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
 200                     .const:	section	.text
 201  0000               L75_rms_lookup:
 202  0000 09            	dc.b	9
 203  0001 12            	dc.b	18
 204  0002 1c            	dc.b	28
 205  0003 26            	dc.b	38
 206  0004 30            	dc.b	48
 207  0005 3a            	dc.b	58
 208  0006 45            	dc.b	69
 209  0007 50            	dc.b	80
 210  0008 5c            	dc.b	92
 211  0009 69            	dc.b	105
 212  000a 76            	dc.b	118
 213  000b 86            	dc.b	134
 214  000c 97            	dc.b	151
 215  000d ad            	dc.b	173
 216  000e c8            	dc.b	200
 217  000f f1            	dc.b	241
 473                     	switch	.const
 474  0010               L01:
 475  0010 00002710      	dc.l	10000
 476  0014               L21:
 477  0014 00007530      	dc.l	30000
 478  0018               L42:
 479  0018 000003e8      	dc.l	1000
 480  001c               L04:
 481  001c 0000000a      	dc.l	10
 482  0020               L25:
 483  0020 00000014      	dc.l	20
 484  0024               L45:
 485  0024 00000064      	dc.l	100
 486  0028               L65:
 487  0028 000007d0      	dc.l	2000
 488  002c               L46:
 489  002c 00001388      	dc.l	5000
 490  0030               L66:
 491  0030 0000003c      	dc.l	60
 492  0034               L07:
 493  0034 00000005      	dc.l	5
 494  0038               L27:
 495  0038 00000003      	dc.l	3
 496  003c               L001:
 497  003c 00001f40      	dc.l	8000
 498                     ; 21 int main()
 498                     ; 22 {
 499                     	switch	.text
 500  003e               _main:
 502  003e 5238          	subw	sp,#56
 503       00000038      OFST:	set	56
 506                     ; 45 	const int test_mode=9;
 508  0040 ae0009        	ldw	x,#9
 509  0043 1f33          	ldw	(OFST-5,sp),x
 511                     ; 46 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 513  0045 96            	ldw	x,sp
 514  0046 1c0009        	addw	x,#OFST-47
 515  0049 90ae0000      	ldw	y,#L75_rms_lookup
 516  004d a610          	ld	a,#16
 517  004f cd0000        	call	c_xymov
 519                     ; 48 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 523  0052 ae0000        	ldw	x,#0
 524  0055 1f29          	ldw	(OFST-15,sp),x
 525  0057 ae0000        	ldw	x,#0
 526  005a 1f27          	ldw	(OFST-17,sp),x
 532                     ; 49 	unsigned sound_level=0;
 534  005c 5f            	clrw	x
 535  005d 1f31          	ldw	(OFST-7,sp),x
 537                     ; 50 	uint8_t mean_threshold=16;
 539  005f a610          	ld	a,#16
 540  0061 6b24          	ld	(OFST-20,sp),a
 542                     ; 51 	uint8_t mean_threshold_8=1;
 544  0063 a601          	ld	a,#1
 545  0065 6b23          	ld	(OFST-21,sp),a
 547                     ; 52 	uint16_t mean_threshold_16=0x0100;
 549  0067 ae0100        	ldw	x,#256
 550  006a 1f1d          	ldw	(OFST-27,sp),x
 552                     ; 53 	unsigned int rms=0;
 554                     ; 54 	const long adc_captures=1<<8;
 556  006c ae0100        	ldw	x,#256
 557  006f 1f1b          	ldw	(OFST-29,sp),x
 558  0071 ae0000        	ldw	x,#0
 559  0074 1f19          	ldw	(OFST-31,sp),x
 561                     ; 56 	int debug=0;
 563  0076 5f            	clrw	x
 564  0077 1f2b          	ldw	(OFST-13,sp),x
 566                     ; 58 	for(rep=0;rep<1;rep++)
 568  0079 ae0000        	ldw	x,#0
 569  007c 1f2f          	ldw	(OFST-9,sp),x
 570  007e ae0000        	ldw	x,#0
 571  0081 1f2d          	ldw	(OFST-11,sp),x
 573  0083               L752:
 574                     ; 59 		for(iter=0;iter<10000;iter++){}
 576  0083 ae0000        	ldw	x,#0
 577  0086 1f37          	ldw	(OFST-1,sp),x
 578  0088 ae0000        	ldw	x,#0
 579  008b 1f35          	ldw	(OFST-3,sp),x
 581  008d               L562:
 584  008d 96            	ldw	x,sp
 585  008e 1c0035        	addw	x,#OFST-3
 586  0091 a601          	ld	a,#1
 587  0093 cd0000        	call	c_lgadc
 592  0096 96            	ldw	x,sp
 593  0097 1c0035        	addw	x,#OFST-3
 594  009a cd0000        	call	c_ltor
 596  009d ae0010        	ldw	x,#L01
 597  00a0 cd0000        	call	c_lcmp
 599  00a3 25e8          	jrult	L562
 600                     ; 58 	for(rep=0;rep<1;rep++)
 602  00a5 96            	ldw	x,sp
 603  00a6 1c002d        	addw	x,#OFST-11
 604  00a9 a601          	ld	a,#1
 605  00ab cd0000        	call	c_lgadc
 610  00ae 96            	ldw	x,sp
 611  00af 1c002d        	addw	x,#OFST-11
 612  00b2 cd0000        	call	c_lzmp
 614  00b5 27cc          	jreq	L752
 615                     ; 62 	if(test_mode!=4 && test_mode!=5 && test_mode!=9)
 617  00b7 1e33          	ldw	x,(OFST-5,sp)
 618  00b9 a30004        	cpw	x,#4
 619  00bc 2743          	jreq	L372
 621  00be 1e33          	ldw	x,(OFST-5,sp)
 622  00c0 a30005        	cpw	x,#5
 623  00c3 273c          	jreq	L372
 625  00c5 1e33          	ldw	x,(OFST-5,sp)
 626  00c7 a30009        	cpw	x,#9
 627  00ca 2735          	jreq	L372
 628                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 630  00cc 4bf0          	push	#240
 631  00ce 4b20          	push	#32
 632  00d0 ae500f        	ldw	x,#20495
 633  00d3 cd0000        	call	_GPIO_Init
 635  00d6 85            	popw	x
 636                     ; 65 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 638  00d7 4b40          	push	#64
 639  00d9 4b40          	push	#64
 640  00db ae500f        	ldw	x,#20495
 641  00de cd0000        	call	_GPIO_Init
 643  00e1 85            	popw	x
 644                     ; 66 		UART1_DeInit();
 646  00e2 cd0000        	call	_UART1_DeInit
 648                     ; 67 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 650  00e5 4b0c          	push	#12
 651  00e7 4b80          	push	#128
 652  00e9 4b00          	push	#0
 653  00eb 4b00          	push	#0
 654  00ed 4b00          	push	#0
 655  00ef aec200        	ldw	x,#49664
 656  00f2 89            	pushw	x
 657  00f3 ae0001        	ldw	x,#1
 658  00f6 89            	pushw	x
 659  00f7 cd0000        	call	_UART1_Init
 661  00fa 5b09          	addw	sp,#9
 662                     ; 69 		UART1_Cmd(ENABLE);
 664  00fc a601          	ld	a,#1
 665  00fe cd0000        	call	_UART1_Cmd
 667  0101               L372:
 668                     ; 72 	switch(test_mode)
 670  0101 1e33          	ldw	x,(OFST-5,sp)
 672                     ; 492 				for(iter=0;iter<30000;iter++){}
 673  0103 5d            	tnzw	x
 674  0104 2739          	jreq	L103
 675  0106 5a            	decw	x
 676  0107 2603          	jrne	L401
 677  0109 cc01e3        	jp	L543
 678  010c               L401:
 679  010c 5a            	decw	x
 680  010d 2603          	jrne	L601
 681  010f cc0299        	jp	L56
 682  0112               L601:
 683  0112 5a            	decw	x
 684  0113 2603          	jrne	L011
 685  0115 cc04af        	jp	L76
 686  0118               L011:
 687  0118 5a            	decw	x
 688  0119 2603          	jrne	L211
 689  011b cc05e9        	jp	L17
 690  011e               L211:
 691  011e 5a            	decw	x
 692  011f 2603          	jrne	L411
 693  0121 cc064c        	jp	L37
 694  0124               L411:
 695  0124 5a            	decw	x
 696  0125 2603          	jrne	L611
 697  0127 cc07b6        	jp	L57
 698  012a               L611:
 699  012a 5a            	decw	x
 700  012b 2603          	jrne	L021
 701  012d cc0839        	jp	L77
 702  0130               L021:
 703  0130 5a            	decw	x
 704  0131 2603          	jrne	L221
 705  0133 cc0917        	jp	L101
 706  0136               L221:
 707  0136 5a            	decw	x
 708  0137 2603          	jrne	L421
 709  0139 cc0996        	jp	L301
 710  013c               L421:
 711  013c               L201:
 712                     ; 497 }
 715  013c 5b38          	addw	sp,#56
 716  013e 81            	ret
 717  013f               L103:
 718                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 720  013f 5f            	clrw	x
 721  0140 1f31          	ldw	(OFST-7,sp),x
 723  0142               L503:
 724                     ; 82 					for(led_index=0;led_index<10;led_index++)
 726  0142 5f            	clrw	x
 727  0143 1f33          	ldw	(OFST-5,sp),x
 729  0145               L313:
 730                     ; 84 						setMatrixHighZ();
 732  0145 cd0b0e        	call	_setMatrixHighZ
 734                     ; 85 						setRGB(led_index,rgb_index);
 736  0148 1e31          	ldw	x,(OFST-7,sp)
 737  014a 89            	pushw	x
 738  014b 1e35          	ldw	x,(OFST-3,sp)
 739  014d cd0b25        	call	_setRGB
 741  0150 85            	popw	x
 742                     ; 86 						for(iter=0;iter<30000;iter++){}
 744  0151 ae0000        	ldw	x,#0
 745  0154 1f37          	ldw	(OFST-1,sp),x
 746  0156 ae0000        	ldw	x,#0
 747  0159 1f35          	ldw	(OFST-3,sp),x
 749  015b               L123:
 752  015b 96            	ldw	x,sp
 753  015c 1c0035        	addw	x,#OFST-3
 754  015f a601          	ld	a,#1
 755  0161 cd0000        	call	c_lgadc
 760  0164 96            	ldw	x,sp
 761  0165 1c0035        	addw	x,#OFST-3
 762  0168 cd0000        	call	c_ltor
 764  016b ae0014        	ldw	x,#L21
 765  016e cd0000        	call	c_lcmp
 767  0171 25e8          	jrult	L123
 768                     ; 87 						debug++;
 770  0173 1e2b          	ldw	x,(OFST-13,sp)
 771  0175 1c0001        	addw	x,#1
 772  0178 1f2b          	ldw	(OFST-13,sp),x
 774                     ; 94 							Serial_print_string("counter: ");
 776  017a ae012f        	ldw	x,#L723
 777  017d cd0a73        	call	_Serial_print_string
 779                     ; 95 							Serial_print_int(debug);
 781  0180 1e2b          	ldw	x,(OFST-13,sp)
 782  0182 cd0a9c        	call	_Serial_print_int
 784                     ; 98 							Serial_newline();
 786  0185 cd0aff        	call	_Serial_newline
 788                     ; 82 					for(led_index=0;led_index<10;led_index++)
 790  0188 1e33          	ldw	x,(OFST-5,sp)
 791  018a 1c0001        	addw	x,#1
 792  018d 1f33          	ldw	(OFST-5,sp),x
 796  018f 1e33          	ldw	x,(OFST-5,sp)
 797  0191 a3000a        	cpw	x,#10
 798  0194 25af          	jrult	L313
 799                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 801  0196 1e31          	ldw	x,(OFST-7,sp)
 802  0198 1c0001        	addw	x,#1
 803  019b 1f31          	ldw	(OFST-7,sp),x
 807  019d 1e31          	ldw	x,(OFST-7,sp)
 808  019f a30003        	cpw	x,#3
 809  01a2 259e          	jrult	L503
 810                     ; 102 				for(led_index=0;led_index<12;led_index++)
 812  01a4 5f            	clrw	x
 813  01a5 1f33          	ldw	(OFST-5,sp),x
 815  01a7               L133:
 816                     ; 104 					setMatrixHighZ();
 818  01a7 cd0b0e        	call	_setMatrixHighZ
 820                     ; 105 					setWhite(led_index);
 822  01aa 1e33          	ldw	x,(OFST-5,sp)
 823  01ac cd0b34        	call	_setWhite
 825                     ; 106 					for(iter=0;iter<30000;iter++){}
 827  01af ae0000        	ldw	x,#0
 828  01b2 1f37          	ldw	(OFST-1,sp),x
 829  01b4 ae0000        	ldw	x,#0
 830  01b7 1f35          	ldw	(OFST-3,sp),x
 832  01b9               L733:
 835  01b9 96            	ldw	x,sp
 836  01ba 1c0035        	addw	x,#OFST-3
 837  01bd a601          	ld	a,#1
 838  01bf cd0000        	call	c_lgadc
 843  01c2 96            	ldw	x,sp
 844  01c3 1c0035        	addw	x,#OFST-3
 845  01c6 cd0000        	call	c_ltor
 847  01c9 ae0014        	ldw	x,#L21
 848  01cc cd0000        	call	c_lcmp
 850  01cf 25e8          	jrult	L733
 851                     ; 102 				for(led_index=0;led_index<12;led_index++)
 853  01d1 1e33          	ldw	x,(OFST-5,sp)
 854  01d3 1c0001        	addw	x,#1
 855  01d6 1f33          	ldw	(OFST-5,sp),x
 859  01d8 1e33          	ldw	x,(OFST-5,sp)
 860  01da a3000c        	cpw	x,#12
 861  01dd 25c8          	jrult	L133
 863  01df ac3f013f      	jpf	L103
 864  01e3               L543:
 865                     ; 114 				rep=ADC_Read(AIN4);
 867  01e3 a604          	ld	a,#4
 868  01e5 cd0000        	call	_ADC_Read
 870  01e8 cd0000        	call	c_uitolx
 872  01eb 96            	ldw	x,sp
 873  01ec 1c002d        	addw	x,#OFST-11
 874  01ef cd0000        	call	c_rtol
 877                     ; 115 				my_min=rep;
 879  01f2 1e2f          	ldw	x,(OFST-9,sp)
 880  01f4 1f2b          	ldw	(OFST-13,sp),x
 882                     ; 116 				my_max=rep;
 884  01f6 1e2f          	ldw	x,(OFST-9,sp)
 885  01f8 1f31          	ldw	(OFST-7,sp),x
 887                     ; 117 				for(iter=0;iter<1000;iter++)
 889  01fa ae0000        	ldw	x,#0
 890  01fd 1f37          	ldw	(OFST-1,sp),x
 891  01ff ae0000        	ldw	x,#0
 892  0202 1f35          	ldw	(OFST-3,sp),x
 894  0204               L153:
 895                     ; 119 					rep=ADC_Read(AIN4);
 897  0204 a604          	ld	a,#4
 898  0206 cd0000        	call	_ADC_Read
 900  0209 cd0000        	call	c_uitolx
 902  020c 96            	ldw	x,sp
 903  020d 1c002d        	addw	x,#OFST-11
 904  0210 cd0000        	call	c_rtol
 907                     ; 120 					my_min=my_min<rep?my_min:rep;
 909  0213 1e2b          	ldw	x,(OFST-13,sp)
 910  0215 cd0000        	call	c_uitolx
 912  0218 96            	ldw	x,sp
 913  0219 1c002d        	addw	x,#OFST-11
 914  021c cd0000        	call	c_lcmp
 916  021f 2404          	jruge	L41
 917  0221 1e2b          	ldw	x,(OFST-13,sp)
 918  0223 2002          	jra	L61
 919  0225               L41:
 920  0225 1e2f          	ldw	x,(OFST-9,sp)
 921  0227               L61:
 922  0227 1f2b          	ldw	(OFST-13,sp),x
 924                     ; 121 					my_max=my_max>rep?my_max:rep;
 926  0229 1e31          	ldw	x,(OFST-7,sp)
 927  022b cd0000        	call	c_uitolx
 929  022e 96            	ldw	x,sp
 930  022f 1c002d        	addw	x,#OFST-11
 931  0232 cd0000        	call	c_lcmp
 933  0235 2304          	jrule	L02
 934  0237 1e31          	ldw	x,(OFST-7,sp)
 935  0239 2002          	jra	L22
 936  023b               L02:
 937  023b 1e2f          	ldw	x,(OFST-9,sp)
 938  023d               L22:
 939  023d 1f31          	ldw	(OFST-7,sp),x
 941                     ; 117 				for(iter=0;iter<1000;iter++)
 943  023f 96            	ldw	x,sp
 944  0240 1c0035        	addw	x,#OFST-3
 945  0243 a601          	ld	a,#1
 946  0245 cd0000        	call	c_lgadc
 951  0248 96            	ldw	x,sp
 952  0249 1c0035        	addw	x,#OFST-3
 953  024c cd0000        	call	c_ltor
 955  024f ae0018        	ldw	x,#L42
 956  0252 cd0000        	call	c_lcmp
 958  0255 25ad          	jrult	L153
 959                     ; 123 				Serial_print_string("adc: ");
 961  0257 ae0129        	ldw	x,#L753
 962  025a cd0a73        	call	_Serial_print_string
 964                     ; 124 				Serial_print_int(rep);
 966  025d 1e2f          	ldw	x,(OFST-9,sp)
 967  025f cd0a9c        	call	_Serial_print_int
 969                     ; 125 				Serial_print_string(", ");
 971  0262 ae0126        	ldw	x,#L163
 972  0265 cd0a73        	call	_Serial_print_string
 974                     ; 126 				Serial_print_int(my_max-my_min);
 976  0268 1e31          	ldw	x,(OFST-7,sp)
 977  026a 72f02b        	subw	x,(OFST-13,sp)
 978  026d cd0a9c        	call	_Serial_print_int
 980                     ; 127 				Serial_newline();
 982  0270 cd0aff        	call	_Serial_newline
 984                     ; 128 				for(iter=0;iter<10000;iter++){}
 986  0273 ae0000        	ldw	x,#0
 987  0276 1f37          	ldw	(OFST-1,sp),x
 988  0278 ae0000        	ldw	x,#0
 989  027b 1f35          	ldw	(OFST-3,sp),x
 991  027d               L363:
 994  027d 96            	ldw	x,sp
 995  027e 1c0035        	addw	x,#OFST-3
 996  0281 a601          	ld	a,#1
 997  0283 cd0000        	call	c_lgadc
