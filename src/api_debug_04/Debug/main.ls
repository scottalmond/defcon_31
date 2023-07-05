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
 196                     .const:	section	.text
 197  0000               L75_rms_lookup:
 198  0000 09            	dc.b	9
 199  0001 12            	dc.b	18
 200  0002 1c            	dc.b	28
 201  0003 26            	dc.b	38
 202  0004 30            	dc.b	48
 203  0005 3a            	dc.b	58
 204  0006 45            	dc.b	69
 205  0007 50            	dc.b	80
 206  0008 5c            	dc.b	92
 207  0009 69            	dc.b	105
 208  000a 76            	dc.b	118
 209  000b 86            	dc.b	134
 210  000c 97            	dc.b	151
 211  000d ad            	dc.b	173
 212  000e c8            	dc.b	200
 213  000f f1            	dc.b	241
 463                     	switch	.const
 464  0010               L01:
 465  0010 00002710      	dc.l	10000
 466  0014               L21:
 467  0014 00007530      	dc.l	30000
 468  0018               L42:
 469  0018 000003e8      	dc.l	1000
 470  001c               L04:
 471  001c 0000000a      	dc.l	10
 472                     ; 20 int main()
 472                     ; 21 {
 473                     	switch	.text
 474  003e               _main:
 476  003e 5238          	subw	sp,#56
 477       00000038      OFST:	set	56
 480                     ; 44 	const int test_mode=5;
 482  0040 ae0005        	ldw	x,#5
 483  0043 1f33          	ldw	(OFST-5,sp),x
 485                     ; 45 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 487  0045 96            	ldw	x,sp
 488  0046 1c0009        	addw	x,#OFST-47
 489  0049 90ae0000      	ldw	y,#L75_rms_lookup
 490  004d a610          	ld	a,#16
 491  004f cd0000        	call	c_xymov
 493                     ; 47 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 501                     ; 48 	unsigned sound_level=0;
 503  0052 5f            	clrw	x
 504  0053 1f2a          	ldw	(OFST-14,sp),x
 506                     ; 49 	uint8_t mean_threshold=16;
 508  0055 a610          	ld	a,#16
 509  0057 6b28          	ld	(OFST-16,sp),a
 511                     ; 50 	uint8_t mean_threshold_8=1;
 513  0059 a601          	ld	a,#1
 514  005b 6b27          	ld	(OFST-17,sp),a
 516                     ; 51 	uint16_t mean_threshold_16=0x0100;
 518  005d ae0100        	ldw	x,#256
 519  0060 1f25          	ldw	(OFST-19,sp),x
 521                     ; 52 	unsigned int rms=0;
 523                     ; 53 	const long adc_captures=1<<8;
 525  0062 ae0100        	ldw	x,#256
 526  0065 1f23          	ldw	(OFST-21,sp),x
 527  0067 ae0000        	ldw	x,#0
 528  006a 1f21          	ldw	(OFST-23,sp),x
 530                     ; 55 	int debug=0;
 532  006c 5f            	clrw	x
 533  006d 1f2d          	ldw	(OFST-11,sp),x
 535                     ; 57 	for(rep=0;rep<1;rep++)
 537  006f ae0000        	ldw	x,#0
 538  0072 1f31          	ldw	(OFST-7,sp),x
 539  0074 ae0000        	ldw	x,#0
 540  0077 1f2f          	ldw	(OFST-9,sp),x
 542  0079               L742:
 543                     ; 58 		for(iter=0;iter<10000;iter++){}
 545  0079 ae0000        	ldw	x,#0
 546  007c 1f37          	ldw	(OFST-1,sp),x
 547  007e ae0000        	ldw	x,#0
 548  0081 1f35          	ldw	(OFST-3,sp),x
 550  0083               L552:
 553  0083 96            	ldw	x,sp
 554  0084 1c0035        	addw	x,#OFST-3
 555  0087 a601          	ld	a,#1
 556  0089 cd0000        	call	c_lgadc
 561  008c 96            	ldw	x,sp
 562  008d 1c0035        	addw	x,#OFST-3
 563  0090 cd0000        	call	c_ltor
 565  0093 ae0010        	ldw	x,#L01
 566  0096 cd0000        	call	c_lcmp
 568  0099 25e8          	jrult	L552
 569                     ; 57 	for(rep=0;rep<1;rep++)
 571  009b 96            	ldw	x,sp
 572  009c 1c002f        	addw	x,#OFST-9
 573  009f a601          	ld	a,#1
 574  00a1 cd0000        	call	c_lgadc
 579  00a4 96            	ldw	x,sp
 580  00a5 1c002f        	addw	x,#OFST-9
 581  00a8 cd0000        	call	c_lzmp
 583  00ab 27cc          	jreq	L742
 584                     ; 61 	if(test_mode<=3 || test_mode==5)
 586  00ad 9c            	rvf
 587  00ae 1e33          	ldw	x,(OFST-5,sp)
 588  00b0 a30004        	cpw	x,#4
 589  00b3 2f07          	jrslt	L562
 591  00b5 1e33          	ldw	x,(OFST-5,sp)
 592  00b7 a30005        	cpw	x,#5
 593  00ba 2635          	jrne	L362
 594  00bc               L562:
 595                     ; 63 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 597  00bc 4bf0          	push	#240
 598  00be 4b20          	push	#32
 599  00c0 ae500f        	ldw	x,#20495
 600  00c3 cd0000        	call	_GPIO_Init
 602  00c6 85            	popw	x
 603                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 605  00c7 4b40          	push	#64
 606  00c9 4b40          	push	#64
 607  00cb ae500f        	ldw	x,#20495
 608  00ce cd0000        	call	_GPIO_Init
 610  00d1 85            	popw	x
 611                     ; 65 		UART1_DeInit();
 613  00d2 cd0000        	call	_UART1_DeInit
 615                     ; 66 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 617  00d5 4b0c          	push	#12
 618  00d7 4b80          	push	#128
 619  00d9 4b00          	push	#0
 620  00db 4b00          	push	#0
 621  00dd 4b00          	push	#0
 622  00df aec200        	ldw	x,#49664
 623  00e2 89            	pushw	x
 624  00e3 ae0001        	ldw	x,#1
 625  00e6 89            	pushw	x
 626  00e7 cd0000        	call	_UART1_Init
 628  00ea 5b09          	addw	sp,#9
 629                     ; 68 		UART1_Cmd(ENABLE);
 631  00ec a601          	ld	a,#1
 632  00ee cd0000        	call	_UART1_Cmd
 634  00f1               L362:
 635                     ; 71 	switch(test_mode)
 637  00f1 1e33          	ldw	x,(OFST-5,sp)
 639                     ; 327 				Serial_newline();
 640  00f3 5d            	tnzw	x
 641  00f4 2721          	jreq	L372
 642  00f6 5a            	decw	x
 643  00f7 2603          	jrne	L45
 644  00f9 cc01bb        	jp	L733
 645  00fc               L45:
 646  00fc 5a            	decw	x
 647  00fd 2603          	jrne	L65
 648  00ff cc0271        	jp	L56
 649  0102               L65:
 650  0102 5a            	decw	x
 651  0103 2603          	jrne	L06
 652  0105 cc0487        	jp	L76
 653  0108               L06:
 654  0108 5a            	decw	x
 655  0109 2603          	jrne	L26
 656  010b cc05c1        	jp	L17
 657  010e               L26:
 658  010e 5a            	decw	x
 659  010f 2603          	jrne	L46
 660  0111 cc0624        	jp	L37
 661  0114               L46:
 662  0114               L25:
 663                     ; 332 }
 666  0114 5b38          	addw	sp,#56
 667  0116 81            	ret
 668  0117               L372:
 669                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 671  0117 5f            	clrw	x
 672  0118 1f2a          	ldw	(OFST-14,sp),x
 674  011a               L772:
 675                     ; 81 					for(led_index=0;led_index<10;led_index++)
 677  011a 5f            	clrw	x
 678  011b 1f33          	ldw	(OFST-5,sp),x
 680  011d               L503:
 681                     ; 83 						setMatrixHighZ();
 683  011d cd0722        	call	_setMatrixHighZ
 685                     ; 84 						setRGB(led_index,rgb_index);
 687  0120 1e2a          	ldw	x,(OFST-14,sp)
 688  0122 89            	pushw	x
 689  0123 1e35          	ldw	x,(OFST-3,sp)
 690  0125 cd0739        	call	_setRGB
 692  0128 85            	popw	x
 693                     ; 85 						for(iter=0;iter<30000;iter++){}
 695  0129 ae0000        	ldw	x,#0
 696  012c 1f37          	ldw	(OFST-1,sp),x
 697  012e ae0000        	ldw	x,#0
 698  0131 1f35          	ldw	(OFST-3,sp),x
 700  0133               L313:
 703  0133 96            	ldw	x,sp
 704  0134 1c0035        	addw	x,#OFST-3
 705  0137 a601          	ld	a,#1
 706  0139 cd0000        	call	c_lgadc
 711  013c 96            	ldw	x,sp
 712  013d 1c0035        	addw	x,#OFST-3
 713  0140 cd0000        	call	c_ltor
 715  0143 ae0014        	ldw	x,#L21
 716  0146 cd0000        	call	c_lcmp
 718  0149 25e8          	jrult	L313
 719                     ; 86 						debug++;
 721  014b 1e2d          	ldw	x,(OFST-11,sp)
 722  014d 1c0001        	addw	x,#1
 723  0150 1f2d          	ldw	(OFST-11,sp),x
 725                     ; 93 							Serial_print_string("counter: ");
 727  0152 ae00ea        	ldw	x,#L123
 728  0155 cd0687        	call	_Serial_print_string
 730                     ; 94 							Serial_print_int(debug);
 732  0158 1e2d          	ldw	x,(OFST-11,sp)
 733  015a cd06b0        	call	_Serial_print_int
 735                     ; 97 							Serial_newline();
 737  015d cd0713        	call	_Serial_newline
 739                     ; 81 					for(led_index=0;led_index<10;led_index++)
 741  0160 1e33          	ldw	x,(OFST-5,sp)
 742  0162 1c0001        	addw	x,#1
 743  0165 1f33          	ldw	(OFST-5,sp),x
 747  0167 1e33          	ldw	x,(OFST-5,sp)
 748  0169 a3000a        	cpw	x,#10
 749  016c 25af          	jrult	L503
 750                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 752  016e 1e2a          	ldw	x,(OFST-14,sp)
 753  0170 1c0001        	addw	x,#1
 754  0173 1f2a          	ldw	(OFST-14,sp),x
 758  0175 1e2a          	ldw	x,(OFST-14,sp)
 759  0177 a30003        	cpw	x,#3
 760  017a 259e          	jrult	L772
 761                     ; 101 				for(led_index=0;led_index<12;led_index++)
 763  017c 5f            	clrw	x
 764  017d 1f33          	ldw	(OFST-5,sp),x
 766  017f               L323:
 767                     ; 103 					setMatrixHighZ();
 769  017f cd0722        	call	_setMatrixHighZ
 771                     ; 104 					setWhite(led_index);
 773  0182 1e33          	ldw	x,(OFST-5,sp)
 774  0184 cd0748        	call	_setWhite
 776                     ; 105 					for(iter=0;iter<30000;iter++){}
 778  0187 ae0000        	ldw	x,#0
 779  018a 1f37          	ldw	(OFST-1,sp),x
 780  018c ae0000        	ldw	x,#0
 781  018f 1f35          	ldw	(OFST-3,sp),x
 783  0191               L133:
 786  0191 96            	ldw	x,sp
 787  0192 1c0035        	addw	x,#OFST-3
 788  0195 a601          	ld	a,#1
 789  0197 cd0000        	call	c_lgadc
 794  019a 96            	ldw	x,sp
 795  019b 1c0035        	addw	x,#OFST-3
 796  019e cd0000        	call	c_ltor
 798  01a1 ae0014        	ldw	x,#L21
 799  01a4 cd0000        	call	c_lcmp
 801  01a7 25e8          	jrult	L133
 802                     ; 101 				for(led_index=0;led_index<12;led_index++)
 804  01a9 1e33          	ldw	x,(OFST-5,sp)
 805  01ab 1c0001        	addw	x,#1
 806  01ae 1f33          	ldw	(OFST-5,sp),x
 810  01b0 1e33          	ldw	x,(OFST-5,sp)
 811  01b2 a3000c        	cpw	x,#12
 812  01b5 25c8          	jrult	L323
 814  01b7 ac170117      	jpf	L372
 815  01bb               L733:
 816                     ; 113 				rep=ADC_Read(AIN4);
 818  01bb a604          	ld	a,#4
 819  01bd cd0000        	call	_ADC_Read
 821  01c0 cd0000        	call	c_uitolx
 823  01c3 96            	ldw	x,sp
 824  01c4 1c002f        	addw	x,#OFST-9
 825  01c7 cd0000        	call	c_rtol
 828                     ; 114 				my_min=rep;
 830  01ca 1e31          	ldw	x,(OFST-7,sp)
 831  01cc 1f33          	ldw	(OFST-5,sp),x
 833                     ; 115 				my_max=rep;
 835  01ce 1e31          	ldw	x,(OFST-7,sp)
 836  01d0 1f2d          	ldw	(OFST-11,sp),x
 838                     ; 116 				for(iter=0;iter<1000;iter++)
 840  01d2 ae0000        	ldw	x,#0
 841  01d5 1f37          	ldw	(OFST-1,sp),x
 842  01d7 ae0000        	ldw	x,#0
 843  01da 1f35          	ldw	(OFST-3,sp),x
 845  01dc               L343:
 846                     ; 118 					rep=ADC_Read(AIN4);
 848  01dc a604          	ld	a,#4
 849  01de cd0000        	call	_ADC_Read
 851  01e1 cd0000        	call	c_uitolx
 853  01e4 96            	ldw	x,sp
 854  01e5 1c002f        	addw	x,#OFST-9
 855  01e8 cd0000        	call	c_rtol
 858                     ; 119 					my_min=my_min<rep?my_min:rep;
 860  01eb 1e33          	ldw	x,(OFST-5,sp)
 861  01ed cd0000        	call	c_uitolx
 863  01f0 96            	ldw	x,sp
 864  01f1 1c002f        	addw	x,#OFST-9
 865  01f4 cd0000        	call	c_lcmp
 867  01f7 2404          	jruge	L41
 868  01f9 1e33          	ldw	x,(OFST-5,sp)
 869  01fb 2002          	jra	L61
 870  01fd               L41:
 871  01fd 1e31          	ldw	x,(OFST-7,sp)
 872  01ff               L61:
 873  01ff 1f33          	ldw	(OFST-5,sp),x
 875                     ; 120 					my_max=my_max>rep?my_max:rep;
 877  0201 1e2d          	ldw	x,(OFST-11,sp)
 878  0203 cd0000        	call	c_uitolx
 880  0206 96            	ldw	x,sp
 881  0207 1c002f        	addw	x,#OFST-9
 882  020a cd0000        	call	c_lcmp
 884  020d 2304          	jrule	L02
 885  020f 1e2d          	ldw	x,(OFST-11,sp)
 886  0211 2002          	jra	L22
 887  0213               L02:
 888  0213 1e31          	ldw	x,(OFST-7,sp)
 889  0215               L22:
 890  0215 1f2d          	ldw	(OFST-11,sp),x
 892                     ; 116 				for(iter=0;iter<1000;iter++)
 894  0217 96            	ldw	x,sp
 895  0218 1c0035        	addw	x,#OFST-3
 896  021b a601          	ld	a,#1
 897  021d cd0000        	call	c_lgadc
 902  0220 96            	ldw	x,sp
 903  0221 1c0035        	addw	x,#OFST-3
 904  0224 cd0000        	call	c_ltor
 906  0227 ae0018        	ldw	x,#L42
 907  022a cd0000        	call	c_lcmp
 909  022d 25ad          	jrult	L343
 910                     ; 122 				Serial_print_string("adc: ");
 912  022f ae00e4        	ldw	x,#L153
 913  0232 cd0687        	call	_Serial_print_string
 915                     ; 123 				Serial_print_int(rep);
 917  0235 1e31          	ldw	x,(OFST-7,sp)
 918  0237 cd06b0        	call	_Serial_print_int
 920                     ; 124 				Serial_print_string(", ");
 922  023a ae00e1        	ldw	x,#L353
 923  023d cd0687        	call	_Serial_print_string
 925                     ; 125 				Serial_print_int(my_max-my_min);
 927  0240 1e2d          	ldw	x,(OFST-11,sp)
 928  0242 72f033        	subw	x,(OFST-5,sp)
 929  0245 cd06b0        	call	_Serial_print_int
 931                     ; 126 				Serial_newline();
 933  0248 cd0713        	call	_Serial_newline
 935                     ; 127 				for(iter=0;iter<10000;iter++){}
 937  024b ae0000        	ldw	x,#0
 938  024e 1f37          	ldw	(OFST-1,sp),x
 939  0250 ae0000        	ldw	x,#0
 940  0253 1f35          	ldw	(OFST-3,sp),x
 942  0255               L553:
 945  0255 96            	ldw	x,sp
 946  0256 1c0035        	addw	x,#OFST-3
 947  0259 a601          	ld	a,#1
 948  025b cd0000        	call	c_lgadc
 953  025e 96            	ldw	x,sp
 954  025f 1c0035        	addw	x,#OFST-3
 955  0262 cd0000        	call	c_ltor
 957  0265 ae0010        	ldw	x,#L01
 958  0268 cd0000        	call	c_lcmp
 960  026b 25e8          	jrult	L553
 962  026d acbb01bb      	jpf	L733
 963  0271               L56:
 964                     ; 132 			ADC1_DeInit();
 966  0271 cd0000        	call	_ADC1_DeInit
 968                     ; 133 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 968                     ; 134 							 AIN4,
 968                     ; 135 							 ADC1_PRESSEL_FCPU_D2,//D18 
 968                     ; 136 							 ADC1_EXTTRIG_TIM, 
 968                     ; 137 							 DISABLE, 
 968                     ; 138 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 968                     ; 139 							 ADC1_SCHMITTTRIG_ALL, 
 968                     ; 140 							 DISABLE);
 970  0274 4b00          	push	#0
 971  0276 4bff          	push	#255
 972  0278 4b08          	push	#8
 973  027a 4b00          	push	#0
 974  027c 4b00          	push	#0
 975  027e 4b00          	push	#0
 976  0280 ae0104        	ldw	x,#260
 977  0283 cd0000        	call	_ADC1_Init
 979  0286 5b06          	addw	sp,#6
 980                     ; 141 			ADC1_Cmd(ENABLE);
 982  0288 a601          	ld	a,#1
 983  028a cd0000        	call	_ADC1_Cmd
 985  028d               L363:
 986                     ; 165 				rms=0;
 988  028d 5f            	clrw	x
 989  028e 1f33          	ldw	(OFST-5,sp),x
 991                     ; 167 				mean_sum=0;
 993  0290 ae0000        	ldw	x,#0
 994  0293 1f31          	ldw	(OFST-7,sp),x
 995  0295 ae0000        	ldw	x,#0
 996  0298 1f2f          	ldw	(OFST-9,sp),x
 998                     ; 168 				mean_low=mean+mean_threshold;
