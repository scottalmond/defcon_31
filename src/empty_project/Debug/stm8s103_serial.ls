   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  45                     ; 7  char Serial_read_char(void)
  45                     ; 8  {
  47                     	switch	.text
  48  0000               _Serial_read_char:
  52  0000               L32:
  53                     ; 9 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
  55  0000 ae0080        	ldw	x,#128
  56  0003 cd0000        	call	_UART1_GetFlagStatus
  58  0006 4d            	tnz	a
  59  0007 27f7          	jreq	L32
  60                     ; 10 	 UART1_ClearFlag(UART1_FLAG_RXNE);
  62  0009 ae0020        	ldw	x,#32
  63  000c cd0000        	call	_UART1_ClearFlag
  65                     ; 11 	 return (UART1_ReceiveData8());
  67  000f cd0000        	call	_UART1_ReceiveData8
  71  0012 81            	ret
 107                     ; 14  void Serial_print_char (char value)
 107                     ; 15  {
 108                     	switch	.text
 109  0013               _Serial_print_char:
 113                     ; 16 	 UART1_SendData8(value);
 115  0013 cd0000        	call	_UART1_SendData8
 118  0016               L74:
 119                     ; 17 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
 121  0016 ae0080        	ldw	x,#128
 122  0019 cd0000        	call	_UART1_GetFlagStatus
 124  001c 4d            	tnz	a
 125  001d 27f7          	jreq	L74
 126                     ; 18  }
 129  001f 81            	ret
 167                     ; 20   void Serial_begin(uint32_t baud_rate)
 167                     ; 21  {
 168                     	switch	.text
 169  0020               _Serial_begin:
 171       00000000      OFST:	set	0
 174                     ; 22 	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 176  0020 4bf0          	push	#240
 177  0022 4b20          	push	#32
 178  0024 ae500f        	ldw	x,#20495
 179  0027 cd0000        	call	_GPIO_Init
 181  002a 85            	popw	x
 182                     ; 23 	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 184  002b 4b40          	push	#64
 185  002d 4b40          	push	#64
 186  002f ae500f        	ldw	x,#20495
 187  0032 cd0000        	call	_GPIO_Init
 189  0035 85            	popw	x
 190                     ; 25 	 UART1_DeInit(); //Deinitialize UART peripherals 
 192  0036 cd0000        	call	_UART1_DeInit
 194                     ; 28 		UART1_Init(baud_rate, 
 194                     ; 29                 UART1_WORDLENGTH_8D, 
 194                     ; 30                 UART1_STOPBITS_1, 
 194                     ; 31                 UART1_PARITY_NO, 
 194                     ; 32                 UART1_SYNCMODE_CLOCK_DISABLE, 
 194                     ; 33                 UART1_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
 196  0039 4b0c          	push	#12
 197  003b 4b80          	push	#128
 198  003d 4b00          	push	#0
 199  003f 4b00          	push	#0
 200  0041 4b00          	push	#0
 201  0043 1e0a          	ldw	x,(OFST+10,sp)
 202  0045 89            	pushw	x
 203  0046 1e0a          	ldw	x,(OFST+10,sp)
 204  0048 89            	pushw	x
 205  0049 cd0000        	call	_UART1_Init
 207  004c 5b09          	addw	sp,#9
 208                     ; 35 		UART1_Cmd(ENABLE);
 210  004e a601          	ld	a,#1
 211  0050 cd0000        	call	_UART1_Cmd
 213                     ; 36  }
 216  0053 81            	ret
 270                     ; 38  void Serial_print_u32(u32 number)
 270                     ; 39  {
 271                     	switch	.text
 272  0054               _Serial_print_u32:
 274  0054 89            	pushw	x
 275       00000002      OFST:	set	2
 278                     ; 42 	 Serial_print_string("0x");
 280  0055 ae0005        	ldw	x,#L711
 281  0058 cd010d        	call	_Serial_print_string
 283                     ; 43 	 for(iter=28;iter<32;iter-=4)
 285  005b a61c          	ld	a,#28
 286  005d 6b02          	ld	(OFST+0,sp),a
 288  005f               L121:
 289                     ; 45 		 digit=number>>iter;
 291  005f 96            	ldw	x,sp
 292  0060 1c0005        	addw	x,#OFST+3
 293  0063 cd0000        	call	c_ltor
 295  0066 7b02          	ld	a,(OFST+0,sp)
 296  0068 cd0000        	call	c_lursh
 298  006b b603          	ld	a,c_lreg+3
 299  006d 6b01          	ld	(OFST-1,sp),a
 301                     ; 46 		 if(digit>9) Serial_print_char('A'+(digit-10));
 303  006f 7b01          	ld	a,(OFST-1,sp)
 304  0071 a10a          	cp	a,#10
 305  0073 2508          	jrult	L721
 308  0075 7b01          	ld	a,(OFST-1,sp)
 309  0077 ab37          	add	a,#55
 310  0079 ad98          	call	_Serial_print_char
 313  007b 2006          	jra	L131
 314  007d               L721:
 315                     ; 47 		 else Serial_print_char('0'+digit);
 317  007d 7b01          	ld	a,(OFST-1,sp)
 318  007f ab30          	add	a,#48
 319  0081 ad90          	call	_Serial_print_char
 321  0083               L131:
 322                     ; 48 		 if(iter==16) Serial_print_char('_');
 324  0083 7b02          	ld	a,(OFST+0,sp)
 325  0085 a110          	cp	a,#16
 326  0087 2604          	jrne	L331
 329  0089 a65f          	ld	a,#95
 330  008b ad86          	call	_Serial_print_char
 332  008d               L331:
 333                     ; 43 	 for(iter=28;iter<32;iter-=4)
 335  008d 7b02          	ld	a,(OFST+0,sp)
 336  008f a004          	sub	a,#4
 337  0091 6b02          	ld	(OFST+0,sp),a
 341  0093 7b02          	ld	a,(OFST+0,sp)
 342  0095 a120          	cp	a,#32
 343  0097 25c6          	jrult	L121
 344                     ; 50  }
 347  0099 85            	popw	x
 348  009a 81            	ret
 351                     .const:	section	.text
 352  0000               L531_digit:
 353  0000 00            	dc.b	0
 354  0001 00000000      	ds.b	4
 407                     ; 52  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 407                     ; 53  {
 408                     	switch	.text
 409  009b               _Serial_print_int:
 411  009b 89            	pushw	x
 412  009c 5208          	subw	sp,#8
 413       00000008      OFST:	set	8
 416                     ; 54 	 char count = 0;
 418  009e 0f08          	clr	(OFST+0,sp)
 420                     ; 55 	 char digit[5] = "";
 422  00a0 96            	ldw	x,sp
 423  00a1 1c0003        	addw	x,#OFST-5
 424  00a4 90ae0000      	ldw	y,#L531_digit
 425  00a8 a605          	ld	a,#5
 426  00aa cd0000        	call	c_xymov
 429  00ad 2023          	jra	L171
 430  00af               L561:
 431                     ; 59 		 digit[count] = number%10;
 433  00af 96            	ldw	x,sp
 434  00b0 1c0003        	addw	x,#OFST-5
 435  00b3 9f            	ld	a,xl
 436  00b4 5e            	swapw	x
 437  00b5 1b08          	add	a,(OFST+0,sp)
 438  00b7 2401          	jrnc	L61
 439  00b9 5c            	incw	x
 440  00ba               L61:
 441  00ba 02            	rlwa	x,a
 442  00bb 1609          	ldw	y,(OFST+1,sp)
 443  00bd a60a          	ld	a,#10
 444  00bf cd0000        	call	c_smody
 446  00c2 9001          	rrwa	y,a
 447  00c4 f7            	ld	(x),a
 448  00c5 9002          	rlwa	y,a
 449                     ; 60 		 count++;
 451  00c7 0c08          	inc	(OFST+0,sp)
 453                     ; 61 		 number = number/10;
 455  00c9 1e09          	ldw	x,(OFST+1,sp)
 456  00cb a60a          	ld	a,#10
 457  00cd cd0000        	call	c_sdivx
 459  00d0 1f09          	ldw	(OFST+1,sp),x
 460  00d2               L171:
 461                     ; 57 	 while (number != 0) //split the int to char array 
 463  00d2 1e09          	ldw	x,(OFST+1,sp)
 464  00d4 26d9          	jrne	L561
 466  00d6 201f          	jra	L771
 467  00d8               L571:
 468                     ; 66 		UART1_SendData8(digit[count-1] + 0x30);
 470  00d8 96            	ldw	x,sp
 471  00d9 1c0003        	addw	x,#OFST-5
 472  00dc 1f01          	ldw	(OFST-7,sp),x
 474  00de 7b08          	ld	a,(OFST+0,sp)
 475  00e0 5f            	clrw	x
 476  00e1 97            	ld	xl,a
 477  00e2 5a            	decw	x
 478  00e3 72fb01        	addw	x,(OFST-7,sp)
 479  00e6 f6            	ld	a,(x)
 480  00e7 ab30          	add	a,#48
 481  00e9 cd0000        	call	_UART1_SendData8
 484  00ec               L502:
 485                     ; 67 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 487  00ec ae0080        	ldw	x,#128
 488  00ef cd0000        	call	_UART1_GetFlagStatus
 490  00f2 4d            	tnz	a
 491  00f3 27f7          	jreq	L502
 492                     ; 68 		count--; 
 494  00f5 0a08          	dec	(OFST+0,sp)
 496  00f7               L771:
 497                     ; 64 	 while (count !=0) //print char array in correct direction 
 499  00f7 0d08          	tnz	(OFST+0,sp)
 500  00f9 26dd          	jrne	L571
 501                     ; 70  }
 504  00fb 5b0a          	addw	sp,#10
 505  00fd 81            	ret
 530                     ; 72  void Serial_newline(void)
 530                     ; 73  {
 531                     	switch	.text
 532  00fe               _Serial_newline:
 536                     ; 74 	 UART1_SendData8(0x0a);
 538  00fe a60a          	ld	a,#10
 539  0100 cd0000        	call	_UART1_SendData8
 542  0103               L322:
 543                     ; 75 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 545  0103 ae0080        	ldw	x,#128
 546  0106 cd0000        	call	_UART1_GetFlagStatus
 548  0109 4d            	tnz	a
 549  010a 27f7          	jreq	L322
 550                     ; 76  }
 553  010c 81            	ret
 600                     ; 78  void Serial_print_string (char string[])
 600                     ; 79  {
 601                     	switch	.text
 602  010d               _Serial_print_string:
 604  010d 89            	pushw	x
 605  010e 88            	push	a
 606       00000001      OFST:	set	1
 609                     ; 81 	 char i=0;
 611  010f 0f01          	clr	(OFST+0,sp)
 614  0111 2016          	jra	L552
 615  0113               L152:
 616                     ; 85 		UART1_SendData8(string[i]);
 618  0113 7b01          	ld	a,(OFST+0,sp)
 619  0115 5f            	clrw	x
 620  0116 97            	ld	xl,a
 621  0117 72fb02        	addw	x,(OFST+1,sp)
 622  011a f6            	ld	a,(x)
 623  011b cd0000        	call	_UART1_SendData8
 626  011e               L362:
 627                     ; 86 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 629  011e ae0080        	ldw	x,#128
 630  0121 cd0000        	call	_UART1_GetFlagStatus
 632  0124 4d            	tnz	a
 633  0125 27f7          	jreq	L362
 634                     ; 87 		i++;
 636  0127 0c01          	inc	(OFST+0,sp)
 638  0129               L552:
 639                     ; 83 	 while (string[i] != 0x00)
 641  0129 7b01          	ld	a,(OFST+0,sp)
 642  012b 5f            	clrw	x
 643  012c 97            	ld	xl,a
 644  012d 72fb02        	addw	x,(OFST+1,sp)
 645  0130 7d            	tnz	(x)
 646  0131 26e0          	jrne	L152
 647                     ; 89  }
 650  0133 5b03          	addw	sp,#3
 651  0135 81            	ret
 696                     ; 91  bool Serial_available()
 696                     ; 92  {
 697                     	switch	.text
 698  0136               _Serial_available:
 702                     ; 93 	 if(UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
 704  0136 ae0020        	ldw	x,#32
 705  0139 cd0000        	call	_UART1_GetFlagStatus
 707  013c a101          	cp	a,#1
 708  013e 2603          	jrne	L703
 709                     ; 94 	 return TRUE;
 711  0140 a601          	ld	a,#1
 714  0142 81            	ret
 715  0143               L703:
 716                     ; 96 	 return FALSE;
 718  0143 4f            	clr	a
 721  0144 81            	ret
 734                     	xref	_GPIO_Init
 735                     	xref	_UART1_ClearFlag
 736                     	xref	_UART1_GetFlagStatus
 737                     	xref	_UART1_SendData8
 738                     	xref	_UART1_ReceiveData8
 739                     	xref	_UART1_Cmd
 740                     	xref	_UART1_Init
 741                     	xref	_UART1_DeInit
 742                     	xdef	_Serial_print_u32
 743                     	xdef	_Serial_read_char
 744                     	xdef	_Serial_available
 745                     	xdef	_Serial_newline
 746                     	xdef	_Serial_print_string
 747                     	xdef	_Serial_print_char
 748                     	xdef	_Serial_print_int
 749                     	xdef	_Serial_begin
 750                     	switch	.const
 751  0005               L711:
 752  0005 307800        	dc.b	"0x",0
 753                     	xref.b	c_lreg
 754                     	xref.b	c_x
 755                     	xref.b	c_y
 775                     	xref	c_sdivx
 776                     	xref	c_smody
 777                     	xref	c_smodx
 778                     	xref	c_xymov
 779                     	xref	c_lursh
 780                     	xref	c_ltor
 781                     	end
