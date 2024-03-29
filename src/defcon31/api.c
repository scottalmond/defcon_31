#include "STM8s.h"
#include "api.h"
#include "stm8s_adc1.h"

//1: v1r1 has MAT0 on PD3 and mic on PD4, which precludes audio input (no analog connection) <-- prototype units
//2: v1r2 moved MAT0 to PD4, and audio input to PD3 <-- defcon31 as-built/delivered/production version

//time state
u32 api_counter=0;//increments roughly every millisecond, give-or-take a factor of 2 based on clock divider settings, this is the basis of millis()
#define 	to_HSE	0xB4			// definition of clock blocks (to be copied to SWR)

//application space settings
#define LED_COUNT 43 //10 RGB (3 LEDs each) + 12 white + 1 debug
u8 pwm_brightness_buffer[LED_COUNT];//a swap space for the developer to place the brightness of each LED independent of the pwm volatile display

//LED pwm volatile control state machine
#define PWM_MAX_PERIOD 249 //interrupt counter has max value, so delaying longer requires multiple interrupt triggers
u8 pwm_brightness[LED_COUNT][2][2];//array index, [led index, led pwm], [A vs B side live]
u16 pwm_sleep[2];//[A vs B side live], how many LED LSBs to wait with LEDs OFF before putting LEDs back ON
u8 pwm_led_count[2];//how many LEDs to cycle through
u16 pwm_sleep_remaining=0;
u8 pwm_led_index=0;
u8 pwm_state=0;//LSB (bit 0) is index of pwm_brightness to pull pwm info from.  bit 1 is a flag the application layer raises for the API layer to clear requesting a switch

//buttons
#define BUTTON_COUNT 2
u32 button_start_ms=0;
bool is_right_button_down=0;
bool button_pressed_event[BUTTON_COUNT][2];//event flag registering a button push
#define BUTTON_LONG_PRESS_MS 512 //number of millisconds to consititue a long press rather than a short press
#define BUTTON_MINIMUM_PRESS_MS 50 //minimum time a button needs to be pressed down to be registered as a complete button press

//audio input mic
u8 audio_measurement_count=0;//state machine, triggers re-computation of mean and "standard deviation" every roll over
u8 audio_mean;//the mean computed over the PREVIOUS 256 samples
u8 audio_std;//the "standard deviation" computed during the PREVIOUS 256 samples
u16 audio_running_mean;//the running sum of the mean CURRENTLY being computed
u16 audio_running_std;//the running sum of the std CURRENTLY being computed

//return a pseudo-random number based on the input seed (ex. millis())
//Linear Congruential Generator for pseudo-random numbers
u16 get_random(u16 x)
{
	u16 a=1664525;
	u16 c=1013904223;
	return a * x + c;
}

void setup_serial(bool is_enabled,bool is_fast_baud_rate)
{
	if(is_enabled)
	{
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
		UART1_DeInit();
		UART1_Init(is_fast_baud_rate?57600:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
		//unit can do 1Mbaud, but is not stable with other interrupts present (LED, buttons, audio) also running, causes reading character to be skipped
		UART1_Cmd(ENABLE);
	}else{
		UART1_Cmd(DISABLE);
		UART1_DeInit();
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	}
}

//leave application mode if SWIM pin floats high or sleep mode is activated (long press on left button)
bool is_application_valid()
{ return !is_button_down(2) && !get_button_event(0,1); }

//exit developer mode if SWIM pin floats high
bool is_developer_valid()
{ return is_button_down(2) && !get_button_event(0,1); }

//exit sleep mode if any button is pushed
bool is_sleep_valid()
{ return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1)); }

void setup_main()
{
	u16 iter;
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	CLK->SWCR &= ~CLK_SWCR_SWIF;
	CLK->SWR= to_HSE;
	for(iter=0;iter<0x0491;iter++);//timeout for clock switching
	//now CLK->SWCR & CLK_SWCR_SWIF is FALSE
	CLK->SWCR|= CLK_SWCR_SWEN;
	
	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input used to choose between application and developer modes
		
	//run pwm interrupt at 2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	TIM2->CCR1H=0;//this will always be zero based on application architecutre (analog mic voltage input below quarter of full range)
	TIM2->PSCR= 5;// init divider register 16MHz/2^X
	TIM2->ARRH= 0;// init auto reload register
	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
	
	ADC1_DeInit();
  ADC1_ConversionConfig(ADC1_CONVERSIONMODE_CONTINUOUS, ADC1_CHANNEL_4, ADC1_ALIGN_RIGHT);
  /* Select the prescaler division factor according to ADC1_PrescalerSelection values */
  ADC1_PrescalerConfig(ADC1_PRESSEL_FCPU_D18);
  /*-----------------CR2 configuration --------------------*/
  /* Configure the external trigger state and event respectively
  according to NewState, ADC1_ExtTrigger */
  ADC1_ExternalTriggerConfig(ADC1_EXTTRIG_TIM, DISABLE);
  /* Enable the ADC1 peripheral */
  ADC1->CR1 |= ADC1_CR1_ADON;
	ADC1_Cmd(ENABLE);
	
	enableInterrupts();
}

