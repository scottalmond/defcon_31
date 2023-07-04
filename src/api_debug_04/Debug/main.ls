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
 193                     .const:	section	.text
 194  0000               L75_rms_lookup:
 195  0000 09            	dc.b	9
 196  0001 12            	dc.b	18
 197  0002 1c            	dc.b	28
 198  0003 26            	dc.b	38
 199  0004 30            	dc.b	48
 200  0005 3a            	dc.b	58
 201  0006 45            	dc.b	69
 202  0007 50            	dc.b	80
 203  0008 5c            	dc.b	92
 204  0009 69            	dc.b	105
 205  000a 76            	dc.b	118
 206  000b 86            	dc.b	134
 207  000c 97            	dc.b	151
 208  000d ad            	dc.b	173
 209  000e c8            	dc.b	200
 210  000f f1            	dc.b	241
 458                     	switch	.const
 459  0010               L01:
 460  0010 00002710      	dc.l	10000
 461  0014               L21:
 462  0014 00007530      	dc.l	30000
 463  0018               L42:
 464  0018 000003e8      	dc.l	1000
 465  001c               L04:
 466  001c 0000000a      	dc.l	10
 467                     ; 18 int main()
 467                     ; 19 {
 468                     	switch	.text
 469  003e               _main:
 471  003e 5238          	subw	sp,#56
 472       00000038      OFST:	set	56
 475                     ; 42 	const int test_mode=4;
 477  0040 ae0004        	ldw	x,#4
 478  0043 1f33          	ldw	(OFST-5,sp),x
 480                     ; 43 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 482  0045 96            	ldw	x,sp
 483  0046 1c0009        	addw	x,#OFST-47
 484  0049 90ae0000      	ldw	y,#L75_rms_lookup
 485  004d a610          	ld	a,#16
 486  004f cd0000        	call	c_xymov
 488                     ; 45 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 496                     ; 46 	unsigned sound_level=0;
 498  0052 5f            	clrw	x
 499  0053 1f2a          	ldw	(OFST-14,sp),x
 501                     ; 47 	uint8_t mean_threshold=16;
 503  0055 a610          	ld	a,#16
 504  0057 6b28          	ld	(OFST-16,sp),a
 506                     ; 48 	uint8_t mean_threshold_8=1;
 508  0059 a601          	ld	a,#1
 509  005b 6b27          	ld	(OFST-17,sp),a
 511                     ; 49 	uint16_t mean_threshold_16=0x0100;
 513  005d ae0100        	ldw	x,#256
 514  0060 1f25          	ldw	(OFST-19,sp),x
 516                     ; 50 	unsigned int rms=0;
 518                     ; 51 	const long adc_captures=1<<8;
 520  0062 ae0100        	ldw	x,#256
 521  0065 1f23          	ldw	(OFST-21,sp),x
 522  0067 ae0000        	ldw	x,#0
 523  006a 1f21          	ldw	(OFST-23,sp),x
 525                     ; 53 	int debug=0;
 527  006c 5f            	clrw	x
 528  006d 1f2d          	ldw	(OFST-11,sp),x
 530                     ; 55 	for(rep=0;rep<1;rep++)
 532  006f ae0000        	ldw	x,#0
 533  0072 1f31          	ldw	(OFST-7,sp),x
 534  0074 ae0000        	ldw	x,#0
 535  0077 1f2f          	ldw	(OFST-9,sp),x
 537  0079               L542:
 538                     ; 56 		for(iter=0;iter<10000;iter++){}
 540  0079 ae0000        	ldw	x,#0
 541  007c 1f37          	ldw	(OFST-1,sp),x
 542  007e ae0000        	ldw	x,#0
 543  0081 1f35          	ldw	(OFST-3,sp),x
 545  0083               L352:
 548  0083 96            	ldw	x,sp
 549  0084 1c0035        	addw	x,#OFST-3
 550  0087 a601          	ld	a,#1
 551  0089 cd0000        	call	c_lgadc
 556  008c 96            	ldw	x,sp
 557  008d 1c0035        	addw	x,#OFST-3
 558  0090 cd0000        	call	c_ltor
 560  0093 ae0010        	ldw	x,#L01
 561  0096 cd0000        	call	c_lcmp
 563  0099 25e8          	jrult	L352
 564                     ; 55 	for(rep=0;rep<1;rep++)
 566  009b 96            	ldw	x,sp
 567  009c 1c002f        	addw	x,#OFST-9
 568  009f a601          	ld	a,#1
 569  00a1 cd0000        	call	c_lgadc
 574  00a4 96            	ldw	x,sp
 575  00a5 1c002f        	addw	x,#OFST-9
 576  00a8 cd0000        	call	c_lzmp
 578  00ab 27cc          	jreq	L542
 579                     ; 59 	if(test_mode<=3)
 581  00ad 9c            	rvf
 582  00ae 1e33          	ldw	x,(OFST-5,sp)
 583  00b0 a30004        	cpw	x,#4
 584  00b3 2e35          	jrsge	L162
 585                     ; 61 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 587  00b5 4bf0          	push	#240
 588  00b7 4b20          	push	#32
 589  00b9 ae500f        	ldw	x,#20495
 590  00bc cd0000        	call	_GPIO_Init
 592  00bf 85            	popw	x
 593                     ; 62 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 595  00c0 4b40          	push	#64
 596  00c2 4b40          	push	#64
 597  00c4 ae500f        	ldw	x,#20495
 598  00c7 cd0000        	call	_GPIO_Init
 600  00ca 85            	popw	x
 601                     ; 63 		UART1_DeInit();
 603  00cb cd0000        	call	_UART1_DeInit
 605                     ; 64 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 607  00ce 4b0c          	push	#12
 608  00d0 4b80          	push	#128
 609  00d2 4b00          	push	#0
 610  00d4 4b00          	push	#0
 611  00d6 4b00          	push	#0
 612  00d8 aec200        	ldw	x,#49664
 613  00db 89            	pushw	x
 614  00dc ae0001        	ldw	x,#1
 615  00df 89            	pushw	x
 616  00e0 cd0000        	call	_UART1_Init
 618  00e3 5b09          	addw	sp,#9
 619                     ; 66 		UART1_Cmd(ENABLE);
 621  00e5 a601          	ld	a,#1
 622  00e7 cd0000        	call	_UART1_Cmd
 624  00ea               L162:
 625                     ; 69 	switch(test_mode)
 627  00ea 1e33          	ldw	x,(OFST-5,sp)
 629                     ; 305 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
 630  00ec 5d            	tnzw	x
 631  00ed 271b          	jreq	L762
 632  00ef 5a            	decw	x
 633  00f0 2603          	jrne	L45
 634  00f2 cc01ae        	jp	L333
 635  00f5               L45:
 636  00f5 5a            	decw	x
 637  00f6 2603          	jrne	L65
 638  00f8 cc0264        	jp	L56
 639  00fb               L65:
 640  00fb 5a            	decw	x
 641  00fc 2603          	jrne	L06
 642  00fe cc047a        	jp	L76
 643  0101               L06:
 644  0101 5a            	decw	x
 645  0102 2603          	jrne	L26
 646  0104 cc05b2        	jp	L17
 647  0107               L26:
 648  0107               L25:
 649                     ; 311 }
 652  0107 5b38          	addw	sp,#56
 653  0109 81            	ret
 654  010a               L762:
 655                     ; 77 				for(rgb_index=0;rgb_index<3;rgb_index++)
 657  010a 5f            	clrw	x
 658  010b 1f2a          	ldw	(OFST-14,sp),x
 660  010d               L372:
 661                     ; 79 					for(led_index=0;led_index<10;led_index++)
 663  010d 5f            	clrw	x
 664  010e 1f33          	ldw	(OFST-5,sp),x
 666  0110               L103:
 667                     ; 81 						setMatrixHighZ();
 669  0110 cd06b0        	call	_setMatrixHighZ
 671                     ; 82 						setRGB(led_index,rgb_index);
 673  0113 1e2a          	ldw	x,(OFST-14,sp)
 674  0115 89            	pushw	x
 675  0116 1e35          	ldw	x,(OFST-3,sp)
 676  0118 cd06c7        	call	_setRGB
 678  011b 85            	popw	x
 679                     ; 83 						for(iter=0;iter<30000;iter++){}
 681  011c ae0000        	ldw	x,#0
 682  011f 1f37          	ldw	(OFST-1,sp),x
 683  0121 ae0000        	ldw	x,#0
 684  0124 1f35          	ldw	(OFST-3,sp),x
 686  0126               L703:
 689  0126 96            	ldw	x,sp
 690  0127 1c0035        	addw	x,#OFST-3
 691  012a a601          	ld	a,#1
 692  012c cd0000        	call	c_lgadc
 697  012f 96            	ldw	x,sp
 698  0130 1c0035        	addw	x,#OFST-3
 699  0133 cd0000        	call	c_ltor
 701  0136 ae0014        	ldw	x,#L21
 702  0139 cd0000        	call	c_lcmp
 704  013c 25e8          	jrult	L703
 705                     ; 84 						debug++;
 707  013e 1e2d          	ldw	x,(OFST-11,sp)
 708  0140 1c0001        	addw	x,#1
 709  0143 1f2d          	ldw	(OFST-11,sp),x
 711                     ; 91 							Serial_print_string("counter: ");
 713  0145 ae00dc        	ldw	x,#L513
 714  0148 cd0615        	call	_Serial_print_string
 716                     ; 92 							Serial_print_int(debug);
 718  014b 1e2d          	ldw	x,(OFST-11,sp)
 719  014d cd063e        	call	_Serial_print_int
 721                     ; 95 							Serial_newline();
 723  0150 cd06a1        	call	_Serial_newline
 725                     ; 79 					for(led_index=0;led_index<10;led_index++)
 727  0153 1e33          	ldw	x,(OFST-5,sp)
 728  0155 1c0001        	addw	x,#1
 729  0158 1f33          	ldw	(OFST-5,sp),x
 733  015a 1e33          	ldw	x,(OFST-5,sp)
 734  015c a3000a        	cpw	x,#10
 735  015f 25af          	jrult	L103
 736                     ; 77 				for(rgb_index=0;rgb_index<3;rgb_index++)
 738  0161 1e2a          	ldw	x,(OFST-14,sp)
 739  0163 1c0001        	addw	x,#1
 740  0166 1f2a          	ldw	(OFST-14,sp),x
 744  0168 1e2a          	ldw	x,(OFST-14,sp)
 745  016a a30003        	cpw	x,#3
 746  016d 259e          	jrult	L372
 747                     ; 99 				for(led_index=0;led_index<12;led_index++)
 749  016f 5f            	clrw	x
 750  0170 1f33          	ldw	(OFST-5,sp),x
 752  0172               L713:
 753                     ; 101 					setMatrixHighZ();
 755  0172 cd06b0        	call	_setMatrixHighZ
 757                     ; 102 					setWhite(led_index);
 759  0175 1e33          	ldw	x,(OFST-5,sp)
 760  0177 cd06d6        	call	_setWhite
 762                     ; 103 					for(iter=0;iter<30000;iter++){}
 764  017a ae0000        	ldw	x,#0
 765  017d 1f37          	ldw	(OFST-1,sp),x
 766  017f ae0000        	ldw	x,#0
 767  0182 1f35          	ldw	(OFST-3,sp),x
 769  0184               L523:
 772  0184 96            	ldw	x,sp
 773  0185 1c0035        	addw	x,#OFST-3
 774  0188 a601          	ld	a,#1
 775  018a cd0000        	call	c_lgadc
 780  018d 96            	ldw	x,sp
 781  018e 1c0035        	addw	x,#OFST-3
 782  0191 cd0000        	call	c_ltor
 784  0194 ae0014        	ldw	x,#L21
 785  0197 cd0000        	call	c_lcmp
 787  019a 25e8          	jrult	L523
 788                     ; 99 				for(led_index=0;led_index<12;led_index++)
 790  019c 1e33          	ldw	x,(OFST-5,sp)
 791  019e 1c0001        	addw	x,#1
 792  01a1 1f33          	ldw	(OFST-5,sp),x
 796  01a3 1e33          	ldw	x,(OFST-5,sp)
 797  01a5 a3000c        	cpw	x,#12
 798  01a8 25c8          	jrult	L713
 800  01aa ac0a010a      	jpf	L762
 801  01ae               L333:
 802                     ; 111 				rep=ADC_Read(AIN4);
 804  01ae a604          	ld	a,#4
 805  01b0 cd0000        	call	_ADC_Read
 807  01b3 cd0000        	call	c_uitolx
 809  01b6 96            	ldw	x,sp
 810  01b7 1c002f        	addw	x,#OFST-9
 811  01ba cd0000        	call	c_rtol
 814                     ; 112 				my_min=rep;
 816  01bd 1e31          	ldw	x,(OFST-7,sp)
 817  01bf 1f33          	ldw	(OFST-5,sp),x
 819                     ; 113 				my_max=rep;
 821  01c1 1e31          	ldw	x,(OFST-7,sp)
 822  01c3 1f2d          	ldw	(OFST-11,sp),x
 824                     ; 114 				for(iter=0;iter<1000;iter++)
 826  01c5 ae0000        	ldw	x,#0
 827  01c8 1f37          	ldw	(OFST-1,sp),x
 828  01ca ae0000        	ldw	x,#0
 829  01cd 1f35          	ldw	(OFST-3,sp),x
 831  01cf               L733:
 832                     ; 116 					rep=ADC_Read(AIN4);
 834  01cf a604          	ld	a,#4
 835  01d1 cd0000        	call	_ADC_Read
 837  01d4 cd0000        	call	c_uitolx
 839  01d7 96            	ldw	x,sp
 840  01d8 1c002f        	addw	x,#OFST-9
 841  01db cd0000        	call	c_rtol
 844                     ; 117 					my_min=my_min<rep?my_min:rep;
 846  01de 1e33          	ldw	x,(OFST-5,sp)
 847  01e0 cd0000        	call	c_uitolx
 849  01e3 96            	ldw	x,sp
 850  01e4 1c002f        	addw	x,#OFST-9
 851  01e7 cd0000        	call	c_lcmp
 853  01ea 2404          	jruge	L41
 854  01ec 1e33          	ldw	x,(OFST-5,sp)
 855  01ee 2002          	jra	L61
 856  01f0               L41:
 857  01f0 1e31          	ldw	x,(OFST-7,sp)
 858  01f2               L61:
 859  01f2 1f33          	ldw	(OFST-5,sp),x
 861                     ; 118 					my_max=my_max>rep?my_max:rep;
 863  01f4 1e2d          	ldw	x,(OFST-11,sp)
 864  01f6 cd0000        	call	c_uitolx
 866  01f9 96            	ldw	x,sp
 867  01fa 1c002f        	addw	x,#OFST-9
 868  01fd cd0000        	call	c_lcmp
 870  0200 2304          	jrule	L02
 871  0202 1e2d          	ldw	x,(OFST-11,sp)
 872  0204 2002          	jra	L22
 873  0206               L02:
 874  0206 1e31          	ldw	x,(OFST-7,sp)
 875  0208               L22:
 876  0208 1f2d          	ldw	(OFST-11,sp),x
 878                     ; 114 				for(iter=0;iter<1000;iter++)
 880  020a 96            	ldw	x,sp
 881  020b 1c0035        	addw	x,#OFST-3
 882  020e a601          	ld	a,#1
 883  0210 cd0000        	call	c_lgadc
 888  0213 96            	ldw	x,sp
 889  0214 1c0035        	addw	x,#OFST-3
 890  0217 cd0000        	call	c_ltor
 892  021a ae0018        	ldw	x,#L42
 893  021d cd0000        	call	c_lcmp
 895  0220 25ad          	jrult	L733
 896                     ; 120 				Serial_print_string("adc: ");
 898  0222 ae00d6        	ldw	x,#L543
 899  0225 cd0615        	call	_Serial_print_string
 901                     ; 121 				Serial_print_int(rep);
 903  0228 1e31          	ldw	x,(OFST-7,sp)
 904  022a cd063e        	call	_Serial_print_int
 906                     ; 122 				Serial_print_string(", ");
 908  022d ae00d3        	ldw	x,#L743
 909  0230 cd0615        	call	_Serial_print_string
 911                     ; 123 				Serial_print_int(my_max-my_min);
 913  0233 1e2d          	ldw	x,(OFST-11,sp)
 914  0235 72f033        	subw	x,(OFST-5,sp)
 915  0238 cd063e        	call	_Serial_print_int
 917                     ; 124 				Serial_newline();
 919  023b cd06a1        	call	_Serial_newline
 921                     ; 125 				for(iter=0;iter<10000;iter++){}
 923  023e ae0000        	ldw	x,#0
 924  0241 1f37          	ldw	(OFST-1,sp),x
 925  0243 ae0000        	ldw	x,#0
 926  0246 1f35          	ldw	(OFST-3,sp),x
 928  0248               L153:
 931  0248 96            	ldw	x,sp
 932  0249 1c0035        	addw	x,#OFST-3
 933  024c a601          	ld	a,#1
 934  024e cd0000        	call	c_lgadc
 939  0251 96            	ldw	x,sp
 940  0252 1c0035        	addw	x,#OFST-3
 941  0255 cd0000        	call	c_ltor
 943  0258 ae0010        	ldw	x,#L01
 944  025b cd0000        	call	c_lcmp
 946  025e 25e8          	jrult	L153
 948  0260 acae01ae      	jpf	L333
 949  0264               L56:
 950                     ; 130 			ADC1_DeInit();
 952  0264 cd0000        	call	_ADC1_DeInit
 954                     ; 131 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 954                     ; 132 							 AIN4,
 954                     ; 133 							 ADC1_PRESSEL_FCPU_D2,//D18 
 954                     ; 134 							 ADC1_EXTTRIG_TIM, 
 954                     ; 135 							 DISABLE, 
 954                     ; 136 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 954                     ; 137 							 ADC1_SCHMITTTRIG_ALL, 
 954                     ; 138 							 DISABLE);
 956  0267 4b00          	push	#0
 957  0269 4bff          	push	#255
 958  026b 4b08          	push	#8
 959  026d 4b00          	push	#0
 960  026f 4b00          	push	#0
 961  0271 4b00          	push	#0
 962  0273 ae0104        	ldw	x,#260
 963  0276 cd0000        	call	_ADC1_Init
 965  0279 5b06          	addw	sp,#6
 966                     ; 139 			ADC1_Cmd(ENABLE);
 968  027b a601          	ld	a,#1
 969  027d cd0000        	call	_ADC1_Cmd
 971  0280               L753:
 972                     ; 163 				rms=0;
 974  0280 5f            	clrw	x
 975  0281 1f33          	ldw	(OFST-5,sp),x
 977                     ; 165 				mean_sum=0;
 979  0283 ae0000        	ldw	x,#0
 980  0286 1f31          	ldw	(OFST-7,sp),x
 981  0288 ae0000        	ldw	x,#0
 982  028b 1f2f          	ldw	(OFST-9,sp),x
 984                     ; 166 				mean_low=mean+mean_threshold;
 986  028d 7b29          	ld	a,(OFST-15,sp)
 987  028f 5f            	clrw	x
 988  0290 1b28          	add	a,(OFST-16,sp)
 989  0292 2401          	jrnc	L62
 990  0294 5c            	incw	x
 991  0295               L62:
 992  0295 cd0000        	call	c_itol
 994  0298 96            	ldw	x,sp
 995  0299 1c0019        	addw	x,#OFST-31
 996  029c cd0000        	call	c_rtol
 999                     ; 167 				mean_high=mean-mean_threshold;
