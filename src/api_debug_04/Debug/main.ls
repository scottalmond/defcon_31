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
 466                     	switch	.const
 467  0010               L01:
 468  0010 00002710      	dc.l	10000
 469  0014               L21:
 470  0014 00007530      	dc.l	30000
 471  0018               L42:
 472  0018 000003e8      	dc.l	1000
 473  001c               L04:
 474  001c 0000000a      	dc.l	10
 475  0020               L25:
 476  0020 00000014      	dc.l	20
 477  0024               L45:
 478  0024 00000064      	dc.l	100
 479  0028               L65:
 480  0028 000007d0      	dc.l	2000
 481  002c               L46:
 482  002c 00001388      	dc.l	5000
 483  0030               L66:
 484  0030 0000003c      	dc.l	60
 485  0034               L07:
 486  0034 00000005      	dc.l	5
 487  0038               L27:
 488  0038 00000003      	dc.l	3
 489  003c               L001:
 490  003c 00001f40      	dc.l	8000
 491                     ; 21 int main()
 491                     ; 22 {
 492                     	switch	.text
 493  003e               _main:
 495  003e 5238          	subw	sp,#56
 496       00000038      OFST:	set	56
 499                     ; 45 	const int test_mode=8;
 501  0040 ae0008        	ldw	x,#8
 502  0043 1f33          	ldw	(OFST-5,sp),x
 504                     ; 46 	const uint8_t rms_lookup[16]={9,18,28,38,48,58,69,80,92,105,118,134,151,173,200,241};
 506  0045 96            	ldw	x,sp
 507  0046 1c0009        	addw	x,#OFST-47
 508  0049 90ae0000      	ldw	y,#L75_rms_lookup
 509  004d a610          	ld	a,#16
 510  004f cd0000        	call	c_xymov
 512                     ; 48 	unsigned long old_mean=0,mean_sum=0,mean_low=0,mean_high=0;
 516  0052 ae0000        	ldw	x,#0
 517  0055 1f29          	ldw	(OFST-15,sp),x
 518  0057 ae0000        	ldw	x,#0
 519  005a 1f27          	ldw	(OFST-17,sp),x
 525                     ; 49 	unsigned sound_level=0;
 527  005c 5f            	clrw	x
 528  005d 1f31          	ldw	(OFST-7,sp),x
 530                     ; 50 	uint8_t mean_threshold=16;
 532  005f a610          	ld	a,#16
 533  0061 6b24          	ld	(OFST-20,sp),a
 535                     ; 51 	uint8_t mean_threshold_8=1;
 537  0063 a601          	ld	a,#1
 538  0065 6b23          	ld	(OFST-21,sp),a
 540                     ; 52 	uint16_t mean_threshold_16=0x0100;
 542  0067 ae0100        	ldw	x,#256
 543  006a 1f1d          	ldw	(OFST-27,sp),x
 545                     ; 53 	unsigned int rms=0;
 547                     ; 54 	const long adc_captures=1<<8;
 549  006c ae0100        	ldw	x,#256
 550  006f 1f1b          	ldw	(OFST-29,sp),x
 551  0071 ae0000        	ldw	x,#0
 552  0074 1f19          	ldw	(OFST-31,sp),x
 554                     ; 56 	int debug=0;
 556  0076 5f            	clrw	x
 557  0077 1f2b          	ldw	(OFST-13,sp),x
 559                     ; 58 	for(rep=0;rep<1;rep++)
 561  0079 ae0000        	ldw	x,#0
 562  007c 1f2f          	ldw	(OFST-9,sp),x
 563  007e ae0000        	ldw	x,#0
 564  0081 1f2d          	ldw	(OFST-11,sp),x
 566  0083               L752:
 567                     ; 59 		for(iter=0;iter<10000;iter++){}
 569  0083 ae0000        	ldw	x,#0
 570  0086 1f37          	ldw	(OFST-1,sp),x
 571  0088 ae0000        	ldw	x,#0
 572  008b 1f35          	ldw	(OFST-3,sp),x
 574  008d               L562:
 577  008d 96            	ldw	x,sp
 578  008e 1c0035        	addw	x,#OFST-3
 579  0091 a601          	ld	a,#1
 580  0093 cd0000        	call	c_lgadc
 585  0096 96            	ldw	x,sp
 586  0097 1c0035        	addw	x,#OFST-3
 587  009a cd0000        	call	c_ltor
 589  009d ae0010        	ldw	x,#L01
 590  00a0 cd0000        	call	c_lcmp
 592  00a3 25e8          	jrult	L562
 593                     ; 58 	for(rep=0;rep<1;rep++)
 595  00a5 96            	ldw	x,sp
 596  00a6 1c002d        	addw	x,#OFST-11
 597  00a9 a601          	ld	a,#1
 598  00ab cd0000        	call	c_lgadc
 603  00ae 96            	ldw	x,sp
 604  00af 1c002d        	addw	x,#OFST-11
 605  00b2 cd0000        	call	c_lzmp
 607  00b5 27cc          	jreq	L752
 608                     ; 62 	if(test_mode!=4 && test_mode!=5)
 610  00b7 1e33          	ldw	x,(OFST-5,sp)
 611  00b9 a30004        	cpw	x,#4
 612  00bc 273c          	jreq	L372
 614  00be 1e33          	ldw	x,(OFST-5,sp)
 615  00c0 a30005        	cpw	x,#5
 616  00c3 2735          	jreq	L372
 617                     ; 64 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 619  00c5 4bf0          	push	#240
 620  00c7 4b20          	push	#32
 621  00c9 ae500f        	ldw	x,#20495
 622  00cc cd0000        	call	_GPIO_Init
 624  00cf 85            	popw	x
 625                     ; 65 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 627  00d0 4b40          	push	#64
 628  00d2 4b40          	push	#64
 629  00d4 ae500f        	ldw	x,#20495
 630  00d7 cd0000        	call	_GPIO_Init
 632  00da 85            	popw	x
 633                     ; 66 		UART1_DeInit();
 635  00db cd0000        	call	_UART1_DeInit
 637                     ; 67 		UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 639  00de 4b0c          	push	#12
 640  00e0 4b80          	push	#128
 641  00e2 4b00          	push	#0
 642  00e4 4b00          	push	#0
 643  00e6 4b00          	push	#0
 644  00e8 aec200        	ldw	x,#49664
 645  00eb 89            	pushw	x
 646  00ec ae0001        	ldw	x,#1
 647  00ef 89            	pushw	x
 648  00f0 cd0000        	call	_UART1_Init
 650  00f3 5b09          	addw	sp,#9
 651                     ; 69 		UART1_Cmd(ENABLE);
 653  00f5 a601          	ld	a,#1
 654  00f7 cd0000        	call	_UART1_Cmd
 656  00fa               L372:
 657                     ; 72 	switch(test_mode)
 659  00fa 1e33          	ldw	x,(OFST-5,sp)
 661                     ; 458 						setRGB(4,mean_sum%4);
 662  00fc 5d            	tnzw	x
 663  00fd 273a          	jreq	L103
 664  00ff 5a            	decw	x
 665  0100 2603          	jrne	L401
 666  0102 cc01dd        	jp	L543
 667  0105               L401:
 668  0105 5a            	decw	x
 669  0106 2603          	jrne	L601
 670  0108 cc0293        	jp	L56
 671  010b               L601:
 672  010b 5a            	decw	x
 673  010c 2603          	jrne	L011
 674  010e cc04a9        	jp	L76
 675  0111               L011:
 676  0111 5a            	decw	x
 677  0112 2603          	jrne	L211
 678  0114 cc05e3        	jp	L17
 679  0117               L211:
 680  0117 5a            	decw	x
 681  0118 2603          	jrne	L411
 682  011a cc0646        	jp	L37
 683  011d               L411:
 684  011d 5a            	decw	x
 685  011e 2603          	jrne	L611
 686  0120 cc07b0        	jp	L57
 687  0123               L611:
 688  0123 5a            	decw	x
 689  0124 2603          	jrne	L021
 690  0126 cc0833        	jp	L77
 691  0129               L021:
 692  0129 5a            	decw	x
 693  012a 2603          	jrne	L221
 694  012c cc0911        	jp	L101
 695  012f               L221:
 696  012f 5a            	decw	x
 697  0130 2603          	jrne	L421
 698  0132 cc0990        	jp	L201
 699  0135               L421:
 700  0135 ac900990      	jpf	L201
 701  0139               L103:
 702                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 704  0139 5f            	clrw	x
 705  013a 1f31          	ldw	(OFST-7,sp),x
 707  013c               L503:
 708                     ; 82 					for(led_index=0;led_index<10;led_index++)
 710  013c 5f            	clrw	x
 711  013d 1f33          	ldw	(OFST-5,sp),x
 713  013f               L313:
 714                     ; 84 						setMatrixHighZ();
 716  013f cd0a45        	call	_setMatrixHighZ
 718                     ; 85 						setRGB(led_index,rgb_index);
 720  0142 1e31          	ldw	x,(OFST-7,sp)
 721  0144 89            	pushw	x
 722  0145 1e35          	ldw	x,(OFST-3,sp)
 723  0147 cd0a5c        	call	_setRGB
 725  014a 85            	popw	x
 726                     ; 86 						for(iter=0;iter<30000;iter++){}
 728  014b ae0000        	ldw	x,#0
 729  014e 1f37          	ldw	(OFST-1,sp),x
 730  0150 ae0000        	ldw	x,#0
 731  0153 1f35          	ldw	(OFST-3,sp),x
 733  0155               L123:
 736  0155 96            	ldw	x,sp
 737  0156 1c0035        	addw	x,#OFST-3
 738  0159 a601          	ld	a,#1
 739  015b cd0000        	call	c_lgadc
 744  015e 96            	ldw	x,sp
 745  015f 1c0035        	addw	x,#OFST-3
 746  0162 cd0000        	call	c_ltor
 748  0165 ae0014        	ldw	x,#L21
 749  0168 cd0000        	call	c_lcmp
 751  016b 25e8          	jrult	L123
 752                     ; 87 						debug++;
 754  016d 1e2b          	ldw	x,(OFST-13,sp)
 755  016f 1c0001        	addw	x,#1
 756  0172 1f2b          	ldw	(OFST-13,sp),x
 758                     ; 94 							Serial_print_string("counter: ");
 760  0174 ae011f        	ldw	x,#L723
 761  0177 cd09aa        	call	_Serial_print_string
 763                     ; 95 							Serial_print_int(debug);
 765  017a 1e2b          	ldw	x,(OFST-13,sp)
 766  017c cd09d3        	call	_Serial_print_int
 768                     ; 98 							Serial_newline();
 770  017f cd0a36        	call	_Serial_newline
 772                     ; 82 					for(led_index=0;led_index<10;led_index++)
 774  0182 1e33          	ldw	x,(OFST-5,sp)
 775  0184 1c0001        	addw	x,#1
 776  0187 1f33          	ldw	(OFST-5,sp),x
 780  0189 1e33          	ldw	x,(OFST-5,sp)
 781  018b a3000a        	cpw	x,#10
 782  018e 25af          	jrult	L313
 783                     ; 80 				for(rgb_index=0;rgb_index<3;rgb_index++)
 785  0190 1e31          	ldw	x,(OFST-7,sp)
 786  0192 1c0001        	addw	x,#1
 787  0195 1f31          	ldw	(OFST-7,sp),x
 791  0197 1e31          	ldw	x,(OFST-7,sp)
 792  0199 a30003        	cpw	x,#3
 793  019c 259e          	jrult	L503
 794                     ; 102 				for(led_index=0;led_index<12;led_index++)
 796  019e 5f            	clrw	x
 797  019f 1f33          	ldw	(OFST-5,sp),x
 799  01a1               L133:
 800                     ; 104 					setMatrixHighZ();
 802  01a1 cd0a45        	call	_setMatrixHighZ
 804                     ; 105 					setWhite(led_index);
 806  01a4 1e33          	ldw	x,(OFST-5,sp)
 807  01a6 cd0a6b        	call	_setWhite
 809                     ; 106 					for(iter=0;iter<30000;iter++){}
 811  01a9 ae0000        	ldw	x,#0
 812  01ac 1f37          	ldw	(OFST-1,sp),x
 813  01ae ae0000        	ldw	x,#0
 814  01b1 1f35          	ldw	(OFST-3,sp),x
 816  01b3               L733:
 819  01b3 96            	ldw	x,sp
 820  01b4 1c0035        	addw	x,#OFST-3
 821  01b7 a601          	ld	a,#1
 822  01b9 cd0000        	call	c_lgadc
 827  01bc 96            	ldw	x,sp
 828  01bd 1c0035        	addw	x,#OFST-3
 829  01c0 cd0000        	call	c_ltor
 831  01c3 ae0014        	ldw	x,#L21
 832  01c6 cd0000        	call	c_lcmp
 834  01c9 25e8          	jrult	L733
 835                     ; 102 				for(led_index=0;led_index<12;led_index++)
 837  01cb 1e33          	ldw	x,(OFST-5,sp)
 838  01cd 1c0001        	addw	x,#1
 839  01d0 1f33          	ldw	(OFST-5,sp),x
 843  01d2 1e33          	ldw	x,(OFST-5,sp)
 844  01d4 a3000c        	cpw	x,#12
 845  01d7 25c8          	jrult	L133
 847  01d9 ac390139      	jpf	L103
 848  01dd               L543:
 849                     ; 114 				rep=ADC_Read(AIN4);
 851  01dd a604          	ld	a,#4
 852  01df cd0000        	call	_ADC_Read
 854  01e2 cd0000        	call	c_uitolx
 856  01e5 96            	ldw	x,sp
 857  01e6 1c002d        	addw	x,#OFST-11
 858  01e9 cd0000        	call	c_rtol
 861                     ; 115 				my_min=rep;
 863  01ec 1e2f          	ldw	x,(OFST-9,sp)
 864  01ee 1f2b          	ldw	(OFST-13,sp),x
 866                     ; 116 				my_max=rep;
 868  01f0 1e2f          	ldw	x,(OFST-9,sp)
 869  01f2 1f31          	ldw	(OFST-7,sp),x
 871                     ; 117 				for(iter=0;iter<1000;iter++)
 873  01f4 ae0000        	ldw	x,#0
 874  01f7 1f37          	ldw	(OFST-1,sp),x
 875  01f9 ae0000        	ldw	x,#0
 876  01fc 1f35          	ldw	(OFST-3,sp),x
 878  01fe               L153:
 879                     ; 119 					rep=ADC_Read(AIN4);
 881  01fe a604          	ld	a,#4
 882  0200 cd0000        	call	_ADC_Read
 884  0203 cd0000        	call	c_uitolx
 886  0206 96            	ldw	x,sp
 887  0207 1c002d        	addw	x,#OFST-11
 888  020a cd0000        	call	c_rtol
 891                     ; 120 					my_min=my_min<rep?my_min:rep;
 893  020d 1e2b          	ldw	x,(OFST-13,sp)
 894  020f cd0000        	call	c_uitolx
 896  0212 96            	ldw	x,sp
 897  0213 1c002d        	addw	x,#OFST-11
 898  0216 cd0000        	call	c_lcmp
 900  0219 2404          	jruge	L41
 901  021b 1e2b          	ldw	x,(OFST-13,sp)
 902  021d 2002          	jra	L61
 903  021f               L41:
 904  021f 1e2f          	ldw	x,(OFST-9,sp)
 905  0221               L61:
 906  0221 1f2b          	ldw	(OFST-13,sp),x
 908                     ; 121 					my_max=my_max>rep?my_max:rep;
 910  0223 1e31          	ldw	x,(OFST-7,sp)
 911  0225 cd0000        	call	c_uitolx
 913  0228 96            	ldw	x,sp
 914  0229 1c002d        	addw	x,#OFST-11
 915  022c cd0000        	call	c_lcmp
 917  022f 2304          	jrule	L02
 918  0231 1e31          	ldw	x,(OFST-7,sp)
 919  0233 2002          	jra	L22
 920  0235               L02:
 921  0235 1e2f          	ldw	x,(OFST-9,sp)
 922  0237               L22:
 923  0237 1f31          	ldw	(OFST-7,sp),x
 925                     ; 117 				for(iter=0;iter<1000;iter++)
 927  0239 96            	ldw	x,sp
 928  023a 1c0035        	addw	x,#OFST-3
 929  023d a601          	ld	a,#1
 930  023f cd0000        	call	c_lgadc
 935  0242 96            	ldw	x,sp
 936  0243 1c0035        	addw	x,#OFST-3
 937  0246 cd0000        	call	c_ltor
 939  0249 ae0018        	ldw	x,#L42
 940  024c cd0000        	call	c_lcmp
 942  024f 25ad          	jrult	L153
 943                     ; 123 				Serial_print_string("adc: ");
 945  0251 ae0119        	ldw	x,#L753
 946  0254 cd09aa        	call	_Serial_print_string
 948                     ; 124 				Serial_print_int(rep);
 950  0257 1e2f          	ldw	x,(OFST-9,sp)
 951  0259 cd09d3        	call	_Serial_print_int
 953                     ; 125 				Serial_print_string(", ");
 955  025c ae0116        	ldw	x,#L163
 956  025f cd09aa        	call	_Serial_print_string
 958                     ; 126 				Serial_print_int(my_max-my_min);
 960  0262 1e31          	ldw	x,(OFST-7,sp)
 961  0264 72f02b        	subw	x,(OFST-13,sp)
 962  0267 cd09d3        	call	_Serial_print_int
 964                     ; 127 				Serial_newline();
 966  026a cd0a36        	call	_Serial_newline
 968                     ; 128 				for(iter=0;iter<10000;iter++){}
 970  026d ae0000        	ldw	x,#0
 971  0270 1f37          	ldw	(OFST-1,sp),x
 972  0272 ae0000        	ldw	x,#0
 973  0275 1f35          	ldw	(OFST-3,sp),x
 975  0277               L363:
 978  0277 96            	ldw	x,sp
 979  0278 1c0035        	addw	x,#OFST-3
 980  027b a601          	ld	a,#1
 981  027d cd0000        	call	c_lgadc
 986  0280 96            	ldw	x,sp
 987  0281 1c0035        	addw	x,#OFST-3
 988  0284 cd0000        	call	c_ltor
 990  0287 ae0010        	ldw	x,#L01
 991  028a cd0000        	call	c_lcmp
 993  028d 25e8          	jrult	L363
 995  028f acdd01dd      	jpf	L543
 996  0293               L56:
 997                     ; 133 			ADC1_DeInit();
 999  0293 cd0000        	call	_ADC1_DeInit
1001                     ; 134 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1001                     ; 135 							 AIN4,
1001                     ; 136 							 ADC1_PRESSEL_FCPU_D2,//D18 
1001                     ; 137 							 ADC1_EXTTRIG_TIM, 
1001                     ; 138 							 DISABLE, 
1001                     ; 139 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1001                     ; 140 							 ADC1_SCHMITTTRIG_ALL, 
1001                     ; 141 							 DISABLE);
1003  0296 4b00          	push	#0
1004  0298 4bff          	push	#255
1005  029a 4b08          	push	#8
1006  029c 4b00          	push	#0
1007  029e 4b00          	push	#0
1008  02a0 4b00          	push	#0
1009  02a2 ae0104        	ldw	x,#260
1010  02a5 cd0000        	call	_ADC1_Init
1012  02a8 5b06          	addw	sp,#6
1013                     ; 142 			ADC1_Cmd(ENABLE);
1015  02aa a601          	ld	a,#1
1016  02ac cd0000        	call	_ADC1_Cmd
1018  02af               L173:
1019                     ; 166 				rms=0;
1021  02af 5f            	clrw	x
1022  02b0 1f33          	ldw	(OFST-5,sp),x
1024                     ; 168 				mean_sum=0;
1026  02b2 ae0000        	ldw	x,#0
1027  02b5 1f29          	ldw	(OFST-15,sp),x
1028  02b7 ae0000        	ldw	x,#0
1029  02ba 1f27          	ldw	(OFST-17,sp),x
1031                     ; 169 				mean_low=mean+mean_threshold;
1033  02bc 7b25          	ld	a,(OFST-19,sp)
1034  02be 5f            	clrw	x
1035  02bf 1b24          	add	a,(OFST-20,sp)
1036  02c1 2401          	jrnc	L62
1037  02c3 5c            	incw	x
1038  02c4               L62:
1039  02c4 cd0000        	call	c_itol
1041  02c7 96            	ldw	x,sp
1042  02c8 1c001f        	addw	x,#OFST-25
1043  02cb cd0000        	call	c_rtol
1046                     ; 170 				mean_high=mean-mean_threshold;
1048  02ce 7b25          	ld	a,(OFST-19,sp)
1049  02d0 5f            	clrw	x
1050  02d1 1024          	sub	a,(OFST-20,sp)
1051  02d3 2401          	jrnc	L03
1052  02d5 5a            	decw	x
1053  02d6               L03:
1054  02d6 cd0000        	call	c_itol
1056  02d9 96            	ldw	x,sp
1057  02da 1c002d        	addw	x,#OFST-11
1058  02dd cd0000        	call	c_rtol
1061                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1063  02e0 ae0000        	ldw	x,#0
1064  02e3 1f37          	ldw	(OFST-1,sp),x
1065  02e5 ae0000        	ldw	x,#0
1066  02e8 1f35          	ldw	(OFST-3,sp),x
1069  02ea 2058          	jra	L104
1070  02ec               L573:
1071                     ; 174 					ADC1_StartConversion();
1073  02ec cd0000        	call	_ADC1_StartConversion
1076  02ef               L704:
1077                     ; 175 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1079  02ef a680          	ld	a,#128
1080  02f1 cd0000        	call	_ADC1_GetFlagStatus
1082  02f4 4d            	tnz	a
1083  02f5 27f8          	jreq	L704
1084                     ; 177 					reading=ADC1->DRL;
1086  02f7 c65405        	ld	a,21509
1087  02fa 6b26          	ld	(OFST-18,sp),a
1089                     ; 178 					mean_sum += reading;
1091  02fc 7b26          	ld	a,(OFST-18,sp)
1092  02fe 96            	ldw	x,sp
1093  02ff 1c0027        	addw	x,#OFST-17
1094  0302 cd0000        	call	c_lgadc
1097                     ; 179 					rms+=reading>mean_low || reading<mean_high;
1099  0305 7b26          	ld	a,(OFST-18,sp)
1100  0307 b703          	ld	c_lreg+3,a
1101  0309 3f02          	clr	c_lreg+2
1102  030b 3f01          	clr	c_lreg+1
1103  030d 3f00          	clr	c_lreg
1104  030f 96            	ldw	x,sp
1105  0310 1c001f        	addw	x,#OFST-25
1106  0313 cd0000        	call	c_lcmp
1108  0316 2213          	jrugt	L43
1109  0318 7b26          	ld	a,(OFST-18,sp)
1110  031a b703          	ld	c_lreg+3,a
1111  031c 3f02          	clr	c_lreg+2
1112  031e 3f01          	clr	c_lreg+1
1113  0320 3f00          	clr	c_lreg
1114  0322 96            	ldw	x,sp
1115  0323 1c002d        	addw	x,#OFST-11
1116  0326 cd0000        	call	c_lcmp
1118  0329 2405          	jruge	L23
1119  032b               L43:
1120  032b ae0001        	ldw	x,#1
1121  032e 2001          	jra	L63
1122  0330               L23:
1123  0330 5f            	clrw	x
1124  0331               L63:
1125  0331 72fb33        	addw	x,(OFST-5,sp)
1126  0334 1f33          	ldw	(OFST-5,sp),x
1128                     ; 183 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1130  0336 a680          	ld	a,#128
1131  0338 cd0000        	call	_ADC1_ClearFlag
1133                     ; 171 				for(iter=0;iter<adc_captures;iter++)
1135  033b 96            	ldw	x,sp
1136  033c 1c0035        	addw	x,#OFST-3
1137  033f a601          	ld	a,#1
1138  0341 cd0000        	call	c_lgadc
1141  0344               L104:
1144  0344 96            	ldw	x,sp
1145  0345 1c0035        	addw	x,#OFST-3
1146  0348 cd0000        	call	c_ltor
1148  034b 96            	ldw	x,sp
1149  034c 1c0019        	addw	x,#OFST-31
1150  034f cd0000        	call	c_lcmp
1152  0352 2598          	jrult	L573
1153                     ; 187 				if(rms>9) mean_threshold++;
1155  0354 1e33          	ldw	x,(OFST-5,sp)
1156  0356 a3000a        	cpw	x,#10
1157  0359 2502          	jrult	L314
1160  035b 0c24          	inc	(OFST-20,sp)
1162  035d               L314:
1163                     ; 188 				if(rms==0) mean_threshold--;
1165  035d 1e33          	ldw	x,(OFST-5,sp)
1166  035f 2602          	jrne	L514
1169  0361 0a24          	dec	(OFST-20,sp)
1171  0363               L514:
1172                     ; 189 				mean=(mean_sum)/(adc_captures);
1174  0363 96            	ldw	x,sp
1175  0364 1c0027        	addw	x,#OFST-17
1176  0367 cd0000        	call	c_ltor
1178  036a 96            	ldw	x,sp
1179  036b 1c0019        	addw	x,#OFST-31
1180  036e cd0000        	call	c_ludv
1182  0371 b603          	ld	a,c_lreg+3
1183  0373 6b25          	ld	(OFST-19,sp),a
1185                     ; 190 				if(sound_level/32<mean_threshold) sound_level++;
1187  0375 1e31          	ldw	x,(OFST-7,sp)
1188  0377 54            	srlw	x
1189  0378 54            	srlw	x
1190  0379 54            	srlw	x
1191  037a 54            	srlw	x
1192  037b 54            	srlw	x
1193  037c 7b24          	ld	a,(OFST-20,sp)
1194  037e 905f          	clrw	y
1195  0380 9097          	ld	yl,a
1196  0382 90bf00        	ldw	c_y,y
1197  0385 b300          	cpw	x,c_y
1198  0387 2407          	jruge	L714
1201  0389 1e31          	ldw	x,(OFST-7,sp)
1202  038b 1c0001        	addw	x,#1
1203  038e 1f31          	ldw	(OFST-7,sp),x
1205  0390               L714:
1206                     ; 191 				if(sound_level/32>mean_threshold) sound_level--;
1208  0390 1e31          	ldw	x,(OFST-7,sp)
1209  0392 54            	srlw	x
1210  0393 54            	srlw	x
1211  0394 54            	srlw	x
1212  0395 54            	srlw	x
1213  0396 54            	srlw	x
1214  0397 7b24          	ld	a,(OFST-20,sp)
1215  0399 905f          	clrw	y
1216  039b 9097          	ld	yl,a
1217  039d 90bf00        	ldw	c_y,y
1218  03a0 b300          	cpw	x,c_y
1219  03a2 2307          	jrule	L124
1222  03a4 1e31          	ldw	x,(OFST-7,sp)
1223  03a6 1d0001        	subw	x,#1
1224  03a9 1f31          	ldw	(OFST-7,sp),x
1226  03ab               L124:
1227                     ; 192 				if(debug%4==0)
1229  03ab 1e2b          	ldw	x,(OFST-13,sp)
1230  03ad a604          	ld	a,#4
1231  03af cd0000        	call	c_smodx
1233  03b2 a30000        	cpw	x,#0
1234  03b5 267b          	jrne	L324
1235                     ; 194 					Serial_print_string("adc: ");
1237  03b7 ae0119        	ldw	x,#L753
1238  03ba cd09aa        	call	_Serial_print_string
1240                     ; 195 					Serial_print_int(mean);
1242  03bd 7b25          	ld	a,(OFST-19,sp)
1243  03bf 5f            	clrw	x
1244  03c0 97            	ld	xl,a
1245  03c1 cd09d3        	call	_Serial_print_int
1247                     ; 196 					Serial_print_string(", ");
1249  03c4 ae0116        	ldw	x,#L163
1250  03c7 cd09aa        	call	_Serial_print_string
1252                     ; 197 					if(rms<9) Serial_print_string("0");
1254  03ca 1e33          	ldw	x,(OFST-5,sp)
1255  03cc a30009        	cpw	x,#9
1256  03cf 2406          	jruge	L524
1259  03d1 ae0114        	ldw	x,#L724
1260  03d4 cd09aa        	call	_Serial_print_string
1262  03d7               L524:
1263                     ; 198 					if(rms==0) Serial_print_string("0");
1265  03d7 1e33          	ldw	x,(OFST-5,sp)
1266  03d9 2606          	jrne	L134
1269  03db ae0114        	ldw	x,#L724
1270  03de cd09aa        	call	_Serial_print_string
1272  03e1               L134:
1273                     ; 199 					Serial_print_int(rms);
1275  03e1 1e33          	ldw	x,(OFST-5,sp)
1276  03e3 cd09d3        	call	_Serial_print_int
1278                     ; 200 					Serial_print_string(", ");
1280  03e6 ae0116        	ldw	x,#L163
1281  03e9 cd09aa        	call	_Serial_print_string
1283                     ; 201 					if(mean_threshold<9) Serial_print_string("0");
1285  03ec 7b24          	ld	a,(OFST-20,sp)
1286  03ee a109          	cp	a,#9
1287  03f0 2406          	jruge	L334
1290  03f2 ae0114        	ldw	x,#L724
1291  03f5 cd09aa        	call	_Serial_print_string
1293  03f8               L334:
1294                     ; 202 					Serial_print_int(mean_threshold);
1296  03f8 7b24          	ld	a,(OFST-20,sp)
1297  03fa 5f            	clrw	x
1298  03fb 97            	ld	xl,a
1299  03fc cd09d3        	call	_Serial_print_int
1301                     ; 203 					Serial_print_string(", ");
1303  03ff ae0116        	ldw	x,#L163
1304  0402 cd09aa        	call	_Serial_print_string
1306                     ; 204 					if(sound_level/8<9) Serial_print_string("0");
1308  0405 1e31          	ldw	x,(OFST-7,sp)
1309  0407 54            	srlw	x
1310  0408 54            	srlw	x
1311  0409 54            	srlw	x
1312  040a a30009        	cpw	x,#9
1313  040d 2406          	jruge	L534
1316  040f ae0114        	ldw	x,#L724
1317  0412 cd09aa        	call	_Serial_print_string
1319  0415               L534:
1320                     ; 205 					Serial_print_int(sound_level/8);
1322  0415 1e31          	ldw	x,(OFST-7,sp)
1323  0417 54            	srlw	x
1324  0418 54            	srlw	x
1325  0419 54            	srlw	x
1326  041a cd09d3        	call	_Serial_print_int
1328                     ; 206 					if(debug%10==0) Serial_print_string("*");
1330  041d 1e2b          	ldw	x,(OFST-13,sp)
1331  041f a60a          	ld	a,#10
1332  0421 cd0000        	call	c_smodx
1334  0424 a30000        	cpw	x,#0
1335  0427 2606          	jrne	L734
1338  0429 ae0112        	ldw	x,#L144
1339  042c cd09aa        	call	_Serial_print_string
1341  042f               L734:
1342                     ; 207 					Serial_newline();
1344  042f cd0a36        	call	_Serial_newline
1346  0432               L324:
1347                     ; 209 				if(mean_threshold>10)
1349  0432 7b24          	ld	a,(OFST-20,sp)
1350  0434 a10b          	cp	a,#11
1351  0436 2518          	jrult	L344
1352                     ; 213 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1354  0438 4bd0          	push	#208
1355  043a 4b08          	push	#8
1356  043c ae500a        	ldw	x,#20490
1357  043f cd0000        	call	_GPIO_Init
1359  0442 85            	popw	x
1360                     ; 214 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1362  0443 4bc0          	push	#192
1363  0445 4b20          	push	#32
1364  0447 ae500a        	ldw	x,#20490
1365  044a cd0000        	call	_GPIO_Init
1367  044d 85            	popw	x
1369  044e 2016          	jra	L544
1370  0450               L344:
1371                     ; 216 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1373  0450 4bd0          	push	#208
1374  0452 4b10          	push	#16
1375  0454 ae500a        	ldw	x,#20490
1376  0457 cd0000        	call	_GPIO_Init
1378  045a 85            	popw	x
1379                     ; 217 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1381  045b 4bc0          	push	#192
1382  045d 4b40          	push	#64
1383  045f ae500a        	ldw	x,#20490
1384  0462 cd0000        	call	_GPIO_Init
1386  0465 85            	popw	x
1387  0466               L544:
1388                     ; 219 			for(iter=0;iter<10;iter++){}
1390  0466 ae0000        	ldw	x,#0
1391  0469 1f37          	ldw	(OFST-1,sp),x
1392  046b ae0000        	ldw	x,#0
1393  046e 1f35          	ldw	(OFST-3,sp),x
1395  0470               L744:
1398  0470 96            	ldw	x,sp
1399  0471 1c0035        	addw	x,#OFST-3
1400  0474 a601          	ld	a,#1
1401  0476 cd0000        	call	c_lgadc
1406  0479 96            	ldw	x,sp
1407  047a 1c0035        	addw	x,#OFST-3
1408  047d cd0000        	call	c_ltor
1410  0480 ae001c        	ldw	x,#L04
1411  0483 cd0000        	call	c_lcmp
1413  0486 25e8          	jrult	L744
1414                     ; 220 				GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1416  0488 4b00          	push	#0
1417  048a 4bf8          	push	#248
1418  048c ae500a        	ldw	x,#20490
1419  048f cd0000        	call	_GPIO_Init
1421  0492 85            	popw	x
1422                     ; 221 				GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
1424  0493 4b00          	push	#0
1425  0495 4b04          	push	#4
1426  0497 ae500f        	ldw	x,#20495
1427  049a cd0000        	call	_GPIO_Init
1429  049d 85            	popw	x
1430                     ; 223 				debug++;
1432  049e 1e2b          	ldw	x,(OFST-13,sp)
1433  04a0 1c0001        	addw	x,#1
1434  04a3 1f2b          	ldw	(OFST-13,sp),x
1437  04a5 acaf02af      	jpf	L173
1438  04a9               L76:
1439                     ; 229 			ADC1_DeInit();
1441  04a9 cd0000        	call	_ADC1_DeInit
1443                     ; 230 			ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
1443                     ; 231 							 AIN4,
1443                     ; 232 							 ADC1_PRESSEL_FCPU_D2,//D18 
1443                     ; 233 							 ADC1_EXTTRIG_TIM, 
1443                     ; 234 							 DISABLE, 
1443                     ; 235 							 ADC1_ALIGN_RIGHT, //left to put 8 bits in ADC1->DRH; right for all 10 bits with ADC1_GetConversionValue()
1443                     ; 236 							 ADC1_SCHMITTTRIG_ALL, 
1443                     ; 237 							 DISABLE);
1445  04ac 4b00          	push	#0
1446  04ae 4bff          	push	#255
1447  04b0 4b08          	push	#8
1448  04b2 4b00          	push	#0
1449  04b4 4b00          	push	#0
1450  04b6 4b00          	push	#0
1451  04b8 ae0104        	ldw	x,#260
1452  04bb cd0000        	call	_ADC1_Init
1454  04be 5b06          	addw	sp,#6
1455                     ; 238 			ADC1_Cmd(ENABLE);
1457  04c0 a601          	ld	a,#1
1458  04c2 cd0000        	call	_ADC1_Cmd
1460  04c5               L554:
1461                     ; 241 				debug++;
1463  04c5 1e2b          	ldw	x,(OFST-13,sp)
1464  04c7 1c0001        	addw	x,#1
1465  04ca 1f2b          	ldw	(OFST-13,sp),x
1467                     ; 242 				rms=0;//8 bit
1469  04cc 5f            	clrw	x
1470  04cd 1f33          	ldw	(OFST-5,sp),x
1472                     ; 244 				mean_sum=0;//16 bit
1474  04cf ae0000        	ldw	x,#0
1475  04d2 1f29          	ldw	(OFST-15,sp),x
1476  04d4 ae0000        	ldw	x,#0
1477  04d7 1f27          	ldw	(OFST-17,sp),x
1479                     ; 247 				iter=0;
1481  04d9 ae0000        	ldw	x,#0
1482  04dc 1f37          	ldw	(OFST-1,sp),x
1483  04de ae0000        	ldw	x,#0
1484  04e1 1f35          	ldw	(OFST-3,sp),x
1486  04e3               L164:
1487                     ; 250 					ADC1_StartConversion();
1489  04e3 cd0000        	call	_ADC1_StartConversion
1492  04e6               L174:
1493                     ; 251 					while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
1495  04e6 a680          	ld	a,#128
1496  04e8 cd0000        	call	_ADC1_GetFlagStatus
1498  04eb 4d            	tnz	a
1499  04ec 27f8          	jreq	L174
1500                     ; 253 					reading=ADC1->DRL;
1502  04ee c65405        	ld	a,21509
1503  04f1 6b26          	ld	(OFST-18,sp),a
1505                     ; 254 					mean_sum += reading;
1507  04f3 7b26          	ld	a,(OFST-18,sp)
1508  04f5 96            	ldw	x,sp
1509  04f6 1c0027        	addw	x,#OFST-17
1510  04f9 cd0000        	call	c_lgadc
1513                     ; 256 					mean_diff=reading>mean?(reading-mean):(mean-reading);
1515  04fc 7b26          	ld	a,(OFST-18,sp)
1516  04fe 1125          	cp	a,(OFST-19,sp)
1517  0500 2306          	jrule	L24
1518  0502 7b26          	ld	a,(OFST-18,sp)
1519  0504 1025          	sub	a,(OFST-19,sp)
1520  0506 2004          	jra	L44
1521  0508               L24:
1522  0508 7b25          	ld	a,(OFST-19,sp)
1523  050a 1026          	sub	a,(OFST-18,sp)
1524  050c               L44:
1525  050c 6b24          	ld	(OFST-20,sp),a
1527                     ; 257 					rms+=mean_diff>mean_threshold_8;
1529  050e 7b24          	ld	a,(OFST-20,sp)
1530  0510 1123          	cp	a,(OFST-21,sp)
1531  0512 2305          	jrule	L64
1532  0514 ae0001        	ldw	x,#1
1533  0517 2001          	jra	L05
1534  0519               L64:
1535  0519 5f            	clrw	x
1536  051a               L05:
1537  051a 72fb33        	addw	x,(OFST-5,sp)
1538  051d 1f33          	ldw	(OFST-5,sp),x
1540                     ; 259 					ADC1_ClearFlag(ADC1_FLAG_EOC);
1542  051f a680          	ld	a,#128
1543  0521 cd0000        	call	_ADC1_ClearFlag
1545                     ; 262 					iter++;
1547  0524 96            	ldw	x,sp
1548  0525 1c0035        	addw	x,#OFST-3
1549  0528 a601          	ld	a,#1
1550  052a cd0000        	call	c_lgadc
1553                     ; 263 					iter%=256;//8 bit unsigned
1555  052d 0f37          	clr	(OFST-1,sp)
1556  052f 0f36          	clr	(OFST-2,sp)
1557  0531 0f35          	clr	(OFST-3,sp)
1559                     ; 264 				}while(iter!=0);//run 255 times
1561  0533 96            	ldw	x,sp
1562  0534 1c0035        	addw	x,#OFST-3
1563  0537 cd0000        	call	c_lzmp
1565  053a 26a7          	jrne	L164
1566                     ; 265 				mean=((uint16_t)mean+mean_sum/256)/2;
1568  053c 96            	ldw	x,sp
1569  053d 1c0027        	addw	x,#OFST-17
1570  0540 cd0000        	call	c_ltor
1572  0543 a608          	ld	a,#8
1573  0545 cd0000        	call	c_lursh
1575  0548 96            	ldw	x,sp
1576  0549 1c0001        	addw	x,#OFST-55
1577  054c cd0000        	call	c_rtol
1580  054f 7b25          	ld	a,(OFST-19,sp)
1581  0551 b703          	ld	c_lreg+3,a
1582  0553 3f02          	clr	c_lreg+2
1583  0555 3f01          	clr	c_lreg+1
1584  0557 3f00          	clr	c_lreg
1585  0559 96            	ldw	x,sp
1586  055a 1c0001        	addw	x,#OFST-55
1587  055d cd0000        	call	c_ladd
1589  0560 3400          	srl	c_lreg
1590  0562 3601          	rrc	c_lreg+1
1591  0564 3602          	rrc	c_lreg+2
1592  0566 3603          	rrc	c_lreg+3
1593  0568 b603          	ld	a,c_lreg+3
1594  056a 6b25          	ld	(OFST-19,sp),a
1596                     ; 266 				mean_threshold_16=(mean_threshold_16+(((uint16_t)rms_lookup[rms/16])*mean_threshold_16)/32)/2;
1598  056c 96            	ldw	x,sp
1599  056d 1c0009        	addw	x,#OFST-47
1600  0570 1f03          	ldw	(OFST-53,sp),x
1602  0572 1e33          	ldw	x,(OFST-5,sp)
1603  0574 54            	srlw	x
1604  0575 54            	srlw	x
1605  0576 54            	srlw	x
1606  0577 54            	srlw	x
1607  0578 72fb03        	addw	x,(OFST-53,sp)
1608  057b f6            	ld	a,(x)
1609  057c 5f            	clrw	x
1610  057d 97            	ld	xl,a
1611  057e 161d          	ldw	y,(OFST-27,sp)
1612  0580 cd0000        	call	c_imul
1614  0583 54            	srlw	x
1615  0584 54            	srlw	x
1616  0585 54            	srlw	x
1617  0586 54            	srlw	x
1618  0587 54            	srlw	x
1619  0588 72fb1d        	addw	x,(OFST-27,sp)
1620  058b 54            	srlw	x
1621  058c 1f1d          	ldw	(OFST-27,sp),x
1623                     ; 267 				mean_threshold_8=mean_threshold_16/256;
1625  058e 7b1d          	ld	a,(OFST-27,sp)
1626  0590 6b23          	ld	(OFST-21,sp),a
1628                     ; 268 				if(mean_threshold_8==0)
1630  0592 0d23          	tnz	(OFST-21,sp)
1631  0594 2609          	jrne	L574
1632                     ; 270 					mean_threshold_8=1;
1634  0596 a601          	ld	a,#1
1635  0598 6b23          	ld	(OFST-21,sp),a
1637                     ; 271 					mean_threshold_16=0x0100;
1639  059a ae0100        	ldw	x,#256
1640  059d 1f1d          	ldw	(OFST-27,sp),x
1642  059f               L574:
1643                     ; 276 					if(mean==0) Serial_print_string("0");
1645  059f 0d25          	tnz	(OFST-19,sp)
1646  05a1 2606          	jrne	L774
1649  05a3 ae0114        	ldw	x,#L724
1650  05a6 cd09aa        	call	_Serial_print_string
1652  05a9               L774:
1653                     ; 277 					Serial_print_int(mean);
1655  05a9 7b25          	ld	a,(OFST-19,sp)
1656  05ab 5f            	clrw	x
1657  05ac 97            	ld	xl,a
1658  05ad cd09d3        	call	_Serial_print_int
1660                     ; 279 					Serial_print_string(" ");
1662  05b0 ae0110        	ldw	x,#L105
1663  05b3 cd09aa        	call	_Serial_print_string
1665                     ; 282 					if(rms==0) Serial_print_string("0");
1667  05b6 1e33          	ldw	x,(OFST-5,sp)
1668  05b8 2606          	jrne	L305
1671  05ba ae0114        	ldw	x,#L724
1672  05bd cd09aa        	call	_Serial_print_string
1674  05c0               L305:
1675                     ; 283 					Serial_print_int(rms);
1677  05c0 1e33          	ldw	x,(OFST-5,sp)
1678  05c2 cd09d3        	call	_Serial_print_int
1680                     ; 285 					Serial_print_string(" ");
1682  05c5 ae0110        	ldw	x,#L105
1683  05c8 cd09aa        	call	_Serial_print_string
1685                     ; 286 					if(mean_threshold_8==0) Serial_print_string("0");
1687  05cb 0d23          	tnz	(OFST-21,sp)
1688  05cd 2606          	jrne	L505
1691  05cf ae0114        	ldw	x,#L724
1692  05d2 cd09aa        	call	_Serial_print_string
1694  05d5               L505:
1695                     ; 287 					Serial_print_int(mean_threshold_8);
1697  05d5 7b23          	ld	a,(OFST-21,sp)
1698  05d7 5f            	clrw	x
1699  05d8 97            	ld	xl,a
1700  05d9 cd09d3        	call	_Serial_print_int
1702                     ; 289 					Serial_newline();
1704  05dc cd0a36        	call	_Serial_newline
1707  05df acc504c5      	jpf	L554
1708  05e3               L17:
1709                     ; 295 			GPIO_Init(GPIOD, GPIO_PIN_5,GPIO_MODE_IN_PU_NO_IT);
1711  05e3 4b40          	push	#64
1712  05e5 4b20          	push	#32
1713  05e7 ae500f        	ldw	x,#20495
1714  05ea cd0000        	call	_GPIO_Init
1716  05ed 85            	popw	x
1717                     ; 296 			GPIO_Init(GPIOD, GPIO_PIN_6,GPIO_MODE_IN_PU_NO_IT);
1719  05ee 4b40          	push	#64
1720  05f0 4b40          	push	#64
1721  05f2 ae500f        	ldw	x,#20495
1722  05f5 cd0000        	call	_GPIO_Init
1724  05f8 85            	popw	x
1725  05f9               L705:
1726                     ; 299 			  setMatrixHighZ();
1728  05f9 cd0a45        	call	_setMatrixHighZ
1730                     ; 300 				if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_5))
1732  05fc 4b20          	push	#32
1733  05fe ae500f        	ldw	x,#20495
1734  0601 cd0000        	call	_GPIO_ReadInputPin
1736  0604 5b01          	addw	sp,#1
1737  0606 4d            	tnz	a
1738  0607 2618          	jrne	L315
1739                     ; 304 					GPIO_Init(GPIOC, GPIO_PIN_3,GPIO_MODE_OUT_PP_HIGH_SLOW);
1741  0609 4bd0          	push	#208
1742  060b 4b08          	push	#8
1743  060d ae500a        	ldw	x,#20490
1744  0610 cd0000        	call	_GPIO_Init
1746  0613 85            	popw	x
1747                     ; 305 					GPIO_Init(GPIOC, GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_SLOW);
1749  0614 4bc0          	push	#192
1750  0616 4b20          	push	#32
1751  0618 ae500a        	ldw	x,#20490
1752  061b cd0000        	call	_GPIO_Init
1754  061e 85            	popw	x
1756  061f 20d8          	jra	L705
1757  0621               L315:
1758                     ; 306 				}else if(!GPIO_ReadInputPin(GPIOD, GPIO_PIN_6)){
1760  0621 4b40          	push	#64
1761  0623 ae500f        	ldw	x,#20495
1762  0626 cd0000        	call	_GPIO_ReadInputPin
1764  0629 5b01          	addw	sp,#1
1765  062b 4d            	tnz	a
1766  062c 26cb          	jrne	L705
1767                     ; 307 					GPIO_Init(GPIOC, GPIO_PIN_4,GPIO_MODE_OUT_PP_HIGH_SLOW);
1769  062e 4bd0          	push	#208
1770  0630 4b10          	push	#16
1771  0632 ae500a        	ldw	x,#20490
1772  0635 cd0000        	call	_GPIO_Init
1774  0638 85            	popw	x
1775                     ; 308 					GPIO_Init(GPIOC, GPIO_PIN_6,GPIO_MODE_OUT_PP_LOW_SLOW);
1777  0639 4bc0          	push	#192
1778  063b 4b40          	push	#64
1779  063d ae500a        	ldw	x,#20490
1780  0640 cd0000        	call	_GPIO_Init
1782  0643 85            	popw	x
1783  0644 20b3          	jra	L705
1784  0646               L37:
1785                     ; 314 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
1787  0646 c650c6        	ld	a,20678
1788  0649 a4e7          	and	a,#231
1789  064b c750c6        	ld	20678,a
1790                     ; 316 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
1792  064e 4bf0          	push	#240
1793  0650 4b20          	push	#32
1794  0652 ae500f        	ldw	x,#20495
1795  0655 cd0000        	call	_GPIO_Init
1797  0658 85            	popw	x
1798                     ; 317 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
1800  0659 4b40          	push	#64
1801  065b 4b40          	push	#64
1802  065d ae500f        	ldw	x,#20495
1803  0660 cd0000        	call	_GPIO_Init
1805  0663 85            	popw	x
1806                     ; 318 			UART1_DeInit();
1808  0664 cd0000        	call	_UART1_DeInit
1810                     ; 319 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1812  0667 4b0c          	push	#12
1813  0669 4b80          	push	#128
1814  066b 4b00          	push	#0
1815  066d 4b00          	push	#0
1816  066f 4b00          	push	#0
1817  0671 ae4240        	ldw	x,#16960
1818  0674 89            	pushw	x
1819  0675 ae000f        	ldw	x,#15
1820  0678 89            	pushw	x
1821  0679 cd0000        	call	_UART1_Init
1823  067c 5b09          	addw	sp,#9
1824                     ; 321 			UART1_Cmd(ENABLE);
1826  067e a601          	ld	a,#1
1827  0680 cd0000        	call	_UART1_Cmd
1829                     ; 323 			Serial_print_string("Mode: ");
1831  0683 ae0109        	ldw	x,#L125
1832  0686 cd09aa        	call	_Serial_print_string
1834                     ; 324 			Serial_print_int(test_mode);
1836  0689 1e33          	ldw	x,(OFST-5,sp)
1837  068b cd09d3        	call	_Serial_print_int
1839                     ; 325 			Serial_newline();
1841  068e cd0a36        	call	_Serial_newline
1843                     ; 328 			Serial_print_string("Params v2: ");
1845  0691 ae00fd        	ldw	x,#L325
1846  0694 cd09aa        	call	_Serial_print_string
1848                     ; 335 			Serial_print_int(CLK->CKDIVR);//24 0001_1000
1850  0697 c650c6        	ld	a,20678
1851  069a 5f            	clrw	x
1852  069b 97            	ld	xl,a
1853  069c cd09d3        	call	_Serial_print_int
1855                     ; 336 			Serial_print_string(" ");
1857  069f ae0110        	ldw	x,#L105
1858  06a2 cd09aa        	call	_Serial_print_string
1860                     ; 337 			Serial_print_int(CLK->CCOR);//0
1862  06a5 c650c9        	ld	a,20681
1863  06a8 5f            	clrw	x
1864  06a9 97            	ld	xl,a
1865  06aa cd09d3        	call	_Serial_print_int
1867                     ; 338 			Serial_newline();
1869  06ad cd0a36        	call	_Serial_newline
1871                     ; 340 			TIM4->PSCR= 7;// init divider register /128	
1873  06b0 35075347      	mov	21319,#7
1874                     ; 341 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
1876  06b4 357d5348      	mov	21320,#125
1877                     ; 342 			TIM4->EGR= TIM4_EGR_UG;// update registers
1879  06b8 35015345      	mov	21317,#1
1880                     ; 343 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
1882  06bc c65340        	ld	a,21312
1883  06bf aa85          	or	a,#133
1884  06c1 c75340        	ld	21312,a
1885                     ; 344 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
1887  06c4 35015343      	mov	21315,#1
1888                     ; 345 			enableInterrupts();
1891  06c8 9a            rim
1893  06c9               L525:
1894                     ; 348 				if(tms%1000==0 && mean_sum!=tms/1000)
1896  06c9 ae0000        	ldw	x,#_tms
1897  06cc cd0000        	call	c_ltor
1899  06cf ae0018        	ldw	x,#L42
1900  06d2 cd0000        	call	c_lumd
1902  06d5 cd0000        	call	c_lrzmp
1904  06d8 2642          	jrne	L135
1906  06da ae0000        	ldw	x,#_tms
1907  06dd cd0000        	call	c_ltor
1909  06e0 ae0018        	ldw	x,#L42
1910  06e3 cd0000        	call	c_ludv
1912  06e6 96            	ldw	x,sp
1913  06e7 1c0027        	addw	x,#OFST-17
1914  06ea cd0000        	call	c_lcmp
1916  06ed 272d          	jreq	L135
1917                     ; 350 					Serial_print_string("time: ");
1919  06ef ae00f6        	ldw	x,#L335
1920  06f2 cd09aa        	call	_Serial_print_string
1922                     ; 351 					mean_sum=tms/1000;
1924  06f5 ae0000        	ldw	x,#_tms
1925  06f8 cd0000        	call	c_ltor
1927  06fb ae0018        	ldw	x,#L42
1928  06fe cd0000        	call	c_ludv
1930  0701 96            	ldw	x,sp
1931  0702 1c0027        	addw	x,#OFST-17
1932  0705 cd0000        	call	c_rtol
1935                     ; 352 					Serial_print_int(tms/1000);
1937  0708 ae0000        	ldw	x,#_tms
1938  070b cd0000        	call	c_ltor
1940  070e ae0018        	ldw	x,#L42
1941  0711 cd0000        	call	c_ludv
1943  0714 be02          	ldw	x,c_lreg+2
1944  0716 cd09d3        	call	_Serial_print_int
1946                     ; 353 					Serial_newline();
1948  0719 cd0a36        	call	_Serial_newline
1950  071c               L135:
1951                     ; 361 				setMatrixHighZ();
1953  071c cd0a45        	call	_setMatrixHighZ
1955                     ; 362 				mean_low=tms%20;
1957  071f ae0000        	ldw	x,#_tms
1958  0722 cd0000        	call	c_ltor
1960  0725 ae0020        	ldw	x,#L25
1961  0728 cd0000        	call	c_lumd
1963  072b 96            	ldw	x,sp
1964  072c 1c001f        	addw	x,#OFST-25
1965  072f cd0000        	call	c_rtol
1968                     ; 363 				mean_high=(tms/20)%100;
1970  0732 ae0000        	ldw	x,#_tms
1971  0735 cd0000        	call	c_ltor
1973  0738 ae0020        	ldw	x,#L25
1974  073b cd0000        	call	c_ludv
1976  073e ae0024        	ldw	x,#L45
1977  0741 cd0000        	call	c_lumd
1979  0744 96            	ldw	x,sp
1980  0745 1c002d        	addw	x,#OFST-11
1981  0748 cd0000        	call	c_rtol
1984                     ; 364 				if(mean_low>(mean_high/4) ^ (tms/2000)%2)
1986  074b ae0000        	ldw	x,#_tms
1987  074e cd0000        	call	c_ltor
1989  0751 ae0028        	ldw	x,#L65
1990  0754 cd0000        	call	c_ludv
1992  0757 b603          	ld	a,c_lreg+3
1993  0759 a401          	and	a,#1
1994  075b b703          	ld	c_lreg+3,a
1995  075d 3f02          	clr	c_lreg+2
1996  075f 3f01          	clr	c_lreg+1
1997  0761 3f00          	clr	c_lreg
1998  0763 96            	ldw	x,sp
1999  0764 1c0001        	addw	x,#OFST-55
2000  0767 cd0000        	call	c_rtol
2003  076a 96            	ldw	x,sp
2004  076b 1c002d        	addw	x,#OFST-11
2005  076e cd0000        	call	c_ltor
2007  0771 a602          	ld	a,#2
2008  0773 cd0000        	call	c_lursh
2010  0776 96            	ldw	x,sp
2011  0777 1c001f        	addw	x,#OFST-25
2012  077a cd0000        	call	c_lcmp
2014  077d 2405          	jruge	L06
2015  077f ae0001        	ldw	x,#1
2016  0782 2001          	jra	L26
2017  0784               L06:
2018  0784 5f            	clrw	x
2019  0785               L26:
2020  0785 cd0000        	call	c_itolx
2022  0788 96            	ldw	x,sp
2023  0789 1c0001        	addw	x,#OFST-55
2024  078c cd0000        	call	c_lxor
2026  078f cd0000        	call	c_lrzmp
2028  0792 270f          	jreq	L535
2029                     ; 366 					setRGB(4,1);
2031  0794 ae0001        	ldw	x,#1
2032  0797 89            	pushw	x
2033  0798 ae0004        	ldw	x,#4
2034  079b cd0a5c        	call	_setRGB
2036  079e 85            	popw	x
2038  079f acc906c9      	jpf	L525
2039  07a3               L535:
2040                     ; 369 					setRGB(4,0);
2042  07a3 5f            	clrw	x
2043  07a4 89            	pushw	x
2044  07a5 ae0004        	ldw	x,#4
2045  07a8 cd0a5c        	call	_setRGB
2047  07ab 85            	popw	x
2048  07ac acc906c9      	jpf	L525
2049  07b0               L57:
2050                     ; 375 			Serial_print_string("Mode: ");
2052  07b0 ae0109        	ldw	x,#L125
2053  07b3 cd09aa        	call	_Serial_print_string
2055                     ; 376 			Serial_print_int(test_mode);
2057  07b6 1e33          	ldw	x,(OFST-5,sp)
2058  07b8 cd09d3        	call	_Serial_print_int
2060                     ; 377 			Serial_newline();
2062  07bb cd0a36        	call	_Serial_newline
2064                     ; 381 			Serial_print_string("Params: ");
2066  07be ae00ed        	ldw	x,#L145
2067  07c1 cd09aa        	call	_Serial_print_string
2069                     ; 382 			Serial_print_int(CLK->CKDIVR);//
2071  07c4 c650c6        	ld	a,20678
2072  07c7 5f            	clrw	x
2073  07c8 97            	ld	xl,a
2074  07c9 cd09d3        	call	_Serial_print_int
2076                     ; 383 			Serial_print_string(" ");
2078  07cc ae0110        	ldw	x,#L105
2079  07cf cd09aa        	call	_Serial_print_string
2081                     ; 384 			Serial_print_int(CLK->CCOR);//
2083  07d2 c650c9        	ld	a,20681
2084  07d5 5f            	clrw	x
2085  07d6 97            	ld	xl,a
2086  07d7 cd09d3        	call	_Serial_print_int
2088                     ; 385 			Serial_newline();
2090  07da cd0a36        	call	_Serial_newline
2092                     ; 387 			TIM4->PSCR= 7;// init divider register /128	
2094  07dd 35075347      	mov	21319,#7
2095                     ; 388 			TIM4->ARR= 256 - (u8)(-128);// init auto reload register
2097  07e1 35805348      	mov	21320,#128
2098                     ; 389 			TIM4->EGR= TIM4_EGR_UG;// update registers
2100  07e5 35015345      	mov	21317,#1
2101                     ; 390 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2103  07e9 c65340        	ld	a,21312
2104  07ec aa85          	or	a,#133
2105  07ee c75340        	ld	21312,a
2106                     ; 391 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2108  07f1 35015343      	mov	21315,#1
2109                     ; 392 			enableInterrupts();
2112  07f5 9a            rim
2114  07f6               L345:
2115                     ; 395 				for(iter=0;iter<5000;iter++){}
2117  07f6 ae0000        	ldw	x,#0
2118  07f9 1f37          	ldw	(OFST-1,sp),x
2119  07fb ae0000        	ldw	x,#0
2120  07fe 1f35          	ldw	(OFST-3,sp),x
2122  0800               L745:
2125  0800 96            	ldw	x,sp
2126  0801 1c0035        	addw	x,#OFST-3
2127  0804 a601          	ld	a,#1
2128  0806 cd0000        	call	c_lgadc
2133  0809 96            	ldw	x,sp
2134  080a 1c0035        	addw	x,#OFST-3
2135  080d cd0000        	call	c_ltor
2137  0810 ae002c        	ldw	x,#L46
2138  0813 cd0000        	call	c_lcmp
2140  0816 25e8          	jrult	L745
2141                     ; 396 				Serial_print_string("time: ");
2143  0818 ae00f6        	ldw	x,#L335
2144  081b cd09aa        	call	_Serial_print_string
2146                     ; 397 				Serial_print_int(tms>>16);
2148  081e be00          	ldw	x,_tms
2149  0820 cd09d3        	call	_Serial_print_int
2151                     ; 398 				Serial_print_string(" ");
2153  0823 ae0110        	ldw	x,#L105
2154  0826 cd09aa        	call	_Serial_print_string
2156                     ; 399 				Serial_print_int((uint16_t)tms);
2158  0829 be02          	ldw	x,_tms+2
2159  082b cd09d3        	call	_Serial_print_int
2161                     ; 400 				Serial_newline();
2163  082e cd0a36        	call	_Serial_newline
2166  0831 20c3          	jra	L345
2167  0833               L77:
2168                     ; 405 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2170  0833 c650c6        	ld	a,20678
2171  0836 a4e7          	and	a,#231
2172  0838 c750c6        	ld	20678,a
2173                     ; 407 			GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
2175  083b 4bf0          	push	#240
2176  083d 4b20          	push	#32
2177  083f ae500f        	ldw	x,#20495
2178  0842 cd0000        	call	_GPIO_Init
2180  0845 85            	popw	x
2181                     ; 408 			GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
2183  0846 4b40          	push	#64
2184  0848 4b40          	push	#64
2185  084a ae500f        	ldw	x,#20495
2186  084d cd0000        	call	_GPIO_Init
2188  0850 85            	popw	x
2189                     ; 409 			UART1_DeInit();
2191  0851 cd0000        	call	_UART1_DeInit
2193                     ; 410 			UART1_Init(1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
2195  0854 4b0c          	push	#12
2196  0856 4b80          	push	#128
2197  0858 4b00          	push	#0
2198  085a 4b00          	push	#0
2199  085c 4b00          	push	#0
2200  085e ae4240        	ldw	x,#16960
2201  0861 89            	pushw	x
2202  0862 ae000f        	ldw	x,#15
2203  0865 89            	pushw	x
2204  0866 cd0000        	call	_UART1_Init
2206  0869 5b09          	addw	sp,#9
2207                     ; 412 			UART1_Cmd(ENABLE);
2209  086b a601          	ld	a,#1
2210  086d cd0000        	call	_UART1_Cmd
2212                     ; 414 			Serial_print_string("Mode: ");
2214  0870 ae0109        	ldw	x,#L125
2215  0873 cd09aa        	call	_Serial_print_string
2217                     ; 415 			Serial_print_int(test_mode);
2219  0876 1e33          	ldw	x,(OFST-5,sp)
2220  0878 cd09d3        	call	_Serial_print_int
2222                     ; 416 			Serial_newline();
2224  087b cd0a36        	call	_Serial_newline
2226                     ; 418 			TIM4->PSCR= 7;// init divider register /128	
2228  087e 35075347      	mov	21319,#7
2229                     ; 419 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2231  0882 357d5348      	mov	21320,#125
2232                     ; 420 			TIM4->EGR= TIM4_EGR_UG;// update registers
2234  0886 35015345      	mov	21317,#1
2235                     ; 421 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2237  088a c65340        	ld	a,21312
2238  088d aa85          	or	a,#133
2239  088f c75340        	ld	21312,a
2240                     ; 422 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2242  0892 35015343      	mov	21315,#1
2243                     ; 423 			enableInterrupts();
2246  0896 9a            rim
2248  0897               L555:
2249                     ; 429 					setMatrixHighZ();
2251  0897 cd0a45        	call	_setMatrixHighZ
2253                     ; 430 					mean_sum=tms/60;
2255  089a ae0000        	ldw	x,#_tms
2256  089d cd0000        	call	c_ltor
2258  08a0 ae0030        	ldw	x,#L66
2259  08a3 cd0000        	call	c_ludv
2261  08a6 96            	ldw	x,sp
2262  08a7 1c0027        	addw	x,#OFST-17
2263  08aa cd0000        	call	c_rtol
2266                     ; 431 					mean_low=tms%2;//is high or low charlieplexing
2268  08ad b603          	ld	a,_tms+3
2269  08af a401          	and	a,#1
2270  08b1 6b22          	ld	(OFST-22,sp),a
2271  08b3 4f            	clr	a
2272  08b4 6b21          	ld	(OFST-23,sp),a
2273  08b6 6b20          	ld	(OFST-24,sp),a
2274  08b8 6b1f          	ld	(OFST-25,sp),a
2276                     ; 432 					mean_high=(mean_sum/2)%5;//which LED, 2x on display lit
2278  08ba 96            	ldw	x,sp
2279  08bb 1c0027        	addw	x,#OFST-17
2280  08be cd0000        	call	c_ltor
2282  08c1 3400          	srl	c_lreg
2283  08c3 3601          	rrc	c_lreg+1
2284  08c5 3602          	rrc	c_lreg+2
2285  08c7 3603          	rrc	c_lreg+3
2286  08c9 ae0034        	ldw	x,#L07
2287  08cc cd0000        	call	c_lumd
2289  08cf 96            	ldw	x,sp
2290  08d0 1c002d        	addw	x,#OFST-11
2291  08d3 cd0000        	call	c_rtol
2294                     ; 433 					sound_level=(mean_sum/10)%3;//RGB
2296  08d6 96            	ldw	x,sp
2297  08d7 1c0027        	addw	x,#OFST-17
2298  08da cd0000        	call	c_ltor
2300  08dd ae001c        	ldw	x,#L04
2301  08e0 cd0000        	call	c_ludv
2303  08e3 ae0038        	ldw	x,#L27
2304  08e6 cd0000        	call	c_lumd
2306  08e9 be02          	ldw	x,c_lreg+2
2307  08eb 1f31          	ldw	(OFST-7,sp),x
2309                     ; 434 					setRGB(mean_high+(mean_low?5:0),sound_level);
2311  08ed 1e31          	ldw	x,(OFST-7,sp)
2312  08ef 89            	pushw	x
2313  08f0 96            	ldw	x,sp
2314  08f1 1c0021        	addw	x,#OFST-23
2315  08f4 cd0000        	call	c_lzmp
2317  08f7 2705          	jreq	L47
2318  08f9 ae0005        	ldw	x,#5
2319  08fc 2001          	jra	L67
2320  08fe               L47:
2321  08fe 5f            	clrw	x
2322  08ff               L67:
2323  08ff cd0000        	call	c_itolx
2325  0902 96            	ldw	x,sp
2326  0903 1c002f        	addw	x,#OFST-9
2327  0906 cd0000        	call	c_ladd
2329  0909 be02          	ldw	x,c_lreg+2
2330  090b cd0a5c        	call	_setRGB
2332  090e 85            	popw	x
2334  090f 2086          	jpf	L555
2335  0911               L101:
2336                     ; 440 			CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0)
2338  0911 c650c6        	ld	a,20678
2339  0914 a4e7          	and	a,#231
2340  0916 c750c6        	ld	20678,a
2341                     ; 442 			TIM4->PSCR= 7;// init divider register /128	
2343  0919 35075347      	mov	21319,#7
2344                     ; 443 			TIM4->ARR= 256 - (u8)(-125);// init auto reload register
2346  091d 357d5348      	mov	21320,#125
2347                     ; 444 			TIM4->EGR= TIM4_EGR_UG;// update registers
2349  0921 35015345      	mov	21317,#1
2350                     ; 445 			TIM4->CR1|= TIM4_CR1_ARPE | TIM4_CR1_URS |TIM4_CR1_CEN;// enable timer
2352  0925 c65340        	ld	a,21312
2353  0928 aa85          	or	a,#133
2354  092a c75340        	ld	21312,a
2355                     ; 446 			TIM4->IER= TIM4_IER_UIE;// enable TIM4 interrupt
2357  092d 35015343      	mov	21315,#1
2358                     ; 447 			enableInterrupts();
2361  0931 9a            rim
2363  0932               L165:
2364                     ; 450 				if(tms%8000==0 && mean_sum!=tms/8000)
2366  0932 ae0000        	ldw	x,#_tms
2367  0935 cd0000        	call	c_ltor
2369  0938 ae003c        	ldw	x,#L001
2370  093b cd0000        	call	c_lumd
2372  093e cd0000        	call	c_lrzmp
2374  0941 26ef          	jrne	L165
2376  0943 ae0000        	ldw	x,#_tms
2377  0946 cd0000        	call	c_ltor
2379  0949 ae003c        	ldw	x,#L001
2380  094c cd0000        	call	c_ludv
2382  094f 96            	ldw	x,sp
2383  0950 1c0027        	addw	x,#OFST-17
2384  0953 cd0000        	call	c_lcmp
2386  0956 27da          	jreq	L165
2387                     ; 452 				  setMatrixHighZ();
2389  0958 cd0a45        	call	_setMatrixHighZ
2391                     ; 453 					mean_sum=tms/8000;
2393  095b ae0000        	ldw	x,#_tms
2394  095e cd0000        	call	c_ltor
2396  0961 ae003c        	ldw	x,#L001
2397  0964 cd0000        	call	c_ludv
2399  0967 96            	ldw	x,sp
2400  0968 1c0027        	addw	x,#OFST-17
2401  096b cd0000        	call	c_rtol
2404                     ; 454 					if(mean_sum%4==3)
2406  096e 7b2a          	ld	a,(OFST-14,sp)
2407  0970 a403          	and	a,#3
2408  0972 a103          	cp	a,#3
2409  0974 2608          	jrne	L765
2410                     ; 456 						setWhite(11);
2412  0976 ae000b        	ldw	x,#11
2413  0979 cd0a6b        	call	_setWhite
2416  097c 20b4          	jra	L165
2417  097e               L765:
2418                     ; 458 						setRGB(4,mean_sum%4);
2420  097e 7b2a          	ld	a,(OFST-14,sp)
2421  0980 5f            	clrw	x
2422  0981 a403          	and	a,#3
2423  0983 5f            	clrw	x
2424  0984 02            	rlwa	x,a
2425  0985 89            	pushw	x
2426  0986 01            	rrwa	x,a
2427  0987 ae0004        	ldw	x,#4
2428  098a cd0a5c        	call	_setRGB
2430  098d 85            	popw	x
2431  098e 20a2          	jra	L165
2432  0990               L201:
2433                     ; 490 }
2436  0990 5b38          	addw	sp,#56
2437  0992 81            	ret
2462                     ; 492 @far @interrupt void TIM4_UPD_OVF_IRQHandler (void) {
2464                     	switch	.text
2465  0993               f_TIM4_UPD_OVF_IRQHandler:
2469                     ; 493 	TIM4->SR1&=~TIM4_SR1_UIF;
2471  0993 72115344      	bres	21316,#0
2472                     ; 494 	tms++;
2474  0997 ae0000        	ldw	x,#_tms
2475  099a a601          	ld	a,#1
2476  099c cd0000        	call	c_lgadc
2478                     ; 495 }
2481  099f 80            	iret
2504                     ; 497 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
2505                     	switch	.text
2506  09a0               f_TIM2_UPD_OVF_IRQHandler:
2510                     ; 498 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
2512  09a0 72115304      	bres	21252,#0
2513                     ; 500 }
2516  09a4 80            	iret
2539                     ; 502 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
2540                     	switch	.text
2541  09a5               f_TIM2_CapComp_IRQ_Handler:
2545                     ; 503 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
2547  09a5 72135304      	bres	21252,#1
2548                     ; 505 }
2551  09a9 80            	iret
2597                     ; 528  void Serial_print_string (char string[])
2597                     ; 529  {
2599                     	switch	.text
2600  09aa               _Serial_print_string:
2602  09aa 89            	pushw	x
2603  09ab 88            	push	a
2604       00000001      OFST:	set	1
2607                     ; 531 	 char i=0;
2609  09ac 0f01          	clr	(OFST+0,sp)
2612  09ae 2016          	jra	L156
2613  09b0               L546:
2614                     ; 535 		UART1_SendData8(string[i]);
2616  09b0 7b01          	ld	a,(OFST+0,sp)
2617  09b2 5f            	clrw	x
2618  09b3 97            	ld	xl,a
2619  09b4 72fb02        	addw	x,(OFST+1,sp)
2620  09b7 f6            	ld	a,(x)
2621  09b8 cd0000        	call	_UART1_SendData8
2624  09bb               L756:
2625                     ; 536 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
2627  09bb ae0080        	ldw	x,#128
2628  09be cd0000        	call	_UART1_GetFlagStatus
2630  09c1 4d            	tnz	a
2631  09c2 27f7          	jreq	L756
2632                     ; 537 		i++;
2634  09c4 0c01          	inc	(OFST+0,sp)
2636  09c6               L156:
2637                     ; 533 	 while (string[i] != 0x00)
2639  09c6 7b01          	ld	a,(OFST+0,sp)
2640  09c8 5f            	clrw	x
2641  09c9 97            	ld	xl,a
2642  09ca 72fb02        	addw	x,(OFST+1,sp)
2643  09cd 7d            	tnz	(x)
2644  09ce 26e0          	jrne	L546
2645                     ; 539  }
2648  09d0 5b03          	addw	sp,#3
2649  09d2 81            	ret
2652                     	switch	.const
2653  0040               L366_digit:
2654  0040 00            	dc.b	0
2655  0041 00000000      	ds.b	4
2708                     ; 541  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
2708                     ; 542  {
2709                     	switch	.text
2710  09d3               _Serial_print_int:
2712  09d3 89            	pushw	x
2713  09d4 5208          	subw	sp,#8
2714       00000008      OFST:	set	8
2717                     ; 543 	 char count = 0;
2719  09d6 0f08          	clr	(OFST+0,sp)
2721                     ; 544 	 char digit[5] = "";
2723  09d8 96            	ldw	x,sp
2724  09d9 1c0003        	addw	x,#OFST-5
2725  09dc 90ae0040      	ldw	y,#L366_digit
2726  09e0 a605          	ld	a,#5
2727  09e2 cd0000        	call	c_xymov
2730  09e5 2023          	jra	L717
2731  09e7               L317:
2732                     ; 548 		 digit[count] = number%10;
2734  09e7 96            	ldw	x,sp
2735  09e8 1c0003        	addw	x,#OFST-5
2736  09eb 9f            	ld	a,xl
2737  09ec 5e            	swapw	x
2738  09ed 1b08          	add	a,(OFST+0,sp)
2739  09ef 2401          	jrnc	L041
2740  09f1 5c            	incw	x
2741  09f2               L041:
2742  09f2 02            	rlwa	x,a
2743  09f3 1609          	ldw	y,(OFST+1,sp)
2744  09f5 a60a          	ld	a,#10
2745  09f7 cd0000        	call	c_smody
2747  09fa 9001          	rrwa	y,a
2748  09fc f7            	ld	(x),a
2749  09fd 9002          	rlwa	y,a
2750                     ; 549 		 count++;
2752  09ff 0c08          	inc	(OFST+0,sp)
2754                     ; 550 		 number = number/10;
2756  0a01 1e09          	ldw	x,(OFST+1,sp)
2757  0a03 a60a          	ld	a,#10
2758  0a05 cd0000        	call	c_sdivx
2760  0a08 1f09          	ldw	(OFST+1,sp),x
2761  0a0a               L717:
2762                     ; 546 	 while (number != 0) //split the int to char array 
2764  0a0a 1e09          	ldw	x,(OFST+1,sp)
2765  0a0c 26d9          	jrne	L317
2767  0a0e 201f          	jra	L527
2768  0a10               L327:
2769                     ; 555 		UART1_SendData8(digit[count-1] + 0x30);
2771  0a10 96            	ldw	x,sp
2772  0a11 1c0003        	addw	x,#OFST-5
2773  0a14 1f01          	ldw	(OFST-7,sp),x
2775  0a16 7b08          	ld	a,(OFST+0,sp)
2776  0a18 5f            	clrw	x
2777  0a19 97            	ld	xl,a
2778  0a1a 5a            	decw	x
2779  0a1b 72fb01        	addw	x,(OFST-7,sp)
2780  0a1e f6            	ld	a,(x)
2781  0a1f ab30          	add	a,#48
2782  0a21 cd0000        	call	_UART1_SendData8
2785  0a24               L337:
2786                     ; 556 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2788  0a24 ae0080        	ldw	x,#128
2789  0a27 cd0000        	call	_UART1_GetFlagStatus
2791  0a2a 4d            	tnz	a
2792  0a2b 27f7          	jreq	L337
2793                     ; 557 		count--; 
2795  0a2d 0a08          	dec	(OFST+0,sp)
2797  0a2f               L527:
2798                     ; 553 	 while (count !=0) //print char array in correct direction 
2800  0a2f 0d08          	tnz	(OFST+0,sp)
2801  0a31 26dd          	jrne	L327
2802                     ; 559  }
2805  0a33 5b0a          	addw	sp,#10
2806  0a35 81            	ret
2831                     ; 561  void Serial_newline(void)
2831                     ; 562  {
2832                     	switch	.text
2833  0a36               _Serial_newline:
2837                     ; 563 	 UART1_SendData8(0x0a);
2839  0a36 a60a          	ld	a,#10
2840  0a38 cd0000        	call	_UART1_SendData8
2843  0a3b               L157:
2844                     ; 564 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
2846  0a3b ae0080        	ldw	x,#128
2847  0a3e cd0000        	call	_UART1_GetFlagStatus
2849  0a41 4d            	tnz	a
2850  0a42 27f7          	jreq	L157
2851                     ; 565  }
2854  0a44 81            	ret
2878                     ; 567 void setMatrixHighZ()
2878                     ; 568 {
2879                     	switch	.text
2880  0a45               _setMatrixHighZ:
2884                     ; 573 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2886  0a45 4b00          	push	#0
2887  0a47 4bf8          	push	#248
2888  0a49 ae500a        	ldw	x,#20490
2889  0a4c cd0000        	call	_GPIO_Init
2891  0a4f 85            	popw	x
2892                     ; 574 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
2894  0a50 4b00          	push	#0
2895  0a52 4b0c          	push	#12
2896  0a54 ae500f        	ldw	x,#20495
2897  0a57 cd0000        	call	_GPIO_Init
2899  0a5a 85            	popw	x
2900                     ; 575 }
2903  0a5b 81            	ret
2947                     ; 577 void setRGB(int led_index,int rgb_index){ setLED(1,led_index,rgb_index); }
2948                     	switch	.text
2949  0a5c               _setRGB:
2951  0a5c 89            	pushw	x
2952       00000000      OFST:	set	0
2957  0a5d 1e05          	ldw	x,(OFST+5,sp)
2958  0a5f 89            	pushw	x
2959  0a60 1e03          	ldw	x,(OFST+3,sp)
2960  0a62 89            	pushw	x
2961  0a63 a601          	ld	a,#1
2962  0a65 ad11          	call	_setLED
2964  0a67 5b04          	addw	sp,#4
2968  0a69 85            	popw	x
2969  0a6a 81            	ret
3004                     ; 578 void setWhite(int led_index){ setLED(0,led_index,0); }
3005                     	switch	.text
3006  0a6b               _setWhite:
3008  0a6b 89            	pushw	x
3009       00000000      OFST:	set	0
3014  0a6c 5f            	clrw	x
3015  0a6d 89            	pushw	x
3016  0a6e 1e03          	ldw	x,(OFST+3,sp)
3017  0a70 89            	pushw	x
3018  0a71 4f            	clr	a
3019  0a72 ad04          	call	_setLED
3021  0a74 5b04          	addw	sp,#4
3025  0a76 85            	popw	x
3026  0a77 81            	ret
3029                     	switch	.const
3030  0045               L5201_rgb_lookup:
3031  0045 0000          	dc.w	0
3032  0047 0001          	dc.w	1
3033  0049 0000          	dc.w	0
3034  004b 0002          	dc.w	2
3035  004d 0001          	dc.w	1
3036  004f 0002          	dc.w	2
3037  0051 0001          	dc.w	1
3038  0053 0000          	dc.w	0
3039  0055 0002          	dc.w	2
3040  0057 0000          	dc.w	0
3041  0059 0002          	dc.w	2
3042  005b 0001          	dc.w	1
3043  005d 0005          	dc.w	5
3044  005f 0000          	dc.w	0
3045  0061 0005          	dc.w	5
3046  0063 0001          	dc.w	1
3047  0065 0005          	dc.w	5
3048  0067 0002          	dc.w	2
3049  0069 0006          	dc.w	6
3050  006b 0000          	dc.w	0
3051  006d 0006          	dc.w	6
3052  006f 0001          	dc.w	1
3053  0071 0006          	dc.w	6
3054  0073 0002          	dc.w	2
3055  0075 0006          	dc.w	6
3056  0077 0005          	dc.w	5
3057  0079 0006          	dc.w	6
3058  007b 0004          	dc.w	4
3059  007d 0005          	dc.w	5
3060  007f 0004          	dc.w	4
3061  0081 0004          	dc.w	4
3062  0083 0003          	dc.w	3
3063  0085 0005          	dc.w	5
3064  0087 0003          	dc.w	3
3065  0089 0006          	dc.w	6
3066  008b 0003          	dc.w	3
3067  008d 0003          	dc.w	3
3068  008f 0004          	dc.w	4
3069  0091 0003          	dc.w	3
3070  0093 0005          	dc.w	5
3071  0095 0003          	dc.w	3
3072  0097 0006          	dc.w	6
3073  0099 0000          	dc.w	0
3074  009b 0005          	dc.w	5
3075  009d 0000          	dc.w	0
3076  009f 0006          	dc.w	6
3077  00a1 0001          	dc.w	1
3078  00a3 0006          	dc.w	6
3079  00a5 0000          	dc.w	0
3080  00a7 0004          	dc.w	4
3081  00a9 0001          	dc.w	1
3082  00ab 0004          	dc.w	4
3083  00ad 0002          	dc.w	2
3084  00af 0004          	dc.w	4
3085  00b1 0000          	dc.w	0
3086  00b3 0003          	dc.w	3
3087  00b5 0001          	dc.w	1
3088  00b7 0003          	dc.w	3
3089  00b9 0002          	dc.w	2
3090  00bb 0003          	dc.w	3
3091  00bd               L7201_white_lookup:
3092  00bd 0003          	dc.w	3
3093  00bf 0000          	dc.w	0
3094  00c1 0003          	dc.w	3
3095  00c3 0001          	dc.w	1
3096  00c5 0003          	dc.w	3
3097  00c7 0002          	dc.w	2
3098  00c9 0004          	dc.w	4
3099  00cb 0000          	dc.w	0
3100  00cd 0001          	dc.w	1
3101  00cf 0005          	dc.w	5
3102  00d1 0002          	dc.w	2
3103  00d3 0005          	dc.w	5
3104  00d5 0004          	dc.w	4
3105  00d7 0001          	dc.w	1
3106  00d9 0004          	dc.w	4
3107  00db 0002          	dc.w	2
3108  00dd 0002          	dc.w	2
3109  00df 0006          	dc.w	6
3110  00e1 0004          	dc.w	4
3111  00e3 0006          	dc.w	6
3112  00e5 0004          	dc.w	4
3113  00e7 0005          	dc.w	5
3114  00e9 0005          	dc.w	5
3115  00eb 0006          	dc.w	6
3377                     ; 580 void setLED(bool is_rgb,int led_index,int rgb_index)
3377                     ; 581 {
3378                     	switch	.text
3379  0a78               _setLED:
3381  0a78 88            	push	a
3382  0a79 52b6          	subw	sp,#182
3383       000000b6      OFST:	set	182
3386                     ; 582   const unsigned short rgb_lookup[10][3][2]={
3386                     ; 583 		{{0,1},{0,2},{1,2}},//7
3386                     ; 584 		{{1,0},{2,0},{2,1}},//3
3386                     ; 585 		{{5,0},{5,1},{5,2}},//1
3386                     ; 586 		{{6,0},{6,1},{6,2}},//20
3386                     ; 587 		{{6,5},{6,4},{5,4}},//22
3386                     ; 588 		{{4,3},{5,3},{6,3}},//23
3386                     ; 589 		{{3,4},{3,5},{3,6}},//21
3386                     ; 590 		{{0,5},{0,6},{1,6}},//19
3386                     ; 591 		{{0,4},{1,4},{2,4}},//18
3386                     ; 592 		{{0,3},{1,3},{2,3}} //2
3386                     ; 593 	};
3388  0a7b 96            	ldw	x,sp
3389  0a7c 1c000e        	addw	x,#OFST-168
3390  0a7f 90ae0045      	ldw	y,#L5201_rgb_lookup
3391  0a83 a678          	ld	a,#120
3392  0a85 cd0000        	call	c_xymov
3394                     ; 594 	const unsigned short white_lookup[12][2]={
3394                     ; 595 		{3,0},//6
3394                     ; 596 		{3,1},//4
3394                     ; 597 		{3,2},//5
3394                     ; 598 		{4,0},//14
3394                     ; 599 		{1,5},//8
3394                     ; 600 		{2,5},//9
3394                     ; 601 		{4,1},//10
3394                     ; 602 		{4,2},//16
3394                     ; 603 		{2,6},//17
3394                     ; 604 		{4,6},//12
3394                     ; 605 		{4,5},//13
3394                     ; 606 		{5,6} //11
3394                     ; 607 	};
3396  0a88 96            	ldw	x,sp
3397  0a89 1c0086        	addw	x,#OFST-48
3398  0a8c 90ae00bd      	ldw	y,#L7201_white_lookup
3399  0a90 a630          	ld	a,#48
3400  0a92 cd0000        	call	c_xymov
3402                     ; 608 	bool is_low=0;
3404  0a95 0fb6          	clr	(OFST+0,sp)
3406  0a97               L7121:
3407                     ; 612 		switch(is_rgb?rgb_lookup[led_index][rgb_index][is_low]:white_lookup[led_index][is_low])
3409  0a97 0db7          	tnz	(OFST+1,sp)
3410  0a99 2726          	jreq	L451
3411  0a9b 7bb6          	ld	a,(OFST+0,sp)
3412  0a9d 5f            	clrw	x
3413  0a9e 97            	ld	xl,a
3414  0a9f 58            	sllw	x
3415  0aa0 1f09          	ldw	(OFST-173,sp),x
3417  0aa2 1ebc          	ldw	x,(OFST+6,sp)
3418  0aa4 58            	sllw	x
3419  0aa5 58            	sllw	x
3420  0aa6 1f07          	ldw	(OFST-175,sp),x
3422  0aa8 96            	ldw	x,sp
3423  0aa9 1c000e        	addw	x,#OFST-168
3424  0aac 1f05          	ldw	(OFST-177,sp),x
3426  0aae 1eba          	ldw	x,(OFST+4,sp)
3427  0ab0 a60c          	ld	a,#12
3428  0ab2 cd0000        	call	c_bmulx
3430  0ab5 72fb05        	addw	x,(OFST-177,sp)
3431  0ab8 72fb07        	addw	x,(OFST-175,sp)
3432  0abb 72fb09        	addw	x,(OFST-173,sp)
3433  0abe fe            	ldw	x,(x)
3434  0abf 2018          	jra	L651
3435  0ac1               L451:
3436  0ac1 7bb6          	ld	a,(OFST+0,sp)
3437  0ac3 5f            	clrw	x
3438  0ac4 97            	ld	xl,a
3439  0ac5 58            	sllw	x
3440  0ac6 1f03          	ldw	(OFST-179,sp),x
3442  0ac8 96            	ldw	x,sp
3443  0ac9 1c0086        	addw	x,#OFST-48
3444  0acc 1f01          	ldw	(OFST-181,sp),x
3446  0ace 1eba          	ldw	x,(OFST+4,sp)
3447  0ad0 58            	sllw	x
3448  0ad1 58            	sllw	x
3449  0ad2 72fb01        	addw	x,(OFST-181,sp)
3450  0ad5 72fb03        	addw	x,(OFST-179,sp)
3451  0ad8 fe            	ldw	x,(x)
3452  0ad9               L651:
3454                     ; 644 			}break;
3455  0ad9 5d            	tnzw	x
3456  0ada 2714          	jreq	L1301
3457  0adc 5a            	decw	x
3458  0add 271c          	jreq	L3301
3459  0adf 5a            	decw	x
3460  0ae0 2724          	jreq	L5301
3461  0ae2 5a            	decw	x
3462  0ae3 272c          	jreq	L7301
3463  0ae5 5a            	decw	x
3464  0ae6 2734          	jreq	L1401
3465  0ae8 5a            	decw	x
3466  0ae9 273c          	jreq	L3401
3467  0aeb 5a            	decw	x
3468  0aec 2744          	jreq	L5401
3469  0aee 204b          	jra	L7221
3470  0af0               L1301:
3471                     ; 615 				GPIOx=GPIOD;
3473  0af0 ae500f        	ldw	x,#20495
3474  0af3 1f0b          	ldw	(OFST-171,sp),x
3476                     ; 616 				PortPin=GPIO_PIN_3;
3478  0af5 a608          	ld	a,#8
3479  0af7 6b0d          	ld	(OFST-169,sp),a
3481                     ; 617 			}break;
3483  0af9 2040          	jra	L7221
3484  0afb               L3301:
3485                     ; 619 				GPIOx=GPIOD;
3487  0afb ae500f        	ldw	x,#20495
3488  0afe 1f0b          	ldw	(OFST-171,sp),x
3490                     ; 620 				PortPin=GPIO_PIN_2;
3492  0b00 a604          	ld	a,#4
3493  0b02 6b0d          	ld	(OFST-169,sp),a
3495                     ; 621 			}break;
3497  0b04 2035          	jra	L7221
3498  0b06               L5301:
3499                     ; 623 				GPIOx=GPIOC;
3501  0b06 ae500a        	ldw	x,#20490
3502  0b09 1f0b          	ldw	(OFST-171,sp),x
3504                     ; 624 				PortPin=GPIO_PIN_7;
3506  0b0b a680          	ld	a,#128
3507  0b0d 6b0d          	ld	(OFST-169,sp),a
3509                     ; 625 			}break;
3511  0b0f 202a          	jra	L7221
3512  0b11               L7301:
3513                     ; 627 				GPIOx=GPIOC;
3515  0b11 ae500a        	ldw	x,#20490
3516  0b14 1f0b          	ldw	(OFST-171,sp),x
3518                     ; 628 				PortPin=GPIO_PIN_6;
3520  0b16 a640          	ld	a,#64
3521  0b18 6b0d          	ld	(OFST-169,sp),a
3523                     ; 629 			}break;
3525  0b1a 201f          	jra	L7221
3526  0b1c               L1401:
3527                     ; 631 				GPIOx=GPIOC;
3529  0b1c ae500a        	ldw	x,#20490
3530  0b1f 1f0b          	ldw	(OFST-171,sp),x
3532                     ; 632 				PortPin=GPIO_PIN_5;
3534  0b21 a620          	ld	a,#32
3535  0b23 6b0d          	ld	(OFST-169,sp),a
3537                     ; 633 			}break;
3539  0b25 2014          	jra	L7221
3540  0b27               L3401:
3541                     ; 635 				GPIOx=GPIOC;
3543  0b27 ae500a        	ldw	x,#20490
3544  0b2a 1f0b          	ldw	(OFST-171,sp),x
3546                     ; 636 				PortPin=GPIO_PIN_4;
3548  0b2c a610          	ld	a,#16
3549  0b2e 6b0d          	ld	(OFST-169,sp),a
3551                     ; 637 			}break;
3553  0b30 2009          	jra	L7221
3554  0b32               L5401:
3555                     ; 639 				GPIOx=GPIOC;
3557  0b32 ae500a        	ldw	x,#20490
3558  0b35 1f0b          	ldw	(OFST-171,sp),x
3560                     ; 640 				PortPin=GPIO_PIN_3;
3562  0b37 a608          	ld	a,#8
3563  0b39 6b0d          	ld	(OFST-169,sp),a
3565                     ; 641 			}break;
3567  0b3b               L7221:
3568                     ; 646 		GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
3570  0b3b 0db6          	tnz	(OFST+0,sp)
3571  0b3d 2704          	jreq	L061
3572  0b3f a6c0          	ld	a,#192
3573  0b41 2002          	jra	L261
3574  0b43               L061:
3575  0b43 a6d0          	ld	a,#208
3576  0b45               L261:
3577  0b45 88            	push	a
3578  0b46 7b0e          	ld	a,(OFST-168,sp)
3579  0b48 88            	push	a
3580  0b49 1e0d          	ldw	x,(OFST-169,sp)
3581  0b4b cd0000        	call	_GPIO_Init
3583  0b4e 85            	popw	x
3584                     ; 647 		is_low=!is_low;
3586  0b4f 0db6          	tnz	(OFST+0,sp)
3587  0b51 2604          	jrne	L461
3588  0b53 a601          	ld	a,#1
3589  0b55 2001          	jra	L661
3590  0b57               L461:
3591  0b57 4f            	clr	a
3592  0b58               L661:
3593  0b58 6bb6          	ld	(OFST+0,sp),a
3595                     ; 648 	}while(is_low);
3597  0b5a 0db6          	tnz	(OFST+0,sp)
3598  0b5c 2703          	jreq	L071
3599  0b5e cc0a97        	jp	L7121
3600  0b61               L071:
3601                     ; 649 }
3604  0b61 5bb7          	addw	sp,#183
3605  0b63 81            	ret
3629                     	xdef	f_TIM2_CapComp_IRQ_Handler
3630                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3631                     	xdef	f_TIM4_UPD_OVF_IRQHandler
3632                     	xdef	_main
3633                     	xdef	_Serial_print_string
3634                     	xdef	_Serial_newline
3635                     	xdef	_Serial_print_int
3636                     	xdef	_setWhite
3637                     	xdef	_setRGB
3638                     	xdef	_setLED
3639                     	xdef	_setMatrixHighZ
3640                     	xdef	_tms
3641                     	xdef	_ADC_Read
3642                     	xref	_UART1_GetFlagStatus
3643                     	xref	_UART1_SendData8
3644                     	xref	_UART1_Cmd
3645                     	xref	_UART1_Init
3646                     	xref	_UART1_DeInit
3647                     	xref	_GPIO_ReadInputPin
3648                     	xref	_GPIO_Init
3649                     	xref	_ADC1_ClearFlag
3650                     	xref	_ADC1_GetFlagStatus
3651                     	xref	_ADC1_GetConversionValue
3652                     	xref	_ADC1_StartConversion
3653                     	xref	_ADC1_Cmd
3654                     	xref	_ADC1_Init
3655                     	xref	_ADC1_DeInit
3656                     	switch	.const
3657  00ed               L145:
3658  00ed 506172616d73  	dc.b	"Params: ",0
3659  00f6               L335:
3660  00f6 74696d653a20  	dc.b	"time: ",0
3661  00fd               L325:
3662  00fd 506172616d73  	dc.b	"Params v2: ",0
3663  0109               L125:
3664  0109 4d6f64653a20  	dc.b	"Mode: ",0
3665  0110               L105:
3666  0110 2000          	dc.b	" ",0
3667  0112               L144:
3668  0112 2a00          	dc.b	"*",0
3669  0114               L724:
3670  0114 3000          	dc.b	"0",0
3671  0116               L163:
3672  0116 2c2000        	dc.b	", ",0
3673  0119               L753:
3674  0119 6164633a2000  	dc.b	"adc: ",0
3675  011f               L723:
3676  011f 636f756e7465  	dc.b	"counter: ",0
3677                     	xref.b	c_lreg
3678                     	xref.b	c_x
3679                     	xref.b	c_y
3699                     	xref	c_bmulx
3700                     	xref	c_sdivx
3701                     	xref	c_smody
3702                     	xref	c_lxor
3703                     	xref	c_itolx
3704                     	xref	c_lrzmp
3705                     	xref	c_lumd
3706                     	xref	c_imul
3707                     	xref	c_ladd
3708                     	xref	c_lursh
3709                     	xref	c_uitol
3710                     	xref	c_smodx
3711                     	xref	c_ludv
3712                     	xref	c_itol
3713                     	xref	c_rtol
3714                     	xref	c_uitolx
3715                     	xref	c_lzmp
3716                     	xref	c_lcmp
3717                     	xref	c_ltor
3718                     	xref	c_lgadc
3719                     	xref	c_xymov
3720                     	end