u32 millis()
{
	return api_counter>>1;
}

void set_millis(u32 new_time)
{
	api_counter=new_time<<1;
}

//log short or long press button events for application layer to use as user input
//PRECON: don't press buttons at the same time (state machine gets confused).  Leveraging just one u32 to store timestamp of button press start to conserve memory
void update_buttons()
{
	u32 elapsed_pressed_ms;
	u8 button_index;
	if(button_start_ms)
	{
		#if HW_REVISION==1
			set_rgb(0,0,255);//v1 development
		#else
			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
		#endif
		if(!is_button_down(is_right_button_down))
		{
			elapsed_pressed_ms=millis()-button_start_ms;
			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
			button_start_ms=0;
		}
	}else{
		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
		{
			if(is_button_down(button_index))
			{
				is_right_button_down=button_index;
				button_start_ms=millis();
			}
		}
	}
}

//returns true if the API has registered the requested type of event
bool get_button_event(u8 button_index,bool is_long)
{ return button_pressed_event[button_index][is_long]; }

//clears the specified type of event from the event queue.  returns if it was triggered before clearing
bool clear_button_event(u8 button_index,bool is_long)
{
	bool out=button_pressed_event[button_index][is_long];
	button_pressed_event[button_index][is_long]=0;
	return out;
}

void clear_button_events()
{
	u8 iter;
	for(iter=0;iter<BUTTON_COUNT;iter++)
	{
		clear_button_event(iter,0);
		clear_button_event(iter,1);
	}
}

//instantaneous check to see if button is pressed (grounded)
bool is_button_down(u8 index)
{
	switch(index)
	{
		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
	}
	return 0;
}

//fetch audio reading and update state machine that computes the "RMS"
void update_audio()
{
	u8 reading,reading_residual;
	reading=ADC1->DRL;//only get 8 least significant bits of the 10 available, assuming reading is not changing fast enough or near enough the 1/4-full-scale point to matter
	ADC1_ClearFlag(ADC1_FLAG_EOC);
	audio_measurement_count++;
	audio_running_mean+=reading;
	reading_residual=reading>audio_mean?reading-audio_mean:audio_mean-reading;
	audio_running_std+=reading_residual;
	if(!audio_measurement_count)//every 256 measurements, average them (/256) and store them
	{
		audio_mean=audio_running_mean>>8;
		audio_running_mean=0;
		audio_std=audio_running_std>>8;
		audio_running_std=0;
	}
	ADC1_StartConversion();
}

u8 get_audio_level()
{ return audio_std; }

//millisecond interrupt
@svlreg @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
	api_counter++;
	//read buttons (if in application mode), update state
	update_buttons();
	//read audio, update state
	update_audio();
}

//LED interrupt
@far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
	
	u8 sleep_amount=(PWM_MAX_PERIOD+1);//max sleep duration before wrap-over occurs
	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
	
	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
	
	if(pwm_sleep_remaining==0)
	{//if sleep time remaining, then keep sleeping
		set_matrix_high_z();
		if(pwm_led_index<pwm_led_count[buffer_index])
		{
			set_led(pwm_brightness[pwm_led_index][0][buffer_index]);//turn on the next LED
			pwm_sleep_remaining=/*0x00FF&*/(pwm_brightness[pwm_led_index][1][buffer_index]+32);//set how long to sleep in this state //+15 works ok here as magic number to correct timing errors from interrupts
			pwm_led_index++;//prepare state machine to go to the next led later
		}else{//sleep pading at the end with all LEDs OFF
			pwm_led_index=0;//reset state machine to 0
			pwm_sleep_remaining=pwm_sleep[buffer_index];
			if(pwm_state&0x02) pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
		}
	}
	sleep_amount=pwm_sleep_remaining<sleep_amount?pwm_sleep_remaining:sleep_amount;
	pwm_sleep_remaining-=sleep_amount;
	
	TIM2->CCR1L = ( (TIM2->CCR1L) + sleep_amount )%(PWM_MAX_PERIOD+1);//set wakeup alarm relative to current time
}

