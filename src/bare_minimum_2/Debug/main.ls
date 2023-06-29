   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  73                     ; 10 int main()
  73                     ; 11 {
  75                     	switch	.text
  76  0000               _main:
  78  0000 5206          	subw	sp,#6
  79       00000006      OFST:	set	6
  82  0002               L73:
  83                     ; 37 		for(rgb_index=0;rgb_index<3;rgb_index++)
  85  0002 5f            	clrw	x
  86  0003 1f01          	ldw	(OFST-5,sp),x
  88  0005               L34:
  89                     ; 39 			for(led_index=0;led_index<10;led_index++)
  91  0005 5f            	clrw	x
  92  0006 1f05          	ldw	(OFST-1,sp),x
  94  0008               L15:
  95                     ; 41 				setMatrixHighZ();
  97  0008 ad37          	call	_setMatrixHighZ
  99                     ; 42 				setRGB(led_index,rgb_index);
 101  000a 1e01          	ldw	x,(OFST-5,sp)
 102  000c 89            	pushw	x
 103  000d 1e07          	ldw	x,(OFST+1,sp)
 104  000f ad47          	call	_setRGB
 106  0011 85            	popw	x
 107                     ; 43 				for(iter=0;iter<30000;iter++){}
 109  0012 5f            	clrw	x
 110  0013 1f03          	ldw	(OFST-3,sp),x
 112  0015               L75:
 115  0015 1e03          	ldw	x,(OFST-3,sp)
 116  0017 1c0001        	addw	x,#1
 117  001a 1f03          	ldw	(OFST-3,sp),x
 121  001c 1e03          	ldw	x,(OFST-3,sp)
 122  001e a37530        	cpw	x,#30000
 123  0021 25f2          	jrult	L75
 124                     ; 39 			for(led_index=0;led_index<10;led_index++)
 126  0023 1e05          	ldw	x,(OFST-1,sp)
 127  0025 1c0001        	addw	x,#1
 128  0028 1f05          	ldw	(OFST-1,sp),x
 132  002a 1e05          	ldw	x,(OFST-1,sp)
 133  002c a3000a        	cpw	x,#10
 134  002f 25d7          	jrult	L15
 135                     ; 37 		for(rgb_index=0;rgb_index<3;rgb_index++)
 137  0031 1e01          	ldw	x,(OFST-5,sp)
 138  0033 1c0001        	addw	x,#1
 139  0036 1f01          	ldw	(OFST-5,sp),x
 143  0038 1e01          	ldw	x,(OFST-5,sp)
 144  003a a30003        	cpw	x,#3
 145  003d 25c6          	jrult	L34
 147  003f 20c1          	jra	L73
 171                     ; 49 void setMatrixHighZ()
 171                     ; 50 {
 172                     	switch	.text
 173  0041               _setMatrixHighZ:
 177                     ; 51 	GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
 179  0041 4b00          	push	#0
 180  0043 4bf8          	push	#248
 181  0045 ae500a        	ldw	x,#20490
 182  0048 cd0000        	call	_GPIO_Init
 184  004b 85            	popw	x
 185                     ; 52 	GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//0, 1
 187  004c 4b00          	push	#0
 188  004e 4b0c          	push	#12
 189  0050 ae500f        	ldw	x,#20495
 190  0053 cd0000        	call	_GPIO_Init
 192  0056 85            	popw	x
 193                     ; 53 }
 196  0057 81            	ret
 199                     .const:	section	.text
 200  0000               L57_matrix_lookup:
 201  0000 0000          	dc.w	0
 202  0002 0001          	dc.w	1
 203  0004 0000          	dc.w	0
 204  0006 0002          	dc.w	2
 205  0008 0001          	dc.w	1
 206  000a 0002          	dc.w	2
 207  000c 0001          	dc.w	1
 208  000e 0000          	dc.w	0
 209  0010 0002          	dc.w	2
 210  0012 0000          	dc.w	0
 211  0014 0002          	dc.w	2
 212  0016 0001          	dc.w	1
 213  0018 0005          	dc.w	5
 214  001a 0000          	dc.w	0
 215  001c 0005          	dc.w	5
 216  001e 0001          	dc.w	1
 217  0020 0005          	dc.w	5
 218  0022 0002          	dc.w	2
 219  0024 0006          	dc.w	6
 220  0026 0000          	dc.w	0
 221  0028 0006          	dc.w	6
 222  002a 0001          	dc.w	1
 223  002c 0006          	dc.w	6
 224  002e 0002          	dc.w	2
 225  0030 0006          	dc.w	6
 226  0032 0005          	dc.w	5
 227  0034 0006          	dc.w	6
 228  0036 0004          	dc.w	4
 229  0038 0005          	dc.w	5
 230  003a 0004          	dc.w	4
 231  003c 0004          	dc.w	4
 232  003e 0003          	dc.w	3
 233  0040 0005          	dc.w	5
 234  0042 0003          	dc.w	3
 235  0044 0006          	dc.w	6
 236  0046 0003          	dc.w	3
 237  0048 0003          	dc.w	3
 238  004a 0004          	dc.w	4
 239  004c 0003          	dc.w	3
 240  004e 0005          	dc.w	5
 241  0050 0003          	dc.w	3
 242  0052 0006          	dc.w	6
 243  0054 0000          	dc.w	0
 244  0056 0005          	dc.w	5
 245  0058 0000          	dc.w	0
 246  005a 0006          	dc.w	6
 247  005c 0001          	dc.w	1
 248  005e 0006          	dc.w	6
 249  0060 0000          	dc.w	0
 250  0062 0004          	dc.w	4
 251  0064 0001          	dc.w	1
 252  0066 0004          	dc.w	4
 253  0068 0002          	dc.w	2
 254  006a 0004          	dc.w	4
 255  006c 0000          	dc.w	0
 256  006e 0003          	dc.w	3
 257  0070 0001          	dc.w	1
 258  0072 0003          	dc.w	3
 259  0074 0002          	dc.w	2
 260  0076 0003          	dc.w	3
 501                     ; 55 void setRGB(int led_index,int rgb_index)
 501                     ; 56 {
 502                     	switch	.text
 503  0058               _setRGB:
 505  0058 89            	pushw	x
 506  0059 5280          	subw	sp,#128
 507       00000080      OFST:	set	128
 510                     ; 57 const unsigned short matrix_lookup[10][3][2]={
 510                     ; 58 																	  {{0,1},{0,2},{1,2}},//7
 510                     ; 59 																	  {{1,0},{2,0},{2,1}},//3
 510                     ; 60 																	  {{5,0},{5,1},{5,2}},//1
 510                     ; 61 																	  {{6,0},{6,1},{6,2}},//20
 510                     ; 62 																	  {{6,5},{6,4},{5,4}},//22
 510                     ; 63 																	  {{4,3},{5,3},{6,3}},//23
 510                     ; 64 																	  {{3,4},{3,5},{3,6}},//21
 510                     ; 65 																	  {{0,5},{0,6},{1,6}},//19
 510                     ; 66 																	  {{0,4},{1,4},{2,4}},//18
 510                     ; 67 																	  {{0,3},{1,3},{2,3}}//2
 510                     ; 68 																		};
 512  005b 96            	ldw	x,sp
 513  005c 1c0008        	addw	x,#OFST-120
 514  005f 90ae0000      	ldw	y,#L57_matrix_lookup
 515  0063 a678          	ld	a,#120
 516  0065 cd0000        	call	c_xymov
 518                     ; 69 bool is_low=0;
 520  0068 0f80          	clr	(OFST+0,sp)
 522  006a               L552:
 523                     ; 73 	switch(matrix_lookup[led_index][rgb_index][is_low])
 525  006a 1e85          	ldw	x,(OFST+5,sp)
 526  006c 58            	sllw	x
 527  006d 58            	sllw	x
 528  006e 1f03          	ldw	(OFST-125,sp),x
 530  0070 96            	ldw	x,sp
 531  0071 1c0008        	addw	x,#OFST-120
 532  0074 1f01          	ldw	(OFST-127,sp),x
 534  0076 1e81          	ldw	x,(OFST+1,sp)
 535  0078 a60c          	ld	a,#12
 536  007a cd0000        	call	c_bmulx
 538  007d 72fb01        	addw	x,(OFST-127,sp)
 539  0080 72fb03        	addw	x,(OFST-125,sp)
 540  0083 7b80          	ld	a,(OFST+0,sp)
 541  0085 905f          	clrw	y
 542  0087 9097          	ld	yl,a
 543  0089 9058          	sllw	y
 544  008b 90bf00        	ldw	c_x,y
 545  008e 92de00        	ldw	x,([c_x.w],x)
 547                     ; 105 		}break;
 548  0091 5d            	tnzw	x
 549  0092 2714          	jreq	L77
 550  0094 5a            	decw	x
 551  0095 271c          	jreq	L101
 552  0097 5a            	decw	x
 553  0098 2724          	jreq	L301
 554  009a 5a            	decw	x
 555  009b 272c          	jreq	L501
 556  009d 5a            	decw	x
 557  009e 2734          	jreq	L701
 558  00a0 5a            	decw	x
 559  00a1 273c          	jreq	L111
 560  00a3 5a            	decw	x
 561  00a4 2744          	jreq	L311
 562  00a6 204b          	jra	L562
 563  00a8               L77:
 564                     ; 76 			GPIOx=GPIOD;
 566  00a8 ae500f        	ldw	x,#20495
 567  00ab 1f05          	ldw	(OFST-123,sp),x
 569                     ; 77 			PortPin=GPIO_PIN_3;
 571  00ad a608          	ld	a,#8
 572  00af 6b07          	ld	(OFST-121,sp),a
 574                     ; 78 		}break;
 576  00b1 2040          	jra	L562
 577  00b3               L101:
 578                     ; 80 			GPIOx=GPIOD;
 580  00b3 ae500f        	ldw	x,#20495
 581  00b6 1f05          	ldw	(OFST-123,sp),x
 583                     ; 81 			PortPin=GPIO_PIN_2;
 585  00b8 a604          	ld	a,#4
 586  00ba 6b07          	ld	(OFST-121,sp),a
 588                     ; 82 		}break;
 590  00bc 2035          	jra	L562
 591  00be               L301:
 592                     ; 84 			GPIOx=GPIOC;
 594  00be ae500a        	ldw	x,#20490
 595  00c1 1f05          	ldw	(OFST-123,sp),x
 597                     ; 85 			PortPin=GPIO_PIN_7;
 599  00c3 a680          	ld	a,#128
 600  00c5 6b07          	ld	(OFST-121,sp),a
 602                     ; 86 		}break;
 604  00c7 202a          	jra	L562
 605  00c9               L501:
 606                     ; 88 			GPIOx=GPIOC;
 608  00c9 ae500a        	ldw	x,#20490
 609  00cc 1f05          	ldw	(OFST-123,sp),x
 611                     ; 89 			PortPin=GPIO_PIN_6;
 613  00ce a640          	ld	a,#64
 614  00d0 6b07          	ld	(OFST-121,sp),a
 616                     ; 90 		}break;
 618  00d2 201f          	jra	L562
 619  00d4               L701:
 620                     ; 92 			GPIOx=GPIOC;
 622  00d4 ae500a        	ldw	x,#20490
 623  00d7 1f05          	ldw	(OFST-123,sp),x
 625                     ; 93 			PortPin=GPIO_PIN_5;
 627  00d9 a620          	ld	a,#32
 628  00db 6b07          	ld	(OFST-121,sp),a
 630                     ; 94 		}break;
 632  00dd 2014          	jra	L562
 633  00df               L111:
 634                     ; 96 			GPIOx=GPIOC;
 636  00df ae500a        	ldw	x,#20490
 637  00e2 1f05          	ldw	(OFST-123,sp),x
 639                     ; 97 			PortPin=GPIO_PIN_4;
 641  00e4 a610          	ld	a,#16
 642  00e6 6b07          	ld	(OFST-121,sp),a
 644                     ; 98 		}break;
 646  00e8 2009          	jra	L562
 647  00ea               L311:
 648                     ; 100 			GPIOx=GPIOC;
 650  00ea ae500a        	ldw	x,#20490
 651  00ed 1f05          	ldw	(OFST-123,sp),x
 653                     ; 101 			PortPin=GPIO_PIN_3;
 655  00ef a608          	ld	a,#8
 656  00f1 6b07          	ld	(OFST-121,sp),a
 658                     ; 102 		}break;
 660  00f3               L562:
 661                     ; 107   GPIO_Init(GPIOx, PortPin, is_low?GPIO_MODE_OUT_PP_LOW_SLOW:GPIO_MODE_OUT_PP_HIGH_SLOW);
 663  00f3 0d80          	tnz	(OFST+0,sp)
 664  00f5 2704          	jreq	L21
 665  00f7 a6c0          	ld	a,#192
 666  00f9 2002          	jra	L41
 667  00fb               L21:
 668  00fb a6d0          	ld	a,#208
 669  00fd               L41:
 670  00fd 88            	push	a
 671  00fe 7b08          	ld	a,(OFST-120,sp)
 672  0100 88            	push	a
 673  0101 1e07          	ldw	x,(OFST-121,sp)
 674  0103 cd0000        	call	_GPIO_Init
 676  0106 85            	popw	x
 677                     ; 108 	is_low=!is_low;
 679  0107 0d80          	tnz	(OFST+0,sp)
 680  0109 2604          	jrne	L61
 681  010b a601          	ld	a,#1
 682  010d 2001          	jra	L02
 683  010f               L61:
 684  010f 4f            	clr	a
 685  0110               L02:
 686  0110 6b80          	ld	(OFST+0,sp),a
 688                     ; 109 }while(is_low);
 690  0112 0d80          	tnz	(OFST+0,sp)
 691  0114 2703          	jreq	L22
 692  0116 cc006a        	jp	L552
 693  0119               L22:
 694                     ; 110 }
 697  0119 5b82          	addw	sp,#130
 698  011b 81            	ret
 732                     ; 112 void setWhite(int led_index,bool is_high)
 732                     ; 113 {
 733                     	switch	.text
 734  011c               _setWhite:
 738                     ; 115 }
 741  011c 81            	ret
 754                     	xdef	_setWhite
 755                     	xdef	_main
 756                     	xdef	_setRGB
 757                     	xdef	_setMatrixHighZ
 758                     	xref	_GPIO_Init
 759                     	xref.b	c_x
 778                     	xref	c_bmulx
 779                     	xref	c_xymov
 780                     	end
