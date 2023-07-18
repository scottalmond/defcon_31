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
 658                     	switch	.const
 659  0005               L62:
 660  0005 00000064      	dc.l	100
 661  0009               L03:
 662  0009 000003e8      	dc.l	1000
 663                     ; 7 void run_developer()
 663                     ; 8 {
 664                     	switch	.text
 665  00fe               _run_developer:
 667  00fe 5209          	subw	sp,#9
 668       00000009      OFST:	set	9
 671                     ; 10 	u8 iter=0;
 673                     ; 11 	u32 old_sec=999;
 675  0100 ae03e7        	ldw	x,#999
 676  0103 1f07          	ldw	(OFST-2,sp),x
 677  0105 ae0000        	ldw	x,#0
 678  0108 1f05          	ldw	(OFST-4,sp),x
 680                     ; 12 	serial_setup(1,1000000);
 682  010a ae4240        	ldw	x,#16960
 683  010d 89            	pushw	x
 684  010e ae000f        	ldw	x,#15
 685  0111 89            	pushw	x
 686  0112 a601          	ld	a,#1
 687  0114 cd0000        	call	_serial_setup
 689  0117 5b04          	addw	sp,#4
 691  0119 ac310231      	jpf	L103
 692  011d               L772:
 693                     ; 18 		for(iter=0;iter<10;iter++)
 695  011d 0f09          	clr	(OFST+0,sp)
 697  011f               L503:
 698                     ; 22 			set_hue(iter,(u16)(millis()*16+(0xFFFF/10)*iter),255);
 700  011f 4bff          	push	#255
 701  0121 7b0a          	ld	a,(OFST+1,sp)
 702  0123 5f            	clrw	x
 703  0124 97            	ld	xl,a
 704  0125 90ae1999      	ldw	y,#6553
 705  0129 cd0000        	call	c_imul
 707  012c cd0000        	call	c_uitolx
 709  012f 96            	ldw	x,sp
 710  0130 1c0002        	addw	x,#OFST-7
 711  0133 cd0000        	call	c_rtol
 714  0136 cd0000        	call	_millis
 716  0139 a604          	ld	a,#4
 717  013b cd0000        	call	c_llsh
 719  013e 96            	ldw	x,sp
 720  013f 1c0002        	addw	x,#OFST-7
 721  0142 cd0000        	call	c_ladd
 723  0145 be02          	ldw	x,c_lreg+2
 724  0147 89            	pushw	x
 725  0148 7b0c          	ld	a,(OFST+3,sp)
 726  014a cd0000        	call	_set_hue
 728  014d 5b03          	addw	sp,#3
 729                     ; 18 		for(iter=0;iter<10;iter++)
 731  014f 0c09          	inc	(OFST+0,sp)
 735  0151 7b09          	ld	a,(OFST+0,sp)
 736  0153 a10a          	cp	a,#10
 737  0155 25c8          	jrult	L503
 738                     ; 26 		if(old_sec!=(millis()/100))
 740  0157 cd0000        	call	_millis
 742  015a ae0005        	ldw	x,#L62
 743  015d cd0000        	call	c_ludv
 745  0160 96            	ldw	x,sp
 746  0161 1c0005        	addw	x,#OFST-4
 747  0164 cd0000        	call	c_lcmp
 749  0167 2603          	jrne	L23
 750  0169 cc022c        	jp	L313
 751  016c               L23:
 752                     ; 28 			old_sec=millis()/100;
 754  016c cd0000        	call	_millis
 756  016f ae0005        	ldw	x,#L62
 757  0172 cd0000        	call	c_ludv
 759  0175 96            	ldw	x,sp
 760  0176 1c0005        	addw	x,#OFST-4
 761  0179 cd0000        	call	c_rtol
 764                     ; 30 			Serial_print_string("sec: ");
 766  017c ae006b        	ldw	x,#L513
 767  017f cd00c6        	call	_Serial_print_string
 769                     ; 31 			Serial_print_int(millis()/1000);
 771  0182 cd0000        	call	_millis
 773  0185 ae0009        	ldw	x,#L03
 774  0188 cd0000        	call	c_ludv
 776  018b be02          	ldw	x,c_lreg+2
 777  018d cd0054        	call	_Serial_print_int
 779                     ; 33 			Serial_print_string(", [0]: ");
 781  0190 ae0063        	ldw	x,#L713
 782  0193 cd00c6        	call	_Serial_print_string
 784                     ; 34 			Serial_print_int(get_val(0));
 786  0196 4f            	clr	a
 787  0197 cd0000        	call	_get_val
 789  019a cd0054        	call	_Serial_print_int
 791                     ; 35 			Serial_print_string(", [1]: ");
 793  019d ae005b        	ldw	x,#L123
 794  01a0 cd00c6        	call	_Serial_print_string
 796                     ; 36 			Serial_print_int(get_val(1));
 798  01a3 a601          	ld	a,#1
 799  01a5 cd0000        	call	_get_val
 801  01a8 cd0054        	call	_Serial_print_int
 803                     ; 37 			Serial_print_string(", [2]: ");
 805  01ab ae0053        	ldw	x,#L323
 806  01ae cd00c6        	call	_Serial_print_string
 808                     ; 38 			Serial_print_int(get_val(2));
 810  01b1 a602          	ld	a,#2
 811  01b3 cd0000        	call	_get_val
 813  01b6 cd0054        	call	_Serial_print_int
 815                     ; 39 			Serial_print_string(", [3]: ");
 817  01b9 ae004b        	ldw	x,#L523
 818  01bc cd00c6        	call	_Serial_print_string
 820                     ; 40 			Serial_print_int(get_val(3));
 822  01bf a603          	ld	a,#3
 823  01c1 cd0000        	call	_get_val
 825  01c4 cd0054        	call	_Serial_print_int
 827                     ; 41 			Serial_print_string(", [4]: ");
 829  01c7 ae0043        	ldw	x,#L723
 830  01ca cd00c6        	call	_Serial_print_string
 832                     ; 42 			Serial_print_int(get_val(4));
 834  01cd a604          	ld	a,#4
 835  01cf cd0000        	call	_get_val
 837  01d2 cd0054        	call	_Serial_print_int
 839                     ; 43 			Serial_print_string(", [5]: ");
 841  01d5 ae003b        	ldw	x,#L133
 842  01d8 cd00c6        	call	_Serial_print_string
 844                     ; 44 			Serial_print_int(get_val(5));
 846  01db a605          	ld	a,#5
 847  01dd cd0000        	call	_get_val
 849  01e0 cd0054        	call	_Serial_print_int
 851                     ; 45 			Serial_print_string(", [6]: ");
 853  01e3 ae0033        	ldw	x,#L333
 854  01e6 cd00c6        	call	_Serial_print_string
 856                     ; 46 			Serial_print_int(get_val(6));
 858  01e9 a606          	ld	a,#6
 859  01eb cd0000        	call	_get_val
 861  01ee cd0054        	call	_Serial_print_int
 863                     ; 47 			Serial_print_string(", [7]: ");
 865  01f1 ae002b        	ldw	x,#L533
 866  01f4 cd00c6        	call	_Serial_print_string
 868                     ; 48 			Serial_print_int(get_val(7));
 870  01f7 a607          	ld	a,#7
 871  01f9 cd0000        	call	_get_val
 873  01fc cd0054        	call	_Serial_print_int
 875                     ; 49 			Serial_print_string(", [8]: ");
 877  01ff ae0023        	ldw	x,#L733
 878  0202 cd00c6        	call	_Serial_print_string
 880                     ; 50 			Serial_print_int(get_val(8));
 882  0205 a608          	ld	a,#8
 883  0207 cd0000        	call	_get_val
 885  020a cd0054        	call	_Serial_print_int
 887                     ; 51 			Serial_print_string(", [9]: ");
 889  020d ae001b        	ldw	x,#L143
 890  0210 cd00c6        	call	_Serial_print_string
 892                     ; 52 			Serial_print_int(get_val(9));
 894  0213 a609          	ld	a,#9
 895  0215 cd0000        	call	_get_val
 897  0218 cd0054        	call	_Serial_print_int
 899                     ; 53 			Serial_print_string(", [10]: ");
 901  021b ae0012        	ldw	x,#L343
 902  021e cd00c6        	call	_Serial_print_string
 904                     ; 54 			Serial_print_int(get_val(10));
 906  0221 a60a          	ld	a,#10
 907  0223 cd0000        	call	_get_val
 909  0226 cd0054        	call	_Serial_print_int
 911                     ; 55 			Serial_newline();
 913  0229 cd00b7        	call	_Serial_newline
 915  022c               L313:
 916                     ; 74 		flush_leds(20);
 918  022c a614          	ld	a,#20
 919  022e cd0000        	call	_flush_leds
 921  0231               L103:
 922                     ; 16 	while(!is_application_valid())
 924  0231 cd0000        	call	_is_application_valid
 926  0234 4d            	tnz	a
 927  0235 2603          	jrne	L43
 928  0237 cc011d        	jp	L772
 929  023a               L43:
 930                     ; 76 	Serial_print_string("DONE");
 932  023a ae000d        	ldw	x,#L543
 933  023d cd00c6        	call	_Serial_print_string
 935                     ; 77 	Serial_newline();
 937  0240 cd00b7        	call	_Serial_newline
 939                     ; 78 }
 942  0243 5b09          	addw	sp,#9
 943  0245 81            	ret
 956                     	xdef	_Serial_read_char
 957                     	xdef	_Serial_available
 958                     	xdef	_Serial_newline
 959                     	xdef	_Serial_print_string
 960                     	xdef	_Serial_print_char
 961                     	xdef	_Serial_print_int
 962                     	xdef	_Serial_begin
 963                     	xdef	_run_developer
 964                     	xref	_set_hue
 965                     	xref	_get_val
 966                     	xref	_flush_leds
 967                     	xref	_millis
 968                     	xref	_is_application_valid
 969                     	xref	_serial_setup
 970                     	xref	_UART1_ClearFlag
 971                     	xref	_UART1_GetFlagStatus
 972                     	xref	_UART1_SendData8
 973                     	xref	_UART1_ReceiveData8
 974                     	xref	_UART1_Cmd
 975                     	xref	_UART1_Init
 976                     	xref	_UART1_DeInit
 977                     	xref	_GPIO_Init
 978                     	switch	.const
 979  000d               L543:
 980  000d 444f4e4500    	dc.b	"DONE",0
 981  0012               L343:
 982  0012 2c205b31305d  	dc.b	", [10]: ",0
 983  001b               L143:
 984  001b 2c205b395d3a  	dc.b	", [9]: ",0
 985  0023               L733:
 986  0023 2c205b385d3a  	dc.b	", [8]: ",0
 987  002b               L533:
 988  002b 2c205b375d3a  	dc.b	", [7]: ",0
 989  0033               L333:
 990  0033 2c205b365d3a  	dc.b	", [6]: ",0
 991  003b               L133:
 992  003b 2c205b355d3a  	dc.b	", [5]: ",0
 993  0043               L723:
 994  0043 2c205b345d3a  	dc.b	", [4]: ",0
 995  004b               L523:
 996  004b 2c205b335d3a  	dc.b	", [3]: ",0
 997  0053               L323:
 998  0053 2c205b325d3a  	dc.b	", [2]: ",0
 999  005b               L123:
1000  005b 2c205b315d3a  	dc.b	", [1]: ",0
1001  0063               L713:
1002  0063 2c205b305d3a  	dc.b	", [0]: ",0
1003  006b               L513:
1004  006b 7365633a2000  	dc.b	"sec: ",0
1005                     	xref.b	c_lreg
1006                     	xref.b	c_x
1007                     	xref.b	c_y
1027                     	xref	c_lcmp
1028                     	xref	c_ludv
1029                     	xref	c_ladd
1030                     	xref	c_rtol
1031                     	xref	c_uitolx
1032                     	xref	c_imul
1033                     	xref	c_llsh
1034                     	xref	c_sdivx
1035                     	xref	c_smody
1036                     	xref	c_smodx
1037                     	xref	c_xymov
1038                     	end
