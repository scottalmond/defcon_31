   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  48                     ; 6 void setup_developer()
  48                     ; 7 {
  50                     	switch	.text
  51  0000               _setup_developer:
  55                     ; 8 	setup_serial(1,1);//enabled at high speed
  57  0000 ae0101        	ldw	x,#257
  58  0003 cd0000        	call	_setup_serial
  60                     ; 9 	clear_button_events();
  62  0006 cd0000        	call	_clear_button_events
  64                     ; 10 	flush_leds(0);//clear outstanding led buffer
  66  0009 4f            	clr	a
  67  000a cd0000        	call	_flush_leds
  69                     ; 14 		set_debug(255);//show only one debug led ON
  71  000d a6ff          	ld	a,#255
  72  000f cd0000        	call	_set_debug
  74                     ; 16 	flush_leds(1);
  76  0012 a601          	ld	a,#1
  77  0014 cd0000        	call	_flush_leds
  79                     ; 17 	Serial_newline();
  81  0017 cd0000        	call	_Serial_newline
  83                     ; 18 	print_ascii_art(1);
  85  001a a601          	ld	a,#1
  86  001c ad50          	call	_print_ascii_art
  88                     ; 19 }
  91  001e 81            	ret
 151                     ; 21 void run_developer()
 151                     ; 22 {
 152                     	switch	.text
 153  001f               _run_developer:
 155  001f 520e          	subw	sp,#14
 156       0000000e      OFST:	set	14
 159                     ; 26 	setup_developer();
 161  0021 addd          	call	_setup_developer
 164  0023 2031          	jra	L15
 165  0025               L74:
 166                     ; 29 		Serial_print_string("> ");
 168  0025 ae0100        	ldw	x,#L55
 169  0028 cd0000        	call	_Serial_print_string
 171                     ; 30 		get_terminal_command(&command,&parameters,&parameter_count);
 173  002b 96            	ldw	x,sp
 174  002c 1c0002        	addw	x,#OFST-12
 175  002f 89            	pushw	x
 176  0030 96            	ldw	x,sp
 177  0031 1c0005        	addw	x,#OFST-9
 178  0034 89            	pushw	x
 179  0035 96            	ldw	x,sp
 180  0036 1c0005        	addw	x,#OFST-9
 181  0039 cd0119        	call	_get_terminal_command
 183  003c 5b04          	addw	sp,#4
 184                     ; 34 			set_debug(255);//show only one debug led ON
 186  003e a6ff          	ld	a,#255
 187  0040 cd0000        	call	_set_debug
 189                     ; 36 		execute_terminal_command(&command,&parameters,&parameter_count);
 191  0043 96            	ldw	x,sp
 192  0044 1c0002        	addw	x,#OFST-12
 193  0047 89            	pushw	x
 194  0048 96            	ldw	x,sp
 195  0049 1c0005        	addw	x,#OFST-9
 196  004c 89            	pushw	x
 197  004d 96            	ldw	x,sp
 198  004e 1c0005        	addw	x,#OFST-9
 199  0051 cd0285        	call	_execute_terminal_command
 201  0054 5b04          	addw	sp,#4
 202  0056               L15:
 203                     ; 27 	while(is_developer_valid())
 205  0056 cd0000        	call	_is_developer_valid
 207  0059 4d            	tnz	a
 208  005a 26c9          	jrne	L74
 209                     ; 38 	Serial_print_string("Exiting Terminal\n");
 211  005c ae00ee        	ldw	x,#L75
 212  005f cd0000        	call	_Serial_print_string
 214                     ; 39 	flush_leds(0);//turn off debug led
 216  0062 4f            	clr	a
 217  0063 cd0000        	call	_flush_leds
 219                     ; 40 	flush_leds(1);//turn off debug led
 221  0066 a601          	ld	a,#1
 222  0068 cd0000        	call	_flush_leds
 224                     ; 41 }
 227  006b 5b0e          	addw	sp,#14
 228  006d 81            	ret
 231                     .const:	section	.text
 232  0000               L16_welcome:
 233  0000 79            	dc.b	121
 234  0001 f0            	dc.b	240
 235  0002 c3            	dc.b	195
 236  0003 cf            	dc.b	207
 237  0004 df            	dc.b	223
 238  0005 2f            	dc.b	47
 239  0006 9e            	dc.b	158
 240  0007 7c            	dc.b	124
 241  0008 84            	dc.b	132
 242  0009 f0            	dc.b	240
 243  000a 81            	dc.b	129
 244  000b 09            	dc.b	9
 245  000c 24            	dc.b	36
 246  000d 28            	dc.b	40
 247  000e 10            	dc.b	16
 248  000f a2            	dc.b	162
 249  0010 20            	dc.b	32
 250  0011 42            	dc.b	66
 251  0012 85            	dc.b	133
 252  0013 00            	dc.b	0
 253  0014 79            	dc.b	121
 254  0015 0a            	dc.b	10
 255  0016 14            	dc.b	20
 256  0017 0f            	dc.b	15
 257  0018 9f            	dc.b	159
 258  0019 22            	dc.b	34
 259  001a 1e            	dc.b	30
 260  001b 42            	dc.b	66
 261  001c 84            	dc.b	132
 262  001d f0            	dc.b	240
 263  001e 05            	dc.b	5
 264  001f f3            	dc.b	243
 265  0020 f4            	dc.b	244
 266  0021 08            	dc.b	8
 267  0022 10            	dc.b	16
 268  0023 a2            	dc.b	162
 269  0024 01            	dc.b	1
 270  0025 7c            	dc.b	124
 271  0026 84            	dc.b	132
 272  0027 08            	dc.b	8
 273  0028 85            	dc.b	133
 274  0029 02            	dc.b	2
 275  002a 14            	dc.b	20
 276  002b 28            	dc.b	40
 277  002c 10            	dc.b	16
 278  002d a2            	dc.b	162
 279  002e 21            	dc.b	33
 280  002f 44            	dc.b	68
 281  0030 85            	dc.b	133
 282  0031 08            	dc.b	8
 283  0032 79            	dc.b	121
 284  0033 02            	dc.b	2
 285  0034 13            	dc.b	19
 286  0035 cf            	dc.b	207
 287  0036 df            	dc.b	223
 288  0037 22            	dc.b	34
 289  0038 1e            	dc.b	30
 290  0039 42            	dc.b	66
 291  003a 78            	dc.b	120
 292  003b f0            	dc.b	240
 293  003c               L36_winner:
 294  003c 82            	dc.b	130
 295  003d e8            	dc.b	232
 296  003e 28            	dc.b	40
 297  003f 2f            	dc.b	47
 298  0040 ef            	dc.b	239
 299  0041 c0            	dc.b	192
 300  0042 92            	dc.b	146
 301  0043 4c            	dc.b	76
 302  0044 2c            	dc.b	44
 303  0045 28            	dc.b	40
 304  0046 08            	dc.b	8
 305  0047 20            	dc.b	32
 306  0048 92            	dc.b	146
 307  0049 4a            	dc.b	74
 308  004a 2a            	dc.b	42
 309  004b 28            	dc.b	40
 310  004c 08            	dc.b	8
 311  004d 20            	dc.b	32
 312  004e 92            	dc.b	146
 313  004f 49            	dc.b	73
 314  0050 29            	dc.b	41
 315  0051 2f            	dc.b	47
 316  0052 8f            	dc.b	143
 317  0053 c0            	dc.b	192
 318  0054 92            	dc.b	146
 319  0055 48            	dc.b	72
 320  0056 a8            	dc.b	168
 321  0057 a8            	dc.b	168
 322  0058 08            	dc.b	8
 323  0059 80            	dc.b	128
 324  005a 92            	dc.b	146
 325  005b 48            	dc.b	72
 326  005c 68            	dc.b	104
 327  005d 68            	dc.b	104
 328  005e 08            	dc.b	8
 329  005f 40            	dc.b	64
 330  0060 6c            	dc.b	108
 331  0061 e8            	dc.b	232
 332  0062 28            	dc.b	40
 333  0063 2f            	dc.b	47
 334  0064 e8            	dc.b	232
 335  0065 20            	dc.b	32
 446                     ; 44 void print_ascii_art(bool is_welcome)
 446                     ; 45 {
 447                     	switch	.text
 448  006e               _print_ascii_art:
 450  006e 88            	push	a
 451  006f 526a          	subw	sp,#106
 452       0000006a      OFST:	set	106
 455                     ; 46 	u8 welcome[] = {
 455                     ; 47 		#if IS_SPACE_SAO
 455                     ; 48 											0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,
 455                     ; 49 											0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,
 455                     ; 50 											0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,
 455                     ; 51 											0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,
 455                     ; 52 											0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,
 455                     ; 53 											0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,
 455                     ; 54 											0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,
 455                     ; 55 											0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,
 455                     ; 56 											0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,
 455                     ; 57 											0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000
 455                     ; 58 		#else
 455                     ; 59 											0b01111110,0b01111111,0b01111111,0b00111110,0b01111111,0b01000001,
 455                     ; 60 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000001,
 455                     ; 61 											0b01000001,0b01100001,0b01000001,0b0011000,0b01000001,0b01000000,
 455                     ; 62 											0b01000000,0b01000000,0b01000001,0b01010001,0b00000001,0b0101000,
 455                     ; 63 											0b01000001,0b01111100,0b01111100,0b01000000,0b01000001,0b01001001,//last bit messed up?
 455                     ; 64 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000000,//mis-typed bit?
 455                     ; 65 											0b01000001,0b01000101,0b00000001,0b0001000,0b01000001,0b01000000,
 455                     ; 66 											0b01000000,0b01000001,0b01000001,0b01000011,0b01000001,0b0001000,
 455                     ; 67 											0b01111110,0b01111111,0b01000000,0b00111110,0b01111111,0b01000001,
 455                     ; 68 											0b00111110,0b0111110
 455                     ; 69 		#endif
 455                     ; 70 		};
 457  0071 96            	ldw	x,sp
 458  0072 1c0002        	addw	x,#OFST-104
 459  0075 90ae0000      	ldw	y,#L16_welcome
 460  0079 a63c          	ld	a,#60
 461  007b cd0000        	call	c_xymov
 463                     ; 71 	u8 winner[] = {     0b10000010,0b11101000,0b00101000,0b00101111,0b11101111,0b11000000,
 463                     ; 72 											0b10010010,0b01001100,0b00101100,0b00101000,0b00001000,0b00100000,
 463                     ; 73 											0b10010010,0b01001010,0b00101010,0b00101000,0b00001000,0b00100000,
 463                     ; 74 											0b10010010,0b01001001,0b00101001,0b00101111,0b10001111,0b11000000,
 463                     ; 75 											0b10010010,0b01001000,0b10101000,0b10101000,0b00001000,0b10000000,
 463                     ; 76 											0b10010010,0b01001000,0b01101000,0b01101000,0b00001000,0b01000000,
 463                     ; 77 											0b01101100,0b11101000,0b00101000,0b00101111,0b11101000,0b00100000 };
 465  007e 96            	ldw	x,sp
 466  007f 1c003e        	addw	x,#OFST-44
 467  0082 90ae003c      	ldw	y,#L36_winner
 468  0086 a62a          	ld	a,#42
 469  0088 cd0000        	call	c_xymov
 471                     ; 78 	u8 length = is_welcome?sizeof(welcome):sizeof(winner);
 473  008b 0d6b          	tnz	(OFST+1,sp)
 474  008d 2704          	jreq	L21
 475  008f a63c          	ld	a,#60
 476  0091 2002          	jra	L41
 477  0093               L21:
 478  0093 a62a          	ld	a,#42
 479  0095               L41:
 480  0095 6b01          	ld	(OFST-105,sp),a
 482                     ; 79 	u8 lineBreakInterval = is_welcome?
 482                     ; 80 		#if IS_SPACE_SAO
 482                     ; 81 			10
 482                     ; 82 		#else
 482                     ; 83 			8
 482                     ; 84 		#endif
 482                     ; 85 			:6;
 484  0097 0d6b          	tnz	(OFST+1,sp)
 485  0099 2704          	jreq	L61
 486  009b a60a          	ld	a,#10
 487  009d 2002          	jra	L02
 488  009f               L61:
 489  009f a606          	ld	a,#6
 490  00a1               L02:
 491  00a1 6b68          	ld	(OFST-2,sp),a
 493                     ; 87 	for (i = 0; i < length; i++) {
 495  00a3 0f6a          	clr	(OFST+0,sp)
 498  00a5 2069          	jra	L741
 499  00a7               L341:
 500                     ; 88 		for (j = 7; j !=0xFF; j--) {
 502  00a7 a607          	ld	a,#7
 503  00a9 6b69          	ld	(OFST-1,sp),a
 505  00ab               L351:
 506                     ; 90 			Serial_print_char((( (is_welcome?welcome[i]:winner[i]) >> j)  & 0x01) ? '#' : ' ');
 508  00ab 0d6b          	tnz	(OFST+1,sp)
 509  00ad 2711          	jreq	L42
 510  00af 96            	ldw	x,sp
 511  00b0 1c0002        	addw	x,#OFST-104
 512  00b3 9f            	ld	a,xl
 513  00b4 5e            	swapw	x
 514  00b5 1b6a          	add	a,(OFST+0,sp)
 515  00b7 2401          	jrnc	L62
 516  00b9 5c            	incw	x
 517  00ba               L62:
 518  00ba 02            	rlwa	x,a
 519  00bb f6            	ld	a,(x)
 520  00bc 5f            	clrw	x
 521  00bd 97            	ld	xl,a
 522  00be 200f          	jra	L03
 523  00c0               L42:
 524  00c0 96            	ldw	x,sp
 525  00c1 1c003e        	addw	x,#OFST-44
 526  00c4 9f            	ld	a,xl
 527  00c5 5e            	swapw	x
 528  00c6 1b6a          	add	a,(OFST+0,sp)
 529  00c8 2401          	jrnc	L23
 530  00ca 5c            	incw	x
 531  00cb               L23:
 532  00cb 02            	rlwa	x,a
 533  00cc f6            	ld	a,(x)
 534  00cd 5f            	clrw	x
 535  00ce 97            	ld	xl,a
 536  00cf               L03:
 537  00cf 7b69          	ld	a,(OFST-1,sp)
 538  00d1 4d            	tnz	a
 539  00d2 2704          	jreq	L43
 540  00d4               L63:
 541  00d4 57            	sraw	x
 542  00d5 4a            	dec	a
 543  00d6 26fc          	jrne	L63
 544  00d8               L43:
 545  00d8 01            	rrwa	x,a
 546  00d9 a501          	bcp	a,#1
 547  00db 2704          	jreq	L22
 548  00dd a623          	ld	a,#35
 549  00df 2002          	jra	L04
 550  00e1               L22:
 551  00e1 a620          	ld	a,#32
 552  00e3               L04:
 553  00e3 cd0000        	call	_Serial_print_char
 555                     ; 88 		for (j = 7; j !=0xFF; j--) {
 557  00e6 0a69          	dec	(OFST-1,sp)
 561  00e8 7b69          	ld	a,(OFST-1,sp)
 562  00ea a1ff          	cp	a,#255
 563  00ec 26bd          	jrne	L351
 564                     ; 92 		if ((i % lineBreakInterval) == (lineBreakInterval-1)) {
 566  00ee 7b6a          	ld	a,(OFST+0,sp)
 567  00f0 5f            	clrw	x
 568  00f1 97            	ld	xl,a
 569  00f2 7b68          	ld	a,(OFST-2,sp)
 570  00f4 905f          	clrw	y
 571  00f6 9097          	ld	yl,a
 572  00f8 cd0000        	call	c_idiv
 574  00fb 51            	exgw	x,y
 575  00fc 7b68          	ld	a,(OFST-2,sp)
 576  00fe 905f          	clrw	y
 577  0100 9097          	ld	yl,a
 578  0102 905a          	decw	y
 579  0104 90bf00        	ldw	c_y,y
 580  0107 b300          	cpw	x,c_y
 581  0109 2603          	jrne	L161
 582                     ; 94 			Serial_newline();
 584  010b cd0000        	call	_Serial_newline
 586  010e               L161:
 587                     ; 87 	for (i = 0; i < length; i++) {
 589  010e 0c6a          	inc	(OFST+0,sp)
 591  0110               L741:
 594  0110 7b6a          	ld	a,(OFST+0,sp)
 595  0112 1101          	cp	a,(OFST-105,sp)
 596  0114 2591          	jrult	L341
 597                     ; 97 }
 600  0116 5b6b          	addw	sp,#107
 601  0118 81            	ret
 727                     ; 99 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 727                     ; 100 {
 728                     	switch	.text
 729  0119               _get_terminal_command:
 731  0119 89            	pushw	x
 732  011a 522e          	subw	sp,#46
 733       0000002e      OFST:	set	46
 736                     ; 101 	bool is_new_line=0;
 738                     ; 102 	bool is_any_input=0;//set to true after new input received, including a value of '0'
 740                     ; 104 	u8 new_input_index=0;
 742                     ; 106 	u8 str_index=0,iter;
 744  011c 0f2e          	clr	(OFST+0,sp)
 747  011e aca601a6      	jpf	L152
 748  0122               L542:
 749                     ; 109 		if(Serial_available())
 751  0122 cd0000        	call	_Serial_available
 753  0125 4d            	tnz	a
 754  0126 2602          	jrne	L46
 755  0128 207c          	jp	L152
 756  012a               L46:
 757                     ; 111 			input_char=Serial_read_char(0);
 759  012a 4f            	clr	a
 760  012b cd0000        	call	_Serial_read_char
 762  012e 6b2d          	ld	(OFST-1,sp),a
 764                     ; 112 			if(str_index==0)
 766  0130 0d2e          	tnz	(OFST+0,sp)
 767  0132 260e          	jrne	L752
 768                     ; 114 				str[0]=input_char;
 770  0134 7b2d          	ld	a,(OFST-1,sp)
 771  0136 6b08          	ld	(OFST-38,sp),a
 773                     ; 115 				str_index++;
 775  0138 0c2e          	inc	(OFST+0,sp)
 777                     ; 116 				if(input_char=='\n') break;
 779  013a 7b2d          	ld	a,(OFST-1,sp)
 780  013c a10a          	cp	a,#10
 781  013e 2666          	jrne	L152
 784  0140 2073          	jra	L352
 785  0142               L752:
 786                     ; 118 				if(input_char>='0' && input_char<='9')
 788  0142 7b2d          	ld	a,(OFST-1,sp)
 789  0144 a130          	cp	a,#48
 790  0146 2525          	jrult	L562
 792  0148 7b2d          	ld	a,(OFST-1,sp)
 793  014a a13a          	cp	a,#58
 794  014c 241f          	jruge	L562
 795                     ; 120 					if(str_index==1)
 797  014e 7b2e          	ld	a,(OFST+0,sp)
 798  0150 a101          	cp	a,#1
 799  0152 2606          	jrne	L762
 800                     ; 122 						str[1]=' ';
 802  0154 a620          	ld	a,#32
 803  0156 6b09          	ld	(OFST-37,sp),a
 805                     ; 123 						str_index++;
 807  0158 0c2e          	inc	(OFST+0,sp)
 809  015a               L762:
 810                     ; 125 					str[str_index]=input_char;
 812  015a 96            	ldw	x,sp
 813  015b 1c0008        	addw	x,#OFST-38
 814  015e 9f            	ld	a,xl
 815  015f 5e            	swapw	x
 816  0160 1b2e          	add	a,(OFST+0,sp)
 817  0162 2401          	jrnc	L44
 818  0164 5c            	incw	x
 819  0165               L44:
 820  0165 02            	rlwa	x,a
 821  0166 7b2d          	ld	a,(OFST-1,sp)
 822  0168 f7            	ld	(x),a
 823                     ; 126 					str_index++;
 825  0169 0c2e          	inc	(OFST+0,sp)
 828  016b 2039          	jra	L152
 829  016d               L562:
 830                     ; 128 					if(input_char=='\n')
 832  016d 7b2d          	ld	a,(OFST-1,sp)
 833  016f a10a          	cp	a,#10
 834  0171 260f          	jrne	L372
 835                     ; 130 						str[str_index]='\0';
 837  0173 96            	ldw	x,sp
 838  0174 1c0008        	addw	x,#OFST-38
 839  0177 9f            	ld	a,xl
 840  0178 5e            	swapw	x
 841  0179 1b2e          	add	a,(OFST+0,sp)
 842  017b 2401          	jrnc	L64
 843  017d 5c            	incw	x
 844  017e               L64:
 845  017e 02            	rlwa	x,a
 846  017f 7f            	clr	(x)
 847                     ; 131 						break;
 849  0180 2033          	jra	L352
 850  0182               L372:
 851                     ; 133 					if(str[str_index-1]!=' ')
 853  0182 96            	ldw	x,sp
 854  0183 1c0008        	addw	x,#OFST-38
 855  0186 1f03          	ldw	(OFST-43,sp),x
 857  0188 7b2e          	ld	a,(OFST+0,sp)
 858  018a 5f            	clrw	x
 859  018b 97            	ld	xl,a
 860  018c 5a            	decw	x
 861  018d 72fb03        	addw	x,(OFST-43,sp)
 862  0190 f6            	ld	a,(x)
 863  0191 a120          	cp	a,#32
 864  0193 2711          	jreq	L152
 865                     ; 135 						str[str_index]=' ';
 867  0195 96            	ldw	x,sp
 868  0196 1c0008        	addw	x,#OFST-38
 869  0199 9f            	ld	a,xl
 870  019a 5e            	swapw	x
 871  019b 1b2e          	add	a,(OFST+0,sp)
 872  019d 2401          	jrnc	L05
 873  019f 5c            	incw	x
 874  01a0               L05:
 875  01a0 02            	rlwa	x,a
 876  01a1 a620          	ld	a,#32
 877  01a3 f7            	ld	(x),a
 878                     ; 136 						str_index++;
 880  01a4 0c2e          	inc	(OFST+0,sp)
 882  01a6               L152:
 883                     ; 107 	while(is_developer_valid()&&str_index<sizeof(str))
 885  01a6 cd0000        	call	_is_developer_valid
 887  01a9 4d            	tnz	a
 888  01aa 2709          	jreq	L352
 890  01ac 7b2e          	ld	a,(OFST+0,sp)
 891  01ae a125          	cp	a,#37
 892  01b0 2403          	jruge	L66
 893  01b2 cc0122        	jp	L542
 894  01b5               L66:
 895  01b5               L352:
 896                     ; 148 	*command=str[0];
 898  01b5 7b08          	ld	a,(OFST-38,sp)
 899  01b7 1e2f          	ldw	x,(OFST+1,sp)
 900  01b9 f7            	ld	(x),a
 901                     ; 149 	str[0]=0;
 903  01ba 0f08          	clr	(OFST-38,sp)
 905                     ; 150 	*parameter_count=0;
 907  01bc 1e35          	ldw	x,(OFST+7,sp)
 908  01be 7f            	clr	(x)
 909                     ; 151 	for(iter=1;iter<str_index;iter++)
 911  01bf a601          	ld	a,#1
 912  01c1 6b2d          	ld	(OFST-1,sp),a
 915  01c3 ac680268      	jpf	L503
 916  01c7               L103:
 917                     ; 153 		new_input_index=(*parameter_count-1)%MAX_TERMINAL_PARAMETERS;
 919  01c7 1e35          	ldw	x,(OFST+7,sp)
 920  01c9 f6            	ld	a,(x)
 921  01ca 5f            	clrw	x
 922  01cb 97            	ld	xl,a
 923  01cc 5a            	decw	x
 924  01cd a603          	ld	a,#3
 925  01cf cd0000        	call	c_smodx
 927  01d2 01            	rrwa	x,a
 928  01d3 6b07          	ld	(OFST-39,sp),a
 929  01d5 02            	rlwa	x,a
 931                     ; 154 		if(str[iter]==' ')
 933  01d6 96            	ldw	x,sp
 934  01d7 1c0008        	addw	x,#OFST-38
 935  01da 9f            	ld	a,xl
 936  01db 5e            	swapw	x
 937  01dc 1b2d          	add	a,(OFST-1,sp)
 938  01de 2401          	jrnc	L25
 939  01e0 5c            	incw	x
 940  01e1               L25:
 941  01e1 02            	rlwa	x,a
 942  01e2 f6            	ld	a,(x)
 943  01e3 a120          	cp	a,#32
 944  01e5 261e          	jrne	L113
 945                     ; 156 			(*parameters)[*parameter_count]=0;
 947  01e7 1e35          	ldw	x,(OFST+7,sp)
 948  01e9 f6            	ld	a,(x)
 949  01ea 97            	ld	xl,a
 950  01eb a604          	ld	a,#4
 951  01ed 42            	mul	x,a
 952  01ee 72fb33        	addw	x,(OFST+5,sp)
 953  01f1 a600          	ld	a,#0
 954  01f3 e703          	ld	(3,x),a
 955  01f5 a600          	ld	a,#0
 956  01f7 e702          	ld	(2,x),a
 957  01f9 a600          	ld	a,#0
 958  01fb e701          	ld	(1,x),a
 959  01fd a600          	ld	a,#0
 960  01ff f7            	ld	(x),a
 961                     ; 157 			(*parameter_count)++;
 963  0200 1e35          	ldw	x,(OFST+7,sp)
 964  0202 7c            	inc	(x)
 966  0203 2054          	jra	L313
 967  0205               L113:
 968                     ; 161 			(*parameters)[new_input_index]=(((*parameters)[new_input_index])<<3)+(((*parameters)[new_input_index])<<1)+str[iter]-'0';
 970  0205 7b07          	ld	a,(OFST-39,sp)
 971  0207 97            	ld	xl,a
 972  0208 a604          	ld	a,#4
 973  020a 42            	mul	x,a
 974  020b 72fb33        	addw	x,(OFST+5,sp)
 975  020e cd0000        	call	c_ltor
 977  0211 3803          	sll	c_lreg+3
 978  0213 3902          	rlc	c_lreg+2
 979  0215 3901          	rlc	c_lreg+1
 980  0217 3900          	rlc	c_lreg
 981  0219 96            	ldw	x,sp
 982  021a 1c0001        	addw	x,#OFST-45
 983  021d cd0000        	call	c_rtol
 986  0220 7b07          	ld	a,(OFST-39,sp)
 987  0222 97            	ld	xl,a
 988  0223 a604          	ld	a,#4
 989  0225 42            	mul	x,a
 990  0226 72fb33        	addw	x,(OFST+5,sp)
 991  0229 cd0000        	call	c_ltor
 993  022c a603          	ld	a,#3
 994  022e cd0000        	call	c_llsh
 996  0231 96            	ldw	x,sp
 997  0232 1c0001        	addw	x,#OFST-45
 998  0235 cd0000        	call	c_ladd
1000  0238 96            	ldw	x,sp
1001  0239 1c0008        	addw	x,#OFST-38
1002  023c 9f            	ld	a,xl
1003  023d 5e            	swapw	x
1004  023e 1b2d          	add	a,(OFST-1,sp)
1005  0240 2401          	jrnc	L45
1006  0242 5c            	incw	x
1007  0243               L45:
1008  0243 02            	rlwa	x,a
1009  0244 f6            	ld	a,(x)
1010  0245 cd0000        	call	c_ladc
1012  0248 a630          	ld	a,#48
1013  024a cd0000        	call	c_lsbc
1015  024d 7b07          	ld	a,(OFST-39,sp)
1016  024f 97            	ld	xl,a
1017  0250 a604          	ld	a,#4
1018  0252 42            	mul	x,a
1019  0253 72fb33        	addw	x,(OFST+5,sp)
1020  0256 cd0000        	call	c_rtol
1022  0259               L313:
1023                     ; 163 		str[iter]=0;
1025  0259 96            	ldw	x,sp
1026  025a 1c0008        	addw	x,#OFST-38
1027  025d 9f            	ld	a,xl
1028  025e 5e            	swapw	x
1029  025f 1b2d          	add	a,(OFST-1,sp)
1030  0261 2401          	jrnc	L65
1031  0263 5c            	incw	x
1032  0264               L65:
1033  0264 02            	rlwa	x,a
1034  0265 7f            	clr	(x)
1035                     ; 151 	for(iter=1;iter<str_index;iter++)
1037  0266 0c2d          	inc	(OFST-1,sp)
1039  0268               L503:
1042  0268 7b2d          	ld	a,(OFST-1,sp)
1043  026a 112e          	cp	a,(OFST+0,sp)
1044  026c 2403          	jruge	L07
1045  026e cc01c7        	jp	L103
1046  0271               L07:
1047                     ; 165 	*parameter_count=(*parameter_count)>MAX_TERMINAL_PARAMETERS?MAX_TERMINAL_PARAMETERS:*parameter_count;
1049  0271 1e35          	ldw	x,(OFST+7,sp)
1050  0273 f6            	ld	a,(x)
1051  0274 a104          	cp	a,#4
1052  0276 2504          	jrult	L06
1053  0278 a603          	ld	a,#3
1054  027a 2003          	jra	L26
1055  027c               L06:
1056  027c 1e35          	ldw	x,(OFST+7,sp)
1057  027e f6            	ld	a,(x)
1058  027f               L26:
1059  027f 1e35          	ldw	x,(OFST+7,sp)
1060  0281 f7            	ld	(x),a
1061                     ; 166 }
1064  0282 5b30          	addw	sp,#48
1065  0284 81            	ret
1162                     	switch	.const
1163  0066               L47:
1164  0066 0000000a      	dc.l	10
1165  006a               L67:
1166  006a 00000003      	dc.l	3
1167  006e               L001:
1168  006e 00000100      	dc.l	256
1169  0072               L201:
1170  0072 0000000c      	dc.l	12
1171                     ; 168 void execute_terminal_command(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
1171                     ; 169 {
1172                     	switch	.text
1173  0285               _execute_terminal_command:
1175  0285 89            	pushw	x
1176  0286 89            	pushw	x
1177       00000002      OFST:	set	2
1180                     ; 171 	bool is_valid=0,is_command_exist=1;
1182  0287 0f02          	clr	(OFST+0,sp)
1186  0289 a601          	ld	a,#1
1187  028b 6b01          	ld	(OFST-1,sp),a
1189                     ; 172 	switch(*command)
1191  028d f6            	ld	a,(x)
1193                     ; 230 		default:{ is_command_exist=0; } break;
1194  028e a00a          	sub	a,#10
1195  0290 2603          	jrne	L401
1196  0292 cc0330        	jp	L123
1197  0295               L401:
1198  0295 a027          	sub	a,#39
1199  0297 2603          	jrne	L601
1200  0299 cc033e        	jp	L323
1201  029c               L601:
1202  029c a00e          	sub	a,#14
1203  029e 2603          	jrne	L011
1204  02a0 cc0330        	jp	L123
1205  02a3               L011:
1206  02a3 a022          	sub	a,#34
1207  02a5 2603          	jrne	L211
1208  02a7 cc0419        	jp	L723
1209  02aa               L211:
1210  02aa a006          	sub	a,#6
1211  02ac 2603          	jrne	L411
1212  02ae cc0435        	jp	L133
1213  02b1               L411:
1214  02b1 4a            	dec	a
1215  02b2 277c          	jreq	L123
1216  02b4 a004          	sub	a,#4
1217  02b6 2603          	jrne	L611
1218  02b8 cc033e        	jp	L323
1219  02bb               L611:
1220  02bb a004          	sub	a,#4
1221  02bd 2711          	jreq	L513
1222  02bf a004          	sub	a,#4
1223  02c1 2743          	jreq	L713
1224  02c3 a003          	sub	a,#3
1225  02c5 2603          	jrne	L021
1226  02c7 cc03bb        	jp	L523
1227  02ca               L021:
1228  02ca               L333:
1231  02ca 0f01          	clr	(OFST-1,sp)
1235  02cc ac450445      	jpf	L104
1236  02d0               L513:
1237                     ; 175 			Serial_print_char(*command);
1239  02d0 1e03          	ldw	x,(OFST+1,sp)
1240  02d2 f6            	ld	a,(x)
1241  02d3 cd0000        	call	_Serial_print_char
1243                     ; 176 			for(iter=0;iter<*parameter_count;iter++)
1245  02d6 0f02          	clr	(OFST+0,sp)
1248  02d8 201d          	jra	L704
1249  02da               L304:
1250                     ; 178 				Serial_print_char(' ');
1252  02da a620          	ld	a,#32
1253  02dc cd0000        	call	_Serial_print_char
1255                     ; 179 				Serial_print_u32((*parameters)[iter]);
1257  02df 7b02          	ld	a,(OFST+0,sp)
1258  02e1 97            	ld	xl,a
1259  02e2 a604          	ld	a,#4
1260  02e4 42            	mul	x,a
1261  02e5 72fb07        	addw	x,(OFST+5,sp)
1262  02e8 9093          	ldw	y,x
1263  02ea ee02          	ldw	x,(2,x)
1264  02ec 89            	pushw	x
1265  02ed 93            	ldw	x,y
1266  02ee fe            	ldw	x,(x)
1267  02ef 89            	pushw	x
1268  02f0 cd0000        	call	_Serial_print_u32
1270  02f3 5b04          	addw	sp,#4
1271                     ; 176 			for(iter=0;iter<*parameter_count;iter++)
1273  02f5 0c02          	inc	(OFST+0,sp)
1275  02f7               L704:
1278  02f7 1e09          	ldw	x,(OFST+7,sp)
1279  02f9 f6            	ld	a,(x)
1280  02fa 1102          	cp	a,(OFST+0,sp)
1281  02fc 22dc          	jrugt	L304
1282                     ; 181 			is_valid=1;
1284  02fe a601          	ld	a,#1
1285  0300 6b02          	ld	(OFST+0,sp),a
1287                     ; 182 		}break;
1289  0302 ac450445      	jpf	L104
1290  0306               L713:
1291                     ; 184 			if(*parameter_count) set_millis((*parameters)[0]);
1293  0306 1e09          	ldw	x,(OFST+7,sp)
1294  0308 7d            	tnz	(x)
1295  0309 270f          	jreq	L314
1298  030b 1e07          	ldw	x,(OFST+5,sp)
1299  030d 9093          	ldw	y,x
1300  030f ee02          	ldw	x,(2,x)
1301  0311 89            	pushw	x
1302  0312 93            	ldw	x,y
1303  0313 fe            	ldw	x,(x)
1304  0314 89            	pushw	x
1305  0315 cd0000        	call	_set_millis
1307  0318 5b04          	addw	sp,#4
1308  031a               L314:
1309                     ; 185 			Serial_print_u32(millis());
1311  031a cd0000        	call	_millis
1313  031d be02          	ldw	x,c_lreg+2
1314  031f 89            	pushw	x
1315  0320 be00          	ldw	x,c_lreg
1316  0322 89            	pushw	x
1317  0323 cd0000        	call	_Serial_print_u32
1319  0326 5b04          	addw	sp,#4
1320                     ; 186 			is_valid=1;
1322  0328 a601          	ld	a,#1
1323  032a 6b02          	ld	(OFST+0,sp),a
1325                     ; 187 		}break;
1327  032c ac450445      	jpf	L104
1328  0330               L123:
1329                     ; 192 			Serial_print_string("h\np 9 0 255\np0-3#\nt0-1#\nl2-3#\nw1-2#\na\ng");//more cryptic version
1331  0330 ae00c6        	ldw	x,#L514
1332  0333 cd0000        	call	_Serial_print_string
1334                     ; 193 			is_valid=1;
1336  0336 a601          	ld	a,#1
1337  0338 6b02          	ld	(OFST+0,sp),a
1339                     ; 194 		}break;
1341  033a ac450445      	jpf	L104
1342  033e               L323:
1343                     ; 197 			is_valid=1;
1345  033e a601          	ld	a,#1
1346  0340 6b02          	ld	(OFST+0,sp),a
1348                     ; 198 			if((*parameter_count)<2) is_valid=0;
1350  0342 1e09          	ldw	x,(OFST+7,sp)
1351  0344 f6            	ld	a,(x)
1352  0345 a102          	cp	a,#2
1353  0347 2402          	jruge	L714
1356  0349 0f02          	clr	(OFST+0,sp)
1358  034b               L714:
1359                     ; 199 			if(*parameter_count==2) (*parameters)[3]=255;
1361  034b 1e09          	ldw	x,(OFST+7,sp)
1362  034d f6            	ld	a,(x)
1363  034e a102          	cp	a,#2
1364  0350 2612          	jrne	L124
1367  0352 1e07          	ldw	x,(OFST+5,sp)
1368  0354 a6ff          	ld	a,#255
1369  0356 e70f          	ld	(15,x),a
1370  0358 a600          	ld	a,#0
1371  035a e70e          	ld	(14,x),a
1372  035c a600          	ld	a,#0
1373  035e e70d          	ld	(13,x),a
1374  0360 a600          	ld	a,#0
1375  0362 e70c          	ld	(12,x),a
1376  0364               L124:
1377                     ; 200 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
1379  0364 1e07          	ldw	x,(OFST+5,sp)
1380  0366 cd0000        	call	c_ltor
1382  0369 ae0066        	ldw	x,#L47
1383  036c cd0000        	call	c_lcmp
1385  036f 2502          	jrult	L324
1388  0371 0f02          	clr	(OFST+0,sp)
1390  0373               L324:
1391                     ; 201 			if((*parameters)[1]>=3) is_valid=0;
1393  0373 1e07          	ldw	x,(OFST+5,sp)
1394  0375 1c0004        	addw	x,#4
1395  0378 cd0000        	call	c_ltor
1397  037b ae006a        	ldw	x,#L67
1398  037e cd0000        	call	c_lcmp
1400  0381 2502          	jrult	L524
1403  0383 0f02          	clr	(OFST+0,sp)
1405  0385               L524:
1406                     ; 202 			if((*parameters)[2]>255) is_valid=0;
1408  0385 1e07          	ldw	x,(OFST+5,sp)
1409  0387 1c0008        	addw	x,#8
1410  038a cd0000        	call	c_ltor
1412  038d ae006e        	ldw	x,#L001
1413  0390 cd0000        	call	c_lcmp
1415  0393 2502          	jrult	L724
1418  0395 0f02          	clr	(OFST+0,sp)
1420  0397               L724:
1421                     ; 203 			if(is_valid)
1423  0397 0d02          	tnz	(OFST+0,sp)
1424  0399 2603          	jrne	L221
1425  039b cc0445        	jp	L104
1426  039e               L221:
1427                     ; 205 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
1429  039e 1e07          	ldw	x,(OFST+5,sp)
1430  03a0 e60b          	ld	a,(11,x)
1431  03a2 88            	push	a
1432  03a3 1e08          	ldw	x,(OFST+6,sp)
1433  03a5 e607          	ld	a,(7,x)
1434  03a7 97            	ld	xl,a
1435  03a8 1608          	ldw	y,(OFST+6,sp)
1436  03aa 90e603        	ld	a,(3,y)
1437  03ad 95            	ld	xh,a
1438  03ae cd0000        	call	_set_rgb
1440  03b1 84            	pop	a
1441                     ; 206 				flush_leds(2);//1 RGB led element and 1 for status led
1443  03b2 a602          	ld	a,#2
1444  03b4 cd0000        	call	_flush_leds
1446  03b7 ac450445      	jpf	L104
1447  03bb               L523:
1448                     ; 210 			is_valid=1;
1450  03bb a601          	ld	a,#1
1451  03bd 6b02          	ld	(OFST+0,sp),a
1453                     ; 211 			if(*parameter_count<1) is_valid=0;
1455  03bf 1e09          	ldw	x,(OFST+7,sp)
1456  03c1 7d            	tnz	(x)
1457  03c2 2602          	jrne	L334
1460  03c4 0f02          	clr	(OFST+0,sp)
1462  03c6               L334:
1463                     ; 212 			if(*parameter_count==1) (*parameters)[2]=255;
1465  03c6 1e09          	ldw	x,(OFST+7,sp)
1466  03c8 f6            	ld	a,(x)
1467  03c9 a101          	cp	a,#1
1468  03cb 2612          	jrne	L534
1471  03cd 1e07          	ldw	x,(OFST+5,sp)
1472  03cf a6ff          	ld	a,#255
1473  03d1 e70b          	ld	(11,x),a
1474  03d3 a600          	ld	a,#0
1475  03d5 e70a          	ld	(10,x),a
1476  03d7 a600          	ld	a,#0
1477  03d9 e709          	ld	(9,x),a
1478  03db a600          	ld	a,#0
1479  03dd e708          	ld	(8,x),a
1480  03df               L534:
1481                     ; 213 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
1483  03df 1e07          	ldw	x,(OFST+5,sp)
1484  03e1 cd0000        	call	c_ltor
1486  03e4 ae0072        	ldw	x,#L201
1487  03e7 cd0000        	call	c_lcmp
1489  03ea 2502          	jrult	L734
1492  03ec 0f02          	clr	(OFST+0,sp)
1494  03ee               L734:
1495                     ; 214 			if((*parameters)[1]>255) is_valid=0;
1497  03ee 1e07          	ldw	x,(OFST+5,sp)
1498  03f0 1c0004        	addw	x,#4
1499  03f3 cd0000        	call	c_ltor
1501  03f6 ae006e        	ldw	x,#L001
1502  03f9 cd0000        	call	c_lcmp
1504  03fc 2502          	jrult	L144
1507  03fe 0f02          	clr	(OFST+0,sp)
1509  0400               L144:
1510                     ; 215 			if(is_valid)
1512  0400 0d02          	tnz	(OFST+0,sp)
1513  0402 2741          	jreq	L104
1514                     ; 217 				set_white((*parameters)[0],(*parameters)[1]);
1516  0404 1e07          	ldw	x,(OFST+5,sp)
1517  0406 e607          	ld	a,(7,x)
1518  0408 97            	ld	xl,a
1519  0409 1607          	ldw	y,(OFST+5,sp)
1520  040b 90e603        	ld	a,(3,y)
1521  040e 95            	ld	xh,a
1522  040f cd0000        	call	_set_white
1524                     ; 218 				flush_leds(2);//1 RGB led element and 1 for status led
1526  0412 a602          	ld	a,#2
1527  0414 cd0000        	call	_flush_leds
1529  0417 202c          	jra	L104
1530  0419               L723:
1531                     ; 223 			Serial_print_u32(get_audio_level());
1533  0419 cd0000        	call	_get_audio_level
1535  041c b703          	ld	c_lreg+3,a
1536  041e 3f02          	clr	c_lreg+2
1537  0420 3f01          	clr	c_lreg+1
1538  0422 3f00          	clr	c_lreg
1539  0424 be02          	ldw	x,c_lreg+2
1540  0426 89            	pushw	x
1541  0427 be00          	ldw	x,c_lreg
1542  0429 89            	pushw	x
1543  042a cd0000        	call	_Serial_print_u32
1545  042d 5b04          	addw	sp,#4
1546                     ; 224 			is_valid=1;
1548  042f a601          	ld	a,#1
1549  0431 6b02          	ld	(OFST+0,sp),a
1551                     ; 225 		}break;
1553  0433 2010          	jra	L104
1554  0435               L133:
1555                     ; 227 			play_terminal_game(command,parameters,parameter_count);
1557  0435 1e09          	ldw	x,(OFST+7,sp)
1558  0437 89            	pushw	x
1559  0438 1e09          	ldw	x,(OFST+7,sp)
1560  043a 89            	pushw	x
1561  043b 1e07          	ldw	x,(OFST+5,sp)
1562  043d ad28          	call	_play_terminal_game
1564  043f 5b04          	addw	sp,#4
1565                     ; 228 			is_valid=1;
1567  0441 a601          	ld	a,#1
1568  0443 6b02          	ld	(OFST+0,sp),a
1570                     ; 229 		}break;
1572  0445               L104:
1573                     ; 232 	if(!is_command_exist)
1575  0445 0d01          	tnz	(OFST-1,sp)
1576  0447 260e          	jrne	L544
1577                     ; 234 		Serial_print_string("Invalid cmd: ");
1579  0449 ae00b8        	ldw	x,#L744
1580  044c cd0000        	call	_Serial_print_string
1582                     ; 235 		Serial_print_char(*command);
1584  044f 1e03          	ldw	x,(OFST+1,sp)
1585  0451 f6            	ld	a,(x)
1586  0452 cd0000        	call	_Serial_print_char
1589  0455 200a          	jra	L154
1590  0457               L544:
1591                     ; 237 	else if(!is_valid) Serial_print_string("Invalid params");
1593  0457 0d02          	tnz	(OFST+0,sp)
1594  0459 2606          	jrne	L154
1597  045b ae00a9        	ldw	x,#L554
1598  045e cd0000        	call	_Serial_print_string
1600  0461               L154:
1601                     ; 238 	Serial_newline();
1603  0461 cd0000        	call	_Serial_newline
1605                     ; 239 }
1608  0464 5b04          	addw	sp,#4
1609  0466 81            	ret
1749                     	switch	.const
1750  0076               L641:
1751  0076 00000008      	dc.l	8
1752                     ; 242 void play_terminal_game(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
1752                     ; 243 {
1753                     	switch	.text
1754  0467               _play_terminal_game:
1756  0467 89            	pushw	x
1757  0468 5216          	subw	sp,#22
1758       00000016      OFST:	set	22
1761                     ; 245 	u8 mine_count=0,hidden_count=0;
1763  046a 0f0a          	clr	(OFST-12,sp)
1767                     ; 246 	bool valid_input,is_lose=0;
1769  046c 0f0b          	clr	(OFST-11,sp)
1771                     ; 249 	for(row=0;row<MINESWEEPER_ROWS;row++)
1773  046e 0f16          	clr	(OFST+0,sp)
1775  0470               L545:
1776                     ; 251 		mine_locations[row]=0;
1778  0470 96            	ldw	x,sp
1779  0471 1c000c        	addw	x,#OFST-10
1780  0474 9f            	ld	a,xl
1781  0475 5e            	swapw	x
1782  0476 1b16          	add	a,(OFST+0,sp)
1783  0478 2401          	jrnc	L621
1784  047a 5c            	incw	x
1785  047b               L621:
1786  047b 02            	rlwa	x,a
1787  047c 7f            	clr	(x)
1788                     ; 252 		revealed_cells[row]=0;
1790  047d 96            	ldw	x,sp
1791  047e 1c0001        	addw	x,#OFST-21
1792  0481 9f            	ld	a,xl
1793  0482 5e            	swapw	x
1794  0483 1b16          	add	a,(OFST+0,sp)
1795  0485 2401          	jrnc	L031
1796  0487 5c            	incw	x
1797  0488               L031:
1798  0488 02            	rlwa	x,a
1799  0489 7f            	clr	(x)
1800                     ; 249 	for(row=0;row<MINESWEEPER_ROWS;row++)
1802  048a 0c16          	inc	(OFST+0,sp)
1806  048c 7b16          	ld	a,(OFST+0,sp)
1807  048e a109          	cp	a,#9
1808  0490 25de          	jrult	L545
1810  0492 2062          	jra	L555
1811  0494               L355:
1812                     ; 256 		row=(get_random(millis())>>3)%MINESWEEPER_ROWS;
1814  0494 cd0000        	call	_millis
1816  0497 be02          	ldw	x,c_lreg+2
1817  0499 cd0000        	call	_get_random
1819  049c 54            	srlw	x
1820  049d 54            	srlw	x
1821  049e 54            	srlw	x
1822  049f a609          	ld	a,#9
1823  04a1 62            	div	x,a
1824  04a2 5f            	clrw	x
1825  04a3 97            	ld	xl,a
1826  04a4 01            	rrwa	x,a
1827  04a5 6b16          	ld	(OFST+0,sp),a
1828  04a7 02            	rlwa	x,a
1830                     ; 257 		col=get_random(millis())%8;
1832  04a8 cd0000        	call	_millis
1834  04ab be02          	ldw	x,c_lreg+2
1835  04ad cd0000        	call	_get_random
1837  04b0 01            	rrwa	x,a
1838  04b1 a407          	and	a,#7
1839  04b3 5f            	clrw	x
1840  04b4 6b15          	ld	(OFST-1,sp),a
1842                     ; 258 		if(!((mine_locations[row]>>col)&0x01))
1844  04b6 96            	ldw	x,sp
1845  04b7 1c000c        	addw	x,#OFST-10
1846  04ba 9f            	ld	a,xl
1847  04bb 5e            	swapw	x
1848  04bc 1b16          	add	a,(OFST+0,sp)
1849  04be 2401          	jrnc	L231
1850  04c0 5c            	incw	x
1851  04c1               L231:
1852  04c1 02            	rlwa	x,a
1853  04c2 f6            	ld	a,(x)
1854  04c3 88            	push	a
1855  04c4 7b16          	ld	a,(OFST+0,sp)
1856  04c6 5f            	clrw	x
1857  04c7 97            	ld	xl,a
1858  04c8 84            	pop	a
1859  04c9 5d            	tnzw	x
1860  04ca 2704          	jreq	L431
1861  04cc               L631:
1862  04cc 44            	srl	a
1863  04cd 5a            	decw	x
1864  04ce 26fc          	jrne	L631
1865  04d0               L431:
1866  04d0 5f            	clrw	x
1867  04d1 a501          	bcp	a,#1
1868  04d3 2621          	jrne	L555
1869                     ; 260 			mine_locations[row]|=0x01<<col;
1871  04d5 96            	ldw	x,sp
1872  04d6 1c000c        	addw	x,#OFST-10
1873  04d9 9f            	ld	a,xl
1874  04da 5e            	swapw	x
1875  04db 1b16          	add	a,(OFST+0,sp)
1876  04dd 2401          	jrnc	L041
1877  04df 5c            	incw	x
1878  04e0               L041:
1879  04e0 02            	rlwa	x,a
1880  04e1 7b15          	ld	a,(OFST-1,sp)
1881  04e3 905f          	clrw	y
1882  04e5 9097          	ld	yl,a
1883  04e7 a601          	ld	a,#1
1884  04e9 905d          	tnzw	y
1885  04eb 2705          	jreq	L241
1886  04ed               L441:
1887  04ed 48            	sll	a
1888  04ee 905a          	decw	y
1889  04f0 26fb          	jrne	L441
1890  04f2               L241:
1891  04f2 fa            	or	a,(x)
1892  04f3 f7            	ld	(x),a
1893                     ; 261 			mine_count++;
1895  04f4 0c0a          	inc	(OFST-12,sp)
1897  04f6               L555:
1898                     ; 254 	while(mine_count<10)
1900  04f6 7b0a          	ld	a,(OFST-12,sp)
1901  04f8 a10a          	cp	a,#10
1902  04fa 2598          	jrult	L355
1904  04fc ac9d059d      	jpf	L565
1905  0500               L365:
1906                     ; 266 		valid_input=1;
1908  0500 a601          	ld	a,#1
1909  0502 6b16          	ld	(OFST+0,sp),a
1911                     ; 267 		hidden_count=print_minesweeper(&mine_locations,&revealed_cells,is_lose);
1913  0504 7b0b          	ld	a,(OFST-11,sp)
1914  0506 88            	push	a
1915  0507 96            	ldw	x,sp
1916  0508 1c0002        	addw	x,#OFST-20
1917  050b 89            	pushw	x
1918  050c 96            	ldw	x,sp
1919  050d 1c000f        	addw	x,#OFST-7
1920  0510 cd05c1        	call	_print_minesweeper
1922  0513 5b03          	addw	sp,#3
1923  0515 6b15          	ld	(OFST-1,sp),a
1925                     ; 268 		if(hidden_count<=mine_count || is_lose) break;//won game
1927  0517 7b15          	ld	a,(OFST-1,sp)
1928  0519 110a          	cp	a,(OFST-12,sp)
1929  051b 2203          	jrugt	L251
1930  051d cc05a6        	jp	L765
1931  0520               L251:
1933  0520 0d0b          	tnz	(OFST-11,sp)
1934  0522 2703          	jreq	L451
1935  0524 cc05a6        	jp	L765
1936  0527               L451:
1937                     ; 269 		Serial_print_string("Guess (row col), or quit: ");
1939  0527 ae008e        	ldw	x,#L575
1940  052a cd0000        	call	_Serial_print_string
1942                     ; 270 		get_terminal_command(command,parameters,parameter_count);
1944  052d 1e1d          	ldw	x,(OFST+7,sp)
1945  052f 89            	pushw	x
1946  0530 1e1d          	ldw	x,(OFST+7,sp)
1947  0532 89            	pushw	x
1948  0533 1e1b          	ldw	x,(OFST+5,sp)
1949  0535 cd0119        	call	_get_terminal_command
1951  0538 5b04          	addw	sp,#4
1952                     ; 271 		if(*command=='q') return;
1954  053a 1e17          	ldw	x,(OFST+1,sp)
1955  053c f6            	ld	a,(x)
1956  053d a171          	cp	a,#113
1957  053f 276b          	jreq	L051
1960                     ; 272 		if(*command<'0' || *command>'9') valid_input=0;
1962  0541 1e17          	ldw	x,(OFST+1,sp)
1963  0543 f6            	ld	a,(x)
1964  0544 a130          	cp	a,#48
1965  0546 2507          	jrult	L306
1967  0548 1e17          	ldw	x,(OFST+1,sp)
1968  054a f6            	ld	a,(x)
1969  054b a13a          	cp	a,#58
1970  054d 252c          	jrult	L106
1971  054f               L306:
1974  054f 0f16          	clr	(OFST+0,sp)
1977  0551               L506:
1978                     ; 275 		if(valid_input)
1980  0551 0d16          	tnz	(OFST+0,sp)
1981  0553 2742          	jreq	L516
1982                     ; 277 			row=*command-'0';
1984  0555 1e17          	ldw	x,(OFST+1,sp)
1985  0557 f6            	ld	a,(x)
1986  0558 a030          	sub	a,#48
1987  055a 6b16          	ld	(OFST+0,sp),a
1989                     ; 278 			col=(*parameters)[0];
1991  055c 1e1b          	ldw	x,(OFST+5,sp)
1992  055e e603          	ld	a,(3,x)
1993  0560 6b15          	ld	(OFST-1,sp),a
1995                     ; 279 			is_lose=make_guess(row,col,&mine_locations,&revealed_cells);
1997  0562 96            	ldw	x,sp
1998  0563 1c0001        	addw	x,#OFST-21
1999  0566 89            	pushw	x
2000  0567 96            	ldw	x,sp
2001  0568 1c000e        	addw	x,#OFST-8
2002  056b 89            	pushw	x
2003  056c 7b19          	ld	a,(OFST+3,sp)
2004  056e 97            	ld	xl,a
2005  056f 7b1a          	ld	a,(OFST+4,sp)
2006  0571 95            	ld	xh,a
2007  0572 cd063e        	call	_make_guess
2009  0575 5b04          	addw	sp,#4
2010  0577 6b0b          	ld	(OFST-11,sp),a
2013  0579 2022          	jra	L565
2014  057b               L106:
2015                     ; 273 		else if(*parameter_count!=1) valid_input=0;
2017  057b 1e1d          	ldw	x,(OFST+7,sp)
2018  057d f6            	ld	a,(x)
2019  057e a101          	cp	a,#1
2020  0580 2704          	jreq	L706
2023  0582 0f16          	clr	(OFST+0,sp)
2026  0584 20cb          	jra	L506
2027  0586               L706:
2028                     ; 274 		else if((*parameters)[0]>=8) valid_input=0;
2030  0586 1e1b          	ldw	x,(OFST+5,sp)
2031  0588 cd0000        	call	c_ltor
2033  058b ae0076        	ldw	x,#L641
2034  058e cd0000        	call	c_lcmp
2036  0591 25be          	jrult	L506
2039  0593 0f16          	clr	(OFST+0,sp)
2041  0595 20ba          	jra	L506
2042  0597               L516:
2043                     ; 280 		}else Serial_print_string("Invalid\n");
2045  0597 ae0085        	ldw	x,#L126
2046  059a cd0000        	call	_Serial_print_string
2048  059d               L565:
2049                     ; 264 	while(is_developer_valid())
2051  059d cd0000        	call	_is_developer_valid
2053  05a0 4d            	tnz	a
2054  05a1 2703          	jreq	L651
2055  05a3 cc0500        	jp	L365
2056  05a6               L651:
2057  05a6               L765:
2058                     ; 282 	if(!is_developer_valid()) return;//prevent displaying winner message because user left the menu manually
2060  05a6 cd0000        	call	_is_developer_valid
2062  05a9 4d            	tnz	a
2063  05aa 2603          	jrne	L326
2065  05ac               L051:
2068  05ac 5b18          	addw	sp,#24
2069  05ae 81            	ret
2070  05af               L326:
2071                     ; 283 	if(is_lose){ Serial_print_string("Game Over\n"); is_lose=0; }
2073  05af 0d0b          	tnz	(OFST-11,sp)
2074  05b1 2708          	jreq	L526
2077  05b3 ae007a        	ldw	x,#L726
2078  05b6 cd0000        	call	_Serial_print_string
2083  05b9 2004          	jra	L136
2084  05bb               L526:
2085                     ; 284 	else print_ascii_art(0);
2087  05bb 4f            	clr	a
2088  05bc cd006e        	call	_print_ascii_art
2090  05bf               L136:
2091                     ; 285 }
2093  05bf 20eb          	jra	L051
2181                     ; 288 u8 print_minesweeper(u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_mines)[MINESWEEPER_ROWS],/*u8 (*marked_cells)[MINESWEEPER_ROWS],*/bool is_lose)
2181                     ; 289 {
2182                     	switch	.text
2183  05c1               _print_minesweeper:
2185  05c1 89            	pushw	x
2186  05c2 5203          	subw	sp,#3
2187       00000003      OFST:	set	3
2190                     ; 290 	u8 row,col,hidden_count=0;
2192  05c4 0f01          	clr	(OFST-2,sp)
2194                     ; 294 	for(row=0;row<MINESWEEPER_ROWS;row++)
2196  05c6 0f02          	clr	(OFST-1,sp)
2198  05c8               L576:
2199                     ; 296 		Serial_print_char('0'+row);
2201  05c8 7b02          	ld	a,(OFST-1,sp)
2202  05ca ab30          	add	a,#48
2203  05cc cd0000        	call	_Serial_print_char
2205                     ; 297 		Serial_print_char(' ');
2207  05cf a620          	ld	a,#32
2208  05d1 cd0000        	call	_Serial_print_char
2210                     ; 298 		Serial_print_char('|');
2212  05d4 a67c          	ld	a,#124
2213  05d6 cd0000        	call	_Serial_print_char
2215                     ; 299 		for(col=0;col<8;col++)
2217  05d9 0f03          	clr	(OFST+0,sp)
2219  05db               L307:
2220                     ; 301 			Serial_print_char(' ');
2222  05db a620          	ld	a,#32
2223  05dd cd0000        	call	_Serial_print_char
2225                     ; 302 			if(is_lose && is_mine_at(row,col,mine_locations)) Serial_print_char('X');
2227  05e0 0d0a          	tnz	(OFST+7,sp)
2228  05e2 2717          	jreq	L117
2230  05e4 1e04          	ldw	x,(OFST+1,sp)
2231  05e6 89            	pushw	x
2232  05e7 7b05          	ld	a,(OFST+2,sp)
2233  05e9 97            	ld	xl,a
2234  05ea 7b04          	ld	a,(OFST+1,sp)
2235  05ec 95            	ld	xh,a
2236  05ed cd0740        	call	_is_mine_at
2238  05f0 85            	popw	x
2239  05f1 4d            	tnz	a
2240  05f2 2707          	jreq	L117
2243  05f4 a658          	ld	a,#88
2244  05f6 cd0000        	call	_Serial_print_char
2247  05f9 202b          	jra	L317
2248  05fb               L117:
2249                     ; 305 				if(is_mine_at(row,col,revealed_mines))
2251  05fb 1e08          	ldw	x,(OFST+5,sp)
2252  05fd 89            	pushw	x
2253  05fe 7b05          	ld	a,(OFST+2,sp)
2254  0600 97            	ld	xl,a
2255  0601 7b04          	ld	a,(OFST+1,sp)
2256  0603 95            	ld	xh,a
2257  0604 cd0740        	call	_is_mine_at
2259  0607 85            	popw	x
2260  0608 4d            	tnz	a
2261  0609 2714          	jreq	L517
2262                     ; 306 					Serial_print_char('0'+get_nearby_count(row,col,mine_locations));
2264  060b 1e04          	ldw	x,(OFST+1,sp)
2265  060d 89            	pushw	x
2266  060e 7b05          	ld	a,(OFST+2,sp)
2267  0610 97            	ld	xl,a
2268  0611 7b04          	ld	a,(OFST+1,sp)
2269  0613 95            	ld	xh,a
2270  0614 cd06df        	call	_get_nearby_count
2272  0617 85            	popw	x
2273  0618 ab30          	add	a,#48
2274  061a cd0000        	call	_Serial_print_char
2277  061d 2007          	jra	L317
2278  061f               L517:
2279                     ; 309 					Serial_print_char('.');
2281  061f a62e          	ld	a,#46
2282  0621 cd0000        	call	_Serial_print_char
2284                     ; 310 					hidden_count++;
2286  0624 0c01          	inc	(OFST-2,sp)
2288  0626               L317:
2289                     ; 299 		for(col=0;col<8;col++)
2291  0626 0c03          	inc	(OFST+0,sp)
2295  0628 7b03          	ld	a,(OFST+0,sp)
2296  062a a108          	cp	a,#8
2297  062c 25ad          	jrult	L307
2298                     ; 314 		Serial_newline();
2300  062e cd0000        	call	_Serial_newline
2302                     ; 294 	for(row=0;row<MINESWEEPER_ROWS;row++)
2304  0631 0c02          	inc	(OFST-1,sp)
2308  0633 7b02          	ld	a,(OFST-1,sp)
2309  0635 a109          	cp	a,#9
2310  0637 258f          	jrult	L576
2311                     ; 316 	return hidden_count;
2313  0639 7b01          	ld	a,(OFST-2,sp)
2316  063b 5b05          	addw	sp,#5
2317  063d 81            	ret
2404                     ; 320 bool make_guess(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_cells)[MINESWEEPER_ROWS])
2404                     ; 321 {
2405                     	switch	.text
2406  063e               _make_guess:
2408  063e 89            	pushw	x
2409  063f 89            	pushw	x
2410       00000002      OFST:	set	2
2413                     ; 323 	if(row>=MINESWEEPER_ROWS || col>=8) return 0;//if out of bounds, skip it
2415  0640 9e            	ld	a,xh
2416  0641 a109          	cp	a,#9
2417  0643 2405          	jruge	L567
2419  0645 9f            	ld	a,xl
2420  0646 a108          	cp	a,#8
2421  0648 2503          	jrult	L367
2422  064a               L567:
2425  064a 4f            	clr	a
2427  064b 201c          	jra	L471
2428  064d               L367:
2429                     ; 324 	if(((*revealed_cells)[row]>>col) & 0x01) return 0;//if already revealed, skip it
2431  064d 7b04          	ld	a,(OFST+2,sp)
2432  064f 5f            	clrw	x
2433  0650 97            	ld	xl,a
2434  0651 7b03          	ld	a,(OFST+1,sp)
2435  0653 905f          	clrw	y
2436  0655 9097          	ld	yl,a
2437  0657 72f909        	addw	y,(OFST+7,sp)
2438  065a 90f6          	ld	a,(y)
2439  065c 5d            	tnzw	x
2440  065d 2704          	jreq	L461
2441  065f               L661:
2442  065f 44            	srl	a
2443  0660 5a            	decw	x
2444  0661 26fc          	jrne	L661
2445  0663               L461:
2446  0663 5f            	clrw	x
2447  0664 a501          	bcp	a,#1
2448  0666 2704          	jreq	L767
2451  0668 4f            	clr	a
2453  0669               L471:
2455  0669 5b04          	addw	sp,#4
2456  066b 81            	ret
2457  066c               L767:
2458                     ; 325 	(*revealed_cells)[row]|=0x01<<col;//reveal guess
2460  066c 7b03          	ld	a,(OFST+1,sp)
2461  066e 5f            	clrw	x
2462  066f 97            	ld	xl,a
2463  0670 72fb09        	addw	x,(OFST+7,sp)
2464  0673 7b04          	ld	a,(OFST+2,sp)
2465  0675 905f          	clrw	y
2466  0677 9097          	ld	yl,a
2467  0679 a601          	ld	a,#1
2468  067b 905d          	tnzw	y
2469  067d 2705          	jreq	L071
2470  067f               L271:
2471  067f 48            	sll	a
2472  0680 905a          	decw	y
2473  0682 26fb          	jrne	L271
2474  0684               L071:
2475  0684 fa            	or	a,(x)
2476  0685 f7            	ld	(x),a
2477                     ; 326 	if(get_nearby_count(row,col,mine_locations)==0)
2479  0686 1e07          	ldw	x,(OFST+5,sp)
2480  0688 89            	pushw	x
2481  0689 7b06          	ld	a,(OFST+4,sp)
2482  068b 97            	ld	xl,a
2483  068c 7b05          	ld	a,(OFST+3,sp)
2484  068e 95            	ld	xh,a
2485  068f ad4e          	call	_get_nearby_count
2487  0691 85            	popw	x
2488  0692 4d            	tnz	a
2489  0693 263c          	jrne	L177
2490                     ; 328 		for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
2492  0695 a6ff          	ld	a,#255
2493  0697 6b01          	ld	(OFST-1,sp),a
2496  0699 202a          	jra	L777
2497  069b               L377:
2498                     ; 329 			for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
2500  069b a6ff          	ld	a,#255
2501  069d 6b02          	ld	(OFST+0,sp),a
2504  069f 2016          	jra	L7001
2505  06a1               L3001:
2506                     ; 330 				make_guess(row+row_diff,col+col_diff,mine_locations,revealed_cells);
2508  06a1 1e09          	ldw	x,(OFST+7,sp)
2509  06a3 89            	pushw	x
2510  06a4 1e09          	ldw	x,(OFST+7,sp)
2511  06a6 89            	pushw	x
2512  06a7 7b08          	ld	a,(OFST+6,sp)
2513  06a9 1b06          	add	a,(OFST+4,sp)
2514  06ab 97            	ld	xl,a
2515  06ac 7b07          	ld	a,(OFST+5,sp)
2516  06ae 1b05          	add	a,(OFST+3,sp)
2517  06b0 95            	ld	xh,a
2518  06b1 ad8b          	call	_make_guess
2520  06b3 5b04          	addw	sp,#4
2521                     ; 329 			for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
2523  06b5 0c02          	inc	(OFST+0,sp)
2525  06b7               L7001:
2528  06b7 7b02          	ld	a,(OFST+0,sp)
2529  06b9 a102          	cp	a,#2
2530  06bb 25e4          	jrult	L3001
2532  06bd 7b02          	ld	a,(OFST+0,sp)
2533  06bf a1ff          	cp	a,#255
2534  06c1 27de          	jreq	L3001
2535                     ; 328 		for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
2537  06c3 0c01          	inc	(OFST-1,sp)
2539  06c5               L777:
2542  06c5 7b01          	ld	a,(OFST-1,sp)
2543  06c7 a102          	cp	a,#2
2544  06c9 25d0          	jrult	L377
2546  06cb 7b01          	ld	a,(OFST-1,sp)
2547  06cd a1ff          	cp	a,#255
2548  06cf 27ca          	jreq	L377
2549  06d1               L177:
2550                     ; 332 	return is_mine_at(row,col,mine_locations);
2552  06d1 1e07          	ldw	x,(OFST+5,sp)
2553  06d3 89            	pushw	x
2554  06d4 7b06          	ld	a,(OFST+4,sp)
2555  06d6 97            	ld	xl,a
2556  06d7 7b05          	ld	a,(OFST+3,sp)
2557  06d9 95            	ld	xh,a
2558  06da ad64          	call	_is_mine_at
2560  06dc 85            	popw	x
2562  06dd 208a          	jra	L471
2644                     ; 335 u8 get_nearby_count(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
2644                     ; 336 {
2645                     	switch	.text
2646  06df               _get_nearby_count:
2648  06df 89            	pushw	x
2649  06e0 5203          	subw	sp,#3
2650       00000003      OFST:	set	3
2653                     ; 338 	u8 sum=0;
2655  06e2 0f01          	clr	(OFST-2,sp)
2657                     ; 339 	for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
2659  06e4 a6ff          	ld	a,#255
2660  06e6 6b02          	ld	(OFST-1,sp),a
2663  06e8 2045          	jra	L1601
2664  06ea               L5501:
2665                     ; 341 		for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
2667  06ea a6ff          	ld	a,#255
2668  06ec 6b03          	ld	(OFST+0,sp),a
2671  06ee 2031          	jra	L1701
2672  06f0               L5601:
2673                     ; 343 			if(row_diff==0 && col_diff==0)
2675  06f0 0d02          	tnz	(OFST-1,sp)
2676  06f2 2617          	jrne	L5701
2678  06f4 0d03          	tnz	(OFST+0,sp)
2679  06f6 2613          	jrne	L5701
2680                     ; 345 				if(is_mine_at(row,col,mine_locations)) return 1;
2682  06f8 1e08          	ldw	x,(OFST+5,sp)
2683  06fa 89            	pushw	x
2684  06fb 7b07          	ld	a,(OFST+4,sp)
2685  06fd 97            	ld	xl,a
2686  06fe 7b06          	ld	a,(OFST+3,sp)
2687  0700 95            	ld	xh,a
2688  0701 ad3d          	call	_is_mine_at
2690  0703 85            	popw	x
2691  0704 4d            	tnz	a
2692  0705 2718          	jreq	L1011
2695  0707 a601          	ld	a,#1
2697  0709 2032          	jra	L002
2698  070b               L5701:
2699                     ; 347 				sum+=is_mine_at(row+row_diff,col+col_diff,mine_locations);
2701  070b 1e08          	ldw	x,(OFST+5,sp)
2702  070d 89            	pushw	x
2703  070e 7b07          	ld	a,(OFST+4,sp)
2704  0710 1b05          	add	a,(OFST+2,sp)
2705  0712 97            	ld	xl,a
2706  0713 7b06          	ld	a,(OFST+3,sp)
2707  0715 1b04          	add	a,(OFST+1,sp)
2708  0717 95            	ld	xh,a
2709  0718 ad26          	call	_is_mine_at
2711  071a 85            	popw	x
2712  071b 1b01          	add	a,(OFST-2,sp)
2713  071d 6b01          	ld	(OFST-2,sp),a
2715  071f               L1011:
2716                     ; 341 		for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
2718  071f 0c03          	inc	(OFST+0,sp)
2720  0721               L1701:
2723  0721 7b03          	ld	a,(OFST+0,sp)
2724  0723 a102          	cp	a,#2
2725  0725 25c9          	jrult	L5601
2727  0727 7b03          	ld	a,(OFST+0,sp)
2728  0729 a1ff          	cp	a,#255
2729  072b 27c3          	jreq	L5601
2730                     ; 339 	for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
2732  072d 0c02          	inc	(OFST-1,sp)
2734  072f               L1601:
2737  072f 7b02          	ld	a,(OFST-1,sp)
2738  0731 a102          	cp	a,#2
2739  0733 25b5          	jrult	L5501
2741  0735 7b02          	ld	a,(OFST-1,sp)
2742  0737 a1ff          	cp	a,#255
2743  0739 27af          	jreq	L5501
2744                     ; 351 	return sum;
2746  073b 7b01          	ld	a,(OFST-2,sp)
2748  073d               L002:
2750  073d 5b05          	addw	sp,#5
2751  073f 81            	ret
2806                     ; 354 bool is_mine_at(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
2806                     ; 355 {
2807                     	switch	.text
2808  0740               _is_mine_at:
2810  0740 89            	pushw	x
2811       00000000      OFST:	set	0
2814                     ; 356 	if(row>=MINESWEEPER_ROWS || col>=8) return 0;
2816  0741 9e            	ld	a,xh
2817  0742 a109          	cp	a,#9
2818  0744 2405          	jruge	L3311
2820  0746 9f            	ld	a,xl
2821  0747 a108          	cp	a,#8
2822  0749 2503          	jrult	L1311
2823  074b               L3311:
2826  074b 4f            	clr	a
2828  074c 2018          	jra	L012
2829  074e               L1311:
2830                     ; 357 	return ((*mine_locations)[row]>>col)&0x01;
2832  074e 7b02          	ld	a,(OFST+2,sp)
2833  0750 5f            	clrw	x
2834  0751 97            	ld	xl,a
2835  0752 7b01          	ld	a,(OFST+1,sp)
2836  0754 905f          	clrw	y
2837  0756 9097          	ld	yl,a
2838  0758 72f905        	addw	y,(OFST+5,sp)
2839  075b 90f6          	ld	a,(y)
2840  075d 5d            	tnzw	x
2841  075e 2704          	jreq	L402
2842  0760               L602:
2843  0760 44            	srl	a
2844  0761 5a            	decw	x
2845  0762 26fc          	jrne	L602
2846  0764               L402:
2847  0764 a401          	and	a,#1
2849  0766               L012:
2851  0766 85            	popw	x
2852  0767 81            	ret
2865                     	xref	_Serial_print_u32
2866                     	xref	_Serial_read_char
2867                     	xref	_Serial_available
2868                     	xref	_Serial_newline
2869                     	xref	_Serial_print_string
2870                     	xref	_Serial_print_char
2871                     	xdef	_is_mine_at
2872                     	xdef	_get_nearby_count
2873                     	xdef	_make_guess
2874                     	xdef	_print_minesweeper
2875                     	xdef	_play_terminal_game
2876                     	xdef	_print_ascii_art
2877                     	xdef	_execute_terminal_command
2878                     	xdef	_get_terminal_command
2879                     	xdef	_run_developer
2880                     	xdef	_setup_developer
2881                     	xref	_set_millis
2882                     	xref	_get_audio_level
2883                     	xref	_get_random
2884                     	xref	_clear_button_events
2885                     	xref	_is_developer_valid
2886                     	xref	_flush_leds
2887                     	xref	_set_debug
2888                     	xref	_set_white
2889                     	xref	_set_rgb
2890                     	xref	_millis
2891                     	xref	_setup_serial
2892                     	switch	.const
2893  007a               L726:
2894  007a 47616d65204f  	dc.b	"Game Over",10,0
2895  0085               L126:
2896  0085 496e76616c69  	dc.b	"Invalid",10,0
2897  008e               L575:
2898  008e 477565737320  	dc.b	"Guess (row col), o"
2899  00a0 722071756974  	dc.b	"r quit: ",0
2900  00a9               L554:
2901  00a9 496e76616c69  	dc.b	"Invalid params",0
2902  00b8               L744:
2903  00b8 496e76616c69  	dc.b	"Invalid cmd: ",0
2904  00c6               L514:
2905  00c6 680a          	dc.b	"h",10
2906  00c8 702039203020  	dc.b	"p 9 0 255",10
2907  00d2 70302d33230a  	dc.b	"p0-3#",10
2908  00d8 74302d31230a  	dc.b	"t0-1#",10
2909  00de 6c322d33230a  	dc.b	"l2-3#",10
2910  00e4 77312d32230a  	dc.b	"w1-2#",10
2911  00ea 610a          	dc.b	"a",10
2912  00ec 6700          	dc.b	"g",0
2913  00ee               L75:
2914  00ee 45786974696e  	dc.b	"Exiting Terminal",10,0
2915  0100               L55:
2916  0100 3e2000        	dc.b	"> ",0
2917                     	xref.b	c_lreg
2918                     	xref.b	c_x
2919                     	xref.b	c_y
2939                     	xref	c_lcmp
2940                     	xref	c_lsbc
2941                     	xref	c_ladc
2942                     	xref	c_ladd
2943                     	xref	c_rtol
2944                     	xref	c_llsh
2945                     	xref	c_ltor
2946                     	xref	c_smodx
2947                     	xref	c_idiv
2948                     	xref	c_xymov
2949                     	end
