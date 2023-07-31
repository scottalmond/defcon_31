/* MAIN.C file
 * 
 * 
 */

#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"
#include "sleep.h"
#include "stm8s103_serial.h"

int main()
{
	u32 iter;
	setup_main();
	//setup_serial(1,1);
			/*CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
			
			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
			UART1_DeInit();
			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			//UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
			UART1_Cmd(ENABLE);
			
			Serial_print_string("START\n");
			
			TIM2->CCR1H=0;//this will always be zero based on application architecutre decisions
			TIM2->PSCR= 5;// init divider register 16MHz/2^X
			TIM2->ARRH= 0;// init auto reload register
			TIM2->ARRL= 250;// init auto reload register
			//TIM2->EGR= TIM2_EGR_UG;// update registers
			TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
			TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
			enableInterrupts();*/
			
			//Serial_print_string("HERE 2\n");
			
	/*while(1)
	{
		set_rgb(0,millis()%3,255);
		flush_leds(10);
		//if(iter<millis())
		{
			Serial_print_string("HERE 1\n");
			//iter+=1000;
		}
	}*/
	while(1)
	{
		if(is_application_valid()) run_application();
		if(is_developer_valid()) run_developer();
		if(get_button_event(0,1)) run_sleep();//if long press on left button, enter sleep mode
	}
	return 0;
}
