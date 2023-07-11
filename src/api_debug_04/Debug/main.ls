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
 465                     	switch	.const
 466  0010               L01:
 467  0010 00002710      	dc.l	10000
 468  0014               L21:
 469  0014 00007530      	dc.l	30000
 470  0018               L42:
 471  0018 000003e8      	dc.l	1000
 472  001c               L04:
 473  001c 0000000a      	dc.l	10
 474  0020               L25:
 475  0020 00000014      	dc.l	20
 476  0024               L45:
 477  0024 00000064      	dc.l	100
 478  0028               L65:
 479  0028 000007d0      	dc.l	2000
 480  002c               L46:
 481  002c 00001388      	dc.l	5000
 482  0030               L66:
 483  0030 0000003c      	dc.l	60
 484  0034               L07:
 485  0034 00000005      	dc.l	5
 486  0038               L27:
 487  0038 00000003      	dc.l	3
 488                     ; 20 int main()
 488                     ; 21 {
 489                     	switch	.text
 490  003e               _main:
 492  003e 5238          	subw	sp,#56
 493       00000038      OFST:	set	56
 496                     ; 44 	const int test_mode=7;
 498  0040 ae0007        	ldw	x,#7
 499  0043 1f33          	ldw	(OFST-5,sp),x
 501                     ; 45 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 503  0045 96            	ldw	x,sp
 504  0046 1c0009        	addw	x,#OFST-47
 505  0049 90ae0000      	ldw	y,#L75_rms_lookup
 506  004d a610          	ld	a,#16
 507  004f cd0000        	call	c_xymov
 509                     ; 47 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 513  0052 ae0000        	ldw	x,#0
 514  0055 1f26          	ldw	(OFST-18,sp),x
 515  0057 ae0000        	ldw	x,#0
 516  005a 1f24          	ldw	(OFST-20,sp),x
 522                     ; 48 	unsigned sound_level=0;
 524  005c 5f            	clrw	x
 525  005d 1f31          	ldw	(OFST-7,sp),x
 527                     ; 49 	uint8_t mean_threshold=16;
 529  005f a610          	ld	a,#16
 530  0061 6b28          	ld	(OFST-16,sp),a
 532                     ; 50 	uint8_t mean_threshold_8=1;
 534  0063 a601          	ld	a,#1
 535  0065 6b23          	ld	(OFST-21,sp),a
 537                     ; 51 	uint16_t mean_threshold_16=0x0100;
 539  0067 ae0100        	ldw	x,#256
 540  006a 1f1d          	ldw	(OFST-27,sp),x
 542                     ; 52 	unsigned int rms=0;
 544                     ; 53 	const long adc_captures=1<<8;
 546  006c ae0100        	ldw	x,#256
 547  006f 1f1b          	ldw	(OFST-29,sp),x
 548  0071 ae0000        	ldw	x,#0
 549  0074 1f19          	ldw	(OFST-31,sp),x
 551                     ; 55 	int debug=0;
 553  0076 5f            	clrw	x
 554  0077 1f2b          	ldw	(OFST-13,sp),x
 556                     ; 57 	for(rep=0;rep<1;rep++)
 558  0079 ae0000        	ldw	x,#0
 559  007c 1f2f          	ldw	(OFST-9,sp),x
 560  007e ae0000        	ldw	x,#0
 561  0081 1f2d          	ldw	(OFST-11,sp),x
 563  0083               L352:
 564                     ; 58 		for(iter=0;iter<10000;iter++){}
 566  0083 ae0000        	ldw	x,#0
 567  0086 1f37          	ldw	(OFST-1,sp),x
 568  0088 ae0000        	ldw	x,#0
 569  008b 1f35          	ldw	(OFST-3,sp),x
 571  008d               L162:
 574  008d 96            	ldw	x,sp
 575  008e 1c0035        	addw	x,#OFST-3
 576  0091 a601          	ld	a,#1
 577  0093 cd0000        	call	c_lgadc
 582  0096 96            	ldw	x,sp
 583  0097 1c0035        	addw	x,#OFST-3
 584  009a cd0000        	call	c_ltor
 586  009d ae0010        	ldw	x,#L01
 587  00a0 cd0000        	call	c_lcmp
 589  00a3 25e8          	jrult	L162
 590                     ; 57 	for(rep=0;rep<1;rep++)
 592  00a5 96            	ldw	x,sp
 593  00a6 1c002d        	addw	x,#OFST-11
 594  00a9 a601          	ld	a,#1
 595  00ab cd0000        	call	c_lgadc
 600  00ae 96            	ldw	x,sp
 601  00af 1c002d        	addw	x,#OFST-11
 602  00b2 cd0000        	call	c_lzmp
 604  00b5 27cc          	jreq	L352
 605                     ; 61 	if(test_mode!=4 && test_mode!=5)
 607  00b7 1e33          	ldw	x,(OFST-5,sp)
 608  00b9 a30004        	cpw	x,#4
 609  00bc 273c          	jreq	L762
 611  00be 1e33          	ldw	x,(OFST-5,sp)
 612  00c0 a30005        	cpw	x,#5
 613  00c3 2735          	jreq	L762
 614                     ; 63 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 616  00c5 4bf0          	push	#240
 617  00c7 4b20          	push	#32
 618  00c9 ae500f        	ldw	x,#20495
 619  00cc cd0000        	call	_GPIO_Init
 621  00cf 85            	popw	x
 622                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 624  00d0 4b40          	push	#64
 625  00d2 4b40          	push	#64
 626  00d4 ae500f        	ldw	x,#20495
 627  00d7 cd0000        	call	_GPIO_Init
 629  00da 85            	popw	x
 630                     ; 65 		UART1_DeInit();
 632  00db cd0000        	call	_UART1_DeInit
 634                     ; 66 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 636  00de 4b0c          	push	#12
 637  00e0 4b80          	push	#128
 638  00e2 4b00          	push	#0
 639  00e4 4b00          	push	#0
 640  00e6 4b00          	push	#0
 641  00e8 aec200        	ldw	x,#49664
 642  00eb 89            	pushw	x
 643  00ec ae0001        	ldw	x,#1
 644  00ef 89            	pushw	x
 645  00f0 cd0000        	call	_UART1_Init
 647  00f3 5b09          	addw	sp,#9
 648                     ; 68 		UART1_Cmd(ENABLE);
 650  00f5 a601          	ld	a,#1
 651  00f7 cd0000        	call	_UART1_Cmd
 653  00fa               L762:
 654                     ; 71 	switch(test_mode)
 656  00fa 1e33          	ldw	x,(OFST-5,sp)
 658                     ; 433 					setRGB(mean_high+(mean_low?5:0),sound_level);
 659  00fc 5d            	tnzw	x
 660  00fd 272d          	jreq	L572
 661  00ff 5a            	decw	x
 662  0100 2603          	jrne	L201
 663  0102 cc01d0        	jp	L143
 664  0105               L201:
 665  0105 5a            	decw	x
 666  0106 2603          	jrne	L401
 667  0108 cc0286        	jp	L56
 668  010b               L401:
 669  010b 5a            	decw	x
 670  010c 2603          	jrne	L601
 671  010e cc049c        	jp	L76
 672  0111               L601:
 673  0111 5a            	decw	x
 674  0112 2603          	jrne	L011
 675  0114 cc05d6        	jp	L17
 676  0117               L011:
 677  0117 5a            	decw	x
 678  0118 2603          	jrne	L211
 679  011a cc0639        	jp	L37
 680  011d               L211:
 681  011d 5a            	decw	x
 682  011e 2603          	jrne	L411
 683  0120 cc07a3        	jp	L57
 684  0123               L411:
 685  0123 5a            	decw	x
 686  0124 2603          	jrne	L611
 687  0126 cc0826        	jp	L77
 688  0129               L611:
 689  0129               L001:
 690                     ; 439 }
 693  0129 5b38          	addw	sp,#56
 694  012b 81            	ret
 695  012c               L572:
 696                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 698  012c 5f            	clrw	x
 699  012d 1f31          	ldw	(OFST-7,sp),x
 701  012f               L103:
 702                     ; 81 					for(led_index=0;led_index<10;led_index++)
 704  012f 5f            	clrw	x
 705  0130 1f33          	ldw	(OFST-5,sp),x
 707  0132               L703:
 708                     ; 83 						setMatrixHighZ();
 710  0132 cd09ac        	call	_setMatrixHighZ
 712                     ; 84 						setRGB(led_index,rgb_index);
 714  0135 1e31          	ldw	x,(OFST-7,sp)
 715  0137 89            	pushw	x
 716  0138 1e35          	ldw	x,(OFST-3,sp)
 717  013a cd09c3        	call	_setRGB
 719  013d 85            	popw	x
 720                     ; 85 						for(iter=0;iter<30000;iter++){}
 722  013e ae0000        	ldw	x,#0
 723  0141 1f37          	ldw	(OFST-1,sp),x
 724  0143 ae0000        	ldw	x,#0
 725  0146 1f35          	ldw	(OFST-3,sp),x
 727  0148               L513:
 730  0148 96            	ldw	x,sp
 731  0149 1c0035        	addw	x,#OFST-3
 732  014c a601          	ld	a,#1
 733  014e cd0000        	call	c_lgadc
 738  0151 96            	ldw	x,sp
 739  0152 1c0035        	addw	x,#OFST-3
 740  0155 cd0000        	call	c_ltor
 742  0158 ae0014        	ldw	x,#L21
 743  015b cd0000        	call	c_lcmp
 745  015e 25e8          	jrult	L513
 746                     ; 86 						debug++;
 748  0160 1e2b          	ldw	x,(OFST-13,sp)
 749  0162 1c0001        	addw	x,#1
 750  0165 1f2b          	ldw	(OFST-13,sp),x
 752                     ; 93 							Serial_print_string("counter: ");
 754  0167 ae011b        	ldw	x,#L323
 755  016a cd0911        	call	_Serial_print_string
 757                     ; 94 							Serial_print_int(debug);
 759  016d 1e2b          	ldw	x,(OFST-13,sp)
 760  016f cd093a        	call	_Serial_print_int
 762                     ; 97 							Serial_newline();
 764  0172 cd099d        	call	_Serial_newline
 766                     ; 81 					for(led_index=0;led_index<10;led_index++)
 768  0175 1e33          	ldw	x,(OFST-5,sp)
 769  0177 1c0001        	addw	x,#1
 770  017a 1f33          	ldw	(OFST-5,sp),x
 774  017c 1e33          	ldw	x,(OFST-5,sp)
 775  017e a3000a        	cpw	x,#10
 776  0181 25af          	jrult	L703
 777                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 779  0183 1e31          	ldw	x,(OFST-7,sp)
 780  0185 1c0001        	addw	x,#1
 781  0188 1f31          	ldw	(OFST-7,sp),x
 785  018a 1e31          	ldw	x,(OFST-7,sp)
 786  018c a30003        	cpw	x,#3
 787  018f 259e          	jrult	L103
 788                     ; 101 				for(led_index=0;led_index<12;led_index++)
 790  0191 5f            	clrw	x
 791  0192 1f33          	ldw	(OFST-5,sp),x
 793  0194               L523:
 794                     ; 103 					setMatrixHighZ();
 796  0194 cd09ac        	call	_setMatrixHighZ
 798                     ; 104 					setWhite(led_index);
 800  0197 1e33          	ldw	x,(OFST-5,sp)
 801  0199 cd09d2        	call	_setWhite
 803                     ; 105 					for(iter=0;iter<30000;iter++){}
 805  019c ae0000        	ldw	x,#0
 806  019f 1f37          	ldw	(OFST-1,sp),x
 807  01a1 ae0000        	ldw	x,#0
 808  01a4 1f35          	ldw	(OFST-3,sp),x
 810  01a6               L333:
 813  01a6 96            	ldw	x,sp
 814  01a7 1c0035        	addw	x,#OFST-3
 815  01aa a601          	ld	a,#1
 816  01ac cd0000        	call	c_lgadc
 821  01af 96            	ldw	x,sp
 822  01b0 1c0035        	addw	x,#OFST-3
 823  01b3 cd0000        	call	c_ltor
 825  01b6 ae0014        	ldw	x,#L21
 826  01b9 cd0000        	call	c_lcmp
 828  01bc 25e8          	jrult	L333
 829                     ; 101 				for(led_index=0;led_index<12;led_index++)
 831  01be 1e33          	ldw	x,(OFST-5,sp)
 832  01c0 1c0001        	addw	x,#1
 833  01c3 1f33          	ldw	(OFST-5,sp),x
 837  01c5 1e33          	ldw	x,(OFST-5,sp)
 838  01c7 a3000c        	cpw	x,#12
 839  01ca 25c8          	jrult	L523
 841  01cc ac2c012c      	jpf	L572
 842  01d0               L143:
 843                     ; 113 				rep=ADC_Read(AIN4);
 845  01d0 a604          	ld	a,#4
 846  01d2 cd0000        	call	_ADC_Read
 848  01d5 cd0000        	call	c_uitolx
 850  01d8 96            	ldw	x,sp
 851  01d9 1c002d        	addw	x,#OFST-11
 852  01dc cd0000        	call	c_rtol
 855                     ; 114 				my_min=rep;
 857  01df 1e2f          	ldw	x,(OFST-9,sp)
 858  01e1 1f2b          	ldw	(OFST-13,sp),x
 860                     ; 115 				my_max=rep;
 862  01e3 1e2f          	ldw	x,(OFST-9,sp)
 863  01e5 1f31          	ldw	(OFST-7,sp),x
 865                     ; 116 				for(iter=0;iter<1000;iter++)
 867  01e7 ae0000        	ldw	x,#0
 868  01ea 1f37          	ldw	(OFST-1,sp),x
 869  01ec ae0000        	ldw	x,#0
 870  01ef 1f35          	ldw	(OFST-3,sp),x
 872  01f1               L543:
 873                     ; 118 					rep=ADC_Read(AIN4);
 875  01f1 a604          	ld	a,#4
 876  01f3 cd0000        	call	_ADC_Read
 878  01f6 cd0000        	call	c_uitolx
 880  01f9 96            	ldw	x,sp
 881  01fa 1c002d        	addw	x,#OFST-11
 882  01fd cd0000        	call	c_rtol
 885                     ; 119 					my_min=my_min<rep?my_min:rep;
 887  0200 1e2b          	ldw	x,(OFST-13,sp)
 888  0202 cd0000        	call	c_uitolx
 890  0205 96            	ldw	x,sp
 891  0206 1c002d        	addw	x,#OFST-11
 892  0209 cd0000        	call	c_lcmp
 894  020c 2404          	jruge	L41
 895  020e 1e2b          	ldw	x,(OFST-13,sp)
 896  0210 2002          	jra	L61
 897  0212               L41:
 898  0212 1e2f          	ldw	x,(OFST-9,sp)
 899  0214               L61:
 900  0214 1f2b          	ldw	(OFST-13,sp),x
 902                     ; 120 					my_max=my_max>rep?my_max:rep;
 904  0216 1e31          	ldw	x,(OFST-7,sp)
 905  0218 cd0000        	call	c_uitolx
 907  021b 96            	ldw	x,sp
 908  021c 1c002d        	addw	x,#OFST-11
 909  021f cd0000        	call	c_lcmp
 911  0222 2304          	jrule	L02
 912  0224 1e31          	ldw	x,(OFST-7,sp)
 913  0226 2002          	jra	L22
 914  0228               L02:
 915  0228 1e2f          	ldw	x,(OFST-9,sp)
 916  022a               L22:
 917  022a 1f31          	ldw	(OFST-7,sp),x
 919                     ; 116 				for(iter=0;iter<1000;iter++)
 921  022c 96            	ldw	x,sp
 922  022d 1c0035        	addw	x,#OFST-3
 923  0230 a601          	ld	a,#1
 924  0232 cd0000        	call	c_lgadc
 929  0235 96            	ldw	x,sp
 930  0236 1c0035        	addw	x,#OFST-3
 931  0239 cd0000        	call	c_ltor
 933  023c ae0018        	ldw	x,#L42
 934  023f cd0000        	call	c_lcmp
 936  0242 25ad          	jrult	L543
 937                     ; 122 				Serial_print_string("adc: ");
 939  0244 ae0115        	ldw	x,#L353
 940  0247 cd0911        	call	_Serial_print_string
 942                     ; 123 				Serial_print_int(rep);
 944  024a 1e2f          	ldw	x,(OFST-9,sp)
 945  024c cd093a        	call	_Serial_print_int
 947                     ; 124 				Serial_print_string(", ");
 949  024f ae0112        	ldw	x,#L553
 950  0252 cd0911        	call	_Serial_print_string
 952                     ; 125 				Serial_print_int(my_max-my_min);
 954  0255 1e31          	ldw	x,(OFST-7,sp)
 955  0257 72f02b        	subw	x,(OFST-13,sp)
 956  025a cd093a        	call	_Serial_print_int
 958                     ; 126 				Serial_newline();
 960  025d cd099d        	call	_Serial_newline
 962                     ; 127 				for(iter=0;iter<10000;iter++){}
 964  0260 ae0000        	ldw	x,#0
 965  0263 1f37          	ldw	(OFST-1,sp),x
 966  0265 ae0000        	ldw	x,#0
 967  0268 1f35          	ldw	(OFST-3,sp),x
 969  026a               L753:
 972  026a 96            	ldw	x,sp
 973  026b 1c0035        	addw	x,#OFST-3
 974  026e a601          	ld	a,#1
 975  0270 cd0000        	call	c_lgadc
 980  0273 96            	ldw	x,sp
 981  0274 1c0035        	addw	x,#OFST-3
 982  0277 cd0000        	call	c_ltor
 984  027a ae0010        	ldw	x,#L01
 985  027d cd0000        	call	c_lcmp
 987  0280 25e8          	jrult	L753
 989  0282 acd001d0      	jpf	L143
 990  0286               L56:
 991                     ; 132 			ADC1_DeInit();
 993  0286 cd0000        	call	_ADC1_DeInit
 995                     ; 133 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 995                     ; 134 							 AIN4,
 995                     ; 135 							 ADC1_PRESSEL_FCPU_D2,//D18 
 995                     ; 136 							 ADC1_EXTTRIG_TIM, 
 995                     ; 137 							 DISABLE, 
 995                     ; 138 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 995                     ; 139 							 ADC1_SCHMITTTRIG_ALL, 
 995                     ; 140 							 DISABLE);
 997  0289 4b00          	push	#0
 998  028b 4bff          	push	#255
 999  028d 4b08          	push	#8
