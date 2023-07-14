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
 488                     ; 21 int main()
 488                     ; 22 {
 489                     	switch	.text
 490  003e               _main:
 492  003e 5238          	subw	sp,#56
 493       00000038      OFST:	set	56
 496                     ; 45 	const int test_mode=0;
 498  0040 5f            	clrw	x
 499  0041 1f33          	ldw	(OFST-5,sp),x
 501                     ; 46 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 503  0043 96            	ldw	x,sp
 504  0044 1c0009        	addw	x,#OFST-47
 505  0047 90ae0000      	ldw	y,#L75_rms_lookup
 506  004b a610          	ld	a,#16
 507  004d cd0000        	call	c_xymov
 509                     ; 48 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 513  0050 ae0000        	ldw	x,#0
 514  0053 1f26          	ldw	(OFST-18,sp),x
 515  0055 ae0000        	ldw	x,#0
 516  0058 1f24          	ldw	(OFST-20,sp),x
 522                     ; 49 	unsigned sound_level=0;
 524  005a 5f            	clrw	x
 525  005b 1f31          	ldw	(OFST-7,sp),x
 527                     ; 50 	uint8_t mean_threshold=16;
 529  005d a610          	ld	a,#16
 530  005f 6b28          	ld	(OFST-16,sp),a
 532                     ; 51 	uint8_t mean_threshold_8=1;
 534  0061 a601          	ld	a,#1
 535  0063 6b23          	ld	(OFST-21,sp),a
 537                     ; 52 	uint16_t mean_threshold_16=0x0100;
 539  0065 ae0100        	ldw	x,#256
 540  0068 1f1d          	ldw	(OFST-27,sp),x
 542                     ; 53 	unsigned int rms=0;
 544                     ; 54 	const long adc_captures=1<<8;
 546  006a ae0100        	ldw	x,#256
 547  006d 1f1b          	ldw	(OFST-29,sp),x
 548  006f ae0000        	ldw	x,#0
 549  0072 1f19          	ldw	(OFST-31,sp),x
 551                     ; 56 	int debug=0;
 553  0074 5f            	clrw	x
 554  0075 1f2b          	ldw	(OFST-13,sp),x
 556                     ; 58 	for(rep=0;rep<1;rep++)
 558  0077 ae0000        	ldw	x,#0
 559  007a 1f2f          	ldw	(OFST-9,sp),x
 560  007c ae0000        	ldw	x,#0
 561  007f 1f2d          	ldw	(OFST-11,sp),x
 563  0081               L352:
 564                     ; 59 		for(iter=0;iter<10000;iter++){}
 566  0081 ae0000        	ldw	x,#0
 567  0084 1f37          	ldw	(OFST-1,sp),x
 568  0086 ae0000        	ldw	x,#0
 569  0089 1f35          	ldw	(OFST-3,sp),x
 571  008b               L162:
 574  008b 96            	ldw	x,sp
 575  008c 1c0035        	addw	x,#OFST-3
 576  008f a601          	ld	a,#1
 577  0091 cd0000        	call	c_lgadc
 582  0094 96            	ldw	x,sp
 583  0095 1c0035        	addw	x,#OFST-3
 584  0098 cd0000        	call	c_ltor
 586  009b ae0010        	ldw	x,#L01
 587  009e cd0000        	call	c_lcmp
 589  00a1 25e8          	jrult	L162
 590                     ; 58 	for(rep=0;rep<1;rep++)
 592  00a3 96            	ldw	x,sp
 593  00a4 1c002d        	addw	x,#OFST-11
 594  00a7 a601          	ld	a,#1
 595  00a9 cd0000        	call	c_lgadc
 600  00ac 96            	ldw	x,sp
 601  00ad 1c002d        	addw	x,#OFST-11
 602  00b0 cd0000        	call	c_lzmp
 604  00b3 27cc          	jreq	L352
 605                     ; 62 	if(test_mode!=4 && test_mode!=5)
 607  00b5 1e33          	ldw	x,(OFST-5,sp)
 608  00b7 a30004        	cpw	x,#4
 609  00ba 273c          	jreq	L762
 611  00bc 1e33          	ldw	x,(OFST-5,sp)
 612  00be a30005        	cpw	x,#5
 613  00c1 2735          	jreq	L762
 614                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 616  00c3 4bf0          	push	#240
 617  00c5 4b20          	push	#32
 618  00c7 ae500f        	ldw	x,#20495
 619  00ca cd0000        	call	_GPIO_Init
 621  00cd 85            	popw	x
 622                     ; 65 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 624  00ce 4b40          	push	#64
 625  00d0 4b40          	push	#64
 626  00d2 ae500f        	ldw	x,#20495
 627  00d5 cd0000        	call	_GPIO_Init
 629  00d8 85            	popw	x
 630                     ; 66 		UART1_DeInit();
 632  00d9 cd0000        	call	_UART1_DeInit
 634                     ; 67 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 636  00dc 4b0c          	push	#12
 637  00de 4b80          	push	#128
 638  00e0 4b00          	push	#0
 639  00e2 4b00          	push	#0
 640  00e4 4b00          	push	#0
 641  00e6 aec200        	ldw	x,#49664
 642  00e9 89            	pushw	x
 643  00ea ae0001        	ldw	x,#1
 644  00ed 89            	pushw	x
 645  00ee cd0000        	call	_UART1_Init
 647  00f1 5b09          	addw	sp,#9
 648                     ; 69 		UART1_Cmd(ENABLE);
 650  00f3 a601          	ld	a,#1
 651  00f5 cd0000        	call	_UART1_Cmd
 653  00f8               L762:
 654                     ; 72 	switch(test_mode)
 656  00f8 1e33          	ldw	x,(OFST-5,sp)
 658                     ; 434 					setRGB(mean_high+(mean_low?5:0),sound_level);
 659  00fa 5d            	tnzw	x
 660  00fb 272d          	jreq	L572
 661  00fd 5a            	decw	x
 662  00fe 2603          	jrne	L201
 663  0100 cc01ce        	jp	L143
 664  0103               L201:
 665  0103 5a            	decw	x
 666  0104 2603          	jrne	L401
 667  0106 cc0284        	jp	L56
 668  0109               L401:
 669  0109 5a            	decw	x
 670  010a 2603          	jrne	L601
 671  010c cc049a        	jp	L76
 672  010f               L601:
 673  010f 5a            	decw	x
 674  0110 2603          	jrne	L011
 675  0112 cc05d4        	jp	L17
 676  0115               L011:
 677  0115 5a            	decw	x
 678  0116 2603          	jrne	L211
 679  0118 cc0637        	jp	L37
 680  011b               L211:
 681  011b 5a            	decw	x
 682  011c 2603          	jrne	L411
 683  011e cc07a1        	jp	L57
 684  0121               L411:
 685  0121 5a            	decw	x
 686  0122 2603          	jrne	L611
 687  0124 cc0824        	jp	L77
 688  0127               L611:
 689  0127               L001:
 690                     ; 440 }
 693  0127 5b38          	addw	sp,#56
 694  0129 81            	ret
 695  012a               L572:
 696                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 698  012a 5f            	clrw	x
 699  012b 1f31          	ldw	(OFST-7,sp),x
 701  012d               L103:
 702                     ; 82 					for(led_index=0;led_index<10;led_index++)
 704  012d 5f            	clrw	x
 705  012e 1f33          	ldw	(OFST-5,sp),x
 707  0130               L703:
 708                     ; 84 						setMatrixHighZ();
 710  0130 cd09aa        	call	_setMatrixHighZ
 712                     ; 85 						setRGB(led_index,rgb_index);
 714  0133 1e31          	ldw	x,(OFST-7,sp)
 715  0135 89            	pushw	x
 716  0136 1e35          	ldw	x,(OFST-3,sp)
 717  0138 cd09c1        	call	_setRGB
 719  013b 85            	popw	x
 720                     ; 86 						for(iter=0;iter<30000;iter++){}
 722  013c ae0000        	ldw	x,#0
 723  013f 1f37          	ldw	(OFST-1,sp),x
 724  0141 ae0000        	ldw	x,#0
 725  0144 1f35          	ldw	(OFST-3,sp),x
 727  0146               L513:
 730  0146 96            	ldw	x,sp
 731  0147 1c0035        	addw	x,#OFST-3
 732  014a a601          	ld	a,#1
 733  014c cd0000        	call	c_lgadc
 738  014f 96            	ldw	x,sp
 739  0150 1c0035        	addw	x,#OFST-3
 740  0153 cd0000        	call	c_ltor
 742  0156 ae0014        	ldw	x,#L21
 743  0159 cd0000        	call	c_lcmp
 745  015c 25e8          	jrult	L513
 746                     ; 87 						debug++;
 748  015e 1e2b          	ldw	x,(OFST-13,sp)
 749  0160 1c0001        	addw	x,#1
 750  0163 1f2b          	ldw	(OFST-13,sp),x
 752                     ; 94 							Serial_print_string("counter: ");
 754  0165 ae011b        	ldw	x,#L323
 755  0168 cd090f        	call	_Serial_print_string
 757                     ; 95 							Serial_print_int(debug);
 759  016b 1e2b          	ldw	x,(OFST-13,sp)
 760  016d cd0938        	call	_Serial_print_int
 762                     ; 98 							Serial_newline();
 764  0170 cd099b        	call	_Serial_newline
 766                     ; 82 					for(led_index=0;led_index<10;led_index++)
 768  0173 1e33          	ldw	x,(OFST-5,sp)
 769  0175 1c0001        	addw	x,#1
 770  0178 1f33          	ldw	(OFST-5,sp),x
 774  017a 1e33          	ldw	x,(OFST-5,sp)
 775  017c a3000a        	cpw	x,#10
 776  017f 25af          	jrult	L703
 777                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 779  0181 1e31          	ldw	x,(OFST-7,sp)
 780  0183 1c0001        	addw	x,#1
 781  0186 1f31          	ldw	(OFST-7,sp),x
 785  0188 1e31          	ldw	x,(OFST-7,sp)
 786  018a a30003        	cpw	x,#3
 787  018d 259e          	jrult	L103
 788                     ; 102 				for(led_index=0;led_index<12;led_index++)
 790  018f 5f            	clrw	x
 791  0190 1f33          	ldw	(OFST-5,sp),x
 793  0192               L523:
 794                     ; 104 					setMatrixHighZ();
 796  0192 cd09aa        	call	_setMatrixHighZ
 798                     ; 105 					setWhite(led_index);
 800  0195 1e33          	ldw	x,(OFST-5,sp)
 801  0197 cd09d0        	call	_setWhite
 803                     ; 106 					for(iter=0;iter<30000;iter++){}
 805  019a ae0000        	ldw	x,#0
 806  019d 1f37          	ldw	(OFST-1,sp),x
 807  019f ae0000        	ldw	x,#0
 808  01a2 1f35          	ldw	(OFST-3,sp),x
 810  01a4               L333:
 813  01a4 96            	ldw	x,sp
 814  01a5 1c0035        	addw	x,#OFST-3
 815  01a8 a601          	ld	a,#1
 816  01aa cd0000        	call	c_lgadc
 821  01ad 96            	ldw	x,sp
 822  01ae 1c0035        	addw	x,#OFST-3
 823  01b1 cd0000        	call	c_ltor
 825  01b4 ae0014        	ldw	x,#L21
 826  01b7 cd0000        	call	c_lcmp
 828  01ba 25e8          	jrult	L333
 829                     ; 102 				for(led_index=0;led_index<12;led_index++)
 831  01bc 1e33          	ldw	x,(OFST-5,sp)
 832  01be 1c0001        	addw	x,#1
 833  01c1 1f33          	ldw	(OFST-5,sp),x
 837  01c3 1e33          	ldw	x,(OFST-5,sp)
 838  01c5 a3000c        	cpw	x,#12
 839  01c8 25c8          	jrult	L523
 841  01ca ac2a012a      	jpf	L572
 842  01ce               L143:
 843                     ; 114 				rep=ADC_Read(AIN4);
 845  01ce a604          	ld	a,#4
 846  01d0 cd0000        	call	_ADC_Read
 848  01d3 cd0000        	call	c_uitolx
 850  01d6 96            	ldw	x,sp
 851  01d7 1c002d        	addw	x,#OFST-11
 852  01da cd0000        	call	c_rtol
 855                     ; 115 				my_min=rep;
 857  01dd 1e2f          	ldw	x,(OFST-9,sp)
 858  01df 1f2b          	ldw	(OFST-13,sp),x
 860                     ; 116 				my_max=rep;
 862  01e1 1e2f          	ldw	x,(OFST-9,sp)
 863  01e3 1f31          	ldw	(OFST-7,sp),x
 865                     ; 117 				for(iter=0;iter<1000;iter++)
 867  01e5 ae0000        	ldw	x,#0
 868  01e8 1f37          	ldw	(OFST-1,sp),x
 869  01ea ae0000        	ldw	x,#0
 870  01ed 1f35          	ldw	(OFST-3,sp),x
 872  01ef               L543:
 873                     ; 119 					rep=ADC_Read(AIN4);
 875  01ef a604          	ld	a,#4
 876  01f1 cd0000        	call	_ADC_Read
 878  01f4 cd0000        	call	c_uitolx
 880  01f7 96            	ldw	x,sp
 881  01f8 1c002d        	addw	x,#OFST-11
 882  01fb cd0000        	call	c_rtol
 885                     ; 120 					my_min=my_min<rep?my_min:rep;
 887  01fe 1e2b          	ldw	x,(OFST-13,sp)
 888  0200 cd0000        	call	c_uitolx
 890  0203 96            	ldw	x,sp
 891  0204 1c002d        	addw	x,#OFST-11
 892  0207 cd0000        	call	c_lcmp
 894  020a 2404          	jruge	L41
 895  020c 1e2b          	ldw	x,(OFST-13,sp)
 896  020e 2002          	jra	L61
 897  0210               L41:
 898  0210 1e2f          	ldw	x,(OFST-9,sp)
 899  0212               L61:
 900  0212 1f2b          	ldw	(OFST-13,sp),x
 902                     ; 121 					my_max=my_max>rep?my_max:rep;
 904  0214 1e31          	ldw	x,(OFST-7,sp)
 905  0216 cd0000        	call	c_uitolx
 907  0219 96            	ldw	x,sp
 908  021a 1c002d        	addw	x,#OFST-11
 909  021d cd0000        	call	c_lcmp
 911  0220 2304          	jrule	L02
 912  0222 1e31          	ldw	x,(OFST-7,sp)
 913  0224 2002          	jra	L22
 914  0226               L02:
 915  0226 1e2f          	ldw	x,(OFST-9,sp)
 916  0228               L22:
 917  0228 1f31          	ldw	(OFST-7,sp),x
 919                     ; 117 				for(iter=0;iter<1000;iter++)
 921  022a 96            	ldw	x,sp
 922  022b 1c0035        	addw	x,#OFST-3
 923  022e a601          	ld	a,#1
 924  0230 cd0000        	call	c_lgadc
 929  0233 96            	ldw	x,sp
 930  0234 1c0035        	addw	x,#OFST-3
 931  0237 cd0000        	call	c_ltor
 933  023a ae0018        	ldw	x,#L42
 934  023d cd0000        	call	c_lcmp
 936  0240 25ad          	jrult	L543
 937                     ; 123 				Serial_print_string("adc: ");
 939  0242 ae0115        	ldw	x,#L353
 940  0245 cd090f        	call	_Serial_print_string
 942                     ; 124 				Serial_print_int(rep);
 944  0248 1e2f          	ldw	x,(OFST-9,sp)
 945  024a cd0938        	call	_Serial_print_int
 947                     ; 125 				Serial_print_string(", ");
 949  024d ae0112        	ldw	x,#L553
 950  0250 cd090f        	call	_Serial_print_string
 952                     ; 126 				Serial_print_int(my_max-my_min);
 954  0253 1e31          	ldw	x,(OFST-7,sp)
 955  0255 72f02b        	subw	x,(OFST-13,sp)
 956  0258 cd0938        	call	_Serial_print_int
 958                     ; 127 				Serial_newline();
 960  025b cd099b        	call	_Serial_newline
 962                     ; 128 				for(iter=0;iter<10000;iter++){}
 964  025e ae0000        	ldw	x,#0
 965  0261 1f37          	ldw	(OFST-1,sp),x
 966  0263 ae0000        	ldw	x,#0
 967  0266 1f35          	ldw	(OFST-3,sp),x
 969  0268               L753:
 972  0268 96            	ldw	x,sp
 973  0269 1c0035        	addw	x,#OFST-3
 974  026c a601          	ld	a,#1
 975  026e cd0000        	call	c_lgadc
 980  0271 96            	ldw	x,sp
 981  0272 1c0035        	addw	x,#OFST-3
 982  0275 cd0000        	call	c_ltor
 984  0278 ae0010        	ldw	x,#L01
 985  027b cd0000        	call	c_lcmp
 987  027e 25e8          	jrult	L753
 989  0280 acce01ce      	jpf	L143
 990  0284               L56:
 991                     ; 133 			ADC1_DeInit();
 993  0284 cd0000        	call	_ADC1_DeInit
 995                     ; 134 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 995                     ; 135 							 AIN4,
 995                     ; 136 							 ADC1_PRESSEL_FCPU_D2,//D18 
 995                     ; 137 							 ADC1_EXTTRIG_TIM, 
 995                     ; 138 							 DISABLE, 
 995                     ; 139 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
 995                     ; 140 							 ADC1_SCHMITTTRIG_ALL, 
 995                     ; 141 							 DISABLE);
 997  0287 4b00          	push	#0
 998  0289 4bff          	push	#255
 999  028b 4b08          	push	#8
