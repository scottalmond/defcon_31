/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8s.h"
#include "stm8s103_ADC.h"

unsigned long tms=0,tms2=0,tms3=0;

void setMatrixHighZ(void);
void setLED(bool is_rgb,int led_index,int rgb_index);
void setRGB(int led_index,int rgb_index);
void setWhite(int led_index);
void Serial_print_int(int number);
void Serial_newline(void);
void Serial_print_string(char string[]);
//int ADC_Read(ADC_CHANNEL_TypeDef ADC_Channel_Number);

//const bool is_rev_1=true;//mat0 placement

int main()
{
	/*
	//GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
	//GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);//MAT0
	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_SLOW);//MAT1
	GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_SLOW);//MAT2
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	GPIO_WriteHigh(GPIOD, GPIO_PIN_5);	
	while (1)
	{
		unsigned int iter;//16 bit signed
		GPIO_WriteLow(GPIOD, GPIO_PIN_2);
		GPIO_WriteHigh(GPIOC, GPIO_PIN_7);
		GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
		GPIO_WriteHigh(GPIOD, GPIO_PIN_5);
		for(iter=0;iter<30000;iter++){}
		GPIO_WriteHigh(GPIOD, GPIO_PIN_2);
		GPIO_WriteLow(GPIOC, GPIO_PIN_7);
		GPIO_WriteLow(GPIOA, GPIO_PIN_3);
		GPIO_WriteLow(GPIOD, GPIO_PIN_5);
		for(iter=0;iter<30000;iter++){}
	}*/
	const int test_mode=9;
	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
	uint8_t reading,mean,mean_diff;
	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
	unsigned sound_level=0;
	uint8_t mean_threshold=16;
	uint8_t mean_threshold_8=1;
	uint16_t mean_threshold_16=0x0100;
	unsigned int rms=0;
	const long adc_captures=1<<8;
	unsigned long iter,rep;
	int debug=0;
	unsigned int my_min,my_max;
	for(rep=0;rep<1;rep++)
		for(iter=0;iter<10000;iter++){}
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE); 
	
	if(test_mode!=4 && test_mode!=5 && test_mode!=9)
	{
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
		UART1_DeInit();
		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
		//UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
		UART1_Cmd(ENABLE);
	}
	
	switch(test_mode)
	{
		case 0:
		{
			//GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_SLOW);//TxD
			while(1)
			{
				unsigned int led_index,rgb_index;
				for(rgb_index=0;rgb_index<3;rgb_index++)
				{
					for(led_index=0;led_index<10;led_index++)
					{
						setMatrixHighZ();
						setRGB(led_index,rgb_index);
						for(iter=0;iter<30000;iter++){}
						debug++;
						/*if(debug%2)
							GPIO_WriteHigh(GPIOD,GPIO_PIN_5);
						else
							GPIO_WriteLow(GPIOD,GPIO_PIN_5);*/
						//if((debug%10)==0)
						//{
							Serial_print_string("counter: ");
							Serial_print_int(debug);
							//UART1_SendData8('0'+((debug/10)%10));
							//UART1_SendData8('\n');
							Serial_newline();
						//}
					}
				}
				for(led_index=0;led_index<12;led_index++)
				{
					setMatrixHighZ();
					setWhite(led_index);
					for(iter=0;iter<30000;iter++){}
				}
			}
		}
		case 1:
		{
		  while(1)
			{
				rep=ADC_Read(AIN4);
				my_min=rep;
				my_max=rep;
				for(iter=0;iter<1000;iter++)
				{
					rep=ADC_Read(AIN4);
					my_min=my_min<rep?my_min:rep;
					my_max=my_max>rep?my_max:rep;
				}
				Serial_print_string("adc: ");
				Serial_print_int(rep);
				Serial_print_string(", ");
				Serial_print_int(my_max-my_min);
				Serial_newline();
				for(iter=0;iter<10000;iter++){}
			}
		}
		case 2:
		{	 
			ADC1_DeInit();
			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
							 AIN4,
							 ADC1_PRESSEL_FCPU_D2,//D18 
							 ADC1_EXTTRIG_TIM, 
							 DISABLE, 
							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
							 ADC1_SCHMITTTRIG_ALL, 
							 DISABLE);
			ADC1_Cmd(ENABLE);
		  while(1)
			{
				/*ADC1_StartConversion();
				while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
				rep = ADC1_GetConversionValue();
				ADC1_ClearFlag(ADC1_FLAG_EOC);
				//rep=ADC_Read(AIN4);
				my_min=rep;
				my_max=rep;*/
				/*if(debug%20==0)
				{
					ADC1_DeInit();
					GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
					ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
									 AIN4,
									 ADC1_PRESSEL_FCPU_D2, 
									 ADC1_EXTTRIG_TIM, 
									 DISABLE, 
									 ADC1_ALIGN_RIGHT, 
									 ADC1_SCHMITTTRIG_ALL, 
									 DISABLE);
					ADC1_Cmd(ENABLE);
				}*/
				rms=0;
				//old_mean=mean;
				mean_sum=0;
				mean_low=mean+mean_threshold;
				mean_high=mean-mean_threshold;
				for(iter=0;iter<adc_captures;iter++)
				{
					//rep=ADC_Read(AIN4);
					ADC1_StartConversion();
					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
					//rep=ADC1_GetConversionValue();
					reading=ADC1->DRL;
					mean_sum += reading;
					rms+=reading>mean_low || reading<mean_high;
					//mean_diff=reading>mean?(reading-mean):(mean-reading);
					//rms+=mean_diff>mean_threshold?1:0;
					//rms+=(reading-mean)*(reading-mean);
					ADC1_ClearFlag(ADC1_FLAG_EOC);
					//my_min=my_min<rep?my_min:rep;
					//my_max=my_max>rep?my_max:rep;
				}
				if(rms>9) mean_threshold++;
				if(rms==0) mean_threshold--;
				mean=(mean_sum)/(adc_captures);
				if(sound_level/32<mean_threshold) sound_level++;
				if(sound_level/32>mean_threshold) sound_level--;
				if(debug%4==0)
				{
					Serial_print_string("adc: ");
					Serial_print_int(mean);
					Serial_print_string(", ");
					if(rms<9) Serial_print_string("0");
					if(rms==0) Serial_print_string("0");
					Serial_print_int(rms);
					Serial_print_string(", ");
					if(mean_threshold<9) Serial_print_string("0");
					Serial_print_int(mean_threshold);
					Serial_print_string(", ");
					if(sound_level/8<9) Serial_print_string("0");
					Serial_print_int(sound_level/8);
					if(debug%10==0) Serial_print_string("*");
					Serial_newline();
				}
				if(mean_threshold>10)
				{//green on led 22 and 23
					//6-4, 5-3
					//
					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
				}else{
					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
				}
			for(iter=0;iter<10;iter++){}
				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
							
				debug++;
				//for(iter=0;iter<10000;iter++){}
			}
		}
		case 3:
		{
			ADC1_DeInit();
			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
							 AIN4,
							 ADC1_PRESSEL_FCPU_D2,//D18 
							 ADC1_EXTTRIG_TIM, 
							 DISABLE, 
							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
							 ADC1_SCHMITTTRIG_ALL, 
							 DISABLE);
			ADC1_Cmd(ENABLE);
			while(1)
			{
				debug++;
				rms=0;//8 bit
				//old_mean=mean;
				mean_sum=0;//16 bit
				//mean_low=mean+mean_threshold;
				//mean_high=mean-mean_threshold;
				iter=0;
				do{
					//rep=ADC_Read(AIN4);
					ADC1_StartConversion();
					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
					//rep=ADC1_GetConversionValue();
					reading=ADC1->DRL;
					mean_sum += reading;
					//rms+=reading>mean_low || reading<mean_high;
					mean_diff=reading>mean?(reading-mean):(mean-reading);
					rms+=mean_diff>mean_threshold_8;
					//rms+=(reading-mean)*(reading-mean);
					ADC1_ClearFlag(ADC1_FLAG_EOC);
					//my_min=my_min<rep?my_min:rep;
					//my_max=my_max>rep?my_max:rep;
					iter++;
					iter%=256;//8 bit unsigned
				}while(iter!=0);//run 255 times
				mean=((uint16_t)mean+mean_sum/256)/2;
				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
				mean_threshold_8=mean_threshold_16/256;
				if(mean_threshold_8==0)
				{//correct unflow; state machine cannot scale 0 properly
					mean_threshold_8=1;
					mean_threshold_16=0x0100;
				}
				if(debug%1==0)
				{
					//Serial_print_string("mean: ");
					if(mean==0) Serial_print_string("0");
					Serial_print_int(mean);
					//Serial_print_string(", rms: ");
					Serial_print_string(" ");
					//if(rms<99) Serial_print_string("0");
					//if(rms<9) Serial_print_string("0");
					if(rms==0) Serial_print_string("0");
					Serial_print_int(rms);
					//Serial_print_string(", threshold: ");
					Serial_print_string(" ");
					if(mean_threshold_8==0) Serial_print_string("0");
					Serial_print_int(mean_threshold_8);
					//if(debug%100==0) Serial_print_string("*");
					Serial_newline();
				}
			}
		}
		case 4:
		{//button test
			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
			while(1)
			{
			  setMatrixHighZ();
				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
				{//green on led 22 and 23
					//6-4, 5-3
					//
					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
				}
			}
		}
		case 5:
		{//interrupts 1 ms counter
			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
			
			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
			UART1_DeInit();
			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			//UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			UART1_Cmd(ENABLE);
			
			Serial_print_string("Mode: ");
			Serial_print_int(test_mode);
			Serial_newline();
			
			
			Serial_print_string("Params v2: ");
			//Mask:
			/*Serial_print_int(CLK_CKDIVR_CPUDIV);//7 0b000_0111
			Serial_print_string(" ");
			Serial_print_int(CLK_CKDIVR_HSIDIV);//24 0b0001_1000
			Serial_print_string(" ");
			Serial_print_int(CLK_CCOR_CCOSEL);//30 0b0001_1110*/
			Serial_print_int(CLK->CKDIVR);//24 0001_1000
			Serial_print_string(" ");
			Serial_print_int(CLK->CCOR);//0
			Serial_newline();
			
			TIM4->PSCR= 7;// init divider register /128	
			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
			TIM4->EGR= TIM4_EGR_UG;// update registers
			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
			enableInterrupts();
			while(1)
			{
				if(tms%1000==0 && mean_sum!=tms/1000)
				{
					Serial_print_string("time: ");
					mean_sum=tms/1000;
					Serial_print_int(tms/1000);
					Serial_newline();
					/*if(tms/1000%2)
					{
						GPIO_Init(GPIOA, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
					}else{
						GPIO_Init(GPIOA, GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_SLOW);
					}*/
				}
				setMatrixHighZ();
				mean_low=tms%20;
				mean_high=(tms/20)%100;
				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
				{
					setRGB(4,1);
				}else{
					//setRGB(5,1);
					setRGB(4,0);
				}
			}
		}
		case 6:
		{//interrupts 1 ms counter
			Serial_print_string("Mode: ");
			Serial_print_int(test_mode);
			Serial_newline();
			
			
			//https://blog.mark-stevens.co.uk/2012/07/configuring-the-stm8s-system-clock-the-way-of-the-register/
			Serial_print_string("Params: ");
			Serial_print_int(CLK->CKDIVR);//
			Serial_print_string(" ");
			Serial_print_int(CLK->CCOR);//
			Serial_newline();
			
			TIM4->PSCR= 7;// init divider register /128	
			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
			TIM4->EGR= TIM4_EGR_UG;// update registers
			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
			enableInterrupts();
			while(1)
			{
				for(iter=0;iter<5000;iter++){}
				Serial_print_string("time: ");
				Serial_print_int(tms>>16);
				Serial_print_string(" ");
				Serial_print_int((uint16_t)tms);
				Serial_newline();
			}
		}
		case 7:
		{//steeple chase pattern, RGB
			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
			
			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
			UART1_DeInit();
			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			//UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			UART1_Cmd(ENABLE);
			
			Serial_print_string("Mode: ");
			Serial_print_int(test_mode);
			Serial_newline();
			
			TIM4->PSCR= 7;// init divider register /128	
			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
			TIM4->EGR= TIM4_EGR_UG;// update registers
			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
			enableInterrupts();
			
			while(1)
			{
				//if(tms%100==0 && mean_sum!=tms/100)
				{
					setMatrixHighZ();
					mean_sum=tms/60;
					mean_low=tms%2;//is high or low charlieplexing
					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
					sound_level=(mean_sum/10)%3;//RGB
					setRGB(mean_high+(mean_low?5:0),sound_level);
				}
			}
		}
		case 8:
		{//RGB curretndraw and voltage test
			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
			
			TIM4->PSCR= 7;// init divider register /128	
			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
			TIM4->EGR= TIM4_EGR_UG;// update registers
			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
			enableInterrupts();
			while(1)
			{
				if(tms%8000==0 && mean_sum!=tms/8000)
				{
				  setMatrixHighZ();
					mean_sum=tms/8000;
					if(mean_sum%4==3)
					{
						setWhite(11);
					}else{
						setRGB(4,mean_sum%4);
					}
				}
			}
		}
		case 9:
		{//dimness test with TIM2
			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
			
			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
			UART1_DeInit();
			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			//UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			UART1_Cmd(ENABLE);
			
			Serial_print_string("Mode: ");
			Serial_print_int(test_mode);
			Serial_newline();
			
			TIM2->PSCR= 6;// init divider register 16MHz/2^X
			TIM2->ARRH= 0;// init auto reload register
			TIM2->ARRL= 250;// init auto reload register
			//TIM2->EGR= TIM2_EGR_UG;// update registers
			TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
			TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
			enableInterrupts();
			while(1)
			{
				Serial_print_string("tms2: ");
				Serial_print_int(tms2/1000);
				Serial_print_string(", tms3: ");
				Serial_print_int(tms3/1000);
				Serial_newline();
				for(iter=0;iter<30000;iter++){}
			}
		}
		default:{}
	}
}