1002  0286 96            	ldw	x,sp
1003  0287 1c0035        	addw	x,#OFST-3
1004  028a cd0000        	call	c_ltor
1006  028d ae0010        	ldw	x,#L01
1007  0290 cd0000        	call	c_lcmp
1009  0293 25e8          	jrult	L363
1011  0295 ace301e3      	jpf	L543
1012  0299               L56:
1013                     ; 133 			ADC1_DeInit();
1015  0299 cd0000        	call	_ADC1_DeInit
1017                     ; 134 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1017                     ; 135 							 AIN4,
1017                     ; 136 							 ADC1_PRESSEL_FCPU_D2,//D18 
1017                     ; 137 							 ADC1_EXTTRIG_TIM, 
1017                     ; 138 							 DISABLE, 
1017                     ; 139 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1017                     ; 140 							 ADC1_SCHMITTTRIG_ALL, 
1017                     ; 141 							 DISABLE);
1019  029c 4b00          	push	#0
1020  029e 4bff          	push	#255
1021  02a0 4b08          	push	#8
1022  02a2 4b00          	push	#0
1023  02a4 4b00          	push	#0
1024  02a6 4b00          	push	#0
1025  02a8 ae0104        	ldw	x,#260
1026  02ab cd0000        	call	_ADC1_Init
1028  02ae 5b06          	addw	sp,#6
1029                     ; 142 			ADC1_Cmd(ENABLE);
1031  02b0 a601          	ld	a,#1
1032  02b2 cd0000        	call	_ADC1_Cmd
1034  02b5               L173:
1035                     ; 166 				rms=0;
1037  02b5 5f            	clrw	x
1038  02b6 1f33          	ldw	(OFST-5,sp),x
1040                     ; 168 				mean_sum=0;
1042  02b8 ae0000        	ldw	x,#0
1043  02bb 1f29          	ldw	(OFST-15,sp),x
1044  02bd ae0000        	ldw	x,#0
1045  02c0 1f27          	ldw	(OFST-17,sp),x
1047                     ; 169 				mean_low=mean+mean_threshold;
1049  02c2 7b25          	ld	a,(OFST-19,sp)
1050  02c4 5f            	clrw	x
1051  02c5 1b24          	add	a,(OFST-20,sp)
1052  02c7 2401          	jrnc	L62
1053  02c9 5c            	incw	x
1054  02ca               L62:
1055  02ca cd0000        	call	c_itol
1057  02cd 96            	ldw	x,sp
1058  02ce 1c001f        	addw	x,#OFST-25
1059  02d1 cd0000        	call	c_rtol
1062                     ; 170 				mean_high=mean-mean_threshold;
1064  02d4 7b25          	ld	a,(OFST-19,sp)
1065  02d6 5f            	clrw	x
1066  02d7 1024          	sub	a,(OFST-20,sp)
1067  02d9 2401          	jrnc	L03
1068  02db 5a            	decw	x
1069  02dc               L03:
1070  02dc cd0000        	call	c_itol
1072  02df 96            	ldw	x,sp
1073  02e0 1c002d        	addw	x,#OFST-11
1074  02e3 cd0000        	call	c_rtol
1077                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1079  02e6 ae0000        	ldw	x,#0
1080  02e9 1f37          	ldw	(OFST-1,sp),x
1081  02eb ae0000        	ldw	x,#0
1082  02ee 1f35          	ldw	(OFST-3,sp),x
1085  02f0 2058          	jra	L104
1086  02f2               L573:
1087                     ; 174 					ADC1_StartConversion();
1089  02f2 cd0000        	call	_ADC1_StartConversion
1092  02f5               L704:
1093                     ; 175 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1095  02f5 a680          	ld	a,#128
1096  02f7 cd0000        	call	_ADC1_GetFlagStatus
1098  02fa 4d            	tnz	a
1099  02fb 27f8          	jreq	L704
1100                     ; 177 					reading=ADC1->DRL;
1102  02fd c65405        	ld	a,21509
1103  0300 6b26          	ld	(OFST-18,sp),a
1105                     ; 178 					mean_sum += reading;
1107  0302 7b26          	ld	a,(OFST-18,sp)
1108  0304 96            	ldw	x,sp
1109  0305 1c0027        	addw	x,#OFST-17
1110  0308 cd0000        	call	c_lgadc
1113                     ; 179 					rms+=reading>mean_low || reading<mean_high;
1115  030b 7b26          	ld	a,(OFST-18,sp)
1116  030d b703          	ld	c_lreg+3,a
1117  030f 3f02          	clr	c_lreg+2
1118  0311 3f01          	clr	c_lreg+1
1119  0313 3f00          	clr	c_lreg
1120  0315 96            	ldw	x,sp
1121  0316 1c001f        	addw	x,#OFST-25
1122  0319 cd0000        	call	c_lcmp
1124  031c 2213          	jrugt	L43
1125  031e 7b26          	ld	a,(OFST-18,sp)
1126  0320 b703          	ld	c_lreg+3,a
1127  0322 3f02          	clr	c_lreg+2
1128  0324 3f01          	clr	c_lreg+1
1129  0326 3f00          	clr	c_lreg
1130  0328 96            	ldw	x,sp
1131  0329 1c002d        	addw	x,#OFST-11
1132  032c cd0000        	call	c_lcmp
1134  032f 2405          	jruge	L23
1135  0331               L43:
1136  0331 ae0001        	ldw	x,#1
1137  0334 2001          	jra	L63
1138  0336               L23:
1139  0336 5f            	clrw	x
1140  0337               L63:
1141  0337 72fb33        	addw	x,(OFST-5,sp)
1142  033a 1f33          	ldw	(OFST-5,sp),x
1144                     ; 183 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1146  033c a680          	ld	a,#128
1147  033e cd0000        	call	_ADC1_ClearFlag
1149                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1151  0341 96            	ldw	x,sp
1152  0342 1c0035        	addw	x,#OFST-3
1153  0345 a601          	ld	a,#1
1154  0347 cd0000        	call	c_lgadc
1157  034a               L104:
1160  034a 96            	ldw	x,sp
1161  034b 1c0035        	addw	x,#OFST-3
1162  034e cd0000        	call	c_ltor
1164  0351 96            	ldw	x,sp
1165  0352 1c0019        	addw	x,#OFST-31
1166  0355 cd0000        	call	c_lcmp
1168  0358 2598          	jrult	L573
1169                     ; 187 				if(rms>9) mean_threshold++;
1171  035a 1e33          	ldw	x,(OFST-5,sp)
1172  035c a3000a        	cpw	x,#10
1173  035f 2502          	jrult	L314
1176  0361 0c24          	inc	(OFST-20,sp)
1178  0363               L314:
1179                     ; 188 				if(rms==0) mean_threshold--;
1181  0363 1e33          	ldw	x,(OFST-5,sp)
1182  0365 2602          	jrne	L514
1185  0367 0a24          	dec	(OFST-20,sp)
1187  0369               L514:
1188                     ; 189 				mean=(mean_sum)/(adc_captures);
1190  0369 96            	ldw	x,sp
1191  036a 1c0027        	addw	x,#OFST-17
1192  036d cd0000        	call	c_ltor
1194  0370 96            	ldw	x,sp
1195  0371 1c0019        	addw	x,#OFST-31
1196  0374 cd0000        	call	c_ludv
1198  0377 b603          	ld	a,c_lreg+3
1199  0379 6b25          	ld	(OFST-19,sp),a
1201                     ; 190 				if(sound_level/32<mean_threshold) sound_level++;
1203  037b 1e31          	ldw	x,(OFST-7,sp)
1204  037d 54            	srlw	x
1205  037e 54            	srlw	x
1206  037f 54            	srlw	x
1207  0380 54            	srlw	x
1208  0381 54            	srlw	x
1209  0382 7b24          	ld	a,(OFST-20,sp)
1210  0384 905f          	clrw	y
1211  0386 9097          	ld	yl,a
1212  0388 90bf00        	ldw	c_y,y
1213  038b b300          	cpw	x,c_y
1214  038d 2407          	jruge	L714
1217  038f 1e31          	ldw	x,(OFST-7,sp)
1218  0391 1c0001        	addw	x,#1
1219  0394 1f31          	ldw	(OFST-7,sp),x
1221  0396               L714:
1222                     ; 191 				if(sound_level/32>mean_threshold) sound_level--;
1224  0396 1e31          	ldw	x,(OFST-7,sp)
1225  0398 54            	srlw	x
1226  0399 54            	srlw	x
1227  039a 54            	srlw	x
1228  039b 54            	srlw	x
1229  039c 54            	srlw	x
1230  039d 7b24          	ld	a,(OFST-20,sp)
1231  039f 905f          	clrw	y
1232  03a1 9097          	ld	yl,a
1233  03a3 90bf00        	ldw	c_y,y
1234  03a6 b300          	cpw	x,c_y
1235  03a8 2307          	jrule	L124
1238  03aa 1e31          	ldw	x,(OFST-7,sp)
1239  03ac 1d0001        	subw	x,#1
1240  03af 1f31          	ldw	(OFST-7,sp),x
1242  03b1               L124:
1243                     ; 192 				if(debug%4==0)
1245  03b1 1e2b          	ldw	x,(OFST-13,sp)
1246  03b3 a604          	ld	a,#4
1247  03b5 cd0000        	call	c_smodx
1249  03b8 a30000        	cpw	x,#0
1250  03bb 267b          	jrne	L324
1251                     ; 194 					Serial_print_string("adc: ");
1253  03bd ae0129        	ldw	x,#L753
1254  03c0 cd0a73        	call	_Serial_print_string
1256                     ; 195 					Serial_print_int(mean);
1258  03c3 7b25          	ld	a,(OFST-19,sp)
1259  03c5 5f            	clrw	x
1260  03c6 97            	ld	xl,a
1261  03c7 cd0a9c        	call	_Serial_print_int
1263                     ; 196 					Serial_print_string(", ");
1265  03ca ae0126        	ldw	x,#L163
1266  03cd cd0a73        	call	_Serial_print_string
1268                     ; 197 					if(rms<9) Serial_print_string("0");
1270  03d0 1e33          	ldw	x,(OFST-5,sp)
1271  03d2 a30009        	cpw	x,#9
1272  03d5 2406          	jruge	L524
1275  03d7 ae0124        	ldw	x,#L724
1276  03da cd0a73        	call	_Serial_print_string
1278  03dd               L524:
1279                     ; 198 					if(rms==0) Serial_print_string("0");
1281  03dd 1e33          	ldw	x,(OFST-5,sp)
1282  03df 2606          	jrne	L134
1285  03e1 ae0124        	ldw	x,#L724
1286  03e4 cd0a73        	call	_Serial_print_string
1288  03e7               L134:
1289                     ; 199 					Serial_print_int(rms);
1291  03e7 1e33          	ldw	x,(OFST-5,sp)
1292  03e9 cd0a9c        	call	_Serial_print_int
1294                     ; 200 					Serial_print_string(", ");
1296  03ec ae0126        	ldw	x,#L163
1297  03ef cd0a73        	call	_Serial_print_string
1299                     ; 201 					if(mean_threshold<9) Serial_print_string("0");
1301  03f2 7b24          	ld	a,(OFST-20,sp)
1302  03f4 a109          	cp	a,#9
1303  03f6 2406          	jruge	L334
1306  03f8 ae0124        	ldw	x,#L724
1307  03fb cd0a73        	call	_Serial_print_string
1309  03fe               L334:
1310                     ; 202 					Serial_print_int(mean_threshold);
1312  03fe 7b24          	ld	a,(OFST-20,sp)
1313  0400 5f            	clrw	x
1314  0401 97            	ld	xl,a
1315  0402 cd0a9c        	call	_Serial_print_int
1317                     ; 203 					Serial_print_string(", ");
1319  0405 ae0126        	ldw	x,#L163
1320  0408 cd0a73        	call	_Serial_print_string
1322                     ; 204 					if(sound_level/8<9) Serial_print_string("0");
1324  040b 1e31          	ldw	x,(OFST-7,sp)
1325  040d 54            	srlw	x
1326  040e 54            	srlw	x
1327  040f 54            	srlw	x
1328  0410 a30009        	cpw	x,#9
1329  0413 2406          	jruge	L534
1332  0415 ae0124        	ldw	x,#L724
1333  0418 cd0a73        	call	_Serial_print_string
1335  041b               L534:
1336                     ; 205 					Serial_print_int(sound_level/8);
1338  041b 1e31          	ldw	x,(OFST-7,sp)
1339  041d 54            	srlw	x
1340  041e 54            	srlw	x
1341  041f 54            	srlw	x
1342  0420 cd0a9c        	call	_Serial_print_int
1344                     ; 206 					if(debug%10==0) Serial_print_string("*");
1346  0423 1e2b          	ldw	x,(OFST-13,sp)
1347  0425 a60a          	ld	a,#10
1348  0427 cd0000        	call	c_smodx
1350  042a a30000        	cpw	x,#0
1351  042d 2606          	jrne	L734
1354  042f ae0122        	ldw	x,#L144
1355  0432 cd0a73        	call	_Serial_print_string
1357  0435               L734:
1358                     ; 207 					Serial_newline();
1360  0435 cd0aff        	call	_Serial_newline
1362  0438               L324:
1363                     ; 209 				if(mean_threshold>10)
1365  0438 7b24          	ld	a,(OFST-20,sp)
1366  043a a10b          	cp	a,#11
1367  043c 2518          	jrult	L344
1368                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1370  043e 4bd0          	push	#208
1371  0440 4b08          	push	#8
1372  0442 ae500a        	ldw	x,#20490
1373  0445 cd0000        	call	_GPIO_Init
1375  0448 85            	popw	x
1376                     ; 214 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1378  0449 4bc0          	push	#192
1379  044b 4b20          	push	#32
1380  044d ae500a        	ldw	x,#20490
1381  0450 cd0000        	call	_GPIO_Init
1383  0453 85            	popw	x
1385  0454 2016          	jra	L544
1386  0456               L344:
1387                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1389  0456 4bd0          	push	#208
1390  0458 4b10          	push	#16
1391  045a ae500a        	ldw	x,#20490
1392  045d cd0000        	call	_GPIO_Init
1394  0460 85            	popw	x
1395                     ; 217 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1397  0461 4bc0          	push	#192
1398  0463 4b40          	push	#64
1399  0465 ae500a        	ldw	x,#20490
1400  0468 cd0000        	call	_GPIO_Init
1402  046b 85            	popw	x
1403  046c               L544:
1404                     ; 219 			for(iter=0;iter<10;iter++){}
1406  046c ae0000        	ldw	x,#0
1407  046f 1f37          	ldw	(OFST-1,sp),x
1408  0471 ae0000        	ldw	x,#0
1409  0474 1f35          	ldw	(OFST-3,sp),x
1411  0476               L744:
1414  0476 96            	ldw	x,sp
1415  0477 1c0035        	addw	x,#OFST-3
1416  047a a601          	ld	a,#1
1417  047c cd0000        	call	c_lgadc
1422  047f 96            	ldw	x,sp
1423  0480 1c0035        	addw	x,#OFST-3
1424  0483 cd0000        	call	c_ltor
1426  0486 ae001c        	ldw	x,#L04
1427  0489 cd0000        	call	c_lcmp
1429  048c 25e8          	jrult	L744
1430                     ; 220 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1432  048e 4b00          	push	#0
1433  0490 4bf8          	push	#248
1434  0492 ae500a        	ldw	x,#20490
1435  0495 cd0000        	call	_GPIO_Init
1437  0498 85            	popw	x
1438                     ; 221 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1440  0499 4b00          	push	#0
1441  049b 4b04          	push	#4
1442  049d ae500f        	ldw	x,#20495
1443  04a0 cd0000        	call	_GPIO_Init
1445  04a3 85            	popw	x
1446                     ; 223 				debug++;
1448  04a4 1e2b          	ldw	x,(OFST-13,sp)
1449  04a6 1c0001        	addw	x,#1
1450  04a9 1f2b          	ldw	(OFST-13,sp),x
1453  04ab acb502b5      	jpf	L173
1454  04af               L76:
1455                     ; 229 			ADC1_DeInit();
1457  04af cd0000        	call	_ADC1_DeInit
1459                     ; 230 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1459                     ; 231 							 AIN4,
1459                     ; 232 							 ADC1_PRESSEL_FCPU_D2,//D18 
1459                     ; 233 							 ADC1_EXTTRIG_TIM, 
1459                     ; 234 							 DISABLE, 
1459                     ; 235 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1459                     ; 236 							 ADC1_SCHMITTTRIG_ALL, 
1459                     ; 237 							 DISABLE);
1461  04b2 4b00          	push	#0
1462  04b4 4bff          	push	#255
1463  04b6 4b08          	push	#8
1464  04b8 4b00          	push	#0
1465  04ba 4b00          	push	#0
1466  04bc 4b00          	push	#0
1467  04be ae0104        	ldw	x,#260
1468  04c1 cd0000        	call	_ADC1_Init
1470  04c4 5b06          	addw	sp,#6
1471                     ; 238 			ADC1_Cmd(ENABLE);
1473  04c6 a601          	ld	a,#1
1474  04c8 cd0000        	call	_ADC1_Cmd
1476  04cb               L554:
1477                     ; 241 				debug++;
1479  04cb 1e2b          	ldw	x,(OFST-13,sp)
1480  04cd 1c0001        	addw	x,#1
1481  04d0 1f2b          	ldw	(OFST-13,sp),x
1483                     ; 242 				rms=0;//8 bit
1485  04d2 5f            	clrw	x
1486  04d3 1f33          	ldw	(OFST-5,sp),x
1488                     ; 244 				mean_sum=0;//16 bit
1490  04d5 ae0000        	ldw	x,#0
1491  04d8 1f29          	ldw	(OFST-15,sp),x
1492  04da ae0000        	ldw	x,#0
1493  04dd 1f27          	ldw	(OFST-17,sp),x
1495                     ; 247 				iter=0;
1497  04df ae0000        	ldw	x,#0
1498  04e2 1f37          	ldw	(OFST-1,sp),x
1499  04e4 ae0000        	ldw	x,#0
1500  04e7 1f35          	ldw	(OFST-3,sp),x
1502  04e9               L164:
1503                     ; 250 					ADC1_StartConversion();
1505  04e9 cd0000        	call	_ADC1_StartConversion
1508  04ec               L174:
1509                     ; 251 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1511  04ec a680          	ld	a,#128
1512  04ee cd0000        	call	_ADC1_GetFlagStatus
1514  04f1 4d            	tnz	a
1515  04f2 27f8          	jreq	L174
1516                     ; 253 					reading=ADC1->DRL;
1518  04f4 c65405        	ld	a,21509
1519  04f7 6b26          	ld	(OFST-18,sp),a
1521                     ; 254 					mean_sum += reading;
1523  04f9 7b26          	ld	a,(OFST-18,sp)
1524  04fb 96            	ldw	x,sp
1525  04fc 1c0027        	addw	x,#OFST-17
1526  04ff cd0000        	call	c_lgadc
1529                     ; 256 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1531  0502 7b26          	ld	a,(OFST-18,sp)
1532  0504 1125          	cp	a,(OFST-19,sp)
1533  0506 2306          	jrule	L24
1534  0508 7b26          	ld	a,(OFST-18,sp)
1535  050a 1025          	sub	a,(OFST-19,sp)
1536  050c 2004          	jra	L44
1537  050e               L24:
1538  050e 7b25          	ld	a,(OFST-19,sp)
1539  0510 1026          	sub	a,(OFST-18,sp)
1540  0512               L44:
1541  0512 6b24          	ld	(OFST-20,sp),a
1543                     ; 257 					rms+=mean_diff>mean_threshold_8;
1545  0514 7b24          	ld	a,(OFST-20,sp)
1546  0516 1123          	cp	a,(OFST-21,sp)
1547  0518 2305          	jrule	L64
1548  051a ae0001        	ldw	x,#1
1549  051d 2001          	jra	L05
1550  051f               L64:
1551  051f 5f            	clrw	x
1552  0520               L05:
1553  0520 72fb33        	addw	x,(OFST-5,sp)
1554  0523 1f33          	ldw	(OFST-5,sp),x
1556                     ; 259 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1558  0525 a680          	ld	a,#128
1559  0527 cd0000        	call	_ADC1_ClearFlag
1561                     ; 262 					iter++;
1563  052a 96            	ldw	x,sp
1564  052b 1c0035        	addw	x,#OFST-3
1565  052e a601          	ld	a,#1
1566  0530 cd0000        	call	c_lgadc
1569                     ; 263 					iter%=256;//8 bit unsigned
1571  0533 0f37          	clr	(OFST-1,sp)
1572  0535 0f36          	clr	(OFST-2,sp)
1573  0537 0f35          	clr	(OFST-3,sp)
1575                     ; 264 				}while(iter!=0);//run 255 times
1577  0539 96            	ldw	x,sp
1578  053a 1c0035        	addw	x,#OFST-3
1579  053d cd0000        	call	c_lzmp
1581  0540 26a7          	jrne	L164
1582                     ; 265 				mean=((uint16_t)mean+mean_sum/256)/2;
1584  0542 96            	ldw	x,sp
1585  0543 1c0027        	addw	x,#OFST-17
1586  0546 cd0000        	call	c_ltor
1588  0549 a608          	ld	a,#8
1589  054b cd0000        	call	c_lursh
1591  054e 96            	ldw	x,sp
1592  054f 1c0001        	addw	x,#OFST-55
1593  0552 cd0000        	call	c_rtol
1596  0555 7b25          	ld	a,(OFST-19,sp)
1597  0557 b703          	ld	c_lreg+3,a
1598  0559 3f02          	clr	c_lreg+2
1599  055b 3f01          	clr	c_lreg+1
1600  055d 3f00          	clr	c_lreg
1601  055f 96            	ldw	x,sp
1602  0560 1c0001        	addw	x,#OFST-55
1603  0563 cd0000        	call	c_ladd
1605  0566 3400          	srl	c_lreg
1606  0568 3601          	rrc	c_lreg+1
1607  056a 3602          	rrc	c_lreg+2
1608  056c 3603          	rrc	c_lreg+3
1609  056e b603          	ld	a,c_lreg+3
1610  0570 6b25          	ld	(OFST-19,sp),a
1612                     ; 266 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1614  0572 96            	ldw	x,sp
1615  0573 1c0009        	addw	x,#OFST-47
1616  0576 1f03          	ldw	(OFST-53,sp),x
1618  0578 1e33          	ldw	x,(OFST-5,sp)
1619  057a 54            	srlw	x
1620  057b 54            	srlw	x
1621  057c 54            	srlw	x
1622  057d 54            	srlw	x
1623  057e 72fb03        	addw	x,(OFST-53,sp)
1624  0581 f6            	ld	a,(x)
1625  0582 5f            	clrw	x
1626  0583 97            	ld	xl,a
1627  0584 161d          	ldw	y,(OFST-27,sp)
1628  0586 cd0000        	call	c_imul
1630  0589 54            	srlw	x
1631  058a 54            	srlw	x
1632  058b 54            	srlw	x
1633  058c 54            	srlw	x
1634  058d 54            	srlw	x
1635  058e 72fb1d        	addw	x,(OFST-27,sp)
1636  0591 54            	srlw	x
1637  0592 1f1d          	ldw	(OFST-27,sp),x
1639                     ; 267 				mean_threshold_8=mean_threshold_16/256;
1641  0594 7b1d          	ld	a,(OFST-27,sp)
1642  0596 6b23          	ld	(OFST-21,sp),a
1644                     ; 268 				if(mean_threshold_8==0)
1646  0598 0d23          	tnz	(OFST-21,sp)
1647  059a 2609          	jrne	L574
1648                     ; 270 					mean_threshold_8=1;
1650  059c a601          	ld	a,#1
1651  059e 6b23          	ld	(OFST-21,sp),a
1653                     ; 271 					mean_threshold_16=0x0100;
1655  05a0 ae0100        	ldw	x,#256
1656  05a3 1f1d          	ldw	(OFST-27,sp),x
1658  05a5               L574:
1659                     ; 276 					if(mean==0) Serial_print_string("0");
1661  05a5 0d25          	tnz	(OFST-19,sp)
1662  05a7 2606          	jrne	L774
1665  05a9 ae0124        	ldw	x,#L724
1666  05ac cd0a73        	call	_Serial_print_string
1668  05af               L774:
1669                     ; 277 					Serial_print_int(mean);
1671  05af 7b25          	ld	a,(OFST-19,sp)
1672  05b1 5f            	clrw	x
1673  05b2 97            	ld	xl,a
1674  05b3 cd0a9c        	call	_Serial_print_int
1676                     ; 279 					Serial_print_string(" ");
1678  05b6 ae0120        	ldw	x,#L105
1679  05b9 cd0a73        	call	_Serial_print_string
1681                     ; 282 					if(rms==0) Serial_print_string("0");
1683  05bc 1e33          	ldw	x,(OFST-5,sp)
1684  05be 2606          	jrne	L305
1687  05c0 ae0124        	ldw	x,#L724
1688  05c3 cd0a73        	call	_Serial_print_string
1690  05c6               L305:
1691                     ; 283 					Serial_print_int(rms);
1693  05c6 1e33          	ldw	x,(OFST-5,sp)
1694  05c8 cd0a9c        	call	_Serial_print_int
1696                     ; 285 					Serial_print_string(" ");
1698  05cb ae0120        	ldw	x,#L105
1699  05ce cd0a73        	call	_Serial_print_string
1701                     ; 286 					if(mean_threshold_8==0) Serial_print_string("0");
1703  05d1 0d23          	tnz	(OFST-21,sp)
1704  05d3 2606          	jrne	L505
1707  05d5 ae0124        	ldw	x,#L724
1708  05d8 cd0a73        	call	_Serial_print_string
1710  05db               L505:
1711                     ; 287 					Serial_print_int(mean_threshold_8);
1713  05db 7b23          	ld	a,(OFST-21,sp)
1714  05dd 5f            	clrw	x
1715  05de 97            	ld	xl,a
1716  05df cd0a9c        	call	_Serial_print_int
1718                     ; 289 					Serial_newline();
1720  05e2 cd0aff        	call	_Serial_newline
1723  05e5 accb04cb      	jpf	L554
1724  05e9               L17:
1725                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1727  05e9 4b40          	push	#64
1728  05eb 4b20          	push	#32
1729  05ed ae500f        	ldw	x,#20495
1730  05f0 cd0000        	call	_GPIO_Init
1732  05f3 85            	popw	x
1733                     ; 296 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1735  05f4 4b40          	push	#64
1736  05f6 4b40          	push	#64
1737  05f8 ae500f        	ldw	x,#20495
1738  05fb cd0000        	call	_GPIO_Init
1740  05fe 85            	popw	x
1741  05ff               L705:
1742                     ; 299 			  setMatrixHighZ();
1744  05ff cd0b0e        	call	_setMatrixHighZ
1746                     ; 300 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1748  0602 4b20          	push	#32
1749  0604 ae500f        	ldw	x,#20495
1750  0607 cd0000        	call	_GPIO_ReadInputPin
1752  060a 5b01          	addw	sp,#1
1753  060c 4d            	tnz	a
1754  060d 2618          	jrne	L315
1755                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1757  060f 4bd0          	push	#208
1758  0611 4b08          	push	#8
1759  0613 ae500a        	ldw	x,#20490
1760  0616 cd0000        	call	_GPIO_Init
1762  0619 85            	popw	x
1763                     ; 305 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1765  061a 4bc0          	push	#192
1766  061c 4b20          	push	#32
1767  061e ae500a        	ldw	x,#20490
1768  0621 cd0000        	call	_GPIO_Init
1770  0624 85            	popw	x
1772  0625 20d8          	jra	L705
1773  0627               L315:
1774                     ; 306 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1776  0627 4b40          	push	#64
1777  0629 ae500f        	ldw	x,#20495
1778  062c cd0000        	call	_GPIO_ReadInputPin
1780  062f 5b01          	addw	sp,#1
1781  0631 4d            	tnz	a
1782  0632 26cb          	jrne	L705
1783                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1785  0634 4bd0          	push	#208
1786  0636 4b10          	push	#16
1787  0638 ae500a        	ldw	x,#20490
1788  063b cd0000        	call	_GPIO_Init
1790  063e 85            	popw	x
1791                     ; 308 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1793  063f 4bc0          	push	#192
1794  0641 4b40          	push	#64
1795  0643 ae500a        	ldw	x,#20490
1796  0646 cd0000        	call	_GPIO_Init
1798  0649 85            	popw	x
1799  064a 20b3          	jra	L705
1800  064c               L37:
1801                     ; 314 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1803  064c c650c6        	ld	a,20678
1804  064f a4e7          	and	a,#231
1805  0651 c750c6        	ld	20678,a
1806                     ; 316 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1808  0654 4bf0          	push	#240
1809  0656 4b20          	push	#32
1810  0658 ae500f        	ldw	x,#20495
1811  065b cd0000        	call	_GPIO_Init
1813  065e 85            	popw	x
1814                     ; 317 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1816  065f 4b40          	push	#64
1817  0661 4b40          	push	#64
1818  0663 ae500f        	ldw	x,#20495
1819  0666 cd0000        	call	_GPIO_Init
1821  0669 85            	popw	x
1822                     ; 318 			UART1_DeInit();
1824  066a cd0000        	call	_UART1_DeInit
1826                     ; 319 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1828  066d 4b0c          	push	#12
1829  066f 4b80          	push	#128
1830  0671 4b00          	push	#0
1831  0673 4b00          	push	#0
1832  0675 4b00          	push	#0
1833  0677 ae4240        	ldw	x,#16960
1834  067a 89            	pushw	x
1835  067b ae000f        	ldw	x,#15
1836  067e 89            	pushw	x
1837  067f cd0000        	call	_UART1_Init
1839  0682 5b09          	addw	sp,#9
1840                     ; 321 			UART1_Cmd(ENABLE);
1842  0684 a601          	ld	a,#1
1843  0686 cd0000        	call	_UART1_Cmd
1845                     ; 323 			Serial_print_string("Mode: ");
1847  0689 ae0119        	ldw	x,#L125
1848  068c cd0a73        	call	_Serial_print_string
1850                     ; 324 			Serial_print_int(test_mode);
1852  068f 1e33          	ldw	x,(OFST-5,sp)
1853  0691 cd0a9c        	call	_Serial_print_int
1855                     ; 325 			Serial_newline();
1857  0694 cd0aff        	call	_Serial_newline
1859                     ; 328 			Serial_print_string("Params v2: ");
1861  0697 ae010d        	ldw	x,#L325
1862  069a cd0a73        	call	_Serial_print_string
1864                     ; 335 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1866  069d c650c6        	ld	a,20678
1867  06a0 5f            	clrw	x
1868  06a1 97            	ld	xl,a
1869  06a2 cd0a9c        	call	_Serial_print_int
1871                     ; 336 			Serial_print_string(" ");
1873  06a5 ae0120        	ldw	x,#L105
1874  06a8 cd0a73        	call	_Serial_print_string
1876                     ; 337 			Serial_print_int(CLK->CCOR);//0
1878  06ab c650c9        	ld	a,20681
1879  06ae 5f            	clrw	x
1880  06af 97            	ld	xl,a
1881  06b0 cd0a9c        	call	_Serial_print_int
1883                     ; 338 			Serial_newline();
1885  06b3 cd0aff        	call	_Serial_newline
1887                     ; 340 			TIM4->PSCR= 7;// init divider register /128	
1889  06b6 35075347      	mov	21319,#7
1890                     ; 341 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1892  06ba 357d5348      	mov	21320,#125
1893                     ; 342 			TIM4->EGR= TIM4_EGR_UG;// update registers
1895  06be 35015345      	mov	21317,#1
1896                     ; 343 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1898  06c2 c65340        	ld	a,21312
1899  06c5 aa85          	or	a,#133
1900  06c7 c75340        	ld	21312,a
1901                     ; 344 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1903  06ca 35015343      	mov	21315,#1
1904                     ; 345 			enableInterrupts();
1907  06ce 9a            rim
1909  06cf               L525:
1910                     ; 348 				if(tms%1000==0 && mean_sum!=tms/1000)
1912  06cf ae0000        	ldw	x,#_tms
1913  06d2 cd0000        	call	c_ltor
1915  06d5 ae0018        	ldw	x,#L42
1916  06d8 cd0000        	call	c_lumd
1918  06db cd0000        	call	c_lrzmp
1920  06de 2642          	jrne	L135
1922  06e0 ae0000        	ldw	x,#_tms
1923  06e3 cd0000        	call	c_ltor
1925  06e6 ae0018        	ldw	x,#L42
1926  06e9 cd0000        	call	c_ludv
1928  06ec 96            	ldw	x,sp
1929  06ed 1c0027        	addw	x,#OFST-17
1930  06f0 cd0000        	call	c_lcmp
1932  06f3 272d          	jreq	L135
1933                     ; 350 					Serial_print_string("time: ");
1935  06f5 ae0106        	ldw	x,#L335
1936  06f8 cd0a73        	call	_Serial_print_string
1938                     ; 351 					mean_sum=tms/1000;
1940  06fb ae0000        	ldw	x,#_tms
1941  06fe cd0000        	call	c_ltor
1943  0701 ae0018        	ldw	x,#L42
1944  0704 cd0000        	call	c_ludv
1946  0707 96            	ldw	x,sp
1947  0708 1c0027        	addw	x,#OFST-17
1948  070b cd0000        	call	c_rtol
1951                     ; 352 					Serial_print_int(tms/1000);
1953  070e ae0000        	ldw	x,#_tms
1954  0711 cd0000        	call	c_ltor
1956  0714 ae0018        	ldw	x,#L42
1957  0717 cd0000        	call	c_ludv
1959  071a be02          	ldw	x,c_lreg+2
1960  071c cd0a9c        	call	_Serial_print_int
1962                     ; 353 					Serial_newline();
1964  071f cd0aff        	call	_Serial_newline
1966  0722               L135:
1967                     ; 361 				setMatrixHighZ();
1969  0722 cd0b0e        	call	_setMatrixHighZ
1971                     ; 362 				mean_low=tms%20;
1973  0725 ae0000        	ldw	x,#_tms
1974  0728 cd0000        	call	c_ltor
1976  072b ae0020        	ldw	x,#L25
1977  072e cd0000        	call	c_lumd
1979  0731 96            	ldw	x,sp
1980  0732 1c001f        	addw	x,#OFST-25
1981  0735 cd0000        	call	c_rtol
1984                     ; 363 				mean_high=(tms/20)%100;
1986  0738 ae0000        	ldw	x,#_tms
1987  073b cd0000        	call	c_ltor
1989  073e ae0020        	ldw	x,#L25
1990  0741 cd0000        	call	c_ludv
1992  0744 ae0024        	ldw	x,#L45
1993  0747 cd0000        	call	c_lumd
1995  074a 96            	ldw	x,sp
1996  074b 1c002d        	addw	x,#OFST-11
1997  074e cd0000        	call	c_rtol
2000                     ; 364 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
2002  0751 ae0000        	ldw	x,#_tms
2003  0754 cd0000        	call	c_ltor
2005  0757 ae0028        	ldw	x,#L65
2006  075a cd0000        	call	c_ludv
2008  075d b603          	ld	a,c_lreg+3
2009  075f a401          	and	a,#1
2010  0761 b703          	ld	c_lreg+3,a
2011  0763 3f02          	clr	c_lreg+2
2012  0765 3f01          	clr	c_lreg+1
2013  0767 3f00          	clr	c_lreg
2014  0769 96            	ldw	x,sp
2015  076a 1c0001        	addw	x,#OFST-55
2016  076d cd0000        	call	c_rtol
2019  0770 96            	ldw	x,sp
2020  0771 1c002d        	addw	x,#OFST-11
2021  0774 cd0000        	call	c_ltor
2023  0777 a602          	ld	a,#2
2024  0779 cd0000        	call	c_lursh
2026  077c 96            	ldw	x,sp
2027  077d 1c001f        	addw	x,#OFST-25
2028  0780 cd0000        	call	c_lcmp
2030  0783 2405          	jruge	L06
2031  0785 ae0001        	ldw	x,#1
2032  0788 2001          	jra	L26
2033  078a               L06:
2034  078a 5f            	clrw	x
2035  078b               L26:
2036  078b cd0000        	call	c_itolx
2038  078e 96            	ldw	x,sp
2039  078f 1c0001        	addw	x,#OFST-55
2040  0792 cd0000        	call	c_lxor
2042  0795 cd0000        	call	c_lrzmp
2044  0798 270f          	jreq	L535
2045                     ; 366 					setRGB(4,1);
2047  079a ae0001        	ldw	x,#1
2048  079d 89            	pushw	x
2049  079e ae0004        	ldw	x,#4
2050  07a1 cd0b25        	call	_setRGB
2052  07a4 85            	popw	x
2054  07a5 accf06cf      	jpf	L525
2055  07a9               L535:
2056                     ; 369 					setRGB(4,0);
2058  07a9 5f            	clrw	x
2059  07aa 89            	pushw	x
2060  07ab ae0004        	ldw	x,#4
2061  07ae cd0b25        	call	_setRGB
2063  07b1 85            	popw	x
2064  07b2 accf06cf      	jpf	L525
2065  07b6               L57:
2066                     ; 375 			Serial_print_string("Mode: ");
2068  07b6 ae0119        	ldw	x,#L125
2069  07b9 cd0a73        	call	_Serial_print_string
2071                     ; 376 			Serial_print_int(test_mode);
2073  07bc 1e33          	ldw	x,(OFST-5,sp)
2074  07be cd0a9c        	call	_Serial_print_int
2076                     ; 377 			Serial_newline();
2078  07c1 cd0aff        	call	_Serial_newline
2080                     ; 381 			Serial_print_string("Params: ");
2082  07c4 ae00fd        	ldw	x,#L145
2083  07c7 cd0a73        	call	_Serial_print_string
2085                     ; 382 			Serial_print_int(CLK->CKDIVR);//
2087  07ca c650c6        	ld	a,20678
2088  07cd 5f            	clrw	x
2089  07ce 97            	ld	xl,a
2090  07cf cd0a9c        	call	_Serial_print_int
2092                     ; 383 			Serial_print_string(" ");
2094  07d2 ae0120        	ldw	x,#L105
2095  07d5 cd0a73        	call	_Serial_print_string
2097                     ; 384 			Serial_print_int(CLK->CCOR);//
2099  07d8 c650c9        	ld	a,20681
2100  07db 5f            	clrw	x
2101  07dc 97            	ld	xl,a
2102  07dd cd0a9c        	call	_Serial_print_int
2104                     ; 385 			Serial_newline();
2106  07e0 cd0aff        	call	_Serial_newline
2108                     ; 387 			TIM4->PSCR= 7;// init divider register /128	
2110  07e3 35075347      	mov	21319,#7
2111                     ; 388 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2113  07e7 35805348      	mov	21320,#128
2114                     ; 389 			TIM4->EGR= TIM4_EGR_UG;// update registers
2116  07eb 35015345      	mov	21317,#1
2117                     ; 390 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2119  07ef c65340        	ld	a,21312
2120  07f2 aa85          	or	a,#133
2121  07f4 c75340        	ld	21312,a
2122                     ; 391 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2124  07f7 35015343      	mov	21315,#1
2125                     ; 392 			enableInterrupts();
2128  07fb 9a            rim
2130  07fc               L345:
2131                     ; 395 				for(iter=0;iter<5000;iter++){}
2133  07fc ae0000        	ldw	x,#0
2134  07ff 1f37          	ldw	(OFST-1,sp),x
2135  0801 ae0000        	ldw	x,#0
2136  0804 1f35          	ldw	(OFST-3,sp),x
2138  0806               L745:
2141  0806 96            	ldw	x,sp
2142  0807 1c0035        	addw	x,#OFST-3
2143  080a a601          	ld	a,#1
2144  080c cd0000        	call	c_lgadc
2149  080f 96            	ldw	x,sp
2150  0810 1c0035        	addw	x,#OFST-3
2151  0813 cd0000        	call	c_ltor
2153  0816 ae002c        	ldw	x,#L46
2154  0819 cd0000        	call	c_lcmp
2156  081c 25e8          	jrult	L745
2157                     ; 396 				Serial_print_string("time: ");
2159  081e ae0106        	ldw	x,#L335
2160  0821 cd0a73        	call	_Serial_print_string
2162                     ; 397 				Serial_print_int(tms>>16);
2164  0824 be00          	ldw	x,_tms
2165  0826 cd0a9c        	call	_Serial_print_int
2167                     ; 398 				Serial_print_string(" ");
2169  0829 ae0120        	ldw	x,#L105
2170  082c cd0a73        	call	_Serial_print_string
2172                     ; 399 				Serial_print_int((uint16_t)tms);
2174  082f be02          	ldw	x,_tms+2
2175  0831 cd0a9c        	call	_Serial_print_int
2177                     ; 400 				Serial_newline();
2179  0834 cd0aff        	call	_Serial_newline
2182  0837 20c3          	jra	L345
2183  0839               L77:
2184                     ; 405 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2186  0839 c650c6        	ld	a,20678
2187  083c a4e7          	and	a,#231
2188  083e c750c6        	ld	20678,a
2189                     ; 407 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2191  0841 4bf0          	push	#240
2192  0843 4b20          	push	#32
2193  0845 ae500f        	ldw	x,#20495
2194  0848 cd0000        	call	_GPIO_Init
2196  084b 85            	popw	x
2197                     ; 408 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2199  084c 4b40          	push	#64
2200  084e 4b40          	push	#64
2201  0850 ae500f        	ldw	x,#20495
2202  0853 cd0000        	call	_GPIO_Init
2204  0856 85            	popw	x
2205                     ; 409 			UART1_DeInit();
2207  0857 cd0000        	call	_UART1_DeInit
2209                     ; 410 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2211  085a 4b0c          	push	#12
2212  085c 4b80          	push	#128
2213  085e 4b00          	push	#0
2214  0860 4b00          	push	#0
2215  0862 4b00          	push	#0
2216  0864 ae4240        	ldw	x,#16960
2217  0867 89            	pushw	x
2218  0868 ae000f        	ldw	x,#15
2219  086b 89            	pushw	x
2220  086c cd0000        	call	_UART1_Init
2222  086f 5b09          	addw	sp,#9
2223                     ; 412 			UART1_Cmd(ENABLE);
2225  0871 a601          	ld	a,#1
2226  0873 cd0000        	call	_UART1_Cmd
2228                     ; 414 			Serial_print_string("Mode: ");
2230  0876 ae0119        	ldw	x,#L125
2231  0879 cd0a73        	call	_Serial_print_string
2233                     ; 415 			Serial_print_int(test_mode);
2235  087c 1e33          	ldw	x,(OFST-5,sp)
2236  087e cd0a9c        	call	_Serial_print_int
2238                     ; 416 			Serial_newline();
2240  0881 cd0aff        	call	_Serial_newline
2242                     ; 418 			TIM4->PSCR= 7;// init divider register /128	
2244  0884 35075347      	mov	21319,#7
2245                     ; 419 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2247  0888 357d5348      	mov	21320,#125
2248                     ; 420 			TIM4->EGR= TIM4_EGR_UG;// update registers
2250  088c 35015345      	mov	21317,#1
2251                     ; 421 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2253  0890 c65340        	ld	a,21312
2254  0893 aa85          	or	a,#133
2255  0895 c75340        	ld	21312,a
2256                     ; 422 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2258  0898 35015343      	mov	21315,#1
2259                     ; 423 			enableInterrupts();
2262  089c 9a            rim
2264  089d               L555:
2265                     ; 429 					setMatrixHighZ();
2267  089d cd0b0e        	call	_setMatrixHighZ
2269                     ; 430 					mean_sum=tms/60;
2271  08a0 ae0000        	ldw	x,#_tms
2272  08a3 cd0000        	call	c_ltor
2274  08a6 ae0030        	ldw	x,#L66
2275  08a9 cd0000        	call	c_ludv
2277  08ac 96            	ldw	x,sp
2278  08ad 1c0027        	addw	x,#OFST-17
2279  08b0 cd0000        	call	c_rtol
2282                     ; 431 					mean_low=tms%2;//is high or low charlieplexing
2284  08b3 b603          	ld	a,_tms+3
2285  08b5 a401          	and	a,#1
2286  08b7 6b22          	ld	(OFST-22,sp),a
2287  08b9 4f            	clr	a
2288  08ba 6b21          	ld	(OFST-23,sp),a
2289  08bc 6b20          	ld	(OFST-24,sp),a
2290  08be 6b1f          	ld	(OFST-25,sp),a
2292                     ; 432 					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
2294  08c0 96            	ldw	x,sp
2295  08c1 1c0027        	addw	x,#OFST-17
2296  08c4 cd0000        	call	c_ltor
2298  08c7 3400          	srl	c_lreg
2299  08c9 3601          	rrc	c_lreg+1
2300  08cb 3602          	rrc	c_lreg+2
2301  08cd 3603          	rrc	c_lreg+3
2302  08cf ae0034        	ldw	x,#L07
2303  08d2 cd0000        	call	c_lumd
2305  08d5 96            	ldw	x,sp
2306  08d6 1c002d        	addw	x,#OFST-11
2307  08d9 cd0000        	call	c_rtol
2310                     ; 433 					sound_level=(mean_sum/10)%3;//RGB
2312  08dc 96            	ldw	x,sp
2313  08dd 1c0027        	addw	x,#OFST-17
2314  08e0 cd0000        	call	c_ltor
2316  08e3 ae001c        	ldw	x,#L04
2317  08e6 cd0000        	call	c_ludv
2319  08e9 ae0038        	ldw	x,#L27
2320  08ec cd0000        	call	c_lumd
2322  08ef be02          	ldw	x,c_lreg+2
2323  08f1 1f31          	ldw	(OFST-7,sp),x
2325                     ; 434 					setRGB(mean_high+(mean_low?5:0),sound_level);
2327  08f3 1e31          	ldw	x,(OFST-7,sp)
2328  08f5 89            	pushw	x
2329  08f6 96            	ldw	x,sp
2330  08f7 1c0021        	addw	x,#OFST-23
2331  08fa cd0000        	call	c_lzmp
2333  08fd 2705          	jreq	L47
2334  08ff ae0005        	ldw	x,#5
2335  0902 2001          	jra	L67
2336  0904               L47:
2337  0904 5f            	clrw	x
2338  0905               L67:
2339  0905 cd0000        	call	c_itolx
2341  0908 96            	ldw	x,sp
2342  0909 1c002f        	addw	x,#OFST-9
2343  090c cd0000        	call	c_ladd
2345  090f be02          	ldw	x,c_lreg+2
2346  0911 cd0b25        	call	_setRGB
2348  0914 85            	popw	x
2350  0915 2086          	jpf	L555
2351  0917               L101:
2352                     ; 440 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2354  0917 c650c6        	ld	a,20678
2355  091a a4e7          	and	a,#231
2356  091c c750c6        	ld	20678,a
2357                     ; 442 			TIM4->PSCR= 7;// init divider register /128	
2359  091f 35075347      	mov	21319,#7
2360                     ; 443 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2362  0923 357d5348      	mov	21320,#125
2363                     ; 444 			TIM4->EGR= TIM4_EGR_UG;// update registers
2365  0927 35015345      	mov	21317,#1
2366                     ; 445 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2368  092b c65340        	ld	a,21312
2369  092e aa85          	or	a,#133
2370  0930 c75340        	ld	21312,a
2371                     ; 446 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2373  0933 35015343      	mov	21315,#1
2374                     ; 447 			enableInterrupts();
2377  0937 9a            rim
2379  0938               L165:
2380                     ; 450 				if(tms%8000==0 && mean_sum!=tms/8000)
2382  0938 ae0000        	ldw	x,#_tms
2383  093b cd0000        	call	c_ltor
2385  093e ae003c        	ldw	x,#L001
2386  0941 cd0000        	call	c_lumd
2388  0944 cd0000        	call	c_lrzmp
2390  0947 26ef          	jrne	L165
2392  0949 ae0000        	ldw	x,#_tms
2393  094c cd0000        	call	c_ltor
2395  094f ae003c        	ldw	x,#L001
2396  0952 cd0000        	call	c_ludv
2398  0955 96            	ldw	x,sp
2399  0956 1c0027        	addw	x,#OFST-17
2400  0959 cd0000        	call	c_lcmp
2402  095c 27da          	jreq	L165
2403                     ; 452 				  setMatrixHighZ();
2405  095e cd0b0e        	call	_setMatrixHighZ
2407                     ; 453 					mean_sum=tms/8000;
2409  0961 ae0000        	ldw	x,#_tms
2410  0964 cd0000        	call	c_ltor
2412  0967 ae003c        	ldw	x,#L001
2413  096a cd0000        	call	c_ludv
2415  096d 96            	ldw	x,sp
2416  096e 1c0027        	addw	x,#OFST-17
2417  0971 cd0000        	call	c_rtol
2420                     ; 454 					if(mean_sum%4==3)
2422  0974 7b2a          	ld	a,(OFST-14,sp)
2423  0976 a403          	and	a,#3
2424  0978 a103          	cp	a,#3
2425  097a 2608          	jrne	L765
2426                     ; 456 						setWhite(11);
2428  097c ae000b        	ldw	x,#11
2429  097f cd0b34        	call	_setWhite
2432  0982 20b4          	jra	L165
2433  0984               L765:
2434                     ; 458 						setRGB(4,mean_sum%4);
2436  0984 7b2a          	ld	a,(OFST-14,sp)
2437  0986 5f            	clrw	x
2438  0987 a403          	and	a,#3
2439  0989 5f            	clrw	x
2440  098a 02            	rlwa	x,a
2441  098b 89            	pushw	x
2442  098c 01            	rrwa	x,a
2443  098d ae0004        	ldw	x,#4
2444  0990 cd0b25        	call	_setRGB
2446  0993 85            	popw	x
2447  0994 20a2          	jra	L165
2448  0996               L301:
2449                     ; 465 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2451  0996 c650c6        	ld	a,20678
2452  0999 a4e7          	and	a,#231
2453  099b c750c6        	ld	20678,a
2454                     ; 467 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2456  099e 4bf0          	push	#240
2457  09a0 4b20          	push	#32
2458  09a2 ae500f        	ldw	x,#20495
2459  09a5 cd0000        	call	_GPIO_Init
2461  09a8 85            	popw	x
2462                     ; 468 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2464  09a9 4b40          	push	#64
2465  09ab 4b40          	push	#64
2466  09ad ae500f        	ldw	x,#20495
2467  09b0 cd0000        	call	_GPIO_Init
2469  09b3 85            	popw	x
2470                     ; 469 			UART1_DeInit();
2472  09b4 cd0000        	call	_UART1_DeInit
2474                     ; 470 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2476  09b7 4b0c          	push	#12
2477  09b9 4b80          	push	#128
2478  09bb 4b00          	push	#0
2479  09bd 4b00          	push	#0
2480  09bf 4b00          	push	#0
2481  09c1 ae4240        	ldw	x,#16960
2482  09c4 89            	pushw	x
2483  09c5 ae000f        	ldw	x,#15
2484  09c8 89            	pushw	x
2485  09c9 cd0000        	call	_UART1_Init
2487  09cc 5b09          	addw	sp,#9
2488                     ; 472 			UART1_Cmd(ENABLE);
2490  09ce a601          	ld	a,#1
2491  09d0 cd0000        	call	_UART1_Cmd
2493                     ; 474 			Serial_print_string("Mode: ");
2495  09d3 ae0119        	ldw	x,#L125
2496  09d6 cd0a73        	call	_Serial_print_string
2498                     ; 475 			Serial_print_int(test_mode);
2500  09d9 1e33          	ldw	x,(OFST-5,sp)
2501  09db cd0a9c        	call	_Serial_print_int
2503                     ; 476 			Serial_newline();
2505  09de cd0aff        	call	_Serial_newline
2507                     ; 478 			TIM2->PSCR= 6;// init divider register 16MHz/2^X
2509  09e1 3506530e      	mov	21262,#6
2510                     ; 479 			TIM2->ARRH= 0;// init auto reload register
2512  09e5 725f530f      	clr	21263
2513                     ; 480 			TIM2->ARRL= 250;// init auto reload register
2515  09e9 35fa5310      	mov	21264,#250
2516                     ; 482 			TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
2518  09ed c65300        	ld	a,21248
2519  09f0 aa85          	or	a,#133
2520  09f2 c75300        	ld	21248,a
2521                     ; 483 			TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
2523  09f5 35035303      	mov	21251,#3
2524                     ; 484 			enableInterrupts();
2527  09f9 9a            rim
2529  09fa               L375:
2530                     ; 487 				Serial_print_string("tms2: ");
2532  09fa ae00f6        	ldw	x,#L775
2533  09fd ad74          	call	_Serial_print_string
2535                     ; 488 				Serial_print_int(tms2/1000);
2537  09ff ae0004        	ldw	x,#_tms2
2538  0a02 cd0000        	call	c_ltor
2540  0a05 ae0018        	ldw	x,#L42
2541  0a08 cd0000        	call	c_ludv
2543  0a0b be02          	ldw	x,c_lreg+2
2544  0a0d cd0a9c        	call	_Serial_print_int
2546                     ; 489 				Serial_print_string(", tms3: ");
2548  0a10 ae00ed        	ldw	x,#L106
2549  0a13 ad5e          	call	_Serial_print_string
2551                     ; 490 				Serial_print_int(tms3/1000);
2553  0a15 ae0008        	ldw	x,#_tms3
2554  0a18 cd0000        	call	c_ltor
2556  0a1b ae0018        	ldw	x,#L42
2557  0a1e cd0000        	call	c_ludv
2559  0a21 be02          	ldw	x,c_lreg+2
2560  0a23 ad77          	call	_Serial_print_int
2562                     ; 491 				Serial_newline();
2564  0a25 cd0aff        	call	_Serial_newline
2566                     ; 492 				for(iter=0;iter<30000;iter++){}
2568  0a28 ae0000        	ldw	x,#0
2569  0a2b 1f37          	ldw	(OFST-1,sp),x
2570  0a2d ae0000        	ldw	x,#0
2571  0a30 1f35          	ldw	(OFST-3,sp),x
2573  0a32               L306:
2576  0a32 96            	ldw	x,sp
2577  0a33 1c0035        	addw	x,#OFST-3
2578  0a36 a601          	ld	a,#1
2579  0a38 cd0000        	call	c_lgadc
2584  0a3b 96            	ldw	x,sp
2585  0a3c 1c0035        	addw	x,#OFST-3
2586  0a3f cd0000        	call	c_ltor
2588  0a42 ae0014        	ldw	x,#L21
2589  0a45 cd0000        	call	c_lcmp
2591  0a48 25e8          	jrult	L306
2593  0a4a 20ae          	jra	L375
2618                     ; 499 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2620                     	switch	.text
2621  0a4c               f_TIM4_UPD_OVF_IRQHandler:
2625                     ; 500 	TIM4->SR1&=~TIM4_SR1_UIF;
2627  0a4c 72115344      	bres	21316,#0
2628                     ; 501 	tms++;
2630  0a50 ae0000        	ldw	x,#_tms
2631  0a53 a601          	ld	a,#1
2632  0a55 cd0000        	call	c_lgadc
2634                     ; 502 }
2637  0a58 80            	iret
2661                     ; 504 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
2662                     	switch	.text
2663  0a59               f_TIM2_UPD_OVF_IRQHandler:
2667                     ; 505 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
2669  0a59 72115304      	bres	21252,#0
2670                     ; 506 	tms2+=2;
2672  0a5d ae0004        	ldw	x,#_tms2
2673  0a60 a602          	ld	a,#2
2674  0a62 cd0000        	call	c_lgadc
2676                     ; 507 }
2679  0a65 80            	iret
2703                     ; 509 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
2704                     	switch	.text
2705  0a66               f_TIM2_CapComp_IRQ_Handler:
2709                     ; 510 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
2711  0a66 72135304      	bres	21252,#1
2712                     ; 511 	tms3+=3;
2714  0a6a ae0008        	ldw	x,#_tms3
2715  0a6d a603          	ld	a,#3
2716  0a6f cd0000        	call	c_lgadc
2718                     ; 512 }
2721  0a72 80            	iret
2767                     ; 535  void Serial_print_string (char string[])
2767                     ; 536  {
2769                     	switch	.text
2770  0a73               _Serial_print_string:
2772  0a73 89            	pushw	x
2773  0a74 88            	push	a
2774       00000001      OFST:	set	1
2777                     ; 538 	 char i=0;
2779  0a75 0f01          	clr	(OFST+0,sp)
2782  0a77 2016          	jra	L766
2783  0a79               L366:
2784                     ; 542 		UART1_SendData8(string[i]);
2786  0a79 7b01          	ld	a,(OFST+0,sp)
2787  0a7b 5f            	clrw	x
2788  0a7c 97            	ld	xl,a
2789  0a7d 72fb02        	addw	x,(OFST+1,sp)
2790  0a80 f6            	ld	a,(x)
2791  0a81 cd0000        	call	_UART1_SendData8
2794  0a84               L576:
2795                     ; 543 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2797  0a84 ae0080        	ldw	x,#128
2798  0a87 cd0000        	call	_UART1_GetFlagStatus
2800  0a8a 4d            	tnz	a
2801  0a8b 27f7          	jreq	L576
2802                     ; 544 		i++;
2804  0a8d 0c01          	inc	(OFST+0,sp)
2806  0a8f               L766:
2807                     ; 540 	 while (string[i] != 0x00)
2809  0a8f 7b01          	ld	a,(OFST+0,sp)
2810  0a91 5f            	clrw	x
2811  0a92 97            	ld	xl,a
2812  0a93 72fb02        	addw	x,(OFST+1,sp)
2813  0a96 7d            	tnz	(x)
2814  0a97 26e0          	jrne	L366
2815                     ; 546  }
2818  0a99 5b03          	addw	sp,#3
2819  0a9b 81            	ret
2822                     	switch	.const
2823  0040               L107_digit:
2824  0040 00            	dc.b	0
2825  0041 00000000      	ds.b	4
2878                     ; 548  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2878                     ; 549  {
2879                     	switch	.text
2880  0a9c               _Serial_print_int:
2882  0a9c 89            	pushw	x
2883  0a9d 5208          	subw	sp,#8
2884       00000008      OFST:	set	8
2887                     ; 550 	 char count = 0;
2889  0a9f 0f08          	clr	(OFST+0,sp)
2891                     ; 551 	 char digit[5] = "";
2893  0aa1 96            	ldw	x,sp
2894  0aa2 1c0003        	addw	x,#OFST-5
2895  0aa5 90ae0040      	ldw	y,#L107_digit
2896  0aa9 a605          	ld	a,#5
2897  0aab cd0000        	call	c_xymov
2900  0aae 2023          	jra	L537
2901  0ab0               L137:
2902                     ; 555 		 digit[count] = number%10;
2904  0ab0 96            	ldw	x,sp
2905  0ab1 1c0003        	addw	x,#OFST-5
2906  0ab4 9f            	ld	a,xl
2907  0ab5 5e            	swapw	x
2908  0ab6 1b08          	add	a,(OFST+0,sp)
2909  0ab8 2401          	jrnc	L041
2910  0aba 5c            	incw	x
2911  0abb               L041:
2912  0abb 02            	rlwa	x,a
2913  0abc 1609          	ldw	y,(OFST+1,sp)
2914  0abe a60a          	ld	a,#10
2915  0ac0 cd0000        	call	c_smody
2917  0ac3 9001          	rrwa	y,a
2918  0ac5 f7            	ld	(x),a
2919  0ac6 9002          	rlwa	y,a
2920                     ; 556 		 count++;
2922  0ac8 0c08          	inc	(OFST+0,sp)
2924                     ; 557 		 number = number/10;
2926  0aca 1e09          	ldw	x,(OFST+1,sp)
2927  0acc a60a          	ld	a,#10
2928  0ace cd0000        	call	c_sdivx
2930  0ad1 1f09          	ldw	(OFST+1,sp),x
2931  0ad3               L537:
2932                     ; 553 	 while (number != 0) //split the int to char array 
2934  0ad3 1e09          	ldw	x,(OFST+1,sp)
2935  0ad5 26d9          	jrne	L137
2937  0ad7 201f          	jra	L347
2938  0ad9               L147:
2939                     ; 562 		UART1_SendData8(digit[count-1] + 0x30);
2941  0ad9 96            	ldw	x,sp
2942  0ada 1c0003        	addw	x,#OFST-5
2943  0add 1f01          	ldw	(OFST-7,sp),x
2945  0adf 7b08          	ld	a,(OFST+0,sp)
2946  0ae1 5f            	clrw	x
2947  0ae2 97            	ld	xl,a
2948  0ae3 5a            	decw	x
2949  0ae4 72fb01        	addw	x,(OFST-7,sp)
2950  0ae7 f6            	ld	a,(x)
2951  0ae8 ab30          	add	a,#48
2952  0aea cd0000        	call	_UART1_SendData8
2955  0aed               L157:
2956                     ; 563 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2958  0aed ae0080        	ldw	x,#128
2959  0af0 cd0000        	call	_UART1_GetFlagStatus
2961  0af3 4d            	tnz	a
2962  0af4 27f7          	jreq	L157
2963                     ; 564 		count--; 
2965  0af6 0a08          	dec	(OFST+0,sp)
2967  0af8               L347:
2968                     ; 560 	 while (count !=0) //print char array in correct direction 
2970  0af8 0d08          	tnz	(OFST+0,sp)
2971  0afa 26dd          	jrne	L147
2972                     ; 566  }
2975  0afc 5b0a          	addw	sp,#10
2976  0afe 81            	ret
3001                     ; 568  void Serial_newline(void)
3001                     ; 569  {
3002                     	switch	.text
3003  0aff               _Serial_newline:
3007                     ; 570 	 UART1_SendData8(0x0a);
3009  0aff a60a          	ld	a,#10
3010  0b01 cd0000        	call	_UART1_SendData8
3013  0b04               L767:
3014                     ; 571 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
3016  0b04 ae0080        	ldw	x,#128
3017  0b07 cd0000        	call	_UART1_GetFlagStatus
3019  0b0a 4d            	tnz	a
3020  0b0b 27f7          	jreq	L767
3021                     ; 572  }
3024  0b0d 81            	ret
3048                     ; 574 void setMatrixHighZ()
3048                     ; 575 {
3049                     	switch	.text
3050  0b0e               _setMatrixHighZ:
3054                     ; 580 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
3056  0b0e 4b00          	push	#0
3057  0b10 4bf8          	push	#248
3058  0b12 ae500a        	ldw	x,#20490
3059  0b15 cd0000        	call	_GPIO_Init
3061  0b18 85            	popw	x
3062                     ; 581 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
3064  0b19 4b00          	push	#0
3065  0b1b 4b0c          	push	#12
3066  0b1d ae500f        	ldw	x,#20495
3067  0b20 cd0000        	call	_GPIO_Init
3069  0b23 85            	popw	x
3070                     ; 582 }
3073  0b24 81            	ret
3117                     ; 584 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
3118                     	switch	.text
3119  0b25               _setRGB:
3121  0b25 89            	pushw	x
3122       00000000      OFST:	set	0
3127  0b26 1e05          	ldw	x,(OFST+5,sp)
3128  0b28 89            	pushw	x
3129  0b29 1e03          	ldw	x,(OFST+3,sp)
3130  0b2b 89            	pushw	x
3131  0b2c a601          	ld	a,#1
3132  0b2e ad11          	call	_setLED
3134  0b30 5b04          	addw	sp,#4
3138  0b32 85            	popw	x
3139  0b33 81            	ret
3174                     ; 585 void setWhite(int led_index){ setLED(0,led_index,0); }
3175                     	switch	.text
3176  0b34               _setWhite:
3178  0b34 89            	pushw	x
3179       00000000      OFST:	set	0
3184  0b35 5f            	clrw	x
3185  0b36 89            	pushw	x
3186  0b37 1e03          	ldw	x,(OFST+3,sp)
3187  0b39 89            	pushw	x
3188  0b3a 4f            	clr	a
3189  0b3b ad04          	call	_setLED
3191  0b3d 5b04          	addw	sp,#4
3195  0b3f 85            	popw	x
3196  0b40 81            	ret
3199                     	switch	.const
3200  0045               L3401_rgb_lookup:
3201  0045 0000          	dc.w	0
3202  0047 0001          	dc.w	1
3203  0049 0000          	dc.w	0
3204  004b 0002          	dc.w	2
3205  004d 0001          	dc.w	1
3206  004f 0002          	dc.w	2
3207  0051 0001          	dc.w	1
3208  0053 0000          	dc.w	0
3209  0055 0002          	dc.w	2
3210  0057 0000          	dc.w	0
3211  0059 0002          	dc.w	2
3212  005b 0001          	dc.w	1
3213  005d 0005          	dc.w	5
3214  005f 0000          	dc.w	0
3215  0061 0005          	dc.w	5
3216  0063 0001          	dc.w	1
3217  0065 0005          	dc.w	5
3218  0067 0002          	dc.w	2
3219  0069 0006          	dc.w	6
3220  006b 0000          	dc.w	0
3221  006d 0006          	dc.w	6
3222  006f 0001          	dc.w	1
3223  0071 0006          	dc.w	6
3224  0073 0002          	dc.w	2
3225  0075 0006          	dc.w	6
3226  0077 0005          	dc.w	5
3227  0079 0006          	dc.w	6
3228  007b 0004          	dc.w	4
3229  007d 0005          	dc.w	5
3230  007f 0004          	dc.w	4
3231  0081 0004          	dc.w	4
3232  0083 0003          	dc.w	3
3233  0085 0005          	dc.w	5
3234  0087 0003          	dc.w	3
3235  0089 0006          	dc.w	6
3236  008b 0003          	dc.w	3
3237  008d 0003          	dc.w	3
3238  008f 0004          	dc.w	4
3239  0091 0003          	dc.w	3
3240  0093 0005          	dc.w	5
3241  0095 0003          	dc.w	3
3242  0097 0006          	dc.w	6
3243  0099 0000          	dc.w	0
3244  009b 0005          	dc.w	5
3245  009d 0000          	dc.w	0
3246  009f 0006          	dc.w	6
3247  00a1 0001          	dc.w	1
3248  00a3 0006          	dc.w	6
3249  00a5 0000          	dc.w	0
3250  00a7 0004          	dc.w	4
3251  00a9 0001          	dc.w	1
3252  00ab 0004          	dc.w	4
3253  00ad 0002          	dc.w	2
3254  00af 0004          	dc.w	4
3255  00b1 0000          	dc.w	0
3256  00b3 0003          	dc.w	3
3257  00b5 0001          	dc.w	1
3258  00b7 0003          	dc.w	3
3259  00b9 0002          	dc.w	2
3260  00bb 0003          	dc.w	3
3261  00bd               L5401_white_lookup:
3262  00bd 0003          	dc.w	3
3263  00bf 0000          	dc.w	0
3264  00c1 0003          	dc.w	3
3265  00c3 0001          	dc.w	1
3266  00c5 0003          	dc.w	3
3267  00c7 0002          	dc.w	2
3268  00c9 0004          	dc.w	4
3269  00cb 0000          	dc.w	0
3270  00cd 0001          	dc.w	1
3271  00cf 0005          	dc.w	5
3272  00d1 0002          	dc.w	2
3273  00d3 0005          	dc.w	5
3274  00d5 0004          	dc.w	4
3275  00d7 0001          	dc.w	1
3276  00d9 0004          	dc.w	4
3277  00db 0002          	dc.w	2
3278  00dd 0002          	dc.w	2
3279  00df 0006          	dc.w	6
3280  00e1 0004          	dc.w	4
3281  00e3 0006          	dc.w	6
3282  00e5 0004          	dc.w	4
3283  00e7 0005          	dc.w	5
3284  00e9 0005          	dc.w	5
3285  00eb 0006          	dc.w	6
3547                     ; 587 void setLED(bool is_rgb,int led_index,int rgb_index)
3547                     ; 588 {
3548                     	switch	.text
3549  0b41               _setLED:
3551  0b41 88            	push	a
3552  0b42 52b6          	subw	sp,#182
3553       000000b6      OFST:	set	182
3556                     ; 589   const unsigned short rgb_lookup[10][3][2]={
3556                     ; 590 		{{0,1},{0,2},{1,2}},//7
3556                     ; 591 		{{1,0},{2,0},{2,1}},//3
3556                     ; 592 		{{5,0},{5,1},{5,2}},//1
3556                     ; 593 		{{6,0},{6,1},{6,2}},//20
3556                     ; 594 		{{6,5},{6,4},{5,4}},//22
3556                     ; 595 		{{4,3},{5,3},{6,3}},//23
3556                     ; 596 		{{3,4},{3,5},{3,6}},//21
3556                     ; 597 		{{0,5},{0,6},{1,6}},//19
3556                     ; 598 		{{0,4},{1,4},{2,4}},//18
3556                     ; 599 		{{0,3},{1,3},{2,3}} //2
3556                     ; 600 	};
3558  0b44 96            	ldw	x,sp
3559  0b45 1c000e        	addw	x,#OFST-168
3560  0b48 90ae0045      	ldw	y,#L3401_rgb_lookup
3561  0b4c a678          	ld	a,#120
3562  0b4e cd0000        	call	c_xymov
3564                     ; 601 	const unsigned short white_lookup[12][2]={
3564                     ; 602 		{3,0},//6
3564                     ; 603 		{3,1},//4
3564                     ; 604 		{3,2},//5
3564                     ; 605 		{4,0},//14
3564                     ; 606 		{1,5},//8
3564                     ; 607 		{2,5},//9
3564                     ; 608 		{4,1},//10
3564                     ; 609 		{4,2},//16
3564                     ; 610 		{2,6},//17
3564                     ; 611 		{4,6},//12
3564                     ; 612 		{4,5},//13
3564                     ; 613 		{5,6} //11
3564                     ; 614 	};
3566  0b51 96            	ldw	x,sp
3567  0b52 1c0086        	addw	x,#OFST-48
3568  0b55 90ae00bd      	ldw	y,#L5401_white_lookup
3569  0b59 a630          	ld	a,#48
3570  0b5b cd0000        	call	c_xymov
3572                     ; 615 	bool is_low=0;
3574  0b5e 0fb6          	clr	(OFST+0,sp)
3576  0b60               L5321:
3577                     ; 619 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3579  0b60 0db7          	tnz	(OFST+1,sp)
3580  0b62 2726          	jreq	L451
3581  0b64 7bb6          	ld	a,(OFST+0,sp)
3582  0b66 5f            	clrw	x
3583  0b67 97            	ld	xl,a
3584  0b68 58            	sllw	x
3585  0b69 1f09          	ldw	(OFST-173,sp),x
3587  0b6b 1ebc          	ldw	x,(OFST+6,sp)
3588  0b6d 58            	sllw	x
3589  0b6e 58            	sllw	x
3590  0b6f 1f07          	ldw	(OFST-175,sp),x
3592  0b71 96            	ldw	x,sp
3593  0b72 1c000e        	addw	x,#OFST-168
3594  0b75 1f05          	ldw	(OFST-177,sp),x
3596  0b77 1eba          	ldw	x,(OFST+4,sp)
3597  0b79 a60c          	ld	a,#12
3598  0b7b cd0000        	call	c_bmulx
3600  0b7e 72fb05        	addw	x,(OFST-177,sp)
3601  0b81 72fb07        	addw	x,(OFST-175,sp)
3602  0b84 72fb09        	addw	x,(OFST-173,sp)
3603  0b87 fe            	ldw	x,(x)
3604  0b88 2018          	jra	L651
3605  0b8a               L451:
3606  0b8a 7bb6          	ld	a,(OFST+0,sp)
3607  0b8c 5f            	clrw	x
3608  0b8d 97            	ld	xl,a
3609  0b8e 58            	sllw	x
3610  0b8f 1f03          	ldw	(OFST-179,sp),x
3612  0b91 96            	ldw	x,sp
3613  0b92 1c0086        	addw	x,#OFST-48
3614  0b95 1f01          	ldw	(OFST-181,sp),x
3616  0b97 1eba          	ldw	x,(OFST+4,sp)
3617  0b99 58            	sllw	x
3618  0b9a 58            	sllw	x
3619  0b9b 72fb01        	addw	x,(OFST-181,sp)
3620  0b9e 72fb03        	addw	x,(OFST-179,sp)
3621  0ba1 fe            	ldw	x,(x)
3622  0ba2               L651:
3624                     ; 651 			}break;
3625  0ba2 5d            	tnzw	x
3626  0ba3 2714          	jreq	L7401
3627  0ba5 5a            	decw	x
3628  0ba6 271c          	jreq	L1501
3629  0ba8 5a            	decw	x
3630  0ba9 2724          	jreq	L3501
3631  0bab 5a            	decw	x
3632  0bac 272c          	jreq	L5501
3633  0bae 5a            	decw	x
3634  0baf 2734          	jreq	L7501
3635  0bb1 5a            	decw	x
3636  0bb2 273c          	jreq	L1601
3637  0bb4 5a            	decw	x
3638  0bb5 2744          	jreq	L3601
3639  0bb7 204b          	jra	L5421
3640  0bb9               L7401:
3641                     ; 622 				GPIOx=GPIOD;
3643  0bb9 ae500f        	ldw	x,#20495
3644  0bbc 1f0b          	ldw	(OFST-171,sp),x
3646                     ; 623 				PortPin=GPIO_PIN_3;
3648  0bbe a608          	ld	a,#8
3649  0bc0 6b0d          	ld	(OFST-169,sp),a
3651                     ; 624 			}break;
3653  0bc2 2040          	jra	L5421
3654  0bc4               L1501:
3655                     ; 626 				GPIOx=GPIOD;
3657  0bc4 ae500f        	ldw	x,#20495
3658  0bc7 1f0b          	ldw	(OFST-171,sp),x
3660                     ; 627 				PortPin=GPIO_PIN_2;
3662  0bc9 a604          	ld	a,#4
3663  0bcb 6b0d          	ld	(OFST-169,sp),a
3665                     ; 628 			}break;
3667  0bcd 2035          	jra	L5421
3668  0bcf               L3501:
3669                     ; 630 				GPIOx=GPIOC;
3671  0bcf ae500a        	ldw	x,#20490
3672  0bd2 1f0b          	ldw	(OFST-171,sp),x
3674                     ; 631 				PortPin=GPIO_PIN_7;
3676  0bd4 a680          	ld	a,#128
3677  0bd6 6b0d          	ld	(OFST-169,sp),a
3679                     ; 632 			}break;
3681  0bd8 202a          	jra	L5421
3682  0bda               L5501:
3683                     ; 634 				GPIOx=GPIOC;
3685  0bda ae500a        	ldw	x,#20490
3686  0bdd 1f0b          	ldw	(OFST-171,sp),x
3688                     ; 635 				PortPin=GPIO_PIN_6;
3690  0bdf a640          	ld	a,#64
3691  0be1 6b0d          	ld	(OFST-169,sp),a
3693                     ; 636 			}break;
3695  0be3 201f          	jra	L5421
3696  0be5               L7501:
3697                     ; 638 				GPIOx=GPIOC;
3699  0be5 ae500a        	ldw	x,#20490
3700  0be8 1f0b          	ldw	(OFST-171,sp),x
3702                     ; 639 				PortPin=GPIO_PIN_5;
3704  0bea a620          	ld	a,#32
3705  0bec 6b0d          	ld	(OFST-169,sp),a
3707                     ; 640 			}break;
3709  0bee 2014          	jra	L5421
3710  0bf0               L1601:
3711                     ; 642 				GPIOx=GPIOC;
3713  0bf0 ae500a        	ldw	x,#20490
3714  0bf3 1f0b          	ldw	(OFST-171,sp),x
3716                     ; 643 				PortPin=GPIO_PIN_4;
3718  0bf5 a610          	ld	a,#16
3719  0bf7 6b0d          	ld	(OFST-169,sp),a
3721                     ; 644 			}break;
3723  0bf9 2009          	jra	L5421
3724  0bfb               L3601:
3725                     ; 646 				GPIOx=GPIOC;
3727  0bfb ae500a        	ldw	x,#20490
3728  0bfe 1f0b          	ldw	(OFST-171,sp),x
3730                     ; 647 				PortPin=GPIO_PIN_3;
3732  0c00 a608          	ld	a,#8
3733  0c02 6b0d          	ld	(OFST-169,sp),a
3735                     ; 648 			}break;
3737  0c04               L5421:
3738                     ; 653 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3740  0c04 0db6          	tnz	(OFST+0,sp)
3741  0c06 2704          	jreq	L061
3742  0c08 a6c0          	ld	a,#192
3743  0c0a 2002          	jra	L261
3744  0c0c               L061:
3745  0c0c a6d0          	ld	a,#208
3746  0c0e               L261:
3747  0c0e 88            	push	a
3748  0c0f 7b0e          	ld	a,(OFST-168,sp)
3749  0c11 88            	push	a
3750  0c12 1e0d          	ldw	x,(OFST-169,sp)
3751  0c14 cd0000        	call	_GPIO_Init
3753  0c17 85            	popw	x
3754                     ; 654 		is_low=!is_low;
3756  0c18 0db6          	tnz	(OFST+0,sp)
3757  0c1a 2604          	jrne	L461
3758  0c1c a601          	ld	a,#1
3759  0c1e 2001          	jra	L661
3760  0c20               L461:
3761  0c20 4f            	clr	a
3762  0c21               L661:
3763  0c21 6bb6          	ld	(OFST+0,sp),a
3765                     ; 655 	}while(is_low);
3767  0c23 0db6          	tnz	(OFST+0,sp)
3768  0c25 2703          	jreq	L071
3769  0c27 cc0b60        	jp	L5321
3770  0c2a               L071:
3771                     ; 656 }
3774  0c2a 5bb7          	addw	sp,#183
3775  0c2c 81            	ret
3817                     	xdef	f_TIM2_CapComp_IRQ_Handler
3818                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3819                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3820                     	xdef	_main
3821                     	xdef	_Serial_print_string
3822                     	xdef	_Serial_newline
3823                     	xdef	_Serial_print_int
3824                     	xdef	_setWhite
3825                     	xdef	_setRGB
3826                     	xdef	_setLED
3827                     	xdef	_setMatrixHighZ
3828                     	xdef	_tms3
3829                     	xdef	_tms2
3830                     	xdef	_tms
3831                     	xdef	_ADC_Read
3832                     	xref	_UART1_GetFlagStatus
3833                     	xref	_UART1_SendData8
3834                     	xref	_UART1_Cmd
3835                     	xref	_UART1_Init
3836                     	xref	_UART1_DeInit
3837                     	xref	_GPIO_ReadInputPin
3838                     	xref	_GPIO_Init
3839                     	xref	_ADC1_ClearFlag
3840                     	xref	_ADC1_GetFlagStatus
3841                     	xref	_ADC1_GetConversionValue
3842                     	xref	_ADC1_StartConversion
3843                     	xref	_ADC1_Cmd
3844                     	xref	_ADC1_Init
3845                     	xref	_ADC1_DeInit
3846                     	switch	.const
3847  00ed               L106:
3848  00ed 2c20746d7333  	dc.b	", tms3: ",0
3849  00f6               L775:
3850  00f6 746d73323a20  	dc.b	"tms2: ",0
3851  00fd               L145:
3852  00fd 506172616d73  	dc.b	"Params: ",0
3853  0106               L335:
3854  0106 74696d653a20  	dc.b	"time: ",0
3855  010d               L325:
3856  010d 506172616d73  	dc.b	"Params v2: ",0
3857  0119               L125:
3858  0119 4d6f64653a20  	dc.b	"Mode: ",0
3859  0120               L105:
3860  0120 2000          	dc.b	" ",0
3861  0122               L144:
3862  0122 2a00          	dc.b	"*",0
3863  0124               L724:
3864  0124 3000          	dc.b	"0",0
3865  0126               L163:
3866  0126 2c2000        	dc.b	", ",0
3867  0129               L753:
3868  0129 6164633a2000  	dc.b	"adc: ",0
3869  012f               L723:
3870  012f 636f756e7465  	dc.b	"counter: ",0
3871                     	xref.b	c_lreg
3872                     	xref.b	c_x
3873                     	xref.b	c_y
3893                     	xref	c_bmulx
3894                     	xref	c_sdivx
3895                     	xref	c_smody
3896                     	xref	c_lxor
3897                     	xref	c_itolx
3898                     	xref	c_lrzmp
3899                     	xref	c_lumd
3900                     	xref	c_imul
3901                     	xref	c_ladd
3902                     	xref	c_lursh
3903                     	xref	c_uitol
3904                     	xref	c_smodx
3905                     	xref	c_ludv
3906                     	xref	c_itol
3907                     	xref	c_rtol
3908                     	xref	c_uitolx
3909                     	xref	c_lzmp
3910                     	xref	c_lcmp
3911                     	xref	c_ltor
3912                     	xref	c_lgadc
3913                     	xref	c_xymov
3914                     	end
