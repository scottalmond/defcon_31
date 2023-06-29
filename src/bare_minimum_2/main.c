/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8s.h"

void setMatrixHighZ(void);
void setRGB(int led_index,int rgb_index);

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
	while(1)
	{
		unsigned int iter,led_index,rgb_index;
		for(rgb_index=0;rgb_index<3;rgb_index++)
		{
			for(led_index=0;led_index<10;led_index++)
			{
				setMatrixHighZ();
				setRGB(led_index,rgb_index);
				for(iter=0;iter<30000;iter++){}
			}
		}
	}
}

void setMatrixHighZ()
{
	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
}

void setRGB(int led_index,int rgb_index)
{
const unsigned short matrix_lookup[10][3][2]={
																	  {{0,1},{0,2},{1,2}},//7
																	  {{1,0},{2,0},{2,1}},//3
																	  {{5,0},{5,1},{5,2}},//1
																	  {{6,0},{6,1},{6,2}},//20
																	  {{6,5},{6,4},{5,4}},//22
																	  {{4,3},{5,3},{6,3}},//23
																	  {{3,4},{3,5},{3,6}},//21
																	  {{0,5},{0,6},{1,6}},//19
																	  {{0,4},{1,4},{2,4}},//18
																	  {{0,3},{1,3},{2,3}}//2
																		};
bool is_low=0;
do{
	GPIO_TypeDef* GPIOx;
	GPIO_Pin_TypeDef PortPin;
	switch(matrix_lookup[led_index][rgb_index][is_low])
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

void setWhite(int led_index,bool is_high)
{
	
}