@far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
	TIM4->SR1&=~TIM4_SR1_UIF;
	tms++;
}

@far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
	tms2+=2;
}

@far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
	tms3+=3;
}

//https://circuitdigest.com/microcontroller-projects/adc-on-stm8s-using-c-compiler-reading-multiple-adc-values-and-displaying-on-lcd
/*int ADC_Read(ADC_CHANNEL_TypeDef ADC_Channel_Number)
{
	int result = 0;
	ADC1_DeInit();
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOU+S,
						 ADC_Channel_Number,
						 ADC1_PRESSEL_FCPU_D18,
						 ADC1_EXTTRIG_TIM,
						 DISABLE,
						 ADC1_ALIGN_RIGHT,
						 ADC1_SCHMITTTRIG_ALL,
						 DISABLE);
	ADC1_Cmd(ENABLE);
	ADC1_StartConversion();
	while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
		result = ADC1_GetConversionValue();
		ADC1_ClearFlag(ADC1_FLAG_EOC);
	ADC1_DeInit();
}*/

 void Serial_print_string (char string[])
 {

	 char i=0;

	 while (string[i] != 0x00)
	 {
		UART1_SendData8(string[i]);
		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
		i++;
	}
 }

 void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 {
	 char count = 0;
	 char digit[5] = "";
	 
	 while (number != 0) //split the int to char array 
	 {
		 digit[count] = number%10;
		 count++;
		 number = number/10;
	 }
	 
	 while (count !=0) //print char array in correct direction 
	 {
		UART1_SendData8(digit[count-1] + 0x30);
		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
		count--; 
	 }
 }

 void Serial_newline(void)
 {
	 UART1_SendData8(0x0a);
	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 }