1001  029f 7b29          	ld	a,(OFST-15,sp)
1002  02a1 5f            	clrw	x
1003  02a2 1028          	sub	a,(OFST-16,sp)
1004  02a4 2401          	jrnc	L03
1005  02a6 5a            	decw	x
1006  02a7               L03:
1007  02a7 cd0000        	call	c_itol
1009  02aa 96            	ldw	x,sp
1010  02ab 1c001d        	addw	x,#OFST-27
1011  02ae cd0000        	call	c_rtol
1014                     ; 168 				for(iter=0;iter<adc_captures;iter++)
1016  02b1 ae0000        	ldw	x,#0
1017  02b4 1f37          	ldw	(OFST-1,sp),x
1018  02b6 ae0000        	ldw	x,#0
1019  02b9 1f35          	ldw	(OFST-3,sp),x
1022  02bb 2058          	jra	L763
1023  02bd               L363:
1024                     ; 171 					ADC1_StartConversion();
1026  02bd cd0000        	call	_ADC1_StartConversion
1029  02c0               L573:
1030                     ; 172 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1032  02c0 a680          	ld	a,#128
1033  02c2 cd0000        	call	_ADC1_GetFlagStatus
1035  02c5 4d            	tnz	a
1036  02c6 27f8          	jreq	L573
1037                     ; 174 					reading=ADC1->DRL;
1039  02c8 c65405        	ld	a,21509
1040  02cb 6b2c          	ld	(OFST-12,sp),a
1042                     ; 175 					mean_sum += reading;
1044  02cd 7b2c          	ld	a,(OFST-12,sp)
1045  02cf 96            	ldw	x,sp
1046  02d0 1c002f        	addw	x,#OFST-9
1047  02d3 cd0000        	call	c_lgadc
1050                     ; 176 					rms+=reading>mean_low || reading<mean_high;
1052  02d6 7b2c          	ld	a,(OFST-12,sp)
1053  02d8 b703          	ld	c_lreg+3,a
1054  02da 3f02          	clr	c_lreg+2
1055  02dc 3f01          	clr	c_lreg+1
1056  02de 3f00          	clr	c_lreg
1057  02e0 96            	ldw	x,sp
1058  02e1 1c0019        	addw	x,#OFST-31
1059  02e4 cd0000        	call	c_lcmp
1061  02e7 2213          	jrugt	L43
1062  02e9 7b2c          	ld	a,(OFST-12,sp)
1063  02eb b703          	ld	c_lreg+3,a
1064  02ed 3f02          	clr	c_lreg+2
1065  02ef 3f01          	clr	c_lreg+1
1066  02f1 3f00          	clr	c_lreg
1067  02f3 96            	ldw	x,sp
1068  02f4 1c001d        	addw	x,#OFST-27
1069  02f7 cd0000        	call	c_lcmp
1071  02fa 2405          	jruge	L23
1072  02fc               L43:
1073  02fc ae0001        	ldw	x,#1
1074  02ff 2001          	jra	L63
1075  0301               L23:
1076  0301 5f            	clrw	x
1077  0302               L63:
1078  0302 72fb33        	addw	x,(OFST-5,sp)
1079  0305 1f33          	ldw	(OFST-5,sp),x
1081                     ; 180 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1083  0307 a680          	ld	a,#128
1084  0309 cd0000        	call	_ADC1_ClearFlag
1086                     ; 168 				for(iter=0;iter<adc_captures;iter++)
1088  030c 96            	ldw	x,sp
1089  030d 1c0035        	addw	x,#OFST-3
1090  0310 a601          	ld	a,#1
1091  0312 cd0000        	call	c_lgadc
1094  0315               L763:
1097  0315 96            	ldw	x,sp
1098  0316 1c0035        	addw	x,#OFST-3
1099  0319 cd0000        	call	c_ltor
1101  031c 96            	ldw	x,sp
1102  031d 1c0021        	addw	x,#OFST-23
1103  0320 cd0000        	call	c_lcmp
1105  0323 2598          	jrult	L363
1106                     ; 184 				if(rms>9) mean_threshold++;
1108  0325 1e33          	ldw	x,(OFST-5,sp)
1109  0327 a3000a        	cpw	x,#10
1110  032a 2502          	jrult	L104
1113  032c 0c28          	inc	(OFST-16,sp)
1115  032e               L104:
1116                     ; 185 				if(rms==0) mean_threshold--;
1118  032e 1e33          	ldw	x,(OFST-5,sp)
1119  0330 2602          	jrne	L304
1122  0332 0a28          	dec	(OFST-16,sp)
1124  0334               L304:
1125                     ; 186 				mean=(mean_sum)/(adc_captures);
1127  0334 96            	ldw	x,sp
1128  0335 1c002f        	addw	x,#OFST-9
1129  0338 cd0000        	call	c_ltor
1131  033b 96            	ldw	x,sp
1132  033c 1c0021        	addw	x,#OFST-23
1133  033f cd0000        	call	c_ludv
1135  0342 b603          	ld	a,c_lreg+3
1136  0344 6b29          	ld	(OFST-15,sp),a
1138                     ; 187 				if(sound_level/32<mean_threshold) sound_level++;
1140  0346 1e2a          	ldw	x,(OFST-14,sp)
1141  0348 54            	srlw	x
1142  0349 54            	srlw	x
1143  034a 54            	srlw	x
1144  034b 54            	srlw	x
1145  034c 54            	srlw	x
1146  034d 7b28          	ld	a,(OFST-16,sp)
1147  034f 905f          	clrw	y
1148  0351 9097          	ld	yl,a
1149  0353 90bf00        	ldw	c_y,y
1150  0356 b300          	cpw	x,c_y
1151  0358 2407          	jruge	L504
1154  035a 1e2a          	ldw	x,(OFST-14,sp)
1155  035c 1c0001        	addw	x,#1
1156  035f 1f2a          	ldw	(OFST-14,sp),x
1158  0361               L504:
1159                     ; 188 				if(sound_level/32>mean_threshold) sound_level--;
1161  0361 1e2a          	ldw	x,(OFST-14,sp)
1162  0363 54            	srlw	x
1163  0364 54            	srlw	x
1164  0365 54            	srlw	x
1165  0366 54            	srlw	x
1166  0367 54            	srlw	x
1167  0368 7b28          	ld	a,(OFST-16,sp)
1168  036a 905f          	clrw	y
1169  036c 9097          	ld	yl,a
1170  036e 90bf00        	ldw	c_y,y
1171  0371 b300          	cpw	x,c_y
1172  0373 2307          	jrule	L704
1175  0375 1e2a          	ldw	x,(OFST-14,sp)
1176  0377 1d0001        	subw	x,#1
1177  037a 1f2a          	ldw	(OFST-14,sp),x
1179  037c               L704:
1180                     ; 189 				if(debug%4==0)
1182  037c 1e2d          	ldw	x,(OFST-11,sp)
1183  037e a604          	ld	a,#4
1184  0380 cd0000        	call	c_smodx
1186  0383 a30000        	cpw	x,#0
1187  0386 267b          	jrne	L114
1188                     ; 191 					Serial_print_string("adc: ");
1190  0388 ae00d6        	ldw	x,#L543
1191  038b cd0615        	call	_Serial_print_string
1193                     ; 192 					Serial_print_int(mean);
1195  038e 7b29          	ld	a,(OFST-15,sp)
1196  0390 5f            	clrw	x
1197  0391 97            	ld	xl,a
1198  0392 cd063e        	call	_Serial_print_int
1200                     ; 193 					Serial_print_string(", ");
1202  0395 ae00d3        	ldw	x,#L743
1203  0398 cd0615        	call	_Serial_print_string
1205                     ; 194 					if(rms<9) Serial_print_string("0");
1207  039b 1e33          	ldw	x,(OFST-5,sp)
1208  039d a30009        	cpw	x,#9
1209  03a0 2406          	jruge	L314
1212  03a2 ae00d1        	ldw	x,#L514
1213  03a5 cd0615        	call	_Serial_print_string
1215  03a8               L314:
1216                     ; 195 					if(rms==0) Serial_print_string("0");
1218  03a8 1e33          	ldw	x,(OFST-5,sp)
1219  03aa 2606          	jrne	L714
1222  03ac ae00d1        	ldw	x,#L514
1223  03af cd0615        	call	_Serial_print_string
1225  03b2               L714:
1226                     ; 196 					Serial_print_int(rms);
1228  03b2 1e33          	ldw	x,(OFST-5,sp)
1229  03b4 cd063e        	call	_Serial_print_int
1231                     ; 197 					Serial_print_string(", ");
1233  03b7 ae00d3        	ldw	x,#L743
1234  03ba cd0615        	call	_Serial_print_string
1236                     ; 198 					if(mean_threshold<9) Serial_print_string("0");
1238  03bd 7b28          	ld	a,(OFST-16,sp)
1239  03bf a109          	cp	a,#9
1240  03c1 2406          	jruge	L124
1243  03c3 ae00d1        	ldw	x,#L514
1244  03c6 cd0615        	call	_Serial_print_string
1246  03c9               L124:
1247                     ; 199 					Serial_print_int(mean_threshold);
1249  03c9 7b28          	ld	a,(OFST-16,sp)
1250  03cb 5f            	clrw	x
1251  03cc 97            	ld	xl,a
1252  03cd cd063e        	call	_Serial_print_int
1254                     ; 200 					Serial_print_string(", ");
1256  03d0 ae00d3        	ldw	x,#L743
1257  03d3 cd0615        	call	_Serial_print_string
1259                     ; 201 					if(sound_level/8<9) Serial_print_string("0");
1261  03d6 1e2a          	ldw	x,(OFST-14,sp)
1262  03d8 54            	srlw	x
1263  03d9 54            	srlw	x
1264  03da 54            	srlw	x
1265  03db a30009        	cpw	x,#9
1266  03de 2406          	jruge	L324
1269  03e0 ae00d1        	ldw	x,#L514
1270  03e3 cd0615        	call	_Serial_print_string
1272  03e6               L324:
1273                     ; 202 					Serial_print_int(sound_level/8);
1275  03e6 1e2a          	ldw	x,(OFST-14,sp)
1276  03e8 54            	srlw	x
1277  03e9 54            	srlw	x
1278  03ea 54            	srlw	x
1279  03eb cd063e        	call	_Serial_print_int
1281                     ; 203 					if(debug%10==0) Serial_print_string("*");
1283  03ee 1e2d          	ldw	x,(OFST-11,sp)
1284  03f0 a60a          	ld	a,#10
1285  03f2 cd0000        	call	c_smodx
1287  03f5 a30000        	cpw	x,#0
1288  03f8 2606          	jrne	L524
1291  03fa ae00cf        	ldw	x,#L724
1292  03fd cd0615        	call	_Serial_print_string
1294  0400               L524:
1295                     ; 204 					Serial_newline();
1297  0400 cd06a1        	call	_Serial_newline
1299  0403               L114:
1300                     ; 206 				if(mean_threshold>10)
1302  0403 7b28          	ld	a,(OFST-16,sp)
1303  0405 a10b          	cp	a,#11
1304  0407 2518          	jrult	L134
1305                     ; 210 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1307  0409 4bd0          	push	#208
1308  040b 4b08          	push	#8
1309  040d ae500a        	ldw	x,#20490
1310  0410 cd0000        	call	_GPIO_Init
1312  0413 85            	popw	x
1313                     ; 211 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1315  0414 4bc0          	push	#192
1316  0416 4b20          	push	#32
1317  0418 ae500a        	ldw	x,#20490
1318  041b cd0000        	call	_GPIO_Init
1320  041e 85            	popw	x
1322  041f 2016          	jra	L334
1323  0421               L134:
1324                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1326  0421 4bd0          	push	#208
1327  0423 4b10          	push	#16
1328  0425 ae500a        	ldw	x,#20490
1329  0428 cd0000        	call	_GPIO_Init
1331  042b 85            	popw	x
1332                     ; 214 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1334  042c 4bc0          	push	#192
1335  042e 4b40          	push	#64
1336  0430 ae500a        	ldw	x,#20490
1337  0433 cd0000        	call	_GPIO_Init
1339  0436 85            	popw	x
1340  0437               L334:
1341                     ; 216 			for(iter=0;iter<10;iter++){}
1343  0437 ae0000        	ldw	x,#0
1344  043a 1f37          	ldw	(OFST-1,sp),x
1345  043c ae0000        	ldw	x,#0
1346  043f 1f35          	ldw	(OFST-3,sp),x
1348  0441               L534:
1351  0441 96            	ldw	x,sp
1352  0442 1c0035        	addw	x,#OFST-3
1353  0445 a601          	ld	a,#1
1354  0447 cd0000        	call	c_lgadc
1359  044a 96            	ldw	x,sp
1360  044b 1c0035        	addw	x,#OFST-3
1361  044e cd0000        	call	c_ltor
1363  0451 ae001c        	ldw	x,#L04
1364  0454 cd0000        	call	c_lcmp
1366  0457 25e8          	jrult	L534
1367                     ; 217 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1369  0459 4b00          	push	#0
1370  045b 4bf8          	push	#248
1371  045d ae500a        	ldw	x,#20490
1372  0460 cd0000        	call	_GPIO_Init
1374  0463 85            	popw	x
1375                     ; 218 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1377  0464 4b00          	push	#0
1378  0466 4b04          	push	#4
1379  0468 ae500f        	ldw	x,#20495
1380  046b cd0000        	call	_GPIO_Init
1382  046e 85            	popw	x
1383                     ; 220 				debug++;
1385  046f 1e2d          	ldw	x,(OFST-11,sp)
1386  0471 1c0001        	addw	x,#1
1387  0474 1f2d          	ldw	(OFST-11,sp),x
1390  0476 ac800280      	jpf	L753
1391  047a               L76:
1392                     ; 226 			ADC1_DeInit();
1394  047a cd0000        	call	_ADC1_DeInit
1396                     ; 227 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1396                     ; 228 							 AIN4,
1396                     ; 229 							 ADC1_PRESSEL_FCPU_D2,//D18 
1396                     ; 230 							 ADC1_EXTTRIG_TIM, 
1396                     ; 231 							 DISABLE, 
1396                     ; 232 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1396                     ; 233 							 ADC1_SCHMITTTRIG_ALL, 
1396                     ; 234 							 DISABLE);
1398  047d 4b00          	push	#0
1399  047f 4bff          	push	#255
1400  0481 4b08          	push	#8
1401  0483 4b00          	push	#0
1402  0485 4b00          	push	#0
1403  0487 4b00          	push	#0
1404  0489 ae0104        	ldw	x,#260
1405  048c cd0000        	call	_ADC1_Init
1407  048f 5b06          	addw	sp,#6
1408                     ; 235 			ADC1_Cmd(ENABLE);
1410  0491 a601          	ld	a,#1
1411  0493 cd0000        	call	_ADC1_Cmd
1413  0496               L344:
1414                     ; 238 				debug++;
1416  0496 1e2d          	ldw	x,(OFST-11,sp)
1417  0498 1c0001        	addw	x,#1
1418  049b 1f2d          	ldw	(OFST-11,sp),x
1420                     ; 239 				rms=0;//8 bit
1422  049d 5f            	clrw	x
1423  049e 1f33          	ldw	(OFST-5,sp),x
1425                     ; 241 				mean_sum=0;//16 bit
1427  04a0 ae0000        	ldw	x,#0
1428  04a3 1f31          	ldw	(OFST-7,sp),x
1429  04a5 ae0000        	ldw	x,#0
1430  04a8 1f2f          	ldw	(OFST-9,sp),x
1432                     ; 244 				iter=0;
1434  04aa ae0000        	ldw	x,#0
1435  04ad 1f37          	ldw	(OFST-1,sp),x
1436  04af ae0000        	ldw	x,#0
1437  04b2 1f35          	ldw	(OFST-3,sp),x
1439  04b4               L744:
1440                     ; 247 					ADC1_StartConversion();
1442  04b4 cd0000        	call	_ADC1_StartConversion
1445  04b7               L754:
1446                     ; 248 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1448  04b7 a680          	ld	a,#128
1449  04b9 cd0000        	call	_ADC1_GetFlagStatus
1451  04bc 4d            	tnz	a
1452  04bd 27f8          	jreq	L754
1453                     ; 250 					reading=ADC1->DRL;
1455  04bf c65405        	ld	a,21509
1456  04c2 6b2c          	ld	(OFST-12,sp),a
1458                     ; 251 					mean_sum += reading;
1460  04c4 7b2c          	ld	a,(OFST-12,sp)
1461  04c6 96            	ldw	x,sp
1462  04c7 1c002f        	addw	x,#OFST-9
1463  04ca cd0000        	call	c_lgadc
1466                     ; 253 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1468  04cd 7b2c          	ld	a,(OFST-12,sp)
1469  04cf 1129          	cp	a,(OFST-15,sp)
1470  04d1 2306          	jrule	L24
1471  04d3 7b2c          	ld	a,(OFST-12,sp)
1472  04d5 1029          	sub	a,(OFST-15,sp)
1473  04d7 2004          	jra	L44
1474  04d9               L24:
1475  04d9 7b29          	ld	a,(OFST-15,sp)
1476  04db 102c          	sub	a,(OFST-12,sp)
1477  04dd               L44:
1478  04dd 6b28          	ld	(OFST-16,sp),a
1480                     ; 254 					rms+=mean_diff>mean_threshold_8;
1482  04df 7b28          	ld	a,(OFST-16,sp)
1483  04e1 1127          	cp	a,(OFST-17,sp)
1484  04e3 2305          	jrule	L64
1485  04e5 ae0001        	ldw	x,#1
1486  04e8 2001          	jra	L05
1487  04ea               L64:
1488  04ea 5f            	clrw	x
1489  04eb               L05:
1490  04eb 72fb33        	addw	x,(OFST-5,sp)
1491  04ee 1f33          	ldw	(OFST-5,sp),x
1493                     ; 256 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1495  04f0 a680          	ld	a,#128
1496  04f2 cd0000        	call	_ADC1_ClearFlag
1498                     ; 259 					iter++;
1500  04f5 96            	ldw	x,sp
1501  04f6 1c0035        	addw	x,#OFST-3
1502  04f9 a601          	ld	a,#1
1503  04fb cd0000        	call	c_lgadc
1506                     ; 260 					iter%=256;//8 bit unsigned
1508  04fe 0f37          	clr	(OFST-1,sp)
1509  0500 0f36          	clr	(OFST-2,sp)
1510  0502 0f35          	clr	(OFST-3,sp)
1512                     ; 261 				}while(iter!=0);//run 255 times
1514  0504 96            	ldw	x,sp
1515  0505 1c0035        	addw	x,#OFST-3
1516  0508 cd0000        	call	c_lzmp
1518  050b 26a7          	jrne	L744
1519                     ; 262 				mean=((uint16_t)mean+mean_sum/256)/2;
1521  050d 96            	ldw	x,sp
1522  050e 1c002f        	addw	x,#OFST-9
1523  0511 cd0000        	call	c_ltor
1525  0514 a608          	ld	a,#8
1526  0516 cd0000        	call	c_lursh
1528  0519 96            	ldw	x,sp
1529  051a 1c0001        	addw	x,#OFST-55
1530  051d cd0000        	call	c_rtol
1533  0520 7b29          	ld	a,(OFST-15,sp)
1534  0522 b703          	ld	c_lreg+3,a
1535  0524 3f02          	clr	c_lreg+2
1536  0526 3f01          	clr	c_lreg+1
1537  0528 3f00          	clr	c_lreg
1538  052a 96            	ldw	x,sp
1539  052b 1c0001        	addw	x,#OFST-55
1540  052e cd0000        	call	c_ladd
1542  0531 3400          	srl	c_lreg
1543  0533 3601          	rrc	c_lreg+1
1544  0535 3602          	rrc	c_lreg+2
1545  0537 3603          	rrc	c_lreg+3
1546  0539 b603          	ld	a,c_lreg+3
1547  053b 6b29          	ld	(OFST-15,sp),a
1549                     ; 263 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1551  053d 96            	ldw	x,sp
1552  053e 1c0009        	addw	x,#OFST-47
1553  0541 1f03          	ldw	(OFST-53,sp),x
1555  0543 1e33          	ldw	x,(OFST-5,sp)
1556  0545 54            	srlw	x
1557  0546 54            	srlw	x
1558  0547 54            	srlw	x
1559  0548 54            	srlw	x
1560  0549 72fb03        	addw	x,(OFST-53,sp)
1561  054c f6            	ld	a,(x)
1562  054d 5f            	clrw	x
1563  054e 97            	ld	xl,a
1564  054f 1625          	ldw	y,(OFST-19,sp)
1565  0551 cd0000        	call	c_imul
1567  0554 54            	srlw	x
1568  0555 54            	srlw	x
1569  0556 54            	srlw	x
1570  0557 54            	srlw	x
1571  0558 54            	srlw	x
1572  0559 72fb25        	addw	x,(OFST-19,sp)
1573  055c 54            	srlw	x
1574  055d 1f25          	ldw	(OFST-19,sp),x
1576                     ; 264 				mean_threshold_8=mean_threshold_16/256;
1578  055f 7b25          	ld	a,(OFST-19,sp)
1579  0561 6b27          	ld	(OFST-17,sp),a
1581                     ; 265 				if(mean_threshold_8==0)
1583  0563 0d27          	tnz	(OFST-17,sp)
1584  0565 2609          	jrne	L364
1585                     ; 267 					mean_threshold_8=1;
1587  0567 a601          	ld	a,#1
1588  0569 6b27          	ld	(OFST-17,sp),a
1590                     ; 268 					mean_threshold_16=0x0100;
1592  056b ae0100        	ldw	x,#256
1593  056e 1f25          	ldw	(OFST-19,sp),x
1595  0570               L364:
1596                     ; 273 					if(mean==0) Serial_print_string("0");
1598  0570 0d29          	tnz	(OFST-15,sp)
1599  0572 2606          	jrne	L564
1602  0574 ae00d1        	ldw	x,#L514
1603  0577 cd0615        	call	_Serial_print_string
1605  057a               L564:
1606                     ; 274 					Serial_print_int(mean);
1608  057a 7b29          	ld	a,(OFST-15,sp)
1609  057c 5f            	clrw	x
1610  057d 97            	ld	xl,a
1611  057e cd063e        	call	_Serial_print_int
1613                     ; 276 					Serial_print_string(" ");
1615  0581 ae00cd        	ldw	x,#L764
1616  0584 cd0615        	call	_Serial_print_string
1618                     ; 279 					if(rms==0) Serial_print_string("0");
1620  0587 1e33          	ldw	x,(OFST-5,sp)
1621  0589 2606          	jrne	L174
1624  058b ae00d1        	ldw	x,#L514
1625  058e cd0615        	call	_Serial_print_string
1627  0591               L174:
1628                     ; 280 					Serial_print_int(rms);
1630  0591 1e33          	ldw	x,(OFST-5,sp)
1631  0593 cd063e        	call	_Serial_print_int
1633                     ; 282 					Serial_print_string(" ");
1635  0596 ae00cd        	ldw	x,#L764
1636  0599 ad7a          	call	_Serial_print_string
1638                     ; 283 					if(mean_threshold_8==0) Serial_print_string("0");
1640  059b 0d27          	tnz	(OFST-17,sp)
1641  059d 2605          	jrne	L374
1644  059f ae00d1        	ldw	x,#L514
1645  05a2 ad71          	call	_Serial_print_string
1647  05a4               L374:
1648                     ; 284 					Serial_print_int(mean_threshold_8);
1650  05a4 7b27          	ld	a,(OFST-17,sp)
1651  05a6 5f            	clrw	x
1652  05a7 97            	ld	xl,a
1653  05a8 cd063e        	call	_Serial_print_int
1655                     ; 286 					Serial_newline();
1657  05ab cd06a1        	call	_Serial_newline
1660  05ae ac960496      	jpf	L344
1661  05b2               L17:
1662                     ; 292 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1664  05b2 4b40          	push	#64
1665  05b4 4b20          	push	#32
1666  05b6 ae500f        	ldw	x,#20495
1667  05b9 cd0000        	call	_GPIO_Init
1669  05bc 85            	popw	x
1670                     ; 293 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1672  05bd 4b40          	push	#64
1673  05bf 4b40          	push	#64
1674  05c1 ae500f        	ldw	x,#20495
1675  05c4 cd0000        	call	_GPIO_Init
1677  05c7 85            	popw	x
1678  05c8               L574:
1679                     ; 296 			  setMatrixHighZ();
1681  05c8 cd06b0        	call	_setMatrixHighZ
1683                     ; 297 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1685  05cb 4b20          	push	#32
1686  05cd ae500f        	ldw	x,#20495
1687  05d0 cd0000        	call	_GPIO_ReadInputPin
1689  05d3 5b01          	addw	sp,#1
1690  05d5 4d            	tnz	a
1691  05d6 2618          	jrne	L105
1692                     ; 301 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1694  05d8 4bd0          	push	#208
1695  05da 4b08          	push	#8
1696  05dc ae500a        	ldw	x,#20490
1697  05df cd0000        	call	_GPIO_Init
1699  05e2 85            	popw	x
1700                     ; 302 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1702  05e3 4bc0          	push	#192
1703  05e5 4b20          	push	#32
1704  05e7 ae500a        	ldw	x,#20490
1705  05ea cd0000        	call	_GPIO_Init
1707  05ed 85            	popw	x
1709  05ee 20d8          	jra	L574
1710  05f0               L105:
1711                     ; 303 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1713  05f0 4b40          	push	#64
1714  05f2 ae500f        	ldw	x,#20495
1715  05f5 cd0000        	call	_GPIO_ReadInputPin
1717  05f8 5b01          	addw	sp,#1
1718  05fa 4d            	tnz	a
1719  05fb 26cb          	jrne	L574
1720                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1722  05fd 4bd0          	push	#208
1723  05ff 4b10          	push	#16
1724  0601 ae500a        	ldw	x,#20490
1725  0604 cd0000        	call	_GPIO_Init
1727  0607 85            	popw	x
1728                     ; 305 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1730  0608 4bc0          	push	#192
1731  060a 4b40          	push	#64
1732  060c ae500a        	ldw	x,#20490
1733  060f cd0000        	call	_GPIO_Init
1735  0612 85            	popw	x
1736  0613 20b3          	jra	L574
1783                     ; 334  void Serial_print_string (char string[])
1783                     ; 335  {
1784                     	switch	.text
1785  0615               _Serial_print_string:
1787  0615 89            	pushw	x
1788  0616 88            	push	a
1789       00000001      OFST:	set	1
1792                     ; 337 	 char i=0;
1794  0617 0f01          	clr	(OFST+0,sp)
1797  0619 2016          	jra	L535
1798  061b               L135:
1799                     ; 341 		UART1_SendData8(string[i]);
1801  061b 7b01          	ld	a,(OFST+0,sp)
1802  061d 5f            	clrw	x
1803  061e 97            	ld	xl,a
1804  061f 72fb02        	addw	x,(OFST+1,sp)
1805  0622 f6            	ld	a,(x)
1806  0623 cd0000        	call	_UART1_SendData8
1809  0626               L345:
1810                     ; 342 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
1812  0626 ae0080        	ldw	x,#128
1813  0629 cd0000        	call	_UART1_GetFlagStatus
1815  062c 4d            	tnz	a
1816  062d 27f7          	jreq	L345
1817                     ; 343 		i++;
1819  062f 0c01          	inc	(OFST+0,sp)
1821  0631               L535:
1822                     ; 339 	 while (string[i] != 0x00)
1824  0631 7b01          	ld	a,(OFST+0,sp)
1825  0633 5f            	clrw	x
1826  0634 97            	ld	xl,a
1827  0635 72fb02        	addw	x,(OFST+1,sp)
1828  0638 7d            	tnz	(x)
1829  0639 26e0          	jrne	L135
1830                     ; 345  }
1833  063b 5b03          	addw	sp,#3
1834  063d 81            	ret
1837                     	switch	.const
1838  0020               L745_digit:
1839  0020 00            	dc.b	0
1840  0021 00000000      	ds.b	4
1893                     ; 347  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
1893                     ; 348  {
1894                     	switch	.text
1895  063e               _Serial_print_int:
1897  063e 89            	pushw	x
1898  063f 5208          	subw	sp,#8
1899       00000008      OFST:	set	8
1902                     ; 349 	 char count = 0;
1904  0641 0f08          	clr	(OFST+0,sp)
1906                     ; 350 	 char digit[5] = "";
1908  0643 96            	ldw	x,sp
1909  0644 1c0003        	addw	x,#OFST-5
1910  0647 90ae0020      	ldw	y,#L745_digit
1911  064b a605          	ld	a,#5
1912  064d cd0000        	call	c_xymov
1915  0650 2023          	jra	L306
1916  0652               L775:
1917                     ; 354 		 digit[count] = number%10;
1919  0652 96            	ldw	x,sp
1920  0653 1c0003        	addw	x,#OFST-5
1921  0656 9f            	ld	a,xl
1922  0657 5e            	swapw	x
1923  0658 1b08          	add	a,(OFST+0,sp)
1924  065a 2401          	jrnc	L07
1925  065c 5c            	incw	x
1926  065d               L07:
1927  065d 02            	rlwa	x,a
1928  065e 1609          	ldw	y,(OFST+1,sp)
1929  0660 a60a          	ld	a,#10
1930  0662 cd0000        	call	c_smody
1932  0665 9001          	rrwa	y,a
1933  0667 f7            	ld	(x),a
1934  0668 9002          	rlwa	y,a
1935                     ; 355 		 count++;
1937  066a 0c08          	inc	(OFST+0,sp)
1939                     ; 356 		 number = number/10;
1941  066c 1e09          	ldw	x,(OFST+1,sp)
1942  066e a60a          	ld	a,#10
1943  0670 cd0000        	call	c_sdivx
1945  0673 1f09          	ldw	(OFST+1,sp),x
1946  0675               L306:
1947                     ; 352 	 while (number != 0) //split the int to char array 
1949  0675 1e09          	ldw	x,(OFST+1,sp)
1950  0677 26d9          	jrne	L775
1952  0679 201f          	jra	L116
1953  067b               L706:
1954                     ; 361 		UART1_SendData8(digit[count-1] + 0x30);
1956  067b 96            	ldw	x,sp
1957  067c 1c0003        	addw	x,#OFST-5
1958  067f 1f01          	ldw	(OFST-7,sp),x
1960  0681 7b08          	ld	a,(OFST+0,sp)
1961  0683 5f            	clrw	x
1962  0684 97            	ld	xl,a
1963  0685 5a            	decw	x
1964  0686 72fb01        	addw	x,(OFST-7,sp)
1965  0689 f6            	ld	a,(x)
1966  068a ab30          	add	a,#48
1967  068c cd0000        	call	_UART1_SendData8
1970  068f               L716:
1971                     ; 362 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
1973  068f ae0080        	ldw	x,#128
1974  0692 cd0000        	call	_UART1_GetFlagStatus
1976  0695 4d            	tnz	a
1977  0696 27f7          	jreq	L716
1978                     ; 363 		count--; 
1980  0698 0a08          	dec	(OFST+0,sp)
1982  069a               L116:
1983                     ; 359 	 while (count !=0) //print char array in correct direction 
1985  069a 0d08          	tnz	(OFST+0,sp)
1986  069c 26dd          	jrne	L706
1987                     ; 365  }
1990  069e 5b0a          	addw	sp,#10
1991  06a0 81            	ret
2016                     ; 367  void Serial_newline(void)
2016                     ; 368  {
2017                     	switch	.text
2018  06a1               _Serial_newline:
2022                     ; 369 	 UART1_SendData8(0x0a);
2024  06a1 a60a          	ld	a,#10
2025  06a3 cd0000        	call	_UART1_SendData8
2028  06a6               L536:
2029                     ; 370 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2031  06a6 ae0080        	ldw	x,#128
2032  06a9 cd0000        	call	_UART1_GetFlagStatus
2034  06ac 4d            	tnz	a
2035  06ad 27f7          	jreq	L536
2036                     ; 371  }
2039  06af 81            	ret
2063                     ; 373 void setMatrixHighZ()
2063                     ; 374 {
2064                     	switch	.text
2065  06b0               _setMatrixHighZ:
2069                     ; 379 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2071  06b0 4b00          	push	#0
2072  06b2 4bf8          	push	#248
2073  06b4 ae500a        	ldw	x,#20490
2074  06b7 cd0000        	call	_GPIO_Init
2076  06ba 85            	popw	x
2077                     ; 380 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2079  06bb 4b00          	push	#0
2080  06bd 4b0c          	push	#12
2081  06bf ae500f        	ldw	x,#20495
2082  06c2 cd0000        	call	_GPIO_Init
2084  06c5 85            	popw	x
2085                     ; 381 }
2088  06c6 81            	ret
2132                     ; 383 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2133                     	switch	.text
2134  06c7               _setRGB:
2136  06c7 89            	pushw	x
2137       00000000      OFST:	set	0
2142  06c8 1e05          	ldw	x,(OFST+5,sp)
2143  06ca 89            	pushw	x
2144  06cb 1e03          	ldw	x,(OFST+3,sp)
2145  06cd 89            	pushw	x
2146  06ce a601          	ld	a,#1
2147  06d0 ad11          	call	_setLED
2149  06d2 5b04          	addw	sp,#4
2153  06d4 85            	popw	x
2154  06d5 81            	ret
2189                     ; 384 void setWhite(int led_index){ setLED(0,led_index,0); }
2190                     	switch	.text
2191  06d6               _setWhite:
2193  06d6 89            	pushw	x
2194       00000000      OFST:	set	0
2199  06d7 5f            	clrw	x
2200  06d8 89            	pushw	x
2201  06d9 1e03          	ldw	x,(OFST+3,sp)
2202  06db 89            	pushw	x
2203  06dc 4f            	clr	a
2204  06dd ad04          	call	_setLED
2206  06df 5b04          	addw	sp,#4
2210  06e1 85            	popw	x
2211  06e2 81            	ret
2214                     	switch	.const
2215  0025               L117_rgb_lookup:
2216  0025 0000          	dc.w	0
2217  0027 0001          	dc.w	1
2218  0029 0000          	dc.w	0
2219  002b 0002          	dc.w	2
2220  002d 0001          	dc.w	1
2221  002f 0002          	dc.w	2
2222  0031 0001          	dc.w	1
2223  0033 0000          	dc.w	0
2224  0035 0002          	dc.w	2
2225  0037 0000          	dc.w	0
2226  0039 0002          	dc.w	2
2227  003b 0001          	dc.w	1
2228  003d 0005          	dc.w	5
2229  003f 0000          	dc.w	0
2230  0041 0005          	dc.w	5
2231  0043 0001          	dc.w	1
2232  0045 0005          	dc.w	5
2233  0047 0002          	dc.w	2
2234  0049 0006          	dc.w	6
2235  004b 0000          	dc.w	0
2236  004d 0006          	dc.w	6
2237  004f 0001          	dc.w	1
2238  0051 0006          	dc.w	6
2239  0053 0002          	dc.w	2
2240  0055 0006          	dc.w	6
2241  0057 0005          	dc.w	5
2242  0059 0006          	dc.w	6
2243  005b 0004          	dc.w	4
2244  005d 0005          	dc.w	5
2245  005f 0004          	dc.w	4
2246  0061 0004          	dc.w	4
2247  0063 0003          	dc.w	3
2248  0065 0005          	dc.w	5
2249  0067 0003          	dc.w	3
2250  0069 0006          	dc.w	6
2251  006b 0003          	dc.w	3
2252  006d 0003          	dc.w	3
2253  006f 0004          	dc.w	4
2254  0071 0003          	dc.w	3
2255  0073 0005          	dc.w	5
2256  0075 0003          	dc.w	3
2257  0077 0006          	dc.w	6
2258  0079 0000          	dc.w	0
2259  007b 0005          	dc.w	5
2260  007d 0000          	dc.w	0
2261  007f 0006          	dc.w	6
2262  0081 0001          	dc.w	1
2263  0083 0006          	dc.w	6
2264  0085 0000          	dc.w	0
2265  0087 0004          	dc.w	4
2266  0089 0001          	dc.w	1
2267  008b 0004          	dc.w	4
2268  008d 0002          	dc.w	2
2269  008f 0004          	dc.w	4
2270  0091 0000          	dc.w	0
2271  0093 0003          	dc.w	3
2272  0095 0001          	dc.w	1
2273  0097 0003          	dc.w	3
2274  0099 0002          	dc.w	2
2275  009b 0003          	dc.w	3
2276  009d               L317_white_lookup:
2277  009d 0003          	dc.w	3
2278  009f 0000          	dc.w	0
2279  00a1 0003          	dc.w	3
2280  00a3 0001          	dc.w	1
2281  00a5 0003          	dc.w	3
2282  00a7 0002          	dc.w	2
2283  00a9 0004          	dc.w	4
2284  00ab 0000          	dc.w	0
2285  00ad 0001          	dc.w	1
2286  00af 0005          	dc.w	5
2287  00b1 0002          	dc.w	2
2288  00b3 0005          	dc.w	5
2289  00b5 0004          	dc.w	4
2290  00b7 0001          	dc.w	1
2291  00b9 0004          	dc.w	4
2292  00bb 0002          	dc.w	2
2293  00bd 0002          	dc.w	2
2294  00bf 0006          	dc.w	6
2295  00c1 0004          	dc.w	4
2296  00c3 0006          	dc.w	6
2297  00c5 0004          	dc.w	4
2298  00c7 0005          	dc.w	5
2299  00c9 0005          	dc.w	5
2300  00cb 0006          	dc.w	6
2562                     ; 386 void setLED(bool is_rgb,int led_index,int rgb_index)
2562                     ; 387 {
2563                     	switch	.text
2564  06e3               _setLED:
2566  06e3 88            	push	a
2567  06e4 52b6          	subw	sp,#182
2568       000000b6      OFST:	set	182
2571                     ; 388   const unsigned short rgb_lookup[10][3][2]={
2571                     ; 389 		{{0,1},{0,2},{1,2}},//7
2571                     ; 390 		{{1,0},{2,0},{2,1}},//3
2571                     ; 391 		{{5,0},{5,1},{5,2}},//1
2571                     ; 392 		{{6,0},{6,1},{6,2}},//20
2571                     ; 393 		{{6,5},{6,4},{5,4}},//22
2571                     ; 394 		{{4,3},{5,3},{6,3}},//23
2571                     ; 395 		{{3,4},{3,5},{3,6}},//21
2571                     ; 396 		{{0,5},{0,6},{1,6}},//19
2571                     ; 397 		{{0,4},{1,4},{2,4}},//18
2571                     ; 398 		{{0,3},{1,3},{2,3}} //2
2571                     ; 399 	};
2573  06e6 96            	ldw	x,sp
2574  06e7 1c000e        	addw	x,#OFST-168
2575  06ea 90ae0025      	ldw	y,#L117_rgb_lookup
2576  06ee a678          	ld	a,#120
2577  06f0 cd0000        	call	c_xymov
2579                     ; 400 	const unsigned short white_lookup[12][2]={
2579                     ; 401 		{3,0},//6
2579                     ; 402 		{3,1},//4
2579                     ; 403 		{3,2},//5
2579                     ; 404 		{4,0},//14
2579                     ; 405 		{1,5},//8
2579                     ; 406 		{2,5},//9
2579                     ; 407 		{4,1},//10
2579                     ; 408 		{4,2},//16
2579                     ; 409 		{2,6},//17
2579                     ; 410 		{4,6},//12
2579                     ; 411 		{4,5},//13
2579                     ; 412 		{5,6} //11
2579                     ; 413 	};
2581  06f3 96            	ldw	x,sp
2582  06f4 1c0086        	addw	x,#OFST-48
2583  06f7 90ae009d      	ldw	y,#L317_white_lookup
2584  06fb a630          	ld	a,#48
2585  06fd cd0000        	call	c_xymov
2587                     ; 414 	bool is_low=0;
2589  0700 0fb6          	clr	(OFST+0,sp)
2591  0702               L3011:
2592                     ; 418 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
2594  0702 0db7          	tnz	(OFST+1,sp)
2595  0704 2726          	jreq	L401
2596  0706 7bb6          	ld	a,(OFST+0,sp)
2597  0708 5f            	clrw	x
2598  0709 97            	ld	xl,a
2599  070a 58            	sllw	x
2600  070b 1f09          	ldw	(OFST-173,sp),x
2602  070d 1ebc          	ldw	x,(OFST+6,sp)
2603  070f 58            	sllw	x
2604  0710 58            	sllw	x
2605  0711 1f07          	ldw	(OFST-175,sp),x
2607  0713 96            	ldw	x,sp
2608  0714 1c000e        	addw	x,#OFST-168
2609  0717 1f05          	ldw	(OFST-177,sp),x
2611  0719 1eba          	ldw	x,(OFST+4,sp)
2612  071b a60c          	ld	a,#12
2613  071d cd0000        	call	c_bmulx
2615  0720 72fb05        	addw	x,(OFST-177,sp)
2616  0723 72fb07        	addw	x,(OFST-175,sp)
2617  0726 72fb09        	addw	x,(OFST-173,sp)
2618  0729 fe            	ldw	x,(x)
2619  072a 2018          	jra	L601
2620  072c               L401:
2621  072c 7bb6          	ld	a,(OFST+0,sp)
2622  072e 5f            	clrw	x
2623  072f 97            	ld	xl,a
2624  0730 58            	sllw	x
2625  0731 1f03          	ldw	(OFST-179,sp),x
2627  0733 96            	ldw	x,sp
2628  0734 1c0086        	addw	x,#OFST-48
2629  0737 1f01          	ldw	(OFST-181,sp),x
2631  0739 1eba          	ldw	x,(OFST+4,sp)
2632  073b 58            	sllw	x
2633  073c 58            	sllw	x
2634  073d 72fb01        	addw	x,(OFST-181,sp)
2635  0740 72fb03        	addw	x,(OFST-179,sp)
2636  0743 fe            	ldw	x,(x)
2637  0744               L601:
2639                     ; 450 			}break;
2640  0744 5d            	tnzw	x
2641  0745 2714          	jreq	L517
2642  0747 5a            	decw	x
2643  0748 271c          	jreq	L717
2644  074a 5a            	decw	x
2645  074b 2724          	jreq	L127
2646  074d 5a            	decw	x
2647  074e 272c          	jreq	L327
2648  0750 5a            	decw	x
2649  0751 2734          	jreq	L527
2650  0753 5a            	decw	x
2651  0754 273c          	jreq	L727
2652  0756 5a            	decw	x
2653  0757 2744          	jreq	L137
2654  0759 204b          	jra	L3111
2655  075b               L517:
2656                     ; 421 				GPIOx=GPIOD;
2658  075b ae500f        	ldw	x,#20495
2659  075e 1f0b          	ldw	(OFST-171,sp),x
2661                     ; 422 				PortPin=GPIO_PIN_3;
2663  0760 a608          	ld	a,#8
2664  0762 6b0d          	ld	(OFST-169,sp),a
2666                     ; 423 			}break;
2668  0764 2040          	jra	L3111
2669  0766               L717:
2670                     ; 425 				GPIOx=GPIOD;
2672  0766 ae500f        	ldw	x,#20495
2673  0769 1f0b          	ldw	(OFST-171,sp),x
2675                     ; 426 				PortPin=GPIO_PIN_2;
2677  076b a604          	ld	a,#4
2678  076d 6b0d          	ld	(OFST-169,sp),a
2680                     ; 427 			}break;
2682  076f 2035          	jra	L3111
2683  0771               L127:
2684                     ; 429 				GPIOx=GPIOC;
2686  0771 ae500a        	ldw	x,#20490
2687  0774 1f0b          	ldw	(OFST-171,sp),x
2689                     ; 430 				PortPin=GPIO_PIN_7;
2691  0776 a680          	ld	a,#128
2692  0778 6b0d          	ld	(OFST-169,sp),a
2694                     ; 431 			}break;
2696  077a 202a          	jra	L3111
2697  077c               L327:
2698                     ; 433 				GPIOx=GPIOC;
2700  077c ae500a        	ldw	x,#20490
2701  077f 1f0b          	ldw	(OFST-171,sp),x
2703                     ; 434 				PortPin=GPIO_PIN_6;
2705  0781 a640          	ld	a,#64
2706  0783 6b0d          	ld	(OFST-169,sp),a
2708                     ; 435 			}break;
2710  0785 201f          	jra	L3111
2711  0787               L527:
2712                     ; 437 				GPIOx=GPIOC;
2714  0787 ae500a        	ldw	x,#20490
2715  078a 1f0b          	ldw	(OFST-171,sp),x
2717                     ; 438 				PortPin=GPIO_PIN_5;
2719  078c a620          	ld	a,#32
2720  078e 6b0d          	ld	(OFST-169,sp),a
2722                     ; 439 			}break;
2724  0790 2014          	jra	L3111
2725  0792               L727:
2726                     ; 441 				GPIOx=GPIOC;
2728  0792 ae500a        	ldw	x,#20490
2729  0795 1f0b          	ldw	(OFST-171,sp),x
2731                     ; 442 				PortPin=GPIO_PIN_4;
2733  0797 a610          	ld	a,#16
2734  0799 6b0d          	ld	(OFST-169,sp),a
2736                     ; 443 			}break;
2738  079b 2009          	jra	L3111
2739  079d               L137:
2740                     ; 445 				GPIOx=GPIOC;
2742  079d ae500a        	ldw	x,#20490
2743  07a0 1f0b          	ldw	(OFST-171,sp),x
2745                     ; 446 				PortPin=GPIO_PIN_3;
2747  07a2 a608          	ld	a,#8
2748  07a4 6b0d          	ld	(OFST-169,sp),a
2750                     ; 447 			}break;
2752  07a6               L3111:
2753                     ; 452 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
2755  07a6 0db6          	tnz	(OFST+0,sp)
2756  07a8 2704          	jreq	L011
2757  07aa a6c0          	ld	a,#192
2758  07ac 2002          	jra	L211
2759  07ae               L011:
2760  07ae a6d0          	ld	a,#208
2761  07b0               L211:
2762  07b0 88            	push	a
2763  07b1 7b0e          	ld	a,(OFST-168,sp)
2764  07b3 88            	push	a
2765  07b4 1e0d          	ldw	x,(OFST-169,sp)
2766  07b6 cd0000        	call	_GPIO_Init
2768  07b9 85            	popw	x
2769                     ; 453 		is_low=!is_low;
2771  07ba 0db6          	tnz	(OFST+0,sp)
2772  07bc 2604          	jrne	L411
2773  07be a601          	ld	a,#1
2774  07c0 2001          	jra	L611
2775  07c2               L411:
2776  07c2 4f            	clr	a
2777  07c3               L611:
2778  07c3 6bb6          	ld	(OFST+0,sp),a
2780                     ; 454 	}while(is_low);
2782  07c5 0db6          	tnz	(OFST+0,sp)
2783  07c7 2703          	jreq	L021
2784  07c9 cc0702        	jp	L3011
2785  07cc               L021:
2786                     ; 455 }
2789  07cc 5bb7          	addw	sp,#183
2790  07ce 81            	ret
2803                     	xdef	_main
2804                     	xdef	_Serial_print_string
2805                     	xdef	_Serial_newline
2806                     	xdef	_Serial_print_int
2807                     	xdef	_setWhite
2808                     	xdef	_setRGB
2809                     	xdef	_setLED
2810                     	xdef	_setMatrixHighZ
2811                     	xdef	_ADC_Read
2812                     	xref	_UART1_GetFlagStatus
2813                     	xref	_UART1_SendData8
2814                     	xref	_UART1_Cmd
2815                     	xref	_UART1_Init
2816                     	xref	_UART1_DeInit
2817                     	xref	_GPIO_ReadInputPin
2818                     	xref	_GPIO_Init
2819                     	xref	_ADC1_ClearFlag
2820                     	xref	_ADC1_GetFlagStatus
2821                     	xref	_ADC1_GetConversionValue
2822                     	xref	_ADC1_StartConversion
2823                     	xref	_ADC1_Cmd
2824                     	xref	_ADC1_Init
2825                     	xref	_ADC1_DeInit
2826                     	switch	.const
2827  00cd               L764:
2828  00cd 2000          	dc.b	" ",0
2829  00cf               L724:
2830  00cf 2a00          	dc.b	"*",0
2831  00d1               L514:
2832  00d1 3000          	dc.b	"0",0
2833  00d3               L743:
2834  00d3 2c2000        	dc.b	", ",0
2835  00d6               L543:
2836  00d6 6164633a2000  	dc.b	"adc: ",0
2837  00dc               L513:
2838  00dc 636f756e7465  	dc.b	"counter: ",0
2839                     	xref.b	c_lreg
2840                     	xref.b	c_x
2841                     	xref.b	c_y
2861                     	xref	c_bmulx
2862                     	xref	c_sdivx
2863                     	xref	c_smody
2864                     	xref	c_imul
2865                     	xref	c_ladd
2866                     	xref	c_lursh
2867                     	xref	c_uitol
2868                     	xref	c_smodx
2869                     	xref	c_ludv
2870                     	xref	c_itol
2871                     	xref	c_rtol
2872                     	xref	c_uitolx
2873                     	xref	c_lzmp
2874                     	xref	c_lcmp
2875                     	xref	c_ltor
2876                     	xref	c_lgadc
2877                     	xref	c_xymov
2878                     	end