1000  029a 7b29          	ld	a,(OFST-15,sp)
1001  029c 5f            	clrw	x
1002  029d 1b28          	add	a,(OFST-16,sp)
1003  029f 2401          	jrnc	L62
1004  02a1 5c            	incw	x
1005  02a2               L62:
1006  02a2 cd0000        	call	c_itol
1008  02a5 96            	ldw	x,sp
1009  02a6 1c0019        	addw	x,#OFST-31
1010  02a9 cd0000        	call	c_rtol
1013                     ; 169 				mean_high=mean-mean_threshold;
1015  02ac 7b29          	ld	a,(OFST-15,sp)
1016  02ae 5f            	clrw	x
1017  02af 1028          	sub	a,(OFST-16,sp)
1018  02b1 2401          	jrnc	L03
1019  02b3 5a            	decw	x
1020  02b4               L03:
1021  02b4 cd0000        	call	c_itol
1023  02b7 96            	ldw	x,sp
1024  02b8 1c001d        	addw	x,#OFST-27
1025  02bb cd0000        	call	c_rtol
1028                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1030  02be ae0000        	ldw	x,#0
1031  02c1 1f37          	ldw	(OFST-1,sp),x
1032  02c3 ae0000        	ldw	x,#0
1033  02c6 1f35          	ldw	(OFST-3,sp),x
1036  02c8 2058          	jra	L373
1037  02ca               L763:
1038                     ; 173 					ADC1_StartConversion();
1040  02ca cd0000        	call	_ADC1_StartConversion
1043  02cd               L104:
1044                     ; 174 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1046  02cd a680          	ld	a,#128
1047  02cf cd0000        	call	_ADC1_GetFlagStatus
1049  02d2 4d            	tnz	a
1050  02d3 27f8          	jreq	L104
1051                     ; 176 					reading=ADC1->DRL;
1053  02d5 c65405        	ld	a,21509
1054  02d8 6b2c          	ld	(OFST-12,sp),a
1056                     ; 177 					mean_sum += reading;
1058  02da 7b2c          	ld	a,(OFST-12,sp)
1059  02dc 96            	ldw	x,sp
1060  02dd 1c002f        	addw	x,#OFST-9
1061  02e0 cd0000        	call	c_lgadc
1064                     ; 178 					rms+=reading>mean_low || reading<mean_high;
1066  02e3 7b2c          	ld	a,(OFST-12,sp)
1067  02e5 b703          	ld	c_lreg+3,a
1068  02e7 3f02          	clr	c_lreg+2
1069  02e9 3f01          	clr	c_lreg+1
1070  02eb 3f00          	clr	c_lreg
1071  02ed 96            	ldw	x,sp
1072  02ee 1c0019        	addw	x,#OFST-31
1073  02f1 cd0000        	call	c_lcmp
1075  02f4 2213          	jrugt	L43
1076  02f6 7b2c          	ld	a,(OFST-12,sp)
1077  02f8 b703          	ld	c_lreg+3,a
1078  02fa 3f02          	clr	c_lreg+2
1079  02fc 3f01          	clr	c_lreg+1
1080  02fe 3f00          	clr	c_lreg
1081  0300 96            	ldw	x,sp
1082  0301 1c001d        	addw	x,#OFST-27
1083  0304 cd0000        	call	c_lcmp
1085  0307 2405          	jruge	L23
1086  0309               L43:
1087  0309 ae0001        	ldw	x,#1
1088  030c 2001          	jra	L63
1089  030e               L23:
1090  030e 5f            	clrw	x
1091  030f               L63:
1092  030f 72fb33        	addw	x,(OFST-5,sp)
1093  0312 1f33          	ldw	(OFST-5,sp),x
1095                     ; 182 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1097  0314 a680          	ld	a,#128
1098  0316 cd0000        	call	_ADC1_ClearFlag
1100                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1102  0319 96            	ldw	x,sp
1103  031a 1c0035        	addw	x,#OFST-3
1104  031d a601          	ld	a,#1
1105  031f cd0000        	call	c_lgadc
1108  0322               L373:
1111  0322 96            	ldw	x,sp
1112  0323 1c0035        	addw	x,#OFST-3
1113  0326 cd0000        	call	c_ltor
1115  0329 96            	ldw	x,sp
1116  032a 1c0021        	addw	x,#OFST-23
1117  032d cd0000        	call	c_lcmp
1119  0330 2598          	jrult	L763
1120                     ; 186 				if(rms>9) mean_threshold++;
1122  0332 1e33          	ldw	x,(OFST-5,sp)
1123  0334 a3000a        	cpw	x,#10
1124  0337 2502          	jrult	L504
1127  0339 0c28          	inc	(OFST-16,sp)
1129  033b               L504:
1130                     ; 187 				if(rms==0) mean_threshold--;
1132  033b 1e33          	ldw	x,(OFST-5,sp)
1133  033d 2602          	jrne	L704
1136  033f 0a28          	dec	(OFST-16,sp)
1138  0341               L704:
1139                     ; 188 				mean=(mean_sum)/(adc_captures);
1141  0341 96            	ldw	x,sp
1142  0342 1c002f        	addw	x,#OFST-9
1143  0345 cd0000        	call	c_ltor
1145  0348 96            	ldw	x,sp
1146  0349 1c0021        	addw	x,#OFST-23
1147  034c cd0000        	call	c_ludv
1149  034f b603          	ld	a,c_lreg+3
1150  0351 6b29          	ld	(OFST-15,sp),a
1152                     ; 189 				if(sound_level/32<mean_threshold) sound_level++;
1154  0353 1e2a          	ldw	x,(OFST-14,sp)
1155  0355 54            	srlw	x
1156  0356 54            	srlw	x
1157  0357 54            	srlw	x
1158  0358 54            	srlw	x
1159  0359 54            	srlw	x
1160  035a 7b28          	ld	a,(OFST-16,sp)
1161  035c 905f          	clrw	y
1162  035e 9097          	ld	yl,a
1163  0360 90bf00        	ldw	c_y,y
1164  0363 b300          	cpw	x,c_y
1165  0365 2407          	jruge	L114
1168  0367 1e2a          	ldw	x,(OFST-14,sp)
1169  0369 1c0001        	addw	x,#1
1170  036c 1f2a          	ldw	(OFST-14,sp),x
1172  036e               L114:
1173                     ; 190 				if(sound_level/32>mean_threshold) sound_level--;
1175  036e 1e2a          	ldw	x,(OFST-14,sp)
1176  0370 54            	srlw	x
1177  0371 54            	srlw	x
1178  0372 54            	srlw	x
1179  0373 54            	srlw	x
1180  0374 54            	srlw	x
1181  0375 7b28          	ld	a,(OFST-16,sp)
1182  0377 905f          	clrw	y
1183  0379 9097          	ld	yl,a
1184  037b 90bf00        	ldw	c_y,y
1185  037e b300          	cpw	x,c_y
1186  0380 2307          	jrule	L314
1189  0382 1e2a          	ldw	x,(OFST-14,sp)
1190  0384 1d0001        	subw	x,#1
1191  0387 1f2a          	ldw	(OFST-14,sp),x
1193  0389               L314:
1194                     ; 191 				if(debug%4==0)
1196  0389 1e2d          	ldw	x,(OFST-11,sp)
1197  038b a604          	ld	a,#4
1198  038d cd0000        	call	c_smodx
1200  0390 a30000        	cpw	x,#0
1201  0393 267b          	jrne	L514
1202                     ; 193 					Serial_print_string("adc: ");
1204  0395 ae00e4        	ldw	x,#L153
1205  0398 cd0687        	call	_Serial_print_string
1207                     ; 194 					Serial_print_int(mean);
1209  039b 7b29          	ld	a,(OFST-15,sp)
1210  039d 5f            	clrw	x
1211  039e 97            	ld	xl,a
1212  039f cd06b0        	call	_Serial_print_int
1214                     ; 195 					Serial_print_string(", ");
1216  03a2 ae00e1        	ldw	x,#L353
1217  03a5 cd0687        	call	_Serial_print_string
1219                     ; 196 					if(rms<9) Serial_print_string("0");
1221  03a8 1e33          	ldw	x,(OFST-5,sp)
1222  03aa a30009        	cpw	x,#9
1223  03ad 2406          	jruge	L714
1226  03af ae00df        	ldw	x,#L124
1227  03b2 cd0687        	call	_Serial_print_string
1229  03b5               L714:
1230                     ; 197 					if(rms==0) Serial_print_string("0");
1232  03b5 1e33          	ldw	x,(OFST-5,sp)
1233  03b7 2606          	jrne	L324
1236  03b9 ae00df        	ldw	x,#L124
1237  03bc cd0687        	call	_Serial_print_string
1239  03bf               L324:
1240                     ; 198 					Serial_print_int(rms);
1242  03bf 1e33          	ldw	x,(OFST-5,sp)
1243  03c1 cd06b0        	call	_Serial_print_int
1245                     ; 199 					Serial_print_string(", ");
1247  03c4 ae00e1        	ldw	x,#L353
1248  03c7 cd0687        	call	_Serial_print_string
1250                     ; 200 					if(mean_threshold<9) Serial_print_string("0");
1252  03ca 7b28          	ld	a,(OFST-16,sp)
1253  03cc a109          	cp	a,#9
1254  03ce 2406          	jruge	L524
1257  03d0 ae00df        	ldw	x,#L124
1258  03d3 cd0687        	call	_Serial_print_string
1260  03d6               L524:
1261                     ; 201 					Serial_print_int(mean_threshold);
1263  03d6 7b28          	ld	a,(OFST-16,sp)
1264  03d8 5f            	clrw	x
1265  03d9 97            	ld	xl,a
1266  03da cd06b0        	call	_Serial_print_int
1268                     ; 202 					Serial_print_string(", ");
1270  03dd ae00e1        	ldw	x,#L353
1271  03e0 cd0687        	call	_Serial_print_string
1273                     ; 203 					if(sound_level/8<9) Serial_print_string("0");
1275  03e3 1e2a          	ldw	x,(OFST-14,sp)
1276  03e5 54            	srlw	x
1277  03e6 54            	srlw	x
1278  03e7 54            	srlw	x
1279  03e8 a30009        	cpw	x,#9
1280  03eb 2406          	jruge	L724
1283  03ed ae00df        	ldw	x,#L124
1284  03f0 cd0687        	call	_Serial_print_string
1286  03f3               L724:
1287                     ; 204 					Serial_print_int(sound_level/8);
1289  03f3 1e2a          	ldw	x,(OFST-14,sp)
1290  03f5 54            	srlw	x
1291  03f6 54            	srlw	x
1292  03f7 54            	srlw	x
1293  03f8 cd06b0        	call	_Serial_print_int
1295                     ; 205 					if(debug%10==0) Serial_print_string("*");
1297  03fb 1e2d          	ldw	x,(OFST-11,sp)
1298  03fd a60a          	ld	a,#10
1299  03ff cd0000        	call	c_smodx
1301  0402 a30000        	cpw	x,#0
1302  0405 2606          	jrne	L134
1305  0407 ae00dd        	ldw	x,#L334
1306  040a cd0687        	call	_Serial_print_string
1308  040d               L134:
1309                     ; 206 					Serial_newline();
1311  040d cd0713        	call	_Serial_newline
1313  0410               L514:
1314                     ; 208 				if(mean_threshold>10)
1316  0410 7b28          	ld	a,(OFST-16,sp)
1317  0412 a10b          	cp	a,#11
1318  0414 2518          	jrult	L534
1319                     ; 212 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1321  0416 4bd0          	push	#208
1322  0418 4b08          	push	#8
1323  041a ae500a        	ldw	x,#20490
1324  041d cd0000        	call	_GPIO_Init
1326  0420 85            	popw	x
1327                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1329  0421 4bc0          	push	#192
1330  0423 4b20          	push	#32
1331  0425 ae500a        	ldw	x,#20490
1332  0428 cd0000        	call	_GPIO_Init
1334  042b 85            	popw	x
1336  042c 2016          	jra	L734
1337  042e               L534:
1338                     ; 215 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1340  042e 4bd0          	push	#208
1341  0430 4b10          	push	#16
1342  0432 ae500a        	ldw	x,#20490
1343  0435 cd0000        	call	_GPIO_Init
1345  0438 85            	popw	x
1346                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1348  0439 4bc0          	push	#192
1349  043b 4b40          	push	#64
1350  043d ae500a        	ldw	x,#20490
1351  0440 cd0000        	call	_GPIO_Init
1353  0443 85            	popw	x
1354  0444               L734:
1355                     ; 218 			for(iter=0;iter<10;iter++){}
1357  0444 ae0000        	ldw	x,#0
1358  0447 1f37          	ldw	(OFST-1,sp),x
1359  0449 ae0000        	ldw	x,#0
1360  044c 1f35          	ldw	(OFST-3,sp),x
1362  044e               L144:
1365  044e 96            	ldw	x,sp
1366  044f 1c0035        	addw	x,#OFST-3
1367  0452 a601          	ld	a,#1
1368  0454 cd0000        	call	c_lgadc
1373  0457 96            	ldw	x,sp
1374  0458 1c0035        	addw	x,#OFST-3
1375  045b cd0000        	call	c_ltor
1377  045e ae001c        	ldw	x,#L04
1378  0461 cd0000        	call	c_lcmp
1380  0464 25e8          	jrult	L144
1381                     ; 219 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1383  0466 4b00          	push	#0
1384  0468 4bf8          	push	#248
1385  046a ae500a        	ldw	x,#20490
1386  046d cd0000        	call	_GPIO_Init
1388  0470 85            	popw	x
1389                     ; 220 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1391  0471 4b00          	push	#0
1392  0473 4b04          	push	#4
1393  0475 ae500f        	ldw	x,#20495
1394  0478 cd0000        	call	_GPIO_Init
1396  047b 85            	popw	x
1397                     ; 222 				debug++;
1399  047c 1e2d          	ldw	x,(OFST-11,sp)
1400  047e 1c0001        	addw	x,#1
1401  0481 1f2d          	ldw	(OFST-11,sp),x
1404  0483 ac8d028d      	jpf	L363
1405  0487               L76:
1406                     ; 228 			ADC1_DeInit();
1408  0487 cd0000        	call	_ADC1_DeInit
1410                     ; 229 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1410                     ; 230 							 AIN4,
1410                     ; 231 							 ADC1_PRESSEL_FCPU_D2,//D18 
1410                     ; 232 							 ADC1_EXTTRIG_TIM, 
1410                     ; 233 							 DISABLE, 
1410                     ; 234 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1410                     ; 235 							 ADC1_SCHMITTTRIG_ALL, 
1410                     ; 236 							 DISABLE);
1412  048a 4b00          	push	#0
1413  048c 4bff          	push	#255
1414  048e 4b08          	push	#8
1415  0490 4b00          	push	#0
1416  0492 4b00          	push	#0
1417  0494 4b00          	push	#0
1418  0496 ae0104        	ldw	x,#260
1419  0499 cd0000        	call	_ADC1_Init
1421  049c 5b06          	addw	sp,#6
1422                     ; 237 			ADC1_Cmd(ENABLE);
1424  049e a601          	ld	a,#1
1425  04a0 cd0000        	call	_ADC1_Cmd
1427  04a3               L744:
1428                     ; 240 				debug++;
1430  04a3 1e2d          	ldw	x,(OFST-11,sp)
1431  04a5 1c0001        	addw	x,#1
1432  04a8 1f2d          	ldw	(OFST-11,sp),x
1434                     ; 241 				rms=0;//8 bit
1436  04aa 5f            	clrw	x
1437  04ab 1f33          	ldw	(OFST-5,sp),x
1439                     ; 243 				mean_sum=0;//16 bit
1441  04ad ae0000        	ldw	x,#0
1442  04b0 1f31          	ldw	(OFST-7,sp),x
1443  04b2 ae0000        	ldw	x,#0
1444  04b5 1f2f          	ldw	(OFST-9,sp),x
1446                     ; 246 				iter=0;
1448  04b7 ae0000        	ldw	x,#0
1449  04ba 1f37          	ldw	(OFST-1,sp),x
1450  04bc ae0000        	ldw	x,#0
1451  04bf 1f35          	ldw	(OFST-3,sp),x
1453  04c1               L354:
1454                     ; 249 					ADC1_StartConversion();
1456  04c1 cd0000        	call	_ADC1_StartConversion
1459  04c4               L364:
1460                     ; 250 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1462  04c4 a680          	ld	a,#128
1463  04c6 cd0000        	call	_ADC1_GetFlagStatus
1465  04c9 4d            	tnz	a
1466  04ca 27f8          	jreq	L364
1467                     ; 252 					reading=ADC1->DRL;
1469  04cc c65405        	ld	a,21509
1470  04cf 6b2c          	ld	(OFST-12,sp),a
1472                     ; 253 					mean_sum += reading;
1474  04d1 7b2c          	ld	a,(OFST-12,sp)
1475  04d3 96            	ldw	x,sp
1476  04d4 1c002f        	addw	x,#OFST-9
1477  04d7 cd0000        	call	c_lgadc
1480                     ; 255 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1482  04da 7b2c          	ld	a,(OFST-12,sp)
1483  04dc 1129          	cp	a,(OFST-15,sp)
1484  04de 2306          	jrule	L24
1485  04e0 7b2c          	ld	a,(OFST-12,sp)
1486  04e2 1029          	sub	a,(OFST-15,sp)
1487  04e4 2004          	jra	L44
1488  04e6               L24:
1489  04e6 7b29          	ld	a,(OFST-15,sp)
1490  04e8 102c          	sub	a,(OFST-12,sp)
1491  04ea               L44:
1492  04ea 6b28          	ld	(OFST-16,sp),a
1494                     ; 256 					rms+=mean_diff>mean_threshold_8;
1496  04ec 7b28          	ld	a,(OFST-16,sp)
1497  04ee 1127          	cp	a,(OFST-17,sp)
1498  04f0 2305          	jrule	L64
1499  04f2 ae0001        	ldw	x,#1
1500  04f5 2001          	jra	L05
1501  04f7               L64:
1502  04f7 5f            	clrw	x
1503  04f8               L05:
1504  04f8 72fb33        	addw	x,(OFST-5,sp)
1505  04fb 1f33          	ldw	(OFST-5,sp),x
1507                     ; 258 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1509  04fd a680          	ld	a,#128
1510  04ff cd0000        	call	_ADC1_ClearFlag
1512                     ; 261 					iter++;
1514  0502 96            	ldw	x,sp
1515  0503 1c0035        	addw	x,#OFST-3
1516  0506 a601          	ld	a,#1
1517  0508 cd0000        	call	c_lgadc
1520                     ; 262 					iter%=256;//8 bit unsigned
1522  050b 0f37          	clr	(OFST-1,sp)
1523  050d 0f36          	clr	(OFST-2,sp)
1524  050f 0f35          	clr	(OFST-3,sp)
1526                     ; 263 				}while(iter!=0);//run 255 times
1528  0511 96            	ldw	x,sp
1529  0512 1c0035        	addw	x,#OFST-3
1530  0515 cd0000        	call	c_lzmp
1532  0518 26a7          	jrne	L354
1533                     ; 264 				mean=((uint16_t)mean+mean_sum/256)/2;
1535  051a 96            	ldw	x,sp
1536  051b 1c002f        	addw	x,#OFST-9
1537  051e cd0000        	call	c_ltor
1539  0521 a608          	ld	a,#8
1540  0523 cd0000        	call	c_lursh
1542  0526 96            	ldw	x,sp
1543  0527 1c0001        	addw	x,#OFST-55
1544  052a cd0000        	call	c_rtol
1547  052d 7b29          	ld	a,(OFST-15,sp)
1548  052f b703          	ld	c_lreg+3,a
1549  0531 3f02          	clr	c_lreg+2
1550  0533 3f01          	clr	c_lreg+1
1551  0535 3f00          	clr	c_lreg
1552  0537 96            	ldw	x,sp
1553  0538 1c0001        	addw	x,#OFST-55
1554  053b cd0000        	call	c_ladd
1556  053e 3400          	srl	c_lreg
1557  0540 3601          	rrc	c_lreg+1
1558  0542 3602          	rrc	c_lreg+2
1559  0544 3603          	rrc	c_lreg+3
1560  0546 b603          	ld	a,c_lreg+3
1561  0548 6b29          	ld	(OFST-15,sp),a
1563                     ; 265 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1565  054a 96            	ldw	x,sp
1566  054b 1c0009        	addw	x,#OFST-47
1567  054e 1f03          	ldw	(OFST-53,sp),x
1569  0550 1e33          	ldw	x,(OFST-5,sp)
1570  0552 54            	srlw	x
1571  0553 54            	srlw	x
1572  0554 54            	srlw	x
1573  0555 54            	srlw	x
1574  0556 72fb03        	addw	x,(OFST-53,sp)
1575  0559 f6            	ld	a,(x)
1576  055a 5f            	clrw	x
1577  055b 97            	ld	xl,a
1578  055c 1625          	ldw	y,(OFST-19,sp)
1579  055e cd0000        	call	c_imul
1581  0561 54            	srlw	x
1582  0562 54            	srlw	x
1583  0563 54            	srlw	x
1584  0564 54            	srlw	x
1585  0565 54            	srlw	x
1586  0566 72fb25        	addw	x,(OFST-19,sp)
1587  0569 54            	srlw	x
1588  056a 1f25          	ldw	(OFST-19,sp),x
1590                     ; 266 				mean_threshold_8=mean_threshold_16/256;
1592  056c 7b25          	ld	a,(OFST-19,sp)
1593  056e 6b27          	ld	(OFST-17,sp),a
1595                     ; 267 				if(mean_threshold_8==0)
1597  0570 0d27          	tnz	(OFST-17,sp)
1598  0572 2609          	jrne	L764
1599                     ; 269 					mean_threshold_8=1;
1601  0574 a601          	ld	a,#1
1602  0576 6b27          	ld	(OFST-17,sp),a
1604                     ; 270 					mean_threshold_16=0x0100;
1606  0578 ae0100        	ldw	x,#256
1607  057b 1f25          	ldw	(OFST-19,sp),x
1609  057d               L764:
1610                     ; 275 					if(mean==0) Serial_print_string("0");
1612  057d 0d29          	tnz	(OFST-15,sp)
1613  057f 2606          	jrne	L174
1616  0581 ae00df        	ldw	x,#L124
1617  0584 cd0687        	call	_Serial_print_string
1619  0587               L174:
1620                     ; 276 					Serial_print_int(mean);
1622  0587 7b29          	ld	a,(OFST-15,sp)
1623  0589 5f            	clrw	x
1624  058a 97            	ld	xl,a
1625  058b cd06b0        	call	_Serial_print_int
1627                     ; 278 					Serial_print_string(" ");
1629  058e ae00db        	ldw	x,#L374
1630  0591 cd0687        	call	_Serial_print_string
1632                     ; 281 					if(rms==0) Serial_print_string("0");
1634  0594 1e33          	ldw	x,(OFST-5,sp)
1635  0596 2606          	jrne	L574
1638  0598 ae00df        	ldw	x,#L124
1639  059b cd0687        	call	_Serial_print_string
1641  059e               L574:
1642                     ; 282 					Serial_print_int(rms);
1644  059e 1e33          	ldw	x,(OFST-5,sp)
1645  05a0 cd06b0        	call	_Serial_print_int
1647                     ; 284 					Serial_print_string(" ");
1649  05a3 ae00db        	ldw	x,#L374
1650  05a6 cd0687        	call	_Serial_print_string
1652                     ; 285 					if(mean_threshold_8==0) Serial_print_string("0");
1654  05a9 0d27          	tnz	(OFST-17,sp)
1655  05ab 2606          	jrne	L774
1658  05ad ae00df        	ldw	x,#L124
1659  05b0 cd0687        	call	_Serial_print_string
1661  05b3               L774:
1662                     ; 286 					Serial_print_int(mean_threshold_8);
1664  05b3 7b27          	ld	a,(OFST-17,sp)
1665  05b5 5f            	clrw	x
1666  05b6 97            	ld	xl,a
1667  05b7 cd06b0        	call	_Serial_print_int
1669                     ; 288 					Serial_newline();
1671  05ba cd0713        	call	_Serial_newline
1674  05bd aca304a3      	jpf	L744
1675  05c1               L17:
1676                     ; 294 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1678  05c1 4b40          	push	#64
1679  05c3 4b20          	push	#32
1680  05c5 ae500f        	ldw	x,#20495
1681  05c8 cd0000        	call	_GPIO_Init
1683  05cb 85            	popw	x
1684                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1686  05cc 4b40          	push	#64
1687  05ce 4b40          	push	#64
1688  05d0 ae500f        	ldw	x,#20495
1689  05d3 cd0000        	call	_GPIO_Init
1691  05d6 85            	popw	x
1692  05d7               L105:
1693                     ; 298 			  setMatrixHighZ();
1695  05d7 cd0722        	call	_setMatrixHighZ
1697                     ; 299 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1699  05da 4b20          	push	#32
1700  05dc ae500f        	ldw	x,#20495
1701  05df cd0000        	call	_GPIO_ReadInputPin
1703  05e2 5b01          	addw	sp,#1
1704  05e4 4d            	tnz	a
1705  05e5 2618          	jrne	L505
1706                     ; 303 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1708  05e7 4bd0          	push	#208
1709  05e9 4b08          	push	#8
1710  05eb ae500a        	ldw	x,#20490
1711  05ee cd0000        	call	_GPIO_Init
1713  05f1 85            	popw	x
1714                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1716  05f2 4bc0          	push	#192
1717  05f4 4b20          	push	#32
1718  05f6 ae500a        	ldw	x,#20490
1719  05f9 cd0000        	call	_GPIO_Init
1721  05fc 85            	popw	x
1723  05fd 20d8          	jra	L105
1724  05ff               L505:
1725                     ; 305 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1727  05ff 4b40          	push	#64
1728  0601 ae500f        	ldw	x,#20495
1729  0604 cd0000        	call	_GPIO_ReadInputPin
1731  0607 5b01          	addw	sp,#1
1732  0609 4d            	tnz	a
1733  060a 26cb          	jrne	L105
1734                     ; 306 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1736  060c 4bd0          	push	#208
1737  060e 4b10          	push	#16
1738  0610 ae500a        	ldw	x,#20490
1739  0613 cd0000        	call	_GPIO_Init
1741  0616 85            	popw	x
1742                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1744  0617 4bc0          	push	#192
1745  0619 4b40          	push	#64
1746  061b ae500a        	ldw	x,#20490
1747  061e cd0000        	call	_GPIO_Init
1749  0621 85            	popw	x
1750  0622 20b3          	jra	L105
1751  0624               L37:
1752                     ; 313 			Serial_print_string("Mode: ");
1754  0624 ae00d4        	ldw	x,#L315
1755  0627 ad5e          	call	_Serial_print_string
1757                     ; 314 			Serial_print_int(test_mode);
1759  0629 1e33          	ldw	x,(OFST-5,sp)
1760  062b cd06b0        	call	_Serial_print_int
1762                     ; 315 			Serial_newline();
1764  062e cd0713        	call	_Serial_newline
1766                     ; 316 			TIM4->PSCR= 7;
1768  0631 35075347      	mov	21319,#7
1769                     ; 317 			TIM4->ARR= 256 - (u8)(-128);
1771  0635 35805348      	mov	21320,#128
1772                     ; 318 			TIM4->EGR= TIM4_EGR_UG;
1774  0639 35015345      	mov	21317,#1
1775                     ; 319 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;
1777  063d c65340        	ld	a,21312
1778  0640 aa85          	or	a,#133
1779  0642 c75340        	ld	21312,a
1780                     ; 320 			TIM4->IER= TIM4_IER_UIE;
1782  0645 35015343      	mov	21315,#1
1783                     ; 321 			enableInterrupts();
1786  0649 9a            rim
1788  064a               L515:
1789                     ; 324 				for(iter=0;iter<30000;iter++){}
1791  064a ae0000        	ldw	x,#0
1792  064d 1f37          	ldw	(OFST-1,sp),x
1793  064f ae0000        	ldw	x,#0
1794  0652 1f35          	ldw	(OFST-3,sp),x
1796  0654               L125:
1799  0654 96            	ldw	x,sp
1800  0655 1c0035        	addw	x,#OFST-3
1801  0658 a601          	ld	a,#1
1802  065a cd0000        	call	c_lgadc
1807  065d 96            	ldw	x,sp
1808  065e 1c0035        	addw	x,#OFST-3
1809  0661 cd0000        	call	c_ltor
1811  0664 ae0014        	ldw	x,#L21
1812  0667 cd0000        	call	c_lcmp
1814  066a 25e8          	jrult	L125
1815                     ; 325 				Serial_print_string("time: ");
1817  066c ae00cd        	ldw	x,#L725
1818  066f ad16          	call	_Serial_print_string
1820                     ; 326 				Serial_print_int(tms);
1822  0671 be02          	ldw	x,_tms+2
1823  0673 ad3b          	call	_Serial_print_int
1825                     ; 327 				Serial_newline();
1827  0675 cd0713        	call	_Serial_newline
1830  0678 20d0          	jra	L515
1855                     ; 334 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
1857                     	switch	.text
1858  067a               f_TIM4_UPD_OVF_IRQHandler:
1862                     ; 335 	TIM4->SR1&=~TIM4_SR1_UIF;
1864  067a 72115344      	bres	21316,#0
1865                     ; 336 	tms++;
1867  067e ae0000        	ldw	x,#_tms
1868  0681 a601          	ld	a,#1
1869  0683 cd0000        	call	c_lgadc
1871                     ; 337 }
1874  0686 80            	iret
1920                     ; 360  void Serial_print_string (char string[])
1920                     ; 361  {
1922                     	switch	.text
1923  0687               _Serial_print_string:
1925  0687 89            	pushw	x
1926  0688 88            	push	a
1927       00000001      OFST:	set	1
1930                     ; 363 	 char i=0;
1932  0689 0f01          	clr	(OFST+0,sp)
1935  068b 2016          	jra	L765
1936  068d               L365:
1937                     ; 367 		UART1_SendData8(string[i]);
1939  068d 7b01          	ld	a,(OFST+0,sp)
1940  068f 5f            	clrw	x
1941  0690 97            	ld	xl,a
1942  0691 72fb02        	addw	x,(OFST+1,sp)
1943  0694 f6            	ld	a,(x)
1944  0695 cd0000        	call	_UART1_SendData8
1947  0698               L575:
1948                     ; 368 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
1950  0698 ae0080        	ldw	x,#128
1951  069b cd0000        	call	_UART1_GetFlagStatus
1953  069e 4d            	tnz	a
1954  069f 27f7          	jreq	L575
1955                     ; 369 		i++;
1957  06a1 0c01          	inc	(OFST+0,sp)
1959  06a3               L765:
1960                     ; 365 	 while (string[i] != 0x00)
1962  06a3 7b01          	ld	a,(OFST+0,sp)
1963  06a5 5f            	clrw	x
1964  06a6 97            	ld	xl,a
1965  06a7 72fb02        	addw	x,(OFST+1,sp)
1966  06aa 7d            	tnz	(x)
1967  06ab 26e0          	jrne	L365
1968                     ; 371  }
1971  06ad 5b03          	addw	sp,#3
1972  06af 81            	ret
1975                     	switch	.const
1976  0020               L106_digit:
1977  0020 00            	dc.b	0
1978  0021 00000000      	ds.b	4
2031                     ; 373  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2031                     ; 374  {
2032                     	switch	.text
2033  06b0               _Serial_print_int:
2035  06b0 89            	pushw	x
2036  06b1 5208          	subw	sp,#8
2037       00000008      OFST:	set	8
2040                     ; 375 	 char count = 0;
2042  06b3 0f08          	clr	(OFST+0,sp)
2044                     ; 376 	 char digit[5] = "";
2046  06b5 96            	ldw	x,sp
2047  06b6 1c0003        	addw	x,#OFST-5
2048  06b9 90ae0020      	ldw	y,#L106_digit
2049  06bd a605          	ld	a,#5
2050  06bf cd0000        	call	c_xymov
2053  06c2 2023          	jra	L536
2054  06c4               L136:
2055                     ; 380 		 digit[count] = number%10;
2057  06c4 96            	ldw	x,sp
2058  06c5 1c0003        	addw	x,#OFST-5
2059  06c8 9f            	ld	a,xl
2060  06c9 5e            	swapw	x
2061  06ca 1b08          	add	a,(OFST+0,sp)
2062  06cc 2401          	jrnc	L47
2063  06ce 5c            	incw	x
2064  06cf               L47:
2065  06cf 02            	rlwa	x,a
2066  06d0 1609          	ldw	y,(OFST+1,sp)
2067  06d2 a60a          	ld	a,#10
2068  06d4 cd0000        	call	c_smody
2070  06d7 9001          	rrwa	y,a
2071  06d9 f7            	ld	(x),a
2072  06da 9002          	rlwa	y,a
2073                     ; 381 		 count++;
2075  06dc 0c08          	inc	(OFST+0,sp)
2077                     ; 382 		 number = number/10;
2079  06de 1e09          	ldw	x,(OFST+1,sp)
2080  06e0 a60a          	ld	a,#10
2081  06e2 cd0000        	call	c_sdivx
2083  06e5 1f09          	ldw	(OFST+1,sp),x
2084  06e7               L536:
2085                     ; 378 	 while (number != 0) //split the int to char array 
2087  06e7 1e09          	ldw	x,(OFST+1,sp)
2088  06e9 26d9          	jrne	L136
2090  06eb 201f          	jra	L346
2091  06ed               L146:
2092                     ; 387 		UART1_SendData8(digit[count-1] + 0x30);
2094  06ed 96            	ldw	x,sp
2095  06ee 1c0003        	addw	x,#OFST-5
2096  06f1 1f01          	ldw	(OFST-7,sp),x
2098  06f3 7b08          	ld	a,(OFST+0,sp)
2099  06f5 5f            	clrw	x
2100  06f6 97            	ld	xl,a
2101  06f7 5a            	decw	x
2102  06f8 72fb01        	addw	x,(OFST-7,sp)
2103  06fb f6            	ld	a,(x)
2104  06fc ab30          	add	a,#48
2105  06fe cd0000        	call	_UART1_SendData8
2108  0701               L156:
2109                     ; 388 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2111  0701 ae0080        	ldw	x,#128
2112  0704 cd0000        	call	_UART1_GetFlagStatus
2114  0707 4d            	tnz	a
2115  0708 27f7          	jreq	L156
2116                     ; 389 		count--; 
2118  070a 0a08          	dec	(OFST+0,sp)
2120  070c               L346:
2121                     ; 385 	 while (count !=0) //print char array in correct direction 
2123  070c 0d08          	tnz	(OFST+0,sp)
2124  070e 26dd          	jrne	L146
2125                     ; 391  }
2128  0710 5b0a          	addw	sp,#10
2129  0712 81            	ret
2154                     ; 393  void Serial_newline(void)
2154                     ; 394  {
2155                     	switch	.text
2156  0713               _Serial_newline:
2160                     ; 395 	 UART1_SendData8(0x0a);
2162  0713 a60a          	ld	a,#10
2163  0715 cd0000        	call	_UART1_SendData8
2166  0718               L766:
2167                     ; 396 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2169  0718 ae0080        	ldw	x,#128
2170  071b cd0000        	call	_UART1_GetFlagStatus
2172  071e 4d            	tnz	a
2173  071f 27f7          	jreq	L766
2174                     ; 397  }
2177  0721 81            	ret
2201                     ; 399 void setMatrixHighZ()
2201                     ; 400 {
2202                     	switch	.text
2203  0722               _setMatrixHighZ:
2207                     ; 405 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2209  0722 4b00          	push	#0
2210  0724 4bf8          	push	#248
2211  0726 ae500a        	ldw	x,#20490
2212  0729 cd0000        	call	_GPIO_Init
2214  072c 85            	popw	x
2215                     ; 406 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2217  072d 4b00          	push	#0
2218  072f 4b0c          	push	#12
2219  0731 ae500f        	ldw	x,#20495
2220  0734 cd0000        	call	_GPIO_Init
2222  0737 85            	popw	x
2223                     ; 407 }
2226  0738 81            	ret
2270                     ; 409 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2271                     	switch	.text
2272  0739               _setRGB:
2274  0739 89            	pushw	x
2275       00000000      OFST:	set	0
2280  073a 1e05          	ldw	x,(OFST+5,sp)
2281  073c 89            	pushw	x
2282  073d 1e03          	ldw	x,(OFST+3,sp)
2283  073f 89            	pushw	x
2284  0740 a601          	ld	a,#1
2285  0742 ad11          	call	_setLED
2287  0744 5b04          	addw	sp,#4
2291  0746 85            	popw	x
2292  0747 81            	ret
2327                     ; 410 void setWhite(int led_index){ setLED(0,led_index,0); }
2328                     	switch	.text
2329  0748               _setWhite:
2331  0748 89            	pushw	x
2332       00000000      OFST:	set	0
2337  0749 5f            	clrw	x
2338  074a 89            	pushw	x
2339  074b 1e03          	ldw	x,(OFST+3,sp)
2340  074d 89            	pushw	x
2341  074e 4f            	clr	a
2342  074f ad04          	call	_setLED
2344  0751 5b04          	addw	sp,#4
2348  0753 85            	popw	x
2349  0754 81            	ret
2352                     	switch	.const
2353  0025               L347_rgb_lookup:
2354  0025 0000          	dc.w	0
2355  0027 0001          	dc.w	1
2356  0029 0000          	dc.w	0
2357  002b 0002          	dc.w	2
2358  002d 0001          	dc.w	1
2359  002f 0002          	dc.w	2
2360  0031 0001          	dc.w	1
2361  0033 0000          	dc.w	0
2362  0035 0002          	dc.w	2
2363  0037 0000          	dc.w	0
2364  0039 0002          	dc.w	2
2365  003b 0001          	dc.w	1
2366  003d 0005          	dc.w	5
2367  003f 0000          	dc.w	0
2368  0041 0005          	dc.w	5
2369  0043 0001          	dc.w	1
2370  0045 0005          	dc.w	5
2371  0047 0002          	dc.w	2
2372  0049 0006          	dc.w	6
2373  004b 0000          	dc.w	0
2374  004d 0006          	dc.w	6
2375  004f 0001          	dc.w	1
2376  0051 0006          	dc.w	6
2377  0053 0002          	dc.w	2
2378  0055 0006          	dc.w	6
2379  0057 0005          	dc.w	5
2380  0059 0006          	dc.w	6
2381  005b 0004          	dc.w	4
2382  005d 0005          	dc.w	5
2383  005f 0004          	dc.w	4
2384  0061 0004          	dc.w	4
2385  0063 0003          	dc.w	3
2386  0065 0005          	dc.w	5
2387  0067 0003          	dc.w	3
2388  0069 0006          	dc.w	6
2389  006b 0003          	dc.w	3
2390  006d 0003          	dc.w	3
2391  006f 0004          	dc.w	4
2392  0071 0003          	dc.w	3
2393  0073 0005          	dc.w	5
2394  0075 0003          	dc.w	3
2395  0077 0006          	dc.w	6
2396  0079 0000          	dc.w	0
2397  007b 0005          	dc.w	5
2398  007d 0000          	dc.w	0
2399  007f 0006          	dc.w	6
2400  0081 0001          	dc.w	1
2401  0083 0006          	dc.w	6
2402  0085 0000          	dc.w	0
2403  0087 0004          	dc.w	4
2404  0089 0001          	dc.w	1
2405  008b 0004          	dc.w	4
2406  008d 0002          	dc.w	2
2407  008f 0004          	dc.w	4
2408  0091 0000          	dc.w	0
2409  0093 0003          	dc.w	3
2410  0095 0001          	dc.w	1
2411  0097 0003          	dc.w	3
2412  0099 0002          	dc.w	2
2413  009b 0003          	dc.w	3
2414  009d               L547_white_lookup:
2415  009d 0003          	dc.w	3
2416  009f 0000          	dc.w	0
2417  00a1 0003          	dc.w	3
2418  00a3 0001          	dc.w	1
2419  00a5 0003          	dc.w	3
2420  00a7 0002          	dc.w	2
2421  00a9 0004          	dc.w	4
2422  00ab 0000          	dc.w	0
2423  00ad 0001          	dc.w	1
2424  00af 0005          	dc.w	5
2425  00b1 0002          	dc.w	2
2426  00b3 0005          	dc.w	5
2427  00b5 0004          	dc.w	4
2428  00b7 0001          	dc.w	1
2429  00b9 0004          	dc.w	4
2430  00bb 0002          	dc.w	2
2431  00bd 0002          	dc.w	2
2432  00bf 0006          	dc.w	6
2433  00c1 0004          	dc.w	4
2434  00c3 0006          	dc.w	6
2435  00c5 0004          	dc.w	4
2436  00c7 0005          	dc.w	5
2437  00c9 0005          	dc.w	5
2438  00cb 0006          	dc.w	6
2700                     ; 412 void setLED(bool is_rgb,int led_index,int rgb_index)
2700                     ; 413 {
2701                     	switch	.text
2702  0755               _setLED:
2704  0755 88            	push	a
2705  0756 52b6          	subw	sp,#182
2706       000000b6      OFST:	set	182
2709                     ; 414   const unsigned short rgb_lookup[10][3][2]={
2709                     ; 415 		{{0,1},{0,2},{1,2}},//7
2709                     ; 416 		{{1,0},{2,0},{2,1}},//3
2709                     ; 417 		{{5,0},{5,1},{5,2}},//1
2709                     ; 418 		{{6,0},{6,1},{6,2}},//20
2709                     ; 419 		{{6,5},{6,4},{5,4}},//22
2709                     ; 420 		{{4,3},{5,3},{6,3}},//23
2709                     ; 421 		{{3,4},{3,5},{3,6}},//21
2709                     ; 422 		{{0,5},{0,6},{1,6}},//19
2709                     ; 423 		{{0,4},{1,4},{2,4}},//18
2709                     ; 424 		{{0,3},{1,3},{2,3}} //2
2709                     ; 425 	};
2711  0758 96            	ldw	x,sp
2712  0759 1c000e        	addw	x,#OFST-168
2713  075c 90ae0025      	ldw	y,#L347_rgb_lookup
2714  0760 a678          	ld	a,#120
2715  0762 cd0000        	call	c_xymov
2717                     ; 426 	const unsigned short white_lookup[12][2]={
2717                     ; 427 		{3,0},//6
2717                     ; 428 		{3,1},//4
2717                     ; 429 		{3,2},//5
2717                     ; 430 		{4,0},//14
2717                     ; 431 		{1,5},//8
2717                     ; 432 		{2,5},//9
2717                     ; 433 		{4,1},//10
2717                     ; 434 		{4,2},//16
2717                     ; 435 		{2,6},//17
2717                     ; 436 		{4,6},//12
2717                     ; 437 		{4,5},//13
2717                     ; 438 		{5,6} //11
2717                     ; 439 	};
2719  0765 96            	ldw	x,sp
2720  0766 1c0086        	addw	x,#OFST-48
2721  0769 90ae009d      	ldw	y,#L547_white_lookup
2722  076d a630          	ld	a,#48
2723  076f cd0000        	call	c_xymov
2725                     ; 440 	bool is_low=0;
2727  0772 0fb6          	clr	(OFST+0,sp)
2729  0774               L5311:
2730                     ; 444 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
2732  0774 0db7          	tnz	(OFST+1,sp)
2733  0776 2726          	jreq	L011
2734  0778 7bb6          	ld	a,(OFST+0,sp)
2735  077a 5f            	clrw	x
2736  077b 97            	ld	xl,a
2737  077c 58            	sllw	x
2738  077d 1f09          	ldw	(OFST-173,sp),x
2740  077f 1ebc          	ldw	x,(OFST+6,sp)
2741  0781 58            	sllw	x
2742  0782 58            	sllw	x
2743  0783 1f07          	ldw	(OFST-175,sp),x
2745  0785 96            	ldw	x,sp
2746  0786 1c000e        	addw	x,#OFST-168
2747  0789 1f05          	ldw	(OFST-177,sp),x
2749  078b 1eba          	ldw	x,(OFST+4,sp)
2750  078d a60c          	ld	a,#12
2751  078f cd0000        	call	c_bmulx
2753  0792 72fb05        	addw	x,(OFST-177,sp)
2754  0795 72fb07        	addw	x,(OFST-175,sp)
2755  0798 72fb09        	addw	x,(OFST-173,sp)
2756  079b fe            	ldw	x,(x)
2757  079c 2018          	jra	L211
2758  079e               L011:
2759  079e 7bb6          	ld	a,(OFST+0,sp)
2760  07a0 5f            	clrw	x
2761  07a1 97            	ld	xl,a
2762  07a2 58            	sllw	x
2763  07a3 1f03          	ldw	(OFST-179,sp),x
2765  07a5 96            	ldw	x,sp
2766  07a6 1c0086        	addw	x,#OFST-48
2767  07a9 1f01          	ldw	(OFST-181,sp),x
2769  07ab 1eba          	ldw	x,(OFST+4,sp)
2770  07ad 58            	sllw	x
2771  07ae 58            	sllw	x
2772  07af 72fb01        	addw	x,(OFST-181,sp)
2773  07b2 72fb03        	addw	x,(OFST-179,sp)
2774  07b5 fe            	ldw	x,(x)
2775  07b6               L211:
2777                     ; 476 			}break;
2778  07b6 5d            	tnzw	x
2779  07b7 2714          	jreq	L747
2780  07b9 5a            	decw	x
2781  07ba 271c          	jreq	L157
2782  07bc 5a            	decw	x
2783  07bd 2724          	jreq	L357
2784  07bf 5a            	decw	x
2785  07c0 272c          	jreq	L557
2786  07c2 5a            	decw	x
2787  07c3 2734          	jreq	L757
2788  07c5 5a            	decw	x
2789  07c6 273c          	jreq	L167
2790  07c8 5a            	decw	x
2791  07c9 2744          	jreq	L367
2792  07cb 204b          	jra	L5411
2793  07cd               L747:
2794                     ; 447 				GPIOx=GPIOD;
2796  07cd ae500f        	ldw	x,#20495
2797  07d0 1f0b          	ldw	(OFST-171,sp),x
2799                     ; 448 				PortPin=GPIO_PIN_3;
2801  07d2 a608          	ld	a,#8
2802  07d4 6b0d          	ld	(OFST-169,sp),a
2804                     ; 449 			}break;
2806  07d6 2040          	jra	L5411
2807  07d8               L157:
2808                     ; 451 				GPIOx=GPIOD;
2810  07d8 ae500f        	ldw	x,#20495
2811  07db 1f0b          	ldw	(OFST-171,sp),x
2813                     ; 452 				PortPin=GPIO_PIN_2;
2815  07dd a604          	ld	a,#4
2816  07df 6b0d          	ld	(OFST-169,sp),a
2818                     ; 453 			}break;
2820  07e1 2035          	jra	L5411
2821  07e3               L357:
2822                     ; 455 				GPIOx=GPIOC;
2824  07e3 ae500a        	ldw	x,#20490
2825  07e6 1f0b          	ldw	(OFST-171,sp),x
2827                     ; 456 				PortPin=GPIO_PIN_7;
2829  07e8 a680          	ld	a,#128
2830  07ea 6b0d          	ld	(OFST-169,sp),a
2832                     ; 457 			}break;
2834  07ec 202a          	jra	L5411
2835  07ee               L557:
2836                     ; 459 				GPIOx=GPIOC;
2838  07ee ae500a        	ldw	x,#20490
2839  07f1 1f0b          	ldw	(OFST-171,sp),x
2841                     ; 460 				PortPin=GPIO_PIN_6;
2843  07f3 a640          	ld	a,#64
2844  07f5 6b0d          	ld	(OFST-169,sp),a
2846                     ; 461 			}break;
2848  07f7 201f          	jra	L5411
2849  07f9               L757:
2850                     ; 463 				GPIOx=GPIOC;
2852  07f9 ae500a        	ldw	x,#20490
2853  07fc 1f0b          	ldw	(OFST-171,sp),x
2855                     ; 464 				PortPin=GPIO_PIN_5;
2857  07fe a620          	ld	a,#32
2858  0800 6b0d          	ld	(OFST-169,sp),a
2860                     ; 465 			}break;
2862  0802 2014          	jra	L5411
2863  0804               L167:
2864                     ; 467 				GPIOx=GPIOC;
2866  0804 ae500a        	ldw	x,#20490
2867  0807 1f0b          	ldw	(OFST-171,sp),x
2869                     ; 468 				PortPin=GPIO_PIN_4;
2871  0809 a610          	ld	a,#16
2872  080b 6b0d          	ld	(OFST-169,sp),a
2874                     ; 469 			}break;
2876  080d 2009          	jra	L5411
2877  080f               L367:
2878                     ; 471 				GPIOx=GPIOC;
2880  080f ae500a        	ldw	x,#20490
2881  0812 1f0b          	ldw	(OFST-171,sp),x
2883                     ; 472 				PortPin=GPIO_PIN_3;
2885  0814 a608          	ld	a,#8
2886  0816 6b0d          	ld	(OFST-169,sp),a
2888                     ; 473 			}break;
2890  0818               L5411:
2891                     ; 478 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
2893  0818 0db6          	tnz	(OFST+0,sp)
2894  081a 2704          	jreq	L411
2895  081c a6c0          	ld	a,#192
2896  081e 2002          	jra	L611
2897  0820               L411:
2898  0820 a6d0          	ld	a,#208
2899  0822               L611:
2900  0822 88            	push	a
2901  0823 7b0e          	ld	a,(OFST-168,sp)
2902  0825 88            	push	a
2903  0826 1e0d          	ldw	x,(OFST-169,sp)
2904  0828 cd0000        	call	_GPIO_Init
2906  082b 85            	popw	x
2907                     ; 479 		is_low=!is_low;
2909  082c 0db6          	tnz	(OFST+0,sp)
2910  082e 2604          	jrne	L021
2911  0830 a601          	ld	a,#1
2912  0832 2001          	jra	L221
2913  0834               L021:
2914  0834 4f            	clr	a
2915  0835               L221:
2916  0835 6bb6          	ld	(OFST+0,sp),a
2918                     ; 480 	}while(is_low);
2920  0837 0db6          	tnz	(OFST+0,sp)
2921  0839 2703          	jreq	L421
2922  083b cc0774        	jp	L5311
2923  083e               L421:
2924                     ; 481 }
2927  083e 5bb7          	addw	sp,#183
2928  0840 81            	ret
2952                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2953                     	xdef	_main
2954                     	xdef	_Serial_print_string
2955                     	xdef	_Serial_newline
2956                     	xdef	_Serial_print_int
2957                     	xdef	_setWhite
2958                     	xdef	_setRGB
2959                     	xdef	_setLED
2960                     	xdef	_setMatrixHighZ
2961                     	xdef	_tms
2962                     	xdef	_ADC_Read
2963                     	xref	_UART1_GetFlagStatus
2964                     	xref	_UART1_SendData8
2965                     	xref	_UART1_Cmd
2966                     	xref	_UART1_Init
2967                     	xref	_UART1_DeInit
2968                     	xref	_GPIO_ReadInputPin
2969                     	xref	_GPIO_Init
2970                     	xref	_ADC1_ClearFlag
2971                     	xref	_ADC1_GetFlagStatus
2972                     	xref	_ADC1_GetConversionValue
2973                     	xref	_ADC1_StartConversion
2974                     	xref	_ADC1_Cmd
2975                     	xref	_ADC1_Init
2976                     	xref	_ADC1_DeInit
2977                     	switch	.const
2978  00cd               L725:
2979  00cd 74696d653a20  	dc.b	"time: ",0
2980  00d4               L315:
2981  00d4 4d6f64653a20  	dc.b	"Mode: ",0
2982  00db               L374:
2983  00db 2000          	dc.b	" ",0
2984  00dd               L334:
2985  00dd 2a00          	dc.b	"*",0
2986  00df               L124:
2987  00df 3000          	dc.b	"0",0
2988  00e1               L353:
2989  00e1 2c2000        	dc.b	", ",0
2990  00e4               L153:
2991  00e4 6164633a2000  	dc.b	"adc: ",0
2992  00ea               L123:
2993  00ea 636f756e7465  	dc.b	"counter: ",0
2994                     	xref.b	c_lreg
2995                     	xref.b	c_x
2996                     	xref.b	c_y
3016                     	xref	c_bmulx
3017                     	xref	c_sdivx
3018                     	xref	c_smody
3019                     	xref	c_imul
3020                     	xref	c_ladd
3021                     	xref	c_lursh
3022                     	xref	c_uitol
3023                     	xref	c_smodx
3024                     	xref	c_ludv
3025                     	xref	c_itol
3026                     	xref	c_rtol
3027                     	xref	c_uitolx
3028                     	xref	c_lzmp
3029                     	xref	c_lcmp
3030                     	xref	c_ltor
3031                     	xref	c_lgadc
3032                     	xref	c_xymov
3033                     	end