void setMatrixHighZ()
{
	/*GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_SLOW);
	GPIO_Init(GPIOC, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW);*/
	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
}

void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
void setWhite(int led_index){ setLED(0,led_index,0); }

void setLED(bool is_rgb,int led_index,int rgb_index)
{
  const unsigned short rgb_lookup[10][3][2]={
		{{0,1},{0,2},{1,2}},//7
		{{1,0},{2,0},{2,1}},//3
		{{5,0},{5,1},{5,2}},//1
		{{6,0},{6,1},{6,2}},//20
		{{6,5},{6,4},{5,4}},//22
		{{4,3},{5,3},{6,3}},//23
		{{3,4},{3,5},{3,6}},//21
		{{0,5},{0,6},{1,6}},//19
		{{0,4},{1,4},{2,4}},//18
		{{0,3},{1,3},{2,3}} //2
	};
	const unsigned short white_lookup[12][2]={
		{3,0},//6
		{3,1},//4
		{3,2},//5
		{4,0},//14
		{1,5},//8
		{2,5},//9
		{4,1},//10
		{4,2},//16
		{2,6},//17
		{4,6},//12
		{4,5},//13
		{5,6} //11
	};
	bool is_low=0;
	do{
		GPIO_TypeDef* GPIOx;
		GPIO_Pin_TypeDef PortPin;
		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
		{
			case 0:{
				GPIOx=GPIOD;
				PortPin=GPIO_PIN_3;
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
			default:{
				
			}break;
		}
		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
		is_low=!is_low;
	}while(is_low);
}