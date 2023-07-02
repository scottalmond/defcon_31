   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
 111                     ; 23  unsigned int ADC_Read(ADC_CHANNEL_TypeDef ADC_Channel_Number)
 111                     ; 24  {
 113                     	switch	.text
 114  0000               _ADC_Read:
 116  0000 88            	push	a
 117  0001 89            	pushw	x
 118       00000002      OFST:	set	2
 121                     ; 25    unsigned int result = 0;
 123                     ; 27 	 ADC1_DeInit();
 125  0002 cd0000        	call	_ADC1_DeInit
 127                     ; 29 	 ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 127                     ; 30              ADC_Channel_Number,
 127                     ; 31              ADC1_PRESSEL_FCPU_D18, 
 127                     ; 32              ADC1_EXTTRIG_TIM, 
 127                     ; 33              DISABLE, 
 127                     ; 34              ADC1_ALIGN_RIGHT, 
 127                     ; 35              ADC1_SCHMITTTRIG_ALL, 
 127                     ; 36              DISABLE);
 129  0005 4b00          	push	#0
 130  0007 4bff          	push	#255
 131  0009 4b08          	push	#8
 132  000b 4b00          	push	#0
 133  000d 4b00          	push	#0
 134  000f 4b70          	push	#112
 135  0011 7b09          	ld	a,(OFST+7,sp)
 136  0013 ae0100        	ldw	x,#256
 137  0016 97            	ld	xl,a
 138  0017 cd0000        	call	_ADC1_Init
 140  001a 5b06          	addw	sp,#6
 141                     ; 38    ADC1_Cmd(ENABLE);
 143  001c a601          	ld	a,#1
 144  001e cd0000        	call	_ADC1_Cmd
 146                     ; 41 	ADC1_StartConversion();
 148  0021 cd0000        	call	_ADC1_StartConversion
 151  0024               L35:
 152                     ; 42 	while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 154  0024 a680          	ld	a,#128
 155  0026 cd0000        	call	_ADC1_GetFlagStatus
 157  0029 4d            	tnz	a
 158  002a 27f8          	jreq	L35
 159                     ; 44   result = ADC1_GetConversionValue();
 161  002c cd0000        	call	_ADC1_GetConversionValue
 163  002f 1f01          	ldw	(OFST-1,sp),x
 165                     ; 45   ADC1_ClearFlag(ADC1_FLAG_EOC);
 167  0031 a680          	ld	a,#128
 168  0033 cd0000        	call	_ADC1_ClearFlag
 170                     ; 47 	ADC1_DeInit();
 172  0036 cd0000        	call	_ADC1_DeInit
 174                     ; 49 	return result; 
 176  0039 1e01          	ldw	x,(OFST-1,sp)
 179  003b 5b03          	addw	sp,#3
 180  003d 81            	ret
 305                     ; 18 int main()
 305                     ; 19 {
 306                     	switch	.text
 307  003e               _main:
 309  003e 5208          	subw	sp,#8
 310       00000008      OFST:	set	8
 313                     ; 20 	int debug=0;
 315  0040 5f            	clrw	x
 316  0041 1f01          	ldw	(OFST-7,sp),x
 318                     ; 43 	const int test_mode=1;
 320  0043 ae0001        	ldw	x,#1
 321  0046 1f03          	ldw	(OFST-5,sp),x
 323                     ; 46 	for(rep=0;rep<1;rep++)
 325  0048 5f            	clrw	x
 326  0049 1f07          	ldw	(OFST-1,sp),x
 328  004b               L541:
 329                     ; 47 		for(iter=0;iter<10000;iter++){}
 331  004b 5f            	clrw	x
 332  004c 1f05          	ldw	(OFST-3,sp),x
 334  004e               L351:
 337  004e 1e05          	ldw	x,(OFST-3,sp)
 338  0050 1c0001        	addw	x,#1
 339  0053 1f05          	ldw	(OFST-3,sp),x
 343  0055 1e05          	ldw	x,(OFST-3,sp)
 344  0057 a32710        	cpw	x,#10000
 345  005a 25f2          	jrult	L351
 346                     ; 46 	for(rep=0;rep<1;rep++)
 348  005c 1e07          	ldw	x,(OFST-1,sp)
 349  005e 1c0001        	addw	x,#1
 350  0061 1f07          	ldw	(OFST-1,sp),x
 354  0063 1e07          	ldw	x,(OFST-1,sp)
 355  0065 27e4          	jreq	L541
 356                     ; 50 	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 358  0067 4bf0          	push	#240
 359  0069 4b20          	push	#32
 360  006b ae500f        	ldw	x,#20495
 361  006e cd0000        	call	_GPIO_Init
 363  0071 85            	popw	x
 364                     ; 51 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 366  0072 4b40          	push	#64
 367  0074 4b40          	push	#64
 368  0076 ae500f        	ldw	x,#20495
 369  0079 cd0000        	call	_GPIO_Init
 371  007c 85            	popw	x
 372                     ; 52 	UART1_DeInit();
 374  007d cd0000        	call	_UART1_DeInit
 376                     ; 53 	UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 378  0080 4b0c          	push	#12
 379  0082 4b80          	push	#128
 380  0084 4b00          	push	#0
 381  0086 4b00          	push	#0
 382  0088 4b00          	push	#0
 383  008a aec200        	ldw	x,#49664
 384  008d 89            	pushw	x
 385  008e ae0001        	ldw	x,#1
 386  0091 89            	pushw	x
 387  0092 cd0000        	call	_UART1_Init
 389  0095 5b09          	addw	sp,#9
 390                     ; 54 	UART1_Cmd(ENABLE);
 392  0097 a601          	ld	a,#1
 393  0099 cd0000        	call	_UART1_Cmd
 395                     ; 56 	switch(test_mode)
 397  009c 1e03          	ldw	x,(OFST-5,sp)
 399                     ; 112 				for(iter=0;iter<10000;iter++){}
 400  009e 5d            	tnzw	x
 401  009f 2709          	jreq	L561
 402  00a1 5a            	decw	x
 403  00a2 2603cc012a    	jreq	L132
 404  00a7               L02:
 405                     ; 117 }
 408  00a7 5b08          	addw	sp,#8
 409  00a9 81            	ret
 410  00aa               L561:
 411                     ; 64 				for(rgb_index=0;rgb_index<3;rgb_index++)
 413  00aa 5f            	clrw	x
 414  00ab 1f03          	ldw	(OFST-5,sp),x
 416  00ad               L171:
 417                     ; 66 					for(led_index=0;led_index<10;led_index++)
 419  00ad 5f            	clrw	x
 420  00ae 1f07          	ldw	(OFST-1,sp),x
 422  00b0               L771:
 423                     ; 68 						setMatrixHighZ();
 425  00b0 cd0233        	call	_setMatrixHighZ
 427                     ; 69 						setRGB(led_index,rgb_index);
 429  00b3 1e03          	ldw	x,(OFST-5,sp)
 430  00b5 89            	pushw	x
 431  00b6 1e09          	ldw	x,(OFST+1,sp)
 432  00b8 cd024a        	call	_setRGB
 434  00bb 85            	popw	x
 435                     ; 70 						for(iter=0;iter<30000;iter++){}
 437  00bc 5f            	clrw	x
 438  00bd 1f05          	ldw	(OFST-3,sp),x
 440  00bf               L502:
 443  00bf 1e05          	ldw	x,(OFST-3,sp)
 444  00c1 1c0001        	addw	x,#1
 445  00c4 1f05          	ldw	(OFST-3,sp),x
 449  00c6 1e05          	ldw	x,(OFST-3,sp)
 450  00c8 a37530        	cpw	x,#30000
 451  00cb 25f2          	jrult	L502
 452                     ; 71 						debug++;
 454  00cd 1e01          	ldw	x,(OFST-7,sp)
 455  00cf 1c0001        	addw	x,#1
 456  00d2 1f01          	ldw	(OFST-7,sp),x
 458                     ; 78 							Serial_print_string("counter: ");
 460  00d4 ae00b6        	ldw	x,#L312
 461  00d7 cd0198        	call	_Serial_print_string
 463                     ; 79 							Serial_print_int(debug);
 465  00da 1e01          	ldw	x,(OFST-7,sp)
 466  00dc cd01c1        	call	_Serial_print_int
 468                     ; 82 							Serial_newline();
 470  00df cd0224        	call	_Serial_newline
 472                     ; 66 					for(led_index=0;led_index<10;led_index++)
 474  00e2 1e07          	ldw	x,(OFST-1,sp)
 475  00e4 1c0001        	addw	x,#1
 476  00e7 1f07          	ldw	(OFST-1,sp),x
 480  00e9 1e07          	ldw	x,(OFST-1,sp)
 481  00eb a3000a        	cpw	x,#10
 482  00ee 25c0          	jrult	L771
 483                     ; 64 				for(rgb_index=0;rgb_index<3;rgb_index++)
 485  00f0 1e03          	ldw	x,(OFST-5,sp)
 486  00f2 1c0001        	addw	x,#1
 487  00f5 1f03          	ldw	(OFST-5,sp),x
 491  00f7 1e03          	ldw	x,(OFST-5,sp)
 492  00f9 a30003        	cpw	x,#3
 493  00fc 25af          	jrult	L171
 494                     ; 86 				for(led_index=0;led_index<12;led_index++)
 496  00fe 5f            	clrw	x
 497  00ff 1f07          	ldw	(OFST-1,sp),x
 499  0101               L512:
 500                     ; 88 					setMatrixHighZ();
 502  0101 cd0233        	call	_setMatrixHighZ
 504                     ; 89 					setWhite(led_index);
 506  0104 1e07          	ldw	x,(OFST-1,sp)
 507  0106 cd0259        	call	_setWhite
 509                     ; 90 					for(iter=0;iter<30000;iter++){}
 511  0109 5f            	clrw	x
 512  010a 1f05          	ldw	(OFST-3,sp),x
 514  010c               L322:
 517  010c 1e05          	ldw	x,(OFST-3,sp)
 518  010e 1c0001        	addw	x,#1
 519  0111 1f05          	ldw	(OFST-3,sp),x
 523  0113 1e05          	ldw	x,(OFST-3,sp)
 524  0115 a37530        	cpw	x,#30000
 525  0118 25f2          	jrult	L322
 526                     ; 86 				for(led_index=0;led_index<12;led_index++)
 528  011a 1e07          	ldw	x,(OFST-1,sp)
 529  011c 1c0001        	addw	x,#1
 530  011f 1f07          	ldw	(OFST-1,sp),x
 534  0121 1e07          	ldw	x,(OFST-1,sp)
 535  0123 a3000c        	cpw	x,#12
 536  0126 25d9          	jrult	L512
 538  0128 2080          	jra	L561
 539  012a               L132:
 540                     ; 98 				rep=ADC_Read(AIN4);
 542  012a a604          	ld	a,#4
 543  012c cd0000        	call	_ADC_Read
 545  012f 1f07          	ldw	(OFST-1,sp),x
 547                     ; 99 				my_min=rep;
 549  0131 1e07          	ldw	x,(OFST-1,sp)
 550  0133 1f03          	ldw	(OFST-5,sp),x
 552                     ; 100 				my_max=rep;
 554  0135 1e07          	ldw	x,(OFST-1,sp)
 555  0137 1f01          	ldw	(OFST-7,sp),x
 557                     ; 101 				for(iter=0;iter<1000;iter++)
 559  0139 5f            	clrw	x
 560  013a 1f05          	ldw	(OFST-3,sp),x
 562  013c               L532:
 563                     ; 103 					rep=ADC_Read(AIN4);
 565  013c a604          	ld	a,#4
 566  013e cd0000        	call	_ADC_Read
 568  0141 1f07          	ldw	(OFST-1,sp),x
 570                     ; 104 					my_min=my_min<rep?my_min:rep;
 572  0143 1e03          	ldw	x,(OFST-5,sp)
 573  0145 1307          	cpw	x,(OFST-1,sp)
 574  0147 2404          	jruge	L01
 575  0149 1e03          	ldw	x,(OFST-5,sp)
 576  014b 2002          	jra	L21
 577  014d               L01:
 578  014d 1e07          	ldw	x,(OFST-1,sp)
 579  014f               L21:
 580  014f 1f03          	ldw	(OFST-5,sp),x
 582                     ; 105 					my_max=my_max>rep?my_max:rep;
 584  0151 1e01          	ldw	x,(OFST-7,sp)
 585  0153 1307          	cpw	x,(OFST-1,sp)
 586  0155 2304          	jrule	L41
 587  0157 1e01          	ldw	x,(OFST-7,sp)
 588  0159 2002          	jra	L61
 589  015b               L41:
 590  015b 1e07          	ldw	x,(OFST-1,sp)
 591  015d               L61:
 592  015d 1f01          	ldw	(OFST-7,sp),x
 594                     ; 101 				for(iter=0;iter<1000;iter++)
 596  015f 1e05          	ldw	x,(OFST-3,sp)
 597  0161 1c0001        	addw	x,#1
 598  0164 1f05          	ldw	(OFST-3,sp),x
 602  0166 1e05          	ldw	x,(OFST-3,sp)
 603  0168 a303e8        	cpw	x,#1000
 604  016b 25cf          	jrult	L532
 605                     ; 107 				Serial_print_string("adc: ");
 607  016d ae00b0        	ldw	x,#L342
 608  0170 ad26          	call	_Serial_print_string
 610                     ; 108 				Serial_print_int(rep);
 612  0172 1e07          	ldw	x,(OFST-1,sp)
 613  0174 ad4b          	call	_Serial_print_int
 615                     ; 109 				Serial_print_string(", ");
 617  0176 ae00ad        	ldw	x,#L542
 618  0179 ad1d          	call	_Serial_print_string
 620                     ; 110 				Serial_print_int(my_max-my_min);
 622  017b 1e01          	ldw	x,(OFST-7,sp)
 623  017d 72f003        	subw	x,(OFST-5,sp)
 624  0180 ad3f          	call	_Serial_print_int
 626                     ; 111 				Serial_newline();
 628  0182 cd0224        	call	_Serial_newline
 630                     ; 112 				for(iter=0;iter<10000;iter++){}
 632  0185 5f            	clrw	x
 633  0186 1f05          	ldw	(OFST-3,sp),x
 635  0188               L742:
 638  0188 1e05          	ldw	x,(OFST-3,sp)
 639  018a 1c0001        	addw	x,#1
 640  018d 1f05          	ldw	(OFST-3,sp),x
 644  018f 1e05          	ldw	x,(OFST-3,sp)
 645  0191 a32710        	cpw	x,#10000
 646  0194 25f2          	jrult	L742
 648  0196 2092          	jra	L132
 695                     ; 140  void Serial_print_string (char string[])
 695                     ; 141  {
 696                     	switch	.text
 697  0198               _Serial_print_string:
 699  0198 89            	pushw	x
 700  0199 88            	push	a
 701       00000001      OFST:	set	1
 704                     ; 143 	 char i=0;
 706  019a 0f01          	clr	(OFST+0,sp)
 709  019c 2016          	jra	L303
 710  019e               L772:
 711                     ; 147 		UART1_SendData8(string[i]);
 713  019e 7b01          	ld	a,(OFST+0,sp)
 714  01a0 5f            	clrw	x
 715  01a1 97            	ld	xl,a
 716  01a2 72fb02        	addw	x,(OFST+1,sp)
 717  01a5 f6            	ld	a,(x)
 718  01a6 cd0000        	call	_UART1_SendData8
 721  01a9               L113:
 722                     ; 148 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 724  01a9 ae0080        	ldw	x,#128
 725  01ac cd0000        	call	_UART1_GetFlagStatus
 727  01af 4d            	tnz	a
 728  01b0 27f7          	jreq	L113
 729                     ; 149 		i++;
 731  01b2 0c01          	inc	(OFST+0,sp)
 733  01b4               L303:
 734                     ; 145 	 while (string[i] != 0x00)
 736  01b4 7b01          	ld	a,(OFST+0,sp)
 737  01b6 5f            	clrw	x
 738  01b7 97            	ld	xl,a
 739  01b8 72fb02        	addw	x,(OFST+1,sp)
 740  01bb 7d            	tnz	(x)
 741  01bc 26e0          	jrne	L772
 742                     ; 151  }
 745  01be 5b03          	addw	sp,#3
 746  01c0 81            	ret
 749                     .const:	section	.text
 750  0000               L513_digit:
 751  0000 00            	dc.b	0
 752  0001 00000000      	ds.b	4
 805                     ; 153  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 805                     ; 154  {
 806                     	switch	.text
 807  01c1               _Serial_print_int:
 809  01c1 89            	pushw	x
 810  01c2 5208          	subw	sp,#8
 811       00000008      OFST:	set	8
 814                     ; 155 	 char count = 0;
 816  01c4 0f08          	clr	(OFST+0,sp)
 818                     ; 156 	 char digit[5] = "";
 820  01c6 96            	ldw	x,sp
 821  01c7 1c0003        	addw	x,#OFST-5
 822  01ca 90ae0000      	ldw	y,#L513_digit
 823  01ce a605          	ld	a,#5
 824  01d0 cd0000        	call	c_xymov
 827  01d3 2023          	jra	L153
 828  01d5               L543:
 829                     ; 160 		 digit[count] = number%10;
 831  01d5 96            	ldw	x,sp
 832  01d6 1c0003        	addw	x,#OFST-5
 833  01d9 9f            	ld	a,xl
 834  01da 5e            	swapw	x
 835  01db 1b08          	add	a,(OFST+0,sp)
 836  01dd 2401          	jrnc	L62
 837  01df 5c            	incw	x
 838  01e0               L62:
 839  01e0 02            	rlwa	x,a
 840  01e1 1609          	ldw	y,(OFST+1,sp)
 841  01e3 a60a          	ld	a,#10
 842  01e5 cd0000        	call	c_smody
 844  01e8 9001          	rrwa	y,a
 845  01ea f7            	ld	(x),a
 846  01eb 9002          	rlwa	y,a
 847                     ; 161 		 count++;
 849  01ed 0c08          	inc	(OFST+0,sp)
 851                     ; 162 		 number = number/10;
 853  01ef 1e09          	ldw	x,(OFST+1,sp)
 854  01f1 a60a          	ld	a,#10
 855  01f3 cd0000        	call	c_sdivx
 857  01f6 1f09          	ldw	(OFST+1,sp),x
 858  01f8               L153:
 859                     ; 158 	 while (number != 0) //split the int to char array 
 861  01f8 1e09          	ldw	x,(OFST+1,sp)
 862  01fa 26d9          	jrne	L543
 864  01fc 201f          	jra	L753
 865  01fe               L553:
 866                     ; 167 		UART1_SendData8(digit[count-1] + 0x30);
 868  01fe 96            	ldw	x,sp
 869  01ff 1c0003        	addw	x,#OFST-5
 870  0202 1f01          	ldw	(OFST-7,sp),x
 872  0204 7b08          	ld	a,(OFST+0,sp)
 873  0206 5f            	clrw	x
 874  0207 97            	ld	xl,a
 875  0208 5a            	decw	x
 876  0209 72fb01        	addw	x,(OFST-7,sp)
 877  020c f6            	ld	a,(x)
 878  020d ab30          	add	a,#48
 879  020f cd0000        	call	_UART1_SendData8
 882  0212               L563:
 883                     ; 168 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 885  0212 ae0080        	ldw	x,#128
 886  0215 cd0000        	call	_UART1_GetFlagStatus
 888  0218 4d            	tnz	a
 889  0219 27f7          	jreq	L563
 890                     ; 169 		count--; 
 892  021b 0a08          	dec	(OFST+0,sp)
 894  021d               L753:
 895                     ; 165 	 while (count !=0) //print char array in correct direction 
 897  021d 0d08          	tnz	(OFST+0,sp)
 898  021f 26dd          	jrne	L553
 899                     ; 171  }
 902  0221 5b0a          	addw	sp,#10
 903  0223 81            	ret
 928                     ; 173  void Serial_newline(void)
 928                     ; 174  {
 929                     	switch	.text
 930  0224               _Serial_newline:
 934                     ; 175 	 UART1_SendData8(0x0a);
 936  0224 a60a          	ld	a,#10
 937  0226 cd0000        	call	_UART1_SendData8
 940  0229               L304:
 941                     ; 176 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 943  0229 ae0080        	ldw	x,#128
 944  022c cd0000        	call	_UART1_GetFlagStatus
 946  022f 4d            	tnz	a
 947  0230 27f7          	jreq	L304
 948                     ; 177  }
 951  0232 81            	ret
 975                     ; 179 void setMatrixHighZ()
 975                     ; 180 {
 976                     	switch	.text
 977  0233               _setMatrixHighZ:
 981                     ; 185 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
 983  0233 4b00          	push	#0
 984  0235 4bf8          	push	#248
 985  0237 ae500a        	ldw	x,#20490
 986  023a cd0000        	call	_GPIO_Init
 988  023d 85            	popw	x
 989                     ; 186 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
 991  023e 4b00          	push	#0
 992  0240 4b0c          	push	#12
 993  0242 ae500f        	ldw	x,#20495
 994  0245 cd0000        	call	_GPIO_Init
 996  0248 85            	popw	x
 997                     ; 187 }
