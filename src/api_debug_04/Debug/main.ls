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
 464                     	switch	.const
 465  0010               L01:
 466  0010 00002710      	dc.l	10000
 467  0014               L21:
 468  0014 00007530      	dc.l	30000
 469  0018               L42:
 470  0018 000003e8      	dc.l	1000
 471  001c               L04:
 472  001c 0000000a      	dc.l	10
 473  0020               L25:
 474  0020 00000014      	dc.l	20
 475  0024               L45:
 476  0024 00000064      	dc.l	100
 477  0028               L65:
 478  0028 000007d0      	dc.l	2000
 479  002c               L46:
 480  002c 00001388      	dc.l	5000
 481                     ; 20 int main()
 481                     ; 21 {
 482                     	switch	.text
 483  003e               _main:
 485  003e 5238          	subw	sp,#56
 486       00000038      OFST:	set	56
 489                     ; 44 	const int test_mode=5;
 491  0040 ae0005        	ldw	x,#5
 492  0043 1f33          	ldw	(OFST-5,sp),x
 494                     ; 45 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 496  0045 96            	ldw	x,sp
 497  0046 1c0009        	addw	x,#OFST-47
 498  0049 90ae0000      	ldw	y,#L75_rms_lookup
 499  004d a610          	ld	a,#16
 500  004f cd0000        	call	c_xymov
 502                     ; 47 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 506  0052 ae0000        	ldw	x,#0
 507  0055 1f26          	ldw	(OFST-18,sp),x
 508  0057 ae0000        	ldw	x,#0
 509  005a 1f24          	ldw	(OFST-20,sp),x
 515                     ; 48 	unsigned sound_level=0;
 517  005c 5f            	clrw	x
 518  005d 1f2a          	ldw	(OFST-14,sp),x
 520                     ; 49 	uint8_t mean_threshold=16;
 522  005f a610          	ld	a,#16
 523  0061 6b28          	ld	(OFST-16,sp),a
 525                     ; 50 	uint8_t mean_threshold_8=1;
 527  0063 a601          	ld	a,#1
 528  0065 6b23          	ld	(OFST-21,sp),a
 530                     ; 51 	uint16_t mean_threshold_16=0x0100;
 532  0067 ae0100        	ldw	x,#256
 533  006a 1f21          	ldw	(OFST-23,sp),x
 535                     ; 52 	unsigned int rms=0;
 537                     ; 53 	const long adc_captures=1<<8;
 539  006c ae0100        	ldw	x,#256
 540  006f 1f1b          	ldw	(OFST-29,sp),x
 541  0071 ae0000        	ldw	x,#0
 542  0074 1f19          	ldw	(OFST-31,sp),x
 544                     ; 55 	int debug=0;
 546  0076 5f            	clrw	x
 547  0077 1f2d          	ldw	(OFST-11,sp),x
 549                     ; 57 	for(rep=0;rep<1;rep++)
 551  0079 ae0000        	ldw	x,#0
 552  007c 1f31          	ldw	(OFST-7,sp),x
 553  007e ae0000        	ldw	x,#0
 554  0081 1f2f          	ldw	(OFST-9,sp),x
 556  0083               L152:
 557                     ; 58 		for(iter=0;iter<10000;iter++){}
 559  0083 ae0000        	ldw	x,#0
 560  0086 1f37          	ldw	(OFST-1,sp),x
 561  0088 ae0000        	ldw	x,#0
 562  008b 1f35          	ldw	(OFST-3,sp),x
 564  008d               L752:
 567  008d 96            	ldw	x,sp
 568  008e 1c0035        	addw	x,#OFST-3
 569  0091 a601          	ld	a,#1
 570  0093 cd0000        	call	c_lgadc
 575  0096 96            	ldw	x,sp
 576  0097 1c0035        	addw	x,#OFST-3
 577  009a cd0000        	call	c_ltor
 579  009d ae0010        	ldw	x,#L01
 580  00a0 cd0000        	call	c_lcmp
 582  00a3 25e8          	jrult	L752
 583                     ; 57 	for(rep=0;rep<1;rep++)
 585  00a5 96            	ldw	x,sp
 586  00a6 1c002f        	addw	x,#OFST-9
 587  00a9 a601          	ld	a,#1
 588  00ab cd0000        	call	c_lgadc
 593  00ae 96            	ldw	x,sp
 594  00af 1c002f        	addw	x,#OFST-9
 595  00b2 cd0000        	call	c_lzmp
 597  00b5 27cc          	jreq	L152
 598                     ; 61 	if(test_mode!=4 && test_mode!=5)
 600  00b7 1e33          	ldw	x,(OFST-5,sp)
 601  00b9 a30004        	cpw	x,#4
 602  00bc 273c          	jreq	L562
 604  00be 1e33          	ldw	x,(OFST-5,sp)
 605  00c0 a30005        	cpw	x,#5
 606  00c3 2735          	jreq	L562
 607                     ; 63 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 609  00c5 4bf0          	push	#240
 610  00c7 4b20          	push	#32
 611  00c9 ae500f        	ldw	x,#20495
 612  00cc cd0000        	call	_GPIO_Init
 614  00cf 85            	popw	x
 615                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 617  00d0 4b40          	push	#64
 618  00d2 4b40          	push	#64
 619  00d4 ae500f        	ldw	x,#20495
 620  00d7 cd0000        	call	_GPIO_Init
 622  00da 85            	popw	x
 623                     ; 65 		UART1_DeInit();
 625  00db cd0000        	call	_UART1_DeInit
 627                     ; 66 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 629  00de 4b0c          	push	#12
 630  00e0 4b80          	push	#128
 631  00e2 4b00          	push	#0
 632  00e4 4b00          	push	#0
 633  00e6 4b00          	push	#0
 634  00e8 aec200        	ldw	x,#49664
 635  00eb 89            	pushw	x
 636  00ec ae0001        	ldw	x,#1
 637  00ef 89            	pushw	x
 638  00f0 cd0000        	call	_UART1_Init
 640  00f3 5b09          	addw	sp,#9
 641                     ; 68 		UART1_Cmd(ENABLE);
 643  00f5 a601          	ld	a,#1
 644  00f7 cd0000        	call	_UART1_Cmd
 646  00fa               L562:
 647                     ; 71 	switch(test_mode)
 649  00fa 1e33          	ldw	x,(OFST-5,sp)
 651                     ; 399 				Serial_newline();
 652  00fc 5d            	tnzw	x
 653  00fd 2727          	jreq	L372
 654  00ff 5a            	decw	x
 655  0100 2603          	jrne	L07
 656  0102 cc01ca        	jp	L733
 657  0105               L07:
 658  0105 5a            	decw	x
 659  0106 2603          	jrne	L27
 660  0108 cc0280        	jp	L56
 661  010b               L27:
 662  010b 5a            	decw	x
 663  010c 2603          	jrne	L47
 664  010e cc0496        	jp	L76
 665  0111               L47:
 666  0111 5a            	decw	x
 667  0112 2603          	jrne	L67
 668  0114 cc05d0        	jp	L17
 669  0117               L67:
 670  0117 5a            	decw	x
 671  0118 2603          	jrne	L001
 672  011a cc0633        	jp	L37
 673  011d               L001:
 674  011d 5a            	decw	x
 675  011e 2603          	jrne	L201
 676  0120 cc079d        	jp	L57
 677  0123               L201:
 678  0123               L66:
 679                     ; 404 }
 682  0123 5b38          	addw	sp,#56
 683  0125 81            	ret
 684  0126               L372:
 685                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 687  0126 5f            	clrw	x
 688  0127 1f2a          	ldw	(OFST-14,sp),x
 690  0129               L772:
 691                     ; 81 					for(led_index=0;led_index<10;led_index++)
 693  0129 5f            	clrw	x
 694  012a 1f33          	ldw	(OFST-5,sp),x
 696  012c               L503:
 697                     ; 83 						setMatrixHighZ();
 699  012c cd08c2        	call	_setMatrixHighZ
 701                     ; 84 						setRGB(led_index,rgb_index);
 703  012f 1e2a          	ldw	x,(OFST-14,sp)
 704  0131 89            	pushw	x
 705  0132 1e35          	ldw	x,(OFST-3,sp)
 706  0134 cd08d9        	call	_setRGB
 708  0137 85            	popw	x
 709                     ; 85 						for(iter=0;iter<30000;iter++){}
 711  0138 ae0000        	ldw	x,#0
 712  013b 1f37          	ldw	(OFST-1,sp),x
 713  013d ae0000        	ldw	x,#0
 714  0140 1f35          	ldw	(OFST-3,sp),x
 716  0142               L313:
 719  0142 96            	ldw	x,sp
 720  0143 1c0035        	addw	x,#OFST-3
 721  0146 a601          	ld	a,#1
 722  0148 cd0000        	call	c_lgadc
 727  014b 96            	ldw	x,sp
 728  014c 1c0035        	addw	x,#OFST-3
 729  014f cd0000        	call	c_ltor
 731  0152 ae0014        	ldw	x,#L21
 732  0155 cd0000        	call	c_lcmp
 734  0158 25e8          	jrult	L313
 735                     ; 86 						debug++;
 737  015a 1e2d          	ldw	x,(OFST-11,sp)
 738  015c 1c0001        	addw	x,#1
 739  015f 1f2d          	ldw	(OFST-11,sp),x
 741                     ; 93 							Serial_print_string("counter: ");
 743  0161 ae010f        	ldw	x,#L123
 744  0164 cd0827        	call	_Serial_print_string
 746                     ; 94 							Serial_print_int(debug);
 748  0167 1e2d          	ldw	x,(OFST-11,sp)
 749  0169 cd0850        	call	_Serial_print_int
 751                     ; 97 							Serial_newline();
 753  016c cd08b3        	call	_Serial_newline
 755                     ; 81 					for(led_index=0;led_index<10;led_index++)
 757  016f 1e33          	ldw	x,(OFST-5,sp)
 758  0171 1c0001        	addw	x,#1
 759  0174 1f33          	ldw	(OFST-5,sp),x
 763  0176 1e33          	ldw	x,(OFST-5,sp)
 764  0178 a3000a        	cpw	x,#10
 765  017b 25af          	jrult	L503
 766                     ; 79 				for(rgb_index=0;rgb_index<3;rgb_index++)
 768  017d 1e2a          	ldw	x,(OFST-14,sp)
 769  017f 1c0001        	addw	x,#1
 770  0182 1f2a          	ldw	(OFST-14,sp),x
 774  0184 1e2a          	ldw	x,(OFST-14,sp)
 775  0186 a30003        	cpw	x,#3
 776  0189 259e          	jrult	L772
 777                     ; 101 				for(led_index=0;led_index<12;led_index++)
 779  018b 5f            	clrw	x
 780  018c 1f33          	ldw	(OFST-5,sp),x
 782  018e               L323:
 783                     ; 103 					setMatrixHighZ();
 785  018e cd08c2        	call	_setMatrixHighZ
 787                     ; 104 					setWhite(led_index);
 789  0191 1e33          	ldw	x,(OFST-5,sp)
 790  0193 cd08e8        	call	_setWhite
 792                     ; 105 					for(iter=0;iter<30000;iter++){}
 794  0196 ae0000        	ldw	x,#0
 795  0199 1f37          	ldw	(OFST-1,sp),x
 796  019b ae0000        	ldw	x,#0
 797  019e 1f35          	ldw	(OFST-3,sp),x
 799  01a0               L133:
 802  01a0 96            	ldw	x,sp
 803  01a1 1c0035        	addw	x,#OFST-3
 804  01a4 a601          	ld	a,#1
 805  01a6 cd0000        	call	c_lgadc
 810  01a9 96            	ldw	x,sp
 811  01aa 1c0035        	addw	x,#OFST-3
 812  01ad cd0000        	call	c_ltor
 814  01b0 ae0014        	ldw	x,#L21
 815  01b3 cd0000        	call	c_lcmp
 817  01b6 25e8          	jrult	L133
 818                     ; 101 				for(led_index=0;led_index<12;led_index++)
 820  01b8 1e33          	ldw	x,(OFST-5,sp)
 821  01ba 1c0001        	addw	x,#1
 822  01bd 1f33          	ldw	(OFST-5,sp),x
 826  01bf 1e33          	ldw	x,(OFST-5,sp)
 827  01c1 a3000c        	cpw	x,#12
 828  01c4 25c8          	jrult	L323
 830  01c6 ac260126      	jpf	L372
 831  01ca               L733:
 832                     ; 113 				rep=ADC_Read(AIN4);
 834  01ca a604          	ld	a,#4
 835  01cc cd0000        	call	_ADC_Read
 837  01cf cd0000        	call	c_uitolx
 839  01d2 96            	ldw	x,sp
 840  01d3 1c002f        	addw	x,#OFST-9
 841  01d6 cd0000        	call	c_rtol
 844                     ; 114 				my_min=rep;
 846  01d9 1e31          	ldw	x,(OFST-7,sp)
 847  01db 1f33          	ldw	(OFST-5,sp),x
 849                     ; 115 				my_max=rep;
 851  01dd 1e31          	ldw	x,(OFST-7,sp)
 852  01df 1f2d          	ldw	(OFST-11,sp),x
 854                     ; 116 				for(iter=0;iter<1000;iter++)
 856  01e1 ae0000        	ldw	x,#0
 857  01e4 1f37          	ldw	(OFST-1,sp),x
 858  01e6 ae0000        	ldw	x,#0
 859  01e9 1f35          	ldw	(OFST-3,sp),x
 861  01eb               L343:
 862                     ; 118 					rep=ADC_Read(AIN4);
 864  01eb a604          	ld	a,#4
 865  01ed cd0000        	call	_ADC_Read
 867  01f0 cd0000        	call	c_uitolx
 869  01f3 96            	ldw	x,sp
 870  01f4 1c002f        	addw	x,#OFST-9
 871  01f7 cd0000        	call	c_rtol
 874                     ; 119 					my_min=my_min<rep?my_min:rep;
 876  01fa 1e33          	ldw	x,(OFST-5,sp)
 877  01fc cd0000        	call	c_uitolx
 879  01ff 96            	ldw	x,sp
 880  0200 1c002f        	addw	x,#OFST-9
 881  0203 cd0000        	call	c_lcmp
 883  0206 2404          	jruge	L41
 884  0208 1e33          	ldw	x,(OFST-5,sp)
 885  020a 2002          	jra	L61
 886  020c               L41:
 887  020c 1e31          	ldw	x,(OFST-7,sp)
 888  020e               L61:
 889  020e 1f33          	ldw	(OFST-5,sp),x
 891                     ; 120 					my_max=my_max>rep?my_max:rep;
 893  0210 1e2d          	ldw	x,(OFST-11,sp)
 894  0212 cd0000        	call	c_uitolx
 896  0215 96            	ldw	x,sp
 897  0216 1c002f        	addw	x,#OFST-9
 898  0219 cd0000        	call	c_lcmp
 900  021c 2304          	jrule	L02
 901  021e 1e2d          	ldw	x,(OFST-11,sp)
 902  0220 2002          	jra	L22
 903  0222               L02:
 904  0222 1e31          	ldw	x,(OFST-7,sp)
 905  0224               L22:
 906  0224 1f2d          	ldw	(OFST-11,sp),x
 908                     ; 116 				for(iter=0;iter<1000;iter++)
 910  0226 96            	ldw	x,sp
 911  0227 1c0035        	addw	x,#OFST-3
 912  022a a601          	ld	a,#1
 913  022c cd0000        	call	c_lgadc
 918  022f 96            	ldw	x,sp
 919  0230 1c0035        	addw	x,#OFST-3
 920  0233 cd0000        	call	c_ltor
 922  0236 ae0018        	ldw	x,#L42
 923  0239 cd0000        	call	c_lcmp
 925  023c 25ad          	jrult	L343
 926                     ; 122 				Serial_print_string("adc: ");
 928  023e ae0109        	ldw	x,#L153
 929  0241 cd0827        	call	_Serial_print_string
 931                     ; 123 				Serial_print_int(rep);
 933  0244 1e31          	ldw	x,(OFST-7,sp)
 934  0246 cd0850        	call	_Serial_print_int
 936                     ; 124 				Serial_print_string(", ");
 938  0249 ae0106        	ldw	x,#L353
 939  024c cd0827        	call	_Serial_print_string
 941                     ; 125 				Serial_print_int(my_max-my_min);
 943  024f 1e2d          	ldw	x,(OFST-11,sp)
 944  0251 72f033        	subw	x,(OFST-5,sp)
 945  0254 cd0850        	call	_Serial_print_int
 947                     ; 126 				Serial_newline();
 949  0257 cd08b3        	call	_Serial_newline
 951                     ; 127 				for(iter=0;iter<10000;iter++){}
 953  025a ae0000        	ldw	x,#0
 954  025d 1f37          	ldw	(OFST-1,sp),x
 955  025f ae0000        	ldw	x,#0
 956  0262 1f35          	ldw	(OFST-3,sp),x
 958  0264               L553:
 961  0264 96            	ldw	x,sp
 962  0265 1c0035        	addw	x,#OFST-3
 963  0268 a601          	ld	a,#1
 964  026a cd0000        	call	c_lgadc
 969  026d 96            	ldw	x,sp
 970  026e 1c0035        	addw	x,#OFST-3
 971  0271 cd0000        	call	c_ltor
 973  0274 ae0010        	ldw	x,#L01
 974  0277 cd0000        	call	c_lcmp
 976  027a 25e8          	jrult	L553
 978  027c acca01ca      	jpf	L733
 979  0280               L56:
 980                     ; 132 			ADC1_DeInit();
 982  0280 cd0000        	call	_ADC1_DeInit
 984                     ; 133 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 984                     ; 134 							 AIN4,
 984                     ; 135 							 ADC1_PRESSEL_FCPU_D2,//D18 
 984                     ; 136 							 ADC1_EXTTRIG_TIM, 
 984                     ; 137 							 DISABLE, 
 984                     ; 138 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 984                     ; 139 							 ADC1_SCHMITTTRIG_ALL, 
 984                     ; 140 							 DISABLE);
 986  0283 4b00          	push	#0
 987  0285 4bff          	push	#255
 988  0287 4b08          	push	#8
 989  0289 4b00          	push	#0
 990  028b 4b00          	push	#0
 991  028d 4b00          	push	#0
 992  028f ae0104        	ldw	x,#260
 993  0292 cd0000        	call	_ADC1_Init
 995  0295 5b06          	addw	sp,#6
 996                     ; 141 			ADC1_Cmd(ENABLE);
 998  0297 a601          	ld	a,#1
 999  0299 cd0000        	call	_ADC1_Cmd
