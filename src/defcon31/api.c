#include "STM8s.h"

u32 api_counter=0;

void serial_setup(bool is_enabled,u32 baud_rate)
{
	if(is_enabled)
	{
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
		UART1_DeInit();
		UART1_Init(baud_rate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
		UART1_Cmd(ENABLE);
	}else{
		UART1_Cmd(DISABLE);
		UART1_DeInit();
		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	}
}

bool is_application_valid()
{
	return 0;
}

void setup()
{
	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
	
	//run pwm interrupt at 2.000 kHz period (to allow for >40 Hz frames with all LEDs ON)
	TIM2->CCR1H=0;//this will always be zero based on application architecutre
	TIM2->PSCR= 5;// init divider register 16MHz/2^X
	TIM2->ARRH= 0;// init auto reload register
	TIM2->ARRL= 250;// init auto reload register
	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
	enableInterrupts();
}

u32 millis()
{
	return api_counter/2;
}

//millisecond interrupt
@far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
	api_counter++;
	//read buttons (if in application mode), update state
	//read audio, update state
}

//LED interrupt
@far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
	//setMatrixHighZ();
	
}

