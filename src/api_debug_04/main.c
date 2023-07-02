/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8s.h"
#include "stm8s103_ADC.h"

void setMatrixHighZ(void);
void setLED(bool is_rgb,int led_index,int rgb_index);
void setRGB(int led_index,int rgb_index);
void setWhite(int led_index);
void Serial_print_int(int number);
void Serial_newline(void);
void Serial_print_string(char string[]);
//int ADC_Read(ADC_CHANNEL_TypeDef ADC_Channel_Number);


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
	const int test_mode=2;
	uint8_t reading,mean,mean_diff;
	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
	unsigned sound_level=0;
	uint8_t mean_threshold=16;
	unsigned int rms=0;
	const long adc_captures=1<<8;
	unsigned long iter,rep;
	int debug=0;
	unsigned int my_min,my_max;
	for(rep=0;rep<1;rep++)
		for(iter=0;iter<10000;iter++){}
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE); 
	
	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
	UART1_DeInit();
	UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	UART1_Cmd(ENABLE);
	
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
		default:{}
	}
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