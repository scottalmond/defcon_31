 #include "stm8s.h"
 //#include "stdio.h"
 #include "stm8s103_Serial.h"
#include "stm8s_uart1.h"
#include "stm8s_gpio.h"

 char Serial_read_char(void)
 {
	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
	 UART1_ClearFlag(UART1_FLAG_RXNE);
	 return (UART1_ReceiveData8());
 }

 void Serial_print_char (char value)
 {
	 UART1_SendData8(value);
	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
 }
 
  void Serial_begin(uint32_t baud_rate)
 {
	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	 
	 UART1_DeInit(); //Deinitialize UART peripherals 
			
                
		UART1_Init(baud_rate, 
                UART1_WORDLENGTH_8D, 
                UART1_STOPBITS_1, 
                UART1_PARITY_NO, 
                UART1_SYNCMODE_CLOCK_DISABLE, 
                UART1_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
                
		UART1_Cmd(ENABLE);
 }
 
 void Serial_print_u32(u32 number)
 {
	 u8 iter;
	 u8 digit;
	 Serial_print_string("0x");
	 for(iter=28;iter<32;iter-=4)
	 {
		 digit=number>>iter;
		 if(digit>9) Serial_print_char('A'+(digit-10));
		 else Serial_print_char('0'+digit);
		 if(iter==16) Serial_print_char('_');
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
 
 bool Serial_available()
 {
	 if(UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
	 return TRUE;
	 else
	 return FALSE;
 }
 
 
 