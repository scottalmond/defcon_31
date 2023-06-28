/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "STM8s.h"

int iter;

main()
{
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	GPIO_WriteHigh(GPIOD, GPIO_PIN_5);
	while (1)
	{
		GPIO_WriteLow(GPIOD, GPIO_PIN_3);
		GPIO_WriteHigh(GPIOD, GPIO_PIN_2);
		GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
		GPIO_WriteHigh(GPIOD, GPIO_PIN_5);
		for(iter=0;iter<30000;iter++){}
		GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
		GPIO_WriteLow(GPIOD, GPIO_PIN_2);
		GPIO_WriteLow(GPIOA, GPIO_PIN_3);
		GPIO_WriteLow(GPIOD, GPIO_PIN_5);
		for(iter=0;iter<30000;iter++){}
	}
}