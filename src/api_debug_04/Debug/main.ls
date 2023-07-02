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
 401                     .const:	section	.text
 402  0000               L01:
 403  0000 00002710      	dc.l	10000
 404  0004               L21:
 405  0004 00007530      	dc.l	30000
 406  0008               L42:
 407  0008 000003e8      	dc.l	1000
 408  000c               L04:
 409  000c 0000000a      	dc.l	10
 410                     ; 18 int main()
 410                     ; 19 {
 411                     	switch	.text
 412  003e               _main:
 414  003e 5220          	subw	sp,#32
 415       00000020      OFST:	set	32
 418                     ; 42 	const int test_mode=2;
 420  0040 ae0002        	ldw	x,#2
 421  0043 1f1b          	ldw	(OFST-5,sp),x
 423                     ; 44 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 431                     ; 45 	unsigned sound_level=0;
 433  0045 5f            	clrw	x
 434  0046 1f13          	ldw	(OFST-13,sp),x
 436                     ; 46 	uint8_t mean_threshold=16;
 438  0048 a610          	ld	a,#16
 439  004a 6b11          	ld	(OFST-15,sp),a
 441                     ; 47 	unsigned int rms=0;
 443                     ; 48 	const long adc_captures=1<<8;
 445  004c ae0100        	ldw	x,#256
 446  004f 1f0f          	ldw	(OFST-17,sp),x
 447  0051 ae0000        	ldw	x,#0
 448  0054 1f0d          	ldw	(OFST-19,sp),x
 450                     ; 50 	int debug=0;
 452  0056 5f            	clrw	x
 453  0057 1f15          	ldw	(OFST-11,sp),x
 455                     ; 52 	for(rep=0;rep<1;rep++)
 457  0059 ae0000        	ldw	x,#0
 458  005c 1f19          	ldw	(OFST-7,sp),x
 459  005e ae0000        	ldw	x,#0
 460  0061 1f17          	ldw	(OFST-9,sp),x
 462  0063               L712:
 463                     ; 53 		for(iter=0;iter<10000;iter++){}
 465  0063 ae0000        	ldw	x,#0
 466  0066 1f1f          	ldw	(OFST-1,sp),x
 467  0068 ae0000        	ldw	x,#0
 468  006b 1f1d          	ldw	(OFST-3,sp),x
 470  006d               L522:
 473  006d 96            	ldw	x,sp
 474  006e 1c001d        	addw	x,#OFST-3
 475  0071 a601          	ld	a,#1
 476  0073 cd0000        	call	c_lgadc
 481  0076 96            	ldw	x,sp
 482  0077 1c001d        	addw	x,#OFST-3
 483  007a cd0000        	call	c_ltor
 485  007d ae0000        	ldw	x,#L01
 486  0080 cd0000        	call	c_lcmp
 488  0083 25e8          	jrult	L522
 489                     ; 52 	for(rep=0;rep<1;rep++)
 491  0085 96            	ldw	x,sp
 492  0086 1c0017        	addw	x,#OFST-9
 493  0089 a601          	ld	a,#1
 494  008b cd0000        	call	c_lgadc
 499  008e 96            	ldw	x,sp
 500  008f 1c0017        	addw	x,#OFST-9
 501  0092 cd0000        	call	c_lzmp
 503  0095 27cc          	jreq	L712
 504                     ; 56 	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 506  0097 4bf0          	push	#240
 507  0099 4b20          	push	#32
 508  009b ae500f        	ldw	x,#20495
 509  009e cd0000        	call	_GPIO_Init
 511  00a1 85            	popw	x
 512                     ; 57 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 514  00a2 4b40          	push	#64
 515  00a4 4b40          	push	#64
 516  00a6 ae500f        	ldw	x,#20495
 517  00a9 cd0000        	call	_GPIO_Init
 519  00ac 85            	popw	x
 520                     ; 58 	UART1_DeInit();
 522  00ad cd0000        	call	_UART1_DeInit
 524                     ; 59 	UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 526  00b0 4b0c          	push	#12
 527  00b2 4b80          	push	#128
 528  00b4 4b00          	push	#0
 529  00b6 4b00          	push	#0
 530  00b8 4b00          	push	#0
 531  00ba aec200        	ldw	x,#49664
 532  00bd 89            	pushw	x
 533  00be ae0001        	ldw	x,#1
 534  00c1 89            	pushw	x
 535  00c2 cd0000        	call	_UART1_Init
 537  00c5 5b09          	addw	sp,#9
 538                     ; 60 	UART1_Cmd(ENABLE);
 540  00c7 a601          	ld	a,#1
 541  00c9 cd0000        	call	_UART1_Cmd
 543                     ; 62 	switch(test_mode)
 545  00cc 1e1b          	ldw	x,(OFST-5,sp)
 547                     ; 213 				debug++;
 548  00ce 5d            	tnzw	x
 549  00cf 270f          	jreq	L732
 550  00d1 5a            	decw	x
 551  00d2 2603          	jrne	L44
 552  00d4 cc0184        	jp	L303
 553  00d7               L44:
 554  00d7 5a            	decw	x
 555  00d8 2603          	jrne	L64
 556  00da cc023a        	jp	L36
 557  00dd               L64:
 558  00dd               L24:
 559                     ; 219 }
 562  00dd 5b20          	addw	sp,#32
 563  00df 81            	ret
 564  00e0               L732:
 565                     ; 70 				for(rgb_index=0;rgb_index<3;rgb_index++)
 567  00e0 5f            	clrw	x
 568  00e1 1f13          	ldw	(OFST-13,sp),x
 570  00e3               L342:
 571                     ; 72 					for(led_index=0;led_index<10;led_index++)
 573  00e3 5f            	clrw	x
 574  00e4 1f1b          	ldw	(OFST-5,sp),x
 576  00e6               L152:
 577                     ; 74 						setMatrixHighZ();
 579  00e6 cd04ea        	call	_setMatrixHighZ
 581                     ; 75 						setRGB(led_index,rgb_index);
 583  00e9 1e13          	ldw	x,(OFST-13,sp)
 584  00eb 89            	pushw	x
 585  00ec 1e1d          	ldw	x,(OFST-3,sp)
 586  00ee cd0501        	call	_setRGB
 588  00f1 85            	popw	x
 589                     ; 76 						for(iter=0;iter<30000;iter++){}
 591  00f2 ae0000        	ldw	x,#0
 592  00f5 1f1f          	ldw	(OFST-1,sp),x
 593  00f7 ae0000        	ldw	x,#0
 594  00fa 1f1d          	ldw	(OFST-3,sp),x
 596  00fc               L752:
 599  00fc 96            	ldw	x,sp
 600  00fd 1c001d        	addw	x,#OFST-3
 601  0100 a601          	ld	a,#1
 602  0102 cd0000        	call	c_lgadc
 607  0105 96            	ldw	x,sp
 608  0106 1c001d        	addw	x,#OFST-3
 609  0109 cd0000        	call	c_ltor
 611  010c ae0004        	ldw	x,#L21
 612  010f cd0000        	call	c_lcmp
 614  0112 25e8          	jrult	L752
 615                     ; 77 						debug++;
 617  0114 1e15          	ldw	x,(OFST-11,sp)
 618  0116 1c0001        	addw	x,#1
 619  0119 1f15          	ldw	(OFST-11,sp),x
 621                     ; 84 							Serial_print_string("counter: ");
 623  011b ae00ca        	ldw	x,#L562
 624  011e cd044f        	call	_Serial_print_string
 626                     ; 85 							Serial_print_int(debug);
 628  0121 1e15          	ldw	x,(OFST-11,sp)
 629  0123 cd0478        	call	_Serial_print_int
 631                     ; 88 							Serial_newline();
 633  0126 cd04db        	call	_Serial_newline
 635                     ; 72 					for(led_index=0;led_index<10;led_index++)
 637  0129 1e1b          	ldw	x,(OFST-5,sp)
 638  012b 1c0001        	addw	x,#1
 639  012e 1f1b          	ldw	(OFST-5,sp),x
 643  0130 1e1b          	ldw	x,(OFST-5,sp)
 644  0132 a3000a        	cpw	x,#10
 645  0135 25af          	jrult	L152
 646                     ; 70 				for(rgb_index=0;rgb_index<3;rgb_index++)
 648  0137 1e13          	ldw	x,(OFST-13,sp)
 649  0139 1c0001        	addw	x,#1
 650  013c 1f13          	ldw	(OFST-13,sp),x
 654  013e 1e13          	ldw	x,(OFST-13,sp)
 655  0140 a30003        	cpw	x,#3
 656  0143 259e          	jrult	L342
 657                     ; 92 				for(led_index=0;led_index<12;led_index++)
 659  0145 5f            	clrw	x
 660  0146 1f1b          	ldw	(OFST-5,sp),x
 662  0148               L762:
 663                     ; 94 					setMatrixHighZ();
 665  0148 cd04ea        	call	_setMatrixHighZ
 667                     ; 95 					setWhite(led_index);
 669  014b 1e1b          	ldw	x,(OFST-5,sp)
 670  014d cd0510        	call	_setWhite
 672                     ; 96 					for(iter=0;iter<30000;iter++){}
 674  0150 ae0000        	ldw	x,#0
 675  0153 1f1f          	ldw	(OFST-1,sp),x
 676  0155 ae0000        	ldw	x,#0
 677  0158 1f1d          	ldw	(OFST-3,sp),x
 679  015a               L572:
 682  015a 96            	ldw	x,sp
 683  015b 1c001d        	addw	x,#OFST-3
 684  015e a601          	ld	a,#1
 685  0160 cd0000        	call	c_lgadc
 690  0163 96            	ldw	x,sp
 691  0164 1c001d        	addw	x,#OFST-3
 692  0167 cd0000        	call	c_ltor
 694  016a ae0004        	ldw	x,#L21
 695  016d cd0000        	call	c_lcmp
 697  0170 25e8          	jrult	L572
 698                     ; 92 				for(led_index=0;led_index<12;led_index++)
 700  0172 1e1b          	ldw	x,(OFST-5,sp)
 701  0174 1c0001        	addw	x,#1
 702  0177 1f1b          	ldw	(OFST-5,sp),x
 706  0179 1e1b          	ldw	x,(OFST-5,sp)
 707  017b a3000c        	cpw	x,#12
 708  017e 25c8          	jrult	L762
 710  0180 ace000e0      	jpf	L732
 711  0184               L303:
 712                     ; 104 				rep=ADC_Read(AIN4);
 714  0184 a604          	ld	a,#4
 715  0186 cd0000        	call	_ADC_Read
 717  0189 cd0000        	call	c_uitolx
 719  018c 96            	ldw	x,sp
 720  018d 1c0017        	addw	x,#OFST-9
 721  0190 cd0000        	call	c_rtol
 724                     ; 105 				my_min=rep;
 726  0193 1e19          	ldw	x,(OFST-7,sp)
 727  0195 1f1b          	ldw	(OFST-5,sp),x
 729                     ; 106 				my_max=rep;
 731  0197 1e19          	ldw	x,(OFST-7,sp)
 732  0199 1f15          	ldw	(OFST-11,sp),x
 734                     ; 107 				for(iter=0;iter<1000;iter++)
 736  019b ae0000        	ldw	x,#0
 737  019e 1f1f          	ldw	(OFST-1,sp),x
 738  01a0 ae0000        	ldw	x,#0
 739  01a3 1f1d          	ldw	(OFST-3,sp),x
 741  01a5               L703:
 742                     ; 109 					rep=ADC_Read(AIN4);
 744  01a5 a604          	ld	a,#4
 745  01a7 cd0000        	call	_ADC_Read
 747  01aa cd0000        	call	c_uitolx
 749  01ad 96            	ldw	x,sp
 750  01ae 1c0017        	addw	x,#OFST-9
 751  01b1 cd0000        	call	c_rtol
 754                     ; 110 					my_min=my_min<rep?my_min:rep;
 756  01b4 1e1b          	ldw	x,(OFST-5,sp)
 757  01b6 cd0000        	call	c_uitolx
 759  01b9 96            	ldw	x,sp
 760  01ba 1c0017        	addw	x,#OFST-9
 761  01bd cd0000        	call	c_lcmp
 763  01c0 2404          	jruge	L41
 764  01c2 1e1b          	ldw	x,(OFST-5,sp)
 765  01c4 2002          	jra	L61
 766  01c6               L41:
 767  01c6 1e19          	ldw	x,(OFST-7,sp)
 768  01c8               L61:
 769  01c8 1f1b          	ldw	(OFST-5,sp),x
 771                     ; 111 					my_max=my_max>rep?my_max:rep;
 773  01ca 1e15          	ldw	x,(OFST-11,sp)
 774  01cc cd0000        	call	c_uitolx
 776  01cf 96            	ldw	x,sp
 777  01d0 1c0017        	addw	x,#OFST-9
 778  01d3 cd0000        	call	c_lcmp
 780  01d6 2304          	jrule	L02
 781  01d8 1e15          	ldw	x,(OFST-11,sp)
 782  01da 2002          	jra	L22
 783  01dc               L02:
 784  01dc 1e19          	ldw	x,(OFST-7,sp)
 785  01de               L22:
 786  01de 1f15          	ldw	(OFST-11,sp),x
 788                     ; 107 				for(iter=0;iter<1000;iter++)
 790  01e0 96            	ldw	x,sp
 791  01e1 1c001d        	addw	x,#OFST-3
 792  01e4 a601          	ld	a,#1
 793  01e6 cd0000        	call	c_lgadc
 798  01e9 96            	ldw	x,sp
 799  01ea 1c001d        	addw	x,#OFST-3
 800  01ed cd0000        	call	c_ltor
 802  01f0 ae0008        	ldw	x,#L42
 803  01f3 cd0000        	call	c_lcmp
 805  01f6 25ad          	jrult	L703
 806                     ; 113 				Serial_print_string("adc: ");
 808  01f8 ae00c4        	ldw	x,#L513
 809  01fb cd044f        	call	_Serial_print_string
 811                     ; 114 				Serial_print_int(rep);
 813  01fe 1e19          	ldw	x,(OFST-7,sp)
 814  0200 cd0478        	call	_Serial_print_int
 816                     ; 115 				Serial_print_string(", ");
 818  0203 ae00c1        	ldw	x,#L713
 819  0206 cd044f        	call	_Serial_print_string
 821                     ; 116 				Serial_print_int(my_max-my_min);
 823  0209 1e15          	ldw	x,(OFST-11,sp)
 824  020b 72f01b        	subw	x,(OFST-5,sp)
 825  020e cd0478        	call	_Serial_print_int
 827                     ; 117 				Serial_newline();
 829  0211 cd04db        	call	_Serial_newline
 831                     ; 118 				for(iter=0;iter<10000;iter++){}
 833  0214 ae0000        	ldw	x,#0
 834  0217 1f1f          	ldw	(OFST-1,sp),x
 835  0219 ae0000        	ldw	x,#0
 836  021c 1f1d          	ldw	(OFST-3,sp),x
 838  021e               L123:
 841  021e 96            	ldw	x,sp
 842  021f 1c001d        	addw	x,#OFST-3
 843  0222 a601          	ld	a,#1
 844  0224 cd0000        	call	c_lgadc
 849  0227 96            	ldw	x,sp
 850  0228 1c001d        	addw	x,#OFST-3
 851  022b cd0000        	call	c_ltor
 853  022e ae0000        	ldw	x,#L01
 854  0231 cd0000        	call	c_lcmp
 856  0234 25e8          	jrult	L123
 858  0236 ac840184      	jpf	L303
 859  023a               L36:
 860                     ; 123 			ADC1_DeInit();
 862  023a cd0000        	call	_ADC1_DeInit
 864                     ; 124 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 864                     ; 125 							 AIN4,
 864                     ; 126 							 ADC1_PRESSEL_FCPU_D2,//D18 
 864                     ; 127 							 ADC1_EXTTRIG_TIM, 
 864                     ; 128 							 DISABLE, 
 864                     ; 129 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 864                     ; 130 							 ADC1_SCHMITTTRIG_ALL, 
 864                     ; 131 							 DISABLE);
 866  023d 4b00          	push	#0
 867  023f 4bff          	push	#255
 868  0241 4b08          	push	#8
 869  0243 4b00          	push	#0
 870  0245 4b00          	push	#0
 871  0247 4b00          	push	#0
 872  0249 ae0104        	ldw	x,#260
 873  024c cd0000        	call	_ADC1_Init
 875  024f 5b06          	addw	sp,#6
 876                     ; 132 			ADC1_Cmd(ENABLE);
 878  0251 a601          	ld	a,#1
 879  0253 cd0000        	call	_ADC1_Cmd
 881  0256               L723:
 882                     ; 156 				rms=0;
 884  0256 5f            	clrw	x
 885  0257 1f1b          	ldw	(OFST-5,sp),x
 887                     ; 158 				mean_sum=0;
 889  0259 ae0000        	ldw	x,#0
 890  025c 1f19          	ldw	(OFST-7,sp),x
 891  025e ae0000        	ldw	x,#0
 892  0261 1f17          	ldw	(OFST-9,sp),x
 894                     ; 159 				mean_low=mean+mean_threshold;
 896  0263 7b12          	ld	a,(OFST-14,sp)
 897  0265 5f            	clrw	x
 898  0266 1b11          	add	a,(OFST-15,sp)
 899  0268 2401          	jrnc	L62
 900  026a 5c            	incw	x
 901  026b               L62:
 902  026b cd0000        	call	c_itol
 904  026e 96            	ldw	x,sp
 905  026f 1c0005        	addw	x,#OFST-27
 906  0272 cd0000        	call	c_rtol
 909                     ; 160 				mean_high=mean-mean_threshold;
 911  0275 7b12          	ld	a,(OFST-14,sp)
 912  0277 5f            	clrw	x
 913  0278 1011          	sub	a,(OFST-15,sp)
 914  027a 2401          	jrnc	L03
 915  027c 5a            	decw	x
 916  027d               L03:
 917  027d cd0000        	call	c_itol
 919  0280 96            	ldw	x,sp
 920  0281 1c0009        	addw	x,#OFST-23
 921  0284 cd0000        	call	c_rtol
 924                     ; 161 				for(iter=0;iter<adc_captures;iter++)
 926  0287 ae0000        	ldw	x,#0
 927  028a 1f1f          	ldw	(OFST-1,sp),x
 928  028c ae0000        	ldw	x,#0
 929  028f 1f1d          	ldw	(OFST-3,sp),x
 932  0291 2058          	jra	L733
 933  0293               L333:
 934                     ; 164 					ADC1_StartConversion();
 936  0293 cd0000        	call	_ADC1_StartConversion
 939  0296               L543:
 940                     ; 165 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 942  0296 a680          	ld	a,#128
 943  0298 cd0000        	call	_ADC1_GetFlagStatus
 945  029b 4d            	tnz	a
 946  029c 27f8          	jreq	L543
 947                     ; 167 					reading=ADC1->DRL;
 949  029e c65405        	ld	a,21509
 950  02a1 6b12          	ld	(OFST-14,sp),a
 952                     ; 168 					mean_sum += reading;
 954  02a3 7b12          	ld	a,(OFST-14,sp)
 955  02a5 96            	ldw	x,sp
 956  02a6 1c0017        	addw	x,#OFST-9
 957  02a9 cd0000        	call	c_lgadc
 960                     ; 169 					rms+=reading>mean_low || reading<mean_high;
 962  02ac 7b12          	ld	a,(OFST-14,sp)
 963  02ae b703          	ld	c_lreg+3,a
 964  02b0 3f02          	clr	c_lreg+2
 965  02b2 3f01          	clr	c_lreg+1
 966  02b4 3f00          	clr	c_lreg
 967  02b6 96            	ldw	x,sp
 968  02b7 1c0005        	addw	x,#OFST-27
 969  02ba cd0000        	call	c_lcmp
 971  02bd 2213          	jrugt	L43
 972  02bf 7b12          	ld	a,(OFST-14,sp)
 973  02c1 b703          	ld	c_lreg+3,a
 974  02c3 3f02          	clr	c_lreg+2
 975  02c5 3f01          	clr	c_lreg+1
 976  02c7 3f00          	clr	c_lreg
 977  02c9 96            	ldw	x,sp
 978  02ca 1c0009        	addw	x,#OFST-23
 979  02cd cd0000        	call	c_lcmp
 981  02d0 2405          	jruge	L23
 982  02d2               L43:
 983  02d2 ae0001        	ldw	x,#1
 984  02d5 2001          	jra	L63
 985  02d7               L23:
 986  02d7 5f            	clrw	x
 987  02d8               L63:
 988  02d8 72fb1b        	addw	x,(OFST-5,sp)
 989  02db 1f1b          	ldw	(OFST-5,sp),x
 991                     ; 173 					ADC1_ClearFlag(ADC1_FLAG_EOC);
 993  02dd a680          	ld	a,#128
 994  02df cd0000        	call	_ADC1_ClearFlag
 996                     ; 161 				for(iter=0;iter<adc_captures;iter++)
 998  02e2 96            	ldw	x,sp
 999  02e3 1c001d        	addw	x,#OFST-3