1000  0249 81            	ret
1044                     ; 189 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
1045                     	switch	.text
1046  024a               _setRGB:
1048  024a 89            	pushw	x
1049       00000000      OFST:	set	0
1054  024b 1e05          	ldw	x,(OFST+5,sp)
1055  024d 89            	pushw	x
1056  024e 1e03          	ldw	x,(OFST+3,sp)
1057  0250 89            	pushw	x
1058  0251 a601          	ld	a,#1
1059  0253 ad11          	call	_setLED
1061  0255 5b04          	addw	sp,#4
1065  0257 85            	popw	x
1066  0258 81            	ret
1101                     ; 190 void setWhite(int led_index){ setLED(0,led_index,0); }
1102                     	switch	.text
1103  0259               _setWhite:
1105  0259 89            	pushw	x
1106       00000000      OFST:	set	0
1111  025a 5f            	clrw	x
1112  025b 89            	pushw	x
1113  025c 1e03          	ldw	x,(OFST+3,sp)
1114  025e 89            	pushw	x
1115  025f 4f            	clr	a
1116  0260 ad04          	call	_setLED
1118  0262 5b04          	addw	sp,#4
1122  0264 85            	popw	x
1123  0265 81            	ret
1126                     	switch	.const
1127  0005               L754_rgb_lookup:
1128  0005 0000          	dc.w	0
1129  0007 0001          	dc.w	1
1130  0009 0000          	dc.w	0
1131  000b 0002          	dc.w	2
1132  000d 0001          	dc.w	1
1133  000f 0002          	dc.w	2
1134  0011 0001          	dc.w	1
1135  0013 0000          	dc.w	0
1136  0015 0002          	dc.w	2
1137  0017 0000          	dc.w	0
1138  0019 0002          	dc.w	2
1139  001b 0001          	dc.w	1
1140  001d 0005          	dc.w	5
1141  001f 0000          	dc.w	0
1142  0021 0005          	dc.w	5
1143  0023 0001          	dc.w	1
1144  0025 0005          	dc.w	5
1145  0027 0002          	dc.w	2
1146  0029 0006          	dc.w	6
1147  002b 0000          	dc.w	0
1148  002d 0006          	dc.w	6
1149  002f 0001          	dc.w	1
1150  0031 0006          	dc.w	6
1151  0033 0002          	dc.w	2
1152  0035 0006          	dc.w	6
1153  0037 0005          	dc.w	5
1154  0039 0006          	dc.w	6
1155  003b 0004          	dc.w	4
1156  003d 0005          	dc.w	5
1157  003f 0004          	dc.w	4
1158  0041 0004          	dc.w	4
1159  0043 0003          	dc.w	3
1160  0045 0005          	dc.w	5
1161  0047 0003          	dc.w	3
1162  0049 0006          	dc.w	6
1163  004b 0003          	dc.w	3
1164  004d 0003          	dc.w	3
1165  004f 0004          	dc.w	4
1166  0051 0003          	dc.w	3
1167  0053 0005          	dc.w	5
1168  0055 0003          	dc.w	3
1169  0057 0006          	dc.w	6
1170  0059 0000          	dc.w	0
1171  005b 0005          	dc.w	5
1172  005d 0000          	dc.w	0
1173  005f 0006          	dc.w	6
1174  0061 0001          	dc.w	1
1175  0063 0006          	dc.w	6
1176  0065 0000          	dc.w	0
1177  0067 0004          	dc.w	4
1178  0069 0001          	dc.w	1
1179  006b 0004          	dc.w	4
1180  006d 0002          	dc.w	2
1181  006f 0004          	dc.w	4
1182  0071 0000          	dc.w	0
1183  0073 0003          	dc.w	3
1184  0075 0001          	dc.w	1
1185  0077 0003          	dc.w	3
1186  0079 0002          	dc.w	2
1187  007b 0003          	dc.w	3
1188  007d               L164_white_lookup:
1189  007d 0003          	dc.w	3
1190  007f 0000          	dc.w	0
1191  0081 0003          	dc.w	3
1192  0083 0001          	dc.w	1
1193  0085 0003          	dc.w	3
1194  0087 0002          	dc.w	2
1195  0089 0004          	dc.w	4
1196  008b 0000          	dc.w	0
1197  008d 0001          	dc.w	1
1198  008f 0005          	dc.w	5
1199  0091 0002          	dc.w	2
1200  0093 0005          	dc.w	5
1201  0095 0004          	dc.w	4
1202  0097 0001          	dc.w	1
1203  0099 0004          	dc.w	4
1204  009b 0002          	dc.w	2
1205  009d 0002          	dc.w	2
1206  009f 0006          	dc.w	6
1207  00a1 0004          	dc.w	4
1208  00a3 0006          	dc.w	6
1209  00a5 0004          	dc.w	4
1210  00a7 0005          	dc.w	5
1211  00a9 0005          	dc.w	5
1212  00ab 0006          	dc.w	6
1474                     ; 192 void setLED(bool is_rgb,int led_index,int rgb_index)
1474                     ; 193 {
1475                     	switch	.text
1476  0266               _setLED:
1478  0266 88            	push	a
1479  0267 52b6          	subw	sp,#182
1480       000000b6      OFST:	set	182
1483                     ; 194   const unsigned short rgb_lookup[10][3][2]={
1483                     ; 195 		{{0,1},{0,2},{1,2}},//7
1483                     ; 196 		{{1,0},{2,0},{2,1}},//3
1483                     ; 197 		{{5,0},{5,1},{5,2}},//1
1483                     ; 198 		{{6,0},{6,1},{6,2}},//20
1483                     ; 199 		{{6,5},{6,4},{5,4}},//22
1483                     ; 200 		{{4,3},{5,3},{6,3}},//23
1483                     ; 201 		{{3,4},{3,5},{3,6}},//21
1483                     ; 202 		{{0,5},{0,6},{1,6}},//19
1483                     ; 203 		{{0,4},{1,4},{2,4}},//18
1483                     ; 204 		{{0,3},{1,3},{2,3}} //2
1483                     ; 205 	};
1485  0269 96            	ldw	x,sp
1486  026a 1c000e        	addw	x,#OFST-168
1487  026d 90ae0005      	ldw	y,#L754_rgb_lookup
1488  0271 a678          	ld	a,#120
1489  0273 cd0000        	call	c_xymov
1491                     ; 206 	const unsigned short white_lookup[12][2]={
1491                     ; 207 		{3,0},//6
1491                     ; 208 		{3,1},//4
1491                     ; 209 		{3,2},//5
1491                     ; 210 		{4,0},//14
1491                     ; 211 		{1,5},//8
1491                     ; 212 		{2,5},//9
1491                     ; 213 		{4,1},//10
1491                     ; 214 		{4,2},//16
1491                     ; 215 		{2,6},//17
1491                     ; 216 		{4,6},//12
1491                     ; 217 		{4,5},//13
1491                     ; 218 		{5,6} //11
1491                     ; 219 	};
1493  0276 96            	ldw	x,sp
1494  0277 1c0086        	addw	x,#OFST-48
1495  027a 90ae007d      	ldw	y,#L164_white_lookup
1496  027e a630          	ld	a,#48
1497  0280 cd0000        	call	c_xymov
1499                     ; 220 	bool is_low=0;
1501  0283 0fb6          	clr	(OFST+0,sp)
1503  0285               L156:
1504                     ; 224 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
1506  0285 0db7          	tnz	(OFST+1,sp)
1507  0287 2726          	jreq	L24
1508  0289 7bb6          	ld	a,(OFST+0,sp)
1509  028b 5f            	clrw	x
1510  028c 97            	ld	xl,a
1511  028d 58            	sllw	x
1512  028e 1f09          	ldw	(OFST-173,sp),x
1514  0290 1ebc          	ldw	x,(OFST+6,sp)
1515  0292 58            	sllw	x
1516  0293 58            	sllw	x
1517  0294 1f07          	ldw	(OFST-175,sp),x
1519  0296 96            	ldw	x,sp
1520  0297 1c000e        	addw	x,#OFST-168
1521  029a 1f05          	ldw	(OFST-177,sp),x
1523  029c 1eba          	ldw	x,(OFST+4,sp)
1524  029e a60c          	ld	a,#12
1525  02a0 cd0000        	call	c_bmulx
1527  02a3 72fb05        	addw	x,(OFST-177,sp)
1528  02a6 72fb07        	addw	x,(OFST-175,sp)
1529  02a9 72fb09        	addw	x,(OFST-173,sp)
1530  02ac fe            	ldw	x,(x)
1531  02ad 2018          	jra	L44
1532  02af               L24:
1533  02af 7bb6          	ld	a,(OFST+0,sp)
1534  02b1 5f            	clrw	x
1535  02b2 97            	ld	xl,a
1536  02b3 58            	sllw	x
1537  02b4 1f03          	ldw	(OFST-179,sp),x
1539  02b6 96            	ldw	x,sp
1540  02b7 1c0086        	addw	x,#OFST-48
1541  02ba 1f01          	ldw	(OFST-181,sp),x
1543  02bc 1eba          	ldw	x,(OFST+4,sp)
1544  02be 58            	sllw	x
1545  02bf 58            	sllw	x
1546  02c0 72fb01        	addw	x,(OFST-181,sp)
1547  02c3 72fb03        	addw	x,(OFST-179,sp)
1548  02c6 fe            	ldw	x,(x)
1549  02c7               L44:
1551                     ; 256 			}break;
1552  02c7 5d            	tnzw	x
1553  02c8 2714          	jreq	L364
1554  02ca 5a            	decw	x
1555  02cb 271c          	jreq	L564
1556  02cd 5a            	decw	x
1557  02ce 2724          	jreq	L764
1558  02d0 5a            	decw	x
1559  02d1 272c          	jreq	L174
1560  02d3 5a            	decw	x
1561  02d4 2734          	jreq	L374
1562  02d6 5a            	decw	x
1563  02d7 273c          	jreq	L574
1564  02d9 5a            	decw	x
1565  02da 2744          	jreq	L774
1566  02dc 204b          	jra	L166
1567  02de               L364:
1568                     ; 227 				GPIOx=GPIOD;
1570  02de ae500f        	ldw	x,#20495
1571  02e1 1f0b          	ldw	(OFST-171,sp),x
1573                     ; 228 				PortPin=GPIO_PIN_3;
1575  02e3 a608          	ld	a,#8
1576  02e5 6b0d          	ld	(OFST-169,sp),a
1578                     ; 229 			}break;
1580  02e7 2040          	jra	L166
1581  02e9               L564:
1582                     ; 231 				GPIOx=GPIOD;
1584  02e9 ae500f        	ldw	x,#20495
1585  02ec 1f0b          	ldw	(OFST-171,sp),x
1587                     ; 232 				PortPin=GPIO_PIN_2;
1589  02ee a604          	ld	a,#4
1590  02f0 6b0d          	ld	(OFST-169,sp),a
1592                     ; 233 			}break;
1594  02f2 2035          	jra	L166
1595  02f4               L764:
1596                     ; 235 				GPIOx=GPIOC;
1598  02f4 ae500a        	ldw	x,#20490
1599  02f7 1f0b          	ldw	(OFST-171,sp),x
1601                     ; 236 				PortPin=GPIO_PIN_7;
1603  02f9 a680          	ld	a,#128
1604  02fb 6b0d          	ld	(OFST-169,sp),a
1606                     ; 237 			}break;
1608  02fd 202a          	jra	L166
1609  02ff               L174:
1610                     ; 239 				GPIOx=GPIOC;
1612  02ff ae500a        	ldw	x,#20490
1613  0302 1f0b          	ldw	(OFST-171,sp),x
1615                     ; 240 				PortPin=GPIO_PIN_6;
1617  0304 a640          	ld	a,#64
1618  0306 6b0d          	ld	(OFST-169,sp),a
1620                     ; 241 			}break;
1622  0308 201f          	jra	L166
1623  030a               L374:
1624                     ; 243 				GPIOx=GPIOC;
1626  030a ae500a        	ldw	x,#20490
1627  030d 1f0b          	ldw	(OFST-171,sp),x
1629                     ; 244 				PortPin=GPIO_PIN_5;
1631  030f a620          	ld	a,#32
1632  0311 6b0d          	ld	(OFST-169,sp),a
1634                     ; 245 			}break;
1636  0313 2014          	jra	L166
1637  0315               L574:
1638                     ; 247 				GPIOx=GPIOC;
1640  0315 ae500a        	ldw	x,#20490
1641  0318 1f0b          	ldw	(OFST-171,sp),x
1643                     ; 248 				PortPin=GPIO_PIN_4;
1645  031a a610          	ld	a,#16
1646  031c 6b0d          	ld	(OFST-169,sp),a
1648                     ; 249 			}break;
1650  031e 2009          	jra	L166
1651  0320               L774:
1652                     ; 251 				GPIOx=GPIOC;
1654  0320 ae500a        	ldw	x,#20490
1655  0323 1f0b          	ldw	(OFST-171,sp),x
1657                     ; 252 				PortPin=GPIO_PIN_3;
1659  0325 a608          	ld	a,#8
1660  0327 6b0d          	ld	(OFST-169,sp),a
1662                     ; 253 			}break;
1664  0329               L166:
1665                     ; 258 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
1667  0329 0db6          	tnz	(OFST+0,sp)
1668  032b 2704          	jreq	L64
1669  032d a6c0          	ld	a,#192
1670  032f 2002          	jra	L05
1671  0331               L64:
1672  0331 a6d0          	ld	a,#208
1673  0333               L05:
1674  0333 88            	push	a
1675  0334 7b0e          	ld	a,(OFST-168,sp)
1676  0336 88            	push	a
1677  0337 1e0d          	ldw	x,(OFST-169,sp)
1678  0339 cd0000        	call	_GPIO_Init
1680  033c 85            	popw	x
1681                     ; 259 		is_low=!is_low;
1683  033d 0db6          	tnz	(OFST+0,sp)
1684  033f 2604          	jrne	L25
1685  0341 a601          	ld	a,#1
1686  0343 2001          	jra	L45
1687  0345               L25:
1688  0345 4f            	clr	a
1689  0346               L45:
1690  0346 6bb6          	ld	(OFST+0,sp),a
1692                     ; 260 	}while(is_low);
1694  0348 0db6          	tnz	(OFST+0,sp)
1695  034a 2703          	jreq	L65
1696  034c cc0285        	jp	L156
1697  034f               L65:
1698                     ; 261 }
1701  034f 5bb7          	addw	sp,#183
1702  0351 81            	ret
1715                     	xdef	_main
1716                     	xdef	_Serial_print_string
1717                     	xdef	_Serial_newline
1718                     	xdef	_Serial_print_int
1719                     	xdef	_setWhite
1720                     	xdef	_setRGB
1721                     	xdef	_setLED
1722                     	xdef	_setMatrixHighZ
1723                     	xdef	_ADC_Read
1724                     	xref	_UART1_GetFlagStatus
1725                     	xref	_UART1_SendData8
1726                     	xref	_UART1_Cmd
1727                     	xref	_UART1_Init
1728                     	xref	_UART1_DeInit
1729                     	xref	_GPIO_Init
1730                     	xref	_ADC1_ClearFlag
1731                     	xref	_ADC1_GetFlagStatus
1732                     	xref	_ADC1_GetConversionValue
1733                     	xref	_ADC1_StartConversion
1734                     	xref	_ADC1_Cmd
1735                     	xref	_ADC1_Init
1736                     	xref	_ADC1_DeInit
1737                     	switch	.const
1738  00ad               L542:
1739  00ad 2c2000        	dc.b	", ",0
1740  00b0               L342:
1741  00b0 6164633a2000  	dc.b	"adc: ",0
1742  00b6               L312:
1743  00b6 636f756e7465  	dc.b	"counter: ",0
1744                     	xref.b	c_x
1745                     	xref.b	c_y
1765                     	xref	c_bmulx
1766                     	xref	c_sdivx
1767                     	xref	c_smody
1768                     	xref	c_smodx
1769                     	xref	c_xymov
1770                     	end
