   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  45                     ; 25  char Serial_read_char(void)
  45                     ; 26  {
  47                     	switch	.text
  48  0000               _Serial_read_char:
  52  0000               L32:
  53                     ; 27 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
  55  0000 ae0080        	ldw	x,#128
  56  0003 cd0000        	call	_UART1_GetFlagStatus
  58  0006 4d            	tnz	a
  59  0007 27f7          	jreq	L32
  60                     ; 28 	 UART1_ClearFlag(UART1_FLAG_RXNE);
  62  0009 ae0020        	ldw	x,#32
  63  000c cd0000        	call	_UART1_ClearFlag
  65                     ; 29 	 return (UART1_ReceiveData8());
  67  000f cd0000        	call	_UART1_ReceiveData8
  71  0012 81            	ret
 107                     ; 32  void Serial_print_char (char value)
 107                     ; 33  {
 108                     	switch	.text
 109  0013               _Serial_print_char:
 113                     ; 34 	 UART1_SendData8(value);
 115  0013 cd0000        	call	_UART1_SendData8
 118  0016               L74:
 119                     ; 35 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
 121  0016 ae0080        	ldw	x,#128
 122  0019 cd0000        	call	_UART1_GetFlagStatus
 124  001c 4d            	tnz	a
 125  001d 27f7          	jreq	L74
 126                     ; 36  }
 129  001f 81            	ret
 167                     ; 38   void Serial_begin(uint32_t baud_rate)
 167                     ; 39  {
 168                     	switch	.text
 169  0020               _Serial_begin:
 171       00000000      OFST:	set	0
 174                     ; 40 	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 176  0020 4bf0          	push	#240
 177  0022 4b20          	push	#32
 178  0024 ae500f        	ldw	x,#20495
 179  0027 cd0000        	call	_GPIO_Init
 181  002a 85            	popw	x
 182                     ; 41 	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 184  002b 4b40          	push	#64
 185  002d 4b40          	push	#64
 186  002f ae500f        	ldw	x,#20495
 187  0032 cd0000        	call	_GPIO_Init
 189  0035 85            	popw	x
 190                     ; 43 	 UART1_DeInit(); //Deinitialize UART peripherals 
 192  0036 cd0000        	call	_UART1_DeInit
 194                     ; 46 		UART1_Init(baud_rate, 
 194                     ; 47                 UART1_WORDLENGTH_8D, 
 194                     ; 48                 UART1_STOPBITS_1, 
 194                     ; 49                 UART1_PARITY_NO, 
 194                     ; 50                 UART1_SYNCMODE_CLOCK_DISABLE, 
 194                     ; 51                 UART1_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
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
 208                     ; 53 		UART1_Cmd(ENABLE);
 210  004e a601          	ld	a,#1
 211  0050 cd0000        	call	_UART1_Cmd
 213                     ; 54  }
 216  0053 81            	ret
 219                     .const:	section	.text
 220  0000               L17_digit:
 221  0000 00            	dc.b	0
 222  0001 00000000      	ds.b	4
 275                     ; 56  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 275                     ; 57  {
 276                     	switch	.text
 277  0054               _Serial_print_int:
 279  0054 89            	pushw	x
 280  0055 5208          	subw	sp,#8
 281       00000008      OFST:	set	8
 284                     ; 58 	 char count = 0;
 286  0057 0f08          	clr	(OFST+0,sp)
 288                     ; 59 	 char digit[5] = "";
 290  0059 96            	ldw	x,sp
 291  005a 1c0003        	addw	x,#OFST-5
 292  005d 90ae0000      	ldw	y,#L17_digit
 293  0061 a605          	ld	a,#5
 294  0063 cd0000        	call	c_xymov
 297  0066 2023          	jra	L521
 298  0068               L121:
 299                     ; 63 		 digit[count] = number%10;
 301  0068 96            	ldw	x,sp
 302  0069 1c0003        	addw	x,#OFST-5
 303  006c 9f            	ld	a,xl
 304  006d 5e            	swapw	x
 305  006e 1b08          	add	a,(OFST+0,sp)
 306  0070 2401          	jrnc	L41
 307  0072 5c            	incw	x
 308  0073               L41:
 309  0073 02            	rlwa	x,a
 310  0074 1609          	ldw	y,(OFST+1,sp)
 311  0076 a60a          	ld	a,#10
 312  0078 cd0000        	call	c_smody
 314  007b 9001          	rrwa	y,a
 315  007d f7            	ld	(x),a
 316  007e 9002          	rlwa	y,a
 317                     ; 64 		 count++;
 319  0080 0c08          	inc	(OFST+0,sp)
 321                     ; 65 		 number = number/10;
 323  0082 1e09          	ldw	x,(OFST+1,sp)
 324  0084 a60a          	ld	a,#10
 325  0086 cd0000        	call	c_sdivx
 327  0089 1f09          	ldw	(OFST+1,sp),x
 328  008b               L521:
 329                     ; 61 	 while (number != 0) //split the int to char array 
 331  008b 1e09          	ldw	x,(OFST+1,sp)
 332  008d 26d9          	jrne	L121
 334  008f 201f          	jra	L331
 335  0091               L131:
 336                     ; 70 		UART1_SendData8(digit[count-1] + 0x30);
 338  0091 96            	ldw	x,sp
 339  0092 1c0003        	addw	x,#OFST-5
 340  0095 1f01          	ldw	(OFST-7,sp),x
 342  0097 7b08          	ld	a,(OFST+0,sp)
 343  0099 5f            	clrw	x
 344  009a 97            	ld	xl,a
 345  009b 5a            	decw	x
 346  009c 72fb01        	addw	x,(OFST-7,sp)
 347  009f f6            	ld	a,(x)
 348  00a0 ab30          	add	a,#48
 349  00a2 cd0000        	call	_UART1_SendData8
 352  00a5               L141:
 353                     ; 71 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 355  00a5 ae0080        	ldw	x,#128
 356  00a8 cd0000        	call	_UART1_GetFlagStatus
 358  00ab 4d            	tnz	a
 359  00ac 27f7          	jreq	L141
 360                     ; 72 		count--; 
 362  00ae 0a08          	dec	(OFST+0,sp)
 364  00b0               L331:
 365                     ; 68 	 while (count !=0) //print char array in correct direction 
 367  00b0 0d08          	tnz	(OFST+0,sp)
 368  00b2 26dd          	jrne	L131
 369                     ; 74  }
 372  00b4 5b0a          	addw	sp,#10
 373  00b6 81            	ret
 398                     ; 76  void Serial_newline(void)
 398                     ; 77  {
 399                     	switch	.text
 400  00b7               _Serial_newline:
 404                     ; 78 	 UART1_SendData8(0x0a);
 406  00b7 a60a          	ld	a,#10
 407  00b9 cd0000        	call	_UART1_SendData8
 410  00bc               L751:
 411                     ; 79 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 413  00bc ae0080        	ldw	x,#128
 414  00bf cd0000        	call	_UART1_GetFlagStatus
 416  00c2 4d            	tnz	a
 417  00c3 27f7          	jreq	L751
 418                     ; 80  }
 421  00c5 81            	ret
 468                     ; 82  void Serial_print_string (char string[])
 468                     ; 83  {
 469                     	switch	.text
 470  00c6               _Serial_print_string:
 472  00c6 89            	pushw	x
 473  00c7 88            	push	a
 474       00000001      OFST:	set	1
 477                     ; 85 	 char i=0;
 479  00c8 0f01          	clr	(OFST+0,sp)
 482  00ca 2016          	jra	L112
 483  00cc               L502:
 484                     ; 89 		UART1_SendData8(string[i]);
 486  00cc 7b01          	ld	a,(OFST+0,sp)
 487  00ce 5f            	clrw	x
 488  00cf 97            	ld	xl,a
 489  00d0 72fb02        	addw	x,(OFST+1,sp)
 490  00d3 f6            	ld	a,(x)
 491  00d4 cd0000        	call	_UART1_SendData8
 494  00d7               L712:
 495                     ; 90 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 497  00d7 ae0080        	ldw	x,#128
 498  00da cd0000        	call	_UART1_GetFlagStatus
 500  00dd 4d            	tnz	a
 501  00de 27f7          	jreq	L712
 502                     ; 91 		i++;
 504  00e0 0c01          	inc	(OFST+0,sp)
 506  00e2               L112:
 507                     ; 87 	 while (string[i] != 0x00)
 509  00e2 7b01          	ld	a,(OFST+0,sp)
 510  00e4 5f            	clrw	x
 511  00e5 97            	ld	xl,a
 512  00e6 72fb02        	addw	x,(OFST+1,sp)
 513  00e9 7d            	tnz	(x)
 514  00ea 26e0          	jrne	L502
 515                     ; 93  }
 518  00ec 5b03          	addw	sp,#3
 519  00ee 81            	ret
 564                     ; 95  bool Serial_available()
 564                     ; 96  {
 565                     	switch	.text
 566  00ef               _Serial_available:
 570                     ; 97 	 if(UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
 572  00ef ae0020        	ldw	x,#32
 573  00f2 cd0000        	call	_UART1_GetFlagStatus
 575  00f5 a101          	cp	a,#1
 576  00f7 2603          	jrne	L342
 577                     ; 98 	 return TRUE;
 579  00f9 a601          	ld	a,#1
 582  00fb 81            	ret
 583  00fc               L342:
 584                     ; 100 	 return FALSE;
 586  00fc 4f            	clr	a
 589  00fd 81            	ret
 646                     	switch	.const
 647  0005               L62:
 648  0005 000003e8      	dc.l	1000
 649                     ; 7 void run_developer()
 649                     ; 8 {
 650                     	switch	.text
 651  00fe               _run_developer:
 653  00fe 5204          	subw	sp,#4
 654       00000004      OFST:	set	4
 657                     ; 9 	u32 old_sec=999;
 659  0100 ae03e7        	ldw	x,#999
 660  0103 1f03          	ldw	(OFST-1,sp),x
 661  0105 ae0000        	ldw	x,#0
 662  0108 1f01          	ldw	(OFST-3,sp),x
 664                     ; 10 	serial_setup(1,1000000);
 666  010a ae4240        	ldw	x,#16960
 667  010d 89            	pushw	x
 668  010e ae000f        	ldw	x,#15
 669  0111 89            	pushw	x
 670  0112 a601          	ld	a,#1
 671  0114 cd0000        	call	_serial_setup
 673  0117 5b04          	addw	sp,#4
 674                     ; 11 	Serial_print_string("START");
 676  0119 ae0014        	ldw	x,#L372
 677  011c ada8          	call	_Serial_print_string
 679                     ; 12 	Serial_newline();
 681  011e ad97          	call	_Serial_newline
 684  0120 2039          	jra	L772
 685  0122               L572:
 686                     ; 16 		if(old_sec!=(millis()/1000))
 688  0122 cd0000        	call	_millis
 690  0125 ae0005        	ldw	x,#L62
 691  0128 cd0000        	call	c_ludv
 693  012b 96            	ldw	x,sp
 694  012c 1c0001        	addw	x,#OFST-3
 695  012f cd0000        	call	c_lcmp
 697  0132 2727          	jreq	L772
 698                     ; 18 			old_sec=millis()/1000;
 700  0134 cd0000        	call	_millis
 702  0137 ae0005        	ldw	x,#L62
 703  013a cd0000        	call	c_ludv
 705  013d 96            	ldw	x,sp
 706  013e 1c0001        	addw	x,#OFST-3
 707  0141 cd0000        	call	c_rtol
 710                     ; 19 			Serial_print_string("sec: ");
 712  0144 ae000e        	ldw	x,#L503
 713  0147 cd00c6        	call	_Serial_print_string
 715                     ; 20 			Serial_print_int(millis()/1000);
 717  014a cd0000        	call	_millis
 719  014d ae0005        	ldw	x,#L62
 720  0150 cd0000        	call	c_ludv
 722  0153 be02          	ldw	x,c_lreg+2
 723  0155 cd0054        	call	_Serial_print_int
 725                     ; 21 			Serial_newline();
 727  0158 cd00b7        	call	_Serial_newline
 729  015b               L772:
 730                     ; 14 	while(!is_application_valid())
 732  015b cd0000        	call	_is_application_valid
 734  015e 4d            	tnz	a
 735  015f 27c1          	jreq	L572
 736                     ; 24 	Serial_print_string("DONE");
 738  0161 ae0009        	ldw	x,#L703
 739  0164 cd00c6        	call	_Serial_print_string
 741                     ; 25 	Serial_newline();
 743  0167 cd00b7        	call	_Serial_newline
 745                     ; 26 }
 748  016a 5b04          	addw	sp,#4
 749  016c 81            	ret
 762                     	xdef	_run_developer
 763                     	xdef	_Serial_read_char
 764                     	xdef	_Serial_available
 765                     	xdef	_Serial_newline
 766                     	xdef	_Serial_print_string
 767                     	xdef	_Serial_print_char
 768                     	xdef	_Serial_print_int
 769                     	xdef	_Serial_begin
 770                     	xref	_millis
 771                     	xref	_is_application_valid
 772                     	xref	_serial_setup
 773                     	xref	_UART1_ClearFlag
 774                     	xref	_UART1_GetFlagStatus
 775                     	xref	_UART1_SendData8
 776                     	xref	_UART1_ReceiveData8
 777                     	xref	_UART1_Cmd
 778                     	xref	_UART1_Init
 779                     	xref	_UART1_DeInit
 780                     	xref	_GPIO_Init
 781                     	switch	.const
 782  0009               L703:
 783  0009 444f4e4500    	dc.b	"DONE",0
 784  000e               L503:
 785  000e 7365633a2000  	dc.b	"sec: ",0
 786  0014               L372:
 787  0014 535441525400  	dc.b	"START",0
 788                     	xref.b	c_lreg
 789                     	xref.b	c_x
 790                     	xref.b	c_y
 810                     	xref	c_rtol
 811                     	xref	c_lcmp
 812                     	xref	c_ludv
 813                     	xref	c_sdivx
 814                     	xref	c_smody
 815                     	xref	c_smodx
 816                     	xref	c_xymov
 817                     	end
