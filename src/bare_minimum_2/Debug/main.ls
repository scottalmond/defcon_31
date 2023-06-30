   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _debug:
  16  0000 0000          	dc.w	0
  92                     ; 14 int main()
  92                     ; 15 {
  94                     	switch	.text
  95  0000               _main:
  97  0000 5206          	subw	sp,#6
  98       00000006      OFST:	set	6
 101                     ; 39 	for(rep=0;rep<4;rep++)
 103  0002 5f            	clrw	x
 104  0003 1f03          	ldw	(OFST-3,sp),x
 106  0005               L34:
 107                     ; 40 		for(iter=0;iter<30000;iter++){}
 109  0005 5f            	clrw	x
 110  0006 1f05          	ldw	(OFST-1,sp),x
 112  0008               L15:
 115  0008 1e05          	ldw	x,(OFST-1,sp)
 116  000a 1c0001        	addw	x,#1
 117  000d 1f05          	ldw	(OFST-1,sp),x
 121  000f 1e05          	ldw	x,(OFST-1,sp)
 122  0011 a37530        	cpw	x,#30000
 123  0014 25f2          	jrult	L15
 124                     ; 39 	for(rep=0;rep<4;rep++)
 126  0016 1e03          	ldw	x,(OFST-3,sp)
 127  0018 1c0001        	addw	x,#1
 128  001b 1f03          	ldw	(OFST-3,sp),x
 132  001d 1e03          	ldw	x,(OFST-3,sp)
 133  001f a30004        	cpw	x,#4
 134  0022 25e1          	jrult	L34
 135                     ; 43   GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 137  0024 4bf0          	push	#240
 138  0026 4b20          	push	#32
 139  0028 ae500f        	ldw	x,#20495
 140  002b cd0000        	call	_GPIO_Init
 142  002e 85            	popw	x
 143                     ; 44 	GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 145  002f 4b40          	push	#64
 146  0031 4b40          	push	#64
 147  0033 ae500f        	ldw	x,#20495
 148  0036 cd0000        	call	_GPIO_Init
 150  0039 85            	popw	x
 151                     ; 45 	UART1_DeInit();
 153  003a cd0000        	call	_UART1_DeInit
 155                     ; 46 	UART1_Init(9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 157  003d 4b0c          	push	#12
 158  003f 4b80          	push	#128
 159  0041 4b00          	push	#0
 160  0043 4b00          	push	#0
 161  0045 4b00          	push	#0
 162  0047 ae2580        	ldw	x,#9600
 163  004a 89            	pushw	x
 164  004b ae0000        	ldw	x,#0
 165  004e 89            	pushw	x
 166  004f cd0000        	call	_UART1_Init
 168  0052 5b09          	addw	sp,#9
 169                     ; 47 	UART1_Cmd(ENABLE);
 171  0054 a601          	ld	a,#1
 172  0056 cd0000        	call	_UART1_Cmd
 174  0059               L75:
 175                     ; 52 		for(rgb_index=0;rgb_index<3;rgb_index++)
 177  0059 5f            	clrw	x
 178  005a 1f03          	ldw	(OFST-3,sp),x
 180  005c               L36:
 181                     ; 54 			for(led_index=0;led_index<10;led_index++)
 183  005c 5f            	clrw	x
 184  005d 1f01          	ldw	(OFST-5,sp),x
 186  005f               L17:
 187                     ; 56 				setMatrixHighZ();
 189  005f cd011a        	call	_setMatrixHighZ
 191                     ; 57 				setRGB(led_index,rgb_index);
 193  0062 1e03          	ldw	x,(OFST-3,sp)
 194  0064 89            	pushw	x
 195  0065 1e03          	ldw	x,(OFST-3,sp)
 196  0067 cd0131        	call	_setRGB
 198  006a 85            	popw	x
 199                     ; 58 				for(iter=0;iter<30000;iter++){}
 201  006b 5f            	clrw	x
 202  006c 1f05          	ldw	(OFST-1,sp),x
 204  006e               L77:
 207  006e 1e05          	ldw	x,(OFST-1,sp)
 208  0070 1c0001        	addw	x,#1
 209  0073 1f05          	ldw	(OFST-1,sp),x
 213  0075 1e05          	ldw	x,(OFST-1,sp)
 214  0077 a37530        	cpw	x,#30000
 215  007a 25f2          	jrult	L77
 216                     ; 59 				debug++;
 218  007c be00          	ldw	x,_debug
 219  007e 1c0001        	addw	x,#1
 220  0081 bf00          	ldw	_debug,x
 221                     ; 66 					Serial_print_int(debug);
 223  0083 be00          	ldw	x,_debug
 224  0085 ad21          	call	_Serial_print_int
 226                     ; 69 					Serial_newline();
 228  0087 cd010b        	call	_Serial_newline
 230                     ; 54 			for(led_index=0;led_index<10;led_index++)
 232  008a 1e01          	ldw	x,(OFST-5,sp)
 233  008c 1c0001        	addw	x,#1
 234  008f 1f01          	ldw	(OFST-5,sp),x
 238  0091 1e01          	ldw	x,(OFST-5,sp)
 239  0093 a3000a        	cpw	x,#10
 240  0096 25c7          	jrult	L17
 241                     ; 52 		for(rgb_index=0;rgb_index<3;rgb_index++)
 243  0098 1e03          	ldw	x,(OFST-3,sp)
 244  009a 1c0001        	addw	x,#1
 245  009d 1f03          	ldw	(OFST-3,sp),x
 249  009f 1e03          	ldw	x,(OFST-3,sp)
 250  00a1 a30003        	cpw	x,#3
 251  00a4 25b6          	jrult	L36
 253  00a6 20b1          	jra	L75
 256                     .const:	section	.text
 257  0000               L501_digit:
 258  0000 00            	dc.b	0
 259  0001 00000000      	ds.b	4
 312                     ; 76  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 312                     ; 77  {
 313                     	switch	.text
 314  00a8               _Serial_print_int:
 316  00a8 89            	pushw	x
 317  00a9 5208          	subw	sp,#8
 318       00000008      OFST:	set	8
 321                     ; 78 	 char count = 0;
 323  00ab 0f08          	clr	(OFST+0,sp)
 325                     ; 79 	 char digit[5] = "";
 327  00ad 96            	ldw	x,sp
 328  00ae 1c0003        	addw	x,#OFST-5
 329  00b1 90ae0000      	ldw	y,#L501_digit
 330  00b5 a605          	ld	a,#5
 331  00b7 cd0000        	call	c_xymov
 334  00ba 2023          	jra	L141
 335  00bc               L531:
 336                     ; 83 		 digit[count] = number%10;
 338  00bc 96            	ldw	x,sp
 339  00bd 1c0003        	addw	x,#OFST-5
 340  00c0 9f            	ld	a,xl
 341  00c1 5e            	swapw	x
 342  00c2 1b08          	add	a,(OFST+0,sp)
 343  00c4 2401          	jrnc	L01
 344  00c6 5c            	incw	x
 345  00c7               L01:
 346  00c7 02            	rlwa	x,a
 347  00c8 1609          	ldw	y,(OFST+1,sp)
 348  00ca a60a          	ld	a,#10
 349  00cc cd0000        	call	c_smody
 351  00cf 9001          	rrwa	y,a
 352  00d1 f7            	ld	(x),a
 353  00d2 9002          	rlwa	y,a
 354                     ; 84 		 count++;
 356  00d4 0c08          	inc	(OFST+0,sp)
 358                     ; 85 		 number = number/10;
 360  00d6 1e09          	ldw	x,(OFST+1,sp)
 361  00d8 a60a          	ld	a,#10
 362  00da cd0000        	call	c_sdivx
 364  00dd 1f09          	ldw	(OFST+1,sp),x
 365  00df               L141:
 366                     ; 81 	 while (number != 0) //split the int to char array 
 368  00df 1e09          	ldw	x,(OFST+1,sp)
 369  00e1 26d9          	jrne	L531
 371  00e3 201f          	jra	L741
 372  00e5               L541:
 373                     ; 90 		UART1_SendData8(digit[count-1] + 0x30);
 375  00e5 96            	ldw	x,sp
 376  00e6 1c0003        	addw	x,#OFST-5
 377  00e9 1f01          	ldw	(OFST-7,sp),x
 379  00eb 7b08          	ld	a,(OFST+0,sp)
 380  00ed 5f            	clrw	x
 381  00ee 97            	ld	xl,a
 382  00ef 5a            	decw	x
 383  00f0 72fb01        	addw	x,(OFST-7,sp)
 384  00f3 f6            	ld	a,(x)
 385  00f4 ab30          	add	a,#48
 386  00f6 cd0000        	call	_UART1_SendData8
 389  00f9               L551:
 390                     ; 91 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 392  00f9 ae0080        	ldw	x,#128
 393  00fc cd0000        	call	_UART1_GetFlagStatus
 395  00ff 4d            	tnz	a
 396  0100 27f7          	jreq	L551
 397                     ; 92 		count--; 
 399  0102 0a08          	dec	(OFST+0,sp)
 401  0104               L741:
 402                     ; 88 	 while (count !=0) //print char array in correct direction 
 404  0104 0d08          	tnz	(OFST+0,sp)
 405  0106 26dd          	jrne	L541
 406                     ; 94  }
 409  0108 5b0a          	addw	sp,#10
 410  010a 81            	ret
 435                     ; 96  void Serial_newline(void)
 435                     ; 97  {
 436                     	switch	.text
 437  010b               _Serial_newline:
 441                     ; 98 	 UART1_SendData8(0x0a);
 443  010b a60a          	ld	a,#10
 444  010d cd0000        	call	_UART1_SendData8
 447  0110               L371:
 448                     ; 99 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 450  0110 ae0080        	ldw	x,#128
 451  0113 cd0000        	call	_UART1_GetFlagStatus
 453  0116 4d            	tnz	a
 454  0117 27f7          	jreq	L371
 455                     ; 100  }
 458  0119 81            	ret
 482                     ; 102 void setMatrixHighZ()
 482                     ; 103 {
 483                     	switch	.text
 484  011a               _setMatrixHighZ:
 488                     ; 104 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
 490  011a 4b00          	push	#0
 491  011c 4bf8          	push	#248
 492  011e ae500a        	ldw	x,#20490
 493  0121 cd0000        	call	_GPIO_Init
 495  0124 85            	popw	x
 496                     ; 105 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
 498  0125 4b00          	push	#0
 499  0127 4b0c          	push	#12
 500  0129 ae500f        	ldw	x,#20495
 501  012c cd0000        	call	_GPIO_Init
 503  012f 85            	popw	x
 504                     ; 106 }
 507  0130 81            	ret
 510                     	switch	.const
 511  0005               L702_matrix_lookup:
 512  0005 0000          	dc.w	0
 513  0007 0001          	dc.w	1
 514  0009 0000          	dc.w	0
 515  000b 0002          	dc.w	2
 516  000d 0001          	dc.w	1
 517  000f 0002          	dc.w	2
 518  0011 0001          	dc.w	1
 519  0013 0000          	dc.w	0
 520  0015 0002          	dc.w	2
 521  0017 0000          	dc.w	0
 522  0019 0002          	dc.w	2
 523  001b 0001          	dc.w	1
 524  001d 0005          	dc.w	5
 525  001f 0000          	dc.w	0
 526  0021 0005          	dc.w	5
 527  0023 0001          	dc.w	1
 528  0025 0005          	dc.w	5
 529  0027 0002          	dc.w	2
 530  0029 0006          	dc.w	6
 531  002b 0000          	dc.w	0
 532  002d 0006          	dc.w	6
 533  002f 0001          	dc.w	1
 534  0031 0006          	dc.w	6
 535  0033 0002          	dc.w	2
 536  0035 0006          	dc.w	6
 537  0037 0005          	dc.w	5
 538  0039 0006          	dc.w	6
 539  003b 0004          	dc.w	4
 540  003d 0005          	dc.w	5
 541  003f 0004          	dc.w	4
 542  0041 0004          	dc.w	4
 543  0043 0003          	dc.w	3
 544  0045 0005          	dc.w	5
 545  0047 0003          	dc.w	3
 546  0049 0006          	dc.w	6
 547  004b 0003          	dc.w	3
 548  004d 0003          	dc.w	3
 549  004f 0004          	dc.w	4
 550  0051 0003          	dc.w	3
 551  0053 0005          	dc.w	5
 552  0055 0003          	dc.w	3
 553  0057 0006          	dc.w	6
 554  0059 0000          	dc.w	0
 555  005b 0005          	dc.w	5
 556  005d 0000          	dc.w	0
 557  005f 0006          	dc.w	6
 558  0061 0001          	dc.w	1
 559  0063 0006          	dc.w	6
 560  0065 0000          	dc.w	0
 561  0067 0004          	dc.w	4
 562  0069 0001          	dc.w	1
 563  006b 0004          	dc.w	4
 564  006d 0002          	dc.w	2
 565  006f 0004          	dc.w	4
 566  0071 0000          	dc.w	0
 567  0073 0003          	dc.w	3
 568  0075 0001          	dc.w	1
 569  0077 0003          	dc.w	3
 570  0079 0002          	dc.w	2
 571  007b 0003          	dc.w	3
 812                     ; 108 void setRGB(int led_index,int rgb_index)
 812                     ; 109 {
 813                     	switch	.text
 814  0131               _setRGB:
 816  0131 89            	pushw	x
 817  0132 5280          	subw	sp,#128
 818       00000080      OFST:	set	128
 821                     ; 110 const unsigned short matrix_lookup[10][3][2]={
 821                     ; 111 																	  {{0,1},{0,2},{1,2}},//7
 821                     ; 112 																	  {{1,0},{2,0},{2,1}},//3
 821                     ; 113 																	  {{5,0},{5,1},{5,2}},//1
 821                     ; 114 																	  {{6,0},{6,1},{6,2}},//20
 821                     ; 115 																	  {{6,5},{6,4},{5,4}},//22
 821                     ; 116 																	  {{4,3},{5,3},{6,3}},//23
 821                     ; 117 																	  {{3,4},{3,5},{3,6}},//21
 821                     ; 118 																	  {{0,5},{0,6},{1,6}},//19
 821                     ; 119 																	  {{0,4},{1,4},{2,4}},//18
 821                     ; 120 																	  {{0,3},{1,3},{2,3}}//2
 821                     ; 121 																		};
 823  0134 96            	ldw	x,sp
 824  0135 1c0008        	addw	x,#OFST-120
 825  0138 90ae0005      	ldw	y,#L702_matrix_lookup
 826  013c a678          	ld	a,#120
 827  013e cd0000        	call	c_xymov
 829                     ; 122 bool is_low=0;
 831  0141 0f80          	clr	(OFST+0,sp)
 833  0143               L763:
 834                     ; 126 	switch(matrix_lookup[led_index][rgb_index][is_low])
 836  0143 1e85          	ldw	x,(OFST+5,sp)
 837  0145 58            	sllw	x
 838  0146 58            	sllw	x
 839  0147 1f03          	ldw	(OFST-125,sp),x
 841  0149 96            	ldw	x,sp
 842  014a 1c0008        	addw	x,#OFST-120
 843  014d 1f01          	ldw	(OFST-127,sp),x
 845  014f 1e81          	ldw	x,(OFST+1,sp)
 846  0151 a60c          	ld	a,#12
 847  0153 cd0000        	call	c_bmulx
 849  0156 72fb01        	addw	x,(OFST-127,sp)
 850  0159 72fb03        	addw	x,(OFST-125,sp)
 851  015c 7b80          	ld	a,(OFST+0,sp)
 852  015e 905f          	clrw	y
 853  0160 9097          	ld	yl,a
 854  0162 9058          	sllw	y
 855  0164 90bf00        	ldw	c_x,y
 856  0167 92de00        	ldw	x,([c_x.w],x)
 858                     ; 158 		}break;
 859  016a 5d            	tnzw	x
 860  016b 2714          	jreq	L112
 861  016d 5a            	decw	x
 862  016e 271c          	jreq	L312
 863  0170 5a            	decw	x
 864  0171 2724          	jreq	L512
 865  0173 5a            	decw	x
 866  0174 272c          	jreq	L712
 867  0176 5a            	decw	x
 868  0177 2734          	jreq	L122
 869  0179 5a            	decw	x
 870  017a 273c          	jreq	L322
 871  017c 5a            	decw	x
 872  017d 2744          	jreq	L522
 873  017f 204b          	jra	L773
 874  0181               L112:
 875                     ; 129 			GPIOx=GPIOD;
 877  0181 ae500f        	ldw	x,#20495
 878  0184 1f05          	ldw	(OFST-123,sp),x
 880                     ; 130 			PortPin=GPIO_PIN_3;
 882  0186 a608          	ld	a,#8
 883  0188 6b07          	ld	(OFST-121,sp),a
 885                     ; 131 		}break;
 887  018a 2040          	jra	L773
 888  018c               L312:
 889                     ; 133 			GPIOx=GPIOD;
 891  018c ae500f        	ldw	x,#20495
 892  018f 1f05          	ldw	(OFST-123,sp),x
 894                     ; 134 			PortPin=GPIO_PIN_2;
 896  0191 a604          	ld	a,#4
 897  0193 6b07          	ld	(OFST-121,sp),a
 899                     ; 135 		}break;
 901  0195 2035          	jra	L773
 902  0197               L512:
 903                     ; 137 			GPIOx=GPIOC;
 905  0197 ae500a        	ldw	x,#20490
 906  019a 1f05          	ldw	(OFST-123,sp),x
 908                     ; 138 			PortPin=GPIO_PIN_7;
 910  019c a680          	ld	a,#128
 911  019e 6b07          	ld	(OFST-121,sp),a
 913                     ; 139 		}break;
 915  01a0 202a          	jra	L773
 916  01a2               L712:
 917                     ; 141 			GPIOx=GPIOC;
 919  01a2 ae500a        	ldw	x,#20490
 920  01a5 1f05          	ldw	(OFST-123,sp),x
 922                     ; 142 			PortPin=GPIO_PIN_6;
 924  01a7 a640          	ld	a,#64
 925  01a9 6b07          	ld	(OFST-121,sp),a
 927                     ; 143 		}break;
 929  01ab 201f          	jra	L773
 930  01ad               L122:
 931                     ; 145 			GPIOx=GPIOC;
 933  01ad ae500a        	ldw	x,#20490
 934  01b0 1f05          	ldw	(OFST-123,sp),x
 936                     ; 146 			PortPin=GPIO_PIN_5;
 938  01b2 a620          	ld	a,#32
 939  01b4 6b07          	ld	(OFST-121,sp),a
 941                     ; 147 		}break;
 943  01b6 2014          	jra	L773
 944  01b8               L322:
 945                     ; 149 			GPIOx=GPIOC;
 947  01b8 ae500a        	ldw	x,#20490
 948  01bb 1f05          	ldw	(OFST-123,sp),x
 950                     ; 150 			PortPin=GPIO_PIN_4;
 952  01bd a610          	ld	a,#16
 953  01bf 6b07          	ld	(OFST-121,sp),a
 955                     ; 151 		}break;
 957  01c1 2009          	jra	L773
 958  01c3               L522:
 959                     ; 153 			GPIOx=GPIOC;
 961  01c3 ae500a        	ldw	x,#20490
 962  01c6 1f05          	ldw	(OFST-123,sp),x
 964                     ; 154 			PortPin=GPIO_PIN_3;
 966  01c8 a608          	ld	a,#8
 967  01ca 6b07          	ld	(OFST-121,sp),a
 969                     ; 155 		}break;
 971  01cc               L773:
 972                     ; 160   GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
 974  01cc 0d80          	tnz	(OFST+0,sp)
 975  01ce 2704          	jreq	L02
 976  01d0 a6c0          	ld	a,#192
 977  01d2 2002          	jra	L22
 978  01d4               L02:
 979  01d4 a6d0          	ld	a,#208
 980  01d6               L22:
 981  01d6 88            	push	a
 982  01d7 7b08          	ld	a,(OFST-120,sp)
 983  01d9 88            	push	a
 984  01da 1e07          	ldw	x,(OFST-121,sp)
 985  01dc cd0000        	call	_GPIO_Init
 987  01df 85            	popw	x
 988                     ; 161 	is_low=!is_low;
 990  01e0 0d80          	tnz	(OFST+0,sp)
 991  01e2 2604          	jrne	L42
 992  01e4 a601          	ld	a,#1
 993  01e6 2001          	jra	L62
 994  01e8               L42:
 995  01e8 4f            	clr	a
 996  01e9               L62:
 997  01e9 6b80          	ld	(OFST+0,sp),a
 999                     ; 162 }while(is_low);