1001  029c               L363:
1002                     ; 165 				rms=0;
1004  029c 5f            	clrw	x
1005  029d 1f33          	ldw	(OFST-5,sp),x
1007                     ; 167 				mean_sum=0;
1009  029f ae0000        	ldw	x,#0
1010  02a2 1f26          	ldw	(OFST-18,sp),x
1011  02a4 ae0000        	ldw	x,#0
1012  02a7 1f24          	ldw	(OFST-20,sp),x
1014                     ; 168 				mean_low=mean+mean_threshold;
1016  02a9 7b29          	ld	a,(OFST-15,sp)
1017  02ab 5f            	clrw	x
1018  02ac 1b28          	add	a,(OFST-16,sp)
1019  02ae 2401          	jrnc	L62
1020  02b0 5c            	incw	x
1021  02b1               L62:
1022  02b1 cd0000        	call	c_itol
1024  02b4 96            	ldw	x,sp
1025  02b5 1c001d        	addw	x,#OFST-27
1026  02b8 cd0000        	call	c_rtol
1029                     ; 169 				mean_high=mean-mean_threshold;
1031  02bb 7b29          	ld	a,(OFST-15,sp)
1032  02bd 5f            	clrw	x
1033  02be 1028          	sub	a,(OFST-16,sp)
1034  02c0 2401          	jrnc	L03
1035  02c2 5a            	decw	x
1036  02c3               L03:
1037  02c3 cd0000        	call	c_itol
1039  02c6 96            	ldw	x,sp
1040  02c7 1c002f        	addw	x,#OFST-9
1041  02ca cd0000        	call	c_rtol
1044                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1046  02cd ae0000        	ldw	x,#0
1047  02d0 1f37          	ldw	(OFST-1,sp),x
1048  02d2 ae0000        	ldw	x,#0
1049  02d5 1f35          	ldw	(OFST-3,sp),x
1052  02d7 2058          	jra	L373
1053  02d9               L763:
1054                     ; 173 					ADC1_StartConversion();
1056  02d9 cd0000        	call	_ADC1_StartConversion
1059  02dc               L104:
1060                     ; 174 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1062  02dc a680          	ld	a,#128
1063  02de cd0000        	call	_ADC1_GetFlagStatus
1065  02e1 4d            	tnz	a
1066  02e2 27f8          	jreq	L104
1067                     ; 176 					reading=ADC1->DRL;
1069  02e4 c65405        	ld	a,21509
1070  02e7 6b2c          	ld	(OFST-12,sp),a
1072                     ; 177 					mean_sum += reading;
1074  02e9 7b2c          	ld	a,(OFST-12,sp)
1075  02eb 96            	ldw	x,sp
1076  02ec 1c0024        	addw	x,#OFST-20
1077  02ef cd0000        	call	c_lgadc
1080                     ; 178 					rms+=reading>mean_low || reading<mean_high;
1082  02f2 7b2c          	ld	a,(OFST-12,sp)
1083  02f4 b703          	ld	c_lreg+3,a
1084  02f6 3f02          	clr	c_lreg+2
1085  02f8 3f01          	clr	c_lreg+1
1086  02fa 3f00          	clr	c_lreg
1087  02fc 96            	ldw	x,sp
1088  02fd 1c001d        	addw	x,#OFST-27
1089  0300 cd0000        	call	c_lcmp
1091  0303 2213          	jrugt	L43
1092  0305 7b2c          	ld	a,(OFST-12,sp)
1093  0307 b703          	ld	c_lreg+3,a
1094  0309 3f02          	clr	c_lreg+2
1095  030b 3f01          	clr	c_lreg+1
1096  030d 3f00          	clr	c_lreg
1097  030f 96            	ldw	x,sp
1098  0310 1c002f        	addw	x,#OFST-9
1099  0313 cd0000        	call	c_lcmp
1101  0316 2405          	jruge	L23
1102  0318               L43:
1103  0318 ae0001        	ldw	x,#1
1104  031b 2001          	jra	L63
1105  031d               L23:
1106  031d 5f            	clrw	x
1107  031e               L63:
1108  031e 72fb33        	addw	x,(OFST-5,sp)
1109  0321 1f33          	ldw	(OFST-5,sp),x
1111                     ; 182 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1113  0323 a680          	ld	a,#128
1114  0325 cd0000        	call	_ADC1_ClearFlag
1116                     ; 170 				for(iter=0;iter<adc_captures;iter++)
1118  0328 96            	ldw	x,sp
1119  0329 1c0035        	addw	x,#OFST-3
1120  032c a601          	ld	a,#1
1121  032e cd0000        	call	c_lgadc
1124  0331               L373:
1127  0331 96            	ldw	x,sp
1128  0332 1c0035        	addw	x,#OFST-3
1129  0335 cd0000        	call	c_ltor
1131  0338 96            	ldw	x,sp
1132  0339 1c0019        	addw	x,#OFST-31
1133  033c cd0000        	call	c_lcmp
1135  033f 2598          	jrult	L763
1136                     ; 186 				if(rms>9) mean_threshold++;
1138  0341 1e33          	ldw	x,(OFST-5,sp)
1139  0343 a3000a        	cpw	x,#10
1140  0346 2502          	jrult	L504
1143  0348 0c28          	inc	(OFST-16,sp)
1145  034a               L504:
1146                     ; 187 				if(rms==0) mean_threshold--;
1148  034a 1e33          	ldw	x,(OFST-5,sp)
1149  034c 2602          	jrne	L704
1152  034e 0a28          	dec	(OFST-16,sp)
1154  0350               L704:
1155                     ; 188 				mean=(mean_sum)/(adc_captures);
1157  0350 96            	ldw	x,sp
1158  0351 1c0024        	addw	x,#OFST-20
1159  0354 cd0000        	call	c_ltor
1161  0357 96            	ldw	x,sp
1162  0358 1c0019        	addw	x,#OFST-31
1163  035b cd0000        	call	c_ludv
1165  035e b603          	ld	a,c_lreg+3
1166  0360 6b29          	ld	(OFST-15,sp),a
1168                     ; 189 				if(sound_level/32<mean_threshold) sound_level++;
1170  0362 1e2a          	ldw	x,(OFST-14,sp)
1171  0364 54            	srlw	x
1172  0365 54            	srlw	x
1173  0366 54            	srlw	x
1174  0367 54            	srlw	x
1175  0368 54            	srlw	x
1176  0369 7b28          	ld	a,(OFST-16,sp)
1177  036b 905f          	clrw	y
1178  036d 9097          	ld	yl,a
1179  036f 90bf00        	ldw	c_y,y
1180  0372 b300          	cpw	x,c_y
1181  0374 2407          	jruge	L114
1184  0376 1e2a          	ldw	x,(OFST-14,sp)
1185  0378 1c0001        	addw	x,#1
1186  037b 1f2a          	ldw	(OFST-14,sp),x
1188  037d               L114:
1189                     ; 190 				if(sound_level/32>mean_threshold) sound_level--;
1191  037d 1e2a          	ldw	x,(OFST-14,sp)
1192  037f 54            	srlw	x
1193  0380 54            	srlw	x
1194  0381 54            	srlw	x
1195  0382 54            	srlw	x
1196  0383 54            	srlw	x
1197  0384 7b28          	ld	a,(OFST-16,sp)
1198  0386 905f          	clrw	y
1199  0388 9097          	ld	yl,a
1200  038a 90bf00        	ldw	c_y,y
1201  038d b300          	cpw	x,c_y
1202  038f 2307          	jrule	L314
1205  0391 1e2a          	ldw	x,(OFST-14,sp)
1206  0393 1d0001        	subw	x,#1
1207  0396 1f2a          	ldw	(OFST-14,sp),x
1209  0398               L314:
1210                     ; 191 				if(debug%4==0)
1212  0398 1e2d          	ldw	x,(OFST-11,sp)
1213  039a a604          	ld	a,#4
1214  039c cd0000        	call	c_smodx
1216  039f a30000        	cpw	x,#0
1217  03a2 267b          	jrne	L514
1218                     ; 193 					Serial_print_string("adc: ");
1220  03a4 ae0109        	ldw	x,#L153
1221  03a7 cd0827        	call	_Serial_print_string
1223                     ; 194 					Serial_print_int(mean);
1225  03aa 7b29          	ld	a,(OFST-15,sp)
1226  03ac 5f            	clrw	x
1227  03ad 97            	ld	xl,a
1228  03ae cd0850        	call	_Serial_print_int
1230                     ; 195 					Serial_print_string(", ");
1232  03b1 ae0106        	ldw	x,#L353
1233  03b4 cd0827        	call	_Serial_print_string
1235                     ; 196 					if(rms<9) Serial_print_string("0");
1237  03b7 1e33          	ldw	x,(OFST-5,sp)
1238  03b9 a30009        	cpw	x,#9
1239  03bc 2406          	jruge	L714
1242  03be ae0104        	ldw	x,#L124
1243  03c1 cd0827        	call	_Serial_print_string
1245  03c4               L714:
1246                     ; 197 					if(rms==0) Serial_print_string("0");
1248  03c4 1e33          	ldw	x,(OFST-5,sp)
1249  03c6 2606          	jrne	L324
1252  03c8 ae0104        	ldw	x,#L124
1253  03cb cd0827        	call	_Serial_print_string
1255  03ce               L324:
1256                     ; 198 					Serial_print_int(rms);
1258  03ce 1e33          	ldw	x,(OFST-5,sp)
1259  03d0 cd0850        	call	_Serial_print_int
1261                     ; 199 					Serial_print_string(", ");
1263  03d3 ae0106        	ldw	x,#L353
1264  03d6 cd0827        	call	_Serial_print_string
1266                     ; 200 					if(mean_threshold<9) Serial_print_string("0");
1268  03d9 7b28          	ld	a,(OFST-16,sp)
1269  03db a109          	cp	a,#9
1270  03dd 2406          	jruge	L524
1273  03df ae0104        	ldw	x,#L124
1274  03e2 cd0827        	call	_Serial_print_string
1276  03e5               L524:
1277                     ; 201 					Serial_print_int(mean_threshold);
1279  03e5 7b28          	ld	a,(OFST-16,sp)
1280  03e7 5f            	clrw	x
1281  03e8 97            	ld	xl,a
1282  03e9 cd0850        	call	_Serial_print_int
1284                     ; 202 					Serial_print_string(", ");
1286  03ec ae0106        	ldw	x,#L353
1287  03ef cd0827        	call	_Serial_print_string
1289                     ; 203 					if(sound_level/8<9) Serial_print_string("0");
1291  03f2 1e2a          	ldw	x,(OFST-14,sp)
1292  03f4 54            	srlw	x
1293  03f5 54            	srlw	x
1294  03f6 54            	srlw	x
1295  03f7 a30009        	cpw	x,#9
1296  03fa 2406          	jruge	L724
1299  03fc ae0104        	ldw	x,#L124
1300  03ff cd0827        	call	_Serial_print_string
1302  0402               L724:
1303                     ; 204 					Serial_print_int(sound_level/8);
1305  0402 1e2a          	ldw	x,(OFST-14,sp)
1306  0404 54            	srlw	x
1307  0405 54            	srlw	x
1308  0406 54            	srlw	x
1309  0407 cd0850        	call	_Serial_print_int
1311                     ; 205 					if(debug%10==0) Serial_print_string("*");
1313  040a 1e2d          	ldw	x,(OFST-11,sp)
1314  040c a60a          	ld	a,#10
1315  040e cd0000        	call	c_smodx
1317  0411 a30000        	cpw	x,#0
1318  0414 2606          	jrne	L134
1321  0416 ae0102        	ldw	x,#L334
1322  0419 cd0827        	call	_Serial_print_string
1324  041c               L134:
1325                     ; 206 					Serial_newline();
1327  041c cd08b3        	call	_Serial_newline
1329  041f               L514:
1330                     ; 208 				if(mean_threshold>10)
1332  041f 7b28          	ld	a,(OFST-16,sp)
1333  0421 a10b          	cp	a,#11
1334  0423 2518          	jrult	L534
1335                     ; 212 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1337  0425 4bd0          	push	#208
1338  0427 4b08          	push	#8
1339  0429 ae500a        	ldw	x,#20490
1340  042c cd0000        	call	_GPIO_Init
1342  042f 85            	popw	x
1343                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1345  0430 4bc0          	push	#192
1346  0432 4b20          	push	#32
1347  0434 ae500a        	ldw	x,#20490
1348  0437 cd0000        	call	_GPIO_Init
1350  043a 85            	popw	x
1352  043b 2016          	jra	L734
1353  043d               L534:
1354                     ; 215 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1356  043d 4bd0          	push	#208
1357  043f 4b10          	push	#16
1358  0441 ae500a        	ldw	x,#20490
1359  0444 cd0000        	call	_GPIO_Init
1361  0447 85            	popw	x
1362                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1364  0448 4bc0          	push	#192
1365  044a 4b40          	push	#64
1366  044c ae500a        	ldw	x,#20490
1367  044f cd0000        	call	_GPIO_Init
1369  0452 85            	popw	x
1370  0453               L734:
1371                     ; 218 			for(iter=0;iter<10;iter++){}
1373  0453 ae0000        	ldw	x,#0
1374  0456 1f37          	ldw	(OFST-1,sp),x
1375  0458 ae0000        	ldw	x,#0
1376  045b 1f35          	ldw	(OFST-3,sp),x
1378  045d               L144:
1381  045d 96            	ldw	x,sp
1382  045e 1c0035        	addw	x,#OFST-3
1383  0461 a601          	ld	a,#1
1384  0463 cd0000        	call	c_lgadc
1389  0466 96            	ldw	x,sp
1390  0467 1c0035        	addw	x,#OFST-3
1391  046a cd0000        	call	c_ltor
1393  046d ae001c        	ldw	x,#L04
1394  0470 cd0000        	call	c_lcmp
1396  0473 25e8          	jrult	L144
1397                     ; 219 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1399  0475 4b00          	push	#0
1400  0477 4bf8          	push	#248
1401  0479 ae500a        	ldw	x,#20490
1402  047c cd0000        	call	_GPIO_Init
1404  047f 85            	popw	x
1405                     ; 220 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1407  0480 4b00          	push	#0
1408  0482 4b04          	push	#4
1409  0484 ae500f        	ldw	x,#20495
1410  0487 cd0000        	call	_GPIO_Init
1412  048a 85            	popw	x
1413                     ; 222 				debug++;
1415  048b 1e2d          	ldw	x,(OFST-11,sp)
1416  048d 1c0001        	addw	x,#1
1417  0490 1f2d          	ldw	(OFST-11,sp),x
1420  0492 ac9c029c      	jpf	L363
1421  0496               L76:
1422                     ; 228 			ADC1_DeInit();
1424  0496 cd0000        	call	_ADC1_DeInit
1426                     ; 229 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1426                     ; 230 							 AIN4,
1426                     ; 231 							 ADC1_PRESSEL_FCPU_D2,//D18 
1426                     ; 232 							 ADC1_EXTTRIG_TIM, 
1426                     ; 233 							 DISABLE, 
1426                     ; 234 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1426                     ; 235 							 ADC1_SCHMITTTRIG_ALL, 
1426                     ; 236 							 DISABLE);
1428  0499 4b00          	push	#0
1429  049b 4bff          	push	#255
1430  049d 4b08          	push	#8
1431  049f 4b00          	push	#0
1432  04a1 4b00          	push	#0
1433  04a3 4b00          	push	#0
1434  04a5 ae0104        	ldw	x,#260
1435  04a8 cd0000        	call	_ADC1_Init
1437  04ab 5b06          	addw	sp,#6
1438                     ; 237 			ADC1_Cmd(ENABLE);
1440  04ad a601          	ld	a,#1
1441  04af cd0000        	call	_ADC1_Cmd
1443  04b2               L744:
1444                     ; 240 				debug++;
1446  04b2 1e2d          	ldw	x,(OFST-11,sp)
1447  04b4 1c0001        	addw	x,#1
1448  04b7 1f2d          	ldw	(OFST-11,sp),x
1450                     ; 241 				rms=0;//8 bit
1452  04b9 5f            	clrw	x
1453  04ba 1f33          	ldw	(OFST-5,sp),x
1455                     ; 243 				mean_sum=0;//16 bit
1457  04bc ae0000        	ldw	x,#0
1458  04bf 1f26          	ldw	(OFST-18,sp),x
1459  04c1 ae0000        	ldw	x,#0
1460  04c4 1f24          	ldw	(OFST-20,sp),x
1462                     ; 246 				iter=0;
1464  04c6 ae0000        	ldw	x,#0
1465  04c9 1f37          	ldw	(OFST-1,sp),x
1466  04cb ae0000        	ldw	x,#0
1467  04ce 1f35          	ldw	(OFST-3,sp),x
1469  04d0               L354:
1470                     ; 249 					ADC1_StartConversion();
1472  04d0 cd0000        	call	_ADC1_StartConversion
1475  04d3               L364:
1476                     ; 250 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1478  04d3 a680          	ld	a,#128
1479  04d5 cd0000        	call	_ADC1_GetFlagStatus
1481  04d8 4d            	tnz	a
1482  04d9 27f8          	jreq	L364
1483                     ; 252 					reading=ADC1->DRL;
1485  04db c65405        	ld	a,21509
1486  04de 6b2c          	ld	(OFST-12,sp),a
1488                     ; 253 					mean_sum += reading;
1490  04e0 7b2c          	ld	a,(OFST-12,sp)
1491  04e2 96            	ldw	x,sp
1492  04e3 1c0024        	addw	x,#OFST-20
1493  04e6 cd0000        	call	c_lgadc
1496                     ; 255 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1498  04e9 7b2c          	ld	a,(OFST-12,sp)
1499  04eb 1129          	cp	a,(OFST-15,sp)
1500  04ed 2306          	jrule	L24
1501  04ef 7b2c          	ld	a,(OFST-12,sp)
1502  04f1 1029          	sub	a,(OFST-15,sp)
1503  04f3 2004          	jra	L44
1504  04f5               L24:
1505  04f5 7b29          	ld	a,(OFST-15,sp)
1506  04f7 102c          	sub	a,(OFST-12,sp)
1507  04f9               L44:
1508  04f9 6b28          	ld	(OFST-16,sp),a
1510                     ; 256 					rms+=mean_diff>mean_threshold_8;
1512  04fb 7b28          	ld	a,(OFST-16,sp)
1513  04fd 1123          	cp	a,(OFST-21,sp)
1514  04ff 2305          	jrule	L64
1515  0501 ae0001        	ldw	x,#1
1516  0504 2001          	jra	L05
1517  0506               L64:
1518  0506 5f            	clrw	x
1519  0507               L05:
1520  0507 72fb33        	addw	x,(OFST-5,sp)
1521  050a 1f33          	ldw	(OFST-5,sp),x
1523                     ; 258 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1525  050c a680          	ld	a,#128
1526  050e cd0000        	call	_ADC1_ClearFlag
1528                     ; 261 					iter++;
1530  0511 96            	ldw	x,sp
1531  0512 1c0035        	addw	x,#OFST-3
1532  0515 a601          	ld	a,#1
1533  0517 cd0000        	call	c_lgadc
1536                     ; 262 					iter%=256;//8 bit unsigned
1538  051a 0f37          	clr	(OFST-1,sp)
1539  051c 0f36          	clr	(OFST-2,sp)
1540  051e 0f35          	clr	(OFST-3,sp)
1542                     ; 263 				}while(iter!=0);//run 255 times
1544  0520 96            	ldw	x,sp
1545  0521 1c0035        	addw	x,#OFST-3
1546  0524 cd0000        	call	c_lzmp
1548  0527 26a7          	jrne	L354
1549                     ; 264 				mean=((uint16_t)mean+mean_sum/256)/2;
1551  0529 96            	ldw	x,sp
1552  052a 1c0024        	addw	x,#OFST-20
1553  052d cd0000        	call	c_ltor
1555  0530 a608          	ld	a,#8
1556  0532 cd0000        	call	c_lursh
1558  0535 96            	ldw	x,sp
1559  0536 1c0001        	addw	x,#OFST-55
1560  0539 cd0000        	call	c_rtol
1563  053c 7b29          	ld	a,(OFST-15,sp)
1564  053e b703          	ld	c_lreg+3,a
1565  0540 3f02          	clr	c_lreg+2
1566  0542 3f01          	clr	c_lreg+1
1567  0544 3f00          	clr	c_lreg
1568  0546 96            	ldw	x,sp
1569  0547 1c0001        	addw	x,#OFST-55
1570  054a cd0000        	call	c_ladd
1572  054d 3400          	srl	c_lreg
1573  054f 3601          	rrc	c_lreg+1
1574  0551 3602          	rrc	c_lreg+2
1575  0553 3603          	rrc	c_lreg+3
1576  0555 b603          	ld	a,c_lreg+3
1577  0557 6b29          	ld	(OFST-15,sp),a
1579                     ; 265 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1581  0559 96            	ldw	x,sp
1582  055a 1c0009        	addw	x,#OFST-47
1583  055d 1f03          	ldw	(OFST-53,sp),x
1585  055f 1e33          	ldw	x,(OFST-5,sp)
1586  0561 54            	srlw	x
1587  0562 54            	srlw	x
1588  0563 54            	srlw	x
1589  0564 54            	srlw	x
1590  0565 72fb03        	addw	x,(OFST-53,sp)
1591  0568 f6            	ld	a,(x)
1592  0569 5f            	clrw	x
1593  056a 97            	ld	xl,a
1594  056b 1621          	ldw	y,(OFST-23,sp)
1595  056d cd0000        	call	c_imul
1597  0570 54            	srlw	x
1598  0571 54            	srlw	x
1599  0572 54            	srlw	x
1600  0573 54            	srlw	x
1601  0574 54            	srlw	x
1602  0575 72fb21        	addw	x,(OFST-23,sp)
1603  0578 54            	srlw	x
1604  0579 1f21          	ldw	(OFST-23,sp),x
1606                     ; 266 				mean_threshold_8=mean_threshold_16/256;
1608  057b 7b21          	ld	a,(OFST-23,sp)
1609  057d 6b23          	ld	(OFST-21,sp),a
1611                     ; 267 				if(mean_threshold_8==0)
1613  057f 0d23          	tnz	(OFST-21,sp)
1614  0581 2609          	jrne	L764
1615                     ; 269 					mean_threshold_8=1;
1617  0583 a601          	ld	a,#1
1618  0585 6b23          	ld	(OFST-21,sp),a
1620                     ; 270 					mean_threshold_16=0x0100;
1622  0587 ae0100        	ldw	x,#256
1623  058a 1f21          	ldw	(OFST-23,sp),x
1625  058c               L764:
1626                     ; 275 					if(mean==0) Serial_print_string("0");
1628  058c 0d29          	tnz	(OFST-15,sp)
1629  058e 2606          	jrne	L174
1632  0590 ae0104        	ldw	x,#L124
1633  0593 cd0827        	call	_Serial_print_string
1635  0596               L174:
1636                     ; 276 					Serial_print_int(mean);
1638  0596 7b29          	ld	a,(OFST-15,sp)
1639  0598 5f            	clrw	x
1640  0599 97            	ld	xl,a
1641  059a cd0850        	call	_Serial_print_int
1643                     ; 278 					Serial_print_string(" ");
1645  059d ae0100        	ldw	x,#L374
1646  05a0 cd0827        	call	_Serial_print_string
1648                     ; 281 					if(rms==0) Serial_print_string("0");
1650  05a3 1e33          	ldw	x,(OFST-5,sp)
1651  05a5 2606          	jrne	L574
1654  05a7 ae0104        	ldw	x,#L124
1655  05aa cd0827        	call	_Serial_print_string
1657  05ad               L574:
1658                     ; 282 					Serial_print_int(rms);
1660  05ad 1e33          	ldw	x,(OFST-5,sp)
1661  05af cd0850        	call	_Serial_print_int
1663                     ; 284 					Serial_print_string(" ");
1665  05b2 ae0100        	ldw	x,#L374
1666  05b5 cd0827        	call	_Serial_print_string
1668                     ; 285 					if(mean_threshold_8==0) Serial_print_string("0");
1670  05b8 0d23          	tnz	(OFST-21,sp)
1671  05ba 2606          	jrne	L774
1674  05bc ae0104        	ldw	x,#L124
1675  05bf cd0827        	call	_Serial_print_string
1677  05c2               L774:
1678                     ; 286 					Serial_print_int(mean_threshold_8);
1680  05c2 7b23          	ld	a,(OFST-21,sp)
1681  05c4 5f            	clrw	x
1682  05c5 97            	ld	xl,a
1683  05c6 cd0850        	call	_Serial_print_int
1685                     ; 288 					Serial_newline();
1687  05c9 cd08b3        	call	_Serial_newline
1690  05cc acb204b2      	jpf	L744
1691  05d0               L17:
1692                     ; 294 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1694  05d0 4b40          	push	#64
1695  05d2 4b20          	push	#32
1696  05d4 ae500f        	ldw	x,#20495
1697  05d7 cd0000        	call	_GPIO_Init
1699  05da 85            	popw	x
1700                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1702  05db 4b40          	push	#64
1703  05dd 4b40          	push	#64
1704  05df ae500f        	ldw	x,#20495
1705  05e2 cd0000        	call	_GPIO_Init
1707  05e5 85            	popw	x
1708  05e6               L105:
1709                     ; 298 			  setMatrixHighZ();
1711  05e6 cd08c2        	call	_setMatrixHighZ
1713                     ; 299 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1715  05e9 4b20          	push	#32
1716  05eb ae500f        	ldw	x,#20495
1717  05ee cd0000        	call	_GPIO_ReadInputPin
1719  05f1 5b01          	addw	sp,#1
1720  05f3 4d            	tnz	a
1721  05f4 2618          	jrne	L505
1722                     ; 303 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1724  05f6 4bd0          	push	#208
1725  05f8 4b08          	push	#8
1726  05fa ae500a        	ldw	x,#20490
1727  05fd cd0000        	call	_GPIO_Init
1729  0600 85            	popw	x
1730                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1732  0601 4bc0          	push	#192
1733  0603 4b20          	push	#32
1734  0605 ae500a        	ldw	x,#20490
1735  0608 cd0000        	call	_GPIO_Init
1737  060b 85            	popw	x
1739  060c 20d8          	jra	L105
1740  060e               L505:
1741                     ; 305 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1743  060e 4b40          	push	#64
1744  0610 ae500f        	ldw	x,#20495
1745  0613 cd0000        	call	_GPIO_ReadInputPin
1747  0616 5b01          	addw	sp,#1
1748  0618 4d            	tnz	a
1749  0619 26cb          	jrne	L105
1750                     ; 306 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1752  061b 4bd0          	push	#208
1753  061d 4b10          	push	#16
1754  061f ae500a        	ldw	x,#20490
1755  0622 cd0000        	call	_GPIO_Init
1757  0625 85            	popw	x
1758                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1760  0626 4bc0          	push	#192
1761  0628 4b40          	push	#64
1762  062a ae500a        	ldw	x,#20490
1763  062d cd0000        	call	_GPIO_Init
1765  0630 85            	popw	x
1766  0631 20b3          	jra	L105
1767  0633               L37:
1768                     ; 313 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1770  0633 c650c6        	ld	a,20678
1771  0636 a4e7          	and	a,#231
1772  0638 c750c6        	ld	20678,a
1773                     ; 315 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1775  063b 4bf0          	push	#240
1776  063d 4b20          	push	#32
1777  063f ae500f        	ldw	x,#20495
1778  0642 cd0000        	call	_GPIO_Init
1780  0645 85            	popw	x
1781                     ; 316 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1783  0646 4b40          	push	#64
1784  0648 4b40          	push	#64
1785  064a ae500f        	ldw	x,#20495
1786  064d cd0000        	call	_GPIO_Init
1788  0650 85            	popw	x
1789                     ; 317 			UART1_DeInit();
1791  0651 cd0000        	call	_UART1_DeInit
1793                     ; 318 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1795  0654 4b0c          	push	#12
1796  0656 4b80          	push	#128
1797  0658 4b00          	push	#0
1798  065a 4b00          	push	#0
1799  065c 4b00          	push	#0
1800  065e ae4240        	ldw	x,#16960
1801  0661 89            	pushw	x
1802  0662 ae000f        	ldw	x,#15
1803  0665 89            	pushw	x
1804  0666 cd0000        	call	_UART1_Init
1806  0669 5b09          	addw	sp,#9
1807                     ; 320 			UART1_Cmd(ENABLE);
1809  066b a601          	ld	a,#1
1810  066d cd0000        	call	_UART1_Cmd
1812                     ; 322 			Serial_print_string("Mode: ");
1814  0670 ae00f9        	ldw	x,#L315
1815  0673 cd0827        	call	_Serial_print_string
1817                     ; 323 			Serial_print_int(test_mode);
1819  0676 1e33          	ldw	x,(OFST-5,sp)
1820  0678 cd0850        	call	_Serial_print_int
1822                     ; 324 			Serial_newline();
1824  067b cd08b3        	call	_Serial_newline
1826                     ; 327 			Serial_print_string("Params v2: ");
1828  067e ae00ed        	ldw	x,#L515
1829  0681 cd0827        	call	_Serial_print_string
1831                     ; 334 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1833  0684 c650c6        	ld	a,20678
1834  0687 5f            	clrw	x
1835  0688 97            	ld	xl,a
1836  0689 cd0850        	call	_Serial_print_int
1838                     ; 335 			Serial_print_string(" ");
1840  068c ae0100        	ldw	x,#L374
1841  068f cd0827        	call	_Serial_print_string
1843                     ; 336 			Serial_print_int(CLK->CCOR);//0
1845  0692 c650c9        	ld	a,20681
1846  0695 5f            	clrw	x
1847  0696 97            	ld	xl,a
1848  0697 cd0850        	call	_Serial_print_int
1850                     ; 337 			Serial_newline();
1852  069a cd08b3        	call	_Serial_newline
1854                     ; 339 			TIM4->PSCR= 7;// init divider register /128	
1856  069d 35075347      	mov	21319,#7
1857                     ; 340 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1859  06a1 357d5348      	mov	21320,#125
1860                     ; 341 			TIM4->EGR= TIM4_EGR_UG;// update registers
1862  06a5 35015345      	mov	21317,#1
1863                     ; 342 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1865  06a9 c65340        	ld	a,21312
1866  06ac aa85          	or	a,#133
1867  06ae c75340        	ld	21312,a
1868                     ; 343 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1870  06b1 35015343      	mov	21315,#1
1871                     ; 344 			enableInterrupts();
1874  06b5 9a            rim
1876  06b6               L715:
1877                     ; 347 				if(tms%1000==0 && mean_sum!=tms/1000)
1879  06b6 ae0000        	ldw	x,#_tms
1880  06b9 cd0000        	call	c_ltor
1882  06bc ae0018        	ldw	x,#L42
1883  06bf cd0000        	call	c_lumd
1885  06c2 cd0000        	call	c_lrzmp
1887  06c5 2642          	jrne	L325
1889  06c7 ae0000        	ldw	x,#_tms
1890  06ca cd0000        	call	c_ltor
1892  06cd ae0018        	ldw	x,#L42
1893  06d0 cd0000        	call	c_ludv
1895  06d3 96            	ldw	x,sp
1896  06d4 1c0024        	addw	x,#OFST-20
1897  06d7 cd0000        	call	c_lcmp
1899  06da 272d          	jreq	L325
1900                     ; 349 					Serial_print_string("time: ");
1902  06dc ae00e6        	ldw	x,#L525
1903  06df cd0827        	call	_Serial_print_string
1905                     ; 350 					mean_sum=tms/1000;
1907  06e2 ae0000        	ldw	x,#_tms
1908  06e5 cd0000        	call	c_ltor
1910  06e8 ae0018        	ldw	x,#L42
1911  06eb cd0000        	call	c_ludv
1913  06ee 96            	ldw	x,sp
1914  06ef 1c0024        	addw	x,#OFST-20
1915  06f2 cd0000        	call	c_rtol
1918                     ; 351 					Serial_print_int(tms/1000);
1920  06f5 ae0000        	ldw	x,#_tms
1921  06f8 cd0000        	call	c_ltor
1923  06fb ae0018        	ldw	x,#L42
1924  06fe cd0000        	call	c_ludv
1926  0701 be02          	ldw	x,c_lreg+2
1927  0703 cd0850        	call	_Serial_print_int
1929                     ; 352 					Serial_newline();
1931  0706 cd08b3        	call	_Serial_newline
1933  0709               L325:
1934                     ; 360 				setMatrixHighZ();
1936  0709 cd08c2        	call	_setMatrixHighZ
1938                     ; 361 				mean_low=tms%20;
1940  070c ae0000        	ldw	x,#_tms
1941  070f cd0000        	call	c_ltor
1943  0712 ae0020        	ldw	x,#L25
1944  0715 cd0000        	call	c_lumd
1946  0718 96            	ldw	x,sp
1947  0719 1c001d        	addw	x,#OFST-27
1948  071c cd0000        	call	c_rtol
1951                     ; 362 				mean_high=(tms/20)%100;
1953  071f ae0000        	ldw	x,#_tms
1954  0722 cd0000        	call	c_ltor
1956  0725 ae0020        	ldw	x,#L25
1957  0728 cd0000        	call	c_ludv
1959  072b ae0024        	ldw	x,#L45
1960  072e cd0000        	call	c_lumd
1962  0731 96            	ldw	x,sp
1963  0732 1c002f        	addw	x,#OFST-9
1964  0735 cd0000        	call	c_rtol
1967                     ; 363 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
1969  0738 ae0000        	ldw	x,#_tms
1970  073b cd0000        	call	c_ltor
1972  073e ae0028        	ldw	x,#L65
1973  0741 cd0000        	call	c_ludv
1975  0744 b603          	ld	a,c_lreg+3
1976  0746 a401          	and	a,#1
1977  0748 b703          	ld	c_lreg+3,a
1978  074a 3f02          	clr	c_lreg+2
1979  074c 3f01          	clr	c_lreg+1
1980  074e 3f00          	clr	c_lreg
1981  0750 96            	ldw	x,sp
1982  0751 1c0001        	addw	x,#OFST-55
1983  0754 cd0000        	call	c_rtol
1986  0757 96            	ldw	x,sp
1987  0758 1c002f        	addw	x,#OFST-9
1988  075b cd0000        	call	c_ltor
1990  075e a602          	ld	a,#2
1991  0760 cd0000        	call	c_lursh
1993  0763 96            	ldw	x,sp
1994  0764 1c001d        	addw	x,#OFST-27
1995  0767 cd0000        	call	c_lcmp
1997  076a 2405          	jruge	L06
1998  076c ae0001        	ldw	x,#1
1999  076f 2001          	jra	L26
2000  0771               L06:
2001  0771 5f            	clrw	x
2002  0772               L26:
2003  0772 cd0000        	call	c_itolx
2005  0775 96            	ldw	x,sp
2006  0776 1c0001        	addw	x,#OFST-55
2007  0779 cd0000        	call	c_lxor
2009  077c cd0000        	call	c_lrzmp
2011  077f 270f          	jreq	L725
2012                     ; 365 					setRGB(4,1);
2014  0781 ae0001        	ldw	x,#1
2015  0784 89            	pushw	x
2016  0785 ae0004        	ldw	x,#4
2017  0788 cd08d9        	call	_setRGB
2019  078b 85            	popw	x
2021  078c acb606b6      	jpf	L715
2022  0790               L725:
2023                     ; 368 					setRGB(4,0);
2025  0790 5f            	clrw	x
2026  0791 89            	pushw	x
2027  0792 ae0004        	ldw	x,#4
2028  0795 cd08d9        	call	_setRGB
2030  0798 85            	popw	x
2031  0799 acb606b6      	jpf	L715
2032  079d               L57:
2033                     ; 374 			Serial_print_string("Mode: ");
2035  079d ae00f9        	ldw	x,#L315
2036  07a0 cd0827        	call	_Serial_print_string
2038                     ; 375 			Serial_print_int(test_mode);
2040  07a3 1e33          	ldw	x,(OFST-5,sp)
2041  07a5 cd0850        	call	_Serial_print_int
2043                     ; 376 			Serial_newline();
2045  07a8 cd08b3        	call	_Serial_newline
2047                     ; 380 			Serial_print_string("Params: ");
2049  07ab ae00dd        	ldw	x,#L335
2050  07ae ad77          	call	_Serial_print_string
2052                     ; 381 			Serial_print_int(CLK->CKDIVR);//
2054  07b0 c650c6        	ld	a,20678
2055  07b3 5f            	clrw	x
2056  07b4 97            	ld	xl,a
2057  07b5 cd0850        	call	_Serial_print_int
2059                     ; 382 			Serial_print_string(" ");
2061  07b8 ae0100        	ldw	x,#L374
2062  07bb ad6a          	call	_Serial_print_string
2064                     ; 383 			Serial_print_int(CLK->CCOR);//
2066  07bd c650c9        	ld	a,20681
2067  07c0 5f            	clrw	x
2068  07c1 97            	ld	xl,a
2069  07c2 cd0850        	call	_Serial_print_int
2071                     ; 384 			Serial_newline();
2073  07c5 cd08b3        	call	_Serial_newline
2075                     ; 386 			TIM4->PSCR= 7;// init divider register /128	
2077  07c8 35075347      	mov	21319,#7
2078                     ; 387 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2080  07cc 35805348      	mov	21320,#128
2081                     ; 388 			TIM4->EGR= TIM4_EGR_UG;// update registers
2083  07d0 35015345      	mov	21317,#1
2084                     ; 389 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2086  07d4 c65340        	ld	a,21312
2087  07d7 aa85          	or	a,#133
2088  07d9 c75340        	ld	21312,a
2089                     ; 390 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2091  07dc 35015343      	mov	21315,#1
2092                     ; 391 			enableInterrupts();
2095  07e0 9a            rim
2097  07e1               L535:
2098                     ; 394 				for(iter=0;iter<5000;iter++){}
2100  07e1 ae0000        	ldw	x,#0
2101  07e4 1f37          	ldw	(OFST-1,sp),x
2102  07e6 ae0000        	ldw	x,#0
2103  07e9 1f35          	ldw	(OFST-3,sp),x
2105  07eb               L145:
2108  07eb 96            	ldw	x,sp
2109  07ec 1c0035        	addw	x,#OFST-3
2110  07ef a601          	ld	a,#1
2111  07f1 cd0000        	call	c_lgadc
2116  07f4 96            	ldw	x,sp
2117  07f5 1c0035        	addw	x,#OFST-3
2118  07f8 cd0000        	call	c_ltor
2120  07fb ae002c        	ldw	x,#L46
2121  07fe cd0000        	call	c_lcmp
2123  0801 25e8          	jrult	L145
2124                     ; 395 				Serial_print_string("time: ");
2126  0803 ae00e6        	ldw	x,#L525
2127  0806 ad1f          	call	_Serial_print_string
2129                     ; 396 				Serial_print_int(tms>>16);
2131  0808 be00          	ldw	x,_tms
2132  080a ad44          	call	_Serial_print_int
2134                     ; 397 				Serial_print_string(" ");
2136  080c ae0100        	ldw	x,#L374
2137  080f ad16          	call	_Serial_print_string
2139                     ; 398 				Serial_print_int((uint16_t)tms);
2141  0811 be02          	ldw	x,_tms+2
2142  0813 ad3b          	call	_Serial_print_int
2144                     ; 399 				Serial_newline();
2146  0815 cd08b3        	call	_Serial_newline
2149  0818 20c7          	jra	L535
2174                     ; 406 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2176                     	switch	.text
2177  081a               f_TIM4_UPD_OVF_IRQHandler:
2181                     ; 407 	TIM4->SR1&=~TIM4_SR1_UIF;
2183  081a 72115344      	bres	21316,#0
2184                     ; 408 	tms++;
2186  081e ae0000        	ldw	x,#_tms
2187  0821 a601          	ld	a,#1
2188  0823 cd0000        	call	c_lgadc
2190                     ; 409 }
2193  0826 80            	iret
2239                     ; 432  void Serial_print_string (char string[])
2239                     ; 433  {
2241                     	switch	.text
2242  0827               _Serial_print_string:
2244  0827 89            	pushw	x
2245  0828 88            	push	a
2246       00000001      OFST:	set	1
2249                     ; 435 	 char i=0;
2251  0829 0f01          	clr	(OFST+0,sp)
2254  082b 2016          	jra	L506
2255  082d               L106:
2256                     ; 439 		UART1_SendData8(string[i]);
2258  082d 7b01          	ld	a,(OFST+0,sp)
2259  082f 5f            	clrw	x
2260  0830 97            	ld	xl,a
2261  0831 72fb02        	addw	x,(OFST+1,sp)
2262  0834 f6            	ld	a,(x)
2263  0835 cd0000        	call	_UART1_SendData8
2266  0838               L316:
2267                     ; 440 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2269  0838 ae0080        	ldw	x,#128
2270  083b cd0000        	call	_UART1_GetFlagStatus
2272  083e 4d            	tnz	a
2273  083f 27f7          	jreq	L316
2274                     ; 441 		i++;
2276  0841 0c01          	inc	(OFST+0,sp)
2278  0843               L506:
2279                     ; 437 	 while (string[i] != 0x00)
2281  0843 7b01          	ld	a,(OFST+0,sp)
2282  0845 5f            	clrw	x
2283  0846 97            	ld	xl,a
2284  0847 72fb02        	addw	x,(OFST+1,sp)
2285  084a 7d            	tnz	(x)
2286  084b 26e0          	jrne	L106
2287                     ; 443  }
2290  084d 5b03          	addw	sp,#3
2291  084f 81            	ret
2294                     	switch	.const
2295  0030               L716_digit:
2296  0030 00            	dc.b	0
2297  0031 00000000      	ds.b	4
2350                     ; 445  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2350                     ; 446  {
2351                     	switch	.text
2352  0850               _Serial_print_int:
2354  0850 89            	pushw	x
2355  0851 5208          	subw	sp,#8
2356       00000008      OFST:	set	8
2359                     ; 447 	 char count = 0;
2361  0853 0f08          	clr	(OFST+0,sp)
2363                     ; 448 	 char digit[5] = "";
2365  0855 96            	ldw	x,sp
2366  0856 1c0003        	addw	x,#OFST-5
2367  0859 90ae0030      	ldw	y,#L716_digit
2368  085d a605          	ld	a,#5
2369  085f cd0000        	call	c_xymov
2372  0862 2023          	jra	L356
2373  0864               L746:
2374                     ; 452 		 digit[count] = number%10;
2376  0864 96            	ldw	x,sp
2377  0865 1c0003        	addw	x,#OFST-5
2378  0868 9f            	ld	a,xl
2379  0869 5e            	swapw	x
2380  086a 1b08          	add	a,(OFST+0,sp)
2381  086c 2401          	jrnc	L211
2382  086e 5c            	incw	x
2383  086f               L211:
2384  086f 02            	rlwa	x,a
2385  0870 1609          	ldw	y,(OFST+1,sp)
2386  0872 a60a          	ld	a,#10
2387  0874 cd0000        	call	c_smody
2389  0877 9001          	rrwa	y,a
2390  0879 f7            	ld	(x),a
2391  087a 9002          	rlwa	y,a
2392                     ; 453 		 count++;
2394  087c 0c08          	inc	(OFST+0,sp)
2396                     ; 454 		 number = number/10;
2398  087e 1e09          	ldw	x,(OFST+1,sp)
2399  0880 a60a          	ld	a,#10
2400  0882 cd0000        	call	c_sdivx
2402  0885 1f09          	ldw	(OFST+1,sp),x
2403  0887               L356:
2404                     ; 450 	 while (number != 0) //split the int to char array 
2406  0887 1e09          	ldw	x,(OFST+1,sp)
2407  0889 26d9          	jrne	L746
2409  088b 201f          	jra	L166
2410  088d               L756:
2411                     ; 459 		UART1_SendData8(digit[count-1] + 0x30);
2413  088d 96            	ldw	x,sp
2414  088e 1c0003        	addw	x,#OFST-5
2415  0891 1f01          	ldw	(OFST-7,sp),x
2417  0893 7b08          	ld	a,(OFST+0,sp)
2418  0895 5f            	clrw	x
2419  0896 97            	ld	xl,a
2420  0897 5a            	decw	x
2421  0898 72fb01        	addw	x,(OFST-7,sp)
2422  089b f6            	ld	a,(x)
2423  089c ab30          	add	a,#48
2424  089e cd0000        	call	_UART1_SendData8
2427  08a1               L766:
2428                     ; 460 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2430  08a1 ae0080        	ldw	x,#128
2431  08a4 cd0000        	call	_UART1_GetFlagStatus
2433  08a7 4d            	tnz	a
2434  08a8 27f7          	jreq	L766
2435                     ; 461 		count--; 
2437  08aa 0a08          	dec	(OFST+0,sp)
2439  08ac               L166:
2440                     ; 457 	 while (count !=0) //print char array in correct direction 
2442  08ac 0d08          	tnz	(OFST+0,sp)
2443  08ae 26dd          	jrne	L756
2444                     ; 463  }
2447  08b0 5b0a          	addw	sp,#10
2448  08b2 81            	ret
2473                     ; 465  void Serial_newline(void)
2473                     ; 466  {
2474                     	switch	.text
2475  08b3               _Serial_newline:
2479                     ; 467 	 UART1_SendData8(0x0a);
2481  08b3 a60a          	ld	a,#10
2482  08b5 cd0000        	call	_UART1_SendData8
2485  08b8               L507:
2486                     ; 468 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2488  08b8 ae0080        	ldw	x,#128
2489  08bb cd0000        	call	_UART1_GetFlagStatus
2491  08be 4d            	tnz	a
2492  08bf 27f7          	jreq	L507
2493                     ; 469  }
2496  08c1 81            	ret
2520                     ; 471 void setMatrixHighZ()
2520                     ; 472 {
2521                     	switch	.text
2522  08c2               _setMatrixHighZ:
2526                     ; 477 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2528  08c2 4b00          	push	#0
2529  08c4 4bf8          	push	#248
2530  08c6 ae500a        	ldw	x,#20490
2531  08c9 cd0000        	call	_GPIO_Init
2533  08cc 85            	popw	x
2534                     ; 478 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2536  08cd 4b00          	push	#0
2537  08cf 4b0c          	push	#12
2538  08d1 ae500f        	ldw	x,#20495
2539  08d4 cd0000        	call	_GPIO_Init
2541  08d7 85            	popw	x
2542                     ; 479 }
2545  08d8 81            	ret
2589                     ; 481 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2590                     	switch	.text
2591  08d9               _setRGB:
2593  08d9 89            	pushw	x
2594       00000000      OFST:	set	0
2599  08da 1e05          	ldw	x,(OFST+5,sp)
2600  08dc 89            	pushw	x
2601  08dd 1e03          	ldw	x,(OFST+3,sp)
2602  08df 89            	pushw	x
2603  08e0 a601          	ld	a,#1
2604  08e2 ad11          	call	_setLED
2606  08e4 5b04          	addw	sp,#4
2610  08e6 85            	popw	x
2611  08e7 81            	ret
2646                     ; 482 void setWhite(int led_index){ setLED(0,led_index,0); }
2647                     	switch	.text
2648  08e8               _setWhite:
2650  08e8 89            	pushw	x
2651       00000000      OFST:	set	0
2656  08e9 5f            	clrw	x
2657  08ea 89            	pushw	x
2658  08eb 1e03          	ldw	x,(OFST+3,sp)
2659  08ed 89            	pushw	x
2660  08ee 4f            	clr	a
2661  08ef ad04          	call	_setLED
2663  08f1 5b04          	addw	sp,#4
2667  08f3 85            	popw	x
2668  08f4 81            	ret
2671                     	switch	.const
2672  0035               L167_rgb_lookup:
2673  0035 0000          	dc.w	0
2674  0037 0001          	dc.w	1
2675  0039 0000          	dc.w	0
2676  003b 0002          	dc.w	2
2677  003d 0001          	dc.w	1
2678  003f 0002          	dc.w	2
2679  0041 0001          	dc.w	1
2680  0043 0000          	dc.w	0
2681  0045 0002          	dc.w	2
2682  0047 0000          	dc.w	0
2683  0049 0002          	dc.w	2
2684  004b 0001          	dc.w	1
2685  004d 0005          	dc.w	5
2686  004f 0000          	dc.w	0
2687  0051 0005          	dc.w	5
2688  0053 0001          	dc.w	1
2689  0055 0005          	dc.w	5
2690  0057 0002          	dc.w	2
2691  0059 0006          	dc.w	6
2692  005b 0000          	dc.w	0
2693  005d 0006          	dc.w	6
2694  005f 0001          	dc.w	1
2695  0061 0006          	dc.w	6
2696  0063 0002          	dc.w	2
2697  0065 0006          	dc.w	6
2698  0067 0005          	dc.w	5
2699  0069 0006          	dc.w	6
2700  006b 0004          	dc.w	4
2701  006d 0005          	dc.w	5
2702  006f 0004          	dc.w	4
2703  0071 0004          	dc.w	4
2704  0073 0003          	dc.w	3
2705  0075 0005          	dc.w	5
2706  0077 0003          	dc.w	3
2707  0079 0006          	dc.w	6
2708  007b 0003          	dc.w	3
2709  007d 0003          	dc.w	3
2710  007f 0004          	dc.w	4
2711  0081 0003          	dc.w	3
2712  0083 0005          	dc.w	5
2713  0085 0003          	dc.w	3
2714  0087 0006          	dc.w	6
2715  0089 0000          	dc.w	0
2716  008b 0005          	dc.w	5
2717  008d 0000          	dc.w	0
2718  008f 0006          	dc.w	6
2719  0091 0001          	dc.w	1
2720  0093 0006          	dc.w	6
2721  0095 0000          	dc.w	0
2722  0097 0004          	dc.w	4
2723  0099 0001          	dc.w	1
2724  009b 0004          	dc.w	4
2725  009d 0002          	dc.w	2
2726  009f 0004          	dc.w	4
2727  00a1 0000          	dc.w	0
2728  00a3 0003          	dc.w	3
2729  00a5 0001          	dc.w	1
2730  00a7 0003          	dc.w	3
2731  00a9 0002          	dc.w	2
2732  00ab 0003          	dc.w	3
2733  00ad               L367_white_lookup:
2734  00ad 0003          	dc.w	3
2735  00af 0000          	dc.w	0
2736  00b1 0003          	dc.w	3
2737  00b3 0001          	dc.w	1
2738  00b5 0003          	dc.w	3
2739  00b7 0002          	dc.w	2
2740  00b9 0004          	dc.w	4
2741  00bb 0000          	dc.w	0
2742  00bd 0001          	dc.w	1
2743  00bf 0005          	dc.w	5
2744  00c1 0002          	dc.w	2
2745  00c3 0005          	dc.w	5
2746  00c5 0004          	dc.w	4
2747  00c7 0001          	dc.w	1
2748  00c9 0004          	dc.w	4
2749  00cb 0002          	dc.w	2
2750  00cd 0002          	dc.w	2
2751  00cf 0006          	dc.w	6
2752  00d1 0004          	dc.w	4
2753  00d3 0006          	dc.w	6
2754  00d5 0004          	dc.w	4
2755  00d7 0005          	dc.w	5
2756  00d9 0005          	dc.w	5
2757  00db 0006          	dc.w	6
3019                     ; 484 void setLED(bool is_rgb,int led_index,int rgb_index)
3019                     ; 485 {
3020                     	switch	.text
3021  08f5               _setLED:
3023  08f5 88            	push	a
3024  08f6 52b6          	subw	sp,#182
3025       000000b6      OFST:	set	182
3028                     ; 486   const unsigned short rgb_lookup[10][3][2]={
3028                     ; 487 		{{0,1},{0,2},{1,2}},//7
3028                     ; 488 		{{1,0},{2,0},{2,1}},//3
3028                     ; 489 		{{5,0},{5,1},{5,2}},//1
3028                     ; 490 		{{6,0},{6,1},{6,2}},//20
3028                     ; 491 		{{6,5},{6,4},{5,4}},//22
3028                     ; 492 		{{4,3},{5,3},{6,3}},//23
3028                     ; 493 		{{3,4},{3,5},{3,6}},//21
3028                     ; 494 		{{0,5},{0,6},{1,6}},//19
3028                     ; 495 		{{0,4},{1,4},{2,4}},//18
3028                     ; 496 		{{0,3},{1,3},{2,3}} //2
3028                     ; 497 	};
3030  08f8 96            	ldw	x,sp
3031  08f9 1c000e        	addw	x,#OFST-168
3032  08fc 90ae0035      	ldw	y,#L167_rgb_lookup
3033  0900 a678          	ld	a,#120
3034  0902 cd0000        	call	c_xymov
3036                     ; 498 	const unsigned short white_lookup[12][2]={
3036                     ; 499 		{3,0},//6
3036                     ; 500 		{3,1},//4
3036                     ; 501 		{3,2},//5
3036                     ; 502 		{4,0},//14
3036                     ; 503 		{1,5},//8
3036                     ; 504 		{2,5},//9
3036                     ; 505 		{4,1},//10
3036                     ; 506 		{4,2},//16
3036                     ; 507 		{2,6},//17
3036                     ; 508 		{4,6},//12
3036                     ; 509 		{4,5},//13
3036                     ; 510 		{5,6} //11
3036                     ; 511 	};
3038  0905 96            	ldw	x,sp
3039  0906 1c0086        	addw	x,#OFST-48
3040  0909 90ae00ad      	ldw	y,#L367_white_lookup
3041  090d a630          	ld	a,#48
3042  090f cd0000        	call	c_xymov
3044                     ; 512 	bool is_low=0;
3046  0912 0fb6          	clr	(OFST+0,sp)
3048  0914               L3511:
3049                     ; 516 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3051  0914 0db7          	tnz	(OFST+1,sp)
3052  0916 2726          	jreq	L621
3053  0918 7bb6          	ld	a,(OFST+0,sp)
3054  091a 5f            	clrw	x
3055  091b 97            	ld	xl,a
3056  091c 58            	sllw	x
3057  091d 1f09          	ldw	(OFST-173,sp),x
3059  091f 1ebc          	ldw	x,(OFST+6,sp)
3060  0921 58            	sllw	x
3061  0922 58            	sllw	x
3062  0923 1f07          	ldw	(OFST-175,sp),x
3064  0925 96            	ldw	x,sp
3065  0926 1c000e        	addw	x,#OFST-168
3066  0929 1f05          	ldw	(OFST-177,sp),x
3068  092b 1eba          	ldw	x,(OFST+4,sp)
3069  092d a60c          	ld	a,#12
3070  092f cd0000        	call	c_bmulx
3072  0932 72fb05        	addw	x,(OFST-177,sp)
3073  0935 72fb07        	addw	x,(OFST-175,sp)
3074  0938 72fb09        	addw	x,(OFST-173,sp)
3075  093b fe            	ldw	x,(x)
3076  093c 2018          	jra	L031
3077  093e               L621:
3078  093e 7bb6          	ld	a,(OFST+0,sp)
3079  0940 5f            	clrw	x
3080  0941 97            	ld	xl,a
3081  0942 58            	sllw	x
3082  0943 1f03          	ldw	(OFST-179,sp),x
3084  0945 96            	ldw	x,sp
3085  0946 1c0086        	addw	x,#OFST-48
3086  0949 1f01          	ldw	(OFST-181,sp),x
3088  094b 1eba          	ldw	x,(OFST+4,sp)
3089  094d 58            	sllw	x
3090  094e 58            	sllw	x
3091  094f 72fb01        	addw	x,(OFST-181,sp)
3092  0952 72fb03        	addw	x,(OFST-179,sp)
3093  0955 fe            	ldw	x,(x)
3094  0956               L031:
3096                     ; 548 			}break;
3097  0956 5d            	tnzw	x
3098  0957 2714          	jreq	L567
3099  0959 5a            	decw	x
3100  095a 271c          	jreq	L767
3101  095c 5a            	decw	x
3102  095d 2724          	jreq	L177
3103  095f 5a            	decw	x
3104  0960 272c          	jreq	L377
3105  0962 5a            	decw	x
3106  0963 2734          	jreq	L577
3107  0965 5a            	decw	x
3108  0966 273c          	jreq	L777
3109  0968 5a            	decw	x
3110  0969 2744          	jreq	L1001
3111  096b 204b          	jra	L3611
3112  096d               L567:
3113                     ; 519 				GPIOx=GPIOD;
3115  096d ae500f        	ldw	x,#20495
3116  0970 1f0b          	ldw	(OFST-171,sp),x
3118                     ; 520 				PortPin=GPIO_PIN_3;
3120  0972 a608          	ld	a,#8
3121  0974 6b0d          	ld	(OFST-169,sp),a
3123                     ; 521 			}break;
3125  0976 2040          	jra	L3611
3126  0978               L767:
3127                     ; 523 				GPIOx=GPIOD;
3129  0978 ae500f        	ldw	x,#20495
3130  097b 1f0b          	ldw	(OFST-171,sp),x
3132                     ; 524 				PortPin=GPIO_PIN_2;
3134  097d a604          	ld	a,#4
3135  097f 6b0d          	ld	(OFST-169,sp),a
3137                     ; 525 			}break;
3139  0981 2035          	jra	L3611
3140  0983               L177:
3141                     ; 527 				GPIOx=GPIOC;
3143  0983 ae500a        	ldw	x,#20490
3144  0986 1f0b          	ldw	(OFST-171,sp),x
3146                     ; 528 				PortPin=GPIO_PIN_7;
3148  0988 a680          	ld	a,#128
3149  098a 6b0d          	ld	(OFST-169,sp),a
3151                     ; 529 			}break;
3153  098c 202a          	jra	L3611
3154  098e               L377:
3155                     ; 531 				GPIOx=GPIOC;
3157  098e ae500a        	ldw	x,#20490
3158  0991 1f0b          	ldw	(OFST-171,sp),x
3160                     ; 532 				PortPin=GPIO_PIN_6;
3162  0993 a640          	ld	a,#64
3163  0995 6b0d          	ld	(OFST-169,sp),a
3165                     ; 533 			}break;
3167  0997 201f          	jra	L3611
3168  0999               L577:
3169                     ; 535 				GPIOx=GPIOC;
3171  0999 ae500a        	ldw	x,#20490
3172  099c 1f0b          	ldw	(OFST-171,sp),x
3174                     ; 536 				PortPin=GPIO_PIN_5;
3176  099e a620          	ld	a,#32
3177  09a0 6b0d          	ld	(OFST-169,sp),a
3179                     ; 537 			}break;
3181  09a2 2014          	jra	L3611
3182  09a4               L777:
3183                     ; 539 				GPIOx=GPIOC;
3185  09a4 ae500a        	ldw	x,#20490
3186  09a7 1f0b          	ldw	(OFST-171,sp),x
3188                     ; 540 				PortPin=GPIO_PIN_4;
3190  09a9 a610          	ld	a,#16
3191  09ab 6b0d          	ld	(OFST-169,sp),a
3193                     ; 541 			}break;
3195  09ad 2009          	jra	L3611
3196  09af               L1001:
3197                     ; 543 				GPIOx=GPIOC;
3199  09af ae500a        	ldw	x,#20490
3200  09b2 1f0b          	ldw	(OFST-171,sp),x
3202                     ; 544 				PortPin=GPIO_PIN_3;
3204  09b4 a608          	ld	a,#8
3205  09b6 6b0d          	ld	(OFST-169,sp),a
3207                     ; 545 			}break;
3209  09b8               L3611:
3210                     ; 550 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3212  09b8 0db6          	tnz	(OFST+0,sp)
3213  09ba 2704          	jreq	L231
3214  09bc a6c0          	ld	a,#192
3215  09be 2002          	jra	L431
3216  09c0               L231:
3217  09c0 a6d0          	ld	a,#208
3218  09c2               L431:
3219  09c2 88            	push	a
3220  09c3 7b0e          	ld	a,(OFST-168,sp)
3221  09c5 88            	push	a
3222  09c6 1e0d          	ldw	x,(OFST-169,sp)
3223  09c8 cd0000        	call	_GPIO_Init
3225  09cb 85            	popw	x
3226                     ; 551 		is_low=!is_low;
3228  09cc 0db6          	tnz	(OFST+0,sp)
3229  09ce 2604          	jrne	L631
3230  09d0 a601          	ld	a,#1
3231  09d2 2001          	jra	L041
3232  09d4               L631:
3233  09d4 4f            	clr	a
3234  09d5               L041:
3235  09d5 6bb6          	ld	(OFST+0,sp),a
3237                     ; 552 	}while(is_low);
3239  09d7 0db6          	tnz	(OFST+0,sp)
3240  09d9 2703          	jreq	L241
3241  09db cc0914        	jp	L3511
3242  09de               L241:
3243                     ; 553 }
3246  09de 5bb7          	addw	sp,#183
3247  09e0 81            	ret
3271                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3272                     	xdef	_main
3273                     	xdef	_Serial_print_string
3274                     	xdef	_Serial_newline
3275                     	xdef	_Serial_print_int
3276                     	xdef	_setWhite
3277                     	xdef	_setRGB
3278                     	xdef	_setLED
3279                     	xdef	_setMatrixHighZ
3280                     	xdef	_tms
3281                     	xdef	_ADC_Read
3282                     	xref	_UART1_GetFlagStatus
3283                     	xref	_UART1_SendData8
3284                     	xref	_UART1_Cmd
3285                     	xref	_UART1_Init
3286                     	xref	_UART1_DeInit
3287                     	xref	_GPIO_ReadInputPin
3288                     	xref	_GPIO_Init
3289                     	xref	_ADC1_ClearFlag
3290                     	xref	_ADC1_GetFlagStatus
3291                     	xref	_ADC1_GetConversionValue
3292                     	xref	_ADC1_StartConversion
3293                     	xref	_ADC1_Cmd
3294                     	xref	_ADC1_Init
3295                     	xref	_ADC1_DeInit
3296                     	switch	.const
3297  00dd               L335:
3298  00dd 506172616d73  	dc.b	"Params: ",0
3299  00e6               L525:
3300  00e6 74696d653a20  	dc.b	"time: ",0
3301  00ed               L515:
3302  00ed 506172616d73  	dc.b	"Params v2: ",0
3303  00f9               L315:
3304  00f9 4d6f64653a20  	dc.b	"Mode: ",0
3305  0100               L374:
3306  0100 2000          	dc.b	" ",0
3307  0102               L334:
3308  0102 2a00          	dc.b	"*",0
3309  0104               L124:
3310  0104 3000          	dc.b	"0",0
3311  0106               L353:
3312  0106 2c2000        	dc.b	", ",0
3313  0109               L153:
3314  0109 6164633a2000  	dc.b	"adc: ",0
3315  010f               L123:
3316  010f 636f756e7465  	dc.b	"counter: ",0
3317                     	xref.b	c_lreg
3318                     	xref.b	c_x
3319                     	xref.b	c_y
3339                     	xref	c_bmulx
3340                     	xref	c_sdivx
3341                     	xref	c_smody
3342                     	xref	c_lxor
3343                     	xref	c_itolx
3344                     	xref	c_lrzmp
3345                     	xref	c_lumd
3346                     	xref	c_imul
3347                     	xref	c_ladd
3348                     	xref	c_lursh
3349                     	xref	c_uitol
3350                     	xref	c_smodx
3351                     	xref	c_ludv
3352                     	xref	c_itol
3353                     	xref	c_rtol
3354                     	xref	c_uitolx
3355                     	xref	c_lzmp
3356                     	xref	c_lcmp
3357                     	xref	c_ltor
3358                     	xref	c_lgadc
3359                     	xref	c_xymov
3360                     	end