//take the values stored in RAM and start displaying live on the LEDs.  Recommend to set led_count to the number of LEDs being commanded to a non-zero value (to maximize LED brightness by reducing revisit time to each LED), plus one to account for the red status led to acknwoledge buttons puchses, which is set wihtin the API layer and otherwise not accunted for.
void flush_leds(u8 led_count)
{
	u8 led_read_index=0,led_write_index=0;
	u8 buffer_index;//write to the buffer index that is NOT being used/volatile
	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
	//write application layer data (brightness values) into the pwm volatile memory
	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
	{
		if(pwm_brightness_buffer[led_read_index]>7)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
		{//if these is an led with a non-zero brightness to be shown, then add it to the relevant list
			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
			led_write_index++;
			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
		}
		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
	}
	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
	//note: user may ahve requeted more LEDs to be lit then are actually there, so use as-written LED count, led_write_index,
	//rather than user-specified value: led_count
	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
}

//assumes max brightness
void set_hue_max(u8 index,u16 color)
{
	const u8 brightness=255;
	u8 red=0,green=0,blue=0;
	u16 residual_16=color%(0x2AAB);
	u8 residual_8=(residual_16<<8)/0x2AAB;
	switch(color/(0x2AAB))
	{
		case 0:{
			red=brightness;
			green=residual_8;
			blue=0;
			break;
		}case 1:{
			red=brightness-residual_8;
			green=brightness;
			blue=0;
			break;
		}case 2:{
			red=0;
			green=brightness;
			blue=residual_8;
			break;
		}case 3:{
			red=0;
			green=brightness-residual_8;
			blue=brightness;
			break;
		}case 4:{
			red=residual_8;
			green=0;
			blue=brightness;
			break;
		}case 5:{
			red=brightness;
			green=0;
			blue=brightness-residual_8;
			break;
		}default:{}
	}
	set_rgb(index,0,red);
	set_rgb(index,1,green);
	set_rgb(index,2,blue);
}

void set_rgb(u8 index,u8 color,u8 brightness)
{
	pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness;
	//update occurs in order 0-to-29.  update all red first, then all green, then all blue.  this helps to avoid gaps where led is fully off and appears flickering
}

void set_white(u8 index,u8 brightness)
{
	pwm_brightness_buffer[31+index]=brightness;
}

//debug led status
void set_debug(u8 brightness)
{
	pwm_brightness_buffer[30]=brightness;
}

//common method calls
void set_rgb_max(u8 index,u8 color)
{ set_rgb(index,color,255); }
void set_white_max(u8 index)
{ set_white(index,255); }

//used to force all LEDs to float as part of the Charelieplexiing routine
void set_matrix_high_z()
{
	#if HW_REVISION==1
		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
	#else
		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
		GPIO_Init(GPIOD, GPIO_PIN_4 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//swapped analog and MAT_0
		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
	#endif
}

//turn ON the relevant LED
void set_led(u8 led_index)
{
	u8 is_high;
	//0-(10*3-1) is RGB
	//(10*3) is debug
	//(10*3+1) to (10*3+1+12) is white LEDs (if populated)
	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
		{0,1},{1,0},{5,0},{6,0},{6,5},{4,3},{3,4},{0,5},{0,4},{0,3},//reds
		{0,2},{2,0},{5,1},{6,1},{6,4},{5,3},{3,5},{0,6},{1,4},{1,3},//greens
		{1,2},{2,1},{5,2},{6,2},{5,4},{6,3},{3,6},{1,6},{2,4},{2,3},//blues
		{7,7},//debug; GND is tied low, no charlieplexing involved
		{3,0},//LED6
		{3,1},//LED4
		{3,2},//LED5
		{4,0},//LED14
		{1,5},//LED8
		{2,5},//LED9
		{4,1},//LED10
		{4,2},//LED16
		{2,6},//LED17
		{4,6},//LED12
		{4,5},//LED13
		{5,6} //LED11
	};
	for(is_high=0;is_high<2;is_high++)
	{
		GPIO_TypeDef* GPIOx;
		GPIO_Pin_TypeDef PortPin;
		switch(led_lookup[led_index][!is_high])
		{
			case 0:{
				GPIOx=GPIOD;
				#if HW_REVISION==1
					PortPin=GPIO_PIN_3;
				#else
					PortPin=GPIO_PIN_4;
				#endif
			}break;
			case 1:{
				GPIOx=GPIOD;
				PortPin=GPIO_PIN_2;
			}break;
			case 2:{
				GPIOx=GPIOC;
				PortPin=GPIO_PIN_7;
			}break;
			case 3:{
				GPIOx=GPIOC;
				PortPin=GPIO_PIN_6;
			}break;
			case 4:{
				GPIOx=GPIOC;
				PortPin=GPIO_PIN_5;
			}break;
			case 5:{
				GPIOx=GPIOC;
				PortPin=GPIO_PIN_4;
			}break;
			case 6:{
				GPIOx=GPIOC;
				PortPin=GPIO_PIN_3;
			}break;
			case 7:{
				GPIOx=GPIOA;
				PortPin=GPIO_PIN_3;
			}break;
		}
		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
	}
}