1000  028f 4b00          	push	#0
1001  0291 4b00          	push	#0
1002  0293 4b00          	push	#0
1003  0295 ae0104        	ldw	x,#260
1004  0298 cd0000        	call	_ADC1_Init
1006  029b 5b06          	addw	sp,#6
1007                     ; 141 			ADC1_Cmd(ENABLE);
1009  029d a601          	ld	a,#1
1010  029f cd0000        	call	_ADC1_Cmd
1012  02a2               L563:
1013                     ; 165 				rms=0;
1015  02a2 5f            	clrw	x
1016  02a3 1f33          	ldw	(OFST-5,sp),x
1018                     ; 167 				mean_sum=0;
1020  02a5 ae0000        	ldw	x,#0
1021  02a8 1f26          	ldw	(OFST-18,sp),x
1022  02aa ae0000        	ldw	x,#0
1023  02ad 1f24          	ldw	(OFST-20,sp),x
1025                     ; 168 				mean_low=mean+mean_threshold;
1027  02af 7b29          	ld	a,(OFST-15,sp)
1028  02b1 5f            	clrw	x
1029  02b2 1b28          	add	a,(OFST-16,sp)
1030  02b4 2401          	jrnc	L62
1031  02b6 5c            	incw	x
1032  02b7               L62:
1033  02b7 cd0000        	call	c_itol
1035  02ba 96            	ldw	x,sp
1036  02bb 1c001f        	addw	x,#OFST-25
1037  02be cd0000        	call	c_rtol
1040                     ; 169 				mean_high=mean-mean_threshold;
1042  02c1 7b29          	ld	a,(OFST-15,sp)
1043  02c3 5f            	clrw	x
1044  02c4 1028          	sub	a,(OFST-16,sp)
1045  02c6 2401          	jrnc	L03
1046  02c8 5a            	decw	x
1047  02c9               L03:
1048  02c9 cd0000        	call	c_itol
1050  02cc 96            	ldw	x,sp
1051  02cd 1c002d        	addw	x,#OFST-11
1052  02d0 cd0000        	call	c_rtol
1055                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1057  02d3 ae0000        	ldw	x,#0
1058  02d6 1f37          	ldw	(OFST-1,sp),x
1059  02d8 ae0000        	ldw	x,#0
1060  02db 1f35          	ldw	(OFST-3,sp),x
1063  02dd 2058          	jra	L573
1064  02df               L173:
1065                     ; 173 					ADC1_StartConversion();
1067  02df cd0000        	call	_ADC1_StartConversion
1070  02e2               L304:
1071                     ; 174 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1073  02e2 a680          	ld	a,#128
1074  02e4 cd0000        	call	_ADC1_GetFlagStatus
1076  02e7 4d            	tnz	a
1077  02e8 27f8          	jreq	L304
1078                     ; 176 					reading=ADC1->DRL;
1080  02ea c65405        	ld	a,21509
1081  02ed 6b2a          	ld	(OFST-14,sp),a
1083                     ; 177 					mean_sum += reading;
1085  02ef 7b2a          	ld	a,(OFST-14,sp)
1086  02f1 96            	ldw	x,sp
1087  02f2 1c0024        	addw	x,#OFST-20
1088  02f5 cd0000        	call	c_lgadc
1091                     ; 178 					rms+=reading>mean_low || reading<mean_high;
1093  02f8 7b2a          	ld	a,(OFST-14,sp)
1094  02fa b703          	ld	c_lreg+3,a
1095  02fc 3f02          	clr	c_lreg+2
1096  02fe 3f01          	clr	c_lreg+1
1097  0300 3f00          	clr	c_lreg
1098  0302 96            	ldw	x,sp
1099  0303 1c001f        	addw	x,#OFST-25
1100  0306 cd0000        	call	c_lcmp
1102  0309 2213          	jrugt	L43
1103  030b 7b2a          	ld	a,(OFST-14,sp)
1104  030d b703          	ld	c_lreg+3,a
1105  030f 3f02          	clr	c_lreg+2
1106  0311 3f01          	clr	c_lreg+1
1107  0313 3f00          	clr	c_lreg
1108  0315 96            	ldw	x,sp
1109  0316 1c002d        	addw	x,#OFST-11
1110  0319 cd0000        	call	c_lcmp
1112  031c 2405          	jruge	L23
1113  031e               L43:
1114  031e ae0001        	ldw	x,#1
1115  0321 2001          	jra	L63
1116  0323               L23:
1117  0323 5f            	clrw	x
1118  0324               L63:
1119  0324 72fb33        	addw	x,(OFST-5,sp)
1120  0327 1f33          	ldw	(OFST-5,sp),x
1122                     ; 182 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1124  0329 a680          	ld	a,#128
1125  032b cd0000        	call	_ADC1_ClearFlag
1127                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1129  032e 96            	ldw	x,sp
1130  032f 1c0035        	addw	x,#OFST-3
1131  0332 a601          	ld	a,#1
1132  0334 cd0000        	call	c_lgadc
1135  0337               L573:
1138  0337 96            	ldw	x,sp
1139  0338 1c0035        	addw	x,#OFST-3
1140  033b cd0000        	call	c_ltor
1142  033e 96            	ldw	x,sp
1143  033f 1c0019        	addw	x,#OFST-31
1144  0342 cd0000        	call	c_lcmp
1146  0345 2598          	jrult	L173
1147                     ; 186 				if(rms>9) mean_threshold++;
1149  0347 1e33          	ldw	x,(OFST-5,sp)
1150  0349 a3000a        	cpw	x,#10
1151  034c 2502          	jrult	L704
1154  034e 0c28          	inc	(OFST-16,sp)
1156  0350               L704:
1157                     ; 187 				if(rms==0) mean_threshold--;
1159  0350 1e33          	ldw	x,(OFST-5,sp)
1160  0352 2602          	jrne	L114
1163  0354 0a28          	dec	(OFST-16,sp)
1165  0356               L114:
1166                     ; 188 				mean=(mean_sum)/(adc_captures);
1168  0356 96            	ldw	x,sp
1169  0357 1c0024        	addw	x,#OFST-20
1170  035a cd0000        	call	c_ltor
1172  035d 96            	ldw	x,sp
1173  035e 1c0019        	addw	x,#OFST-31
1174  0361 cd0000        	call	c_ludv
1176  0364 b603          	ld	a,c_lreg+3
1177  0366 6b29          	ld	(OFST-15,sp),a
1179                     ; 189 				if(sound_level/32<mean_threshold) sound_level++;
1181  0368 1e31          	ldw	x,(OFST-7,sp)
1182  036a 54            	srlw	x
1183  036b 54            	srlw	x
1184  036c 54            	srlw	x
1185  036d 54            	srlw	x
1186  036e 54            	srlw	x
1187  036f 7b28          	ld	a,(OFST-16,sp)
1188  0371 905f          	clrw	y
1189  0373 9097          	ld	yl,a
1190  0375 90bf00        	ldw	c_y,y
1191  0378 b300          	cpw	x,c_y
1192  037a 2407          	jruge	L314
1195  037c 1e31          	ldw	x,(OFST-7,sp)
1196  037e 1c0001        	addw	x,#1
1197  0381 1f31          	ldw	(OFST-7,sp),x
1199  0383               L314:
1200                     ; 190 				if(sound_level/32>mean_threshold) sound_level--;
1202  0383 1e31          	ldw	x,(OFST-7,sp)
1203  0385 54            	srlw	x
1204  0386 54            	srlw	x
1205  0387 54            	srlw	x
1206  0388 54            	srlw	x
1207  0389 54            	srlw	x
1208  038a 7b28          	ld	a,(OFST-16,sp)
1209  038c 905f          	clrw	y
1210  038e 9097          	ld	yl,a
1211  0390 90bf00        	ldw	c_y,y
1212  0393 b300          	cpw	x,c_y
1213  0395 2307          	jrule	L514
1216  0397 1e31          	ldw	x,(OFST-7,sp)
1217  0399 1d0001        	subw	x,#1
1218  039c 1f31          	ldw	(OFST-7,sp),x
1220  039e               L514:
1221                     ; 191 				if(debug%4==0)
1223  039e 1e2b          	ldw	x,(OFST-13,sp)
1224  03a0 a604          	ld	a,#4
1225  03a2 cd0000        	call	c_smodx
1227  03a5 a30000        	cpw	x,#0
1228  03a8 267b          	jrne	L714
1229                     ; 193 					Serial_print_string("adc: ");
1231  03aa ae0115        	ldw	x,#L353
1232  03ad cd0911        	call	_Serial_print_string
1234                     ; 194 					Serial_print_int(mean);
1236  03b0 7b29          	ld	a,(OFST-15,sp)
1237  03b2 5f            	clrw	x
1238  03b3 97            	ld	xl,a
1239  03b4 cd093a        	call	_Serial_print_int
1241                     ; 195 					Serial_print_string(", ");
1243  03b7 ae0112        	ldw	x,#L553
1244  03ba cd0911        	call	_Serial_print_string
1246                     ; 196 					if(rms<9) Serial_print_string("0");
1248  03bd 1e33          	ldw	x,(OFST-5,sp)
1249  03bf a30009        	cpw	x,#9
1250  03c2 2406          	jruge	L124
1253  03c4 ae0110        	ldw	x,#L324
1254  03c7 cd0911        	call	_Serial_print_string
1256  03ca               L124:
1257                     ; 197 					if(rms==0) Serial_print_string("0");
1259  03ca 1e33          	ldw	x,(OFST-5,sp)
1260  03cc 2606          	jrne	L524
1263  03ce ae0110        	ldw	x,#L324
1264  03d1 cd0911        	call	_Serial_print_string
1266  03d4               L524:
1267                     ; 198 					Serial_print_int(rms);
1269  03d4 1e33          	ldw	x,(OFST-5,sp)
1270  03d6 cd093a        	call	_Serial_print_int
1272                     ; 199 					Serial_print_string(", ");
1274  03d9 ae0112        	ldw	x,#L553
1275  03dc cd0911        	call	_Serial_print_string
1277                     ; 200 					if(mean_threshold<9) Serial_print_string("0");
1279  03df 7b28          	ld	a,(OFST-16,sp)
1280  03e1 a109          	cp	a,#9
1281  03e3 2406          	jruge	L724
1284  03e5 ae0110        	ldw	x,#L324
1285  03e8 cd0911        	call	_Serial_print_string
1287  03eb               L724:
1288                     ; 201 					Serial_print_int(mean_threshold);
1290  03eb 7b28          	ld	a,(OFST-16,sp)
1291  03ed 5f            	clrw	x
1292  03ee 97            	ld	xl,a
1293  03ef cd093a        	call	_Serial_print_int
1295                     ; 202 					Serial_print_string(", ");
1297  03f2 ae0112        	ldw	x,#L553
1298  03f5 cd0911        	call	_Serial_print_string
1300                     ; 203 					if(sound_level/8<9) Serial_print_string("0");
1302  03f8 1e31          	ldw	x,(OFST-7,sp)
1303  03fa 54            	srlw	x
1304  03fb 54            	srlw	x
1305  03fc 54            	srlw	x
1306  03fd a30009        	cpw	x,#9
1307  0400 2406          	jruge	L134
1310  0402 ae0110        	ldw	x,#L324
1311  0405 cd0911        	call	_Serial_print_string
1313  0408               L134:
1314                     ; 204 					Serial_print_int(sound_level/8);
1316  0408 1e31          	ldw	x,(OFST-7,sp)
1317  040a 54            	srlw	x
1318  040b 54            	srlw	x
1319  040c 54            	srlw	x
1320  040d cd093a        	call	_Serial_print_int
1322                     ; 205 					if(debug%10==0) Serial_print_string("*");
1324  0410 1e2b          	ldw	x,(OFST-13,sp)
1325  0412 a60a          	ld	a,#10
1326  0414 cd0000        	call	c_smodx
1328  0417 a30000        	cpw	x,#0
1329  041a 2606          	jrne	L334
1332  041c ae010e        	ldw	x,#L534
1333  041f cd0911        	call	_Serial_print_string
1335  0422               L334:
1336                     ; 206 					Serial_newline();
1338  0422 cd099d        	call	_Serial_newline
1340  0425               L714:
1341                     ; 208 				if(mean_threshold>10)
1343  0425 7b28          	ld	a,(OFST-16,sp)
1344  0427 a10b          	cp	a,#11
1345  0429 2518          	jrult	L734
1346                     ; 212 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1348  042b 4bd0          	push	#208
1349  042d 4b08          	push	#8
1350  042f ae500a        	ldw	x,#20490
1351  0432 cd0000        	call	_GPIO_Init
1353  0435 85            	popw	x
1354                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1356  0436 4bc0          	push	#192
1357  0438 4b20          	push	#32
1358  043a ae500a        	ldw	x,#20490
1359  043d cd0000        	call	_GPIO_Init
1361  0440 85            	popw	x
1363  0441 2016          	jra	L144
1364  0443               L734:
1365                     ; 215 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1367  0443 4bd0          	push	#208
1368  0445 4b10          	push	#16
1369  0447 ae500a        	ldw	x,#20490
1370  044a cd0000        	call	_GPIO_Init
1372  044d 85            	popw	x
1373                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1375  044e 4bc0          	push	#192
1376  0450 4b40          	push	#64
1377  0452 ae500a        	ldw	x,#20490
1378  0455 cd0000        	call	_GPIO_Init
1380  0458 85            	popw	x
1381  0459               L144:
1382                     ; 218 			for(iter=0;iter<10;iter++){}
1384  0459 ae0000        	ldw	x,#0
1385  045c 1f37          	ldw	(OFST-1,sp),x
1386  045e ae0000        	ldw	x,#0
1387  0461 1f35          	ldw	(OFST-3,sp),x
1389  0463               L344:
1392  0463 96            	ldw	x,sp
1393  0464 1c0035        	addw	x,#OFST-3
1394  0467 a601          	ld	a,#1
1395  0469 cd0000        	call	c_lgadc
1400  046c 96            	ldw	x,sp
1401  046d 1c0035        	addw	x,#OFST-3
1402  0470 cd0000        	call	c_ltor
1404  0473 ae001c        	ldw	x,#L04
1405  0476 cd0000        	call	c_lcmp
1407  0479 25e8          	jrult	L344
1408                     ; 219 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1410  047b 4b00          	push	#0
1411  047d 4bf8          	push	#248
1412  047f ae500a        	ldw	x,#20490
1413  0482 cd0000        	call	_GPIO_Init
1415  0485 85            	popw	x
1416                     ; 220 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1418  0486 4b00          	push	#0
1419  0488 4b04          	push	#4
1420  048a ae500f        	ldw	x,#20495
1421  048d cd0000        	call	_GPIO_Init
1423  0490 85            	popw	x
1424                     ; 222 				debug++;
1426  0491 1e2b          	ldw	x,(OFST-13,sp)
1427  0493 1c0001        	addw	x,#1
1428  0496 1f2b          	ldw	(OFST-13,sp),x
1431  0498 aca202a2      	jpf	L563
1432  049c               L76:
1433                     ; 228 			ADC1_DeInit();
1435  049c cd0000        	call	_ADC1_DeInit
1437                     ; 229 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1437                     ; 230 							 AIN4,
1437                     ; 231 							 ADC1_PRESSEL_FCPU_D2,//D18 
1437                     ; 232 							 ADC1_EXTTRIG_TIM, 
1437                     ; 233 							 DISABLE, 
1437                     ; 234 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1437                     ; 235 							 ADC1_SCHMITTTRIG_ALL, 
1437                     ; 236 							 DISABLE);
1439  049f 4b00          	push	#0
1440  04a1 4bff          	push	#255
1441  04a3 4b08          	push	#8
1442  04a5 4b00          	push	#0
1443  04a7 4b00          	push	#0
1444  04a9 4b00          	push	#0
1445  04ab ae0104        	ldw	x,#260
1446  04ae cd0000        	call	_ADC1_Init
1448  04b1 5b06          	addw	sp,#6
1449                     ; 237 			ADC1_Cmd(ENABLE);
1451  04b3 a601          	ld	a,#1
1452  04b5 cd0000        	call	_ADC1_Cmd
1454  04b8               L154:
1455                     ; 240 				debug++;
1457  04b8 1e2b          	ldw	x,(OFST-13,sp)
1458  04ba 1c0001        	addw	x,#1
1459  04bd 1f2b          	ldw	(OFST-13,sp),x
1461                     ; 241 				rms=0;//8 bit
1463  04bf 5f            	clrw	x
1464  04c0 1f33          	ldw	(OFST-5,sp),x
1466                     ; 243 				mean_sum=0;//16 bit
1468  04c2 ae0000        	ldw	x,#0
1469  04c5 1f26          	ldw	(OFST-18,sp),x
1470  04c7 ae0000        	ldw	x,#0
1471  04ca 1f24          	ldw	(OFST-20,sp),x
1473                     ; 246 				iter=0;
1475  04cc ae0000        	ldw	x,#0
1476  04cf 1f37          	ldw	(OFST-1,sp),x
1477  04d1 ae0000        	ldw	x,#0
1478  04d4 1f35          	ldw	(OFST-3,sp),x
1480  04d6               L554:
1481                     ; 249 					ADC1_StartConversion();
1483  04d6 cd0000        	call	_ADC1_StartConversion
1486  04d9               L564:
1487                     ; 250 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1489  04d9 a680          	ld	a,#128
1490  04db cd0000        	call	_ADC1_GetFlagStatus
1492  04de 4d            	tnz	a
1493  04df 27f8          	jreq	L564
1494                     ; 252 					reading=ADC1->DRL;
1496  04e1 c65405        	ld	a,21509
1497  04e4 6b2a          	ld	(OFST-14,sp),a
1499                     ; 253 					mean_sum += reading;
1501  04e6 7b2a          	ld	a,(OFST-14,sp)
1502  04e8 96            	ldw	x,sp
1503  04e9 1c0024        	addw	x,#OFST-20
1504  04ec cd0000        	call	c_lgadc
1507                     ; 255 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1509  04ef 7b2a          	ld	a,(OFST-14,sp)
1510  04f1 1129          	cp	a,(OFST-15,sp)
1511  04f3 2306          	jrule	L24
1512  04f5 7b2a          	ld	a,(OFST-14,sp)
1513  04f7 1029          	sub	a,(OFST-15,sp)
1514  04f9 2004          	jra	L44
1515  04fb               L24:
1516  04fb 7b29          	ld	a,(OFST-15,sp)
1517  04fd 102a          	sub	a,(OFST-14,sp)
1518  04ff               L44:
1519  04ff 6b28          	ld	(OFST-16,sp),a
1521                     ; 256 					rms+=mean_diff>mean_threshold_8;
1523  0501 7b28          	ld	a,(OFST-16,sp)
1524  0503 1123          	cp	a,(OFST-21,sp)
1525  0505 2305          	jrule	L64
1526  0507 ae0001        	ldw	x,#1
1527  050a 2001          	jra	L05
1528  050c               L64:
1529  050c 5f            	clrw	x
1530  050d               L05:
1531  050d 72fb33        	addw	x,(OFST-5,sp)
1532  0510 1f33          	ldw	(OFST-5,sp),x
1534                     ; 258 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1536  0512 a680          	ld	a,#128
1537  0514 cd0000        	call	_ADC1_ClearFlag
1539                     ; 261 					iter++;
1541  0517 96            	ldw	x,sp
1542  0518 1c0035        	addw	x,#OFST-3
1543  051b a601          	ld	a,#1
1544  051d cd0000        	call	c_lgadc
1547                     ; 262 					iter%=256;//8 bit unsigned
1549  0520 0f37          	clr	(OFST-1,sp)
1550  0522 0f36          	clr	(OFST-2,sp)
1551  0524 0f35          	clr	(OFST-3,sp)
1553                     ; 263 				}while(iter!=0);//run 255 times
1555  0526 96            	ldw	x,sp
1556  0527 1c0035        	addw	x,#OFST-3
1557  052a cd0000        	call	c_lzmp
1559  052d 26a7          	jrne	L554
1560                     ; 264 				mean=((uint16_t)mean+mean_sum/256)/2;
1562  052f 96            	ldw	x,sp
1563  0530 1c0024        	addw	x,#OFST-20
1564  0533 cd0000        	call	c_ltor
1566  0536 a608          	ld	a,#8
1567  0538 cd0000        	call	c_lursh
1569  053b 96            	ldw	x,sp
1570  053c 1c0001        	addw	x,#OFST-55
1571  053f cd0000        	call	c_rtol
1574  0542 7b29          	ld	a,(OFST-15,sp)
1575  0544 b703          	ld	c_lreg+3,a
1576  0546 3f02          	clr	c_lreg+2
1577  0548 3f01          	clr	c_lreg+1
1578  054a 3f00          	clr	c_lreg
1579  054c 96            	ldw	x,sp
1580  054d 1c0001        	addw	x,#OFST-55
1581  0550 cd0000        	call	c_ladd
1583  0553 3400          	srl	c_lreg
1584  0555 3601          	rrc	c_lreg+1
1585  0557 3602          	rrc	c_lreg+2
1586  0559 3603          	rrc	c_lreg+3
1587  055b b603          	ld	a,c_lreg+3
1588  055d 6b29          	ld	(OFST-15,sp),a
1590                     ; 265 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1592  055f 96            	ldw	x,sp
1593  0560 1c0009        	addw	x,#OFST-47
1594  0563 1f03          	ldw	(OFST-53,sp),x
1596  0565 1e33          	ldw	x,(OFST-5,sp)
1597  0567 54            	srlw	x
1598  0568 54            	srlw	x
1599  0569 54            	srlw	x
1600  056a 54            	srlw	x
1601  056b 72fb03        	addw	x,(OFST-53,sp)
1602  056e f6            	ld	a,(x)
1603  056f 5f            	clrw	x
1604  0570 97            	ld	xl,a
1605  0571 161d          	ldw	y,(OFST-27,sp)
1606  0573 cd0000        	call	c_imul
1608  0576 54            	srlw	x
1609  0577 54            	srlw	x
1610  0578 54            	srlw	x
1611  0579 54            	srlw	x
1612  057a 54            	srlw	x
1613  057b 72fb1d        	addw	x,(OFST-27,sp)
1614  057e 54            	srlw	x
1615  057f 1f1d          	ldw	(OFST-27,sp),x
1617                     ; 266 				mean_threshold_8=mean_threshold_16/256;
1619  0581 7b1d          	ld	a,(OFST-27,sp)
1620  0583 6b23          	ld	(OFST-21,sp),a
1622                     ; 267 				if(mean_threshold_8==0)
1624  0585 0d23          	tnz	(OFST-21,sp)
1625  0587 2609          	jrne	L174
1626                     ; 269 					mean_threshold_8=1;
1628  0589 a601          	ld	a,#1
1629  058b 6b23          	ld	(OFST-21,sp),a
1631                     ; 270 					mean_threshold_16=0x0100;
1633  058d ae0100        	ldw	x,#256
1634  0590 1f1d          	ldw	(OFST-27,sp),x
1636  0592               L174:
1637                     ; 275 					if(mean==0) Serial_print_string("0");
1639  0592 0d29          	tnz	(OFST-15,sp)
1640  0594 2606          	jrne	L374
1643  0596 ae0110        	ldw	x,#L324
1644  0599 cd0911        	call	_Serial_print_string
1646  059c               L374:
1647                     ; 276 					Serial_print_int(mean);
1649  059c 7b29          	ld	a,(OFST-15,sp)
1650  059e 5f            	clrw	x
1651  059f 97            	ld	xl,a
1652  05a0 cd093a        	call	_Serial_print_int
1654                     ; 278 					Serial_print_string(" ");
1656  05a3 ae010c        	ldw	x,#L574
1657  05a6 cd0911        	call	_Serial_print_string
1659                     ; 281 					if(rms==0) Serial_print_string("0");
1661  05a9 1e33          	ldw	x,(OFST-5,sp)
1662  05ab 2606          	jrne	L774
1665  05ad ae0110        	ldw	x,#L324
1666  05b0 cd0911        	call	_Serial_print_string
1668  05b3               L774:
1669                     ; 282 					Serial_print_int(rms);
1671  05b3 1e33          	ldw	x,(OFST-5,sp)
1672  05b5 cd093a        	call	_Serial_print_int
1674                     ; 284 					Serial_print_string(" ");
1676  05b8 ae010c        	ldw	x,#L574
1677  05bb cd0911        	call	_Serial_print_string
1679                     ; 285 					if(mean_threshold_8==0) Serial_print_string("0");
1681  05be 0d23          	tnz	(OFST-21,sp)
1682  05c0 2606          	jrne	L105
1685  05c2 ae0110        	ldw	x,#L324
1686  05c5 cd0911        	call	_Serial_print_string
1688  05c8               L105:
1689                     ; 286 					Serial_print_int(mean_threshold_8);
1691  05c8 7b23          	ld	a,(OFST-21,sp)
1692  05ca 5f            	clrw	x
1693  05cb 97            	ld	xl,a
1694  05cc cd093a        	call	_Serial_print_int
1696                     ; 288 					Serial_newline();
1698  05cf cd099d        	call	_Serial_newline
1701  05d2 acb804b8      	jpf	L154
1702  05d6               L17:
1703                     ; 294 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1705  05d6 4b40          	push	#64
1706  05d8 4b20          	push	#32
1707  05da ae500f        	ldw	x,#20495
1708  05dd cd0000        	call	_GPIO_Init
1710  05e0 85            	popw	x
1711                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1713  05e1 4b40          	push	#64
1714  05e3 4b40          	push	#64
1715  05e5 ae500f        	ldw	x,#20495
1716  05e8 cd0000        	call	_GPIO_Init
1718  05eb 85            	popw	x
1719  05ec               L305:
1720                     ; 298 			  setMatrixHighZ();
1722  05ec cd09ac        	call	_setMatrixHighZ
1724                     ; 299 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1726  05ef 4b20          	push	#32
1727  05f1 ae500f        	ldw	x,#20495
1728  05f4 cd0000        	call	_GPIO_ReadInputPin
1730  05f7 5b01          	addw	sp,#1
1731  05f9 4d            	tnz	a
1732  05fa 2618          	jrne	L705
1733                     ; 303 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1735  05fc 4bd0          	push	#208
1736  05fe 4b08          	push	#8
1737  0600 ae500a        	ldw	x,#20490
1738  0603 cd0000        	call	_GPIO_Init
1740  0606 85            	popw	x
1741                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1743  0607 4bc0          	push	#192
1744  0609 4b20          	push	#32
1745  060b ae500a        	ldw	x,#20490
1746  060e cd0000        	call	_GPIO_Init
1748  0611 85            	popw	x
1750  0612 20d8          	jra	L305
1751  0614               L705:
1752                     ; 305 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1754  0614 4b40          	push	#64
1755  0616 ae500f        	ldw	x,#20495
1756  0619 cd0000        	call	_GPIO_ReadInputPin
1758  061c 5b01          	addw	sp,#1
1759  061e 4d            	tnz	a
1760  061f 26cb          	jrne	L305
1761                     ; 306 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1763  0621 4bd0          	push	#208
1764  0623 4b10          	push	#16
1765  0625 ae500a        	ldw	x,#20490
1766  0628 cd0000        	call	_GPIO_Init
1768  062b 85            	popw	x
1769                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1771  062c 4bc0          	push	#192
1772  062e 4b40          	push	#64
1773  0630 ae500a        	ldw	x,#20490
1774  0633 cd0000        	call	_GPIO_Init
1776  0636 85            	popw	x
1777  0637 20b3          	jra	L305
1778  0639               L37:
1779                     ; 313 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1781  0639 c650c6        	ld	a,20678
1782  063c a4e7          	and	a,#231
1783  063e c750c6        	ld	20678,a
1784                     ; 315 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1786  0641 4bf0          	push	#240
1787  0643 4b20          	push	#32
1788  0645 ae500f        	ldw	x,#20495
1789  0648 cd0000        	call	_GPIO_Init
1791  064b 85            	popw	x
1792                     ; 316 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1794  064c 4b40          	push	#64
1795  064e 4b40          	push	#64
1796  0650 ae500f        	ldw	x,#20495
1797  0653 cd0000        	call	_GPIO_Init
1799  0656 85            	popw	x
1800                     ; 317 			UART1_DeInit();
1802  0657 cd0000        	call	_UART1_DeInit
1804                     ; 318 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1806  065a 4b0c          	push	#12
1807  065c 4b80          	push	#128
1808  065e 4b00          	push	#0
1809  0660 4b00          	push	#0
1810  0662 4b00          	push	#0
1811  0664 ae4240        	ldw	x,#16960
1812  0667 89            	pushw	x
1813  0668 ae000f        	ldw	x,#15
1814  066b 89            	pushw	x
1815  066c cd0000        	call	_UART1_Init
1817  066f 5b09          	addw	sp,#9
1818                     ; 320 			UART1_Cmd(ENABLE);
1820  0671 a601          	ld	a,#1
1821  0673 cd0000        	call	_UART1_Cmd
1823                     ; 322 			Serial_print_string("Mode: ");
1825  0676 ae0105        	ldw	x,#L515
1826  0679 cd0911        	call	_Serial_print_string
1828                     ; 323 			Serial_print_int(test_mode);
1830  067c 1e33          	ldw	x,(OFST-5,sp)
1831  067e cd093a        	call	_Serial_print_int
1833                     ; 324 			Serial_newline();
1835  0681 cd099d        	call	_Serial_newline
1837                     ; 327 			Serial_print_string("Params v2: ");
1839  0684 ae00f9        	ldw	x,#L715
1840  0687 cd0911        	call	_Serial_print_string
1842                     ; 334 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1844  068a c650c6        	ld	a,20678
1845  068d 5f            	clrw	x
1846  068e 97            	ld	xl,a
1847  068f cd093a        	call	_Serial_print_int
1849                     ; 335 			Serial_print_string(" ");
1851  0692 ae010c        	ldw	x,#L574
1852  0695 cd0911        	call	_Serial_print_string
1854                     ; 336 			Serial_print_int(CLK->CCOR);//0
1856  0698 c650c9        	ld	a,20681
1857  069b 5f            	clrw	x
1858  069c 97            	ld	xl,a
1859  069d cd093a        	call	_Serial_print_int
1861                     ; 337 			Serial_newline();
1863  06a0 cd099d        	call	_Serial_newline
1865                     ; 339 			TIM4->PSCR= 7;// init divider register /128	
1867  06a3 35075347      	mov	21319,#7
1868                     ; 340 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1870  06a7 357d5348      	mov	21320,#125
1871                     ; 341 			TIM4->EGR= TIM4_EGR_UG;// update registers
1873  06ab 35015345      	mov	21317,#1
1874                     ; 342 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1876  06af c65340        	ld	a,21312
1877  06b2 aa85          	or	a,#133
1878  06b4 c75340        	ld	21312,a
1879                     ; 343 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1881  06b7 35015343      	mov	21315,#1
1882                     ; 344 			enableInterrupts();
1885  06bb 9a            rim
1887  06bc               L125:
1888                     ; 347 				if(tms%1000==0 && mean_sum!=tms/1000)
1890  06bc ae0000        	ldw	x,#_tms
1891  06bf cd0000        	call	c_ltor
1893  06c2 ae0018        	ldw	x,#L42
1894  06c5 cd0000        	call	c_lumd
1896  06c8 cd0000        	call	c_lrzmp
1898  06cb 2642          	jrne	L525
1900  06cd ae0000        	ldw	x,#_tms
1901  06d0 cd0000        	call	c_ltor
1903  06d3 ae0018        	ldw	x,#L42
1904  06d6 cd0000        	call	c_ludv
1906  06d9 96            	ldw	x,sp
1907  06da 1c0024        	addw	x,#OFST-20
1908  06dd cd0000        	call	c_lcmp
1910  06e0 272d          	jreq	L525
1911                     ; 349 					Serial_print_string("time: ");
1913  06e2 ae00f2        	ldw	x,#L725
1914  06e5 cd0911        	call	_Serial_print_string
1916                     ; 350 					mean_sum=tms/1000;
1918  06e8 ae0000        	ldw	x,#_tms
1919  06eb cd0000        	call	c_ltor
1921  06ee ae0018        	ldw	x,#L42
1922  06f1 cd0000        	call	c_ludv
1924  06f4 96            	ldw	x,sp
1925  06f5 1c0024        	addw	x,#OFST-20
1926  06f8 cd0000        	call	c_rtol
1929                     ; 351 					Serial_print_int(tms/1000);
1931  06fb ae0000        	ldw	x,#_tms
1932  06fe cd0000        	call	c_ltor
1934  0701 ae0018        	ldw	x,#L42
1935  0704 cd0000        	call	c_ludv
1937  0707 be02          	ldw	x,c_lreg+2
1938  0709 cd093a        	call	_Serial_print_int
1940                     ; 352 					Serial_newline();
1942  070c cd099d        	call	_Serial_newline
1944  070f               L525:
1945                     ; 360 				setMatrixHighZ();
1947  070f cd09ac        	call	_setMatrixHighZ
1949                     ; 361 				mean_low=tms%20;
1951  0712 ae0000        	ldw	x,#_tms
1952  0715 cd0000        	call	c_ltor
1954  0718 ae0020        	ldw	x,#L25
1955  071b cd0000        	call	c_lumd
1957  071e 96            	ldw	x,sp
1958  071f 1c001f        	addw	x,#OFST-25
1959  0722 cd0000        	call	c_rtol
1962                     ; 362 				mean_high=(tms/20)%100;
1964  0725 ae0000        	ldw	x,#_tms
1965  0728 cd0000        	call	c_ltor
1967  072b ae0020        	ldw	x,#L25
1968  072e cd0000        	call	c_ludv
1970  0731 ae0024        	ldw	x,#L45
1971  0734 cd0000        	call	c_lumd
1973  0737 96            	ldw	x,sp
1974  0738 1c002d        	addw	x,#OFST-11
1975  073b cd0000        	call	c_rtol
1978                     ; 363 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
1980  073e ae0000        	ldw	x,#_tms
1981  0741 cd0000        	call	c_ltor
1983  0744 ae0028        	ldw	x,#L65
1984  0747 cd0000        	call	c_ludv
1986  074a b603          	ld	a,c_lreg+3
1987  074c a401          	and	a,#1
1988  074e b703          	ld	c_lreg+3,a
1989  0750 3f02          	clr	c_lreg+2
1990  0752 3f01          	clr	c_lreg+1
1991  0754 3f00          	clr	c_lreg
1992  0756 96            	ldw	x,sp
1993  0757 1c0001        	addw	x,#OFST-55
1994  075a cd0000        	call	c_rtol
1997  075d 96            	ldw	x,sp
1998  075e 1c002d        	addw	x,#OFST-11
1999  0761 cd0000        	call	c_ltor
2001  0764 a602          	ld	a,#2
2002  0766 cd0000        	call	c_lursh
2004  0769 96            	ldw	x,sp
2005  076a 1c001f        	addw	x,#OFST-25
2006  076d cd0000        	call	c_lcmp
2008  0770 2405          	jruge	L06
2009  0772 ae0001        	ldw	x,#1
2010  0775 2001          	jra	L26
2011  0777               L06:
2012  0777 5f            	clrw	x
2013  0778               L26:
2014  0778 cd0000        	call	c_itolx
2016  077b 96            	ldw	x,sp
2017  077c 1c0001        	addw	x,#OFST-55
2018  077f cd0000        	call	c_lxor
2020  0782 cd0000        	call	c_lrzmp
2022  0785 270f          	jreq	L135
2023                     ; 365 					setRGB(4,1);
2025  0787 ae0001        	ldw	x,#1
2026  078a 89            	pushw	x
2027  078b ae0004        	ldw	x,#4
2028  078e cd09c3        	call	_setRGB
2030  0791 85            	popw	x
2032  0792 acbc06bc      	jpf	L125
2033  0796               L135:
2034                     ; 368 					setRGB(4,0);
2036  0796 5f            	clrw	x
2037  0797 89            	pushw	x
2038  0798 ae0004        	ldw	x,#4
2039  079b cd09c3        	call	_setRGB
2041  079e 85            	popw	x
2042  079f acbc06bc      	jpf	L125
2043  07a3               L57:
2044                     ; 374 			Serial_print_string("Mode: ");
2046  07a3 ae0105        	ldw	x,#L515
2047  07a6 cd0911        	call	_Serial_print_string
2049                     ; 375 			Serial_print_int(test_mode);
2051  07a9 1e33          	ldw	x,(OFST-5,sp)
2052  07ab cd093a        	call	_Serial_print_int
2054                     ; 376 			Serial_newline();
2056  07ae cd099d        	call	_Serial_newline
2058                     ; 380 			Serial_print_string("Params: ");
2060  07b1 ae00e9        	ldw	x,#L535
2061  07b4 cd0911        	call	_Serial_print_string
2063                     ; 381 			Serial_print_int(CLK->CKDIVR);//
2065  07b7 c650c6        	ld	a,20678
2066  07ba 5f            	clrw	x
2067  07bb 97            	ld	xl,a
2068  07bc cd093a        	call	_Serial_print_int
2070                     ; 382 			Serial_print_string(" ");
2072  07bf ae010c        	ldw	x,#L574
2073  07c2 cd0911        	call	_Serial_print_string
2075                     ; 383 			Serial_print_int(CLK->CCOR);//
2077  07c5 c650c9        	ld	a,20681
2078  07c8 5f            	clrw	x
2079  07c9 97            	ld	xl,a
2080  07ca cd093a        	call	_Serial_print_int
2082                     ; 384 			Serial_newline();
2084  07cd cd099d        	call	_Serial_newline
2086                     ; 386 			TIM4->PSCR= 7;// init divider register /128	
2088  07d0 35075347      	mov	21319,#7
2089                     ; 387 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2091  07d4 35805348      	mov	21320,#128
2092                     ; 388 			TIM4->EGR= TIM4_EGR_UG;// update registers
2094  07d8 35015345      	mov	21317,#1
2095                     ; 389 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2097  07dc c65340        	ld	a,21312
2098  07df aa85          	or	a,#133
2099  07e1 c75340        	ld	21312,a
2100                     ; 390 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2102  07e4 35015343      	mov	21315,#1
2103                     ; 391 			enableInterrupts();
2106  07e8 9a            rim
2108  07e9               L735:
2109                     ; 394 				for(iter=0;iter<5000;iter++){}
2111  07e9 ae0000        	ldw	x,#0
2112  07ec 1f37          	ldw	(OFST-1,sp),x
2113  07ee ae0000        	ldw	x,#0
2114  07f1 1f35          	ldw	(OFST-3,sp),x
2116  07f3               L345:
2119  07f3 96            	ldw	x,sp
2120  07f4 1c0035        	addw	x,#OFST-3
2121  07f7 a601          	ld	a,#1
2122  07f9 cd0000        	call	c_lgadc
2127  07fc 96            	ldw	x,sp
2128  07fd 1c0035        	addw	x,#OFST-3
2129  0800 cd0000        	call	c_ltor
2131  0803 ae002c        	ldw	x,#L46
2132  0806 cd0000        	call	c_lcmp
2134  0809 25e8          	jrult	L345
2135                     ; 395 				Serial_print_string("time: ");
2137  080b ae00f2        	ldw	x,#L725
2138  080e cd0911        	call	_Serial_print_string
2140                     ; 396 				Serial_print_int(tms>>16);
2142  0811 be00          	ldw	x,_tms
2143  0813 cd093a        	call	_Serial_print_int
2145                     ; 397 				Serial_print_string(" ");
2147  0816 ae010c        	ldw	x,#L574
2148  0819 cd0911        	call	_Serial_print_string
2150                     ; 398 				Serial_print_int((uint16_t)tms);
2152  081c be02          	ldw	x,_tms+2
2153  081e cd093a        	call	_Serial_print_int
2155                     ; 399 				Serial_newline();
2157  0821 cd099d        	call	_Serial_newline
2160  0824 20c3          	jra	L735
2161  0826               L77:
2162                     ; 404 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2164  0826 c650c6        	ld	a,20678
2165  0829 a4e7          	and	a,#231
2166  082b c750c6        	ld	20678,a
2167                     ; 406 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2169  082e 4bf0          	push	#240
2170  0830 4b20          	push	#32
2171  0832 ae500f        	ldw	x,#20495
2172  0835 cd0000        	call	_GPIO_Init
2174  0838 85            	popw	x
2175                     ; 407 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2177  0839 4b40          	push	#64
2178  083b 4b40          	push	#64
2179  083d ae500f        	ldw	x,#20495
2180  0840 cd0000        	call	_GPIO_Init
2182  0843 85            	popw	x
2183                     ; 408 			UART1_DeInit();
2185  0844 cd0000        	call	_UART1_DeInit
2187                     ; 409 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2189  0847 4b0c          	push	#12
2190  0849 4b80          	push	#128
2191  084b 4b00          	push	#0
2192  084d 4b00          	push	#0
2193  084f 4b00          	push	#0
2194  0851 ae4240        	ldw	x,#16960
2195  0854 89            	pushw	x
2196  0855 ae000f        	ldw	x,#15
2197  0858 89            	pushw	x
2198  0859 cd0000        	call	_UART1_Init
2200  085c 5b09          	addw	sp,#9
2201                     ; 411 			UART1_Cmd(ENABLE);
2203  085e a601          	ld	a,#1
2204  0860 cd0000        	call	_UART1_Cmd
2206                     ; 413 			Serial_print_string("Mode: ");
2208  0863 ae0105        	ldw	x,#L515
2209  0866 cd0911        	call	_Serial_print_string
2211                     ; 414 			Serial_print_int(test_mode);
2213  0869 1e33          	ldw	x,(OFST-5,sp)
2214  086b cd093a        	call	_Serial_print_int
2216                     ; 415 			Serial_newline();
2218  086e cd099d        	call	_Serial_newline
2220                     ; 417 			TIM4->PSCR= 7;// init divider register /128	
2222  0871 35075347      	mov	21319,#7
2223                     ; 418 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2225  0875 357d5348      	mov	21320,#125
2226                     ; 419 			TIM4->EGR= TIM4_EGR_UG;// update registers
2228  0879 35015345      	mov	21317,#1
2229                     ; 420 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2231  087d c65340        	ld	a,21312
2232  0880 aa85          	or	a,#133
2233  0882 c75340        	ld	21312,a
2234                     ; 421 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2236  0885 35015343      	mov	21315,#1
2237                     ; 422 			enableInterrupts();
2240  0889 9a            rim
2242  088a               L155:
2243                     ; 428 					setMatrixHighZ();
2245  088a cd09ac        	call	_setMatrixHighZ
2247                     ; 429 					mean_sum=tms/60;
2249  088d ae0000        	ldw	x,#_tms
2250  0890 cd0000        	call	c_ltor
2252  0893 ae0030        	ldw	x,#L66
2253  0896 cd0000        	call	c_ludv
2255  0899 96            	ldw	x,sp
2256  089a 1c0024        	addw	x,#OFST-20
2257  089d cd0000        	call	c_rtol
2260                     ; 430 					mean_low=tms%2;//is high or low charlieplexing
2262  08a0 b603          	ld	a,_tms+3
2263  08a2 a401          	and	a,#1
2264  08a4 6b22          	ld	(OFST-22,sp),a
2265  08a6 4f            	clr	a
2266  08a7 6b21          	ld	(OFST-23,sp),a
2267  08a9 6b20          	ld	(OFST-24,sp),a
2268  08ab 6b1f          	ld	(OFST-25,sp),a
2270                     ; 431 					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
2272  08ad 96            	ldw	x,sp
2273  08ae 1c0024        	addw	x,#OFST-20
2274  08b1 cd0000        	call	c_ltor
2276  08b4 3400          	srl	c_lreg
2277  08b6 3601          	rrc	c_lreg+1
2278  08b8 3602          	rrc	c_lreg+2
2279  08ba 3603          	rrc	c_lreg+3
2280  08bc ae0034        	ldw	x,#L07
2281  08bf cd0000        	call	c_lumd
2283  08c2 96            	ldw	x,sp
2284  08c3 1c002d        	addw	x,#OFST-11
2285  08c6 cd0000        	call	c_rtol
2288                     ; 432 					sound_level=(mean_sum/10)%3;//RGB
2290  08c9 96            	ldw	x,sp
2291  08ca 1c0024        	addw	x,#OFST-20
2292  08cd cd0000        	call	c_ltor
2294  08d0 ae001c        	ldw	x,#L04
2295  08d3 cd0000        	call	c_ludv
2297  08d6 ae0038        	ldw	x,#L27
2298  08d9 cd0000        	call	c_lumd
2300  08dc be02          	ldw	x,c_lreg+2
2301  08de 1f31          	ldw	(OFST-7,sp),x
2303                     ; 433 					setRGB(mean_high+(mean_low?5:0),sound_level);
2305  08e0 1e31          	ldw	x,(OFST-7,sp)
2306  08e2 89            	pushw	x
2307  08e3 96            	ldw	x,sp
2308  08e4 1c0021        	addw	x,#OFST-23
2309  08e7 cd0000        	call	c_lzmp
2311  08ea 2705          	jreq	L47
2312  08ec ae0005        	ldw	x,#5
2313  08ef 2001          	jra	L67
2314  08f1               L47:
2315  08f1 5f            	clrw	x
2316  08f2               L67:
2317  08f2 cd0000        	call	c_itolx
2319  08f5 96            	ldw	x,sp
2320  08f6 1c002f        	addw	x,#OFST-9
2321  08f9 cd0000        	call	c_ladd
2323  08fc be02          	ldw	x,c_lreg+2
2324  08fe cd09c3        	call	_setRGB
2326  0901 85            	popw	x
2328  0902 2086          	jpf	L155
2353                     ; 441 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2355                     	switch	.text
2356  0904               f_TIM4_UPD_OVF_IRQHandler:
2360                     ; 442 	TIM4->SR1&=~TIM4_SR1_UIF;
2362  0904 72115344      	bres	21316,#0
2363                     ; 443 	tms++;
2365  0908 ae0000        	ldw	x,#_tms
2366  090b a601          	ld	a,#1
2367  090d cd0000        	call	c_lgadc
2369                     ; 444 }
2372  0910 80            	iret
2418                     ; 467  void Serial_print_string (char string[])
2418                     ; 468  {
2420                     	switch	.text
2421  0911               _Serial_print_string:
2423  0911 89            	pushw	x
2424  0912 88            	push	a
2425       00000001      OFST:	set	1
2428                     ; 470 	 char i=0;
2430  0913 0f01          	clr	(OFST+0,sp)
2433  0915 2016          	jra	L316
2434  0917               L706:
2435                     ; 474 		UART1_SendData8(string[i]);
2437  0917 7b01          	ld	a,(OFST+0,sp)
2438  0919 5f            	clrw	x
2439  091a 97            	ld	xl,a
2440  091b 72fb02        	addw	x,(OFST+1,sp)
2441  091e f6            	ld	a,(x)
2442  091f cd0000        	call	_UART1_SendData8
2445  0922               L126:
2446                     ; 475 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2448  0922 ae0080        	ldw	x,#128
2449  0925 cd0000        	call	_UART1_GetFlagStatus
2451  0928 4d            	tnz	a
2452  0929 27f7          	jreq	L126
2453                     ; 476 		i++;
2455  092b 0c01          	inc	(OFST+0,sp)
2457  092d               L316:
2458                     ; 472 	 while (string[i] != 0x00)
2460  092d 7b01          	ld	a,(OFST+0,sp)
2461  092f 5f            	clrw	x
2462  0930 97            	ld	xl,a
2463  0931 72fb02        	addw	x,(OFST+1,sp)
2464  0934 7d            	tnz	(x)
2465  0935 26e0          	jrne	L706
2466                     ; 478  }
2469  0937 5b03          	addw	sp,#3
2470  0939 81            	ret
2473                     	switch	.const
2474  003c               L526_digit:
2475  003c 00            	dc.b	0
2476  003d 00000000      	ds.b	4
2529                     ; 480  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2529                     ; 481  {
2530                     	switch	.text
2531  093a               _Serial_print_int:
2533  093a 89            	pushw	x
2534  093b 5208          	subw	sp,#8
2535       00000008      OFST:	set	8
2538                     ; 482 	 char count = 0;
2540  093d 0f08          	clr	(OFST+0,sp)
2542                     ; 483 	 char digit[5] = "";
2544  093f 96            	ldw	x,sp
2545  0940 1c0003        	addw	x,#OFST-5
2546  0943 90ae003c      	ldw	y,#L526_digit
2547  0947 a605          	ld	a,#5
2548  0949 cd0000        	call	c_xymov
2551  094c 2023          	jra	L166
2552  094e               L556:
2553                     ; 487 		 digit[count] = number%10;
2555  094e 96            	ldw	x,sp
2556  094f 1c0003        	addw	x,#OFST-5
2557  0952 9f            	ld	a,xl
2558  0953 5e            	swapw	x
2559  0954 1b08          	add	a,(OFST+0,sp)
2560  0956 2401          	jrnc	L621
2561  0958 5c            	incw	x
2562  0959               L621:
2563  0959 02            	rlwa	x,a
2564  095a 1609          	ldw	y,(OFST+1,sp)
2565  095c a60a          	ld	a,#10
2566  095e cd0000        	call	c_smody
2568  0961 9001          	rrwa	y,a
2569  0963 f7            	ld	(x),a
2570  0964 9002          	rlwa	y,a
2571                     ; 488 		 count++;
2573  0966 0c08          	inc	(OFST+0,sp)
2575                     ; 489 		 number = number/10;
2577  0968 1e09          	ldw	x,(OFST+1,sp)
2578  096a a60a          	ld	a,#10
2579  096c cd0000        	call	c_sdivx
2581  096f 1f09          	ldw	(OFST+1,sp),x
2582  0971               L166:
2583                     ; 485 	 while (number != 0) //split the int to char array 
2585  0971 1e09          	ldw	x,(OFST+1,sp)
2586  0973 26d9          	jrne	L556
2588  0975 201f          	jra	L766
2589  0977               L566:
2590                     ; 494 		UART1_SendData8(digit[count-1] + 0x30);
2592  0977 96            	ldw	x,sp
2593  0978 1c0003        	addw	x,#OFST-5
2594  097b 1f01          	ldw	(OFST-7,sp),x
2596  097d 7b08          	ld	a,(OFST+0,sp)
2597  097f 5f            	clrw	x
2598  0980 97            	ld	xl,a
2599  0981 5a            	decw	x
2600  0982 72fb01        	addw	x,(OFST-7,sp)
2601  0985 f6            	ld	a,(x)
2602  0986 ab30          	add	a,#48
2603  0988 cd0000        	call	_UART1_SendData8
2606  098b               L576:
2607                     ; 495 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2609  098b ae0080        	ldw	x,#128
2610  098e cd0000        	call	_UART1_GetFlagStatus
2612  0991 4d            	tnz	a
2613  0992 27f7          	jreq	L576
2614                     ; 496 		count--; 
2616  0994 0a08          	dec	(OFST+0,sp)
2618  0996               L766:
2619                     ; 492 	 while (count !=0) //print char array in correct direction 
2621  0996 0d08          	tnz	(OFST+0,sp)
2622  0998 26dd          	jrne	L566
2623                     ; 498  }
2626  099a 5b0a          	addw	sp,#10
2627  099c 81            	ret
2652                     ; 500  void Serial_newline(void)
2652                     ; 501  {
2653                     	switch	.text
2654  099d               _Serial_newline:
2658                     ; 502 	 UART1_SendData8(0x0a);
2660  099d a60a          	ld	a,#10
2661  099f cd0000        	call	_UART1_SendData8
2664  09a2               L317:
2665                     ; 503 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2667  09a2 ae0080        	ldw	x,#128
2668  09a5 cd0000        	call	_UART1_GetFlagStatus
2670  09a8 4d            	tnz	a
2671  09a9 27f7          	jreq	L317
2672                     ; 504  }
2675  09ab 81            	ret
2699                     ; 506 void setMatrixHighZ()
2699                     ; 507 {
2700                     	switch	.text
2701  09ac               _setMatrixHighZ:
2705                     ; 512 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2707  09ac 4b00          	push	#0
2708  09ae 4bf8          	push	#248
2709  09b0 ae500a        	ldw	x,#20490
2710  09b3 cd0000        	call	_GPIO_Init
2712  09b6 85            	popw	x
2713                     ; 513 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2715  09b7 4b00          	push	#0
2716  09b9 4b0c          	push	#12
2717  09bb ae500f        	ldw	x,#20495
2718  09be cd0000        	call	_GPIO_Init
2720  09c1 85            	popw	x
2721                     ; 514 }
2724  09c2 81            	ret
2768                     ; 516 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2769                     	switch	.text
2770  09c3               _setRGB:
2772  09c3 89            	pushw	x
2773       00000000      OFST:	set	0
2778  09c4 1e05          	ldw	x,(OFST+5,sp)
2779  09c6 89            	pushw	x
2780  09c7 1e03          	ldw	x,(OFST+3,sp)
2781  09c9 89            	pushw	x
2782  09ca a601          	ld	a,#1
2783  09cc ad11          	call	_setLED
2785  09ce 5b04          	addw	sp,#4
2789  09d0 85            	popw	x
2790  09d1 81            	ret
2825                     ; 517 void setWhite(int led_index){ setLED(0,led_index,0); }
2826                     	switch	.text
2827  09d2               _setWhite:
2829  09d2 89            	pushw	x
2830       00000000      OFST:	set	0
2835  09d3 5f            	clrw	x
2836  09d4 89            	pushw	x
2837  09d5 1e03          	ldw	x,(OFST+3,sp)
2838  09d7 89            	pushw	x
2839  09d8 4f            	clr	a
2840  09d9 ad04          	call	_setLED
2842  09db 5b04          	addw	sp,#4
2846  09dd 85            	popw	x
2847  09de 81            	ret
2850                     	switch	.const
2851  0041               L767_rgb_lookup:
2852  0041 0000          	dc.w	0
2853  0043 0001          	dc.w	1
2854  0045 0000          	dc.w	0
2855  0047 0002          	dc.w	2
2856  0049 0001          	dc.w	1
2857  004b 0002          	dc.w	2
2858  004d 0001          	dc.w	1
2859  004f 0000          	dc.w	0
2860  0051 0002          	dc.w	2
2861  0053 0000          	dc.w	0
2862  0055 0002          	dc.w	2
2863  0057 0001          	dc.w	1
2864  0059 0005          	dc.w	5
2865  005b 0000          	dc.w	0
2866  005d 0005          	dc.w	5
2867  005f 0001          	dc.w	1
2868  0061 0005          	dc.w	5
2869  0063 0002          	dc.w	2
2870  0065 0006          	dc.w	6
2871  0067 0000          	dc.w	0
2872  0069 0006          	dc.w	6
2873  006b 0001          	dc.w	1
2874  006d 0006          	dc.w	6
2875  006f 0002          	dc.w	2
2876  0071 0006          	dc.w	6
2877  0073 0005          	dc.w	5
2878  0075 0006          	dc.w	6
2879  0077 0004          	dc.w	4
2880  0079 0005          	dc.w	5
2881  007b 0004          	dc.w	4
2882  007d 0004          	dc.w	4
2883  007f 0003          	dc.w	3
2884  0081 0005          	dc.w	5
2885  0083 0003          	dc.w	3
2886  0085 0006          	dc.w	6
2887  0087 0003          	dc.w	3
2888  0089 0003          	dc.w	3
2889  008b 0004          	dc.w	4
2890  008d 0003          	dc.w	3
2891  008f 0005          	dc.w	5
2892  0091 0003          	dc.w	3
2893  0093 0006          	dc.w	6
2894  0095 0000          	dc.w	0
2895  0097 0005          	dc.w	5
2896  0099 0000          	dc.w	0
2897  009b 0006          	dc.w	6
2898  009d 0001          	dc.w	1
2899  009f 0006          	dc.w	6
2900  00a1 0000          	dc.w	0
2901  00a3 0004          	dc.w	4
2902  00a5 0001          	dc.w	1
2903  00a7 0004          	dc.w	4
2904  00a9 0002          	dc.w	2
2905  00ab 0004          	dc.w	4
2906  00ad 0000          	dc.w	0
2907  00af 0003          	dc.w	3
2908  00b1 0001          	dc.w	1
2909  00b3 0003          	dc.w	3
2910  00b5 0002          	dc.w	2
2911  00b7 0003          	dc.w	3
2912  00b9               L177_white_lookup:
2913  00b9 0003          	dc.w	3
2914  00bb 0000          	dc.w	0
2915  00bd 0003          	dc.w	3
2916  00bf 0001          	dc.w	1
2917  00c1 0003          	dc.w	3
2918  00c3 0002          	dc.w	2
2919  00c5 0004          	dc.w	4
2920  00c7 0000          	dc.w	0
2921  00c9 0001          	dc.w	1
2922  00cb 0005          	dc.w	5
2923  00cd 0002          	dc.w	2
2924  00cf 0005          	dc.w	5
2925  00d1 0004          	dc.w	4
2926  00d3 0001          	dc.w	1
2927  00d5 0004          	dc.w	4
2928  00d7 0002          	dc.w	2
2929  00d9 0002          	dc.w	2
2930  00db 0006          	dc.w	6
2931  00dd 0004          	dc.w	4
2932  00df 0006          	dc.w	6
2933  00e1 0004          	dc.w	4
2934  00e3 0005          	dc.w	5
2935  00e5 0005          	dc.w	5
2936  00e7 0006          	dc.w	6
3198                     ; 519 void setLED(bool is_rgb,int led_index,int rgb_index)
3198                     ; 520 {
3199                     	switch	.text
3200  09df               _setLED:
3202  09df 88            	push	a
3203  09e0 52b6          	subw	sp,#182
3204       000000b6      OFST:	set	182
3207                     ; 521   const unsigned short rgb_lookup[10][3][2]={
3207                     ; 522 		{{0,1},{0,2},{1,2}},//7
3207                     ; 523 		{{1,0},{2,0},{2,1}},//3
3207                     ; 524 		{{5,0},{5,1},{5,2}},//1
3207                     ; 525 		{{6,0},{6,1},{6,2}},//20
3207                     ; 526 		{{6,5},{6,4},{5,4}},//22
3207                     ; 527 		{{4,3},{5,3},{6,3}},//23
3207                     ; 528 		{{3,4},{3,5},{3,6}},//21
3207                     ; 529 		{{0,5},{0,6},{1,6}},//19
3207                     ; 530 		{{0,4},{1,4},{2,4}},//18
3207                     ; 531 		{{0,3},{1,3},{2,3}} //2
3207                     ; 532 	};
3209  09e2 96            	ldw	x,sp
3210  09e3 1c000e        	addw	x,#OFST-168
3211  09e6 90ae0041      	ldw	y,#L767_rgb_lookup
3212  09ea a678          	ld	a,#120
3213  09ec cd0000        	call	c_xymov
3215                     ; 533 	const unsigned short white_lookup[12][2]={
3215                     ; 534 		{3,0},//6
3215                     ; 535 		{3,1},//4
3215                     ; 536 		{3,2},//5
3215                     ; 537 		{4,0},//14
3215                     ; 538 		{1,5},//8
3215                     ; 539 		{2,5},//9
3215                     ; 540 		{4,1},//10
3215                     ; 541 		{4,2},//16
3215                     ; 542 		{2,6},//17
3215                     ; 543 		{4,6},//12
3215                     ; 544 		{4,5},//13
3215                     ; 545 		{5,6} //11
3215                     ; 546 	};
3217  09ef 96            	ldw	x,sp
3218  09f0 1c0086        	addw	x,#OFST-48
3219  09f3 90ae00b9      	ldw	y,#L177_white_lookup
3220  09f7 a630          	ld	a,#48
3221  09f9 cd0000        	call	c_xymov
3223                     ; 547 	bool is_low=0;
3225  09fc 0fb6          	clr	(OFST+0,sp)
3227  09fe               L1611:
3228                     ; 551 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3230  09fe 0db7          	tnz	(OFST+1,sp)
3231  0a00 2726          	jreq	L241
3232  0a02 7bb6          	ld	a,(OFST+0,sp)
3233  0a04 5f            	clrw	x
3234  0a05 97            	ld	xl,a
3235  0a06 58            	sllw	x
3236  0a07 1f09          	ldw	(OFST-173,sp),x
3238  0a09 1ebc          	ldw	x,(OFST+6,sp)
3239  0a0b 58            	sllw	x
3240  0a0c 58            	sllw	x
3241  0a0d 1f07          	ldw	(OFST-175,sp),x
3243  0a0f 96            	ldw	x,sp
3244  0a10 1c000e        	addw	x,#OFST-168
3245  0a13 1f05          	ldw	(OFST-177,sp),x
3247  0a15 1eba          	ldw	x,(OFST+4,sp)
3248  0a17 a60c          	ld	a,#12
3249  0a19 cd0000        	call	c_bmulx
3251  0a1c 72fb05        	addw	x,(OFST-177,sp)
3252  0a1f 72fb07        	addw	x,(OFST-175,sp)
3253  0a22 72fb09        	addw	x,(OFST-173,sp)
3254  0a25 fe            	ldw	x,(x)
3255  0a26 2018          	jra	L441
3256  0a28               L241:
3257  0a28 7bb6          	ld	a,(OFST+0,sp)
3258  0a2a 5f            	clrw	x
3259  0a2b 97            	ld	xl,a
3260  0a2c 58            	sllw	x
3261  0a2d 1f03          	ldw	(OFST-179,sp),x
3263  0a2f 96            	ldw	x,sp
3264  0a30 1c0086        	addw	x,#OFST-48
3265  0a33 1f01          	ldw	(OFST-181,sp),x
3267  0a35 1eba          	ldw	x,(OFST+4,sp)
3268  0a37 58            	sllw	x
3269  0a38 58            	sllw	x
3270  0a39 72fb01        	addw	x,(OFST-181,sp)
3271  0a3c 72fb03        	addw	x,(OFST-179,sp)
3272  0a3f fe            	ldw	x,(x)
3273  0a40               L441:
3275                     ; 583 			}break;
3276  0a40 5d            	tnzw	x
3277  0a41 2714          	jreq	L377
3278  0a43 5a            	decw	x
3279  0a44 271c          	jreq	L577
3280  0a46 5a            	decw	x
3281  0a47 2724          	jreq	L777
3282  0a49 5a            	decw	x
3283  0a4a 272c          	jreq	L1001
3284  0a4c 5a            	decw	x
3285  0a4d 2734          	jreq	L3001
3286  0a4f 5a            	decw	x
3287  0a50 273c          	jreq	L5001
3288  0a52 5a            	decw	x
3289  0a53 2744          	jreq	L7001
3290  0a55 204b          	jra	L1711
3291  0a57               L377:
3292                     ; 554 				GPIOx=GPIOD;
3294  0a57 ae500f        	ldw	x,#20495
3295  0a5a 1f0b          	ldw	(OFST-171,sp),x
3297                     ; 555 				PortPin=GPIO_PIN_3;
3299  0a5c a608          	ld	a,#8
3300  0a5e 6b0d          	ld	(OFST-169,sp),a
3302                     ; 556 			}break;
3304  0a60 2040          	jra	L1711
3305  0a62               L577:
3306                     ; 558 				GPIOx=GPIOD;
3308  0a62 ae500f        	ldw	x,#20495
3309  0a65 1f0b          	ldw	(OFST-171,sp),x
3311                     ; 559 				PortPin=GPIO_PIN_2;
3313  0a67 a604          	ld	a,#4
3314  0a69 6b0d          	ld	(OFST-169,sp),a
3316                     ; 560 			}break;
3318  0a6b 2035          	jra	L1711
3319  0a6d               L777:
3320                     ; 562 				GPIOx=GPIOC;
3322  0a6d ae500a        	ldw	x,#20490
3323  0a70 1f0b          	ldw	(OFST-171,sp),x
3325                     ; 563 				PortPin=GPIO_PIN_7;
3327  0a72 a680          	ld	a,#128
3328  0a74 6b0d          	ld	(OFST-169,sp),a
3330                     ; 564 			}break;
3332  0a76 202a          	jra	L1711
3333  0a78               L1001:
3334                     ; 566 				GPIOx=GPIOC;
3336  0a78 ae500a        	ldw	x,#20490
3337  0a7b 1f0b          	ldw	(OFST-171,sp),x
3339                     ; 567 				PortPin=GPIO_PIN_6;
3341  0a7d a640          	ld	a,#64
3342  0a7f 6b0d          	ld	(OFST-169,sp),a
3344                     ; 568 			}break;
3346  0a81 201f          	jra	L1711
3347  0a83               L3001:
3348                     ; 570 				GPIOx=GPIOC;
3350  0a83 ae500a        	ldw	x,#20490
3351  0a86 1f0b          	ldw	(OFST-171,sp),x
3353                     ; 571 				PortPin=GPIO_PIN_5;
3355  0a88 a620          	ld	a,#32
3356  0a8a 6b0d          	ld	(OFST-169,sp),a
3358                     ; 572 			}break;
3360  0a8c 2014          	jra	L1711
3361  0a8e               L5001:
3362                     ; 574 				GPIOx=GPIOC;
3364  0a8e ae500a        	ldw	x,#20490
3365  0a91 1f0b          	ldw	(OFST-171,sp),x
3367                     ; 575 				PortPin=GPIO_PIN_4;
3369  0a93 a610          	ld	a,#16
3370  0a95 6b0d          	ld	(OFST-169,sp),a
3372                     ; 576 			}break;
3374  0a97 2009          	jra	L1711
3375  0a99               L7001:
3376                     ; 578 				GPIOx=GPIOC;
3378  0a99 ae500a        	ldw	x,#20490
3379  0a9c 1f0b          	ldw	(OFST-171,sp),x
3381                     ; 579 				PortPin=GPIO_PIN_3;
3383  0a9e a608          	ld	a,#8
3384  0aa0 6b0d          	ld	(OFST-169,sp),a
3386                     ; 580 			}break;
3388  0aa2               L1711:
3389                     ; 585 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3391  0aa2 0db6          	tnz	(OFST+0,sp)
3392  0aa4 2704          	jreq	L641
3393  0aa6 a6c0          	ld	a,#192
3394  0aa8 2002          	jra	L051
3395  0aaa               L641:
3396  0aaa a6d0          	ld	a,#208
3397  0aac               L051:
3398  0aac 88            	push	a
3399  0aad 7b0e          	ld	a,(OFST-168,sp)
3400  0aaf 88            	push	a
3401  0ab0 1e0d          	ldw	x,(OFST-169,sp)
3402  0ab2 cd0000        	call	_GPIO_Init
3404  0ab5 85            	popw	x
3405                     ; 586 		is_low=!is_low;
3407  0ab6 0db6          	tnz	(OFST+0,sp)
3408  0ab8 2604          	jrne	L251
3409  0aba a601          	ld	a,#1
3410  0abc 2001          	jra	L451
3411  0abe               L251:
3412  0abe 4f            	clr	a
3413  0abf               L451:
3414  0abf 6bb6          	ld	(OFST+0,sp),a
3416                     ; 587 	}while(is_low);
3418  0ac1 0db6          	tnz	(OFST+0,sp)
3419  0ac3 2703          	jreq	L651
3420  0ac5 cc09fe        	jp	L1611
3421  0ac8               L651:
3422                     ; 588 }
3425  0ac8 5bb7          	addw	sp,#183
3426  0aca 81            	ret
3450                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3451                     	xdef	_main
3452                     	xdef	_Serial_print_string
3453                     	xdef	_Serial_newline
3454                     	xdef	_Serial_print_int
3455                     	xdef	_setWhite
3456                     	xdef	_setRGB
3457                     	xdef	_setLED
3458                     	xdef	_setMatrixHighZ
3459                     	xdef	_tms
3460                     	xdef	_ADC_Read
3461                     	xref	_UART1_GetFlagStatus
3462                     	xref	_UART1_SendData8
3463                     	xref	_UART1_Cmd
3464                     	xref	_UART1_Init
3465                     	xref	_UART1_DeInit
3466                     	xref	_GPIO_ReadInputPin
3467                     	xref	_GPIO_Init
3468                     	xref	_ADC1_ClearFlag
3469                     	xref	_ADC1_GetFlagStatus
3470                     	xref	_ADC1_GetConversionValue
3471                     	xref	_ADC1_StartConversion
3472                     	xref	_ADC1_Cmd
3473                     	xref	_ADC1_Init
3474                     	xref	_ADC1_DeInit
3475                     	switch	.const
3476  00e9               L535:
3477  00e9 506172616d73  	dc.b	"Params: ",0
3478  00f2               L725:
3479  00f2 74696d653a20  	dc.b	"time: ",0
3480  00f9               L715:
3481  00f9 506172616d73  	dc.b	"Params v2: ",0
3482  0105               L515:
3483  0105 4d6f64653a20  	dc.b	"Mode: ",0
3484  010c               L574:
3485  010c 2000          	dc.b	" ",0
3486  010e               L534:
3487  010e 2a00          	dc.b	"*",0
3488  0110               L324:
3489  0110 3000          	dc.b	"0",0
3490  0112               L553:
3491  0112 2c2000        	dc.b	", ",0
3492  0115               L353:
3493  0115 6164633a2000  	dc.b	"adc: ",0
3494  011b               L323:
3495  011b 636f756e7465  	dc.b	"counter: ",0
3496                     	xref.b	c_lreg
3497                     	xref.b	c_x
3498                     	xref.b	c_y
3518                     	xref	c_bmulx
3519                     	xref	c_sdivx
3520                     	xref	c_smody
3521                     	xref	c_lxor
3522                     	xref	c_itolx
3523                     	xref	c_lrzmp
3524                     	xref	c_lumd
3525                     	xref	c_imul
3526                     	xref	c_ladd
3527                     	xref	c_lursh
3528                     	xref	c_uitol
3529                     	xref	c_smodx
3530                     	xref	c_ludv
3531                     	xref	c_itol
3532                     	xref	c_rtol
3533                     	xref	c_uitolx
3534                     	xref	c_lzmp
3535                     	xref	c_lcmp
3536                     	xref	c_ltor
3537                     	xref	c_lgadc
3538                     	xref	c_xymov
3539                     	end
