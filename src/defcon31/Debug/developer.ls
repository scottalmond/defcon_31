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
 270                     ; 56  void Serial_print_u32(u32 number)
 270                     ; 57  {
 271                     	switch	.text
 272  0054               _Serial_print_u32:
 274  0054 89            	pushw	x
 275       00000002      OFST:	set	2
 278                     ; 60 	 Serial_print_string("0x");
 280  0055 ae00c0        	ldw	x,#L711
 281  0058 cd010d        	call	_Serial_print_string
 283                     ; 61 	 for(iter=28;iter<32;iter-=4)
 285  005b a61c          	ld	a,#28
 286  005d 6b02          	ld	(OFST+0,sp),a
 288  005f               L121:
 289                     ; 63 		 digit=number>>iter;
 291  005f 96            	ldw	x,sp
 292  0060 1c0005        	addw	x,#OFST+3
 293  0063 cd0000        	call	c_ltor
 295  0066 7b02          	ld	a,(OFST+0,sp)
 296  0068 cd0000        	call	c_lursh
 298  006b b603          	ld	a,c_lreg+3
 299  006d 6b01          	ld	(OFST-1,sp),a
 301                     ; 64 		 if(digit>9) Serial_print_char('A'+(digit-10));
 303  006f 7b01          	ld	a,(OFST-1,sp)
 304  0071 a10a          	cp	a,#10
 305  0073 2508          	jrult	L721
 308  0075 7b01          	ld	a,(OFST-1,sp)
 309  0077 ab37          	add	a,#55
 310  0079 ad98          	call	_Serial_print_char
 313  007b 2006          	jra	L131
 314  007d               L721:
 315                     ; 65 		 else Serial_print_char('0'+digit);
 317  007d 7b01          	ld	a,(OFST-1,sp)
 318  007f ab30          	add	a,#48
 319  0081 ad90          	call	_Serial_print_char
 321  0083               L131:
 322                     ; 66 		 if(iter==16) Serial_print_char('_');
 324  0083 7b02          	ld	a,(OFST+0,sp)
 325  0085 a110          	cp	a,#16
 326  0087 2604          	jrne	L331
 329  0089 a65f          	ld	a,#95
 330  008b ad86          	call	_Serial_print_char
 332  008d               L331:
 333                     ; 61 	 for(iter=28;iter<32;iter-=4)
 335  008d 7b02          	ld	a,(OFST+0,sp)
 336  008f a004          	sub	a,#4
 337  0091 6b02          	ld	(OFST+0,sp),a
 341  0093 7b02          	ld	a,(OFST+0,sp)
 342  0095 a120          	cp	a,#32
 343  0097 25c6          	jrult	L121
 344                     ; 68  }
 347  0099 85            	popw	x
 348  009a 81            	ret
 351                     .const:	section	.text
 352  0000               L531_digit:
 353  0000 00            	dc.b	0
 354  0001 00000000      	ds.b	4
 407                     ; 70  void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 407                     ; 71  {
 408                     	switch	.text
 409  009b               _Serial_print_int:
 411  009b 89            	pushw	x
 412  009c 5208          	subw	sp,#8
 413       00000008      OFST:	set	8
 416                     ; 72 	 char count = 0;
 418  009e 0f08          	clr	(OFST+0,sp)
 420                     ; 73 	 char digit[5] = "";
 422  00a0 96            	ldw	x,sp
 423  00a1 1c0003        	addw	x,#OFST-5
 424  00a4 90ae0000      	ldw	y,#L531_digit
 425  00a8 a605          	ld	a,#5
 426  00aa cd0000        	call	c_xymov
 429  00ad 2023          	jra	L171
 430  00af               L561:
 431                     ; 77 		 digit[count] = number%10;
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
 449                     ; 78 		 count++;
 451  00c7 0c08          	inc	(OFST+0,sp)
 453                     ; 79 		 number = number/10;
 455  00c9 1e09          	ldw	x,(OFST+1,sp)
 456  00cb a60a          	ld	a,#10
 457  00cd cd0000        	call	c_sdivx
 459  00d0 1f09          	ldw	(OFST+1,sp),x
 460  00d2               L171:
 461                     ; 75 	 while (number != 0) //split the int to char array 
 463  00d2 1e09          	ldw	x,(OFST+1,sp)
 464  00d4 26d9          	jrne	L561
 466  00d6 201f          	jra	L771
 467  00d8               L571:
 468                     ; 84 		UART1_SendData8(digit[count-1] + 0x30);
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
 485                     ; 85 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 487  00ec ae0080        	ldw	x,#128
 488  00ef cd0000        	call	_UART1_GetFlagStatus
 490  00f2 4d            	tnz	a
 491  00f3 27f7          	jreq	L502
 492                     ; 86 		count--; 
 494  00f5 0a08          	dec	(OFST+0,sp)
 496  00f7               L771:
 497                     ; 82 	 while (count !=0) //print char array in correct direction 
 499  00f7 0d08          	tnz	(OFST+0,sp)
 500  00f9 26dd          	jrne	L571
 501                     ; 88  }
 504  00fb 5b0a          	addw	sp,#10
 505  00fd 81            	ret
 530                     ; 90  void Serial_newline(void)
 530                     ; 91  {
 531                     	switch	.text
 532  00fe               _Serial_newline:
 536                     ; 92 	 UART1_SendData8(0x0a);
 538  00fe a60a          	ld	a,#10
 539  0100 cd0000        	call	_UART1_SendData8
 542  0103               L322:
 543                     ; 93 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 545  0103 ae0080        	ldw	x,#128
 546  0106 cd0000        	call	_UART1_GetFlagStatus
 548  0109 4d            	tnz	a
 549  010a 27f7          	jreq	L322
 550                     ; 94  }
 553  010c 81            	ret
 600                     ; 96  void Serial_print_string (char string[])
 600                     ; 97  {
 601                     	switch	.text
 602  010d               _Serial_print_string:
 604  010d 89            	pushw	x
 605  010e 88            	push	a
 606       00000001      OFST:	set	1
 609                     ; 99 	 char i=0;
 611  010f 0f01          	clr	(OFST+0,sp)
 614  0111 2016          	jra	L552
 615  0113               L152:
 616                     ; 103 		UART1_SendData8(string[i]);
 618  0113 7b01          	ld	a,(OFST+0,sp)
 619  0115 5f            	clrw	x
 620  0116 97            	ld	xl,a
 621  0117 72fb02        	addw	x,(OFST+1,sp)
 622  011a f6            	ld	a,(x)
 623  011b cd0000        	call	_UART1_SendData8
 626  011e               L362:
 627                     ; 104 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 629  011e ae0080        	ldw	x,#128
 630  0121 cd0000        	call	_UART1_GetFlagStatus
 632  0124 4d            	tnz	a
 633  0125 27f7          	jreq	L362
 634                     ; 105 		i++;
 636  0127 0c01          	inc	(OFST+0,sp)
 638  0129               L552:
 639                     ; 101 	 while (string[i] != 0x00)
 641  0129 7b01          	ld	a,(OFST+0,sp)
 642  012b 5f            	clrw	x
 643  012c 97            	ld	xl,a
 644  012d 72fb02        	addw	x,(OFST+1,sp)
 645  0130 7d            	tnz	(x)
 646  0131 26e0          	jrne	L152
 647                     ; 107  }
 650  0133 5b03          	addw	sp,#3
 651  0135 81            	ret
 696                     ; 109  bool Serial_available()
 696                     ; 110  {
 697                     	switch	.text
 698  0136               _Serial_available:
 702                     ; 111 	 if(UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE)
 704  0136 ae0020        	ldw	x,#32
 705  0139 cd0000        	call	_UART1_GetFlagStatus
 707  013c a101          	cp	a,#1
 708  013e 2603          	jrne	L703
 709                     ; 112 	 return TRUE;
 711  0140 a601          	ld	a,#1
 714  0142 81            	ret
 715  0143               L703:
 716                     ; 114 	 return FALSE;
 718  0143 4f            	clr	a
 721  0144 81            	ret
 766                     ; 10 void setup_developer()
 766                     ; 11 {
 767                     	switch	.text
 768  0145               _setup_developer:
 772                     ; 12 	setup_serial(1,1);//enabled, 0: 9600 baud, 1: at high speed (1MBaud)
 774  0145 ae0101        	ldw	x,#257
 775  0148 cd0000        	call	_setup_serial
 777                     ; 13 	clear_button_events();
 779  014b cd0000        	call	_clear_button_events
 781                     ; 14 	flush_leds(0);//clear outstanding led buffer
 783  014e 4f            	clr	a
 784  014f cd0000        	call	_flush_leds
 786                     ; 15 	set_debug(255);//show only one debug led ON
 788  0152 a6ff          	ld	a,#255
 789  0154 cd0000        	call	_set_debug
 791                     ; 16 	flush_leds(1);
 793  0157 a601          	ld	a,#1
 794  0159 cd0000        	call	_flush_leds
 796                     ; 17 	print_welcome();
 798  015c ad40          	call	_print_welcome
 800                     ; 18 }
 803  015e 81            	ret
 862                     ; 20 void run_developer()
 862                     ; 21 {
 863                     	switch	.text
 864  015f               _run_developer:
 866  015f 520e          	subw	sp,#14
 867       0000000e      OFST:	set	14
 870                     ; 25 	setup_developer();
 872  0161 ade2          	call	_setup_developer
 875  0163 2030          	jra	L163
 876  0165               L753:
 877                     ; 28 		Serial_print_string("> ");
 879  0165 ae00bd        	ldw	x,#L563
 880  0168 ada3          	call	_Serial_print_string
 882                     ; 29 		get_terminal_command(&command,&parameters,&parameter_count);
 884  016a 96            	ldw	x,sp
 885  016b 1c000e        	addw	x,#OFST+0
 886  016e 89            	pushw	x
 887  016f 96            	ldw	x,sp
 888  0170 1c0003        	addw	x,#OFST-11
 889  0173 89            	pushw	x
 890  0174 96            	ldw	x,sp
 891  0175 1c0011        	addw	x,#OFST+3
 892  0178 cd021e        	call	_get_terminal_command
 894  017b 5b04          	addw	sp,#4
 895                     ; 30 		set_debug(255);//show only one debug led ON
 897  017d a6ff          	ld	a,#255
 898  017f cd0000        	call	_set_debug
 900                     ; 31 		execute_terminal_command(command,&parameters,parameter_count);
 902  0182 7b0e          	ld	a,(OFST+0,sp)
 903  0184 88            	push	a
 904  0185 96            	ldw	x,sp
 905  0186 1c0002        	addw	x,#OFST-12
 906  0189 89            	pushw	x
 907  018a 7b10          	ld	a,(OFST+2,sp)
 908  018c cd0300        	call	_execute_terminal_command
 910  018f 5b03          	addw	sp,#3
 911                     ; 32 		command=0;
 913  0191 0f0d          	clr	(OFST-1,sp)
 915                     ; 33 		parameter_count=0;
 917  0193 0f0e          	clr	(OFST+0,sp)
 919  0195               L163:
 920                     ; 26 	while(is_developer_valid())
 922  0195 cd0000        	call	_is_developer_valid
 924  0198 4d            	tnz	a
 925  0199 26ca          	jrne	L753
 926                     ; 38 }
 929  019b 5b0e          	addw	sp,#14
 930  019d 81            	ret
 933                     	switch	.const
 934  0005               L763_space_bits:
 935  0005 79            	dc.b	121
 936  0006 f0            	dc.b	240
 937  0007 c3            	dc.b	195
 938  0008 cf            	dc.b	207
 939  0009 df            	dc.b	223
 940  000a 2f            	dc.b	47
 941  000b 9e            	dc.b	158
 942  000c 7c            	dc.b	124
 943  000d 84            	dc.b	132
 944  000e f0            	dc.b	240
 945  000f 81            	dc.b	129
 946  0010 09            	dc.b	9
 947  0011 24            	dc.b	36
 948  0012 28            	dc.b	40
 949  0013 10            	dc.b	16
 950  0014 a2            	dc.b	162
 951  0015 20            	dc.b	32
 952  0016 42            	dc.b	66
 953  0017 85            	dc.b	133
 954  0018 00            	dc.b	0
 955  0019 79            	dc.b	121
 956  001a 0a            	dc.b	10
 957  001b 14            	dc.b	20
 958  001c 0f            	dc.b	15
 959  001d 9f            	dc.b	159
 960  001e 22            	dc.b	34
 961  001f 1e            	dc.b	30
 962  0020 42            	dc.b	66
 963  0021 84            	dc.b	132
 964  0022 f0            	dc.b	240
 965  0023 05            	dc.b	5
 966  0024 f3            	dc.b	243
 967  0025 f4            	dc.b	244
 968  0026 08            	dc.b	8
 969  0027 10            	dc.b	16
 970  0028 a2            	dc.b	162
 971  0029 01            	dc.b	1
 972  002a 7c            	dc.b	124
 973  002b 84            	dc.b	132
 974  002c 08            	dc.b	8
 975  002d 85            	dc.b	133
 976  002e 02            	dc.b	2
 977  002f 14            	dc.b	20
 978  0030 28            	dc.b	40
 979  0031 10            	dc.b	16
 980  0032 a2            	dc.b	162
 981  0033 21            	dc.b	33
 982  0034 44            	dc.b	68
 983  0035 85            	dc.b	133
 984  0036 08            	dc.b	8
 985  0037 79            	dc.b	121
 986  0038 02            	dc.b	2
 987  0039 13            	dc.b	19
 988  003a cf            	dc.b	207
 989  003b df            	dc.b	223
 990  003c 22            	dc.b	34
 991  003d 1e            	dc.b	30
 992  003e 42            	dc.b	66
 993  003f 78            	dc.b	120
 994  0040 f0            	dc.b	240
 995  0041               L173_defcon31:
 996  0041 7e            	dc.b	126
 997  0042 7f            	dc.b	127
 998  0043 7f            	dc.b	127
 999  0044 3e            	dc.b	62
1000  0045 7f            	dc.b	127
1001  0046 41            	dc.b	65
1002  0047 3e            	dc.b	62
1003  0048 08            	dc.b	8
1004  0049 41            	dc.b	65
1005  004a 40            	dc.b	64
1006  004b 40            	dc.b	64
1007  004c 41            	dc.b	65
1008  004d 41            	dc.b	65
1009  004e 61            	dc.b	97
1010  004f 41            	dc.b	65
1011  0050 18            	dc.b	24
1012  0051 41            	dc.b	65
1013  0052 40            	dc.b	64
1014  0053 40            	dc.b	64
1015  0054 40            	dc.b	64
1016  0055 41            	dc.b	65
1017  0056 51            	dc.b	81
1018  0057 01            	dc.b	1
1019  0058 28            	dc.b	40
1020  0059 41            	dc.b	65
1021  005a 7c            	dc.b	124
1022  005b 7c            	dc.b	124
1023  005c 40            	dc.b	64
1024  005d 41            	dc.b	65
1025  005e 49            	dc.b	73
1026  005f 3e            	dc.b	62
1027  0060 08            	dc.b	8
1028  0061 41            	dc.b	65
1029  0062 40            	dc.b	64
1030  0063 40            	dc.b	64
1031  0064 40            	dc.b	64
1032  0065 41            	dc.b	65
1033  0066 45            	dc.b	69
1034  0067 01            	dc.b	1
1035  0068 08            	dc.b	8
1036  0069 41            	dc.b	65
1037  006a 40            	dc.b	64
1038  006b 40            	dc.b	64
1039  006c 41            	dc.b	65
1040  006d 41            	dc.b	65
1041  006e 43            	dc.b	67
1042  006f 41            	dc.b	65
1043  0070 08            	dc.b	8
1044  0071 7e            	dc.b	126
1045  0072 7f            	dc.b	127
1046  0073 40            	dc.b	64
1047  0074 3e            	dc.b	62
1048  0075 7f            	dc.b	127
1049  0076 41            	dc.b	65
1050  0077 3e            	dc.b	62
1051  0078 3e            	dc.b	62
1133                     ; 41 void print_welcome()
1133                     ; 42 {
1134                     	switch	.text
1135  019e               _print_welcome:
1137  019e 5277          	subw	sp,#119
1138       00000077      OFST:	set	119
1141                     ; 43 	u8 space_bits[] = { 0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,
1141                     ; 44 											0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,
1141                     ; 45 											0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,
1141                     ; 46 											0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,
1141                     ; 47 											0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,
1141                     ; 48 											0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,
1141                     ; 49 											0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,
1141                     ; 50 											0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,
1141                     ; 51 											0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,
1141                     ; 52 											0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000}; 
1143  01a0 96            	ldw	x,sp
1144  01a1 1c0002        	addw	x,#OFST-117
1145  01a4 90ae0005      	ldw	y,#L763_space_bits
1146  01a8 a63c          	ld	a,#60
1147  01aa cd0000        	call	c_xymov
1149                     ; 53 	u8 defcon31[] = {   0b01111110,0b01111111,0b01111111,0b00111110,0b01111111,0b01000001,
1149                     ; 54 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000001,
1149                     ; 55 											0b01000001,0b01100001,0b01000001,0b0011000,0b01000001,0b01000000,
1149                     ; 56 											0b01000000,0b01000000,0b01000001,0b01010001,0b00000001,0b0101000,
1149                     ; 57 											0b01000001,0b01111100,0b01111100,0b01000000,0b01000001,0b01001001,//last bit messed up?
1149                     ; 58 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000000,//mis-typed bit?
1149                     ; 59 											0b01000001,0b01000101,0b00000001,0b0001000,0b01000001,0b01000000,
1149                     ; 60 											0b01000000,0b01000001,0b01000001,0b01000011,0b01000001,0b0001000,
1149                     ; 61 											0b01111110,0b01111111,0b01000000,0b00111110,0b01111111,0b01000001,
1149                     ; 62 											0b00111110,0b0111110 };
1151  01ad 96            	ldw	x,sp
1152  01ae 1c003e        	addw	x,#OFST-57
1153  01b1 90ae0041      	ldw	y,#L173_defcon31
1154  01b5 a638          	ld	a,#56
1155  01b7 cd0000        	call	c_xymov
1157                     ; 63 	u8 length = sizeof(is_space_sao()?space_bits:defcon31);
1159  01ba a602          	ld	a,#2
1160  01bc 6b01          	ld	(OFST-118,sp),a
1162                     ; 64 	u8 lineBreakInterval = is_space_sao()?10:8;
1164  01be cd0000        	call	_is_space_sao
1166  01c1 4d            	tnz	a
1167  01c2 2705          	jreq	L43
1168  01c4 ae000a        	ldw	x,#10
1169  01c7 2003          	jra	L63
1170  01c9               L43:
1171  01c9 ae0008        	ldw	x,#8
1172  01cc               L63:
1173                     ; 66 	for (i = 0; i < length; i++) {
1175  01cc 0f76          	clr	(OFST-1,sp)
1178  01ce 2045          	jra	L144
1179  01d0               L534:
1180                     ; 67 			for (j = 7; j >= 0; j--) {
1182  01d0 a607          	ld	a,#7
1183  01d2 6b77          	ld	(OFST+0,sp),a
1185  01d4               L544:
1186                     ; 69 				 Serial_print_char((((is_space_sao()?space_bits[i]:defcon31[i]) >> j) & 0x01) ? '#' : ' ');
1188  01d4 cd0000        	call	_is_space_sao
1190  01d7 4d            	tnz	a
1191  01d8 2711          	jreq	L24
1192  01da 96            	ldw	x,sp
1193  01db 1c0002        	addw	x,#OFST-117
1194  01de 9f            	ld	a,xl
1195  01df 5e            	swapw	x
1196  01e0 1b76          	add	a,(OFST-1,sp)
1197  01e2 2401          	jrnc	L44
1198  01e4 5c            	incw	x
1199  01e5               L44:
1200  01e5 02            	rlwa	x,a
1201  01e6 f6            	ld	a,(x)
1202  01e7 5f            	clrw	x
1203  01e8 97            	ld	xl,a
1204  01e9 200f          	jra	L64
1205  01eb               L24:
1206  01eb 96            	ldw	x,sp
1207  01ec 1c003e        	addw	x,#OFST-57
1208  01ef 9f            	ld	a,xl
1209  01f0 5e            	swapw	x
1210  01f1 1b76          	add	a,(OFST-1,sp)
1211  01f3 2401          	jrnc	L05
1212  01f5 5c            	incw	x
1213  01f6               L05:
1214  01f6 02            	rlwa	x,a
1215  01f7 f6            	ld	a,(x)
1216  01f8 5f            	clrw	x
1217  01f9 97            	ld	xl,a
1218  01fa               L64:
1219  01fa 7b77          	ld	a,(OFST+0,sp)
1220  01fc 4d            	tnz	a
1221  01fd 2704          	jreq	L25
1222  01ff               L45:
1223  01ff 57            	sraw	x
1224  0200 4a            	dec	a
1225  0201 26fc          	jrne	L45
1226  0203               L25:
1227  0203 01            	rrwa	x,a
1228  0204 a501          	bcp	a,#1
1229  0206 2704          	jreq	L04
1230  0208 a623          	ld	a,#35
1231  020a 2002          	jra	L65
1232  020c               L04:
1233  020c a620          	ld	a,#32
1234  020e               L65:
1235  020e cd0013        	call	_Serial_print_char
1237                     ; 67 			for (j = 7; j >= 0; j--) {
1239  0211 0a77          	dec	(OFST+0,sp)
1242  0213 20bf          	jra	L544
1243  0215               L144:
1244                     ; 66 	for (i = 0; i < length; i++) {
1247  0215 7b76          	ld	a,(OFST-1,sp)
1248  0217 1101          	cp	a,(OFST-118,sp)
1249  0219 25b5          	jrult	L534
1250                     ; 78 }
1253  021b 5b77          	addw	sp,#119
1254  021d 81            	ret
1363                     ; 80 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
1363                     ; 81 {
1364                     	switch	.text
1365  021e               _get_terminal_command:
1367  021e 89            	pushw	x
1368  021f 5207          	subw	sp,#7
1369       00000007      OFST:	set	7
1372                     ; 82 	bool is_new_line=0;
1374  0221 0f05          	clr	(OFST-2,sp)
1376                     ; 83 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
1378  0223 0f06          	clr	(OFST-1,sp)
1381  0225 acf002f0      	jpf	L135
1382  0229               L525:
1383                     ; 87 		if(Serial_available())
1385  0229 cd0136        	call	_Serial_available
1387  022c 4d            	tnz	a
1388  022d 2603          	jrne	L26
1389  022f cc02f0        	jp	L135
1390  0232               L26:
1391                     ; 89 			input_char=Serial_read_char();
1393  0232 cd0000        	call	_Serial_read_char
1395  0235 6b07          	ld	(OFST+0,sp),a
1397                     ; 90 			if(input_char=='\n') is_new_line=1;//break on new line character found
1399  0237 7b07          	ld	a,(OFST+0,sp)
1400  0239 a10a          	cp	a,#10
1401  023b 2608          	jrne	L735
1404  023d a601          	ld	a,#1
1405  023f 6b05          	ld	(OFST-2,sp),a
1408  0241 acf002f0      	jpf	L135
1409  0245               L735:
1410                     ; 91 			else if((*command)==0) (*command)=input_char;
1412  0245 1e08          	ldw	x,(OFST+1,sp)
1413  0247 7d            	tnz	(x)
1414  0248 2609          	jrne	L345
1417  024a 7b07          	ld	a,(OFST+0,sp)
1418  024c 1e08          	ldw	x,(OFST+1,sp)
1419  024e f7            	ld	(x),a
1421  024f acf002f0      	jpf	L135
1422  0253               L345:
1423                     ; 93 				if('0'<=input_char && input_char<='9')
1425  0253 7b07          	ld	a,(OFST+0,sp)
1426  0255 a130          	cp	a,#48
1427  0257 2402          	jruge	L46
1428  0259 2078          	jp	L745
1429  025b               L46:
1431  025b 7b07          	ld	a,(OFST+0,sp)
1432  025d a13a          	cp	a,#58
1433  025f 2472          	jruge	L745
1434                     ; 95 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
1436  0261 0d06          	tnz	(OFST-1,sp)
1437  0263 2619          	jrne	L155
1440  0265 1e0e          	ldw	x,(OFST+7,sp)
1441  0267 f6            	ld	a,(x)
1442  0268 97            	ld	xl,a
1443  0269 a604          	ld	a,#4
1444  026b 42            	mul	x,a
1445  026c 72fb0c        	addw	x,(OFST+5,sp)
1446  026f a600          	ld	a,#0
1447  0271 e703          	ld	(3,x),a
1448  0273 a600          	ld	a,#0
1449  0275 e702          	ld	(2,x),a
1450  0277 a600          	ld	a,#0
1451  0279 e701          	ld	(1,x),a
1452  027b a600          	ld	a,#0
1453  027d f7            	ld	(x),a
1454  027e               L155:
1455                     ; 96 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
1457  027e 7b07          	ld	a,(OFST+0,sp)
1458  0280 5f            	clrw	x
1459  0281 97            	ld	xl,a
1460  0282 1d0030        	subw	x,#48
1461  0285 cd0000        	call	c_itolx
1463  0288 96            	ldw	x,sp
1464  0289 1c0001        	addw	x,#OFST-6
1465  028c cd0000        	call	c_rtol
1468  028f 1e0e          	ldw	x,(OFST+7,sp)
1469  0291 f6            	ld	a,(x)
1470  0292 97            	ld	xl,a
1471  0293 a604          	ld	a,#4
1472  0295 42            	mul	x,a
1473  0296 72fb0c        	addw	x,(OFST+5,sp)
1474  0299 cd0000        	call	c_ltor
1476  029c 1e0e          	ldw	x,(OFST+7,sp)
1477  029e f6            	ld	a,(x)
1478  029f 97            	ld	xl,a
1479  02a0 a604          	ld	a,#4
1480  02a2 42            	mul	x,a
1481  02a3 72fb0c        	addw	x,(OFST+5,sp)
1482  02a6 e603          	ld	a,(3,x)
1483  02a8 5f            	clrw	x
1484  02a9 97            	ld	xl,a
1485  02aa 1c0003        	addw	x,#3
1486  02ad 01            	rrwa	x,a
1487  02ae cd0000        	call	c_llsh
1489  02b1 3803          	sll	c_lreg+3
1490  02b3 3902          	rlc	c_lreg+2
1491  02b5 3901          	rlc	c_lreg+1
1492  02b7 3900          	rlc	c_lreg
1493  02b9 96            	ldw	x,sp
1494  02ba 1c0001        	addw	x,#OFST-6
1495  02bd cd0000        	call	c_ladd
1497  02c0 1e0e          	ldw	x,(OFST+7,sp)
1498  02c2 f6            	ld	a,(x)
1499  02c3 97            	ld	xl,a
1500  02c4 a604          	ld	a,#4
1501  02c6 42            	mul	x,a
1502  02c7 72fb0c        	addw	x,(OFST+5,sp)
1503  02ca cd0000        	call	c_rtol
1505                     ; 97 					is_any_input=1;
1507  02cd a601          	ld	a,#1
1508  02cf 6b06          	ld	(OFST-1,sp),a
1511  02d1 201d          	jra	L135
1512  02d3               L745:
1513                     ; 99 					if(is_any_input)
1515  02d3 0d06          	tnz	(OFST-1,sp)
1516  02d5 2719          	jreq	L135
1517                     ; 101 						(*parameter_count)++;
1519  02d7 1e0e          	ldw	x,(OFST+7,sp)
1520  02d9 7c            	inc	(x)
1521                     ; 102 						is_any_input=0;
1523  02da 0f06          	clr	(OFST-1,sp)
1525                     ; 103 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
1527  02dc 1e0e          	ldw	x,(OFST+7,sp)
1528  02de f6            	ld	a,(x)
1529  02df 905f          	clrw	y
1530  02e1 9097          	ld	yl,a
1531  02e3 a603          	ld	a,#3
1532  02e5 9062          	div	y,a
1533  02e7 905f          	clrw	y
1534  02e9 9097          	ld	yl,a
1535  02eb 9001          	rrwa	y,a
1536  02ed f7            	ld	(x),a
1537  02ee 9002          	rlwa	y,a
1538  02f0               L135:
1539                     ; 85 	while(is_developer_valid() && !is_new_line)
1541  02f0 cd0000        	call	_is_developer_valid
1543  02f3 4d            	tnz	a
1544  02f4 2707          	jreq	L755
1546  02f6 0d05          	tnz	(OFST-2,sp)
1547  02f8 2603          	jrne	L66
1548  02fa cc0229        	jp	L525
1549  02fd               L66:
1550  02fd               L755:
1551                     ; 109 }
1554  02fd 5b09          	addw	sp,#9
1555  02ff 81            	ret
1641                     	switch	.const
1642  0079               L27:
1643  0079 00004000      	dc.l	16384
1644  007d               L47:
1645  007d 00000100      	dc.l	256
1646  0081               L67:
1647  0081 0000000a      	dc.l	10
1648  0085               L001:
1649  0085 00000003      	dc.l	3
1650  0089               L201:
1651  0089 000000ff      	dc.l	255
1652  008d               L401:
1653  008d 0000000c      	dc.l	12
1654                     ; 111 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
1654                     ; 112 {
1655                     	switch	.text
1656  0300               _execute_terminal_command:
1658  0300 88            	push	a
1659  0301 88            	push	a
1660       00000001      OFST:	set	1
1663                     ; 114 	bool is_valid=0;
1665  0302 0f01          	clr	(OFST+0,sp)
1667                     ; 115 	switch(command)
1670                     ; 178 		}break;
1671  0304 a061          	sub	a,#97
1672  0306 2603          	jrne	L601
1673  0308 cc0499        	jp	L575
1674  030b               L601:
1675  030b a004          	sub	a,#4
1676  030d 2603          	jrne	L011
1677  030f cc03a0        	jp	L765
1678  0312               L011:
1679  0312 a003          	sub	a,#3
1680  0314 2779          	jreq	L565
1681  0316 a004          	sub	a,#4
1682  0318 2603          	jrne	L211
1683  031a cc03f3        	jp	L175
1684  031d               L211:
1685  031d a004          	sub	a,#4
1686  031f 270f          	jreq	L165
1687  0321 a004          	sub	a,#4
1688  0323 273f          	jreq	L365
1689  0325 a003          	sub	a,#3
1690  0327 2603          	jrne	L411
1691  0329 cc0453        	jp	L375
1692  032c               L411:
1693  032c acb304b3      	jpf	L736
1694  0330               L165:
1695                     ; 118 			Serial_print_char(command);
1697  0330 7b02          	ld	a,(OFST+1,sp)
1698  0332 cd0013        	call	_Serial_print_char
1700                     ; 119 			for(iter=0;iter<parameter_count;iter++)
1702  0335 0f01          	clr	(OFST+0,sp)
1705  0337 201d          	jra	L546
1706  0339               L146:
1707                     ; 121 				Serial_print_char(' ');
1709  0339 a620          	ld	a,#32
1710  033b cd0013        	call	_Serial_print_char
1712                     ; 122 				Serial_print_u32((*parameters)[iter]);
1714  033e 7b01          	ld	a,(OFST+0,sp)
1715  0340 97            	ld	xl,a
1716  0341 a604          	ld	a,#4
1717  0343 42            	mul	x,a
1718  0344 72fb05        	addw	x,(OFST+4,sp)
1719  0347 9093          	ldw	y,x
1720  0349 ee02          	ldw	x,(2,x)
1721  034b 89            	pushw	x
1722  034c 93            	ldw	x,y
1723  034d fe            	ldw	x,(x)
1724  034e 89            	pushw	x
1725  034f cd0054        	call	_Serial_print_u32
1727  0352 5b04          	addw	sp,#4
1728                     ; 119 			for(iter=0;iter<parameter_count;iter++)
1730  0354 0c01          	inc	(OFST+0,sp)
1732  0356               L546:
1735  0356 7b01          	ld	a,(OFST+0,sp)
1736  0358 1107          	cp	a,(OFST+6,sp)
1737  035a 25dd          	jrult	L146
1738                     ; 124 			is_valid=1;
1740  035c a601          	ld	a,#1
1741  035e 6b01          	ld	(OFST+0,sp),a
1743                     ; 125 		}break;
1745  0360 acb304b3      	jpf	L736
1746  0364               L365:
1747                     ; 127 			if(parameter_count) set_millis((*parameters)[0]);
1749  0364 0d07          	tnz	(OFST+6,sp)
1750  0366 2711          	jreq	L156
1753  0368 1e05          	ldw	x,(OFST+4,sp)
1754  036a 9093          	ldw	y,x
1755  036c ee02          	ldw	x,(2,x)
1756  036e 89            	pushw	x
1757  036f 93            	ldw	x,y
1758  0370 fe            	ldw	x,(x)
1759  0371 89            	pushw	x
1760  0372 cd0000        	call	_set_millis
1762  0375 5b04          	addw	sp,#4
1764  0377 200e          	jra	L356
1765  0379               L156:
1766                     ; 128 			else Serial_print_u32(millis());
1768  0379 cd0000        	call	_millis
1770  037c be02          	ldw	x,c_lreg+2
1771  037e 89            	pushw	x
1772  037f be00          	ldw	x,c_lreg
1773  0381 89            	pushw	x
1774  0382 cd0054        	call	_Serial_print_u32
1776  0385 5b04          	addw	sp,#4
1777  0387               L356:
1778                     ; 129 			is_valid=1;
1780  0387 a601          	ld	a,#1
1781  0389 6b01          	ld	(OFST+0,sp),a
1783                     ; 130 		}break;
1785  038b acb304b3      	jpf	L736
1786  038f               L565:
1787                     ; 132 			print_welcome();
1789  038f cd019e        	call	_print_welcome
1791                     ; 133 			Serial_print_string("GitHub.com/ScottAlmond/DefCon_31");
1793  0392 ae009c        	ldw	x,#L556
1794  0395 cd010d        	call	_Serial_print_string
1796                     ; 134 			is_valid=1;
1798  0398 a601          	ld	a,#1
1799  039a 6b01          	ld	(OFST+0,sp),a
1801                     ; 135 		}break;
1803  039c acb304b3      	jpf	L736
1804  03a0               L765:
1805                     ; 137 			if(parameter_count==1)
1807  03a0 7b07          	ld	a,(OFST+6,sp)
1808  03a2 a101          	cp	a,#1
1809  03a4 262d          	jrne	L756
1810                     ; 139 				Serial_print_u32(FLASH_ReadByte((*parameters)[0]+0x4000));
1812  03a6 1e05          	ldw	x,(OFST+4,sp)
1813  03a8 cd0000        	call	c_ltor
1815  03ab ae0079        	ldw	x,#L27
1816  03ae cd0000        	call	c_ladd
1818  03b1 be02          	ldw	x,c_lreg+2
1819  03b3 89            	pushw	x
1820  03b4 be00          	ldw	x,c_lreg
1821  03b6 89            	pushw	x
1822  03b7 cd0000        	call	_FLASH_ReadByte
1824  03ba 5b04          	addw	sp,#4
1825  03bc b703          	ld	c_lreg+3,a
1826  03be 3f02          	clr	c_lreg+2
1827  03c0 3f01          	clr	c_lreg+1
1828  03c2 3f00          	clr	c_lreg
1829  03c4 be02          	ldw	x,c_lreg+2
1830  03c6 89            	pushw	x
1831  03c7 be00          	ldw	x,c_lreg
1832  03c9 89            	pushw	x
1833  03ca cd0054        	call	_Serial_print_u32
1835  03cd 5b04          	addw	sp,#4
1837  03cf acb304b3      	jpf	L736
1838  03d3               L756:
1839                     ; 140 			}else if(parameter_count==2)
1841  03d3 7b07          	ld	a,(OFST+6,sp)
1842  03d5 a102          	cp	a,#2
1843  03d7 2703          	jreq	L611
1844  03d9 cc04b3        	jp	L736
1845  03dc               L611:
1846                     ; 142 				if((*parameters)[1]<256)
1848  03dc 1e05          	ldw	x,(OFST+4,sp)
1849  03de 1c0004        	addw	x,#4
1850  03e1 cd0000        	call	c_ltor
1852  03e4 ae007d        	ldw	x,#L47
1853  03e7 cd0000        	call	c_lcmp
1855  03ea 2503          	jrult	L021
1856  03ec cc04b3        	jp	L736
1857  03ef               L021:
1858  03ef acb304b3      	jpf	L736
1859  03f3               L175:
1860                     ; 153 			is_valid=1;
1862  03f3 a601          	ld	a,#1
1863  03f5 6b01          	ld	(OFST+0,sp),a
1865                     ; 154 			if(parameter_count<3) is_valid=0;
1867  03f7 7b07          	ld	a,(OFST+6,sp)
1868  03f9 a103          	cp	a,#3
1869  03fb 2402          	jruge	L766
1872  03fd 0f01          	clr	(OFST+0,sp)
1874  03ff               L766:
1875                     ; 155 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
1877  03ff 1e05          	ldw	x,(OFST+4,sp)
1878  0401 cd0000        	call	c_ltor
1880  0404 ae0081        	ldw	x,#L67
1881  0407 cd0000        	call	c_lcmp
1883  040a 2502          	jrult	L176
1886  040c 0f01          	clr	(OFST+0,sp)
1888  040e               L176:
1889                     ; 156 			if((*parameters)[1]>=3) is_valid=0;
1891  040e 1e05          	ldw	x,(OFST+4,sp)
1892  0410 1c0004        	addw	x,#4
1893  0413 cd0000        	call	c_ltor
1895  0416 ae0085        	ldw	x,#L001
1896  0419 cd0000        	call	c_lcmp
1898  041c 2502          	jrult	L376
1901  041e 0f01          	clr	(OFST+0,sp)
1903  0420               L376:
1904                     ; 157 			if((*parameters)[2]>=255) is_valid=0;
1906  0420 1e05          	ldw	x,(OFST+4,sp)
1907  0422 1c0008        	addw	x,#8
1908  0425 cd0000        	call	c_ltor
1910  0428 ae0089        	ldw	x,#L201
1911  042b cd0000        	call	c_lcmp
1913  042e 2502          	jrult	L576
1916  0430 0f01          	clr	(OFST+0,sp)
1918  0432               L576:
1919                     ; 158 			if(is_valid)
1921  0432 0d01          	tnz	(OFST+0,sp)
1922  0434 2602          	jrne	L221
1923  0436 207b          	jp	L736
1924  0438               L221:
1925                     ; 160 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
1927  0438 1e05          	ldw	x,(OFST+4,sp)
1928  043a e60b          	ld	a,(11,x)
1929  043c 88            	push	a
1930  043d 1e06          	ldw	x,(OFST+5,sp)
1931  043f e607          	ld	a,(7,x)
1932  0441 97            	ld	xl,a
1933  0442 1606          	ldw	y,(OFST+5,sp)
1934  0444 90e603        	ld	a,(3,y)
1935  0447 95            	ld	xh,a
1936  0448 cd0000        	call	_set_rgb
1938  044b 84            	pop	a
1939                     ; 161 				flush_leds(2);//1 RGB led element and 1 for status led
1941  044c a602          	ld	a,#2
1942  044e cd0000        	call	_flush_leds
1944  0451 2060          	jra	L736
1945  0453               L375:
1946                     ; 165 			is_valid=1;
1948  0453 a601          	ld	a,#1
1949  0455 6b01          	ld	(OFST+0,sp),a
1951                     ; 166 			if(parameter_count<2) is_valid=0;
1953  0457 7b07          	ld	a,(OFST+6,sp)
1954  0459 a102          	cp	a,#2
1955  045b 2402          	jruge	L107
1958  045d 0f01          	clr	(OFST+0,sp)
1960  045f               L107:
1961                     ; 167 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
1963  045f 1e05          	ldw	x,(OFST+4,sp)
1964  0461 cd0000        	call	c_ltor
1966  0464 ae008d        	ldw	x,#L401
1967  0467 cd0000        	call	c_lcmp
1969  046a 2502          	jrult	L307
1972  046c 0f01          	clr	(OFST+0,sp)
1974  046e               L307:
1975                     ; 168 			if((*parameters)[1]>=255) is_valid=0;
1977  046e 1e05          	ldw	x,(OFST+4,sp)
1978  0470 1c0004        	addw	x,#4
1979  0473 cd0000        	call	c_ltor
1981  0476 ae0089        	ldw	x,#L201
1982  0479 cd0000        	call	c_lcmp
1984  047c 2502          	jrult	L507
1987  047e 0f01          	clr	(OFST+0,sp)
1989  0480               L507:
1990                     ; 169 			if(is_valid)
1992  0480 0d01          	tnz	(OFST+0,sp)
1993  0482 272f          	jreq	L736
1994                     ; 171 				set_white((*parameters)[0],(*parameters)[1]);
1996  0484 1e05          	ldw	x,(OFST+4,sp)
1997  0486 e607          	ld	a,(7,x)
1998  0488 97            	ld	xl,a
1999  0489 1605          	ldw	y,(OFST+4,sp)
2000  048b 90e603        	ld	a,(3,y)
2001  048e 95            	ld	xh,a
2002  048f cd0000        	call	_set_white
2004                     ; 172 				flush_leds(2);//1 RGB led element and 1 for status led
2006  0492 a602          	ld	a,#2
2007  0494 cd0000        	call	_flush_leds
2009  0497 201a          	jra	L736
2010  0499               L575:
2011                     ; 176 			Serial_print_u32(get_audio_level());
2013  0499 cd0000        	call	_get_audio_level
2015  049c b703          	ld	c_lreg+3,a
2016  049e 3f02          	clr	c_lreg+2
2017  04a0 3f01          	clr	c_lreg+1
2018  04a2 3f00          	clr	c_lreg
2019  04a4 be02          	ldw	x,c_lreg+2
2020  04a6 89            	pushw	x
2021  04a7 be00          	ldw	x,c_lreg
2022  04a9 89            	pushw	x
2023  04aa cd0054        	call	_Serial_print_u32
2025  04ad 5b04          	addw	sp,#4
2026                     ; 177 			is_valid=1;
2028  04af a601          	ld	a,#1
2029  04b1 6b01          	ld	(OFST+0,sp),a
2031                     ; 178 		}break;
2033  04b3               L736:
2034                     ; 180 	if(!is_valid) Serial_print_string("Invalid. h");
2036  04b3 0d01          	tnz	(OFST+0,sp)
2037  04b5 2606          	jrne	L117
2040  04b7 ae0091        	ldw	x,#L317
2041  04ba cd010d        	call	_Serial_print_string
2043  04bd               L117:
2044                     ; 181 	Serial_newline();
2046  04bd cd00fe        	call	_Serial_newline
2048                     ; 182 }
2051  04c0 85            	popw	x
2052  04c1 81            	ret
2065                     	xdef	_Serial_print_u32
2066                     	xdef	_Serial_read_char
2067                     	xdef	_Serial_available
2068                     	xdef	_Serial_newline
2069                     	xdef	_Serial_print_string
2070                     	xdef	_Serial_print_char
2071                     	xdef	_Serial_print_int
2072                     	xdef	_Serial_begin
2073                     	xdef	_print_welcome
2074                     	xdef	_execute_terminal_command
2075                     	xdef	_get_terminal_command
2076                     	xdef	_run_developer
2077                     	xdef	_setup_developer
2078                     	xref	_set_millis
2079                     	xref	_get_audio_level
2080                     	xref	_is_space_sao
2081                     	xref	_clear_button_events
2082                     	xref	_is_developer_valid
2083                     	xref	_flush_leds
2084                     	xref	_set_debug
2085                     	xref	_set_white
2086                     	xref	_set_rgb
2087                     	xref	_millis
2088                     	xref	_setup_serial
2089                     	xref	_UART1_ClearFlag
2090                     	xref	_UART1_GetFlagStatus
2091                     	xref	_UART1_SendData8
2092                     	xref	_UART1_ReceiveData8
2093                     	xref	_UART1_Cmd
2094                     	xref	_UART1_Init
2095                     	xref	_UART1_DeInit
2096                     	xref	_GPIO_Init
2097                     	xref	_FLASH_ReadByte
2098                     	switch	.const
2099  0091               L317:
2100  0091 496e76616c69  	dc.b	"Invalid. h",0
2101  009c               L556:
2102  009c 476974487562  	dc.b	"GitHub.com/ScottAl"
2103  00ae 6d6f6e642f44  	dc.b	"mond/DefCon_31",0
2104  00bd               L563:
2105  00bd 3e2000        	dc.b	"> ",0
2106  00c0               L711:
2107  00c0 307800        	dc.b	"0x",0
2108                     	xref.b	c_lreg
2109                     	xref.b	c_x
2110                     	xref.b	c_y
2130                     	xref	c_lcmp
2131                     	xref	c_ladd
2132                     	xref	c_rtol
2133                     	xref	c_itolx
2134                     	xref	c_llsh
2135                     	xref	c_sdivx
2136                     	xref	c_smody
2137                     	xref	c_smodx
2138                     	xref	c_xymov
2139                     	xref	c_lursh
2140                     	xref	c_ltor
2141                     	end