1000  028d 4b00          	push	#0
1001  028f 4b00          	push	#0
1002  0291 4b00          	push	#0
1003  0293 ae0104        	ldw	x,#260
1004  0296 cd0000        	call	_ADC1_Init
1006  0299 5b06          	addw	sp,#6
1007                     ; 142 			ADC1_Cmd(ENABLE);
1009  029b a601          	ld	a,#1
1010  029d cd0000        	call	_ADC1_Cmd
1012  02a0               L563:
1013                     ; 166 				rms=0;
1015  02a0 5f            	clrw	x
1016  02a1 1f33          	ldw	(OFST-5,sp),x
1018                     ; 168 				mean_sum=0;
1020  02a3 ae0000        	ldw	x,#0
1021  02a6 1f26          	ldw	(OFST-18,sp),x
1022  02a8 ae0000        	ldw	x,#0
1023  02ab 1f24          	ldw	(OFST-20,sp),x
1025                     ; 169 				mean_low=mean+mean_threshold;
1027  02ad 7b29          	ld	a,(OFST-15,sp)
1028  02af 5f            	clrw	x
1029  02b0 1b28          	add	a,(OFST-16,sp)
1030  02b2 2401          	jrnc	L62
1031  02b4 5c            	incw	x
1032  02b5               L62:
1033  02b5 cd0000        	call	c_itol
1035  02b8 96            	ldw	x,sp
1036  02b9 1c001f        	addw	x,#OFST-25
1037  02bc cd0000        	call	c_rtol
1040                     ; 170 				mean_high=mean-mean_threshold;
1042  02bf 7b29          	ld	a,(OFST-15,sp)
1043  02c1 5f            	clrw	x
1044  02c2 1028          	sub	a,(OFST-16,sp)
1045  02c4 2401          	jrnc	L03
1046  02c6 5a            	decw	x
1047  02c7               L03:
1048  02c7 cd0000        	call	c_itol
1050  02ca 96            	ldw	x,sp
1051  02cb 1c002d        	addw	x,#OFST-11
1052  02ce cd0000        	call	c_rtol
1055                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1057  02d1 ae0000        	ldw	x,#0
1058  02d4 1f37          	ldw	(OFST-1,sp),x
1059  02d6 ae0000        	ldw	x,#0
1060  02d9 1f35          	ldw	(OFST-3,sp),x
1063  02db 2058          	jra	L573
1064  02dd               L173:
1065                     ; 174 					ADC1_StartConversion();
1067  02dd cd0000        	call	_ADC1_StartConversion
1070  02e0               L304:
1071                     ; 175 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1073  02e0 a680          	ld	a,#128
1074  02e2 cd0000        	call	_ADC1_GetFlagStatus
1076  02e5 4d            	tnz	a
1077  02e6 27f8          	jreq	L304
1078                     ; 177 					reading=ADC1->DRL;
1080  02e8 c65405        	ld	a,21509
1081  02eb 6b2a          	ld	(OFST-14,sp),a
1083                     ; 178 					mean_sum += reading;
1085  02ed 7b2a          	ld	a,(OFST-14,sp)
1086  02ef 96            	ldw	x,sp
1087  02f0 1c0024        	addw	x,#OFST-20
1088  02f3 cd0000        	call	c_lgadc
1091                     ; 179 					rms+=reading>mean_low || reading<mean_high;
1093  02f6 7b2a          	ld	a,(OFST-14,sp)
1094  02f8 b703          	ld	c_lreg+3,a
1095  02fa 3f02          	clr	c_lreg+2
1096  02fc 3f01          	clr	c_lreg+1
1097  02fe 3f00          	clr	c_lreg
1098  0300 96            	ldw	x,sp
1099  0301 1c001f        	addw	x,#OFST-25
1100  0304 cd0000        	call	c_lcmp
1102  0307 2213          	jrugt	L43
1103  0309 7b2a          	ld	a,(OFST-14,sp)
1104  030b b703          	ld	c_lreg+3,a
1105  030d 3f02          	clr	c_lreg+2
1106  030f 3f01          	clr	c_lreg+1
1107  0311 3f00          	clr	c_lreg
1108  0313 96            	ldw	x,sp
1109  0314 1c002d        	addw	x,#OFST-11
1110  0317 cd0000        	call	c_lcmp
1112  031a 2405          	jruge	L23
1113  031c               L43:
1114  031c ae0001        	ldw	x,#1
1115  031f 2001          	jra	L63
1116  0321               L23:
1117  0321 5f            	clrw	x
1118  0322               L63:
1119  0322 72fb33        	addw	x,(OFST-5,sp)
1120  0325 1f33          	ldw	(OFST-5,sp),x
1122                     ; 183 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1124  0327 a680          	ld	a,#128
1125  0329 cd0000        	call	_ADC1_ClearFlag
1127                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1129  032c 96            	ldw	x,sp
1130  032d 1c0035        	addw	x,#OFST-3
1131  0330 a601          	ld	a,#1
1132  0332 cd0000        	call	c_lgadc
1135  0335               L573:
1138  0335 96            	ldw	x,sp
1139  0336 1c0035        	addw	x,#OFST-3
1140  0339 cd0000        	call	c_ltor
1142  033c 96            	ldw	x,sp
1143  033d 1c0019        	addw	x,#OFST-31
1144  0340 cd0000        	call	c_lcmp
1146  0343 2598          	jrult	L173
1147                     ; 187 				if(rms>9) mean_threshold++;
1149  0345 1e33          	ldw	x,(OFST-5,sp)
1150  0347 a3000a        	cpw	x,#10
1151  034a 2502          	jrult	L704
1154  034c 0c28          	inc	(OFST-16,sp)
1156  034e               L704:
1157                     ; 188 				if(rms==0) mean_threshold--;
1159  034e 1e33          	ldw	x,(OFST-5,sp)
1160  0350 2602          	jrne	L114
1163  0352 0a28          	dec	(OFST-16,sp)
1165  0354               L114:
1166                     ; 189 				mean=(mean_sum)/(adc_captures);
1168  0354 96            	ldw	x,sp
1169  0355 1c0024        	addw	x,#OFST-20
1170  0358 cd0000        	call	c_ltor
1172  035b 96            	ldw	x,sp
1173  035c 1c0019        	addw	x,#OFST-31
1174  035f cd0000        	call	c_ludv
1176  0362 b603          	ld	a,c_lreg+3
1177  0364 6b29          	ld	(OFST-15,sp),a
1179                     ; 190 				if(sound_level/32<mean_threshold) sound_level++;
1181  0366 1e31          	ldw	x,(OFST-7,sp)
1182  0368 54            	srlw	x
1183  0369 54            	srlw	x
1184  036a 54            	srlw	x
1185  036b 54            	srlw	x
1186  036c 54            	srlw	x
1187  036d 7b28          	ld	a,(OFST-16,sp)
1188  036f 905f          	clrw	y
1189  0371 9097          	ld	yl,a
1190  0373 90bf00        	ldw	c_y,y
1191  0376 b300          	cpw	x,c_y
1192  0378 2407          	jruge	L314
1195  037a 1e31          	ldw	x,(OFST-7,sp)
1196  037c 1c0001        	addw	x,#1
1197  037f 1f31          	ldw	(OFST-7,sp),x
1199  0381               L314:
1200                     ; 191 				if(sound_level/32>mean_threshold) sound_level--;
1202  0381 1e31          	ldw	x,(OFST-7,sp)
1203  0383 54            	srlw	x
1204  0384 54            	srlw	x
1205  0385 54            	srlw	x
1206  0386 54            	srlw	x
1207  0387 54            	srlw	x
1208  0388 7b28          	ld	a,(OFST-16,sp)
1209  038a 905f          	clrw	y
1210  038c 9097          	ld	yl,a
1211  038e 90bf00        	ldw	c_y,y
1212  0391 b300          	cpw	x,c_y
1213  0393 2307          	jrule	L514
1216  0395 1e31          	ldw	x,(OFST-7,sp)
1217  0397 1d0001        	subw	x,#1
1218  039a 1f31          	ldw	(OFST-7,sp),x
1220  039c               L514:
1221                     ; 192 				if(debug%4==0)
1223  039c 1e2b          	ldw	x,(OFST-13,sp)
1224  039e a604          	ld	a,#4
1225  03a0 cd0000        	call	c_smodx
1227  03a3 a30000        	cpw	x,#0
1228  03a6 267b          	jrne	L714
1229                     ; 194 					Serial_print_string("adc: ");
1231  03a8 ae0115        	ldw	x,#L353
1232  03ab cd090f        	call	_Serial_print_string
1234                     ; 195 					Serial_print_int(mean);
1236  03ae 7b29          	ld	a,(OFST-15,sp)
1237  03b0 5f            	clrw	x
1238  03b1 97            	ld	xl,a
1239  03b2 cd0938        	call	_Serial_print_int
1241                     ; 196 					Serial_print_string(", ");
1243  03b5 ae0112        	ldw	x,#L553
1244  03b8 cd090f        	call	_Serial_print_string
1246                     ; 197 					if(rms<9) Serial_print_string("0");
1248  03bb 1e33          	ldw	x,(OFST-5,sp)
1249  03bd a30009        	cpw	x,#9
1250  03c0 2406          	jruge	L124
1253  03c2 ae0110        	ldw	x,#L324
1254  03c5 cd090f        	call	_Serial_print_string
1256  03c8               L124:
1257                     ; 198 					if(rms==0) Serial_print_string("0");
1259  03c8 1e33          	ldw	x,(OFST-5,sp)
1260  03ca 2606          	jrne	L524
1263  03cc ae0110        	ldw	x,#L324
1264  03cf cd090f        	call	_Serial_print_string
1266  03d2               L524:
1267                     ; 199 					Serial_print_int(rms);
1269  03d2 1e33          	ldw	x,(OFST-5,sp)
1270  03d4 cd0938        	call	_Serial_print_int
1272                     ; 200 					Serial_print_string(", ");
1274  03d7 ae0112        	ldw	x,#L553
1275  03da cd090f        	call	_Serial_print_string
1277                     ; 201 					if(mean_threshold<9) Serial_print_string("0");
1279  03dd 7b28          	ld	a,(OFST-16,sp)
1280  03df a109          	cp	a,#9
1281  03e1 2406          	jruge	L724
1284  03e3 ae0110        	ldw	x,#L324
1285  03e6 cd090f        	call	_Serial_print_string
1287  03e9               L724:
1288                     ; 202 					Serial_print_int(mean_threshold);
1290  03e9 7b28          	ld	a,(OFST-16,sp)
1291  03eb 5f            	clrw	x
1292  03ec 97            	ld	xl,a
1293  03ed cd0938        	call	_Serial_print_int
1295                     ; 203 					Serial_print_string(", ");
1297  03f0 ae0112        	ldw	x,#L553
1298  03f3 cd090f        	call	_Serial_print_string
1300                     ; 204 					if(sound_level/8<9) Serial_print_string("0");
1302  03f6 1e31          	ldw	x,(OFST-7,sp)
1303  03f8 54            	srlw	x
1304  03f9 54            	srlw	x
1305  03fa 54            	srlw	x
1306  03fb a30009        	cpw	x,#9
1307  03fe 2406          	jruge	L134
1310  0400 ae0110        	ldw	x,#L324
1311  0403 cd090f        	call	_Serial_print_string
1313  0406               L134:
1314                     ; 205 					Serial_print_int(sound_level/8);
1316  0406 1e31          	ldw	x,(OFST-7,sp)
1317  0408 54            	srlw	x
1318  0409 54            	srlw	x
1319  040a 54            	srlw	x
1320  040b cd0938        	call	_Serial_print_int
1322                     ; 206 					if(debug%10==0) Serial_print_string("*");
1324  040e 1e2b          	ldw	x,(OFST-13,sp)
1325  0410 a60a          	ld	a,#10
1326  0412 cd0000        	call	c_smodx
1328  0415 a30000        	cpw	x,#0
1329  0418 2606          	jrne	L334
1332  041a ae010e        	ldw	x,#L534
1333  041d cd090f        	call	_Serial_print_string
1335  0420               L334:
1336                     ; 207 					Serial_newline();
1338  0420 cd099b        	call	_Serial_newline
1340  0423               L714:
1341                     ; 209 				if(mean_threshold>10)
1343  0423 7b28          	ld	a,(OFST-16,sp)
1344  0425 a10b          	cp	a,#11
1345  0427 2518          	jrult	L734
1346                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1348  0429 4bd0          	push	#208
1349  042b 4b08          	push	#8
1350  042d ae500a        	ldw	x,#20490
1351  0430 cd0000        	call	_GPIO_Init
1353  0433 85            	popw	x
1354                     ; 214 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1356  0434 4bc0          	push	#192
1357  0436 4b20          	push	#32
1358  0438 ae500a        	ldw	x,#20490
1359  043b cd0000        	call	_GPIO_Init
1361  043e 85            	popw	x
1363  043f 2016          	jra	L144
1364  0441               L734:
1365                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1367  0441 4bd0          	push	#208
1368  0443 4b10          	push	#16
1369  0445 ae500a        	ldw	x,#20490
1370  0448 cd0000        	call	_GPIO_Init
1372  044b 85            	popw	x
1373                     ; 217 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1375  044c 4bc0          	push	#192
1376  044e 4b40          	push	#64
1377  0450 ae500a        	ldw	x,#20490
1378  0453 cd0000        	call	_GPIO_Init
1380  0456 85            	popw	x
1381  0457               L144:
1382                     ; 219 			for(iter=0;iter<10;iter++){}
1384  0457 ae0000        	ldw	x,#0
1385  045a 1f37          	ldw	(OFST-1,sp),x
1386  045c ae0000        	ldw	x,#0
1387  045f 1f35          	ldw	(OFST-3,sp),x
1389  0461               L344:
1392  0461 96            	ldw	x,sp
1393  0462 1c0035        	addw	x,#OFST-3
1394  0465 a601          	ld	a,#1
1395  0467 cd0000        	call	c_lgadc
1400  046a 96            	ldw	x,sp
1401  046b 1c0035        	addw	x,#OFST-3
1402  046e cd0000        	call	c_ltor
1404  0471 ae001c        	ldw	x,#L04
1405  0474 cd0000        	call	c_lcmp
1407  0477 25e8          	jrult	L344
1408                     ; 220 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1410  0479 4b00          	push	#0
1411  047b 4bf8          	push	#248
1412  047d ae500a        	ldw	x,#20490
1413  0480 cd0000        	call	_GPIO_Init
1415  0483 85            	popw	x
1416                     ; 221 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1418  0484 4b00          	push	#0
1419  0486 4b04          	push	#4
1420  0488 ae500f        	ldw	x,#20495
1421  048b cd0000        	call	_GPIO_Init
1423  048e 85            	popw	x
1424                     ; 223 				debug++;
1426  048f 1e2b          	ldw	x,(OFST-13,sp)
1427  0491 1c0001        	addw	x,#1
1428  0494 1f2b          	ldw	(OFST-13,sp),x
1431  0496 aca002a0      	jpf	L563
1432  049a               L76:
1433                     ; 229 			ADC1_DeInit();
1435  049a cd0000        	call	_ADC1_DeInit
1437                     ; 230 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1437                     ; 231 							 AIN4,
1437                     ; 232 							 ADC1_PRESSEL_FCPU_D2,//D18 
1437                     ; 233 							 ADC1_EXTTRIG_TIM, 
1437                     ; 234 							 DISABLE, 
1437                     ; 235 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1437                     ; 236 							 ADC1_SCHMITTTRIG_ALL, 
1437                     ; 237 							 DISABLE);
1439  049d 4b00          	push	#0
1440  049f 4bff          	push	#255
1441  04a1 4b08          	push	#8
1442  04a3 4b00          	push	#0
1443  04a5 4b00          	push	#0
1444  04a7 4b00          	push	#0
1445  04a9 ae0104        	ldw	x,#260
1446  04ac cd0000        	call	_ADC1_Init
1448  04af 5b06          	addw	sp,#6
1449                     ; 238 			ADC1_Cmd(ENABLE);
1451  04b1 a601          	ld	a,#1
1452  04b3 cd0000        	call	_ADC1_Cmd
1454  04b6               L154:
1455                     ; 241 				debug++;
1457  04b6 1e2b          	ldw	x,(OFST-13,sp)
1458  04b8 1c0001        	addw	x,#1
1459  04bb 1f2b          	ldw	(OFST-13,sp),x
1461                     ; 242 				rms=0;//8 bit
1463  04bd 5f            	clrw	x
1464  04be 1f33          	ldw	(OFST-5,sp),x
1466                     ; 244 				mean_sum=0;//16 bit
1468  04c0 ae0000        	ldw	x,#0
1469  04c3 1f26          	ldw	(OFST-18,sp),x
1470  04c5 ae0000        	ldw	x,#0
1471  04c8 1f24          	ldw	(OFST-20,sp),x
1473                     ; 247 				iter=0;
1475  04ca ae0000        	ldw	x,#0
1476  04cd 1f37          	ldw	(OFST-1,sp),x
1477  04cf ae0000        	ldw	x,#0
1478  04d2 1f35          	ldw	(OFST-3,sp),x
1480  04d4               L554:
1481                     ; 250 					ADC1_StartConversion();
1483  04d4 cd0000        	call	_ADC1_StartConversion
1486  04d7               L564:
1487                     ; 251 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1489  04d7 a680          	ld	a,#128
1490  04d9 cd0000        	call	_ADC1_GetFlagStatus
1492  04dc 4d            	tnz	a
1493  04dd 27f8          	jreq	L564
1494                     ; 253 					reading=ADC1->DRL;
1496  04df c65405        	ld	a,21509
1497  04e2 6b2a          	ld	(OFST-14,sp),a
1499                     ; 254 					mean_sum += reading;
1501  04e4 7b2a          	ld	a,(OFST-14,sp)
1502  04e6 96            	ldw	x,sp
1503  04e7 1c0024        	addw	x,#OFST-20
1504  04ea cd0000        	call	c_lgadc
1507                     ; 256 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1509  04ed 7b2a          	ld	a,(OFST-14,sp)
1510  04ef 1129          	cp	a,(OFST-15,sp)
1511  04f1 2306          	jrule	L24
1512  04f3 7b2a          	ld	a,(OFST-14,sp)
1513  04f5 1029          	sub	a,(OFST-15,sp)
1514  04f7 2004          	jra	L44
1515  04f9               L24:
1516  04f9 7b29          	ld	a,(OFST-15,sp)
1517  04fb 102a          	sub	a,(OFST-14,sp)
1518  04fd               L44:
1519  04fd 6b28          	ld	(OFST-16,sp),a
1521                     ; 257 					rms+=mean_diff>mean_threshold_8;
1523  04ff 7b28          	ld	a,(OFST-16,sp)
1524  0501 1123          	cp	a,(OFST-21,sp)
1525  0503 2305          	jrule	L64
1526  0505 ae0001        	ldw	x,#1
1527  0508 2001          	jra	L05
1528  050a               L64:
1529  050a 5f            	clrw	x
1530  050b               L05:
1531  050b 72fb33        	addw	x,(OFST-5,sp)
1532  050e 1f33          	ldw	(OFST-5,sp),x
1534                     ; 259 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1536  0510 a680          	ld	a,#128
1537  0512 cd0000        	call	_ADC1_ClearFlag
1539                     ; 262 					iter++;
1541  0515 96            	ldw	x,sp
1542  0516 1c0035        	addw	x,#OFST-3
1543  0519 a601          	ld	a,#1
1544  051b cd0000        	call	c_lgadc
1547                     ; 263 					iter%=256;//8 bit unsigned
1549  051e 0f37          	clr	(OFST-1,sp)
1550  0520 0f36          	clr	(OFST-2,sp)
1551  0522 0f35          	clr	(OFST-3,sp)
1553                     ; 264 				}while(iter!=0);//run 255 times
1555  0524 96            	ldw	x,sp
1556  0525 1c0035        	addw	x,#OFST-3
1557  0528 cd0000        	call	c_lzmp
1559  052b 26a7          	jrne	L554
1560                     ; 265 				mean=((uint16_t)mean+mean_sum/256)/2;
1562  052d 96            	ldw	x,sp
1563  052e 1c0024        	addw	x,#OFST-20
1564  0531 cd0000        	call	c_ltor
1566  0534 a608          	ld	a,#8
1567  0536 cd0000        	call	c_lursh
1569  0539 96            	ldw	x,sp
1570  053a 1c0001        	addw	x,#OFST-55
1571  053d cd0000        	call	c_rtol
1574  0540 7b29          	ld	a,(OFST-15,sp)
1575  0542 b703          	ld	c_lreg+3,a
1576  0544 3f02          	clr	c_lreg+2
1577  0546 3f01          	clr	c_lreg+1
1578  0548 3f00          	clr	c_lreg
1579  054a 96            	ldw	x,sp
1580  054b 1c0001        	addw	x,#OFST-55
1581  054e cd0000        	call	c_ladd
1583  0551 3400          	srl	c_lreg
1584  0553 3601          	rrc	c_lreg+1
1585  0555 3602          	rrc	c_lreg+2
1586  0557 3603          	rrc	c_lreg+3
1587  0559 b603          	ld	a,c_lreg+3
1588  055b 6b29          	ld	(OFST-15,sp),a
1590                     ; 266 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1592  055d 96            	ldw	x,sp
1593  055e 1c0009        	addw	x,#OFST-47
1594  0561 1f03          	ldw	(OFST-53,sp),x
1596  0563 1e33          	ldw	x,(OFST-5,sp)
1597  0565 54            	srlw	x
1598  0566 54            	srlw	x
1599  0567 54            	srlw	x
1600  0568 54            	srlw	x
1601  0569 72fb03        	addw	x,(OFST-53,sp)
1602  056c f6            	ld	a,(x)
1603  056d 5f            	clrw	x
1604  056e 97            	ld	xl,a
1605  056f 161d          	ldw	y,(OFST-27,sp)
1606  0571 cd0000        	call	c_imul
1608  0574 54            	srlw	x
1609  0575 54            	srlw	x
1610  0576 54            	srlw	x
1611  0577 54            	srlw	x
1612  0578 54            	srlw	x
1613  0579 72fb1d        	addw	x,(OFST-27,sp)
1614  057c 54            	srlw	x
1615  057d 1f1d          	ldw	(OFST-27,sp),x
1617                     ; 267 				mean_threshold_8=mean_threshold_16/256;
1619  057f 7b1d          	ld	a,(OFST-27,sp)
1620  0581 6b23          	ld	(OFST-21,sp),a
1622                     ; 268 				if(mean_threshold_8==0)
1624  0583 0d23          	tnz	(OFST-21,sp)
1625  0585 2609          	jrne	L174
1626                     ; 270 					mean_threshold_8=1;
1628  0587 a601          	ld	a,#1
1629  0589 6b23          	ld	(OFST-21,sp),a
1631                     ; 271 					mean_threshold_16=0x0100;
1633  058b ae0100        	ldw	x,#256
1634  058e 1f1d          	ldw	(OFST-27,sp),x
1636  0590               L174:
1637                     ; 276 					if(mean==0) Serial_print_string("0");
1639  0590 0d29          	tnz	(OFST-15,sp)
1640  0592 2606          	jrne	L374
1643  0594 ae0110        	ldw	x,#L324
1644  0597 cd090f        	call	_Serial_print_string
1646  059a               L374:
1647                     ; 277 					Serial_print_int(mean);
1649  059a 7b29          	ld	a,(OFST-15,sp)
1650  059c 5f            	clrw	x
1651  059d 97            	ld	xl,a
1652  059e cd0938        	call	_Serial_print_int
1654                     ; 279 					Serial_print_string(" ");
1656  05a1 ae010c        	ldw	x,#L574
1657  05a4 cd090f        	call	_Serial_print_string
1659                     ; 282 					if(rms==0) Serial_print_string("0");
1661  05a7 1e33          	ldw	x,(OFST-5,sp)
1662  05a9 2606          	jrne	L774
1665  05ab ae0110        	ldw	x,#L324
1666  05ae cd090f        	call	_Serial_print_string
1668  05b1               L774:
1669                     ; 283 					Serial_print_int(rms);
1671  05b1 1e33          	ldw	x,(OFST-5,sp)
1672  05b3 cd0938        	call	_Serial_print_int
1674                     ; 285 					Serial_print_string(" ");
1676  05b6 ae010c        	ldw	x,#L574
1677  05b9 cd090f        	call	_Serial_print_string
1679                     ; 286 					if(mean_threshold_8==0) Serial_print_string("0");
1681  05bc 0d23          	tnz	(OFST-21,sp)
1682  05be 2606          	jrne	L105
1685  05c0 ae0110        	ldw	x,#L324
1686  05c3 cd090f        	call	_Serial_print_string
1688  05c6               L105:
1689                     ; 287 					Serial_print_int(mean_threshold_8);
1691  05c6 7b23          	ld	a,(OFST-21,sp)
1692  05c8 5f            	clrw	x
1693  05c9 97            	ld	xl,a
1694  05ca cd0938        	call	_Serial_print_int
1696                     ; 289 					Serial_newline();
1698  05cd cd099b        	call	_Serial_newline
1701  05d0 acb604b6      	jpf	L154
1702  05d4               L17:
1703                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1705  05d4 4b40          	push	#64
1706  05d6 4b20          	push	#32
1707  05d8 ae500f        	ldw	x,#20495
1708  05db cd0000        	call	_GPIO_Init
1710  05de 85            	popw	x
1711                     ; 296 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1713  05df 4b40          	push	#64
1714  05e1 4b40          	push	#64
1715  05e3 ae500f        	ldw	x,#20495
1716  05e6 cd0000        	call	_GPIO_Init
1718  05e9 85            	popw	x
1719  05ea               L305:
1720                     ; 299 			  setMatrixHighZ();
1722  05ea cd09aa        	call	_setMatrixHighZ
1724                     ; 300 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1726  05ed 4b20          	push	#32
1727  05ef ae500f        	ldw	x,#20495
1728  05f2 cd0000        	call	_GPIO_ReadInputPin
1730  05f5 5b01          	addw	sp,#1
1731  05f7 4d            	tnz	a
1732  05f8 2618          	jrne	L705
1733                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1735  05fa 4bd0          	push	#208
1736  05fc 4b08          	push	#8
1737  05fe ae500a        	ldw	x,#20490
1738  0601 cd0000        	call	_GPIO_Init
1740  0604 85            	popw	x
1741                     ; 305 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1743  0605 4bc0          	push	#192
1744  0607 4b20          	push	#32
1745  0609 ae500a        	ldw	x,#20490
1746  060c cd0000        	call	_GPIO_Init
1748  060f 85            	popw	x
1750  0610 20d8          	jra	L305
1751  0612               L705:
1752                     ; 306 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1754  0612 4b40          	push	#64
1755  0614 ae500f        	ldw	x,#20495
1756  0617 cd0000        	call	_GPIO_ReadInputPin
1758  061a 5b01          	addw	sp,#1
1759  061c 4d            	tnz	a
1760  061d 26cb          	jrne	L305
1761                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1763  061f 4bd0          	push	#208
1764  0621 4b10          	push	#16
1765  0623 ae500a        	ldw	x,#20490
1766  0626 cd0000        	call	_GPIO_Init
1768  0629 85            	popw	x
1769                     ; 308 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1771  062a 4bc0          	push	#192
1772  062c 4b40          	push	#64
1773  062e ae500a        	ldw	x,#20490
1774  0631 cd0000        	call	_GPIO_Init
1776  0634 85            	popw	x
1777  0635 20b3          	jra	L305
1778  0637               L37:
1779                     ; 314 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1781  0637 c650c6        	ld	a,20678
1782  063a a4e7          	and	a,#231
1783  063c c750c6        	ld	20678,a
1784                     ; 316 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1786  063f 4bf0          	push	#240
1787  0641 4b20          	push	#32
1788  0643 ae500f        	ldw	x,#20495
1789  0646 cd0000        	call	_GPIO_Init
1791  0649 85            	popw	x
1792                     ; 317 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1794  064a 4b40          	push	#64
1795  064c 4b40          	push	#64
1796  064e ae500f        	ldw	x,#20495
1797  0651 cd0000        	call	_GPIO_Init
1799  0654 85            	popw	x
1800                     ; 318 			UART1_DeInit();
1802  0655 cd0000        	call	_UART1_DeInit
1804                     ; 319 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1806  0658 4b0c          	push	#12
1807  065a 4b80          	push	#128
1808  065c 4b00          	push	#0
1809  065e 4b00          	push	#0
1810  0660 4b00          	push	#0
1811  0662 ae4240        	ldw	x,#16960
1812  0665 89            	pushw	x
1813  0666 ae000f        	ldw	x,#15
1814  0669 89            	pushw	x
1815  066a cd0000        	call	_UART1_Init
1817  066d 5b09          	addw	sp,#9
1818                     ; 321 			UART1_Cmd(ENABLE);
1820  066f a601          	ld	a,#1
1821  0671 cd0000        	call	_UART1_Cmd
1823                     ; 323 			Serial_print_string("Mode: ");
1825  0674 ae0105        	ldw	x,#L515
1826  0677 cd090f        	call	_Serial_print_string
1828                     ; 324 			Serial_print_int(test_mode);
1830  067a 1e33          	ldw	x,(OFST-5,sp)
1831  067c cd0938        	call	_Serial_print_int
1833                     ; 325 			Serial_newline();
1835  067f cd099b        	call	_Serial_newline
1837                     ; 328 			Serial_print_string("Params v2: ");
1839  0682 ae00f9        	ldw	x,#L715
1840  0685 cd090f        	call	_Serial_print_string
1842                     ; 335 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1844  0688 c650c6        	ld	a,20678
1845  068b 5f            	clrw	x
1846  068c 97            	ld	xl,a
1847  068d cd0938        	call	_Serial_print_int
1849                     ; 336 			Serial_print_string(" ");
1851  0690 ae010c        	ldw	x,#L574
1852  0693 cd090f        	call	_Serial_print_string
1854                     ; 337 			Serial_print_int(CLK->CCOR);//0
1856  0696 c650c9        	ld	a,20681
1857  0699 5f            	clrw	x
1858  069a 97            	ld	xl,a
1859  069b cd0938        	call	_Serial_print_int
1861                     ; 338 			Serial_newline();
1863  069e cd099b        	call	_Serial_newline
1865                     ; 340 			TIM4->PSCR= 7;// init divider register /128	
1867  06a1 35075347      	mov	21319,#7
1868                     ; 341 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1870  06a5 357d5348      	mov	21320,#125
1871                     ; 342 			TIM4->EGR= TIM4_EGR_UG;// update registers
1873  06a9 35015345      	mov	21317,#1
1874                     ; 343 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1876  06ad c65340        	ld	a,21312
1877  06b0 aa85          	or	a,#133
1878  06b2 c75340        	ld	21312,a
1879                     ; 344 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1881  06b5 35015343      	mov	21315,#1
1882                     ; 345 			enableInterrupts();
1885  06b9 9a            rim
1887  06ba               L125:
1888                     ; 348 				if(tms%1000==0 && mean_sum!=tms/1000)
1890  06ba ae0000        	ldw	x,#_tms
1891  06bd cd0000        	call	c_ltor
1893  06c0 ae0018        	ldw	x,#L42
1894  06c3 cd0000        	call	c_lumd
1896  06c6 cd0000        	call	c_lrzmp
1898  06c9 2642          	jrne	L525
1900  06cb ae0000        	ldw	x,#_tms
1901  06ce cd0000        	call	c_ltor
1903  06d1 ae0018        	ldw	x,#L42
1904  06d4 cd0000        	call	c_ludv
1906  06d7 96            	ldw	x,sp
1907  06d8 1c0024        	addw	x,#OFST-20
1908  06db cd0000        	call	c_lcmp
1910  06de 272d          	jreq	L525
1911                     ; 350 					Serial_print_string("time: ");
1913  06e0 ae00f2        	ldw	x,#L725
1914  06e3 cd090f        	call	_Serial_print_string
1916                     ; 351 					mean_sum=tms/1000;
1918  06e6 ae0000        	ldw	x,#_tms
1919  06e9 cd0000        	call	c_ltor
1921  06ec ae0018        	ldw	x,#L42
1922  06ef cd0000        	call	c_ludv
1924  06f2 96            	ldw	x,sp
1925  06f3 1c0024        	addw	x,#OFST-20
1926  06f6 cd0000        	call	c_rtol
1929                     ; 352 					Serial_print_int(tms/1000);
1931  06f9 ae0000        	ldw	x,#_tms
1932  06fc cd0000        	call	c_ltor
1934  06ff ae0018        	ldw	x,#L42
1935  0702 cd0000        	call	c_ludv
1937  0705 be02          	ldw	x,c_lreg+2
1938  0707 cd0938        	call	_Serial_print_int
1940                     ; 353 					Serial_newline();
1942  070a cd099b        	call	_Serial_newline
1944  070d               L525:
1945                     ; 361 				setMatrixHighZ();
1947  070d cd09aa        	call	_setMatrixHighZ
1949                     ; 362 				mean_low=tms%20;
1951  0710 ae0000        	ldw	x,#_tms
1952  0713 cd0000        	call	c_ltor
1954  0716 ae0020        	ldw	x,#L25
1955  0719 cd0000        	call	c_lumd
1957  071c 96            	ldw	x,sp
1958  071d 1c001f        	addw	x,#OFST-25
1959  0720 cd0000        	call	c_rtol
1962                     ; 363 				mean_high=(tms/20)%100;
1964  0723 ae0000        	ldw	x,#_tms
1965  0726 cd0000        	call	c_ltor
1967  0729 ae0020        	ldw	x,#L25
1968  072c cd0000        	call	c_ludv
1970  072f ae0024        	ldw	x,#L45
1971  0732 cd0000        	call	c_lumd
1973  0735 96            	ldw	x,sp
1974  0736 1c002d        	addw	x,#OFST-11
1975  0739 cd0000        	call	c_rtol
1978                     ; 364 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
1980  073c ae0000        	ldw	x,#_tms
1981  073f cd0000        	call	c_ltor
1983  0742 ae0028        	ldw	x,#L65
1984  0745 cd0000        	call	c_ludv
1986  0748 b603          	ld	a,c_lreg+3
1987  074a a401          	and	a,#1
1988  074c b703          	ld	c_lreg+3,a
1989  074e 3f02          	clr	c_lreg+2
1990  0750 3f01          	clr	c_lreg+1
1991  0752 3f00          	clr	c_lreg
1992  0754 96            	ldw	x,sp
1993  0755 1c0001        	addw	x,#OFST-55
1994  0758 cd0000        	call	c_rtol
1997  075b 96            	ldw	x,sp
1998  075c 1c002d        	addw	x,#OFST-11
1999  075f cd0000        	call	c_ltor
2001  0762 a602          	ld	a,#2
2002  0764 cd0000        	call	c_lursh
2004  0767 96            	ldw	x,sp
2005  0768 1c001f        	addw	x,#OFST-25
2006  076b cd0000        	call	c_lcmp
2008  076e 2405          	jruge	L06
2009  0770 ae0001        	ldw	x,#1
2010  0773 2001          	jra	L26
2011  0775               L06:
2012  0775 5f            	clrw	x
2013  0776               L26:
2014  0776 cd0000        	call	c_itolx
2016  0779 96            	ldw	x,sp
2017  077a 1c0001        	addw	x,#OFST-55
2018  077d cd0000        	call	c_lxor
2020  0780 cd0000        	call	c_lrzmp
2022  0783 270f          	jreq	L135
2023                     ; 366 					setRGB(4,1);
2025  0785 ae0001        	ldw	x,#1
2026  0788 89            	pushw	x
2027  0789 ae0004        	ldw	x,#4
2028  078c cd09c1        	call	_setRGB
2030  078f 85            	popw	x
2032  0790 acba06ba      	jpf	L125
2033  0794               L135:
2034                     ; 369 					setRGB(4,0);
2036  0794 5f            	clrw	x
2037  0795 89            	pushw	x
2038  0796 ae0004        	ldw	x,#4
2039  0799 cd09c1        	call	_setRGB
2041  079c 85            	popw	x
2042  079d acba06ba      	jpf	L125
2043  07a1               L57:
2044                     ; 375 			Serial_print_string("Mode: ");
2046  07a1 ae0105        	ldw	x,#L515
2047  07a4 cd090f        	call	_Serial_print_string
2049                     ; 376 			Serial_print_int(test_mode);
2051  07a7 1e33          	ldw	x,(OFST-5,sp)
2052  07a9 cd0938        	call	_Serial_print_int
2054                     ; 377 			Serial_newline();
2056  07ac cd099b        	call	_Serial_newline
2058                     ; 381 			Serial_print_string("Params: ");
2060  07af ae00e9        	ldw	x,#L535
2061  07b2 cd090f        	call	_Serial_print_string
2063                     ; 382 			Serial_print_int(CLK->CKDIVR);//
2065  07b5 c650c6        	ld	a,20678
2066  07b8 5f            	clrw	x
2067  07b9 97            	ld	xl,a
2068  07ba cd0938        	call	_Serial_print_int
2070                     ; 383 			Serial_print_string(" ");
2072  07bd ae010c        	ldw	x,#L574
2073  07c0 cd090f        	call	_Serial_print_string
2075                     ; 384 			Serial_print_int(CLK->CCOR);//
2077  07c3 c650c9        	ld	a,20681
2078  07c6 5f            	clrw	x
2079  07c7 97            	ld	xl,a
2080  07c8 cd0938        	call	_Serial_print_int
2082                     ; 385 			Serial_newline();
2084  07cb cd099b        	call	_Serial_newline
2086                     ; 387 			TIM4->PSCR= 7;// init divider register /128	
2088  07ce 35075347      	mov	21319,#7
2089                     ; 388 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2091  07d2 35805348      	mov	21320,#128
2092                     ; 389 			TIM4->EGR= TIM4_EGR_UG;// update registers
2094  07d6 35015345      	mov	21317,#1
2095                     ; 390 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2097  07da c65340        	ld	a,21312
2098  07dd aa85          	or	a,#133
2099  07df c75340        	ld	21312,a
2100                     ; 391 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2102  07e2 35015343      	mov	21315,#1
2103                     ; 392 			enableInterrupts();
2106  07e6 9a            rim
2108  07e7               L735:
2109                     ; 395 				for(iter=0;iter<5000;iter++){}
2111  07e7 ae0000        	ldw	x,#0
2112  07ea 1f37          	ldw	(OFST-1,sp),x
2113  07ec ae0000        	ldw	x,#0
2114  07ef 1f35          	ldw	(OFST-3,sp),x
2116  07f1               L345:
2119  07f1 96            	ldw	x,sp
2120  07f2 1c0035        	addw	x,#OFST-3
2121  07f5 a601          	ld	a,#1
2122  07f7 cd0000        	call	c_lgadc
2127  07fa 96            	ldw	x,sp
2128  07fb 1c0035        	addw	x,#OFST-3
2129  07fe cd0000        	call	c_ltor
2131  0801 ae002c        	ldw	x,#L46
2132  0804 cd0000        	call	c_lcmp
2134  0807 25e8          	jrult	L345
2135                     ; 396 				Serial_print_string("time: ");
2137  0809 ae00f2        	ldw	x,#L725
2138  080c cd090f        	call	_Serial_print_string
2140                     ; 397 				Serial_print_int(tms>>16);
2142  080f be00          	ldw	x,_tms
2143  0811 cd0938        	call	_Serial_print_int
2145                     ; 398 				Serial_print_string(" ");
2147  0814 ae010c        	ldw	x,#L574
2148  0817 cd090f        	call	_Serial_print_string
2150                     ; 399 				Serial_print_int((uint16_t)tms);
2152  081a be02          	ldw	x,_tms+2
2153  081c cd0938        	call	_Serial_print_int
2155                     ; 400 				Serial_newline();
2157  081f cd099b        	call	_Serial_newline
2160  0822 20c3          	jra	L735
2161  0824               L77:
2162                     ; 405 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2164  0824 c650c6        	ld	a,20678
2165  0827 a4e7          	and	a,#231
2166  0829 c750c6        	ld	20678,a
2167                     ; 407 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2169  082c 4bf0          	push	#240
2170  082e 4b20          	push	#32
2171  0830 ae500f        	ldw	x,#20495
2172  0833 cd0000        	call	_GPIO_Init
2174  0836 85            	popw	x
2175                     ; 408 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2177  0837 4b40          	push	#64
2178  0839 4b40          	push	#64
2179  083b ae500f        	ldw	x,#20495
2180  083e cd0000        	call	_GPIO_Init
2182  0841 85            	popw	x
2183                     ; 409 			UART1_DeInit();
2185  0842 cd0000        	call	_UART1_DeInit
2187                     ; 410 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2189  0845 4b0c          	push	#12
2190  0847 4b80          	push	#128
2191  0849 4b00          	push	#0
2192  084b 4b00          	push	#0
2193  084d 4b00          	push	#0
2194  084f ae4240        	ldw	x,#16960
2195  0852 89            	pushw	x
2196  0853 ae000f        	ldw	x,#15
2197  0856 89            	pushw	x
2198  0857 cd0000        	call	_UART1_Init
2200  085a 5b09          	addw	sp,#9
2201                     ; 412 			UART1_Cmd(ENABLE);
2203  085c a601          	ld	a,#1
2204  085e cd0000        	call	_UART1_Cmd
2206                     ; 414 			Serial_print_string("Mode: ");
2208  0861 ae0105        	ldw	x,#L515
2209  0864 cd090f        	call	_Serial_print_string
2211                     ; 415 			Serial_print_int(test_mode);
2213  0867 1e33          	ldw	x,(OFST-5,sp)
2214  0869 cd0938        	call	_Serial_print_int
2216                     ; 416 			Serial_newline();
2218  086c cd099b        	call	_Serial_newline
2220                     ; 418 			TIM4->PSCR= 7;// init divider register /128	
2222  086f 35075347      	mov	21319,#7
2223                     ; 419 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2225  0873 357d5348      	mov	21320,#125
2226                     ; 420 			TIM4->EGR= TIM4_EGR_UG;// update registers
2228  0877 35015345      	mov	21317,#1
2229                     ; 421 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2231  087b c65340        	ld	a,21312
2232  087e aa85          	or	a,#133
2233  0880 c75340        	ld	21312,a
2234                     ; 422 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2236  0883 35015343      	mov	21315,#1
2237                     ; 423 			enableInterrupts();
2240  0887 9a            rim
2242  0888               L155:
2243                     ; 429 					setMatrixHighZ();
2245  0888 cd09aa        	call	_setMatrixHighZ
2247                     ; 430 					mean_sum=tms/60;
2249  088b ae0000        	ldw	x,#_tms
2250  088e cd0000        	call	c_ltor
2252  0891 ae0030        	ldw	x,#L66
2253  0894 cd0000        	call	c_ludv
2255  0897 96            	ldw	x,sp
2256  0898 1c0024        	addw	x,#OFST-20
2257  089b cd0000        	call	c_rtol
2260                     ; 431 					mean_low=tms%2;//is high or low charlieplexing
2262  089e b603          	ld	a,_tms+3
2263  08a0 a401          	and	a,#1
2264  08a2 6b22          	ld	(OFST-22,sp),a
2265  08a4 4f            	clr	a
2266  08a5 6b21          	ld	(OFST-23,sp),a
2267  08a7 6b20          	ld	(OFST-24,sp),a
2268  08a9 6b1f          	ld	(OFST-25,sp),a
2270                     ; 432 					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
2272  08ab 96            	ldw	x,sp
2273  08ac 1c0024        	addw	x,#OFST-20
2274  08af cd0000        	call	c_ltor
2276  08b2 3400          	srl	c_lreg
2277  08b4 3601          	rrc	c_lreg+1
2278  08b6 3602          	rrc	c_lreg+2
2279  08b8 3603          	rrc	c_lreg+3
2280  08ba ae0034        	ldw	x,#L07
2281  08bd cd0000        	call	c_lumd
2283  08c0 96            	ldw	x,sp
2284  08c1 1c002d        	addw	x,#OFST-11
2285  08c4 cd0000        	call	c_rtol
2288                     ; 433 					sound_level=(mean_sum/10)%3;//RGB
2290  08c7 96            	ldw	x,sp
2291  08c8 1c0024        	addw	x,#OFST-20
2292  08cb cd0000        	call	c_ltor
2294  08ce ae001c        	ldw	x,#L04
2295  08d1 cd0000        	call	c_ludv
2297  08d4 ae0038        	ldw	x,#L27
2298  08d7 cd0000        	call	c_lumd
2300  08da be02          	ldw	x,c_lreg+2
2301  08dc 1f31          	ldw	(OFST-7,sp),x
2303                     ; 434 					setRGB(mean_high+(mean_low?5:0),sound_level);
2305  08de 1e31          	ldw	x,(OFST-7,sp)
2306  08e0 89            	pushw	x
2307  08e1 96            	ldw	x,sp
2308  08e2 1c0021        	addw	x,#OFST-23
2309  08e5 cd0000        	call	c_lzmp
2311  08e8 2705          	jreq	L47
2312  08ea ae0005        	ldw	x,#5
2313  08ed 2001          	jra	L67
2314  08ef               L47:
2315  08ef 5f            	clrw	x
2316  08f0               L67:
2317  08f0 cd0000        	call	c_itolx
2319  08f3 96            	ldw	x,sp
2320  08f4 1c002f        	addw	x,#OFST-9
2321  08f7 cd0000        	call	c_ladd
2323  08fa be02          	ldw	x,c_lreg+2
2324  08fc cd09c1        	call	_setRGB
2326  08ff 85            	popw	x
2328  0900 2086          	jpf	L155
2353                     ; 442 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2355                     	switch	.text
2356  0902               f_TIM4_UPD_OVF_IRQHandler:
2360                     ; 443 	TIM4->SR1&=~TIM4_SR1_UIF;
2362  0902 72115344      	bres	21316,#0
2363                     ; 444 	tms++;
2365  0906 ae0000        	ldw	x,#_tms
2366  0909 a601          	ld	a,#1
2367  090b cd0000        	call	c_lgadc
2369                     ; 445 }
2372  090e 80            	iret
2418                     ; 468  void Serial_print_string (char string[])
2418                     ; 469  {
2420                     	switch	.text
2421  090f               _Serial_print_string:
2423  090f 89            	pushw	x
2424  0910 88            	push	a
2425       00000001      OFST:	set	1
2428                     ; 471 	 char i=0;
2430  0911 0f01          	clr	(OFST+0,sp)
2433  0913 2016          	jra	L316
2434  0915               L706:
2435                     ; 475 		UART1_SendData8(string[i]);
2437  0915 7b01          	ld	a,(OFST+0,sp)
2438  0917 5f            	clrw	x
2439  0918 97            	ld	xl,a
2440  0919 72fb02        	addw	x,(OFST+1,sp)
2441  091c f6            	ld	a,(x)
2442  091d cd0000        	call	_UART1_SendData8
2445  0920               L126:
2446                     ; 476 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2448  0920 ae0080        	ldw	x,#128
2449  0923 cd0000        	call	_UART1_GetFlagStatus
2451  0926 4d            	tnz	a
2452  0927 27f7          	jreq	L126
2453                     ; 477 		i++;
2455  0929 0c01          	inc	(OFST+0,sp)
2457  092b               L316:
2458                     ; 473 	 while (string[i] != 0x00)
2460  092b 7b01          	ld	a,(OFST+0,sp)
2461  092d 5f            	clrw	x
2462  092e 97            	ld	xl,a
2463  092f 72fb02        	addw	x,(OFST+1,sp)
2464  0932 7d            	tnz	(x)
2465  0933 26e0          	jrne	L706
2466                     ; 479  }
2469  0935 5b03          	addw	sp,#3
2470  0937 81            	ret
2473                     	switch	.const
2474  003c               L526_digit:
2475  003c 00            	dc.b	0
2476  003d 00000000      	ds.b	4
2529                     ; 481  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2529                     ; 482  {
2530                     	switch	.text
2531  0938               _Serial_print_int:
2533  0938 89            	pushw	x
2534  0939 5208          	subw	sp,#8
2535       00000008      OFST:	set	8
2538                     ; 483 	 char count = 0;
2540  093b 0f08          	clr	(OFST+0,sp)
2542                     ; 484 	 char digit[5] = "";
2544  093d 96            	ldw	x,sp
2545  093e 1c0003        	addw	x,#OFST-5
2546  0941 90ae003c      	ldw	y,#L526_digit
2547  0945 a605          	ld	a,#5
2548  0947 cd0000        	call	c_xymov
2551  094a 2023          	jra	L166
2552  094c               L556:
2553                     ; 488 		 digit[count] = number%10;
2555  094c 96            	ldw	x,sp
2556  094d 1c0003        	addw	x,#OFST-5
2557  0950 9f            	ld	a,xl
2558  0951 5e            	swapw	x
2559  0952 1b08          	add	a,(OFST+0,sp)
2560  0954 2401          	jrnc	L621
2561  0956 5c            	incw	x
2562  0957               L621:
2563  0957 02            	rlwa	x,a
2564  0958 1609          	ldw	y,(OFST+1,sp)
2565  095a a60a          	ld	a,#10
2566  095c cd0000        	call	c_smody
2568  095f 9001          	rrwa	y,a
2569  0961 f7            	ld	(x),a
2570  0962 9002          	rlwa	y,a
2571                     ; 489 		 count++;
2573  0964 0c08          	inc	(OFST+0,sp)
2575                     ; 490 		 number = number/10;
2577  0966 1e09          	ldw	x,(OFST+1,sp)
2578  0968 a60a          	ld	a,#10
2579  096a cd0000        	call	c_sdivx
2581  096d 1f09          	ldw	(OFST+1,sp),x
2582  096f               L166:
2583                     ; 486 	 while (number != 0) //split the int to char array 
2585  096f 1e09          	ldw	x,(OFST+1,sp)
2586  0971 26d9          	jrne	L556
2588  0973 201f          	jra	L766
2589  0975               L566:
2590                     ; 495 		UART1_SendData8(digit[count-1] + 0x30);
2592  0975 96            	ldw	x,sp
2593  0976 1c0003        	addw	x,#OFST-5
2594  0979 1f01          	ldw	(OFST-7,sp),x
2596  097b 7b08          	ld	a,(OFST+0,sp)
2597  097d 5f            	clrw	x
2598  097e 97            	ld	xl,a
2599  097f 5a            	decw	x
2600  0980 72fb01        	addw	x,(OFST-7,sp)
2601  0983 f6            	ld	a,(x)
2602  0984 ab30          	add	a,#48
2603  0986 cd0000        	call	_UART1_SendData8
2606  0989               L576:
2607                     ; 496 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2609  0989 ae0080        	ldw	x,#128
2610  098c cd0000        	call	_UART1_GetFlagStatus
2612  098f 4d            	tnz	a
2613  0990 27f7          	jreq	L576
2614                     ; 497 		count--; 
2616  0992 0a08          	dec	(OFST+0,sp)
2618  0994               L766:
2619                     ; 493 	 while (count !=0) //print char array in correct direction 
2621  0994 0d08          	tnz	(OFST+0,sp)
2622  0996 26dd          	jrne	L566
2623                     ; 499  }
2626  0998 5b0a          	addw	sp,#10
2627  099a 81            	ret
2652                     ; 501  void Serial_newline(void)
2652                     ; 502  {
2653                     	switch	.text
2654  099b               _Serial_newline:
2658                     ; 503 	 UART1_SendData8(0x0a);
2660  099b a60a          	ld	a,#10
2661  099d cd0000        	call	_UART1_SendData8
2664  09a0               L317:
2665                     ; 504 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2667  09a0 ae0080        	ldw	x,#128
2668  09a3 cd0000        	call	_UART1_GetFlagStatus
2670  09a6 4d            	tnz	a
2671  09a7 27f7          	jreq	L317
2672                     ; 505  }
2675  09a9 81            	ret
2699                     ; 507 void setMatrixHighZ()
2699                     ; 508 {
2700                     	switch	.text
2701  09aa               _setMatrixHighZ:
2705                     ; 513 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2707  09aa 4b00          	push	#0
2708  09ac 4bf8          	push	#248
2709  09ae ae500a        	ldw	x,#20490
2710  09b1 cd0000        	call	_GPIO_Init
2712  09b4 85            	popw	x
2713                     ; 514 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2715  09b5 4b00          	push	#0
2716  09b7 4b0c          	push	#12
2717  09b9 ae500f        	ldw	x,#20495
2718  09bc cd0000        	call	_GPIO_Init
2720  09bf 85            	popw	x
2721                     ; 515 }
2724  09c0 81            	ret
2768                     ; 517 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2769                     	switch	.text
2770  09c1               _setRGB:
2772  09c1 89            	pushw	x
2773       00000000      OFST:	set	0
2778  09c2 1e05          	ldw	x,(OFST+5,sp)
2779  09c4 89            	pushw	x
2780  09c5 1e03          	ldw	x,(OFST+3,sp)
2781  09c7 89            	pushw	x
2782  09c8 a601          	ld	a,#1
2783  09ca ad11          	call	_setLED
2785  09cc 5b04          	addw	sp,#4
2789  09ce 85            	popw	x
2790  09cf 81            	ret
2825                     ; 518 void setWhite(int led_index){ setLED(0,led_index,0); }
2826                     	switch	.text
2827  09d0               _setWhite:
2829  09d0 89            	pushw	x
2830       00000000      OFST:	set	0
2835  09d1 5f            	clrw	x
2836  09d2 89            	pushw	x
2837  09d3 1e03          	ldw	x,(OFST+3,sp)
2838  09d5 89            	pushw	x
2839  09d6 4f            	clr	a
2840  09d7 ad04          	call	_setLED
2842  09d9 5b04          	addw	sp,#4
2846  09db 85            	popw	x
2847  09dc 81            	ret
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
3198                     ; 520 void setLED(bool is_rgb,int led_index,int rgb_index)
3198                     ; 521 {
3199                     	switch	.text
3200  09dd               _setLED:
3202  09dd 88            	push	a
3203  09de 52b6          	subw	sp,#182
3204       000000b6      OFST:	set	182
3207                     ; 522   const unsigned short rgb_lookup[10][3][2]={
3207                     ; 523 		{{0,1},{0,2},{1,2}},//7
3207                     ; 524 		{{1,0},{2,0},{2,1}},//3
3207                     ; 525 		{{5,0},{5,1},{5,2}},//1
3207                     ; 526 		{{6,0},{6,1},{6,2}},//20
3207                     ; 527 		{{6,5},{6,4},{5,4}},//22
3207                     ; 528 		{{4,3},{5,3},{6,3}},//23
3207                     ; 529 		{{3,4},{3,5},{3,6}},//21
3207                     ; 530 		{{0,5},{0,6},{1,6}},//19
3207                     ; 531 		{{0,4},{1,4},{2,4}},//18
3207                     ; 532 		{{0,3},{1,3},{2,3}} //2
3207                     ; 533 	};
3209  09e0 96            	ldw	x,sp
3210  09e1 1c000e        	addw	x,#OFST-168
3211  09e4 90ae0041      	ldw	y,#L767_rgb_lookup
3212  09e8 a678          	ld	a,#120
3213  09ea cd0000        	call	c_xymov
3215                     ; 534 	const unsigned short white_lookup[12][2]={
3215                     ; 535 		{3,0},//6
3215                     ; 536 		{3,1},//4
3215                     ; 537 		{3,2},//5
3215                     ; 538 		{4,0},//14
3215                     ; 539 		{1,5},//8
3215                     ; 540 		{2,5},//9
3215                     ; 541 		{4,1},//10
3215                     ; 542 		{4,2},//16
3215                     ; 543 		{2,6},//17
3215                     ; 544 		{4,6},//12
3215                     ; 545 		{4,5},//13
3215                     ; 546 		{5,6} //11
3215                     ; 547 	};
3217  09ed 96            	ldw	x,sp
3218  09ee 1c0086        	addw	x,#OFST-48
3219  09f1 90ae00b9      	ldw	y,#L177_white_lookup
3220  09f5 a630          	ld	a,#48
3221  09f7 cd0000        	call	c_xymov
3223                     ; 548 	bool is_low=0;
3225  09fa 0fb6          	clr	(OFST+0,sp)
3227  09fc               L1611:
3228                     ; 552 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3230  09fc 0db7          	tnz	(OFST+1,sp)
3231  09fe 2726          	jreq	L241
3232  0a00 7bb6          	ld	a,(OFST+0,sp)
3233  0a02 5f            	clrw	x
3234  0a03 97            	ld	xl,a
3235  0a04 58            	sllw	x
3236  0a05 1f09          	ldw	(OFST-173,sp),x
3238  0a07 1ebc          	ldw	x,(OFST+6,sp)
3239  0a09 58            	sllw	x
3240  0a0a 58            	sllw	x
3241  0a0b 1f07          	ldw	(OFST-175,sp),x
3243  0a0d 96            	ldw	x,sp
3244  0a0e 1c000e        	addw	x,#OFST-168
3245  0a11 1f05          	ldw	(OFST-177,sp),x
3247  0a13 1eba          	ldw	x,(OFST+4,sp)
3248  0a15 a60c          	ld	a,#12
3249  0a17 cd0000        	call	c_bmulx
3251  0a1a 72fb05        	addw	x,(OFST-177,sp)
3252  0a1d 72fb07        	addw	x,(OFST-175,sp)
3253  0a20 72fb09        	addw	x,(OFST-173,sp)
3254  0a23 fe            	ldw	x,(x)
3255  0a24 2018          	jra	L441
3256  0a26               L241:
3257  0a26 7bb6          	ld	a,(OFST+0,sp)
3258  0a28 5f            	clrw	x
3259  0a29 97            	ld	xl,a
3260  0a2a 58            	sllw	x
3261  0a2b 1f03          	ldw	(OFST-179,sp),x
3263  0a2d 96            	ldw	x,sp
3264  0a2e 1c0086        	addw	x,#OFST-48
3265  0a31 1f01          	ldw	(OFST-181,sp),x
3267  0a33 1eba          	ldw	x,(OFST+4,sp)
3268  0a35 58            	sllw	x
3269  0a36 58            	sllw	x
3270  0a37 72fb01        	addw	x,(OFST-181,sp)
3271  0a3a 72fb03        	addw	x,(OFST-179,sp)
3272  0a3d fe            	ldw	x,(x)
3273  0a3e               L441:
3275                     ; 584 			}break;
3276  0a3e 5d            	tnzw	x
3277  0a3f 2714          	jreq	L377
3278  0a41 5a            	decw	x
3279  0a42 271c          	jreq	L577
3280  0a44 5a            	decw	x
3281  0a45 2724          	jreq	L777
3282  0a47 5a            	decw	x
3283  0a48 272c          	jreq	L1001
3284  0a4a 5a            	decw	x
3285  0a4b 2734          	jreq	L3001
3286  0a4d 5a            	decw	x
3287  0a4e 273c          	jreq	L5001
3288  0a50 5a            	decw	x
3289  0a51 2744          	jreq	L7001
3290  0a53 204b          	jra	L1711
3291  0a55               L377:
3292                     ; 555 				GPIOx=GPIOD;
3294  0a55 ae500f        	ldw	x,#20495
3295  0a58 1f0b          	ldw	(OFST-171,sp),x
3297                     ; 556 				PortPin=GPIO_PIN_3;
3299  0a5a a608          	ld	a,#8
3300  0a5c 6b0d          	ld	(OFST-169,sp),a
3302                     ; 557 			}break;
3304  0a5e 2040          	jra	L1711
3305  0a60               L577:
3306                     ; 559 				GPIOx=GPIOD;
3308  0a60 ae500f        	ldw	x,#20495
3309  0a63 1f0b          	ldw	(OFST-171,sp),x
3311                     ; 560 				PortPin=GPIO_PIN_2;
3313  0a65 a604          	ld	a,#4
3314  0a67 6b0d          	ld	(OFST-169,sp),a
3316                     ; 561 			}break;
3318  0a69 2035          	jra	L1711
3319  0a6b               L777:
3320                     ; 563 				GPIOx=GPIOC;
3322  0a6b ae500a        	ldw	x,#20490
3323  0a6e 1f0b          	ldw	(OFST-171,sp),x
3325                     ; 564 				PortPin=GPIO_PIN_7;
3327  0a70 a680          	ld	a,#128
3328  0a72 6b0d          	ld	(OFST-169,sp),a
3330                     ; 565 			}break;
3332  0a74 202a          	jra	L1711
3333  0a76               L1001:
3334                     ; 567 				GPIOx=GPIOC;
3336  0a76 ae500a        	ldw	x,#20490
3337  0a79 1f0b          	ldw	(OFST-171,sp),x
3339                     ; 568 				PortPin=GPIO_PIN_6;
3341  0a7b a640          	ld	a,#64
3342  0a7d 6b0d          	ld	(OFST-169,sp),a
3344                     ; 569 			}break;
3346  0a7f 201f          	jra	L1711
3347  0a81               L3001:
3348                     ; 571 				GPIOx=GPIOC;
3350  0a81 ae500a        	ldw	x,#20490
3351  0a84 1f0b          	ldw	(OFST-171,sp),x
3353                     ; 572 				PortPin=GPIO_PIN_5;
3355  0a86 a620          	ld	a,#32
3356  0a88 6b0d          	ld	(OFST-169,sp),a
3358                     ; 573 			}break;
3360  0a8a 2014          	jra	L1711
3361  0a8c               L5001:
3362                     ; 575 				GPIOx=GPIOC;
3364  0a8c ae500a        	ldw	x,#20490
3365  0a8f 1f0b          	ldw	(OFST-171,sp),x
3367                     ; 576 				PortPin=GPIO_PIN_4;
3369  0a91 a610          	ld	a,#16
3370  0a93 6b0d          	ld	(OFST-169,sp),a
3372                     ; 577 			}break;
3374  0a95 2009          	jra	L1711
3375  0a97               L7001:
3376                     ; 579 				GPIOx=GPIOC;
3378  0a97 ae500a        	ldw	x,#20490
3379  0a9a 1f0b          	ldw	(OFST-171,sp),x
3381                     ; 580 				PortPin=GPIO_PIN_3;
3383  0a9c a608          	ld	a,#8
3384  0a9e 6b0d          	ld	(OFST-169,sp),a
3386                     ; 581 			}break;
3388  0aa0               L1711:
3389                     ; 586 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3391  0aa0 0db6          	tnz	(OFST+0,sp)
3392  0aa2 2704          	jreq	L641
3393  0aa4 a6c0          	ld	a,#192
3394  0aa6 2002          	jra	L051
3395  0aa8               L641:
3396  0aa8 a6d0          	ld	a,#208
3397  0aaa               L051:
3398  0aaa 88            	push	a
3399  0aab 7b0e          	ld	a,(OFST-168,sp)
3400  0aad 88            	push	a
3401  0aae 1e0d          	ldw	x,(OFST-169,sp)
3402  0ab0 cd0000        	call	_GPIO_Init
3404  0ab3 85            	popw	x
3405                     ; 587 		is_low=!is_low;
3407  0ab4 0db6          	tnz	(OFST+0,sp)
3408  0ab6 2604          	jrne	L251
3409  0ab8 a601          	ld	a,#1
3410  0aba 2001          	jra	L451
3411  0abc               L251:
3412  0abc 4f            	clr	a
3413  0abd               L451:
3414  0abd 6bb6          	ld	(OFST+0,sp),a
3416                     ; 588 	}while(is_low);
3418  0abf 0db6          	tnz	(OFST+0,sp)
3419  0ac1 2703          	jreq	L651
3420  0ac3 cc09fc        	jp	L1611
3421  0ac6               L651:
3422                     ; 589 }
3425  0ac6 5bb7          	addw	sp,#183
3426  0ac8 81            	ret
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