1000  02e6 a601          	ld	a,#1
1001  02e8 cd0000        	call	c_lgadc
1004  02eb               L733:
1007  02eb 96            	ldw	x,sp
1008  02ec 1c001d        	addw	x,#OFST-3
1009  02ef cd0000        	call	c_ltor
1011  02f2 96            	ldw	x,sp
1012  02f3 1c000d        	addw	x,#OFST-19
1013  02f6 cd0000        	call	c_lcmp
1015  02f9 2598          	jrult	L333
1016                     ; 177 				if(rms>9) mean_threshold++;
1018  02fb 1e1b          	ldw	x,(OFST-5,sp)
1019  02fd a3000a        	cpw	x,#10
1020  0300 2502          	jrult	L153
1023  0302 0c11          	inc	(OFST-15,sp)
1025  0304               L153:
1026                     ; 178 				if(rms==0) mean_threshold--;
1028  0304 1e1b          	ldw	x,(OFST-5,sp)
1029  0306 2602          	jrne	L353
1032  0308 0a11          	dec	(OFST-15,sp)
1034  030a               L353:
1035                     ; 179 				mean=(mean_sum)/(adc_captures);
1037  030a 96            	ldw	x,sp
1038  030b 1c0017        	addw	x,#OFST-9
1039  030e cd0000        	call	c_ltor
1041  0311 96            	ldw	x,sp
1042  0312 1c000d        	addw	x,#OFST-19
1043  0315 cd0000        	call	c_ludv
1045  0318 b603          	ld	a,c_lreg+3
1046  031a 6b12          	ld	(OFST-14,sp),a
1048                     ; 180 				if(sound_level/32<mean_threshold) sound_level++;
1050  031c 1e13          	ldw	x,(OFST-13,sp)
1051  031e 54            	srlw	x
1052  031f 54            	srlw	x
1053  0320 54            	srlw	x
1054  0321 54            	srlw	x
1055  0322 54            	srlw	x
1056  0323 7b11          	ld	a,(OFST-15,sp)
1057  0325 905f          	clrw	y
1058  0327 9097          	ld	yl,a
1059  0329 90bf00        	ldw	c_y,y
1060  032c b300          	cpw	x,c_y
1061  032e 2407          	jruge	L553
1064  0330 1e13          	ldw	x,(OFST-13,sp)
1065  0332 1c0001        	addw	x,#1
1066  0335 1f13          	ldw	(OFST-13,sp),x
1068  0337               L553:
1069                     ; 181 				if(sound_level/32>mean_threshold) sound_level--;
1071  0337 1e13          	ldw	x,(OFST-13,sp)
1072  0339 54            	srlw	x
1073  033a 54            	srlw	x
1074  033b 54            	srlw	x
1075  033c 54            	srlw	x
1076  033d 54            	srlw	x
1077  033e 7b11          	ld	a,(OFST-15,sp)
1078  0340 905f          	clrw	y
1079  0342 9097          	ld	yl,a
1080  0344 90bf00        	ldw	c_y,y
1081  0347 b300          	cpw	x,c_y
1082  0349 2307          	jrule	L753
1085  034b 1e13          	ldw	x,(OFST-13,sp)
1086  034d 1d0001        	subw	x,#1
1087  0350 1f13          	ldw	(OFST-13,sp),x
1089  0352               L753:
1090                     ; 182 				if(debug%4==0)
1092  0352 1e15          	ldw	x,(OFST-11,sp)
1093  0354 a604          	ld	a,#4
1094  0356 cd0000        	call	c_smodx
1096  0359 a30000        	cpw	x,#0
1097  035c 267a          	jrne	L163
1098                     ; 184 					Serial_print_string("adc: ");
1100  035e ae00c4        	ldw	x,#L513
1101  0361 cd044f        	call	_Serial_print_string
1103                     ; 185 					Serial_print_int(mean);
1105  0364 7b12          	ld	a,(OFST-14,sp)
1106  0366 5f            	clrw	x
1107  0367 97            	ld	xl,a
1108  0368 cd0478        	call	_Serial_print_int
1110                     ; 186 					Serial_print_string(", ");
1112  036b ae00c1        	ldw	x,#L713
1113  036e cd044f        	call	_Serial_print_string
1115                     ; 187 					if(rms<9) Serial_print_string("0");
1117  0371 1e1b          	ldw	x,(OFST-5,sp)
1118  0373 a30009        	cpw	x,#9
1119  0376 2406          	jruge	L363
1122  0378 ae00bf        	ldw	x,#L563
1123  037b cd044f        	call	_Serial_print_string
1125  037e               L363:
1126                     ; 188 					if(rms==0) Serial_print_string("0");
1128  037e 1e1b          	ldw	x,(OFST-5,sp)
1129  0380 2606          	jrne	L763
1132  0382 ae00bf        	ldw	x,#L563
1133  0385 cd044f        	call	_Serial_print_string
1135  0388               L763:
1136                     ; 189 					Serial_print_int(rms);
1138  0388 1e1b          	ldw	x,(OFST-5,sp)
1139  038a cd0478        	call	_Serial_print_int
1141                     ; 190 					Serial_print_string(", ");
1143  038d ae00c1        	ldw	x,#L713
1144  0390 cd044f        	call	_Serial_print_string
1146                     ; 191 					if(mean_threshold<9) Serial_print_string("0");
1148  0393 7b11          	ld	a,(OFST-15,sp)
1149  0395 a109          	cp	a,#9
1150  0397 2406          	jruge	L173
1153  0399 ae00bf        	ldw	x,#L563
1154  039c cd044f        	call	_Serial_print_string
1156  039f               L173:
1157                     ; 192 					Serial_print_int(mean_threshold);
1159  039f 7b11          	ld	a,(OFST-15,sp)
1160  03a1 5f            	clrw	x
1161  03a2 97            	ld	xl,a
1162  03a3 cd0478        	call	_Serial_print_int
1164                     ; 193 					Serial_print_string(", ");
1166  03a6 ae00c1        	ldw	x,#L713
1167  03a9 cd044f        	call	_Serial_print_string
1169                     ; 194 					if(sound_level/8<9) Serial_print_string("0");
1171  03ac 1e13          	ldw	x,(OFST-13,sp)
1172  03ae 54            	srlw	x
1173  03af 54            	srlw	x
1174  03b0 54            	srlw	x
1175  03b1 a30009        	cpw	x,#9
1176  03b4 2406          	jruge	L373
1179  03b6 ae00bf        	ldw	x,#L563
1180  03b9 cd044f        	call	_Serial_print_string
1182  03bc               L373:
1183                     ; 195 					Serial_print_int(sound_level/8);
1185  03bc 1e13          	ldw	x,(OFST-13,sp)
1186  03be 54            	srlw	x
1187  03bf 54            	srlw	x
1188  03c0 54            	srlw	x
1189  03c1 cd0478        	call	_Serial_print_int
1191                     ; 196 					if(debug%10==0) Serial_print_string("*");
1193  03c4 1e15          	ldw	x,(OFST-11,sp)
1194  03c6 a60a          	ld	a,#10
1195  03c8 cd0000        	call	c_smodx
1197  03cb a30000        	cpw	x,#0
1198  03ce 2605          	jrne	L573
1201  03d0 ae00bd        	ldw	x,#L773
1202  03d3 ad7a          	call	_Serial_print_string
1204  03d5               L573:
1205                     ; 197 					Serial_newline();
1207  03d5 cd04db        	call	_Serial_newline
1209  03d8               L163:
1210                     ; 199 				if(mean_threshold>10)
1212  03d8 7b11          	ld	a,(OFST-15,sp)
1213  03da a10b          	cp	a,#11
1214  03dc 2518          	jrult	L104
1215                     ; 203 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1217  03de 4bd0          	push	#208
1218  03e0 4b08          	push	#8
1219  03e2 ae500a        	ldw	x,#20490
1220  03e5 cd0000        	call	_GPIO_Init
1222  03e8 85            	popw	x
1223                     ; 204 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1225  03e9 4bc0          	push	#192
1226  03eb 4b20          	push	#32
1227  03ed ae500a        	ldw	x,#20490
1228  03f0 cd0000        	call	_GPIO_Init
1230  03f3 85            	popw	x
1232  03f4 2016          	jra	L304
1233  03f6               L104:
1234                     ; 206 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1236  03f6 4bd0          	push	#208
1237  03f8 4b10          	push	#16
1238  03fa ae500a        	ldw	x,#20490
1239  03fd cd0000        	call	_GPIO_Init
1241  0400 85            	popw	x
1242                     ; 207 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1244  0401 4bc0          	push	#192
1245  0403 4b40          	push	#64
1246  0405 ae500a        	ldw	x,#20490
1247  0408 cd0000        	call	_GPIO_Init
1249  040b 85            	popw	x
1250  040c               L304:
1251                     ; 209 			for(iter=0;iter<10;iter++){}
1253  040c ae0000        	ldw	x,#0
1254  040f 1f1f          	ldw	(OFST-1,sp),x
1255  0411 ae0000        	ldw	x,#0
1256  0414 1f1d          	ldw	(OFST-3,sp),x
1258  0416               L504:
1261  0416 96            	ldw	x,sp
1262  0417 1c001d        	addw	x,#OFST-3
1263  041a a601          	ld	a,#1
1264  041c cd0000        	call	c_lgadc
1269  041f 96            	ldw	x,sp
1270  0420 1c001d        	addw	x,#OFST-3
1271  0423 cd0000        	call	c_ltor
1273  0426 ae000c        	ldw	x,#L04
1274  0429 cd0000        	call	c_lcmp
1276  042c 25e8          	jrult	L504
1277                     ; 210 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1279  042e 4b00          	push	#0
1280  0430 4bf8          	push	#248
1281  0432 ae500a        	ldw	x,#20490
1282  0435 cd0000        	call	_GPIO_Init
1284  0438 85            	popw	x
1285                     ; 211 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1287  0439 4b00          	push	#0
1288  043b 4b04          	push	#4
1289  043d ae500f        	ldw	x,#20495
1290  0440 cd0000        	call	_GPIO_Init
1292  0443 85            	popw	x
1293                     ; 213 				debug++;
1295  0444 1e15          	ldw	x,(OFST-11,sp)
1296  0446 1c0001        	addw	x,#1
1297  0449 1f15          	ldw	(OFST-11,sp),x
1300  044b ac560256      	jpf	L723
1347                     ; 242  void Serial_print_string (char string[])
1347                     ; 243  {
1348                     	switch	.text
1349  044f               _Serial_print_string:
1351  044f 89            	pushw	x
1352  0450 88            	push	a
1353       00000001      OFST:	set	1
1356                     ; 245 	 char i=0;
1358  0451 0f01          	clr	(OFST+0,sp)
1361  0453 2016          	jra	L144
1362  0455               L534:
1363                     ; 249 		UART1_SendData8(string[i]);
1365  0455 7b01          	ld	a,(OFST+0,sp)
1366  0457 5f            	clrw	x
1367  0458 97            	ld	xl,a
1368  0459 72fb02        	addw	x,(OFST+1,sp)
1369  045c f6            	ld	a,(x)
1370  045d cd0000        	call	_UART1_SendData8
1373  0460               L744:
1374                     ; 250 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
1376  0460 ae0080        	ldw	x,#128
1377  0463 cd0000        	call	_UART1_GetFlagStatus
1379  0466 4d            	tnz	a
1380  0467 27f7          	jreq	L744
1381                     ; 251 		i++;
1383  0469 0c01          	inc	(OFST+0,sp)
1385  046b               L144:
1386                     ; 247 	 while (string[i] != 0x00)
1388  046b 7b01          	ld	a,(OFST+0,sp)
1389  046d 5f            	clrw	x
1390  046e 97            	ld	xl,a
1391  046f 72fb02        	addw	x,(OFST+1,sp)
1392  0472 7d            	tnz	(x)
1393  0473 26e0          	jrne	L534
1394                     ; 253  }
1397  0475 5b03          	addw	sp,#3
1398  0477 81            	ret
1401                     	switch	.const
1402  0010               L354_digit:
1403  0010 00            	dc.b	0
1404  0011 00000000      	ds.b	4
1457                     ; 255  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
1457                     ; 256  {
1458                     	switch	.text
1459  0478               _Serial_print_int:
1461  0478 89            	pushw	x
1462  0479 5208          	subw	sp,#8
1463       00000008      OFST:	set	8
1466                     ; 257 	 char count = 0;
1468  047b 0f08          	clr	(OFST+0,sp)
1470                     ; 258 	 char digit[5] = "";
1472  047d 96            	ldw	x,sp
1473  047e 1c0003        	addw	x,#OFST-5
1474  0481 90ae0010      	ldw	y,#L354_digit
1475  0485 a605          	ld	a,#5
1476  0487 cd0000        	call	c_xymov
1479  048a 2023          	jra	L705
1480  048c               L305:
1481                     ; 262 		 digit[count] = number%10;
1483  048c 96            	ldw	x,sp
1484  048d 1c0003        	addw	x,#OFST-5
1485  0490 9f            	ld	a,xl
1486  0491 5e            	swapw	x
1487  0492 1b08          	add	a,(OFST+0,sp)
1488  0494 2401          	jrnc	L45
1489  0496 5c            	incw	x
1490  0497               L45:
1491  0497 02            	rlwa	x,a
1492  0498 1609          	ldw	y,(OFST+1,sp)
1493  049a a60a          	ld	a,#10
1494  049c cd0000        	call	c_smody
1496  049f 9001          	rrwa	y,a
1497  04a1 f7            	ld	(x),a
1498  04a2 9002          	rlwa	y,a
1499                     ; 263 		 count++;
1501  04a4 0c08          	inc	(OFST+0,sp)
1503                     ; 264 		 number = number/10;
1505  04a6 1e09          	ldw	x,(OFST+1,sp)
1506  04a8 a60a          	ld	a,#10
1507  04aa cd0000        	call	c_sdivx
1509  04ad 1f09          	ldw	(OFST+1,sp),x
1510  04af               L705:
1511                     ; 260 	 while (number != 0) //split the int to char array 
1513  04af 1e09          	ldw	x,(OFST+1,sp)
1514  04b1 26d9          	jrne	L305
1516  04b3 201f          	jra	L515
1517  04b5               L315:
1518                     ; 269 		UART1_SendData8(digit[count-1] + 0x30);
1520  04b5 96            	ldw	x,sp
1521  04b6 1c0003        	addw	x,#OFST-5
1522  04b9 1f01          	ldw	(OFST-7,sp),x
1524  04bb 7b08          	ld	a,(OFST+0,sp)
1525  04bd 5f            	clrw	x
1526  04be 97            	ld	xl,a
1527  04bf 5a            	decw	x
1528  04c0 72fb01        	addw	x,(OFST-7,sp)
1529  04c3 f6            	ld	a,(x)
1530  04c4 ab30          	add	a,#48
1531  04c6 cd0000        	call	_UART1_SendData8
1534  04c9               L325:
1535                     ; 270 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
1537  04c9 ae0080        	ldw	x,#128
1538  04cc cd0000        	call	_UART1_GetFlagStatus
1540  04cf 4d            	tnz	a
1541  04d0 27f7          	jreq	L325
1542                     ; 271 		count--; 
1544  04d2 0a08          	dec	(OFST+0,sp)
1546  04d4               L515:
1547                     ; 267 	 while (count !=0) //print char array in correct direction 
1549  04d4 0d08          	tnz	(OFST+0,sp)
1550  04d6 26dd          	jrne	L315
1551                     ; 273  }
1554  04d8 5b0a          	addw	sp,#10
1555  04da 81            	ret
1580                     ; 275  void Serial_newline(void)
1580                     ; 276  {
1581                     	switch	.text
1582  04db               _Serial_newline:
1586                     ; 277 	 UART1_SendData8(0x0a);
1588  04db a60a          	ld	a,#10
1589  04dd cd0000        	call	_UART1_SendData8
1592  04e0               L145:
1593                     ; 278 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
1595  04e0 ae0080        	ldw	x,#128
1596  04e3 cd0000        	call	_UART1_GetFlagStatus
1598  04e6 4d            	tnz	a
1599  04e7 27f7          	jreq	L145
1600                     ; 279  }
1603  04e9 81            	ret
1627                     ; 281 void setMatrixHighZ()
1627                     ; 282 {
1628                     	switch	.text
1629  04ea               _setMatrixHighZ:
1633                     ; 287 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1635  04ea 4b00          	push	#0
1636  04ec 4bf8          	push	#248
1637  04ee ae500a        	ldw	x,#20490
1638  04f1 cd0000        	call	_GPIO_Init
1640  04f4 85            	popw	x
1641                     ; 288 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1643  04f5 4b00          	push	#0
1644  04f7 4b0c          	push	#12
1645  04f9 ae500f        	ldw	x,#20495
1646  04fc cd0000        	call	_GPIO_Init
1648  04ff 85            	popw	x
1649                     ; 289 }
1652  0500 81            	ret
1696                     ; 291 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
1697                     	switch	.text
1698  0501               _setRGB:
1700  0501 89            	pushw	x
1701       00000000      OFST:	set	0
1706  0502 1e05          	ldw	x,(OFST+5,sp)
1707  0504 89            	pushw	x
1708  0505 1e03          	ldw	x,(OFST+3,sp)
1709  0507 89            	pushw	x
1710  0508 a601          	ld	a,#1
1711  050a ad11          	call	_setLED
1713  050c 5b04          	addw	sp,#4
1717  050e 85            	popw	x
1718  050f 81            	ret
1753                     ; 292 void setWhite(int led_index){ setLED(0,led_index,0); }
1754                     	switch	.text
1755  0510               _setWhite:
1757  0510 89            	pushw	x
1758       00000000      OFST:	set	0
1763  0511 5f            	clrw	x
1764  0512 89            	pushw	x
1765  0513 1e03          	ldw	x,(OFST+3,sp)
1766  0515 89            	pushw	x
1767  0516 4f            	clr	a
1768  0517 ad04          	call	_setLED
1770  0519 5b04          	addw	sp,#4
1774  051b 85            	popw	x
1775  051c 81            	ret
1778                     	switch	.const
1779  0015               L516_rgb_lookup:
1780  0015 0000          	dc.w	0
1781  0017 0001          	dc.w	1
1782  0019 0000          	dc.w	0
1783  001b 0002          	dc.w	2
1784  001d 0001          	dc.w	1
1785  001f 0002          	dc.w	2
1786  0021 0001          	dc.w	1
1787  0023 0000          	dc.w	0
1788  0025 0002          	dc.w	2
1789  0027 0000          	dc.w	0
1790  0029 0002          	dc.w	2
1791  002b 0001          	dc.w	1
1792  002d 0005          	dc.w	5
1793  002f 0000          	dc.w	0
1794  0031 0005          	dc.w	5
1795  0033 0001          	dc.w	1
1796  0035 0005          	dc.w	5
1797  0037 0002          	dc.w	2
1798  0039 0006          	dc.w	6
1799  003b 0000          	dc.w	0
1800  003d 0006          	dc.w	6
1801  003f 0001          	dc.w	1
1802  0041 0006          	dc.w	6
1803  0043 0002          	dc.w	2
1804  0045 0006          	dc.w	6
1805  0047 0005          	dc.w	5
1806  0049 0006          	dc.w	6
1807  004b 0004          	dc.w	4
1808  004d 0005          	dc.w	5
1809  004f 0004          	dc.w	4
1810  0051 0004          	dc.w	4
1811  0053 0003          	dc.w	3
1812  0055 0005          	dc.w	5
1813  0057 0003          	dc.w	3
1814  0059 0006          	dc.w	6
1815  005b 0003          	dc.w	3
1816  005d 0003          	dc.w	3
1817  005f 0004          	dc.w	4
1818  0061 0003          	dc.w	3
1819  0063 0005          	dc.w	5
1820  0065 0003          	dc.w	3
1821  0067 0006          	dc.w	6
1822  0069 0000          	dc.w	0
1823  006b 0005          	dc.w	5
1824  006d 0000          	dc.w	0
1825  006f 0006          	dc.w	6
1826  0071 0001          	dc.w	1
1827  0073 0006          	dc.w	6
1828  0075 0000          	dc.w	0
1829  0077 0004          	dc.w	4
1830  0079 0001          	dc.w	1
1831  007b 0004          	dc.w	4
1832  007d 0002          	dc.w	2
1833  007f 0004          	dc.w	4
1834  0081 0000          	dc.w	0
1835  0083 0003          	dc.w	3
1836  0085 0001          	dc.w	1
1837  0087 0003          	dc.w	3
1838  0089 0002          	dc.w	2
1839  008b 0003          	dc.w	3
1840  008d               L716_white_lookup:
1841  008d 0003          	dc.w	3
1842  008f 0000          	dc.w	0
1843  0091 0003          	dc.w	3
1844  0093 0001          	dc.w	1
1845  0095 0003          	dc.w	3
1846  0097 0002          	dc.w	2
1847  0099 0004          	dc.w	4
1848  009b 0000          	dc.w	0
1849  009d 0001          	dc.w	1
1850  009f 0005          	dc.w	5
1851  00a1 0002          	dc.w	2
1852  00a3 0005          	dc.w	5
1853  00a5 0004          	dc.w	4
1854  00a7 0001          	dc.w	1
1855  00a9 0004          	dc.w	4
1856  00ab 0002          	dc.w	2
1857  00ad 0002          	dc.w	2
1858  00af 0006          	dc.w	6
1859  00b1 0004          	dc.w	4
1860  00b3 0006          	dc.w	6
1861  00b5 0004          	dc.w	4
1862  00b7 0005          	dc.w	5
1863  00b9 0005          	dc.w	5
1864  00bb 0006          	dc.w	6
2126                     ; 294 void setLED(bool is_rgb,int led_index,int rgb_index)
2126                     ; 295 {
2127                     	switch	.text
2128  051d               _setLED:
2130  051d 88            	push	a
2131  051e 52b6          	subw	sp,#182
2132       000000b6      OFST:	set	182
2135                     ; 296   const unsigned short rgb_lookup[10][3][2]={
2135                     ; 297 		{{0,1},{0,2},{1,2}},//7
2135                     ; 298 		{{1,0},{2,0},{2,1}},//3
2135                     ; 299 		{{5,0},{5,1},{5,2}},//1
2135                     ; 300 		{{6,0},{6,1},{6,2}},//20
2135                     ; 301 		{{6,5},{6,4},{5,4}},//22
2135                     ; 302 		{{4,3},{5,3},{6,3}},//23
2135                     ; 303 		{{3,4},{3,5},{3,6}},//21
2135                     ; 304 		{{0,5},{0,6},{1,6}},//19
2135                     ; 305 		{{0,4},{1,4},{2,4}},//18
2135                     ; 306 		{{0,3},{1,3},{2,3}} //2
2135                     ; 307 	};
2137  0520 96            	ldw	x,sp
2138  0521 1c000e        	addw	x,#OFST-168
2139  0524 90ae0015      	ldw	y,#L516_rgb_lookup
2140  0528 a678          	ld	a,#120
2141  052a cd0000        	call	c_xymov
2143                     ; 308 	const unsigned short white_lookup[12][2]={
2143                     ; 309 		{3,0},//6
2143                     ; 310 		{3,1},//4
2143                     ; 311 		{3,2},//5
2143                     ; 312 		{4,0},//14
2143                     ; 313 		{1,5},//8
2143                     ; 314 		{2,5},//9
2143                     ; 315 		{4,1},//10
2143                     ; 316 		{4,2},//16
2143                     ; 317 		{2,6},//17
2143                     ; 318 		{4,6},//12
2143                     ; 319 		{4,5},//13
2143                     ; 320 		{5,6} //11
2143                     ; 321 	};
2145  052d 96            	ldw	x,sp
2146  052e 1c0086        	addw	x,#OFST-48
2147  0531 90ae008d      	ldw	y,#L716_white_lookup
2148  0535 a630          	ld	a,#48
2149  0537 cd0000        	call	c_xymov
2151                     ; 322 	bool is_low=0;
2153  053a 0fb6          	clr	(OFST+0,sp)
2155  053c               L7001:
2156                     ; 326 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
2158  053c 0db7          	tnz	(OFST+1,sp)
2159  053e 2726          	jreq	L07
2160  0540 7bb6          	ld	a,(OFST+0,sp)
2161  0542 5f            	clrw	x
2162  0543 97            	ld	xl,a
2163  0544 58            	sllw	x
2164  0545 1f09          	ldw	(OFST-173,sp),x
2166  0547 1ebc          	ldw	x,(OFST+6,sp)
2167  0549 58            	sllw	x
2168  054a 58            	sllw	x
2169  054b 1f07          	ldw	(OFST-175,sp),x
2171  054d 96            	ldw	x,sp
2172  054e 1c000e        	addw	x,#OFST-168
2173  0551 1f05          	ldw	(OFST-177,sp),x
2175  0553 1eba          	ldw	x,(OFST+4,sp)
2176  0555 a60c          	ld	a,#12
2177  0557 cd0000        	call	c_bmulx
2179  055a 72fb05        	addw	x,(OFST-177,sp)
2180  055d 72fb07        	addw	x,(OFST-175,sp)
2181  0560 72fb09        	addw	x,(OFST-173,sp)
2182  0563 fe            	ldw	x,(x)
2183  0564 2018          	jra	L27
2184  0566               L07:
2185  0566 7bb6          	ld	a,(OFST+0,sp)
2186  0568 5f            	clrw	x
2187  0569 97            	ld	xl,a
2188  056a 58            	sllw	x
2189  056b 1f03          	ldw	(OFST-179,sp),x
2191  056d 96            	ldw	x,sp
2192  056e 1c0086        	addw	x,#OFST-48
2193  0571 1f01          	ldw	(OFST-181,sp),x
2195  0573 1eba          	ldw	x,(OFST+4,sp)
2196  0575 58            	sllw	x
2197  0576 58            	sllw	x
2198  0577 72fb01        	addw	x,(OFST-181,sp)
2199  057a 72fb03        	addw	x,(OFST-179,sp)
2200  057d fe            	ldw	x,(x)
2201  057e               L27:
2203                     ; 358 			}break;
2204  057e 5d            	tnzw	x
2205  057f 2714          	jreq	L126
2206  0581 5a            	decw	x
2207  0582 271c          	jreq	L326
2208  0584 5a            	decw	x
2209  0585 2724          	jreq	L526
2210  0587 5a            	decw	x
2211  0588 272c          	jreq	L726
2212  058a 5a            	decw	x
2213  058b 2734          	jreq	L136
2214  058d 5a            	decw	x
2215  058e 273c          	jreq	L336
2216  0590 5a            	decw	x
2217  0591 2744          	jreq	L536
2218  0593 204b          	jra	L7101
2219  0595               L126:
2220                     ; 329 				GPIOx=GPIOD;
2222  0595 ae500f        	ldw	x,#20495
2223  0598 1f0b          	ldw	(OFST-171,sp),x
2225                     ; 330 				PortPin=GPIO_PIN_3;
2227  059a a608          	ld	a,#8
2228  059c 6b0d          	ld	(OFST-169,sp),a
2230                     ; 331 			}break;
2232  059e 2040          	jra	L7101
2233  05a0               L326:
2234                     ; 333 				GPIOx=GPIOD;
2236  05a0 ae500f        	ldw	x,#20495
2237  05a3 1f0b          	ldw	(OFST-171,sp),x
2239                     ; 334 				PortPin=GPIO_PIN_2;
2241  05a5 a604          	ld	a,#4
2242  05a7 6b0d          	ld	(OFST-169,sp),a
2244                     ; 335 			}break;
2246  05a9 2035          	jra	L7101
2247  05ab               L526:
2248                     ; 337 				GPIOx=GPIOC;
2250  05ab ae500a        	ldw	x,#20490
2251  05ae 1f0b          	ldw	(OFST-171,sp),x
2253                     ; 338 				PortPin=GPIO_PIN_7;
2255  05b0 a680          	ld	a,#128
2256  05b2 6b0d          	ld	(OFST-169,sp),a
2258                     ; 339 			}break;
2260  05b4 202a          	jra	L7101
2261  05b6               L726:
2262                     ; 341 				GPIOx=GPIOC;
2264  05b6 ae500a        	ldw	x,#20490
2265  05b9 1f0b          	ldw	(OFST-171,sp),x
2267                     ; 342 				PortPin=GPIO_PIN_6;
2269  05bb a640          	ld	a,#64
2270  05bd 6b0d          	ld	(OFST-169,sp),a
2272                     ; 343 			}break;
2274  05bf 201f          	jra	L7101
2275  05c1               L136:
2276                     ; 345 				GPIOx=GPIOC;
2278  05c1 ae500a        	ldw	x,#20490
2279  05c4 1f0b          	ldw	(OFST-171,sp),x
2281                     ; 346 				PortPin=GPIO_PIN_5;
2283  05c6 a620          	ld	a,#32
2284  05c8 6b0d          	ld	(OFST-169,sp),a
2286                     ; 347 			}break;
2288  05ca 2014          	jra	L7101
2289  05cc               L336:
2290                     ; 349 				GPIOx=GPIOC;
2292  05cc ae500a        	ldw	x,#20490
2293  05cf 1f0b          	ldw	(OFST-171,sp),x
2295                     ; 350 				PortPin=GPIO_PIN_4;
2297  05d1 a610          	ld	a,#16
2298  05d3 6b0d          	ld	(OFST-169,sp),a
2300                     ; 351 			}break;
2302  05d5 2009          	jra	L7101
2303  05d7               L536:
2304                     ; 353 				GPIOx=GPIOC;
2306  05d7 ae500a        	ldw	x,#20490
2307  05da 1f0b          	ldw	(OFST-171,sp),x
2309                     ; 354 				PortPin=GPIO_PIN_3;
2311  05dc a608          	ld	a,#8
2312  05de 6b0d          	ld	(OFST-169,sp),a
2314                     ; 355 			}break;
2316  05e0               L7101:
2317                     ; 360 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
2319  05e0 0db6          	tnz	(OFST+0,sp)
2320  05e2 2704          	jreq	L47
2321  05e4 a6c0          	ld	a,#192
2322  05e6 2002          	jra	L67
2323  05e8               L47:
2324  05e8 a6d0          	ld	a,#208
2325  05ea               L67:
2326  05ea 88            	push	a
2327  05eb 7b0e          	ld	a,(OFST-168,sp)
2328  05ed 88            	push	a
2329  05ee 1e0d          	ldw	x,(OFST-169,sp)
2330  05f0 cd0000        	call	_GPIO_Init
2332  05f3 85            	popw	x
2333                     ; 361 		is_low=!is_low;
2335  05f4 0db6          	tnz	(OFST+0,sp)
2336  05f6 2604          	jrne	L001
2337  05f8 a601          	ld	a,#1
2338  05fa 2001          	jra	L201
2339  05fc               L001:
2340  05fc 4f            	clr	a
2341  05fd               L201:
2342  05fd 6bb6          	ld	(OFST+0,sp),a
2344                     ; 362 	}while(is_low);
2346  05ff 0db6          	tnz	(OFST+0,sp)
2347  0601 2703          	jreq	L401
2348  0603 cc053c        	jp	L7001
2349  0606               L401:
2350                     ; 363 }
2353  0606 5bb7          	addw	sp,#183
2354  0608 81            	ret
2367                     	xdef	_main
2368                     	xdef	_Serial_print_string
2369                     	xdef	_Serial_newline
2370                     	xdef	_Serial_print_int
2371                     	xdef	_setWhite
2372                     	xdef	_setRGB
2373                     	xdef	_setLED
2374                     	xdef	_setMatrixHighZ
2375                     	xdef	_ADC_Read
2376                     	xref	_UART1_GetFlagStatus
2377                     	xref	_UART1_SendData8
2378                     	xref	_UART1_Cmd
2379                     	xref	_UART1_Init
2380                     	xref	_UART1_DeInit
2381                     	xref	_GPIO_Init
2382                     	xref	_ADC1_ClearFlag
2383                     	xref	_ADC1_GetFlagStatus
2384                     	xref	_ADC1_GetConversionValue
2385                     	xref	_ADC1_StartConversion
2386                     	xref	_ADC1_Cmd
2387                     	xref	_ADC1_Init
2388                     	xref	_ADC1_DeInit
2389                     	switch	.const
2390  00bd               L773:
2391  00bd 2a00          	dc.b	"*",0
2392  00bf               L563:
2393  00bf 3000          	dc.b	"0",0
2394  00c1               L713:
2395  00c1 2c2000        	dc.b	", ",0
2396  00c4               L513:
2397  00c4 6164633a2000  	dc.b	"adc: ",0
2398  00ca               L562:
2399  00ca 636f756e7465  	dc.b	"counter: ",0
2400                     	xref.b	c_lreg
2401                     	xref.b	c_x
2402                     	xref.b	c_y
2422                     	xref	c_bmulx
2423                     	xref	c_sdivx
2424                     	xref	c_smody
2425                     	xref	c_xymov
2426                     	xref	c_smodx
2427                     	xref	c_ludv
2428                     	xref	c_itol
2429                     	xref	c_rtol
2430                     	xref	c_uitolx
2431                     	xref	c_lzmp
2432                     	xref	c_lcmp
2433                     	xref	c_ltor
2434                     	xref	c_lgadc
2435                     	end
