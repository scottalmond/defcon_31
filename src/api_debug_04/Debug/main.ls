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
 193                     	bsct
 194  0000               _tms:
 195  0000 00000000      	dc.l	0
 196  0004               _tms2:
 197  0004 00000000      	dc.l	0
 198  0008               _tms3:
 199  0008 00000000      	dc.l	0
 200  000c               _pwm_sleep_remaining:
 201  000c 0000          	dc.w	0
 202  000e               _pwm_led_index:
 203  000e 00            	dc.b	0
 204  000f               _pwm_state:
 205  000f 00            	dc.b	0
 206                     .const:	section	.text
 207  0000               L75_rms_lookup:
 208  0000 09            	dc.b	9
 209  0001 12            	dc.b	18
 210  0002 1c            	dc.b	28
 211  0003 26            	dc.b	38
 212  0004 30            	dc.b	48
 213  0005 3a            	dc.b	58
 214  0006 45            	dc.b	69
 215  0007 50            	dc.b	80
 216  0008 5c            	dc.b	92
 217  0009 69            	dc.b	105
 218  000a 76            	dc.b	118
 219  000b 86            	dc.b	134
 220  000c 97            	dc.b	151
 221  000d ad            	dc.b	173
 222  000e c8            	dc.b	200
 223  000f f1            	dc.b	241
 478                     	switch	.const
 479  0010               L01:
 480  0010 00002710      	dc.l	10000
 481  0014               L21:
 482  0014 00007530      	dc.l	30000
 483  0018               L42:
 484  0018 000003e8      	dc.l	1000
 485  001c               L04:
 486  001c 0000000a      	dc.l	10
 487  0020               L25:
 488  0020 00000014      	dc.l	20
 489  0024               L45:
 490  0024 00000064      	dc.l	100
 491  0028               L65:
 492  0028 000007d0      	dc.l	2000
 493  002c               L46:
 494  002c 00001388      	dc.l	5000
 495  0030               L66:
 496  0030 0000003c      	dc.l	60
 497  0034               L07:
 498  0034 00000005      	dc.l	5
 499  0038               L27:
 500  0038 00000003      	dc.l	3
 501  003c               L001:
 502  003c 00001f40      	dc.l	8000
 503                     ; 34 int main()
 503                     ; 35 {
 504                     	switch	.text
 505  003e               _main:
 507  003e 5238          	subw	sp,#56
 508       00000038      OFST:	set	56
 511                     ; 58 	const int test_mode=9;
 513  0040 ae0009        	ldw	x,#9
 514  0043 1f33          	ldw	(OFST-5,sp),x
 516                     ; 59 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 518  0045 96            	ldw	x,sp
 519  0046 1c0009        	addw	x,#OFST-47
 520  0049 90ae0000      	ldw	y,#L75_rms_lookup
 521  004d a610          	ld	a,#16
 522  004f cd0000        	call	c_xymov
 524                     ; 61 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 528  0052 ae0000        	ldw	x,#0
 529  0055 1f29          	ldw	(OFST-15,sp),x
 530  0057 ae0000        	ldw	x,#0
 531  005a 1f27          	ldw	(OFST-17,sp),x
 537                     ; 62 	unsigned sound_level=0;
 539  005c 5f            	clrw	x
 540  005d 1f31          	ldw	(OFST-7,sp),x
 542                     ; 63 	uint8_t mean_threshold=16;
 544  005f a610          	ld	a,#16
 545  0061 6b24          	ld	(OFST-20,sp),a
 547                     ; 64 	uint8_t mean_threshold_8=1;
 549  0063 a601          	ld	a,#1
 550  0065 6b23          	ld	(OFST-21,sp),a
 552                     ; 65 	uint16_t mean_threshold_16=0x0100;
 554  0067 ae0100        	ldw	x,#256
 555  006a 1f1d          	ldw	(OFST-27,sp),x
 557                     ; 66 	unsigned int rms=0;
 559                     ; 67 	const long adc_captures=1<<8;
 561  006c ae0100        	ldw	x,#256
 562  006f 1f1b          	ldw	(OFST-29,sp),x
 563  0071 ae0000        	ldw	x,#0
 564  0074 1f19          	ldw	(OFST-31,sp),x
 566                     ; 69 	int debug=0;
 568  0076 5f            	clrw	x
 569  0077 1f2b          	ldw	(OFST-13,sp),x
 571                     ; 71 	for(rep=0;rep<1;rep++)
 573  0079 ae0000        	ldw	x,#0
 574  007c 1f2f          	ldw	(OFST-9,sp),x
 575  007e ae0000        	ldw	x,#0
 576  0081 1f2d          	ldw	(OFST-11,sp),x
 578  0083               L752:
 579                     ; 72 		for(iter=0;iter<10000;iter++){}
 581  0083 ae0000        	ldw	x,#0
 582  0086 1f37          	ldw	(OFST-1,sp),x
 583  0088 ae0000        	ldw	x,#0
 584  008b 1f35          	ldw	(OFST-3,sp),x
 586  008d               L562:
 589  008d 96            	ldw	x,sp
 590  008e 1c0035        	addw	x,#OFST-3
 591  0091 a601          	ld	a,#1
 592  0093 cd0000        	call	c_lgadc
 597  0096 96            	ldw	x,sp
 598  0097 1c0035        	addw	x,#OFST-3
 599  009a cd0000        	call	c_ltor
 601  009d ae0010        	ldw	x,#L01
 602  00a0 cd0000        	call	c_lcmp
 604  00a3 25e8          	jrult	L562
 605                     ; 71 	for(rep=0;rep<1;rep++)
 607  00a5 96            	ldw	x,sp
 608  00a6 1c002d        	addw	x,#OFST-11
 609  00a9 a601          	ld	a,#1
 610  00ab cd0000        	call	c_lgadc
 615  00ae 96            	ldw	x,sp
 616  00af 1c002d        	addw	x,#OFST-11
 617  00b2 cd0000        	call	c_lzmp
 619  00b5 27cc          	jreq	L752
 620                     ; 75 	if(test_mode!=4 && test_mode!=5 && test_mode!=9)
 622  00b7 1e33          	ldw	x,(OFST-5,sp)
 623  00b9 a30004        	cpw	x,#4
 624  00bc 2743          	jreq	L372
 626  00be 1e33          	ldw	x,(OFST-5,sp)
 627  00c0 a30005        	cpw	x,#5
 628  00c3 273c          	jreq	L372
 630  00c5 1e33          	ldw	x,(OFST-5,sp)
 631  00c7 a30009        	cpw	x,#9
 632  00ca 2735          	jreq	L372
 633                     ; 77 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 635  00cc 4bf0          	push	#240
 636  00ce 4b20          	push	#32
 637  00d0 ae500f        	ldw	x,#20495
 638  00d3 cd0000        	call	_GPIO_Init
 640  00d6 85            	popw	x
 641                     ; 78 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 643  00d7 4b40          	push	#64
 644  00d9 4b40          	push	#64
 645  00db ae500f        	ldw	x,#20495
 646  00de cd0000        	call	_GPIO_Init
 648  00e1 85            	popw	x
 649                     ; 79 		UART1_DeInit();
 651  00e2 cd0000        	call	_UART1_DeInit
 653                     ; 80 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 655  00e5 4b0c          	push	#12
 656  00e7 4b80          	push	#128
 657  00e9 4b00          	push	#0
 658  00eb 4b00          	push	#0
 659  00ed 4b00          	push	#0
 660  00ef aec200        	ldw	x,#49664
 661  00f2 89            	pushw	x
 662  00f3 ae0001        	ldw	x,#1
 663  00f6 89            	pushw	x
 664  00f7 cd0000        	call	_UART1_Init
 666  00fa 5b09          	addw	sp,#9
 667                     ; 82 		UART1_Cmd(ENABLE);
 669  00fc a601          	ld	a,#1
 670  00fe cd0000        	call	_UART1_Cmd
 672  0101               L372:
 673                     ; 85 	switch(test_mode)
 675  0101 1e33          	ldw	x,(OFST-5,sp)
 677                     ; 509 				for(iter=0;iter<30000;iter++){}
 678  0103 5d            	tnzw	x
 679  0104 2739          	jreq	L103
 680  0106 5a            	decw	x
 681  0107 2603          	jrne	L401
 682  0109 cc01e3        	jp	L543
 683  010c               L401:
 684  010c 5a            	decw	x
 685  010d 2603          	jrne	L601
 686  010f cc0299        	jp	L56
 687  0112               L601:
 688  0112 5a            	decw	x
 689  0113 2603          	jrne	L011
 690  0115 cc04af        	jp	L76
 691  0118               L011:
 692  0118 5a            	decw	x
 693  0119 2603          	jrne	L211
 694  011b cc05e9        	jp	L17
 695  011e               L211:
 696  011e 5a            	decw	x
 697  011f 2603          	jrne	L411
 698  0121 cc064c        	jp	L37
 699  0124               L411:
 700  0124 5a            	decw	x
 701  0125 2603          	jrne	L611
 702  0127 cc07b6        	jp	L57
 703  012a               L611:
 704  012a 5a            	decw	x
 705  012b 2603          	jrne	L021
 706  012d cc0839        	jp	L77
 707  0130               L021:
 708  0130 5a            	decw	x
 709  0131 2603          	jrne	L221
 710  0133 cc0917        	jp	L101
 711  0136               L221:
 712  0136 5a            	decw	x
 713  0137 2603          	jrne	L421
 714  0139 cc0996        	jp	L301
 715  013c               L421:
 716  013c               L201:
 717                     ; 514 }
 720  013c 5b38          	addw	sp,#56
 721  013e 81            	ret
 722  013f               L103:
 723                     ; 93 				for(rgb_index=0;rgb_index<3;rgb_index++)
 725  013f 5f            	clrw	x
 726  0140 1f31          	ldw	(OFST-7,sp),x
 728  0142               L503:
 729                     ; 95 					for(led_index=0;led_index<10;led_index++)
 731  0142 5f            	clrw	x
 732  0143 1f33          	ldw	(OFST-5,sp),x
 734  0145               L313:
 735                     ; 97 						setMatrixHighZ();
 737  0145 cd0b4f        	call	_setMatrixHighZ
 739                     ; 98 						setRGB(led_index,rgb_index);
 741  0148 1e31          	ldw	x,(OFST-7,sp)
 742  014a 89            	pushw	x
 743  014b 1e35          	ldw	x,(OFST-3,sp)
 744  014d cd0b66        	call	_setRGB
 746  0150 85            	popw	x
 747                     ; 99 						for(iter=0;iter<30000;iter++){}
 749  0151 ae0000        	ldw	x,#0
 750  0154 1f37          	ldw	(OFST-1,sp),x
 751  0156 ae0000        	ldw	x,#0
 752  0159 1f35          	ldw	(OFST-3,sp),x
 754  015b               L123:
 757  015b 96            	ldw	x,sp
 758  015c 1c0035        	addw	x,#OFST-3
 759  015f a601          	ld	a,#1
 760  0161 cd0000        	call	c_lgadc
 765  0164 96            	ldw	x,sp
 766  0165 1c0035        	addw	x,#OFST-3
 767  0168 cd0000        	call	c_ltor
 769  016b ae0014        	ldw	x,#L21
 770  016e cd0000        	call	c_lcmp
 772  0171 25e8          	jrult	L123
 773                     ; 100 						debug++;
 775  0173 1e2b          	ldw	x,(OFST-13,sp)
 776  0175 1c0001        	addw	x,#1
 777  0178 1f2b          	ldw	(OFST-13,sp),x
 779                     ; 107 							Serial_print_string("counter: ");
 781  017a ae012c        	ldw	x,#L723
 782  017d cd0ab4        	call	_Serial_print_string
 784                     ; 108 							Serial_print_int(debug);
 786  0180 1e2b          	ldw	x,(OFST-13,sp)
 787  0182 cd0add        	call	_Serial_print_int
 789                     ; 111 							Serial_newline();
 791  0185 cd0b40        	call	_Serial_newline
 793                     ; 95 					for(led_index=0;led_index<10;led_index++)
 795  0188 1e33          	ldw	x,(OFST-5,sp)
 796  018a 1c0001        	addw	x,#1
 797  018d 1f33          	ldw	(OFST-5,sp),x
 801  018f 1e33          	ldw	x,(OFST-5,sp)
 802  0191 a3000a        	cpw	x,#10
 803  0194 25af          	jrult	L313
 804                     ; 93 				for(rgb_index=0;rgb_index<3;rgb_index++)
 806  0196 1e31          	ldw	x,(OFST-7,sp)
 807  0198 1c0001        	addw	x,#1
 808  019b 1f31          	ldw	(OFST-7,sp),x
 812  019d 1e31          	ldw	x,(OFST-7,sp)
 813  019f a30003        	cpw	x,#3
 814  01a2 259e          	jrult	L503
 815                     ; 115 				for(led_index=0;led_index<12;led_index++)
 817  01a4 5f            	clrw	x
 818  01a5 1f33          	ldw	(OFST-5,sp),x
 820  01a7               L133:
 821                     ; 117 					setMatrixHighZ();
 823  01a7 cd0b4f        	call	_setMatrixHighZ
 825                     ; 118 					setWhite(led_index);
 827  01aa 1e33          	ldw	x,(OFST-5,sp)
 828  01ac cd0b75        	call	_setWhite
 830                     ; 119 					for(iter=0;iter<30000;iter++){}
 832  01af ae0000        	ldw	x,#0
 833  01b2 1f37          	ldw	(OFST-1,sp),x
 834  01b4 ae0000        	ldw	x,#0
 835  01b7 1f35          	ldw	(OFST-3,sp),x
 837  01b9               L733:
 840  01b9 96            	ldw	x,sp
 841  01ba 1c0035        	addw	x,#OFST-3
 842  01bd a601          	ld	a,#1
 843  01bf cd0000        	call	c_lgadc
 848  01c2 96            	ldw	x,sp
 849  01c3 1c0035        	addw	x,#OFST-3
 850  01c6 cd0000        	call	c_ltor
 852  01c9 ae0014        	ldw	x,#L21
 853  01cc cd0000        	call	c_lcmp
 855  01cf 25e8          	jrult	L733
 856                     ; 115 				for(led_index=0;led_index<12;led_index++)
 858  01d1 1e33          	ldw	x,(OFST-5,sp)
 859  01d3 1c0001        	addw	x,#1
 860  01d6 1f33          	ldw	(OFST-5,sp),x
 864  01d8 1e33          	ldw	x,(OFST-5,sp)
 865  01da a3000c        	cpw	x,#12
 866  01dd 25c8          	jrult	L133
 868  01df ac3f013f      	jpf	L103
 869  01e3               L543:
 870                     ; 127 				rep=ADC_Read(AIN4);
 872  01e3 a604          	ld	a,#4
 873  01e5 cd0000        	call	_ADC_Read
 875  01e8 cd0000        	call	c_uitolx
 877  01eb 96            	ldw	x,sp
 878  01ec 1c002d        	addw	x,#OFST-11
 879  01ef cd0000        	call	c_rtol
 882                     ; 128 				my_min=rep;
 884  01f2 1e2f          	ldw	x,(OFST-9,sp)
 885  01f4 1f2b          	ldw	(OFST-13,sp),x
 887                     ; 129 				my_max=rep;
 889  01f6 1e2f          	ldw	x,(OFST-9,sp)
 890  01f8 1f31          	ldw	(OFST-7,sp),x
 892                     ; 130 				for(iter=0;iter<1000;iter++)
 894  01fa ae0000        	ldw	x,#0
 895  01fd 1f37          	ldw	(OFST-1,sp),x
 896  01ff ae0000        	ldw	x,#0
 897  0202 1f35          	ldw	(OFST-3,sp),x
 899  0204               L153:
 900                     ; 132 					rep=ADC_Read(AIN4);
 902  0204 a604          	ld	a,#4
 903  0206 cd0000        	call	_ADC_Read
 905  0209 cd0000        	call	c_uitolx
 907  020c 96            	ldw	x,sp
 908  020d 1c002d        	addw	x,#OFST-11
 909  0210 cd0000        	call	c_rtol
 912                     ; 133 					my_min=my_min<rep?my_min:rep;
 914  0213 1e2b          	ldw	x,(OFST-13,sp)
 915  0215 cd0000        	call	c_uitolx
 917  0218 96            	ldw	x,sp
 918  0219 1c002d        	addw	x,#OFST-11
 919  021c cd0000        	call	c_lcmp
 921  021f 2404          	jruge	L41
 922  0221 1e2b          	ldw	x,(OFST-13,sp)
 923  0223 2002          	jra	L61
 924  0225               L41:
 925  0225 1e2f          	ldw	x,(OFST-9,sp)
 926  0227               L61:
 927  0227 1f2b          	ldw	(OFST-13,sp),x
 929                     ; 134 					my_max=my_max>rep?my_max:rep;
 931  0229 1e31          	ldw	x,(OFST-7,sp)
 932  022b cd0000        	call	c_uitolx
 934  022e 96            	ldw	x,sp
 935  022f 1c002d        	addw	x,#OFST-11
 936  0232 cd0000        	call	c_lcmp
 938  0235 2304          	jrule	L02
 939  0237 1e31          	ldw	x,(OFST-7,sp)
 940  0239 2002          	jra	L22
 941  023b               L02:
 942  023b 1e2f          	ldw	x,(OFST-9,sp)
 943  023d               L22:
 944  023d 1f31          	ldw	(OFST-7,sp),x
 946                     ; 130 				for(iter=0;iter<1000;iter++)
 948  023f 96            	ldw	x,sp
 949  0240 1c0035        	addw	x,#OFST-3
 950  0243 a601          	ld	a,#1
 951  0245 cd0000        	call	c_lgadc
 956  0248 96            	ldw	x,sp
 957  0249 1c0035        	addw	x,#OFST-3
 958  024c cd0000        	call	c_ltor
 960  024f ae0018        	ldw	x,#L42
 961  0252 cd0000        	call	c_lcmp
 963  0255 25ad          	jrult	L153
 964                     ; 136 				Serial_print_string("adc: ");
 966  0257 ae0126        	ldw	x,#L753
 967  025a cd0ab4        	call	_Serial_print_string
 969                     ; 137 				Serial_print_int(rep);
 971  025d 1e2f          	ldw	x,(OFST-9,sp)
 972  025f cd0add        	call	_Serial_print_int
 974                     ; 138 				Serial_print_string(", ");
 976  0262 ae0123        	ldw	x,#L163
 977  0265 cd0ab4        	call	_Serial_print_string
 979                     ; 139 				Serial_print_int(my_max-my_min);
 981  0268 1e31          	ldw	x,(OFST-7,sp)
 982  026a 72f02b        	subw	x,(OFST-13,sp)
 983  026d cd0add        	call	_Serial_print_int
 985                     ; 140 				Serial_newline();
 987  0270 cd0b40        	call	_Serial_newline
 989                     ; 141 				for(iter=0;iter<10000;iter++){}
 991  0273 ae0000        	ldw	x,#0
 992  0276 1f37          	ldw	(OFST-1,sp),x
 993  0278 ae0000        	ldw	x,#0
 994  027b 1f35          	ldw	(OFST-3,sp),x
 996  027d               L363:
 999  027d 96            	ldw	x,sp