1001  01eb 0d80          	tnz	(OFST+0,sp)
1002  01ed 2703          	jreq	L03
1003  01ef cc0143        	jp	L763
1004  01f2               L03:
1005                     ; 163 }
1008  01f2 5b82          	addw	sp,#130
1009  01f4 81            	ret
1043                     ; 165 void setWhite(int led_index,bool is_high)
1043                     ; 166 {
1044                     	switch	.text
1045  01f5               _setWhite:
1049                     ; 168 }
1052  01f5 81            	ret
1076                     	xdef	_setWhite
1077                     	xdef	_main
1078                     	xdef	_debug
1079                     	xdef	_Serial_newline
1080                     	xdef	_Serial_print_int
1081                     	xdef	_setRGB
1082                     	xdef	_setMatrixHighZ
1083                     	xref	_UART1_GetFlagStatus
1084                     	xref	_UART1_SendData8
1085                     	xref	_UART1_Cmd
1086                     	xref	_UART1_Init
1087                     	xref	_UART1_DeInit
1088                     	xref	_GPIO_Init
1089                     	xref.b	c_x
1090                     	xref.b	c_y
1109                     	xref	c_bmulx
1110                     	xref	c_sdivx
1111                     	xref	c_smody
1112                     	xref	c_smodx
1113                     	xref	c_xymov
1114                     	end
