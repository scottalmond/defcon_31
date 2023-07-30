   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  47                     ; 10 void setup_developer()
  47                     ; 11 {
  49                     	switch	.text
  50  0000               _setup_developer:
  54                     ; 12 	setup_serial(1,1);//enabled, 0: 9600 baud, 1: at high speed (1MBaud)
  56  0000 ae0101        	ldw	x,#257
  57  0003 cd0000        	call	_setup_serial
  59                     ; 13 	clear_button_events();
  61  0006 cd0000        	call	_clear_button_events
  63                     ; 14 	flush_leds(0);//clear outstanding led buffer
  65  0009 4f            	clr	a
  66  000a cd0000        	call	_flush_leds
  68                     ; 15 	set_debug(255);//show only one debug led ON
  70  000d a6ff          	ld	a,#255
  71  000f cd0000        	call	_set_debug
  73                     ; 16 	flush_leds(1);
  75  0012 a601          	ld	a,#1
  76  0014 cd0000        	call	_flush_leds
  78                     ; 17 	print_welcome();
  80  0017 ad41          	call	_print_welcome
  82                     ; 18 }
  85  0019 81            	ret
 144                     ; 20 void run_developer()
 144                     ; 21 {
 145                     	switch	.text
 146  001a               _run_developer:
 148  001a 520e          	subw	sp,#14
 149       0000000e      OFST:	set	14
 152                     ; 25 	setup_developer();
 154  001c ade2          	call	_setup_developer
 157  001e 2031          	jra	L15
 158  0020               L74:
 159                     ; 28 		Serial_print_string("> ");
 161  0020 ae00b4        	ldw	x,#L55
 162  0023 cd0000        	call	_Serial_print_string
 164                     ; 29 		get_terminal_command(&command,&parameters,&parameter_count);
 166  0026 96            	ldw	x,sp
 167  0027 1c000e        	addw	x,#OFST+0
 168  002a 89            	pushw	x
 169  002b 96            	ldw	x,sp
 170  002c 1c0003        	addw	x,#OFST-11
 171  002f 89            	pushw	x
 172  0030 96            	ldw	x,sp
 173  0031 1c0011        	addw	x,#OFST+3
 174  0034 cd00da        	call	_get_terminal_command
 176  0037 5b04          	addw	sp,#4
 177                     ; 30 		set_debug(255);//show only one debug led ON
 179  0039 a6ff          	ld	a,#255
 180  003b cd0000        	call	_set_debug
 182                     ; 31 		execute_terminal_command(command,&parameters,parameter_count);
 184  003e 7b0e          	ld	a,(OFST+0,sp)
 185  0040 88            	push	a
 186  0041 96            	ldw	x,sp
 187  0042 1c0002        	addw	x,#OFST-12
 188  0045 89            	pushw	x
 189  0046 7b10          	ld	a,(OFST+2,sp)
 190  0048 cd01bc        	call	_execute_terminal_command
 192  004b 5b03          	addw	sp,#3
 193                     ; 32 		command=0;
 195  004d 0f0d          	clr	(OFST-1,sp)
 197                     ; 33 		parameter_count=0;
 199  004f 0f0e          	clr	(OFST+0,sp)
 201  0051               L15:
 202                     ; 26 	while(is_developer_valid())
 204  0051 cd0000        	call	_is_developer_valid
 206  0054 4d            	tnz	a
 207  0055 26c9          	jrne	L74
 208                     ; 38 }
 211  0057 5b0e          	addw	sp,#14
 212  0059 81            	ret
 215                     .const:	section	.text
 216  0000               L75_space_bits:
 217  0000 79            	dc.b	121
 218  0001 f0            	dc.b	240
 219  0002 c3            	dc.b	195
 220  0003 cf            	dc.b	207
 221  0004 df            	dc.b	223
 222  0005 2f            	dc.b	47
 223  0006 9e            	dc.b	158
 224  0007 7c            	dc.b	124
 225  0008 84            	dc.b	132
 226  0009 f0            	dc.b	240
 227  000a 81            	dc.b	129
 228  000b 09            	dc.b	9
 229  000c 24            	dc.b	36
 230  000d 28            	dc.b	40
 231  000e 10            	dc.b	16
 232  000f a2            	dc.b	162
 233  0010 20            	dc.b	32
 234  0011 42            	dc.b	66
 235  0012 85            	dc.b	133
 236  0013 00            	dc.b	0
 237  0014 79            	dc.b	121
 238  0015 0a            	dc.b	10
 239  0016 14            	dc.b	20
 240  0017 0f            	dc.b	15
 241  0018 9f            	dc.b	159
 242  0019 22            	dc.b	34
 243  001a 1e            	dc.b	30
 244  001b 42            	dc.b	66
 245  001c 84            	dc.b	132
 246  001d f0            	dc.b	240
 247  001e 05            	dc.b	5
 248  001f f3            	dc.b	243
 249  0020 f4            	dc.b	244
 250  0021 08            	dc.b	8
 251  0022 10            	dc.b	16
 252  0023 a2            	dc.b	162
 253  0024 01            	dc.b	1
 254  0025 7c            	dc.b	124
 255  0026 84            	dc.b	132
 256  0027 08            	dc.b	8
 257  0028 85            	dc.b	133
 258  0029 02            	dc.b	2
 259  002a 14            	dc.b	20
 260  002b 28            	dc.b	40
 261  002c 10            	dc.b	16
 262  002d a2            	dc.b	162
 263  002e 21            	dc.b	33
 264  002f 44            	dc.b	68
 265  0030 85            	dc.b	133
 266  0031 08            	dc.b	8
 267  0032 79            	dc.b	121
 268  0033 02            	dc.b	2
 269  0034 13            	dc.b	19
 270  0035 cf            	dc.b	207
 271  0036 df            	dc.b	223
 272  0037 22            	dc.b	34
 273  0038 1e            	dc.b	30
 274  0039 42            	dc.b	66
 275  003a 78            	dc.b	120
 276  003b f0            	dc.b	240
 277  003c               L16_defcon31:
 278  003c 7e            	dc.b	126
 279  003d 7f            	dc.b	127
 280  003e 7f            	dc.b	127
 281  003f 3e            	dc.b	62
 282  0040 7f            	dc.b	127
 283  0041 41            	dc.b	65
 284  0042 3e            	dc.b	62
 285  0043 08            	dc.b	8
 286  0044 41            	dc.b	65
 287  0045 40            	dc.b	64
 288  0046 40            	dc.b	64
 289  0047 41            	dc.b	65
 290  0048 41            	dc.b	65
 291  0049 61            	dc.b	97
 292  004a 41            	dc.b	65
 293  004b 18            	dc.b	24
 294  004c 41            	dc.b	65
 295  004d 40            	dc.b	64
 296  004e 40            	dc.b	64
 297  004f 40            	dc.b	64
 298  0050 41            	dc.b	65
 299  0051 51            	dc.b	81
 300  0052 01            	dc.b	1
 301  0053 28            	dc.b	40
 302  0054 41            	dc.b	65
 303  0055 7c            	dc.b	124
 304  0056 7c            	dc.b	124
 305  0057 40            	dc.b	64
 306  0058 41            	dc.b	65
 307  0059 49            	dc.b	73
 308  005a 3e            	dc.b	62
 309  005b 08            	dc.b	8
 310  005c 41            	dc.b	65
 311  005d 40            	dc.b	64
 312  005e 40            	dc.b	64
 313  005f 40            	dc.b	64
 314  0060 41            	dc.b	65
 315  0061 45            	dc.b	69
 316  0062 01            	dc.b	1
 317  0063 08            	dc.b	8
 318  0064 41            	dc.b	65
 319  0065 40            	dc.b	64
 320  0066 40            	dc.b	64
 321  0067 41            	dc.b	65
 322  0068 41            	dc.b	65
 323  0069 43            	dc.b	67
 324  006a 41            	dc.b	65
 325  006b 08            	dc.b	8
 326  006c 7e            	dc.b	126
 327  006d 7f            	dc.b	127
 328  006e 40            	dc.b	64
 329  006f 3e            	dc.b	62
 330  0070 7f            	dc.b	127
 331  0071 41            	dc.b	65
 332  0072 3e            	dc.b	62
 333  0073 3e            	dc.b	62
 415                     ; 41 void print_welcome()
 415                     ; 42 {
 416                     	switch	.text
 417  005a               _print_welcome:
 419  005a 5277          	subw	sp,#119
 420       00000077      OFST:	set	119
 423                     ; 43 	u8 space_bits[] = { 0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,
 423                     ; 44 											0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,
 423                     ; 45 											0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,
 423                     ; 46 											0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,
 423                     ; 47 											0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,
 423                     ; 48 											0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,
 423                     ; 49 											0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,
 423                     ; 50 											0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,
 423                     ; 51 											0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,
 423                     ; 52 											0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000}; 
 425  005c 96            	ldw	x,sp
 426  005d 1c0002        	addw	x,#OFST-117
 427  0060 90ae0000      	ldw	y,#L75_space_bits
 428  0064 a63c          	ld	a,#60
 429  0066 cd0000        	call	c_xymov
 431                     ; 53 	u8 defcon31[] = {   0b01111110,0b01111111,0b01111111,0b00111110,0b01111111,0b01000001,
 431                     ; 54 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000001,
 431                     ; 55 											0b01000001,0b01100001,0b01000001,0b0011000,0b01000001,0b01000000,
 431                     ; 56 											0b01000000,0b01000000,0b01000001,0b01010001,0b00000001,0b0101000,
 431                     ; 57 											0b01000001,0b01111100,0b01111100,0b01000000,0b01000001,0b01001001,//last bit messed up?
 431                     ; 58 											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000000,//mis-typed bit?
 431                     ; 59 											0b01000001,0b01000101,0b00000001,0b0001000,0b01000001,0b01000000,
 431                     ; 60 											0b01000000,0b01000001,0b01000001,0b01000011,0b01000001,0b0001000,
 431                     ; 61 											0b01111110,0b01111111,0b01000000,0b00111110,0b01111111,0b01000001,
 431                     ; 62 											0b00111110,0b0111110 };
 433  0069 96            	ldw	x,sp
 434  006a 1c003e        	addw	x,#OFST-57
 435  006d 90ae003c      	ldw	y,#L16_defcon31
 436  0071 a638          	ld	a,#56
 437  0073 cd0000        	call	c_xymov
 439                     ; 63 	u8 length = sizeof(is_space_sao()?space_bits:defcon31);
 441  0076 a602          	ld	a,#2
 442  0078 6b01          	ld	(OFST-118,sp),a
 444                     ; 64 	u8 lineBreakInterval = is_space_sao()?10:8;
 446  007a cd0000        	call	_is_space_sao
 448  007d 4d            	tnz	a
 449  007e 2705          	jreq	L21
 450  0080 ae000a        	ldw	x,#10
 451  0083 2003          	jra	L41
 452  0085               L21:
 453  0085 ae0008        	ldw	x,#8
 454  0088               L41:
 455                     ; 66 	for (i = 0; i < length; i++) {
 457  0088 0f76          	clr	(OFST-1,sp)
 460  008a 2045          	jra	L131
 461  008c               L521:
 462                     ; 67 			for (j = 7; j >= 0; j--) {
 464  008c a607          	ld	a,#7
 465  008e 6b77          	ld	(OFST+0,sp),a
 467  0090               L531:
 468                     ; 69 				 Serial_print_char((((is_space_sao()?space_bits[i]:defcon31[i]) >> j) & 0x01) ? '#' : ' ');
 470  0090 cd0000        	call	_is_space_sao
 472  0093 4d            	tnz	a
 473  0094 2711          	jreq	L02
 474  0096 96            	ldw	x,sp
 475  0097 1c0002        	addw	x,#OFST-117
 476  009a 9f            	ld	a,xl
 477  009b 5e            	swapw	x
 478  009c 1b76          	add	a,(OFST-1,sp)
 479  009e 2401          	jrnc	L22
 480  00a0 5c            	incw	x
 481  00a1               L22:
 482  00a1 02            	rlwa	x,a
 483  00a2 f6            	ld	a,(x)
 484  00a3 5f            	clrw	x
 485  00a4 97            	ld	xl,a
 486  00a5 200f          	jra	L42
 487  00a7               L02:
 488  00a7 96            	ldw	x,sp
 489  00a8 1c003e        	addw	x,#OFST-57
 490  00ab 9f            	ld	a,xl
 491  00ac 5e            	swapw	x
 492  00ad 1b76          	add	a,(OFST-1,sp)
 493  00af 2401          	jrnc	L62
 494  00b1 5c            	incw	x
 495  00b2               L62:
 496  00b2 02            	rlwa	x,a
 497  00b3 f6            	ld	a,(x)
 498  00b4 5f            	clrw	x
 499  00b5 97            	ld	xl,a
 500  00b6               L42:
 501  00b6 7b77          	ld	a,(OFST+0,sp)
 502  00b8 4d            	tnz	a
 503  00b9 2704          	jreq	L03
 504  00bb               L23:
 505  00bb 57            	sraw	x
 506  00bc 4a            	dec	a
 507  00bd 26fc          	jrne	L23
 508  00bf               L03:
 509  00bf 01            	rrwa	x,a
 510  00c0 a501          	bcp	a,#1
 511  00c2 2704          	jreq	L61
 512  00c4 a623          	ld	a,#35
 513  00c6 2002          	jra	L43
 514  00c8               L61:
 515  00c8 a620          	ld	a,#32
 516  00ca               L43:
 517  00ca cd0000        	call	_Serial_print_char
 519                     ; 67 			for (j = 7; j >= 0; j--) {
 521  00cd 0a77          	dec	(OFST+0,sp)
 524  00cf 20bf          	jra	L531
 525  00d1               L131:
 526                     ; 66 	for (i = 0; i < length; i++) {
 529  00d1 7b76          	ld	a,(OFST-1,sp)
 530  00d3 1101          	cp	a,(OFST-118,sp)
 531  00d5 25b5          	jrult	L521
 532                     ; 78 }
 535  00d7 5b77          	addw	sp,#119
 536  00d9 81            	ret
 645                     ; 80 void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
 645                     ; 81 {
 646                     	switch	.text
 647  00da               _get_terminal_command:
 649  00da 89            	pushw	x
 650  00db 5207          	subw	sp,#7
 651       00000007      OFST:	set	7
 654                     ; 82 	bool is_new_line=0;
 656  00dd 0f05          	clr	(OFST-2,sp)
 658                     ; 83 	bool is_any_input=0;//set to true after new inpute received, including a value of '0'
 660  00df 0f06          	clr	(OFST-1,sp)
 663  00e1 acac01ac      	jpf	L122
 664  00e5               L512:
 665                     ; 87 		if(Serial_available())
 667  00e5 cd0000        	call	_Serial_available
 669  00e8 4d            	tnz	a
 670  00e9 2603          	jrne	L04
 671  00eb cc01ac        	jp	L122
 672  00ee               L04:
 673                     ; 89 			input_char=Serial_read_char();
 675  00ee cd0000        	call	_Serial_read_char
 677  00f1 6b07          	ld	(OFST+0,sp),a
 679                     ; 90 			if(input_char=='\n') is_new_line=1;//break on new line character found
 681  00f3 7b07          	ld	a,(OFST+0,sp)
 682  00f5 a10a          	cp	a,#10
 683  00f7 2608          	jrne	L722
 686  00f9 a601          	ld	a,#1
 687  00fb 6b05          	ld	(OFST-2,sp),a
 690  00fd acac01ac      	jpf	L122
 691  0101               L722:
 692                     ; 91 			else if((*command)==0) (*command)=input_char;
 694  0101 1e08          	ldw	x,(OFST+1,sp)
 695  0103 7d            	tnz	(x)
 696  0104 2609          	jrne	L332
 699  0106 7b07          	ld	a,(OFST+0,sp)
 700  0108 1e08          	ldw	x,(OFST+1,sp)
 701  010a f7            	ld	(x),a
 703  010b acac01ac      	jpf	L122
 704  010f               L332:
 705                     ; 93 				if('0'<=input_char && input_char<='9')
 707  010f 7b07          	ld	a,(OFST+0,sp)
 708  0111 a130          	cp	a,#48
 709  0113 2402          	jruge	L24
 710  0115 2078          	jp	L732
 711  0117               L24:
 713  0117 7b07          	ld	a,(OFST+0,sp)
 714  0119 a13a          	cp	a,#58
 715  011b 2472          	jruge	L732
 716                     ; 95 					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
 718  011d 0d06          	tnz	(OFST-1,sp)
 719  011f 2619          	jrne	L142
 722  0121 1e0e          	ldw	x,(OFST+7,sp)
 723  0123 f6            	ld	a,(x)
 724  0124 97            	ld	xl,a
 725  0125 a604          	ld	a,#4
 726  0127 42            	mul	x,a
 727  0128 72fb0c        	addw	x,(OFST+5,sp)
 728  012b a600          	ld	a,#0
 729  012d e703          	ld	(3,x),a
 730  012f a600          	ld	a,#0
 731  0131 e702          	ld	(2,x),a
 732  0133 a600          	ld	a,#0
 733  0135 e701          	ld	(1,x),a
 734  0137 a600          	ld	a,#0
 735  0139 f7            	ld	(x),a
 736  013a               L142:
 737                     ; 96 					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
 739  013a 7b07          	ld	a,(OFST+0,sp)
 740  013c 5f            	clrw	x
 741  013d 97            	ld	xl,a
 742  013e 1d0030        	subw	x,#48
 743  0141 cd0000        	call	c_itolx
 745  0144 96            	ldw	x,sp
 746  0145 1c0001        	addw	x,#OFST-6
 747  0148 cd0000        	call	c_rtol
 750  014b 1e0e          	ldw	x,(OFST+7,sp)
 751  014d f6            	ld	a,(x)
 752  014e 97            	ld	xl,a
 753  014f a604          	ld	a,#4
 754  0151 42            	mul	x,a
 755  0152 72fb0c        	addw	x,(OFST+5,sp)
 756  0155 cd0000        	call	c_ltor
 758  0158 1e0e          	ldw	x,(OFST+7,sp)
 759  015a f6            	ld	a,(x)
 760  015b 97            	ld	xl,a
 761  015c a604          	ld	a,#4
 762  015e 42            	mul	x,a
 763  015f 72fb0c        	addw	x,(OFST+5,sp)
 764  0162 e603          	ld	a,(3,x)
 765  0164 5f            	clrw	x
 766  0165 97            	ld	xl,a
 767  0166 1c0003        	addw	x,#3
 768  0169 01            	rrwa	x,a
 769  016a cd0000        	call	c_llsh
 771  016d 3803          	sll	c_lreg+3
 772  016f 3902          	rlc	c_lreg+2
 773  0171 3901          	rlc	c_lreg+1
 774  0173 3900          	rlc	c_lreg
 775  0175 96            	ldw	x,sp
 776  0176 1c0001        	addw	x,#OFST-6
 777  0179 cd0000        	call	c_ladd
 779  017c 1e0e          	ldw	x,(OFST+7,sp)
 780  017e f6            	ld	a,(x)
 781  017f 97            	ld	xl,a
 782  0180 a604          	ld	a,#4
 783  0182 42            	mul	x,a
 784  0183 72fb0c        	addw	x,(OFST+5,sp)
 785  0186 cd0000        	call	c_rtol
 787                     ; 97 					is_any_input=1;
 789  0189 a601          	ld	a,#1
 790  018b 6b06          	ld	(OFST-1,sp),a
 793  018d 201d          	jra	L122
 794  018f               L732:
 795                     ; 99 					if(is_any_input)
 797  018f 0d06          	tnz	(OFST-1,sp)
 798  0191 2719          	jreq	L122
 799                     ; 101 						(*parameter_count)++;
 801  0193 1e0e          	ldw	x,(OFST+7,sp)
 802  0195 7c            	inc	(x)
 803                     ; 102 						is_any_input=0;
 805  0196 0f06          	clr	(OFST-1,sp)
 807                     ; 103 						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
 809  0198 1e0e          	ldw	x,(OFST+7,sp)
 810  019a f6            	ld	a,(x)
 811  019b 905f          	clrw	y
 812  019d 9097          	ld	yl,a
 813  019f a603          	ld	a,#3
 814  01a1 9062          	div	y,a
 815  01a3 905f          	clrw	y
 816  01a5 9097          	ld	yl,a
 817  01a7 9001          	rrwa	y,a
 818  01a9 f7            	ld	(x),a
 819  01aa 9002          	rlwa	y,a
 820  01ac               L122:
 821                     ; 85 	while(is_developer_valid() && !is_new_line)
 823  01ac cd0000        	call	_is_developer_valid
 825  01af 4d            	tnz	a
 826  01b0 2707          	jreq	L742
 828  01b2 0d05          	tnz	(OFST-2,sp)
 829  01b4 2603          	jrne	L44
 830  01b6 cc00e5        	jp	L512
 831  01b9               L44:
 832  01b9               L742:
 833                     ; 109 }
 836  01b9 5b09          	addw	sp,#9
 837  01bb 81            	ret
 923                     	switch	.const
 924  0074               L05:
 925  0074 00000080      	dc.l	128
 926  0078               L25:
 927  0078 0000000a      	dc.l	10
 928  007c               L45:
 929  007c 00000003      	dc.l	3
 930  0080               L65:
 931  0080 000000ff      	dc.l	255
 932  0084               L06:
 933  0084 0000000c      	dc.l	12
 934                     ; 111 void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count)
 934                     ; 112 {
 935                     	switch	.text
 936  01bc               _execute_terminal_command:
 938  01bc 88            	push	a
 939  01bd 88            	push	a
 940       00000001      OFST:	set	1
 943                     ; 114 	bool is_valid=0;
 945  01be 0f01          	clr	(OFST+0,sp)
 947                     ; 115 	switch(command)
 950                     ; 180 		}break;
 951  01c0 a061          	sub	a,#97
 952  01c2 2603          	jrne	L26
 953  01c4 cc0339        	jp	L562
 954  01c7               L26:
 955  01c7 a004          	sub	a,#4
 956  01c9 2603          	jrne	L46
 957  01cb cc025c        	jp	L752
 958  01ce               L46:
 959  01ce a003          	sub	a,#3
 960  01d0 2779          	jreq	L552
 961  01d2 a004          	sub	a,#4
 962  01d4 2603          	jrne	L66
 963  01d6 cc0293        	jp	L162
 964  01d9               L66:
 965  01d9 a004          	sub	a,#4
 966  01db 270f          	jreq	L152
 967  01dd a004          	sub	a,#4
 968  01df 273f          	jreq	L352
 969  01e1 a003          	sub	a,#3
 970  01e3 2603          	jrne	L07
 971  01e5 cc02f3        	jp	L362
 972  01e8               L07:
 973  01e8 ac530353      	jpf	L723
 974  01ec               L152:
 975                     ; 118 			Serial_print_char(command);
 977  01ec 7b02          	ld	a,(OFST+1,sp)
 978  01ee cd0000        	call	_Serial_print_char
 980                     ; 119 			for(iter=0;iter<parameter_count;iter++)
 982  01f1 0f01          	clr	(OFST+0,sp)
 985  01f3 201d          	jra	L533
 986  01f5               L133:
 987                     ; 121 				Serial_print_char(' ');
 989  01f5 a620          	ld	a,#32
 990  01f7 cd0000        	call	_Serial_print_char
 992                     ; 122 				Serial_print_u32((*parameters)[iter]);
 994  01fa 7b01          	ld	a,(OFST+0,sp)
 995  01fc 97            	ld	xl,a
 996  01fd a604          	ld	a,#4
 997  01ff 42            	mul	x,a
 998  0200 72fb05        	addw	x,(OFST+4,sp)
 999  0203 9093          	ldw	y,x
1000  0205 ee02          	ldw	x,(2,x)
1001  0207 89            	pushw	x
1002  0208 93            	ldw	x,y
1003  0209 fe            	ldw	x,(x)
1004  020a 89            	pushw	x
1005  020b cd0000        	call	_Serial_print_u32
1007  020e 5b04          	addw	sp,#4
1008                     ; 119 			for(iter=0;iter<parameter_count;iter++)
1010  0210 0c01          	inc	(OFST+0,sp)
1012  0212               L533:
1015  0212 7b01          	ld	a,(OFST+0,sp)
1016  0214 1107          	cp	a,(OFST+6,sp)
1017  0216 25dd          	jrult	L133
1018                     ; 124 			is_valid=1;
1020  0218 a601          	ld	a,#1
1021  021a 6b01          	ld	(OFST+0,sp),a
1023                     ; 125 		}break;
1025  021c ac530353      	jpf	L723
1026  0220               L352:
1027                     ; 127 			if(parameter_count) set_millis((*parameters)[0]);
1029  0220 0d07          	tnz	(OFST+6,sp)
1030  0222 2711          	jreq	L143
1033  0224 1e05          	ldw	x,(OFST+4,sp)
1034  0226 9093          	ldw	y,x
1035  0228 ee02          	ldw	x,(2,x)
1036  022a 89            	pushw	x
1037  022b 93            	ldw	x,y
1038  022c fe            	ldw	x,(x)
1039  022d 89            	pushw	x
1040  022e cd0000        	call	_set_millis
1042  0231 5b04          	addw	sp,#4
1044  0233 200e          	jra	L343
1045  0235               L143:
1046                     ; 128 			else Serial_print_u32(millis());
1048  0235 cd0000        	call	_millis
1050  0238 be02          	ldw	x,c_lreg+2
1051  023a 89            	pushw	x
1052  023b be00          	ldw	x,c_lreg
1053  023d 89            	pushw	x
1054  023e cd0000        	call	_Serial_print_u32
1056  0241 5b04          	addw	sp,#4
1057  0243               L343:
1058                     ; 129 			is_valid=1;
1060  0243 a601          	ld	a,#1
1061  0245 6b01          	ld	(OFST+0,sp),a
1063                     ; 130 		}break;
1065  0247 ac530353      	jpf	L723
1066  024b               L552:
1067                     ; 132 			print_welcome();
1069  024b cd005a        	call	_print_welcome
1071                     ; 133 			Serial_print_string("GitHub.com/ScottAlmond/DefCon_31");
1073  024e ae0093        	ldw	x,#L543
1074  0251 cd0000        	call	_Serial_print_string
1076                     ; 134 			is_valid=1;
1078  0254 a601          	ld	a,#1
1079  0256 6b01          	ld	(OFST+0,sp),a
1081                     ; 135 		}break;
1083  0258 ac530353      	jpf	L723
1084  025c               L752:
1085                     ; 137 			if(parameter_count==1)
1087  025c 7b07          	ld	a,(OFST+6,sp)
1088  025e a101          	cp	a,#1
1089  0260 2703          	jreq	L27
1090  0262 cc0353        	jp	L723
1091  0265               L27:
1092                     ; 139 				if((*parameters)[0]<128)
1094  0265 1e05          	ldw	x,(OFST+4,sp)
1095  0267 cd0000        	call	c_ltor
1097  026a ae0074        	ldw	x,#L05
1098  026d cd0000        	call	c_lcmp
1100  0270 2503          	jrult	L47
1101  0272 cc0353        	jp	L723
1102  0275               L47:
1103                     ; 141 					Serial_print_u32(get_eeprom_byte((*parameters)[0]));
1105  0275 1e05          	ldw	x,(OFST+4,sp)
1106  0277 ee02          	ldw	x,(2,x)
1107  0279 cd0000        	call	_get_eeprom_byte
1109  027c b703          	ld	c_lreg+3,a
1110  027e 3f02          	clr	c_lreg+2
1111  0280 3f01          	clr	c_lreg+1
1112  0282 3f00          	clr	c_lreg
1113  0284 be02          	ldw	x,c_lreg+2
1114  0286 89            	pushw	x
1115  0287 be00          	ldw	x,c_lreg
1116  0289 89            	pushw	x
1117  028a cd0000        	call	_Serial_print_u32
1119  028d 5b04          	addw	sp,#4
1120  028f ac530353      	jpf	L723
1121  0293               L162:
1122                     ; 155 			is_valid=1;
1124  0293 a601          	ld	a,#1
1125  0295 6b01          	ld	(OFST+0,sp),a
1127                     ; 156 			if(parameter_count<3) is_valid=0;
1129  0297 7b07          	ld	a,(OFST+6,sp)
1130  0299 a103          	cp	a,#3
1131  029b 2402          	jruge	L353
1134  029d 0f01          	clr	(OFST+0,sp)
1136  029f               L353:
1137                     ; 157 			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
1139  029f 1e05          	ldw	x,(OFST+4,sp)
1140  02a1 cd0000        	call	c_ltor
1142  02a4 ae0078        	ldw	x,#L25
1143  02a7 cd0000        	call	c_lcmp
1145  02aa 2502          	jrult	L553
1148  02ac 0f01          	clr	(OFST+0,sp)
1150  02ae               L553:
1151                     ; 158 			if((*parameters)[1]>=3) is_valid=0;
1153  02ae 1e05          	ldw	x,(OFST+4,sp)
1154  02b0 1c0004        	addw	x,#4
1155  02b3 cd0000        	call	c_ltor
1157  02b6 ae007c        	ldw	x,#L45
1158  02b9 cd0000        	call	c_lcmp
1160  02bc 2502          	jrult	L753
1163  02be 0f01          	clr	(OFST+0,sp)
1165  02c0               L753:
1166                     ; 159 			if((*parameters)[2]>=255) is_valid=0;
1168  02c0 1e05          	ldw	x,(OFST+4,sp)
1169  02c2 1c0008        	addw	x,#8
1170  02c5 cd0000        	call	c_ltor
1172  02c8 ae0080        	ldw	x,#L65
1173  02cb cd0000        	call	c_lcmp
1175  02ce 2502          	jrult	L163
1178  02d0 0f01          	clr	(OFST+0,sp)
1180  02d2               L163:
1181                     ; 160 			if(is_valid)
1183  02d2 0d01          	tnz	(OFST+0,sp)
1184  02d4 2602          	jrne	L67
1185  02d6 207b          	jp	L723
1186  02d8               L67:
1187                     ; 162 				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
1189  02d8 1e05          	ldw	x,(OFST+4,sp)
1190  02da e60b          	ld	a,(11,x)
1191  02dc 88            	push	a
1192  02dd 1e06          	ldw	x,(OFST+5,sp)
1193  02df e607          	ld	a,(7,x)
1194  02e1 97            	ld	xl,a
1195  02e2 1606          	ldw	y,(OFST+5,sp)
1196  02e4 90e603        	ld	a,(3,y)
1197  02e7 95            	ld	xh,a
1198  02e8 cd0000        	call	_set_rgb
1200  02eb 84            	pop	a
1201                     ; 163 				flush_leds(2);//1 RGB led element and 1 for status led
1203  02ec a602          	ld	a,#2
1204  02ee cd0000        	call	_flush_leds
1206  02f1 2060          	jra	L723
1207  02f3               L362:
1208                     ; 167 			is_valid=1;
1210  02f3 a601          	ld	a,#1
1211  02f5 6b01          	ld	(OFST+0,sp),a
1213                     ; 168 			if(parameter_count<2) is_valid=0;
1215  02f7 7b07          	ld	a,(OFST+6,sp)
1216  02f9 a102          	cp	a,#2
1217  02fb 2402          	jruge	L563
1220  02fd 0f01          	clr	(OFST+0,sp)
1222  02ff               L563:
1223                     ; 169 			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
1225  02ff 1e05          	ldw	x,(OFST+4,sp)
1226  0301 cd0000        	call	c_ltor
1228  0304 ae0084        	ldw	x,#L06
1229  0307 cd0000        	call	c_lcmp
1231  030a 2502          	jrult	L763
1234  030c 0f01          	clr	(OFST+0,sp)
1236  030e               L763:
1237                     ; 170 			if((*parameters)[1]>=255) is_valid=0;
1239  030e 1e05          	ldw	x,(OFST+4,sp)
1240  0310 1c0004        	addw	x,#4
1241  0313 cd0000        	call	c_ltor
1243  0316 ae0080        	ldw	x,#L65
1244  0319 cd0000        	call	c_lcmp
1246  031c 2502          	jrult	L173
1249  031e 0f01          	clr	(OFST+0,sp)
1251  0320               L173:
1252                     ; 171 			if(is_valid)
1254  0320 0d01          	tnz	(OFST+0,sp)
1255  0322 272f          	jreq	L723
1256                     ; 173 				set_white((*parameters)[0],(*parameters)[1]);
1258  0324 1e05          	ldw	x,(OFST+4,sp)
1259  0326 e607          	ld	a,(7,x)
1260  0328 97            	ld	xl,a
1261  0329 1605          	ldw	y,(OFST+4,sp)
1262  032b 90e603        	ld	a,(3,y)
1263  032e 95            	ld	xh,a
1264  032f cd0000        	call	_set_white
1266                     ; 174 				flush_leds(2);//1 RGB led element and 1 for status led
1268  0332 a602          	ld	a,#2
1269  0334 cd0000        	call	_flush_leds
1271  0337 201a          	jra	L723
1272  0339               L562:
1273                     ; 178 			Serial_print_u32(get_audio_level());
1275  0339 cd0000        	call	_get_audio_level
1277  033c b703          	ld	c_lreg+3,a
1278  033e 3f02          	clr	c_lreg+2
1279  0340 3f01          	clr	c_lreg+1
1280  0342 3f00          	clr	c_lreg
1281  0344 be02          	ldw	x,c_lreg+2
1282  0346 89            	pushw	x
1283  0347 be00          	ldw	x,c_lreg
1284  0349 89            	pushw	x
1285  034a cd0000        	call	_Serial_print_u32
1287  034d 5b04          	addw	sp,#4
1288                     ; 179 			is_valid=1;
1290  034f a601          	ld	a,#1
1291  0351 6b01          	ld	(OFST+0,sp),a
1293                     ; 180 		}break;
1295  0353               L723:
1296                     ; 182 	if(!is_valid) Serial_print_string("Invalid. h");
1298  0353 0d01          	tnz	(OFST+0,sp)
1299  0355 2606          	jrne	L573
1302  0357 ae0088        	ldw	x,#L773
1303  035a cd0000        	call	_Serial_print_string
1305  035d               L573:
1306                     ; 183 	Serial_newline();
1308  035d cd0000        	call	_Serial_newline
1310                     ; 184 }
1313  0360 85            	popw	x
1314  0361 81            	ret
1327                     	xref	_Serial_print_u32
1328                     	xref	_Serial_read_char
1329                     	xref	_Serial_available
1330                     	xref	_Serial_newline
1331                     	xref	_Serial_print_string
1332                     	xref	_Serial_print_char
1333                     	xdef	_print_welcome
1334                     	xdef	_execute_terminal_command
1335                     	xdef	_get_terminal_command
1336                     	xdef	_run_developer
1337                     	xdef	_setup_developer
1338                     	xref	_get_eeprom_byte
1339                     	xref	_set_millis
1340                     	xref	_get_audio_level
1341                     	xref	_is_space_sao
1342                     	xref	_clear_button_events
1343                     	xref	_is_developer_valid
1344                     	xref	_flush_leds
1345                     	xref	_set_debug
1346                     	xref	_set_white
1347                     	xref	_set_rgb
1348                     	xref	_millis
1349                     	xref	_setup_serial
1350                     	switch	.const
1351  0088               L773:
1352  0088 496e76616c69  	dc.b	"Invalid. h",0
1353  0093               L543:
1354  0093 476974487562  	dc.b	"GitHub.com/ScottAl"
1355  00a5 6d6f6e642f44  	dc.b	"mond/DefCon_31",0
1356  00b4               L55:
1357  00b4 3e2000        	dc.b	"> ",0
1358                     	xref.b	c_lreg
1359                     	xref.b	c_x
1379                     	xref	c_lcmp
1380                     	xref	c_ladd
1381                     	xref	c_rtol
1382                     	xref	c_itolx
1383                     	xref	c_llsh
1384                     	xref	c_ltor
1385                     	xref	c_xymov
1386                     	end