1000  027e 1c0035        	addw	x,#OFST-3
1001  0281 a601          	ld	a,#1
1002  0283 cd0000        	call	c_lgadc
1007  0286 96            	ldw	x,sp
1008  0287 1c0035        	addw	x,#OFST-3
1009  028a cd0000        	call	c_ltor
1011  028d ae0010        	ldw	x,#L01
1012  0290 cd0000        	call	c_lcmp
1014  0293 25e8          	jrult	L363
1016  0295 ace301e3      	jpf	L543
1017  0299               L56:
1018                     ; 146 			ADC1_DeInit();
1020  0299 cd0000        	call	_ADC1_DeInit
1022                     ; 147 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1022                     ; 148 							 AIN4,
1022                     ; 149 							 ADC1_PRESSEL_FCPU_D2,//D18 
1022                     ; 150 							 ADC1_EXTTRIG_TIM, 
1022                     ; 151 							 DISABLE, 
1022                     ; 152 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1022                     ; 153 							 ADC1_SCHMITTTRIG_ALL, 
1022                     ; 154 							 DISABLE);
1024  029c 4b00          	push	#0
1025  029e 4bff          	push	#255
1026  02a0 4b08          	push	#8
1027  02a2 4b00          	push	#0
1028  02a4 4b00          	push	#0
1029  02a6 4b00          	push	#0
1030  02a8 ae0104        	ldw	x,#260
1031  02ab cd0000        	call	_ADC1_Init
1033  02ae 5b06          	addw	sp,#6
1034                     ; 155 			ADC1_Cmd(ENABLE);
1036  02b0 a601          	ld	a,#1
1037  02b2 cd0000        	call	_ADC1_Cmd
1039  02b5               L173:
1040                     ; 179 				rms=0;
1042  02b5 5f            	clrw	x
1043  02b6 1f33          	ldw	(OFST-5,sp),x
1045                     ; 181 				mean_sum=0;
1047  02b8 ae0000        	ldw	x,#0
1048  02bb 1f29          	ldw	(OFST-15,sp),x
1049  02bd ae0000        	ldw	x,#0
1050  02c0 1f27          	ldw	(OFST-17,sp),x
1052                     ; 182 				mean_low=mean+mean_threshold;
1054  02c2 7b25          	ld	a,(OFST-19,sp)
1055  02c4 5f            	clrw	x
1056  02c5 1b24          	add	a,(OFST-20,sp)
1057  02c7 2401          	jrnc	L62
1058  02c9 5c            	incw	x
1059  02ca               L62:
1060  02ca cd0000        	call	c_itol
1062  02cd 96            	ldw	x,sp
1063  02ce 1c001f        	addw	x,#OFST-25
1064  02d1 cd0000        	call	c_rtol
1067                     ; 183 				mean_high=mean-mean_threshold;
1069  02d4 7b25          	ld	a,(OFST-19,sp)
1070  02d6 5f            	clrw	x
1071  02d7 1024          	sub	a,(OFST-20,sp)
1072  02d9 2401          	jrnc	L03
1073  02db 5a            	decw	x
1074  02dc               L03:
1075  02dc cd0000        	call	c_itol
1077  02df 96            	ldw	x,sp
1078  02e0 1c002d        	addw	x,#OFST-11
1079  02e3 cd0000        	call	c_rtol
1082                     ; 184 				for(iter=0;iter<adc_captures;iter++)
1084  02e6 ae0000        	ldw	x,#0
1085  02e9 1f37          	ldw	(OFST-1,sp),x
1086  02eb ae0000        	ldw	x,#0
1087  02ee 1f35          	ldw	(OFST-3,sp),x
1090  02f0 2058          	jra	L104
1091  02f2               L573:
1092                     ; 187 					ADC1_StartConversion();
1094  02f2 cd0000        	call	_ADC1_StartConversion
1097  02f5               L704:
1098                     ; 188 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1100  02f5 a680          	ld	a,#128
1101  02f7 cd0000        	call	_ADC1_GetFlagStatus
1103  02fa 4d            	tnz	a
1104  02fb 27f8          	jreq	L704
1105                     ; 190 					reading=ADC1->DRL;
1107  02fd c65405        	ld	a,21509
1108  0300 6b26          	ld	(OFST-18,sp),a
1110                     ; 191 					mean_sum += reading;
1112  0302 7b26          	ld	a,(OFST-18,sp)
1113  0304 96            	ldw	x,sp
1114  0305 1c0027        	addw	x,#OFST-17
1115  0308 cd0000        	call	c_lgadc
1118                     ; 192 					rms+=reading>mean_low || reading<mean_high;
1120  030b 7b26          	ld	a,(OFST-18,sp)
1121  030d b703          	ld	c_lreg+3,a
1122  030f 3f02          	clr	c_lreg+2
1123  0311 3f01          	clr	c_lreg+1
1124  0313 3f00          	clr	c_lreg
1125  0315 96            	ldw	x,sp
1126  0316 1c001f        	addw	x,#OFST-25
1127  0319 cd0000        	call	c_lcmp
1129  031c 2213          	jrugt	L43
1130  031e 7b26          	ld	a,(OFST-18,sp)
1131  0320 b703          	ld	c_lreg+3,a
1132  0322 3f02          	clr	c_lreg+2
1133  0324 3f01          	clr	c_lreg+1
1134  0326 3f00          	clr	c_lreg
1135  0328 96            	ldw	x,sp
1136  0329 1c002d        	addw	x,#OFST-11
1137  032c cd0000        	call	c_lcmp
1139  032f 2405          	jruge	L23
1140  0331               L43:
1141  0331 ae0001        	ldw	x,#1
1142  0334 2001          	jra	L63
1143  0336               L23:
1144  0336 5f            	clrw	x
1145  0337               L63:
1146  0337 72fb33        	addw	x,(OFST-5,sp)
1147  033a 1f33          	ldw	(OFST-5,sp),x
1149                     ; 196 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1151  033c a680          	ld	a,#128
1152  033e cd0000        	call	_ADC1_ClearFlag
1154                     ; 184 				for(iter=0;iter<adc_captures;iter++)
1156  0341 96            	ldw	x,sp
1157  0342 1c0035        	addw	x,#OFST-3
1158  0345 a601          	ld	a,#1
1159  0347 cd0000        	call	c_lgadc
1162  034a               L104:
1165  034a 96            	ldw	x,sp
1166  034b 1c0035        	addw	x,#OFST-3
1167  034e cd0000        	call	c_ltor
1169  0351 96            	ldw	x,sp
1170  0352 1c0019        	addw	x,#OFST-31
1171  0355 cd0000        	call	c_lcmp
1173  0358 2598          	jrult	L573
1174                     ; 200 				if(rms>9) mean_threshold++;
1176  035a 1e33          	ldw	x,(OFST-5,sp)
1177  035c a3000a        	cpw	x,#10
1178  035f 2502          	jrult	L314
1181  0361 0c24          	inc	(OFST-20,sp)
1183  0363               L314:
1184                     ; 201 				if(rms==0) mean_threshold--;
1186  0363 1e33          	ldw	x,(OFST-5,sp)
1187  0365 2602          	jrne	L514
1190  0367 0a24          	dec	(OFST-20,sp)
1192  0369               L514:
1193                     ; 202 				mean=(mean_sum)/(adc_captures);
1195  0369 96            	ldw	x,sp
1196  036a 1c0027        	addw	x,#OFST-17
1197  036d cd0000        	call	c_ltor
1199  0370 96            	ldw	x,sp
1200  0371 1c0019        	addw	x,#OFST-31
1201  0374 cd0000        	call	c_ludv
1203  0377 b603          	ld	a,c_lreg+3
1204  0379 6b25          	ld	(OFST-19,sp),a
1206                     ; 203 				if(sound_level/32<mean_threshold) sound_level++;
1208  037b 1e31          	ldw	x,(OFST-7,sp)
1209  037d 54            	srlw	x
1210  037e 54            	srlw	x
1211  037f 54            	srlw	x
1212  0380 54            	srlw	x
1213  0381 54            	srlw	x
1214  0382 7b24          	ld	a,(OFST-20,sp)
1215  0384 905f          	clrw	y
1216  0386 9097          	ld	yl,a
1217  0388 90bf00        	ldw	c_y,y
1218  038b b300          	cpw	x,c_y
1219  038d 2407          	jruge	L714
1222  038f 1e31          	ldw	x,(OFST-7,sp)
1223  0391 1c0001        	addw	x,#1
1224  0394 1f31          	ldw	(OFST-7,sp),x
1226  0396               L714:
1227                     ; 204 				if(sound_level/32>mean_threshold) sound_level--;
1229  0396 1e31          	ldw	x,(OFST-7,sp)
1230  0398 54            	srlw	x
1231  0399 54            	srlw	x
1232  039a 54            	srlw	x
1233  039b 54            	srlw	x
1234  039c 54            	srlw	x
1235  039d 7b24          	ld	a,(OFST-20,sp)
1236  039f 905f          	clrw	y
1237  03a1 9097          	ld	yl,a
1238  03a3 90bf00        	ldw	c_y,y
1239  03a6 b300          	cpw	x,c_y
1240  03a8 2307          	jrule	L124
1243  03aa 1e31          	ldw	x,(OFST-7,sp)
1244  03ac 1d0001        	subw	x,#1
1245  03af 1f31          	ldw	(OFST-7,sp),x
1247  03b1               L124:
1248                     ; 205 				if(debug%4==0)
1250  03b1 1e2b          	ldw	x,(OFST-13,sp)
1251  03b3 a604          	ld	a,#4
1252  03b5 cd0000        	call	c_smodx
1254  03b8 a30000        	cpw	x,#0
1255  03bb 267b          	jrne	L324
1256                     ; 207 					Serial_print_string("adc: ");
1258  03bd ae0126        	ldw	x,#L753
1259  03c0 cd0ab4        	call	_Serial_print_string
1261                     ; 208 					Serial_print_int(mean);
1263  03c3 7b25          	ld	a,(OFST-19,sp)
1264  03c5 5f            	clrw	x
1265  03c6 97            	ld	xl,a
1266  03c7 cd0add        	call	_Serial_print_int
1268                     ; 209 					Serial_print_string(", ");
1270  03ca ae0123        	ldw	x,#L163
1271  03cd cd0ab4        	call	_Serial_print_string
1273                     ; 210 					if(rms<9) Serial_print_string("0");
1275  03d0 1e33          	ldw	x,(OFST-5,sp)
1276  03d2 a30009        	cpw	x,#9
1277  03d5 2406          	jruge	L524
1280  03d7 ae0121        	ldw	x,#L724
1281  03da cd0ab4        	call	_Serial_print_string
1283  03dd               L524:
1284                     ; 211 					if(rms==0) Serial_print_string("0");
1286  03dd 1e33          	ldw	x,(OFST-5,sp)
1287  03df 2606          	jrne	L134
1290  03e1 ae0121        	ldw	x,#L724
1291  03e4 cd0ab4        	call	_Serial_print_string
1293  03e7               L134:
1294                     ; 212 					Serial_print_int(rms);
1296  03e7 1e33          	ldw	x,(OFST-5,sp)
1297  03e9 cd0add        	call	_Serial_print_int
1299                     ; 213 					Serial_print_string(", ");
1301  03ec ae0123        	ldw	x,#L163
1302  03ef cd0ab4        	call	_Serial_print_string
1304                     ; 214 					if(mean_threshold<9) Serial_print_string("0");
1306  03f2 7b24          	ld	a,(OFST-20,sp)
1307  03f4 a109          	cp	a,#9
1308  03f6 2406          	jruge	L334
1311  03f8 ae0121        	ldw	x,#L724
1312  03fb cd0ab4        	call	_Serial_print_string
1314  03fe               L334:
1315                     ; 215 					Serial_print_int(mean_threshold);
1317  03fe 7b24          	ld	a,(OFST-20,sp)
1318  0400 5f            	clrw	x
1319  0401 97            	ld	xl,a
1320  0402 cd0add        	call	_Serial_print_int
1322                     ; 216 					Serial_print_string(", ");
1324  0405 ae0123        	ldw	x,#L163
1325  0408 cd0ab4        	call	_Serial_print_string
1327                     ; 217 					if(sound_level/8<9) Serial_print_string("0");
1329  040b 1e31          	ldw	x,(OFST-7,sp)
1330  040d 54            	srlw	x
1331  040e 54            	srlw	x
1332  040f 54            	srlw	x
1333  0410 a30009        	cpw	x,#9
1334  0413 2406          	jruge	L534
1337  0415 ae0121        	ldw	x,#L724
1338  0418 cd0ab4        	call	_Serial_print_string
1340  041b               L534:
1341                     ; 218 					Serial_print_int(sound_level/8);
1343  041b 1e31          	ldw	x,(OFST-7,sp)
1344  041d 54            	srlw	x
1345  041e 54            	srlw	x
1346  041f 54            	srlw	x
1347  0420 cd0add        	call	_Serial_print_int
1349                     ; 219 					if(debug%10==0) Serial_print_string("*");
1351  0423 1e2b          	ldw	x,(OFST-13,sp)
1352  0425 a60a          	ld	a,#10
1353  0427 cd0000        	call	c_smodx
1355  042a a30000        	cpw	x,#0
1356  042d 2606          	jrne	L734
1359  042f ae011f        	ldw	x,#L144
1360  0432 cd0ab4        	call	_Serial_print_string
1362  0435               L734:
1363                     ; 220 					Serial_newline();
1365  0435 cd0b40        	call	_Serial_newline
1367  0438               L324:
1368                     ; 222 				if(mean_threshold>10)
1370  0438 7b24          	ld	a,(OFST-20,sp)
1371  043a a10b          	cp	a,#11
1372  043c 2518          	jrult	L344
1373                     ; 226 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1375  043e 4bd0          	push	#208
1376  0440 4b08          	push	#8
1377  0442 ae500a        	ldw	x,#20490
1378  0445 cd0000        	call	_GPIO_Init
1380  0448 85            	popw	x
1381                     ; 227 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1383  0449 4bc0          	push	#192
1384  044b 4b20          	push	#32
1385  044d ae500a        	ldw	x,#20490
1386  0450 cd0000        	call	_GPIO_Init
1388  0453 85            	popw	x
1390  0454 2016          	jra	L544
1391  0456               L344:
1392                     ; 229 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1394  0456 4bd0          	push	#208
1395  0458 4b10          	push	#16
1396  045a ae500a        	ldw	x,#20490
1397  045d cd0000        	call	_GPIO_Init
1399  0460 85            	popw	x
1400                     ; 230 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1402  0461 4bc0          	push	#192
1403  0463 4b40          	push	#64
1404  0465 ae500a        	ldw	x,#20490
1405  0468 cd0000        	call	_GPIO_Init
1407  046b 85            	popw	x
1408  046c               L544:
1409                     ; 232 			for(iter=0;iter<10;iter++){}
1411  046c ae0000        	ldw	x,#0
1412  046f 1f37          	ldw	(OFST-1,sp),x
1413  0471 ae0000        	ldw	x,#0
1414  0474 1f35          	ldw	(OFST-3,sp),x
1416  0476               L744:
1419  0476 96            	ldw	x,sp
1420  0477 1c0035        	addw	x,#OFST-3
1421  047a a601          	ld	a,#1
1422  047c cd0000        	call	c_lgadc
1427  047f 96            	ldw	x,sp
1428  0480 1c0035        	addw	x,#OFST-3
1429  0483 cd0000        	call	c_ltor
1431  0486 ae001c        	ldw	x,#L04
1432  0489 cd0000        	call	c_lcmp
1434  048c 25e8          	jrult	L744
1435                     ; 233 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1437  048e 4b00          	push	#0
1438  0490 4bf8          	push	#248
1439  0492 ae500a        	ldw	x,#20490
1440  0495 cd0000        	call	_GPIO_Init
1442  0498 85            	popw	x
1443                     ; 234 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1445  0499 4b00          	push	#0
1446  049b 4b04          	push	#4
1447  049d ae500f        	ldw	x,#20495
1448  04a0 cd0000        	call	_GPIO_Init
1450  04a3 85            	popw	x
1451                     ; 236 				debug++;
1453  04a4 1e2b          	ldw	x,(OFST-13,sp)
1454  04a6 1c0001        	addw	x,#1
1455  04a9 1f2b          	ldw	(OFST-13,sp),x
1458  04ab acb502b5      	jpf	L173
1459  04af               L76:
1460                     ; 242 			ADC1_DeInit();
1462  04af cd0000        	call	_ADC1_DeInit
1464                     ; 243 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1464                     ; 244 							 AIN4,
1464                     ; 245 							 ADC1_PRESSEL_FCPU_D2,//D18 
1464                     ; 246 							 ADC1_EXTTRIG_TIM, 
1464                     ; 247 							 DISABLE, 
1464                     ; 248 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1464                     ; 249 							 ADC1_SCHMITTTRIG_ALL, 
1464                     ; 250 							 DISABLE);
1466  04b2 4b00          	push	#0
1467  04b4 4bff          	push	#255
1468  04b6 4b08          	push	#8
1469  04b8 4b00          	push	#0
1470  04ba 4b00          	push	#0
1471  04bc 4b00          	push	#0
1472  04be ae0104        	ldw	x,#260
1473  04c1 cd0000        	call	_ADC1_Init
1475  04c4 5b06          	addw	sp,#6
1476                     ; 251 			ADC1_Cmd(ENABLE);
1478  04c6 a601          	ld	a,#1
1479  04c8 cd0000        	call	_ADC1_Cmd
1481  04cb               L554:
1482                     ; 254 				debug++;
1484  04cb 1e2b          	ldw	x,(OFST-13,sp)
1485  04cd 1c0001        	addw	x,#1
1486  04d0 1f2b          	ldw	(OFST-13,sp),x
1488                     ; 255 				rms=0;//8 bit
1490  04d2 5f            	clrw	x
1491  04d3 1f33          	ldw	(OFST-5,sp),x
1493                     ; 257 				mean_sum=0;//16 bit
1495  04d5 ae0000        	ldw	x,#0
1496  04d8 1f29          	ldw	(OFST-15,sp),x
1497  04da ae0000        	ldw	x,#0
1498  04dd 1f27          	ldw	(OFST-17,sp),x
1500                     ; 260 				iter=0;
1502  04df ae0000        	ldw	x,#0
1503  04e2 1f37          	ldw	(OFST-1,sp),x
1504  04e4 ae0000        	ldw	x,#0
1505  04e7 1f35          	ldw	(OFST-3,sp),x
1507  04e9               L164:
1508                     ; 263 					ADC1_StartConversion();
1510  04e9 cd0000        	call	_ADC1_StartConversion
1513  04ec               L174:
1514                     ; 264 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1516  04ec a680          	ld	a,#128
1517  04ee cd0000        	call	_ADC1_GetFlagStatus
1519  04f1 4d            	tnz	a
1520  04f2 27f8          	jreq	L174
1521                     ; 266 					reading=ADC1->DRL;
1523  04f4 c65405        	ld	a,21509
1524  04f7 6b26          	ld	(OFST-18,sp),a
1526                     ; 267 					mean_sum += reading;
1528  04f9 7b26          	ld	a,(OFST-18,sp)
1529  04fb 96            	ldw	x,sp
1530  04fc 1c0027        	addw	x,#OFST-17
1531  04ff cd0000        	call	c_lgadc
1534                     ; 269 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1536  0502 7b26          	ld	a,(OFST-18,sp)
1537  0504 1125          	cp	a,(OFST-19,sp)
1538  0506 2306          	jrule	L24
1539  0508 7b26          	ld	a,(OFST-18,sp)
1540  050a 1025          	sub	a,(OFST-19,sp)
1541  050c 2004          	jra	L44
1542  050e               L24:
1543  050e 7b25          	ld	a,(OFST-19,sp)
1544  0510 1026          	sub	a,(OFST-18,sp)
1545  0512               L44:
1546  0512 6b24          	ld	(OFST-20,sp),a
1548                     ; 270 					rms+=mean_diff>mean_threshold_8;
1550  0514 7b24          	ld	a,(OFST-20,sp)
1551  0516 1123          	cp	a,(OFST-21,sp)
1552  0518 2305          	jrule	L64
1553  051a ae0001        	ldw	x,#1
1554  051d 2001          	jra	L05
1555  051f               L64:
1556  051f 5f            	clrw	x
1557  0520               L05:
1558  0520 72fb33        	addw	x,(OFST-5,sp)
1559  0523 1f33          	ldw	(OFST-5,sp),x
1561                     ; 272 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1563  0525 a680          	ld	a,#128
1564  0527 cd0000        	call	_ADC1_ClearFlag
1566                     ; 275 					iter++;
1568  052a 96            	ldw	x,sp
1569  052b 1c0035        	addw	x,#OFST-3
1570  052e a601          	ld	a,#1
1571  0530 cd0000        	call	c_lgadc
1574                     ; 276 					iter%=256;//8 bit unsigned
1576  0533 0f37          	clr	(OFST-1,sp)
1577  0535 0f36          	clr	(OFST-2,sp)
1578  0537 0f35          	clr	(OFST-3,sp)
1580                     ; 277 				}while(iter!=0);//run 255 times
1582  0539 96            	ldw	x,sp
1583  053a 1c0035        	addw	x,#OFST-3
1584  053d cd0000        	call	c_lzmp
1586  0540 26a7          	jrne	L164
1587                     ; 278 				mean=((uint16_t)mean+mean_sum/256)/2;
1589  0542 96            	ldw	x,sp
1590  0543 1c0027        	addw	x,#OFST-17
1591  0546 cd0000        	call	c_ltor
1593  0549 a608          	ld	a,#8
1594  054b cd0000        	call	c_lursh
1596  054e 96            	ldw	x,sp
1597  054f 1c0001        	addw	x,#OFST-55
1598  0552 cd0000        	call	c_rtol
1601  0555 7b25          	ld	a,(OFST-19,sp)
1602  0557 b703          	ld	c_lreg+3,a
1603  0559 3f02          	clr	c_lreg+2
1604  055b 3f01          	clr	c_lreg+1
1605  055d 3f00          	clr	c_lreg
1606  055f 96            	ldw	x,sp
1607  0560 1c0001        	addw	x,#OFST-55
1608  0563 cd0000        	call	c_ladd
1610  0566 3400          	srl	c_lreg
1611  0568 3601          	rrc	c_lreg+1
1612  056a 3602          	rrc	c_lreg+2
1613  056c 3603          	rrc	c_lreg+3
1614  056e b603          	ld	a,c_lreg+3
1615  0570 6b25          	ld	(OFST-19,sp),a
1617                     ; 279 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1619  0572 96            	ldw	x,sp
1620  0573 1c0009        	addw	x,#OFST-47
1621  0576 1f03          	ldw	(OFST-53,sp),x
1623  0578 1e33          	ldw	x,(OFST-5,sp)
1624  057a 54            	srlw	x
1625  057b 54            	srlw	x
1626  057c 54            	srlw	x
1627  057d 54            	srlw	x
1628  057e 72fb03        	addw	x,(OFST-53,sp)
1629  0581 f6            	ld	a,(x)
1630  0582 5f            	clrw	x
1631  0583 97            	ld	xl,a
1632  0584 161d          	ldw	y,(OFST-27,sp)
1633  0586 cd0000        	call	c_imul
1635  0589 54            	srlw	x
1636  058a 54            	srlw	x
1637  058b 54            	srlw	x
1638  058c 54            	srlw	x
1639  058d 54            	srlw	x
1640  058e 72fb1d        	addw	x,(OFST-27,sp)
1641  0591 54            	srlw	x
1642  0592 1f1d          	ldw	(OFST-27,sp),x
1644                     ; 280 				mean_threshold_8=mean_threshold_16/256;
1646  0594 7b1d          	ld	a,(OFST-27,sp)
1647  0596 6b23          	ld	(OFST-21,sp),a
1649                     ; 281 				if(mean_threshold_8==0)
1651  0598 0d23          	tnz	(OFST-21,sp)
1652  059a 2609          	jrne	L574
1653                     ; 283 					mean_threshold_8=1;
1655  059c a601          	ld	a,#1
1656  059e 6b23          	ld	(OFST-21,sp),a
1658                     ; 284 					mean_threshold_16=0x0100;
1660  05a0 ae0100        	ldw	x,#256
1661  05a3 1f1d          	ldw	(OFST-27,sp),x
1663  05a5               L574:
1664                     ; 289 					if(mean==0) Serial_print_string("0");
1666  05a5 0d25          	tnz	(OFST-19,sp)
1667  05a7 2606          	jrne	L774
1670  05a9 ae0121        	ldw	x,#L724
1671  05ac cd0ab4        	call	_Serial_print_string
1673  05af               L774:
1674                     ; 290 					Serial_print_int(mean);
1676  05af 7b25          	ld	a,(OFST-19,sp)
1677  05b1 5f            	clrw	x
1678  05b2 97            	ld	xl,a
1679  05b3 cd0add        	call	_Serial_print_int
1681                     ; 292 					Serial_print_string(" ");
1683  05b6 ae011d        	ldw	x,#L105
1684  05b9 cd0ab4        	call	_Serial_print_string
1686                     ; 295 					if(rms==0) Serial_print_string("0");
1688  05bc 1e33          	ldw	x,(OFST-5,sp)
1689  05be 2606          	jrne	L305
1692  05c0 ae0121        	ldw	x,#L724
1693  05c3 cd0ab4        	call	_Serial_print_string
1695  05c6               L305:
1696                     ; 296 					Serial_print_int(rms);
1698  05c6 1e33          	ldw	x,(OFST-5,sp)
1699  05c8 cd0add        	call	_Serial_print_int
1701                     ; 298 					Serial_print_string(" ");
1703  05cb ae011d        	ldw	x,#L105
1704  05ce cd0ab4        	call	_Serial_print_string
1706                     ; 299 					if(mean_threshold_8==0) Serial_print_string("0");
1708  05d1 0d23          	tnz	(OFST-21,sp)
1709  05d3 2606          	jrne	L505
1712  05d5 ae0121        	ldw	x,#L724
1713  05d8 cd0ab4        	call	_Serial_print_string
1715  05db               L505:
1716                     ; 300 					Serial_print_int(mean_threshold_8);
1718  05db 7b23          	ld	a,(OFST-21,sp)
1719  05dd 5f            	clrw	x
1720  05de 97            	ld	xl,a
1721  05df cd0add        	call	_Serial_print_int
1723                     ; 302 					Serial_newline();
1725  05e2 cd0b40        	call	_Serial_newline
1728  05e5 accb04cb      	jpf	L554
1729  05e9               L17:
1730                     ; 308 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1732  05e9 4b40          	push	#64
1733  05eb 4b20          	push	#32
1734  05ed ae500f        	ldw	x,#20495
1735  05f0 cd0000        	call	_GPIO_Init
1737  05f3 85            	popw	x
1738                     ; 309 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1740  05f4 4b40          	push	#64
1741  05f6 4b40          	push	#64
1742  05f8 ae500f        	ldw	x,#20495
1743  05fb cd0000        	call	_GPIO_Init
1745  05fe 85            	popw	x
1746  05ff               L705:
1747                     ; 312 			  setMatrixHighZ();
1749  05ff cd0b4f        	call	_setMatrixHighZ
1751                     ; 313 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1753  0602 4b20          	push	#32
1754  0604 ae500f        	ldw	x,#20495
1755  0607 cd0000        	call	_GPIO_ReadInputPin
1757  060a 5b01          	addw	sp,#1
1758  060c 4d            	tnz	a
1759  060d 2618          	jrne	L315
1760                     ; 317 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1762  060f 4bd0          	push	#208
1763  0611 4b08          	push	#8
1764  0613 ae500a        	ldw	x,#20490
1765  0616 cd0000        	call	_GPIO_Init
1767  0619 85            	popw	x
1768                     ; 318 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1770  061a 4bc0          	push	#192
1771  061c 4b20          	push	#32
1772  061e ae500a        	ldw	x,#20490
1773  0621 cd0000        	call	_GPIO_Init
1775  0624 85            	popw	x
1777  0625 20d8          	jra	L705
1778  0627               L315:
1779                     ; 319 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1781  0627 4b40          	push	#64
1782  0629 ae500f        	ldw	x,#20495
1783  062c cd0000        	call	_GPIO_ReadInputPin
1785  062f 5b01          	addw	sp,#1
1786  0631 4d            	tnz	a
1787  0632 26cb          	jrne	L705
1788                     ; 320 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1790  0634 4bd0          	push	#208
1791  0636 4b10          	push	#16
1792  0638 ae500a        	ldw	x,#20490
1793  063b cd0000        	call	_GPIO_Init
1795  063e 85            	popw	x
1796                     ; 321 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1798  063f 4bc0          	push	#192
1799  0641 4b40          	push	#64
1800  0643 ae500a        	ldw	x,#20490
1801  0646 cd0000        	call	_GPIO_Init
1803  0649 85            	popw	x
1804  064a 20b3          	jra	L705
1805  064c               L37:
1806                     ; 327 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1808  064c c650c6        	ld	a,20678
1809  064f a4e7          	and	a,#231
1810  0651 c750c6        	ld	20678,a
1811                     ; 329 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1813  0654 4bf0          	push	#240
1814  0656 4b20          	push	#32
1815  0658 ae500f        	ldw	x,#20495
1816  065b cd0000        	call	_GPIO_Init
1818  065e 85            	popw	x
1819                     ; 330 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1821  065f 4b40          	push	#64
1822  0661 4b40          	push	#64
1823  0663 ae500f        	ldw	x,#20495
1824  0666 cd0000        	call	_GPIO_Init
1826  0669 85            	popw	x
1827                     ; 331 			UART1_DeInit();
1829  066a cd0000        	call	_UART1_DeInit
1831                     ; 332 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1833  066d 4b0c          	push	#12
1834  066f 4b80          	push	#128
1835  0671 4b00          	push	#0
1836  0673 4b00          	push	#0
1837  0675 4b00          	push	#0
1838  0677 ae4240        	ldw	x,#16960
1839  067a 89            	pushw	x
1840  067b ae000f        	ldw	x,#15
1841  067e 89            	pushw	x
1842  067f cd0000        	call	_UART1_Init
1844  0682 5b09          	addw	sp,#9
1845                     ; 334 			UART1_Cmd(ENABLE);
1847  0684 a601          	ld	a,#1
1848  0686 cd0000        	call	_UART1_Cmd
1850                     ; 336 			Serial_print_string("Mode: ");
1852  0689 ae0116        	ldw	x,#L125
1853  068c cd0ab4        	call	_Serial_print_string
1855                     ; 337 			Serial_print_int(test_mode);
1857  068f 1e33          	ldw	x,(OFST-5,sp)
1858  0691 cd0add        	call	_Serial_print_int
1860                     ; 338 			Serial_newline();
1862  0694 cd0b40        	call	_Serial_newline
1864                     ; 341 			Serial_print_string("Params v2: ");
1866  0697 ae010a        	ldw	x,#L325
1867  069a cd0ab4        	call	_Serial_print_string
1869                     ; 348 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1871  069d c650c6        	ld	a,20678
1872  06a0 5f            	clrw	x
1873  06a1 97            	ld	xl,a
1874  06a2 cd0add        	call	_Serial_print_int
1876                     ; 349 			Serial_print_string(" ");
1878  06a5 ae011d        	ldw	x,#L105
1879  06a8 cd0ab4        	call	_Serial_print_string
1881                     ; 350 			Serial_print_int(CLK->CCOR);//0
1883  06ab c650c9        	ld	a,20681
1884  06ae 5f            	clrw	x
1885  06af 97            	ld	xl,a
1886  06b0 cd0add        	call	_Serial_print_int
1888                     ; 351 			Serial_newline();
1890  06b3 cd0b40        	call	_Serial_newline
1892                     ; 353 			TIM4->PSCR= 7;// init divider register /128	
1894  06b6 35075347      	mov	21319,#7
1895                     ; 354 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1897  06ba 357d5348      	mov	21320,#125
1898                     ; 355 			TIM4->EGR= TIM4_EGR_UG;// update registers
1900  06be 35015345      	mov	21317,#1
1901                     ; 356 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1903  06c2 c65340        	ld	a,21312
1904  06c5 aa85          	or	a,#133
1905  06c7 c75340        	ld	21312,a
1906                     ; 357 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1908  06ca 35015343      	mov	21315,#1
1909                     ; 358 			enableInterrupts();
1912  06ce 9a            rim
1914  06cf               L525:
1915                     ; 361 				if(tms%1000==0 && mean_sum!=tms/1000)
1917  06cf ae0000        	ldw	x,#_tms
1918  06d2 cd0000        	call	c_ltor
1920  06d5 ae0018        	ldw	x,#L42
1921  06d8 cd0000        	call	c_lumd
1923  06db cd0000        	call	c_lrzmp
1925  06de 2642          	jrne	L135
1927  06e0 ae0000        	ldw	x,#_tms
1928  06e3 cd0000        	call	c_ltor
1930  06e6 ae0018        	ldw	x,#L42
1931  06e9 cd0000        	call	c_ludv
1933  06ec 96            	ldw	x,sp
1934  06ed 1c0027        	addw	x,#OFST-17
1935  06f0 cd0000        	call	c_lcmp
1937  06f3 272d          	jreq	L135
1938                     ; 363 					Serial_print_string("time: ");
1940  06f5 ae0103        	ldw	x,#L335
1941  06f8 cd0ab4        	call	_Serial_print_string
1943                     ; 364 					mean_sum=tms/1000;
1945  06fb ae0000        	ldw	x,#_tms
1946  06fe cd0000        	call	c_ltor
1948  0701 ae0018        	ldw	x,#L42
1949  0704 cd0000        	call	c_ludv
1951  0707 96            	ldw	x,sp
1952  0708 1c0027        	addw	x,#OFST-17
1953  070b cd0000        	call	c_rtol
1956                     ; 365 					Serial_print_int(tms/1000);
1958  070e ae0000        	ldw	x,#_tms
1959  0711 cd0000        	call	c_ltor
1961  0714 ae0018        	ldw	x,#L42
1962  0717 cd0000        	call	c_ludv
1964  071a be02          	ldw	x,c_lreg+2
1965  071c cd0add        	call	_Serial_print_int
1967                     ; 366 					Serial_newline();
1969  071f cd0b40        	call	_Serial_newline
1971  0722               L135:
1972                     ; 374 				setMatrixHighZ();
1974  0722 cd0b4f        	call	_setMatrixHighZ
1976                     ; 375 				mean_low=tms%20;
1978  0725 ae0000        	ldw	x,#_tms
1979  0728 cd0000        	call	c_ltor
1981  072b ae0020        	ldw	x,#L25
1982  072e cd0000        	call	c_lumd
1984  0731 96            	ldw	x,sp
1985  0732 1c001f        	addw	x,#OFST-25
1986  0735 cd0000        	call	c_rtol
1989                     ; 376 				mean_high=(tms/20)%100;
1991  0738 ae0000        	ldw	x,#_tms
1992  073b cd0000        	call	c_ltor
1994  073e ae0020        	ldw	x,#L25
1995  0741 cd0000        	call	c_ludv
1997  0744 ae0024        	ldw	x,#L45
1998  0747 cd0000        	call	c_lumd
2000  074a 96            	ldw	x,sp
2001  074b 1c002d        	addw	x,#OFST-11
2002  074e cd0000        	call	c_rtol
2005                     ; 377 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
2007  0751 ae0000        	ldw	x,#_tms
2008  0754 cd0000        	call	c_ltor
2010  0757 ae0028        	ldw	x,#L65
2011  075a cd0000        	call	c_ludv
2013  075d b603          	ld	a,c_lreg+3
2014  075f a401          	and	a,#1
2015  0761 b703          	ld	c_lreg+3,a
2016  0763 3f02          	clr	c_lreg+2
2017  0765 3f01          	clr	c_lreg+1
2018  0767 3f00          	clr	c_lreg
2019  0769 96            	ldw	x,sp
2020  076a 1c0001        	addw	x,#OFST-55
2021  076d cd0000        	call	c_rtol
2024  0770 96            	ldw	x,sp
2025  0771 1c002d        	addw	x,#OFST-11
2026  0774 cd0000        	call	c_ltor
2028  0777 a602          	ld	a,#2
2029  0779 cd0000        	call	c_lursh
2031  077c 96            	ldw	x,sp
2032  077d 1c001f        	addw	x,#OFST-25
2033  0780 cd0000        	call	c_lcmp
2035  0783 2405          	jruge	L06
2036  0785 ae0001        	ldw	x,#1
2037  0788 2001          	jra	L26
2038  078a               L06:
2039  078a 5f            	clrw	x
2040  078b               L26:
2041  078b cd0000        	call	c_itolx
2043  078e 96            	ldw	x,sp
2044  078f 1c0001        	addw	x,#OFST-55
2045  0792 cd0000        	call	c_lxor
2047  0795 cd0000        	call	c_lrzmp
2049  0798 270f          	jreq	L535
2050                     ; 379 					setRGB(4,1);
2052  079a ae0001        	ldw	x,#1
2053  079d 89            	pushw	x
2054  079e ae0004        	ldw	x,#4
2055  07a1 cd0b66        	call	_setRGB
2057  07a4 85            	popw	x
2059  07a5 accf06cf      	jpf	L525
2060  07a9               L535:
2061                     ; 382 					setRGB(4,0);
2063  07a9 5f            	clrw	x
2064  07aa 89            	pushw	x
2065  07ab ae0004        	ldw	x,#4
2066  07ae cd0b66        	call	_setRGB
2068  07b1 85            	popw	x
2069  07b2 accf06cf      	jpf	L525
2070  07b6               L57:
2071                     ; 388 			Serial_print_string("Mode: ");
2073  07b6 ae0116        	ldw	x,#L125
2074  07b9 cd0ab4        	call	_Serial_print_string
2076                     ; 389 			Serial_print_int(test_mode);
2078  07bc 1e33          	ldw	x,(OFST-5,sp)
2079  07be cd0add        	call	_Serial_print_int
2081                     ; 390 			Serial_newline();
2083  07c1 cd0b40        	call	_Serial_newline
2085                     ; 394 			Serial_print_string("Params: ");
2087  07c4 ae00fa        	ldw	x,#L145
2088  07c7 cd0ab4        	call	_Serial_print_string
2090                     ; 395 			Serial_print_int(CLK->CKDIVR);//
2092  07ca c650c6        	ld	a,20678
2093  07cd 5f            	clrw	x
2094  07ce 97            	ld	xl,a
2095  07cf cd0add        	call	_Serial_print_int
2097                     ; 396 			Serial_print_string(" ");
2099  07d2 ae011d        	ldw	x,#L105
2100  07d5 cd0ab4        	call	_Serial_print_string
2102                     ; 397 			Serial_print_int(CLK->CCOR);//
2104  07d8 c650c9        	ld	a,20681
2105  07db 5f            	clrw	x
2106  07dc 97            	ld	xl,a
2107  07dd cd0add        	call	_Serial_print_int
2109                     ; 398 			Serial_newline();
2111  07e0 cd0b40        	call	_Serial_newline
2113                     ; 400 			TIM4->PSCR= 7;// init divider register /128	
2115  07e3 35075347      	mov	21319,#7
2116                     ; 401 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2118  07e7 35805348      	mov	21320,#128
2119                     ; 402 			TIM4->EGR= TIM4_EGR_UG;// update registers
2121  07eb 35015345      	mov	21317,#1
2122                     ; 403 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2124  07ef c65340        	ld	a,21312
2125  07f2 aa85          	or	a,#133
2126  07f4 c75340        	ld	21312,a
2127                     ; 404 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2129  07f7 35015343      	mov	21315,#1
2130                     ; 405 			enableInterrupts();
2133  07fb 9a            rim
2135  07fc               L345:
2136                     ; 408 				for(iter=0;iter<5000;iter++){}
2138  07fc ae0000        	ldw	x,#0
2139  07ff 1f37          	ldw	(OFST-1,sp),x
2140  0801 ae0000        	ldw	x,#0
2141  0804 1f35          	ldw	(OFST-3,sp),x
2143  0806               L745:
2146  0806 96            	ldw	x,sp
2147  0807 1c0035        	addw	x,#OFST-3
2148  080a a601          	ld	a,#1
2149  080c cd0000        	call	c_lgadc
2154  080f 96            	ldw	x,sp
2155  0810 1c0035        	addw	x,#OFST-3
2156  0813 cd0000        	call	c_ltor
2158  0816 ae002c        	ldw	x,#L46
2159  0819 cd0000        	call	c_lcmp
2161  081c 25e8          	jrult	L745
2162                     ; 409 				Serial_print_string("time: ");
2164  081e ae0103        	ldw	x,#L335
2165  0821 cd0ab4        	call	_Serial_print_string
2167                     ; 410 				Serial_print_int(tms>>16);
2169  0824 be00          	ldw	x,_tms
2170  0826 cd0add        	call	_Serial_print_int
2172                     ; 411 				Serial_print_string(" ");
2174  0829 ae011d        	ldw	x,#L105
2175  082c cd0ab4        	call	_Serial_print_string
2177                     ; 412 				Serial_print_int((uint16_t)tms);
2179  082f be02          	ldw	x,_tms+2
2180  0831 cd0add        	call	_Serial_print_int
2182                     ; 413 				Serial_newline();
2184  0834 cd0b40        	call	_Serial_newline
2187  0837 20c3          	jra	L345
2188  0839               L77:
2189                     ; 418 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2191  0839 c650c6        	ld	a,20678
2192  083c a4e7          	and	a,#231
2193  083e c750c6        	ld	20678,a
2194                     ; 420 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2196  0841 4bf0          	push	#240
2197  0843 4b20          	push	#32
2198  0845 ae500f        	ldw	x,#20495
2199  0848 cd0000        	call	_GPIO_Init
2201  084b 85            	popw	x
2202                     ; 421 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2204  084c 4b40          	push	#64
2205  084e 4b40          	push	#64
2206  0850 ae500f        	ldw	x,#20495
2207  0853 cd0000        	call	_GPIO_Init
2209  0856 85            	popw	x
2210                     ; 422 			UART1_DeInit();
2212  0857 cd0000        	call	_UART1_DeInit
2214                     ; 423 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2216  085a 4b0c          	push	#12
2217  085c 4b80          	push	#128
2218  085e 4b00          	push	#0
2219  0860 4b00          	push	#0
2220  0862 4b00          	push	#0
2221  0864 ae4240        	ldw	x,#16960
2222  0867 89            	pushw	x
2223  0868 ae000f        	ldw	x,#15
2224  086b 89            	pushw	x
2225  086c cd0000        	call	_UART1_Init
2227  086f 5b09          	addw	sp,#9
2228                     ; 425 			UART1_Cmd(ENABLE);
2230  0871 a601          	ld	a,#1
2231  0873 cd0000        	call	_UART1_Cmd
2233                     ; 427 			Serial_print_string("Mode: ");
2235  0876 ae0116        	ldw	x,#L125
2236  0879 cd0ab4        	call	_Serial_print_string
2238                     ; 428 			Serial_print_int(test_mode);
2240  087c 1e33          	ldw	x,(OFST-5,sp)
2241  087e cd0add        	call	_Serial_print_int
2243                     ; 429 			Serial_newline();
2245  0881 cd0b40        	call	_Serial_newline
2247                     ; 431 			TIM4->PSCR= 7;// init divider register /128	
2249  0884 35075347      	mov	21319,#7
2250                     ; 432 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2252  0888 357d5348      	mov	21320,#125
2253                     ; 433 			TIM4->EGR= TIM4_EGR_UG;// update registers
2255  088c 35015345      	mov	21317,#1
2256                     ; 434 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2258  0890 c65340        	ld	a,21312
2259  0893 aa85          	or	a,#133
2260  0895 c75340        	ld	21312,a
2261                     ; 435 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2263  0898 35015343      	mov	21315,#1
2264                     ; 436 			enableInterrupts();
2267  089c 9a            rim
2269  089d               L555:
2270                     ; 442 					setMatrixHighZ();
2272  089d cd0b4f        	call	_setMatrixHighZ
2274                     ; 443 					mean_sum=tms/60;
2276  08a0 ae0000        	ldw	x,#_tms
2277  08a3 cd0000        	call	c_ltor
2279  08a6 ae0030        	ldw	x,#L66
2280  08a9 cd0000        	call	c_ludv
2282  08ac 96            	ldw	x,sp
2283  08ad 1c0027        	addw	x,#OFST-17
2284  08b0 cd0000        	call	c_rtol
2287                     ; 444 					mean_low=tms%2;//is high or low charlieplexing
2289  08b3 b603          	ld	a,_tms+3
2290  08b5 a401          	and	a,#1
2291  08b7 6b22          	ld	(OFST-22,sp),a
2292  08b9 4f            	clr	a
2293  08ba 6b21          	ld	(OFST-23,sp),a
2294  08bc 6b20          	ld	(OFST-24,sp),a
2295  08be 6b1f          	ld	(OFST-25,sp),a
2297                     ; 445 					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
2299  08c0 96            	ldw	x,sp
2300  08c1 1c0027        	addw	x,#OFST-17
2301  08c4 cd0000        	call	c_ltor
2303  08c7 3400          	srl	c_lreg
2304  08c9 3601          	rrc	c_lreg+1
2305  08cb 3602          	rrc	c_lreg+2
2306  08cd 3603          	rrc	c_lreg+3
2307  08cf ae0034        	ldw	x,#L07
2308  08d2 cd0000        	call	c_lumd
2310  08d5 96            	ldw	x,sp
2311  08d6 1c002d        	addw	x,#OFST-11
2312  08d9 cd0000        	call	c_rtol
2315                     ; 446 					sound_level=(mean_sum/10)%3;//RGB
2317  08dc 96            	ldw	x,sp
2318  08dd 1c0027        	addw	x,#OFST-17
2319  08e0 cd0000        	call	c_ltor
2321  08e3 ae001c        	ldw	x,#L04
2322  08e6 cd0000        	call	c_ludv
2324  08e9 ae0038        	ldw	x,#L27
2325  08ec cd0000        	call	c_lumd
2327  08ef be02          	ldw	x,c_lreg+2
2328  08f1 1f31          	ldw	(OFST-7,sp),x
2330                     ; 447 					setRGB(mean_high+(mean_low?5:0),sound_level);
2332  08f3 1e31          	ldw	x,(OFST-7,sp)
2333  08f5 89            	pushw	x
2334  08f6 96            	ldw	x,sp
2335  08f7 1c0021        	addw	x,#OFST-23
2336  08fa cd0000        	call	c_lzmp
2338  08fd 2705          	jreq	L47
2339  08ff ae0005        	ldw	x,#5
2340  0902 2001          	jra	L67
2341  0904               L47:
2342  0904 5f            	clrw	x
2343  0905               L67:
2344  0905 cd0000        	call	c_itolx
2346  0908 96            	ldw	x,sp
2347  0909 1c002f        	addw	x,#OFST-9
2348  090c cd0000        	call	c_ladd
2350  090f be02          	ldw	x,c_lreg+2
2351  0911 cd0b66        	call	_setRGB
2353  0914 85            	popw	x
2355  0915 2086          	jpf	L555
2356  0917               L101:
2357                     ; 453 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2359  0917 c650c6        	ld	a,20678
2360  091a a4e7          	and	a,#231
2361  091c c750c6        	ld	20678,a
2362                     ; 455 			TIM4->PSCR= 7;// init divider register /128	
2364  091f 35075347      	mov	21319,#7
2365                     ; 456 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2367  0923 357d5348      	mov	21320,#125
2368                     ; 457 			TIM4->EGR= TIM4_EGR_UG;// update registers
2370  0927 35015345      	mov	21317,#1
2371                     ; 458 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2373  092b c65340        	ld	a,21312
2374  092e aa85          	or	a,#133
2375  0930 c75340        	ld	21312,a
2376                     ; 459 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2378  0933 35015343      	mov	21315,#1
2379                     ; 460 			enableInterrupts();
2382  0937 9a            rim
2384  0938               L165:
2385                     ; 463 				if(tms%8000==0 && mean_sum!=tms/8000)
2387  0938 ae0000        	ldw	x,#_tms
2388  093b cd0000        	call	c_ltor
2390  093e ae003c        	ldw	x,#L001
2391  0941 cd0000        	call	c_lumd
2393  0944 cd0000        	call	c_lrzmp
2395  0947 26ef          	jrne	L165
2397  0949 ae0000        	ldw	x,#_tms
2398  094c cd0000        	call	c_ltor
2400  094f ae003c        	ldw	x,#L001
2401  0952 cd0000        	call	c_ludv
2403  0955 96            	ldw	x,sp
2404  0956 1c0027        	addw	x,#OFST-17
2405  0959 cd0000        	call	c_lcmp
2407  095c 27da          	jreq	L165
2408                     ; 465 				  setMatrixHighZ();
2410  095e cd0b4f        	call	_setMatrixHighZ
2412                     ; 466 					mean_sum=tms/8000;
2414  0961 ae0000        	ldw	x,#_tms
2415  0964 cd0000        	call	c_ltor
2417  0967 ae003c        	ldw	x,#L001
2418  096a cd0000        	call	c_ludv
2420  096d 96            	ldw	x,sp
2421  096e 1c0027        	addw	x,#OFST-17
2422  0971 cd0000        	call	c_rtol
2425                     ; 467 					if(mean_sum%4==3)
2427  0974 7b2a          	ld	a,(OFST-14,sp)
2428  0976 a403          	and	a,#3
2429  0978 a103          	cp	a,#3
2430  097a 2608          	jrne	L765
2431                     ; 469 						setWhite(11);
2433  097c ae000b        	ldw	x,#11
2434  097f cd0b75        	call	_setWhite
2437  0982 20b4          	jra	L165
2438  0984               L765:
2439                     ; 471 						setRGB(4,mean_sum%4);
2441  0984 7b2a          	ld	a,(OFST-14,sp)
2442  0986 5f            	clrw	x
2443  0987 a403          	and	a,#3
2444  0989 5f            	clrw	x
2445  098a 02            	rlwa	x,a
2446  098b 89            	pushw	x
2447  098c 01            	rrwa	x,a
2448  098d ae0004        	ldw	x,#4
2449  0990 cd0b66        	call	_setRGB
2451  0993 85            	popw	x
2452  0994 20a2          	jra	L165
2453  0996               L301:
2454                     ; 478 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2456  0996 c650c6        	ld	a,20678
2457  0999 a4e7          	and	a,#231
2458  099b c750c6        	ld	20678,a
2459                     ; 480 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2461  099e 4bf0          	push	#240
2462  09a0 4b20          	push	#32
2463  09a2 ae500f        	ldw	x,#20495
2464  09a5 cd0000        	call	_GPIO_Init
2466  09a8 85            	popw	x
2467                     ; 481 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2469  09a9 4b40          	push	#64
2470  09ab 4b40          	push	#64
2471  09ad ae500f        	ldw	x,#20495
2472  09b0 cd0000        	call	_GPIO_Init
2474  09b3 85            	popw	x
2475                     ; 482 			UART1_DeInit();
2477  09b4 cd0000        	call	_UART1_DeInit
2479                     ; 483 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2481  09b7 4b0c          	push	#12
2482  09b9 4b80          	push	#128
2483  09bb 4b00          	push	#0
2484  09bd 4b00          	push	#0
2485  09bf 4b00          	push	#0
2486  09c1 ae4240        	ldw	x,#16960
2487  09c4 89            	pushw	x
2488  09c5 ae000f        	ldw	x,#15
2489  09c8 89            	pushw	x
2490  09c9 cd0000        	call	_UART1_Init
2492  09cc 5b09          	addw	sp,#9
2493                     ; 485 			UART1_Cmd(ENABLE);
2495  09ce a601          	ld	a,#1
2496  09d0 cd0000        	call	_UART1_Cmd
2498                     ; 487 			Serial_print_string("Mode: ");
2500  09d3 ae0116        	ldw	x,#L125
2501  09d6 cd0ab4        	call	_Serial_print_string
2503                     ; 488 			Serial_print_int(test_mode);
2505  09d9 1e33          	ldw	x,(OFST-5,sp)
2506  09db cd0add        	call	_Serial_print_int
2508                     ; 489 			Serial_newline();
2510  09de cd0b40        	call	_Serial_newline
2512                     ; 492 			TIM2->CCR1H=0;//this will always be zero based on application architecutre decisions
2514  09e1 725f5311      	clr	21265
2515                     ; 493 			TIM2->PSCR= 5;// init divider register 16MHz/2^X
2517  09e5 3505530e      	mov	21262,#5
2518                     ; 494 			TIM2->ARRH= 0;// init auto reload register
2520  09e9 725f530f      	clr	21263
2521                     ; 495 			TIM2->ARRL= 250;// init auto reload register
2523  09ed 35fa5310      	mov	21264,#250
2524                     ; 497 			TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
2526  09f1 c65300        	ld	a,21248
2527  09f4 aa85          	or	a,#133
2528  09f6 c75300        	ld	21248,a
2529                     ; 498 			TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
2531  09f9 35035303      	mov	21251,#3
2532                     ; 499 			enableInterrupts();
2535  09fd 9a            rim
2537  09fe               L375:
2538                     ; 502 				Serial_print_string("tms: ");
2540  09fe ae00f4        	ldw	x,#L775
2541  0a01 cd0ab4        	call	_Serial_print_string
2543                     ; 503 				Serial_print_int(tms/1000);
2545  0a04 ae0000        	ldw	x,#_tms
2546  0a07 cd0000        	call	c_ltor
2548  0a0a ae0018        	ldw	x,#L42
2549  0a0d cd0000        	call	c_ludv
2551  0a10 be02          	ldw	x,c_lreg+2
2552  0a12 cd0add        	call	_Serial_print_int
2554                     ; 504 				Serial_print_string("tms2: ");
2556  0a15 ae00ed        	ldw	x,#L106
2557  0a18 cd0ab4        	call	_Serial_print_string
2559                     ; 505 				Serial_print_int(tms2/1000);
2561  0a1b ae0004        	ldw	x,#_tms2
2562  0a1e cd0000        	call	c_ltor
2564  0a21 ae0018        	ldw	x,#L42
2565  0a24 cd0000        	call	c_ludv
2567  0a27 be02          	ldw	x,c_lreg+2
2568  0a29 cd0add        	call	_Serial_print_int
2570                     ; 506 				Serial_newline();
2572  0a2c cd0b40        	call	_Serial_newline
2574                     ; 507 				setMatrixHighZ();
2576  0a2f cd0b4f        	call	_setMatrixHighZ
2578                     ; 508 				setRGB(0,(tms>>11)%4);
2580  0a32 be02          	ldw	x,_tms+2
2581  0a34 4f            	clr	a
2582  0a35 01            	rrwa	x,a
2583  0a36 54            	srlw	x
2584  0a37 54            	srlw	x
2585  0a38 54            	srlw	x
2586  0a39 cd0000        	call	c_uitolx
2588  0a3c b603          	ld	a,c_lreg+3
2589  0a3e a403          	and	a,#3
2590  0a40 b703          	ld	c_lreg+3,a
2591  0a42 3f02          	clr	c_lreg+2
2592  0a44 3f01          	clr	c_lreg+1
2593  0a46 3f00          	clr	c_lreg
2594  0a48 be02          	ldw	x,c_lreg+2
2595  0a4a 89            	pushw	x
2596  0a4b 5f            	clrw	x
2597  0a4c cd0b66        	call	_setRGB
2599  0a4f 85            	popw	x
2600                     ; 509 				for(iter=0;iter<30000;iter++){}
2602  0a50 ae0000        	ldw	x,#0
2603  0a53 1f37          	ldw	(OFST-1,sp),x
2604  0a55 ae0000        	ldw	x,#0
2605  0a58 1f35          	ldw	(OFST-3,sp),x
2607  0a5a               L306:
2610  0a5a 96            	ldw	x,sp
2611  0a5b 1c0035        	addw	x,#OFST-3
2612  0a5e a601          	ld	a,#1
2613  0a60 cd0000        	call	c_lgadc
2618  0a63 96            	ldw	x,sp
2619  0a64 1c0035        	addw	x,#OFST-3
2620  0a67 cd0000        	call	c_ltor
2622  0a6a ae0014        	ldw	x,#L21
2623  0a6d cd0000        	call	c_lcmp
2625  0a70 25e8          	jrult	L306
2627  0a72 208a          	jra	L375
2652                     ; 516 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2654                     	switch	.text
2655  0a74               f_TIM4_UPD_OVF_IRQHandler:
2659                     ; 517 	TIM4->SR1&=~TIM4_SR1_UIF;
2661  0a74 72115344      	bres	21316,#0
2662                     ; 518 	tms++;
2664  0a78 ae0000        	ldw	x,#_tms
2665  0a7b a601          	ld	a,#1
2666  0a7d cd0000        	call	c_lgadc
2668                     ; 519 }
2671  0a80 80            	iret
2695                     ; 522 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
2696                     	switch	.text
2697  0a81               f_TIM2_UPD_OVF_IRQHandler:
2701                     ; 523 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
2703  0a81 72115304      	bres	21252,#0
2704                     ; 524 	tms2++;
2706  0a85 ae0004        	ldw	x,#_tms2
2707  0a88 a601          	ld	a,#1
2708  0a8a cd0000        	call	c_lgadc
2710                     ; 527 }
2713  0a8d 80            	iret
2737                     ; 530 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
2738                     	switch	.text
2739  0a8e               f_TIM2_CapComp_IRQ_Handler:
2741  0a8e 8a            	push	cc
2742  0a8f 84            	pop	a
2743  0a90 a4bf          	and	a,#191
2744  0a92 88            	push	a
2745  0a93 86            	pop	cc
2746  0a94 3b0002        	push	c_x+2
2747  0a97 be00          	ldw	x,c_x
2748  0a99 89            	pushw	x
2749  0a9a 3b0002        	push	c_y+2
2750  0a9d be00          	ldw	x,c_y
2751  0a9f 89            	pushw	x
2754                     ; 531 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
2756  0aa0 72135304      	bres	21252,#1
2757                     ; 532 	setMatrixHighZ();
2759  0aa4 cd0b4f        	call	_setMatrixHighZ
2761                     ; 534 }
2764  0aa7 85            	popw	x
2765  0aa8 bf00          	ldw	c_y,x
2766  0aaa 320002        	pop	c_y+2
2767  0aad 85            	popw	x
2768  0aae bf00          	ldw	c_x,x
2769  0ab0 320002        	pop	c_x+2
2770  0ab3 80            	iret
2816                     ; 557  void Serial_print_string (char string[])
2816                     ; 558  {
2818                     	switch	.text
2819  0ab4               _Serial_print_string:
2821  0ab4 89            	pushw	x
2822  0ab5 88            	push	a
2823       00000001      OFST:	set	1
2826                     ; 560 	 char i=0;
2828  0ab6 0f01          	clr	(OFST+0,sp)
2831  0ab8 2016          	jra	L766
2832  0aba               L366:
2833                     ; 564 		UART1_SendData8(string[i]);
2835  0aba 7b01          	ld	a,(OFST+0,sp)
2836  0abc 5f            	clrw	x
2837  0abd 97            	ld	xl,a
2838  0abe 72fb02        	addw	x,(OFST+1,sp)
2839  0ac1 f6            	ld	a,(x)
2840  0ac2 cd0000        	call	_UART1_SendData8
2843  0ac5               L576:
2844                     ; 565 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2846  0ac5 ae0080        	ldw	x,#128
2847  0ac8 cd0000        	call	_UART1_GetFlagStatus
2849  0acb 4d            	tnz	a
2850  0acc 27f7          	jreq	L576
2851                     ; 566 		i++;
2853  0ace 0c01          	inc	(OFST+0,sp)
2855  0ad0               L766:
2856                     ; 562 	 while (string[i] != 0x00)
2858  0ad0 7b01          	ld	a,(OFST+0,sp)
2859  0ad2 5f            	clrw	x
2860  0ad3 97            	ld	xl,a
2861  0ad4 72fb02        	addw	x,(OFST+1,sp)
2862  0ad7 7d            	tnz	(x)
2863  0ad8 26e0          	jrne	L366
2864                     ; 568  }
2867  0ada 5b03          	addw	sp,#3
2868  0adc 81            	ret
2871                     	switch	.const
2872  0040               L107_digit:
2873  0040 00            	dc.b	0
2874  0041 00000000      	ds.b	4
2927                     ; 570  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2927                     ; 571  {
2928                     	switch	.text
2929  0add               _Serial_print_int:
2931  0add 89            	pushw	x
2932  0ade 5208          	subw	sp,#8
2933       00000008      OFST:	set	8
2936                     ; 572 	 char count = 0;
2938  0ae0 0f08          	clr	(OFST+0,sp)
2940                     ; 573 	 char digit[5] = "";
2942  0ae2 96            	ldw	x,sp
2943  0ae3 1c0003        	addw	x,#OFST-5
2944  0ae6 90ae0040      	ldw	y,#L107_digit
2945  0aea a605          	ld	a,#5
2946  0aec cd0000        	call	c_xymov
2949  0aef 2023          	jra	L537
2950  0af1               L137:
2951                     ; 577 		 digit[count] = number%10;
2953  0af1 96            	ldw	x,sp
2954  0af2 1c0003        	addw	x,#OFST-5
2955  0af5 9f            	ld	a,xl
2956  0af6 5e            	swapw	x
2957  0af7 1b08          	add	a,(OFST+0,sp)
2958  0af9 2401          	jrnc	L041
2959  0afb 5c            	incw	x
2960  0afc               L041:
2961  0afc 02            	rlwa	x,a
2962  0afd 1609          	ldw	y,(OFST+1,sp)
2963  0aff a60a          	ld	a,#10
2964  0b01 cd0000        	call	c_smody
2966  0b04 9001          	rrwa	y,a
2967  0b06 f7            	ld	(x),a
2968  0b07 9002          	rlwa	y,a
2969                     ; 578 		 count++;
2971  0b09 0c08          	inc	(OFST+0,sp)
2973                     ; 579 		 number = number/10;
2975  0b0b 1e09          	ldw	x,(OFST+1,sp)
2976  0b0d a60a          	ld	a,#10
2977  0b0f cd0000        	call	c_sdivx
2979  0b12 1f09          	ldw	(OFST+1,sp),x
2980  0b14               L537:
2981                     ; 575 	 while (number != 0) //split the int to char array 
2983  0b14 1e09          	ldw	x,(OFST+1,sp)
2984  0b16 26d9          	jrne	L137
2986  0b18 201f          	jra	L347
2987  0b1a               L147:
2988                     ; 584 		UART1_SendData8(digit[count-1] + 0x30);
2990  0b1a 96            	ldw	x,sp
2991  0b1b 1c0003        	addw	x,#OFST-5
2992  0b1e 1f01          	ldw	(OFST-7,sp),x
2994  0b20 7b08          	ld	a,(OFST+0,sp)
2995  0b22 5f            	clrw	x
2996  0b23 97            	ld	xl,a
2997  0b24 5a            	decw	x
2998  0b25 72fb01        	addw	x,(OFST-7,sp)
2999  0b28 f6            	ld	a,(x)
3000  0b29 ab30          	add	a,#48
3001  0b2b cd0000        	call	_UART1_SendData8
3004  0b2e               L157:
3005                     ; 585 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
3007  0b2e ae0080        	ldw	x,#128
3008  0b31 cd0000        	call	_UART1_GetFlagStatus
3010  0b34 4d            	tnz	a
3011  0b35 27f7          	jreq	L157
3012                     ; 586 		count--; 
3014  0b37 0a08          	dec	(OFST+0,sp)
3016  0b39               L347:
3017                     ; 582 	 while (count !=0) //print char array in correct direction 
3019  0b39 0d08          	tnz	(OFST+0,sp)
3020  0b3b 26dd          	jrne	L147
3021                     ; 588  }
3024  0b3d 5b0a          	addw	sp,#10
3025  0b3f 81            	ret
3050                     ; 590  void Serial_newline(void)
3050                     ; 591  {
3051                     	switch	.text
3052  0b40               _Serial_newline:
3056                     ; 592 	 UART1_SendData8(0x0a);
3058  0b40 a60a          	ld	a,#10
3059  0b42 cd0000        	call	_UART1_SendData8
3062  0b45               L767:
3063                     ; 593 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
3065  0b45 ae0080        	ldw	x,#128
3066  0b48 cd0000        	call	_UART1_GetFlagStatus
3068  0b4b 4d            	tnz	a
3069  0b4c 27f7          	jreq	L767
3070                     ; 594  }
3073  0b4e 81            	ret
3097                     ; 596 void setMatrixHighZ()
3097                     ; 597 {
3098                     	switch	.text
3099  0b4f               _setMatrixHighZ:
3103                     ; 602 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
3105  0b4f 4b00          	push	#0
3106  0b51 4bf8          	push	#248
3107  0b53 ae500a        	ldw	x,#20490
3108  0b56 cd0000        	call	_GPIO_Init
3110  0b59 85            	popw	x
3111                     ; 603 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
3113  0b5a 4b00          	push	#0
3114  0b5c 4b0c          	push	#12
3115  0b5e ae500f        	ldw	x,#20495
3116  0b61 cd0000        	call	_GPIO_Init
3118  0b64 85            	popw	x
3119                     ; 604 }
3122  0b65 81            	ret
3166                     ; 606 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
3167                     	switch	.text
3168  0b66               _setRGB:
3170  0b66 89            	pushw	x
3171       00000000      OFST:	set	0
3176  0b67 1e05          	ldw	x,(OFST+5,sp)
3177  0b69 89            	pushw	x
3178  0b6a 1e03          	ldw	x,(OFST+3,sp)
3179  0b6c 89            	pushw	x
3180  0b6d a601          	ld	a,#1
3181  0b6f ad11          	call	_setLED
3183  0b71 5b04          	addw	sp,#4
3187  0b73 85            	popw	x
3188  0b74 81            	ret
3223                     ; 607 void setWhite(int led_index){ setLED(0,led_index,0); }
3224                     	switch	.text
3225  0b75               _setWhite:
3227  0b75 89            	pushw	x
3228       00000000      OFST:	set	0
3233  0b76 5f            	clrw	x
3234  0b77 89            	pushw	x
3235  0b78 1e03          	ldw	x,(OFST+3,sp)
3236  0b7a 89            	pushw	x
3237  0b7b 4f            	clr	a
3238  0b7c ad04          	call	_setLED
3240  0b7e 5b04          	addw	sp,#4
3244  0b80 85            	popw	x
3245  0b81 81            	ret
3248                     	switch	.const
3249  0045               L3401_rgb_lookup:
3250  0045 0000          	dc.w	0
3251  0047 0001          	dc.w	1
3252  0049 0000          	dc.w	0
3253  004b 0002          	dc.w	2
3254  004d 0001          	dc.w	1
3255  004f 0002          	dc.w	2
3256  0051 0001          	dc.w	1
3257  0053 0000          	dc.w	0
3258  0055 0002          	dc.w	2
3259  0057 0000          	dc.w	0
3260  0059 0002          	dc.w	2
3261  005b 0001          	dc.w	1
3262  005d 0005          	dc.w	5
3263  005f 0000          	dc.w	0
3264  0061 0005          	dc.w	5
3265  0063 0001          	dc.w	1
3266  0065 0005          	dc.w	5
3267  0067 0002          	dc.w	2
3268  0069 0006          	dc.w	6
3269  006b 0000          	dc.w	0
3270  006d 0006          	dc.w	6
3271  006f 0001          	dc.w	1
3272  0071 0006          	dc.w	6
3273  0073 0002          	dc.w	2
3274  0075 0006          	dc.w	6
3275  0077 0005          	dc.w	5
3276  0079 0006          	dc.w	6
3277  007b 0004          	dc.w	4
3278  007d 0005          	dc.w	5
3279  007f 0004          	dc.w	4
3280  0081 0004          	dc.w	4
3281  0083 0003          	dc.w	3
3282  0085 0005          	dc.w	5
3283  0087 0003          	dc.w	3
3284  0089 0006          	dc.w	6
3285  008b 0003          	dc.w	3
3286  008d 0003          	dc.w	3
3287  008f 0004          	dc.w	4
3288  0091 0003          	dc.w	3
3289  0093 0005          	dc.w	5
3290  0095 0003          	dc.w	3
3291  0097 0006          	dc.w	6
3292  0099 0000          	dc.w	0
3293  009b 0005          	dc.w	5
3294  009d 0000          	dc.w	0
3295  009f 0006          	dc.w	6
3296  00a1 0001          	dc.w	1
3297  00a3 0006          	dc.w	6
3298  00a5 0000          	dc.w	0
3299  00a7 0004          	dc.w	4
3300  00a9 0001          	dc.w	1
3301  00ab 0004          	dc.w	4
3302  00ad 0002          	dc.w	2
3303  00af 0004          	dc.w	4
3304  00b1 0000          	dc.w	0
3305  00b3 0003          	dc.w	3
3306  00b5 0001          	dc.w	1
3307  00b7 0003          	dc.w	3
3308  00b9 0002          	dc.w	2
3309  00bb 0003          	dc.w	3
3310  00bd               L5401_white_lookup:
3311  00bd 0003          	dc.w	3
3312  00bf 0000          	dc.w	0
3313  00c1 0003          	dc.w	3
3314  00c3 0001          	dc.w	1
3315  00c5 0003          	dc.w	3
3316  00c7 0002          	dc.w	2
3317  00c9 0004          	dc.w	4
3318  00cb 0000          	dc.w	0
3319  00cd 0001          	dc.w	1
3320  00cf 0005          	dc.w	5
3321  00d1 0002          	dc.w	2
3322  00d3 0005          	dc.w	5
3323  00d5 0004          	dc.w	4
3324  00d7 0001          	dc.w	1
3325  00d9 0004          	dc.w	4
3326  00db 0002          	dc.w	2
3327  00dd 0002          	dc.w	2
3328  00df 0006          	dc.w	6
3329  00e1 0004          	dc.w	4
3330  00e3 0006          	dc.w	6
3331  00e5 0004          	dc.w	4
3332  00e7 0005          	dc.w	5
3333  00e9 0005          	dc.w	5
3334  00eb 0006          	dc.w	6
3596                     ; 609 void setLED(bool is_rgb,int led_index,int rgb_index)
3596                     ; 610 {
3597                     	switch	.text
3598  0b82               _setLED:
3600  0b82 88            	push	a
3601  0b83 52b6          	subw	sp,#182
3602       000000b6      OFST:	set	182
3605                     ; 611   const unsigned short rgb_lookup[10][3][2]={
3605                     ; 612 		{{0,1},{0,2},{1,2}},//7
3605                     ; 613 		{{1,0},{2,0},{2,1}},//3
3605                     ; 614 		{{5,0},{5,1},{5,2}},//1
3605                     ; 615 		{{6,0},{6,1},{6,2}},//20
3605                     ; 616 		{{6,5},{6,4},{5,4}},//22
3605                     ; 617 		{{4,3},{5,3},{6,3}},//23
3605                     ; 618 		{{3,4},{3,5},{3,6}},//21
3605                     ; 619 		{{0,5},{0,6},{1,6}},//19
3605                     ; 620 		{{0,4},{1,4},{2,4}},//18
3605                     ; 621 		{{0,3},{1,3},{2,3}} //2
3605                     ; 622 	};
3607  0b85 96            	ldw	x,sp
3608  0b86 1c000e        	addw	x,#OFST-168
3609  0b89 90ae0045      	ldw	y,#L3401_rgb_lookup
3610  0b8d a678          	ld	a,#120
3611  0b8f cd0000        	call	c_xymov
3613                     ; 623 	const unsigned short white_lookup[12][2]={
3613                     ; 624 		{3,0},//6
3613                     ; 625 		{3,1},//4
3613                     ; 626 		{3,2},//5
3613                     ; 627 		{4,0},//14
3613                     ; 628 		{1,5},//8
3613                     ; 629 		{2,5},//9
3613                     ; 630 		{4,1},//10
3613                     ; 631 		{4,2},//16
3613                     ; 632 		{2,6},//17
3613                     ; 633 		{4,6},//12
3613                     ; 634 		{4,5},//13
3613                     ; 635 		{5,6} //11
3613                     ; 636 	};
3615  0b92 96            	ldw	x,sp
3616  0b93 1c0086        	addw	x,#OFST-48
3617  0b96 90ae00bd      	ldw	y,#L5401_white_lookup
3618  0b9a a630          	ld	a,#48
3619  0b9c cd0000        	call	c_xymov
3621                     ; 637 	bool is_low=0;
3623  0b9f 0fb6          	clr	(OFST+0,sp)
3625  0ba1               L5321:
3626                     ; 641 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3628  0ba1 0db7          	tnz	(OFST+1,sp)
3629  0ba3 2726          	jreq	L451
3630  0ba5 7bb6          	ld	a,(OFST+0,sp)
3631  0ba7 5f            	clrw	x
3632  0ba8 97            	ld	xl,a
3633  0ba9 58            	sllw	x
3634  0baa 1f09          	ldw	(OFST-173,sp),x
3636  0bac 1ebc          	ldw	x,(OFST+6,sp)
3637  0bae 58            	sllw	x
3638  0baf 58            	sllw	x
3639  0bb0 1f07          	ldw	(OFST-175,sp),x
3641  0bb2 96            	ldw	x,sp
3642  0bb3 1c000e        	addw	x,#OFST-168
3643  0bb6 1f05          	ldw	(OFST-177,sp),x
3645  0bb8 1eba          	ldw	x,(OFST+4,sp)
3646  0bba a60c          	ld	a,#12
3647  0bbc cd0000        	call	c_bmulx
3649  0bbf 72fb05        	addw	x,(OFST-177,sp)
3650  0bc2 72fb07        	addw	x,(OFST-175,sp)
3651  0bc5 72fb09        	addw	x,(OFST-173,sp)
3652  0bc8 fe            	ldw	x,(x)
3653  0bc9 2018          	jra	L651
3654  0bcb               L451:
3655  0bcb 7bb6          	ld	a,(OFST+0,sp)
3656  0bcd 5f            	clrw	x
3657  0bce 97            	ld	xl,a
3658  0bcf 58            	sllw	x
3659  0bd0 1f03          	ldw	(OFST-179,sp),x
3661  0bd2 96            	ldw	x,sp
3662  0bd3 1c0086        	addw	x,#OFST-48
3663  0bd6 1f01          	ldw	(OFST-181,sp),x
3665  0bd8 1eba          	ldw	x,(OFST+4,sp)
3666  0bda 58            	sllw	x
3667  0bdb 58            	sllw	x
3668  0bdc 72fb01        	addw	x,(OFST-181,sp)
3669  0bdf 72fb03        	addw	x,(OFST-179,sp)
3670  0be2 fe            	ldw	x,(x)
3671  0be3               L651:
3673                     ; 673 			}break;
3674  0be3 5d            	tnzw	x
3675  0be4 2714          	jreq	L7401
3676  0be6 5a            	decw	x
3677  0be7 271c          	jreq	L1501
3678  0be9 5a            	decw	x
3679  0bea 2724          	jreq	L3501
3680  0bec 5a            	decw	x
3681  0bed 272c          	jreq	L5501
3682  0bef 5a            	decw	x
3683  0bf0 2734          	jreq	L7501
3684  0bf2 5a            	decw	x
3685  0bf3 273c          	jreq	L1601
3686  0bf5 5a            	decw	x
3687  0bf6 2744          	jreq	L3601
3688  0bf8 204b          	jra	L5421
3689  0bfa               L7401:
3690                     ; 644 				GPIOx=GPIOD;
3692  0bfa ae500f        	ldw	x,#20495
3693  0bfd 1f0b          	ldw	(OFST-171,sp),x
3695                     ; 645 				PortPin=GPIO_PIN_3;
3697  0bff a608          	ld	a,#8
3698  0c01 6b0d          	ld	(OFST-169,sp),a
3700                     ; 646 			}break;
3702  0c03 2040          	jra	L5421
3703  0c05               L1501:
3704                     ; 648 				GPIOx=GPIOD;
3706  0c05 ae500f        	ldw	x,#20495
3707  0c08 1f0b          	ldw	(OFST-171,sp),x
3709                     ; 649 				PortPin=GPIO_PIN_2;
3711  0c0a a604          	ld	a,#4
3712  0c0c 6b0d          	ld	(OFST-169,sp),a
3714                     ; 650 			}break;
3716  0c0e 2035          	jra	L5421
3717  0c10               L3501:
3718                     ; 652 				GPIOx=GPIOC;
3720  0c10 ae500a        	ldw	x,#20490
3721  0c13 1f0b          	ldw	(OFST-171,sp),x
3723                     ; 653 				PortPin=GPIO_PIN_7;
3725  0c15 a680          	ld	a,#128
3726  0c17 6b0d          	ld	(OFST-169,sp),a
3728                     ; 654 			}break;
3730  0c19 202a          	jra	L5421
3731  0c1b               L5501:
3732                     ; 656 				GPIOx=GPIOC;
3734  0c1b ae500a        	ldw	x,#20490
3735  0c1e 1f0b          	ldw	(OFST-171,sp),x
3737                     ; 657 				PortPin=GPIO_PIN_6;
3739  0c20 a640          	ld	a,#64
3740  0c22 6b0d          	ld	(OFST-169,sp),a
3742                     ; 658 			}break;
3744  0c24 201f          	jra	L5421
3745  0c26               L7501:
3746                     ; 660 				GPIOx=GPIOC;
3748  0c26 ae500a        	ldw	x,#20490
3749  0c29 1f0b          	ldw	(OFST-171,sp),x
3751                     ; 661 				PortPin=GPIO_PIN_5;
3753  0c2b a620          	ld	a,#32
3754  0c2d 6b0d          	ld	(OFST-169,sp),a
3756                     ; 662 			}break;
3758  0c2f 2014          	jra	L5421
3759  0c31               L1601:
3760                     ; 664 				GPIOx=GPIOC;
3762  0c31 ae500a        	ldw	x,#20490
3763  0c34 1f0b          	ldw	(OFST-171,sp),x
3765                     ; 665 				PortPin=GPIO_PIN_4;
3767  0c36 a610          	ld	a,#16
3768  0c38 6b0d          	ld	(OFST-169,sp),a
3770                     ; 666 			}break;
3772  0c3a 2009          	jra	L5421
3773  0c3c               L3601:
3774                     ; 668 				GPIOx=GPIOC;
3776  0c3c ae500a        	ldw	x,#20490
3777  0c3f 1f0b          	ldw	(OFST-171,sp),x
3779                     ; 669 				PortPin=GPIO_PIN_3;
3781  0c41 a608          	ld	a,#8
3782  0c43 6b0d          	ld	(OFST-169,sp),a
3784                     ; 670 			}break;
3786  0c45               L5421:
3787                     ; 675 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3789  0c45 0db6          	tnz	(OFST+0,sp)
3790  0c47 2704          	jreq	L061
3791  0c49 a6c0          	ld	a,#192
3792  0c4b 2002          	jra	L261
3793  0c4d               L061:
3794  0c4d a6d0          	ld	a,#208
3795  0c4f               L261:
3796  0c4f 88            	push	a
3797  0c50 7b0e          	ld	a,(OFST-168,sp)
3798  0c52 88            	push	a
3799  0c53 1e0d          	ldw	x,(OFST-169,sp)
3800  0c55 cd0000        	call	_GPIO_Init
3802  0c58 85            	popw	x
3803                     ; 676 		is_low=!is_low;
3805  0c59 0db6          	tnz	(OFST+0,sp)
3806  0c5b 2604          	jrne	L461
3807  0c5d a601          	ld	a,#1
3808  0c5f 2001          	jra	L661
3809  0c61               L461:
3810  0c61 4f            	clr	a
3811  0c62               L661:
3812  0c62 6bb6          	ld	(OFST+0,sp),a
3814                     ; 677 	}while(is_low);
3816  0c64 0db6          	tnz	(OFST+0,sp)
3817  0c66 2703          	jreq	L071
3818  0c68 cc0ba1        	jp	L5321
3819  0c6b               L071:
3820                     ; 678 }
3823  0c6b 5bb7          	addw	sp,#183
3824  0c6d 81            	ret
3937                     	xdef	f_TIM2_CapComp_IRQ_Handler
3938                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3939                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3940                     	xdef	_main
3941                     	xdef	_Serial_print_string
3942                     	xdef	_Serial_newline
3943                     	xdef	_Serial_print_int
3944                     	xdef	_setWhite
3945                     	xdef	_setRGB
3946                     	xdef	_setLED
3947                     	xdef	_setMatrixHighZ
3948                     	xdef	_pwm_state
3949                     	xdef	_pwm_led_index
3950                     	xdef	_pwm_sleep_remaining
3951                     	switch	.ubsct
3952  0000               _pwm_led_count:
3953  0000 0000          	ds.b	2
3954                     	xdef	_pwm_led_count
3955  0002               _pwm_sleep:
3956  0002 00000000      	ds.b	4
3957                     	xdef	_pwm_sleep
3958  0006               _pwm_brightness:
3959  0006 000000000000  	ds.b	172
3960                     	xdef	_pwm_brightness
3961  00b2               _pwm_brightness_buffer:
3962  00b2 000000000000  	ds.b	43
3963                     	xdef	_pwm_brightness_buffer
3964                     	xdef	_tms3
3965                     	xdef	_tms2
3966                     	xdef	_tms
3967                     	xdef	_ADC_Read
3968                     	xref	_UART1_GetFlagStatus
3969                     	xref	_UART1_SendData8
3970                     	xref	_UART1_Cmd
3971                     	xref	_UART1_Init
3972                     	xref	_UART1_DeInit
3973                     	xref	_GPIO_ReadInputPin
3974                     	xref	_GPIO_Init
3975                     	xref	_ADC1_ClearFlag
3976                     	xref	_ADC1_GetFlagStatus
3977                     	xref	_ADC1_GetConversionValue
3978                     	xref	_ADC1_StartConversion
3979                     	xref	_ADC1_Cmd
3980                     	xref	_ADC1_Init
3981                     	xref	_ADC1_DeInit
3982                     	switch	.const
3983  00ed               L106:
3984  00ed 746d73323a20  	dc.b	"tms2: ",0
3985  00f4               L775:
3986  00f4 746d733a2000  	dc.b	"tms: ",0
3987  00fa               L145:
3988  00fa 506172616d73  	dc.b	"Params: ",0
3989  0103               L335:
3990  0103 74696d653a20  	dc.b	"time: ",0
3991  010a               L325:
3992  010a 506172616d73  	dc.b	"Params v2: ",0
3993  0116               L125:
3994  0116 4d6f64653a20  	dc.b	"Mode: ",0
3995  011d               L105:
3996  011d 2000          	dc.b	" ",0
3997  011f               L144:
3998  011f 2a00          	dc.b	"*",0
3999  0121               L724:
4000  0121 3000          	dc.b	"0",0
4001  0123               L163:
4002  0123 2c2000        	dc.b	", ",0
4003  0126               L753:
4004  0126 6164633a2000  	dc.b	"adc: ",0
4005  012c               L723:
4006  012c 636f756e7465  	dc.b	"counter: ",0
4007                     	xref.b	c_lreg
4008                     	xref.b	c_x
4009                     	xref.b	c_y
4029                     	xref	c_bmulx
4030                     	xref	c_sdivx
4031                     	xref	c_smody
4032                     	xref	c_lxor
4033                     	xref	c_itolx
4034                     	xref	c_lrzmp
4035                     	xref	c_lumd
4036                     	xref	c_imul
4037                     	xref	c_ladd
4038                     	xref	c_lursh
4039                     	xref	c_uitol
4040                     	xref	c_smodx
4041                     	xref	c_ludv
4042                     	xref	c_itol
4043                     	xref	c_rtol
4044                     	xref	c_uitolx
4045                     	xref	c_lzmp
4046                     	xref	c_lcmp
4047                     	xref	c_ltor
4048                     	xref	c_lgadc
4049                     	xref	c_xymov
4050                     	end
