   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _api_counter:
  16  0000 00000000      	dc.l	0
  17  0004               _pwm_sleep_remaining:
  18  0004 0000          	dc.w	0
  19  0006               _pwm_led_index:
  20  0006 00            	dc.b	0
  21  0007               _pwm_state:
  22  0007 00            	dc.b	0
  23  0008               _button_start_ms:
  24  0008 00000000      	dc.l	0
  25  000c               _is_right_button_down:
  26  000c 00            	dc.b	0
  27  000d               _audio_measurement_count:
  28  000d 00            	dc.b	0
  86                     ; 41 u16 get_random(u16 x)
  86                     ; 42 {
  88                     	switch	.text
  89  0000               _get_random:
  91  0000 5204          	subw	sp,#4
  92       00000004      OFST:	set	4
  95                     ; 43 	u16 a=1664525;
  97                     ; 44 	u16 c=1013904223;
  99                     ; 45 	return a * x + c;
 101  0002 90ae660d      	ldw	y,#26125
 102  0006 cd0000        	call	c_imul
 104  0009 1cf35f        	addw	x,#62303
 107  000c 5b04          	addw	sp,#4
 108  000e 81            	ret
 177                     .const:	section	.text
 178  0000               L21:
 179  0000 0001c200      	dc.l	115200
 180                     ; 48 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 180                     ; 49 {
 181                     	switch	.text
 182  000f               _setup_serial:
 184  000f 89            	pushw	x
 185       00000000      OFST:	set	0
 188                     ; 50 	if(is_enabled)
 190  0010 9e            	ld	a,xh
 191  0011 4d            	tnz	a
 192  0012 2747          	jreq	L17
 193                     ; 52 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 195  0014 4bf0          	push	#240
 196  0016 4b20          	push	#32
 197  0018 ae500f        	ldw	x,#20495
 198  001b cd0000        	call	_GPIO_Init
 200  001e 85            	popw	x
 201                     ; 53 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 203  001f 4b40          	push	#64
 204  0021 4b40          	push	#64
 205  0023 ae500f        	ldw	x,#20495
 206  0026 cd0000        	call	_GPIO_Init
 208  0029 85            	popw	x
 209                     ; 54 		UART1_DeInit();
 211  002a cd0000        	call	_UART1_DeInit
 213                     ; 55 		UART1_Init(is_fast_baud_rate?115200:9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 215  002d 4b0c          	push	#12
 216  002f 4b80          	push	#128
 217  0031 4b00          	push	#0
 218  0033 4b00          	push	#0
 219  0035 4b00          	push	#0
 220  0037 0d07          	tnz	(OFST+7,sp)
 221  0039 2708          	jreq	L01
 222  003b ae0000        	ldw	x,#L21
 223  003e cd0000        	call	c_ltor
 225  0041 2006          	jra	L41
 226  0043               L01:
 227  0043 ae2580        	ldw	x,#9600
 228  0046 cd0000        	call	c_itolx
 230  0049               L41:
 231  0049 be02          	ldw	x,c_lreg+2
 232  004b 89            	pushw	x
 233  004c be00          	ldw	x,c_lreg
 234  004e 89            	pushw	x
 235  004f cd0000        	call	_UART1_Init
 237  0052 5b09          	addw	sp,#9
 238                     ; 57 		UART1_Cmd(ENABLE);
 240  0054 a601          	ld	a,#1
 241  0056 cd0000        	call	_UART1_Cmd
 244  0059 201d          	jra	L37
 245  005b               L17:
 246                     ; 59 		UART1_Cmd(DISABLE);
 248  005b 4f            	clr	a
 249  005c cd0000        	call	_UART1_Cmd
 251                     ; 60 		UART1_DeInit();
 253  005f cd0000        	call	_UART1_DeInit
 255                     ; 61 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 257  0062 4b40          	push	#64
 258  0064 4b20          	push	#32
 259  0066 ae500f        	ldw	x,#20495
 260  0069 cd0000        	call	_GPIO_Init
 262  006c 85            	popw	x
 263                     ; 62 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 265  006d 4b40          	push	#64
 266  006f 4b40          	push	#64
 267  0071 ae500f        	ldw	x,#20495
 268  0074 cd0000        	call	_GPIO_Init
 270  0077 85            	popw	x
 271  0078               L37:
 272                     ; 64 }
 275  0078 85            	popw	x
 276  0079 81            	ret
 303                     ; 67 bool is_application_valid()
 303                     ; 68 { return !is_button_down(2) && !get_button_event(0,1); }
 304                     	switch	.text
 305  007a               _is_application_valid:
 311  007a a602          	ld	a,#2
 312  007c cd01ef        	call	_is_button_down
 314  007f 4d            	tnz	a
 315  0080 260d          	jrne	L02
 316  0082 ae0001        	ldw	x,#1
 317  0085 cd01a0        	call	_get_button_event
 319  0088 4d            	tnz	a
 320  0089 2604          	jrne	L02
 321  008b a601          	ld	a,#1
 322  008d 2001          	jra	L22
 323  008f               L02:
 324  008f 4f            	clr	a
 325  0090               L22:
 328  0090 81            	ret
 354                     ; 71 bool is_developer_valid()
 354                     ; 72 { return is_button_down(2) && !get_button_event(0,1); }
 355                     	switch	.text
 356  0091               _is_developer_valid:
 362  0091 a602          	ld	a,#2
 363  0093 cd01ef        	call	_is_button_down
 365  0096 4d            	tnz	a
 366  0097 270d          	jreq	L62
 367  0099 ae0001        	ldw	x,#1
 368  009c cd01a0        	call	_get_button_event
 370  009f 4d            	tnz	a
 371  00a0 2604          	jrne	L62
 372  00a2 a601          	ld	a,#1
 373  00a4 2001          	jra	L03
 374  00a6               L62:
 375  00a6 4f            	clr	a
 376  00a7               L03:
 379  00a7 81            	ret
 404                     ; 75 bool is_sleep_valid()
 404                     ; 76 { return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1)); }
 405                     	switch	.text
 406  00a8               _is_sleep_valid:
 412  00a8 5f            	clrw	x
 413  00a9 cd01a0        	call	_get_button_event
 415  00ac 4d            	tnz	a
 416  00ad 261f          	jrne	L43
 417  00af ae0100        	ldw	x,#256
 418  00b2 cd01a0        	call	_get_button_event
 420  00b5 4d            	tnz	a
 421  00b6 2616          	jrne	L43
 422  00b8 ae0001        	ldw	x,#1
 423  00bb cd01a0        	call	_get_button_event
 425  00be 4d            	tnz	a
 426  00bf 260d          	jrne	L43
 427  00c1 ae0101        	ldw	x,#257
 428  00c4 cd01a0        	call	_get_button_event
 430  00c7 4d            	tnz	a
 431  00c8 2604          	jrne	L43
 432  00ca a601          	ld	a,#1
 433  00cc 2001          	jra	L63
 434  00ce               L43:
 435  00ce 4f            	clr	a
 436  00cf               L63:
 439  00cf 81            	ret
 464                     ; 78 void setup_main()
 464                     ; 79 {
 465                     	switch	.text
 466  00d0               _setup_main:
 470                     ; 80 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 472  00d0 c650c6        	ld	a,20678
 473  00d3 a4e7          	and	a,#231
 474  00d5 c750c6        	ld	20678,a
 475                     ; 82 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 477  00d8 4b40          	push	#64
 478  00da 4b02          	push	#2
 479  00dc ae500f        	ldw	x,#20495
 480  00df cd0000        	call	_GPIO_Init
 482  00e2 85            	popw	x
 483                     ; 85 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 485  00e3 725f5311      	clr	21265
 486                     ; 86 	TIM2->PSCR= 6;// init divider register 16MHz/2^X
 488  00e7 3506530e      	mov	21262,#6
 489                     ; 87 	TIM2->ARRH= 0;// init auto reload register
 491  00eb 725f530f      	clr	21263
 492                     ; 88 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 494  00ef 35fa5310      	mov	21264,#250
 495                     ; 89 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 497  00f3 c65300        	ld	a,21248
 498  00f6 aa85          	or	a,#133
 499  00f8 c75300        	ld	21248,a
 500                     ; 90 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 502  00fb 35035303      	mov	21251,#3
 503                     ; 91 	enableInterrupts();
 506  00ff 9a            rim
 508                     ; 107 }
 512  0100 81            	ret
 536                     ; 109 u32 millis()
 536                     ; 110 {
 537                     	switch	.text
 538  0101               _millis:
 542                     ; 111 	return api_counter;
 544  0101 ae0000        	ldw	x,#_api_counter
 545  0104 cd0000        	call	c_ltor
 549  0107 81            	ret
 584                     ; 114 void set_millis(u32 new_time)
 584                     ; 115 {
 585                     	switch	.text
 586  0108               _set_millis:
 588       00000000      OFST:	set	0
 591                     ; 116 	api_counter=new_time;
 593  0108 1e05          	ldw	x,(OFST+5,sp)
 594  010a bf02          	ldw	_api_counter+2,x
 595  010c 1e03          	ldw	x,(OFST+3,sp)
 596  010e bf00          	ldw	_api_counter,x
 597                     ; 117 }
 600  0110 81            	ret
 649                     	switch	.const
 650  0004               L05:
 651  0004 00000201      	dc.l	513
 652  0008               L25:
 653  0008 00000033      	dc.l	51
 654                     ; 121 void update_buttons()
 654                     ; 122 {
 655                     	switch	.text
 656  0111               _update_buttons:
 658  0111 5205          	subw	sp,#5
 659       00000005      OFST:	set	5
 662                     ; 125 	if(button_start_ms)
 664  0113 ae0008        	ldw	x,#_button_start_ms
 665  0116 cd0000        	call	c_lzmp
 667  0119 275a          	jreq	L502
 668                     ; 130 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 670  011b a6ff          	ld	a,#255
 671  011d cd04a3        	call	_set_debug
 673                     ; 132 		if(!is_button_down(is_right_button_down))
 675  0120 b60c          	ld	a,_is_right_button_down
 676  0122 cd01ef        	call	_is_button_down
 678  0125 4d            	tnz	a
 679  0126 2675          	jrne	L712
 680                     ; 134 			elapsed_pressed_ms=millis()-button_start_ms;
 682  0128 add7          	call	_millis
 684  012a ae0008        	ldw	x,#_button_start_ms
 685  012d cd0000        	call	c_lsub
 687  0130 96            	ldw	x,sp
 688  0131 1c0001        	addw	x,#OFST-4
 689  0134 cd0000        	call	c_rtol
 692                     ; 135 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[is_right_button_down][1]=1;
 694  0137 96            	ldw	x,sp
 695  0138 1c0001        	addw	x,#OFST-4
 696  013b cd0000        	call	c_ltor
 698  013e ae0004        	ldw	x,#L05
 699  0141 cd0000        	call	c_lcmp
 701  0144 250b          	jrult	L112
 704  0146 b60c          	ld	a,_is_right_button_down
 705  0148 5f            	clrw	x
 706  0149 97            	ld	xl,a
 707  014a 58            	sllw	x
 708  014b a601          	ld	a,#1
 709  014d e707          	ld	(_button_pressed_event+1,x),a
 711  014f 2018          	jra	L312
 712  0151               L112:
 713                     ; 136 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[is_right_button_down][0]=1;
 715  0151 96            	ldw	x,sp
 716  0152 1c0001        	addw	x,#OFST-4
 717  0155 cd0000        	call	c_ltor
 719  0158 ae0008        	ldw	x,#L25
 720  015b cd0000        	call	c_lcmp
 722  015e 2509          	jrult	L312
 725  0160 b60c          	ld	a,_is_right_button_down
 726  0162 5f            	clrw	x
 727  0163 97            	ld	xl,a
 728  0164 58            	sllw	x
 729  0165 a601          	ld	a,#1
 730  0167 e706          	ld	(_button_pressed_event,x),a
 731  0169               L312:
 732                     ; 137 			button_start_ms=0;
 734  0169 ae0000        	ldw	x,#0
 735  016c bf0a          	ldw	_button_start_ms+2,x
 736  016e ae0000        	ldw	x,#0
 737  0171 bf08          	ldw	_button_start_ms,x
 738  0173 2028          	jra	L712
 739  0175               L502:
 740                     ; 140 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 742  0175 0f05          	clr	(OFST+0,sp)
 745  0177 2016          	jra	L522
 746  0179               L122:
 747                     ; 142 			if(is_button_down(button_index))
 749  0179 7b05          	ld	a,(OFST+0,sp)
 750  017b ad72          	call	_is_button_down
 752  017d 4d            	tnz	a
 753  017e 270d          	jreq	L132
 754                     ; 144 				is_right_button_down=button_index;
 756  0180 7b05          	ld	a,(OFST+0,sp)
 757  0182 b70c          	ld	_is_right_button_down,a
 758                     ; 145 				button_start_ms=millis();
 760  0184 cd0101        	call	_millis
 762  0187 ae0008        	ldw	x,#_button_start_ms
 763  018a cd0000        	call	c_rtol
 765  018d               L132:
 766                     ; 140 		for(button_index=0;button_index<BUTTON_COUNT && !button_start_ms;button_index++)
 768  018d 0c05          	inc	(OFST+0,sp)
 770  018f               L522:
 773  018f 7b05          	ld	a,(OFST+0,sp)
 774  0191 a102          	cp	a,#2
 775  0193 2408          	jruge	L712
 777  0195 ae0008        	ldw	x,#_button_start_ms
 778  0198 cd0000        	call	c_lzmp
 780  019b 27dc          	jreq	L122
 781  019d               L712:
 782                     ; 149 }
 785  019d 5b05          	addw	sp,#5
 786  019f 81            	ret
 832                     ; 152 bool get_button_event(u8 button_index,bool is_long)
 832                     ; 153 { return button_pressed_event[button_index][is_long]; }
 833                     	switch	.text
 834  01a0               _get_button_event:
 836  01a0 89            	pushw	x
 837       00000000      OFST:	set	0
 842  01a1 9e            	ld	a,xh
 843  01a2 5f            	clrw	x
 844  01a3 97            	ld	xl,a
 845  01a4 58            	sllw	x
 846  01a5 01            	rrwa	x,a
 847  01a6 1b02          	add	a,(OFST+2,sp)
 848  01a8 2401          	jrnc	L65
 849  01aa 5c            	incw	x
 850  01ab               L65:
 851  01ab 02            	rlwa	x,a
 852  01ac e606          	ld	a,(_button_pressed_event,x)
 855  01ae 85            	popw	x
 856  01af 81            	ret
 912                     ; 156 bool clear_button_event(u8 button_index,bool is_long)
 912                     ; 157 {
 913                     	switch	.text
 914  01b0               _clear_button_event:
 916  01b0 89            	pushw	x
 917  01b1 88            	push	a
 918       00000001      OFST:	set	1
 921                     ; 158 	bool out=button_pressed_event[button_index][is_long];
 923  01b2 9e            	ld	a,xh
 924  01b3 5f            	clrw	x
 925  01b4 97            	ld	xl,a
 926  01b5 58            	sllw	x
 927  01b6 01            	rrwa	x,a
 928  01b7 1b03          	add	a,(OFST+2,sp)
 929  01b9 2401          	jrnc	L26
 930  01bb 5c            	incw	x
 931  01bc               L26:
 932  01bc 02            	rlwa	x,a
 933  01bd e606          	ld	a,(_button_pressed_event,x)
 934  01bf 6b01          	ld	(OFST+0,sp),a
 936                     ; 159 	button_pressed_event[button_index][is_long]=0;
 938  01c1 7b02          	ld	a,(OFST+1,sp)
 939  01c3 5f            	clrw	x
 940  01c4 97            	ld	xl,a
 941  01c5 58            	sllw	x
 942  01c6 01            	rrwa	x,a
 943  01c7 1b03          	add	a,(OFST+2,sp)
 944  01c9 2401          	jrnc	L46
 945  01cb 5c            	incw	x
 946  01cc               L46:
 947  01cc 02            	rlwa	x,a
 948  01cd 6f06          	clr	(_button_pressed_event,x)
 949                     ; 160 	return out;
 951  01cf 7b01          	ld	a,(OFST+0,sp)
 954  01d1 5b03          	addw	sp,#3
 955  01d3 81            	ret
 991                     ; 163 void clear_button_events()
 991                     ; 164 {
 992                     	switch	.text
 993  01d4               _clear_button_events:
 995  01d4 88            	push	a
 996       00000001      OFST:	set	1
 999                     ; 166 	for(iter=0;iter<BUTTON_COUNT;iter++)
1001  01d5 0f01          	clr	(OFST+0,sp)
1003  01d7               L323:
1004                     ; 168 		clear_button_event(iter,0);
1006  01d7 7b01          	ld	a,(OFST+0,sp)
1007  01d9 5f            	clrw	x
1008  01da 95            	ld	xh,a
1009  01db add3          	call	_clear_button_event
1011                     ; 169 		clear_button_event(iter,1);
1013  01dd 7b01          	ld	a,(OFST+0,sp)
1014  01df ae0001        	ldw	x,#1
1015  01e2 95            	ld	xh,a
1016  01e3 adcb          	call	_clear_button_event
1018                     ; 166 	for(iter=0;iter<BUTTON_COUNT;iter++)
1020  01e5 0c01          	inc	(OFST+0,sp)
1024  01e7 7b01          	ld	a,(OFST+0,sp)
1025  01e9 a102          	cp	a,#2
1026  01eb 25ea          	jrult	L323
1027                     ; 171 }
1030  01ed 84            	pop	a
1031  01ee 81            	ret
1067                     ; 174 bool is_button_down(u8 index)
1067                     ; 175 {
1068                     	switch	.text
1069  01ef               _is_button_down:
1073                     ; 176 	switch(index)
1076                     ; 180 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1078  01ef 4d            	tnz	a
1079  01f0 2708          	jreq	L133
1080  01f2 4a            	dec	a
1081  01f3 2718          	jreq	L333
1082  01f5 4a            	dec	a
1083  01f6 2728          	jreq	L533
1084  01f8 2039          	jra	L753
1085  01fa               L133:
1086                     ; 178 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1088  01fa 4b20          	push	#32
1089  01fc ae500f        	ldw	x,#20495
1090  01ff cd0000        	call	_GPIO_ReadInputPin
1092  0202 5b01          	addw	sp,#1
1093  0204 4d            	tnz	a
1094  0205 2604          	jrne	L27
1095  0207 a601          	ld	a,#1
1096  0209 2001          	jra	L47
1097  020b               L27:
1098  020b 4f            	clr	a
1099  020c               L47:
1102  020c 81            	ret
1103  020d               L333:
1104                     ; 179 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1107  020d 4b40          	push	#64
1108  020f ae500f        	ldw	x,#20495
1109  0212 cd0000        	call	_GPIO_ReadInputPin
1111  0215 5b01          	addw	sp,#1
1112  0217 4d            	tnz	a
1113  0218 2604          	jrne	L67
1114  021a a601          	ld	a,#1
1115  021c 2001          	jra	L001
1116  021e               L67:
1117  021e 4f            	clr	a
1118  021f               L001:
1121  021f 81            	ret
1122  0220               L533:
1123                     ; 180 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1126  0220 4b02          	push	#2
1127  0222 ae500f        	ldw	x,#20495
1128  0225 cd0000        	call	_GPIO_ReadInputPin
1130  0228 5b01          	addw	sp,#1
1131  022a 4d            	tnz	a
1132  022b 2604          	jrne	L201
1133  022d a601          	ld	a,#1
1134  022f 2001          	jra	L401
1135  0231               L201:
1136  0231 4f            	clr	a
1137  0232               L401:
1140  0232 81            	ret
1141  0233               L753:
1142                     ; 182 	return 0;
1144  0233 4f            	clr	a
1147  0234 81            	ret
1171                     ; 205 u8 get_audio_level()
1171                     ; 206 { return audio_std; }
1172                     	switch	.text
1173  0235               _get_audio_level:
1179  0235 b604          	ld	a,_audio_std
1182  0237 81            	ret
1208                     ; 209 @svlreg @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1210                     	switch	.text
1211  0238               f_TIM2_UPD_OVF_IRQHandler:
1213  0238 8a            	push	cc
1214  0239 84            	pop	a
1215  023a a4bf          	and	a,#191
1216  023c 88            	push	a
1217  023d 86            	pop	cc
1218  023e 3b0002        	push	c_x+2
1219  0241 be00          	ldw	x,c_x
1220  0243 89            	pushw	x
1221  0244 3b0002        	push	c_y+2
1222  0247 be00          	ldw	x,c_y
1223  0249 89            	pushw	x
1224  024a be02          	ldw	x,c_lreg+2
1225  024c 89            	pushw	x
1226  024d be00          	ldw	x,c_lreg
1227  024f 89            	pushw	x
1230                     ; 210 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1232  0250 72115304      	bres	21252,#0
1233                     ; 211 	api_counter++;
1235  0254 ae0000        	ldw	x,#_api_counter
1236  0257 a601          	ld	a,#1
1237  0259 cd0000        	call	c_lgadc
1239                     ; 213 	update_buttons();
1241  025c cd0111        	call	_update_buttons
1243                     ; 215 }
1246  025f 85            	popw	x
1247  0260 bf00          	ldw	c_lreg,x
1248  0262 85            	popw	x
1249  0263 bf02          	ldw	c_lreg+2,x
1250  0265 85            	popw	x
1251  0266 bf00          	ldw	c_y,x
1252  0268 320002        	pop	c_y+2
1253  026b 85            	popw	x
1254  026c bf00          	ldw	c_x,x
1255  026e 320002        	pop	c_x+2
1256  0271 80            	iret
1308                     ; 218 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
1309                     	switch	.text
1310  0272               f_TIM2_CapComp_IRQ_Handler:
1312  0272 8a            	push	cc
1313  0273 84            	pop	a
1314  0274 a4bf          	and	a,#191
1315  0276 88            	push	a
1316  0277 86            	pop	cc
1317       00000004      OFST:	set	4
1318  0278 3b0002        	push	c_x+2
1319  027b be00          	ldw	x,c_x
1320  027d 89            	pushw	x
1321  027e 3b0002        	push	c_y+2
1322  0281 be00          	ldw	x,c_y
1323  0283 89            	pushw	x
1324  0284 5204          	subw	sp,#4
1327                     ; 220 	u8 sleep_amount=PWM_MAX_PERIOD;//max sleep duration before wrap-over occurs
1329  0286 a6fa          	ld	a,#250
1330  0288 6b04          	ld	(OFST+0,sp),a
1332                     ; 221 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1334  028a b607          	ld	a,_pwm_state
1335  028c a401          	and	a,#1
1336  028e 6b03          	ld	(OFST-1,sp),a
1338                     ; 223 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
1340  0290 72135304      	bres	21252,#1
1341                     ; 225 	if(pwm_sleep_remaining==0)
1343  0294 be04          	ldw	x,_pwm_sleep_remaining
1344  0296 2657          	jrne	L324
1345                     ; 227 		set_matrix_high_z();
1347  0298 cd04ba        	call	_set_matrix_high_z
1349                     ; 228 		if(pwm_led_index<pwm_led_count[buffer_index])
1351  029b 7b03          	ld	a,(OFST-1,sp)
1352  029d 5f            	clrw	x
1353  029e 97            	ld	xl,a
1354  029f e60a          	ld	a,(_pwm_led_count,x)
1355  02a1 b106          	cp	a,_pwm_led_index
1356  02a3 2333          	jrule	L524
1357                     ; 230 			set_led(pwm_brightness[pwm_led_index][0][buffer_index]);//turn on the next LED
1359  02a5 b606          	ld	a,_pwm_led_index
1360  02a7 97            	ld	xl,a
1361  02a8 a604          	ld	a,#4
1362  02aa 42            	mul	x,a
1363  02ab 01            	rrwa	x,a
1364  02ac 1b03          	add	a,(OFST-1,sp)
1365  02ae 2401          	jrnc	L411
1366  02b0 5c            	incw	x
1367  02b1               L411:
1368  02b1 02            	rlwa	x,a
1369  02b2 e610          	ld	a,(_pwm_brightness,x)
1370  02b4 cd04dc        	call	_set_led
1372                     ; 231 			pwm_sleep_remaining=0x00FF&(pwm_brightness[pwm_led_index][1][buffer_index]+15);//set how long to sleep in this state //+15 works ok here as magic number to correct timing errors from interrupts
1374  02b7 b606          	ld	a,_pwm_led_index
1375  02b9 97            	ld	xl,a
1376  02ba a604          	ld	a,#4
1377  02bc 42            	mul	x,a
1378  02bd 01            	rrwa	x,a
1379  02be 1b03          	add	a,(OFST-1,sp)
1380  02c0 2401          	jrnc	L611
1381  02c2 5c            	incw	x
1382  02c3               L611:
1383  02c3 02            	rlwa	x,a
1384  02c4 e612          	ld	a,(_pwm_brightness+2,x)
1385  02c6 5f            	clrw	x
1386  02c7 97            	ld	xl,a
1387  02c8 1c000f        	addw	x,#15
1388  02cb 01            	rrwa	x,a
1389  02cc a4ff          	and	a,#255
1390  02ce 5f            	clrw	x
1391  02cf b705          	ld	_pwm_sleep_remaining+1,a
1392  02d1 9f            	ld	a,xl
1393  02d2 b704          	ld	_pwm_sleep_remaining,a
1394                     ; 232 			pwm_led_index++;//prepare state machine to go to the next led later
1396  02d4 3c06          	inc	_pwm_led_index
1398  02d6 2017          	jra	L324
1399  02d8               L524:
1400                     ; 234 			pwm_led_index=0;//reset state machine to 0
1402  02d8 3f06          	clr	_pwm_led_index
1403                     ; 235 			pwm_sleep_remaining=pwm_sleep[buffer_index];
1405  02da 7b03          	ld	a,(OFST-1,sp)
1406  02dc 5f            	clrw	x
1407  02dd 97            	ld	xl,a
1408  02de 58            	sllw	x
1409  02df ee0c          	ldw	x,(_pwm_sleep,x)
1410  02e1 bf04          	ldw	_pwm_sleep_remaining,x
1411                     ; 236 			if(pwm_state&0x02) pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1413  02e3 b607          	ld	a,_pwm_state
1414  02e5 a502          	bcp	a,#2
1415  02e7 2706          	jreq	L324
1418  02e9 b607          	ld	a,_pwm_state
1419  02eb a803          	xor	a,#3
1420  02ed b707          	ld	_pwm_state,a
1421  02ef               L324:
1422                     ; 239 	sleep_amount=pwm_sleep_remaining<sleep_amount?pwm_sleep_remaining:sleep_amount;
1424  02ef 7b04          	ld	a,(OFST+0,sp)
1425  02f1 5f            	clrw	x
1426  02f2 97            	ld	xl,a
1427  02f3 bf00          	ldw	c_x,x
1428  02f5 be04          	ldw	x,_pwm_sleep_remaining
1429  02f7 b300          	cpw	x,c_x
1430  02f9 2404          	jruge	L021
1431  02fb b605          	ld	a,_pwm_sleep_remaining+1
1432  02fd 2002          	jra	L221
1433  02ff               L021:
1434  02ff 7b04          	ld	a,(OFST+0,sp)
1435  0301               L221:
1436  0301 6b04          	ld	(OFST+0,sp),a
1438                     ; 240 	pwm_sleep_remaining-=sleep_amount;
1440  0303 7b04          	ld	a,(OFST+0,sp)
1441  0305 5f            	clrw	x
1442  0306 97            	ld	xl,a
1443  0307 1f01          	ldw	(OFST-3,sp),x
1445  0309 be04          	ldw	x,_pwm_sleep_remaining
1446  030b 72f001        	subw	x,(OFST-3,sp)
1447  030e bf04          	ldw	_pwm_sleep_remaining,x
1448                     ; 242 	TIM2->CCR1L = ( (TIM2->CCR1L) + sleep_amount )%PWM_MAX_PERIOD;//set wakeup alarm relative to current time
1450  0310 c65312        	ld	a,21266
1451  0313 5f            	clrw	x
1452  0314 1b04          	add	a,(OFST+0,sp)
1453  0316 2401          	jrnc	L421
1454  0318 5c            	incw	x
1455  0319               L421:
1456  0319 02            	rlwa	x,a
1457  031a 90ae00fa      	ldw	y,#250
1458  031e cd0000        	call	c_idiv
1460  0321 51            	exgw	x,y
1461  0322 01            	rrwa	x,a
1462  0323 c75312        	ld	21266,a
1463  0326 02            	rlwa	x,a
1464                     ; 243 }
1467  0327 5b04          	addw	sp,#4
1468  0329 85            	popw	x
1469  032a bf00          	ldw	c_y,x
1470  032c 320002        	pop	c_y+2
1471  032f 85            	popw	x
1472  0330 bf00          	ldw	c_x,x
1473  0332 320002        	pop	c_x+2
1474  0335 80            	iret
1539                     ; 245 void flush_leds(u8 led_count)
1539                     ; 246 {
1541                     	switch	.text
1542  0336               _flush_leds:
1544  0336 88            	push	a
1545  0337 5203          	subw	sp,#3
1546       00000003      OFST:	set	3
1549                     ; 247 	u8 led_read_index=0,led_write_index=0;
1553  0339 0f02          	clr	(OFST-1,sp)
1556  033b               L174:
1557                     ; 249 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1559  033b b607          	ld	a,_pwm_state
1560  033d a502          	bcp	a,#2
1561  033f 26fa          	jrne	L174
1562                     ; 250 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1564  0341 b607          	ld	a,_pwm_state
1565  0343 a401          	and	a,#1
1566  0345 a801          	xor	a,#1
1567  0347 6b01          	ld	(OFST-2,sp),a
1569                     ; 251 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1571  0349 7b04          	ld	a,(OFST+1,sp)
1572  034b 5f            	clrw	x
1573  034c 97            	ld	xl,a
1574  034d 4f            	clr	a
1575  034e 02            	rlwa	x,a
1576  034f 7b01          	ld	a,(OFST-2,sp)
1577  0351 905f          	clrw	y
1578  0353 9097          	ld	yl,a
1579  0355 9058          	sllw	y
1580  0357 90ef0c        	ldw	(_pwm_sleep,y),x
1581                     ; 253 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1583  035a 0f03          	clr	(OFST+0,sp)
1586  035c 205d          	jra	L105
1587  035e               L574:
1588                     ; 255 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1590  035e 7b03          	ld	a,(OFST+0,sp)
1591  0360 5f            	clrw	x
1592  0361 97            	ld	xl,a
1593  0362 e6bc          	ld	a,(_pwm_brightness_buffer,x)
1594  0364 a105          	cp	a,#5
1595  0366 254b          	jrult	L505
1596                     ; 257 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1598  0368 7b02          	ld	a,(OFST-1,sp)
1599  036a 97            	ld	xl,a
1600  036b a604          	ld	a,#4
1601  036d 42            	mul	x,a
1602  036e 01            	rrwa	x,a
1603  036f 1b01          	add	a,(OFST-2,sp)
1604  0371 2401          	jrnc	L031
1605  0373 5c            	incw	x
1606  0374               L031:
1607  0374 02            	rlwa	x,a
1608  0375 7b03          	ld	a,(OFST+0,sp)
1609  0377 e710          	ld	(_pwm_brightness,x),a
1610                     ; 258 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1612  0379 7b02          	ld	a,(OFST-1,sp)
1613  037b 97            	ld	xl,a
1614  037c a604          	ld	a,#4
1615  037e 42            	mul	x,a
1616  037f 01            	rrwa	x,a
1617  0380 1b01          	add	a,(OFST-2,sp)
1618  0382 2401          	jrnc	L231
1619  0384 5c            	incw	x
1620  0385               L231:
1621  0385 02            	rlwa	x,a
1622  0386 7b03          	ld	a,(OFST+0,sp)
1623  0388 905f          	clrw	y
1624  038a 9097          	ld	yl,a
1625  038c 90e6bc        	ld	a,(_pwm_brightness_buffer,y)
1626  038f e712          	ld	(_pwm_brightness+2,x),a
1627                     ; 259 			led_write_index++;
1629  0391 0c02          	inc	(OFST-1,sp)
1631                     ; 260 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1633  0393 7b01          	ld	a,(OFST-2,sp)
1634  0395 5f            	clrw	x
1635  0396 97            	ld	xl,a
1636  0397 58            	sllw	x
1637  0398 7b03          	ld	a,(OFST+0,sp)
1638  039a 905f          	clrw	y
1639  039c 9097          	ld	yl,a
1640  039e 90e6bc        	ld	a,(_pwm_brightness_buffer,y)
1641  03a1 905f          	clrw	y
1642  03a3 9097          	ld	yl,a
1643  03a5 9001          	rrwa	y,a
1644  03a7 e00d          	sub	a,(_pwm_sleep+1,x)
1645  03a9 9001          	rrwa	y,a
1646  03ab e20c          	sbc	a,(_pwm_sleep,x)
1647  03ad 9001          	rrwa	y,a
1648  03af 9050          	negw	y
1649  03b1 ef0c          	ldw	(_pwm_sleep,x),y
1650  03b3               L505:
1651                     ; 262 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1653  03b3 7b03          	ld	a,(OFST+0,sp)
1654  03b5 5f            	clrw	x
1655  03b6 97            	ld	xl,a
1656  03b7 6fbc          	clr	(_pwm_brightness_buffer,x)
1657                     ; 253 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1659  03b9 0c03          	inc	(OFST+0,sp)
1661  03bb               L105:
1664  03bb 7b03          	ld	a,(OFST+0,sp)
1665  03bd a12b          	cp	a,#43
1666  03bf 2406          	jruge	L705
1668  03c1 7b02          	ld	a,(OFST-1,sp)
1669  03c3 1104          	cp	a,(OFST+1,sp)
1670  03c5 2597          	jrult	L574
1671  03c7               L705:
1672                     ; 264 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1674  03c7 7b01          	ld	a,(OFST-2,sp)
1675  03c9 5f            	clrw	x
1676  03ca 97            	ld	xl,a
1677  03cb 7b02          	ld	a,(OFST-1,sp)
1678  03cd e70a          	ld	(_pwm_led_count,x),a
1679                     ; 267 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1681  03cf 72120007      	bset	_pwm_state,#1
1682                     ; 268 }
1685  03d3 5b04          	addw	sp,#4
1686  03d5 81            	ret
1784                     ; 271 void set_hue_max(u8 index,u16 color)
1784                     ; 272 {
1785                     	switch	.text
1786  03d6               _set_hue_max:
1788  03d6 88            	push	a
1789  03d7 5207          	subw	sp,#7
1790       00000007      OFST:	set	7
1793                     ; 273 	const u8 brightness=255;
1795  03d9 a6ff          	ld	a,#255
1796  03db 6b07          	ld	(OFST+0,sp),a
1798                     ; 274 	u8 red=0,green=0,blue=0;
1800  03dd 0f04          	clr	(OFST-3,sp)
1804  03df 0f05          	clr	(OFST-2,sp)
1808  03e1 0f06          	clr	(OFST-1,sp)
1810                     ; 275 	u16 residual_16=color%(0x2AAB);
1812  03e3 1e0b          	ldw	x,(OFST+4,sp)
1813  03e5 90ae2aab      	ldw	y,#10923
1814  03e9 65            	divw	x,y
1815  03ea 51            	exgw	x,y
1816  03eb 1f01          	ldw	(OFST-6,sp),x
1818                     ; 276 	u8 residual_8=(residual_16<<8)/0x2AAB;
1820  03ed 1e01          	ldw	x,(OFST-6,sp)
1821  03ef 4f            	clr	a
1822  03f0 02            	rlwa	x,a
1823  03f1 90ae2aab      	ldw	y,#10923
1824  03f5 65            	divw	x,y
1825  03f6 01            	rrwa	x,a
1826  03f7 6b03          	ld	(OFST-4,sp),a
1827  03f9 02            	rlwa	x,a
1829                     ; 277 	switch(color/(0x2AAB))
1831  03fa 1e0b          	ldw	x,(OFST+4,sp)
1832  03fc 90ae2aab      	ldw	y,#10923
1833  0400 65            	divw	x,y
1835                     ; 308 			break;
1836  0401 5d            	tnzw	x
1837  0402 2711          	jreq	L115
1838  0404 5a            	decw	x
1839  0405 271a          	jreq	L315
1840  0407 5a            	decw	x
1841  0408 2725          	jreq	L515
1842  040a 5a            	decw	x
1843  040b 272e          	jreq	L715
1844  040d 5a            	decw	x
1845  040e 2739          	jreq	L125
1846  0410 5a            	decw	x
1847  0411 2742          	jreq	L325
1848  0413 204c          	jra	L306
1849  0415               L115:
1850                     ; 280 			red=brightness;
1852  0415 7b07          	ld	a,(OFST+0,sp)
1853  0417 6b04          	ld	(OFST-3,sp),a
1855                     ; 281 			green=residual_8;
1857  0419 7b03          	ld	a,(OFST-4,sp)
1858  041b 6b05          	ld	(OFST-2,sp),a
1860                     ; 282 			blue=0;
1862  041d 0f06          	clr	(OFST-1,sp)
1864                     ; 283 			break;
1866  041f 2040          	jra	L306
1867  0421               L315:
1868                     ; 285 			red=brightness-residual_8;
1870  0421 7b07          	ld	a,(OFST+0,sp)
1871  0423 1003          	sub	a,(OFST-4,sp)
1872  0425 6b04          	ld	(OFST-3,sp),a
1874                     ; 286 			green=brightness;
1876  0427 7b07          	ld	a,(OFST+0,sp)
1877  0429 6b05          	ld	(OFST-2,sp),a
1879                     ; 287 			blue=0;
1881  042b 0f06          	clr	(OFST-1,sp)
1883                     ; 288 			break;
1885  042d 2032          	jra	L306
1886  042f               L515:
1887                     ; 290 			red=0;
1889  042f 0f04          	clr	(OFST-3,sp)
1891                     ; 291 			green=brightness;
1893  0431 7b07          	ld	a,(OFST+0,sp)
1894  0433 6b05          	ld	(OFST-2,sp),a
1896                     ; 292 			blue=residual_8;
1898  0435 7b03          	ld	a,(OFST-4,sp)
1899  0437 6b06          	ld	(OFST-1,sp),a
1901                     ; 293 			break;
1903  0439 2026          	jra	L306
1904  043b               L715:
1905                     ; 295 			red=0;
1907  043b 0f04          	clr	(OFST-3,sp)
1909                     ; 296 			green=brightness-residual_8;
1911  043d 7b07          	ld	a,(OFST+0,sp)
1912  043f 1003          	sub	a,(OFST-4,sp)
1913  0441 6b05          	ld	(OFST-2,sp),a
1915                     ; 297 			blue=brightness;
1917  0443 7b07          	ld	a,(OFST+0,sp)
1918  0445 6b06          	ld	(OFST-1,sp),a
1920                     ; 298 			break;
1922  0447 2018          	jra	L306
1923  0449               L125:
1924                     ; 300 			red=residual_8;
1926  0449 7b03          	ld	a,(OFST-4,sp)
1927  044b 6b04          	ld	(OFST-3,sp),a
1929                     ; 301 			green=0;
1931  044d 0f05          	clr	(OFST-2,sp)
1933                     ; 302 			blue=brightness;
1935  044f 7b07          	ld	a,(OFST+0,sp)
1936  0451 6b06          	ld	(OFST-1,sp),a
1938                     ; 303 			break;
1940  0453 200c          	jra	L306
1941  0455               L325:
1942                     ; 305 			red=brightness;
1944  0455 7b07          	ld	a,(OFST+0,sp)
1945  0457 6b04          	ld	(OFST-3,sp),a
1947                     ; 306 			green=0;
1949  0459 0f05          	clr	(OFST-2,sp)
1951                     ; 307 			blue=brightness-residual_8;
1953  045b 7b07          	ld	a,(OFST+0,sp)
1954  045d 1003          	sub	a,(OFST-4,sp)
1955  045f 6b06          	ld	(OFST-1,sp),a
1957                     ; 308 			break;
1959  0461               L306:
1960                     ; 311 	set_rgb(index,0,red);
1962  0461 7b04          	ld	a,(OFST-3,sp)
1963  0463 88            	push	a
1964  0464 7b09          	ld	a,(OFST+2,sp)
1965  0466 5f            	clrw	x
1966  0467 95            	ld	xh,a
1967  0468 ad1c          	call	_set_rgb
1969  046a 84            	pop	a
1970                     ; 312 	set_rgb(index,1,green);
1972  046b 7b05          	ld	a,(OFST-2,sp)
1973  046d 88            	push	a
1974  046e 7b09          	ld	a,(OFST+2,sp)
1975  0470 ae0001        	ldw	x,#1
1976  0473 95            	ld	xh,a
1977  0474 ad10          	call	_set_rgb
1979  0476 84            	pop	a
1980                     ; 313 	set_rgb(index,2,blue);
1982  0477 7b06          	ld	a,(OFST-1,sp)
1983  0479 88            	push	a
1984  047a 7b09          	ld	a,(OFST+2,sp)
1985  047c ae0002        	ldw	x,#2
1986  047f 95            	ld	xh,a
1987  0480 ad04          	call	_set_rgb
1989  0482 84            	pop	a
1990                     ; 314 }
1993  0483 5b08          	addw	sp,#8
1994  0485 81            	ret
2047                     ; 316 void set_rgb(u8 index,u8 color,u8 brightness)
2047                     ; 317 {
2048                     	switch	.text
2049  0486               _set_rgb:
2051  0486 89            	pushw	x
2052       00000000      OFST:	set	0
2055                     ; 318 	pwm_brightness_buffer[index+color*RGB_LED_COUNT]=brightness;
2057  0487 9f            	ld	a,xl
2058  0488 97            	ld	xl,a
2059  0489 a60a          	ld	a,#10
2060  048b 42            	mul	x,a
2061  048c 01            	rrwa	x,a
2062  048d 1b01          	add	a,(OFST+1,sp)
2063  048f 2401          	jrnc	L241
2064  0491 5c            	incw	x
2065  0492               L241:
2066  0492 02            	rlwa	x,a
2067  0493 7b05          	ld	a,(OFST+5,sp)
2068  0495 e7bc          	ld	(_pwm_brightness_buffer,x),a
2069                     ; 320 }
2072  0497 85            	popw	x
2073  0498 81            	ret
2117                     ; 322 void set_white(u8 index,u8 brightness)
2117                     ; 323 {
2118                     	switch	.text
2119  0499               _set_white:
2121  0499 89            	pushw	x
2122       00000000      OFST:	set	0
2125                     ; 324 	pwm_brightness_buffer[31+index]=brightness;
2127  049a 9e            	ld	a,xh
2128  049b 5f            	clrw	x
2129  049c 97            	ld	xl,a
2130  049d 7b02          	ld	a,(OFST+2,sp)
2131  049f e7db          	ld	(_pwm_brightness_buffer+31,x),a
2132                     ; 325 }
2135  04a1 85            	popw	x
2136  04a2 81            	ret
2171                     ; 328 void set_debug(u8 brightness)
2171                     ; 329 {
2172                     	switch	.text
2173  04a3               _set_debug:
2177                     ; 330 	pwm_brightness_buffer[30]=brightness;
2179  04a3 b7da          	ld	_pwm_brightness_buffer+30,a
2180                     ; 331 }
2183  04a5 81            	ret
2227                     ; 333 void set_rgb_max(u8 index,u8 color)
2227                     ; 334 { set_rgb(index,color,255); }
2228                     	switch	.text
2229  04a6               _set_rgb_max:
2231  04a6 89            	pushw	x
2232       00000000      OFST:	set	0
2237  04a7 4bff          	push	#255
2238  04a9 9f            	ld	a,xl
2239  04aa 97            	ld	xl,a
2240  04ab 7b02          	ld	a,(OFST+2,sp)
2241  04ad 95            	ld	xh,a
2242  04ae add6          	call	_set_rgb
2244  04b0 84            	pop	a
2248  04b1 85            	popw	x
2249  04b2 81            	ret
2284                     ; 335 void set_white_max(u8 index)
2284                     ; 336 { set_white(index,255); }
2285                     	switch	.text
2286  04b3               _set_white_max:
2292  04b3 ae00ff        	ldw	x,#255
2293  04b6 95            	ld	xh,a
2294  04b7 ade0          	call	_set_white
2299  04b9 81            	ret
2323                     ; 338 void set_matrix_high_z()
2323                     ; 339 {
2324                     	switch	.text
2325  04ba               _set_matrix_high_z:
2329                     ; 345 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2331  04ba 4b00          	push	#0
2332  04bc 4bf8          	push	#248
2333  04be ae500a        	ldw	x,#20490
2334  04c1 cd0000        	call	_GPIO_Init
2336  04c4 85            	popw	x
2337                     ; 346 		GPIO_Init(GPIOD, GPIO_PIN_4 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);//swapped analog and MAT_0
2339  04c5 4b00          	push	#0
2340  04c7 4b14          	push	#20
2341  04c9 ae500f        	ldw	x,#20495
2342  04cc cd0000        	call	_GPIO_Init
2344  04cf 85            	popw	x
2345                     ; 347 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
2347  04d0 4b00          	push	#0
2348  04d2 4b08          	push	#8
2349  04d4 ae5000        	ldw	x,#20480
2350  04d7 cd0000        	call	_GPIO_Init
2352  04da 85            	popw	x
2353                     ; 349 }
2356  04db 81            	ret
2359                     	switch	.const
2360  000c               L347_led_lookup:
2361  000c 00            	dc.b	0
2362  000d 01            	dc.b	1
2363  000e 01            	dc.b	1
2364  000f 00            	dc.b	0
2365  0010 05            	dc.b	5
2366  0011 00            	dc.b	0
2367  0012 06            	dc.b	6
2368  0013 00            	dc.b	0
2369  0014 06            	dc.b	6
2370  0015 05            	dc.b	5
2371  0016 04            	dc.b	4
2372  0017 03            	dc.b	3
2373  0018 03            	dc.b	3
2374  0019 04            	dc.b	4
2375  001a 00            	dc.b	0
2376  001b 05            	dc.b	5
2377  001c 00            	dc.b	0
2378  001d 04            	dc.b	4
2379  001e 00            	dc.b	0
2380  001f 03            	dc.b	3
2381  0020 00            	dc.b	0
2382  0021 02            	dc.b	2
2383  0022 02            	dc.b	2
2384  0023 00            	dc.b	0
2385  0024 05            	dc.b	5
2386  0025 01            	dc.b	1
2387  0026 06            	dc.b	6
2388  0027 01            	dc.b	1
2389  0028 06            	dc.b	6
2390  0029 04            	dc.b	4
2391  002a 05            	dc.b	5
2392  002b 03            	dc.b	3
2393  002c 03            	dc.b	3
2394  002d 05            	dc.b	5
2395  002e 00            	dc.b	0
2396  002f 06            	dc.b	6
2397  0030 01            	dc.b	1
2398  0031 04            	dc.b	4
2399  0032 01            	dc.b	1
2400  0033 03            	dc.b	3
2401  0034 01            	dc.b	1
2402  0035 02            	dc.b	2
2403  0036 02            	dc.b	2
2404  0037 01            	dc.b	1
2405  0038 05            	dc.b	5
2406  0039 02            	dc.b	2
2407  003a 06            	dc.b	6
2408  003b 02            	dc.b	2
2409  003c 05            	dc.b	5
2410  003d 04            	dc.b	4
2411  003e 06            	dc.b	6
2412  003f 03            	dc.b	3
2413  0040 03            	dc.b	3
2414  0041 06            	dc.b	6
2415  0042 01            	dc.b	1
2416  0043 06            	dc.b	6
2417  0044 02            	dc.b	2
2418  0045 04            	dc.b	4
2419  0046 02            	dc.b	2
2420  0047 03            	dc.b	3
2421  0048 07            	dc.b	7
2422  0049 07            	dc.b	7
2423  004a 03            	dc.b	3
2424  004b 00            	dc.b	0
2425  004c 03            	dc.b	3
2426  004d 01            	dc.b	1
2427  004e 03            	dc.b	3
2428  004f 02            	dc.b	2
2429  0050 04            	dc.b	4
2430  0051 00            	dc.b	0
2431  0052 01            	dc.b	1
2432  0053 05            	dc.b	5
2433  0054 02            	dc.b	2
2434  0055 05            	dc.b	5
2435  0056 04            	dc.b	4
2436  0057 01            	dc.b	1
2437  0058 04            	dc.b	4
2438  0059 02            	dc.b	2
2439  005a 02            	dc.b	2
2440  005b 06            	dc.b	6
2441  005c 04            	dc.b	4
2442  005d 06            	dc.b	6
2443  005e 04            	dc.b	4
2444  005f 05            	dc.b	5
2445  0060 05            	dc.b	5
2446  0061 06            	dc.b	6
2656                     ; 352 void set_led(u8 led_index)
2656                     ; 353 {
2657                     	switch	.text
2658  04dc               _set_led:
2660  04dc 88            	push	a
2661  04dd 525c          	subw	sp,#92
2662       0000005c      OFST:	set	92
2665                     ; 358 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2665                     ; 359 		//{0,1},{0,2},{1,2},//LED7  RGB
2665                     ; 360 		//{1,0},{2,0},{2,1},//LED3  RGB
2665                     ; 361 		//{5,0},{5,1},{5,2},//LED1  RGB
2665                     ; 362 		//{6,0},{6,1},{6,2},//LED20 RGB
2665                     ; 363 		//{6,5},{6,4},{5,4},//LED22 RGB
2665                     ; 364 		//{4,3},{5,3},{6,3},//LED23 RGB
2665                     ; 365 		//{3,4},{3,5},{3,6},//LED21 RGB
2665                     ; 366 		//{0,5},{0,6},{1,6},//LED19 RGB
2665                     ; 367 		//{0,4},{1,4},{2,4},//LED18 RGB
2665                     ; 368 		//{0,3},{1,3},{2,3},//LED2  RGB
2665                     ; 369 		
2665                     ; 370 		{0,1},{1,0},{5,0},{6,0},{6,5},{4,3},{3,4},{0,5},{0,4},{0,3},//reds
2665                     ; 371 		{0,2},{2,0},{5,1},{6,1},{6,4},{5,3},{3,5},{0,6},{1,4},{1,3},//greens
2665                     ; 372 		{1,2},{2,1},{5,2},{6,2},{5,4},{6,3},{3,6},{1,6},{2,4},{2,3},//blues
2665                     ; 373 		{7,7},//debug; GND is tied low, no charlieplexing involved
2665                     ; 374 		{3,0},//LED6
2665                     ; 375 		{3,1},//LED4
2665                     ; 376 		{3,2},//LED5
2665                     ; 377 		{4,0},//LED14
2665                     ; 378 		{1,5},//LED8
2665                     ; 379 		{2,5},//LED9
2665                     ; 380 		{4,1},//LED10
2665                     ; 381 		{4,2},//LED16
2665                     ; 382 		{2,6},//LED17
2665                     ; 383 		{4,6},//LED12
2665                     ; 384 		{4,5},//LED13
2665                     ; 385 		{5,6} //LED11
2665                     ; 386 	};
2667  04df 96            	ldw	x,sp
2668  04e0 1c0006        	addw	x,#OFST-86
2669  04e3 90ae000c      	ldw	y,#L347_led_lookup
2670  04e7 a656          	ld	a,#86
2671  04e9 cd0000        	call	c_xymov
2673                     ; 387 	for(is_high=0;is_high<2;is_high++)
2675  04ec 0f5c          	clr	(OFST+0,sp)
2677  04ee               L7011:
2678                     ; 391 		switch(led_lookup[led_index][!is_high])
2680  04ee 0d5c          	tnz	(OFST+0,sp)
2681  04f0 2605          	jrne	L061
2682  04f2 ae0001        	ldw	x,#1
2683  04f5 2001          	jra	L261
2684  04f7               L061:
2685  04f7 5f            	clrw	x
2686  04f8               L261:
2687  04f8 9096          	ldw	y,sp
2688  04fa 72a90006      	addw	y,#OFST-86
2689  04fe 1701          	ldw	(OFST-91,sp),y
2691  0500 7b5d          	ld	a,(OFST+1,sp)
2692  0502 905f          	clrw	y
2693  0504 9097          	ld	yl,a
2694  0506 9058          	sllw	y
2695  0508 72f901        	addw	y,(OFST-91,sp)
2696  050b bf00          	ldw	c_y,x
2697  050d 51            	exgw	x,y
2698  050e 92d600        	ld	a,([c_y.w],x)
2699  0511 51            	exgw	x,y
2701                     ; 428 			}break;
2702  0512 4d            	tnz	a
2703  0513 2717          	jreq	L547
2704  0515 4a            	dec	a
2705  0516 271f          	jreq	L747
2706  0518 4a            	dec	a
2707  0519 2727          	jreq	L157
2708  051b 4a            	dec	a
2709  051c 272f          	jreq	L357
2710  051e 4a            	dec	a
2711  051f 2737          	jreq	L557
2712  0521 4a            	dec	a
2713  0522 273f          	jreq	L757
2714  0524 4a            	dec	a
2715  0525 2747          	jreq	L167
2716  0527 4a            	dec	a
2717  0528 274f          	jreq	L367
2718  052a 2056          	jra	L7111
2719  052c               L547:
2720                     ; 394 				GPIOx=GPIOD;//GPIOD,GPIO_PIN_3
2722  052c ae500f        	ldw	x,#20495
2723  052f 1f03          	ldw	(OFST-89,sp),x
2725                     ; 398 					PortPin=GPIO_PIN_4;
2727  0531 a610          	ld	a,#16
2728  0533 6b05          	ld	(OFST-87,sp),a
2730                     ; 400 			}break;
2732  0535 204b          	jra	L7111
2733  0537               L747:
2734                     ; 402 				GPIOx=GPIOD;//GPIOD,GPIO_PIN_2
2736  0537 ae500f        	ldw	x,#20495
2737  053a 1f03          	ldw	(OFST-89,sp),x
2739                     ; 403 				PortPin=GPIO_PIN_2;
2741  053c a604          	ld	a,#4
2742  053e 6b05          	ld	(OFST-87,sp),a
2744                     ; 404 			}break;
2746  0540 2040          	jra	L7111
2747  0542               L157:
2748                     ; 406 				GPIOx=GPIOC;//GPIOC,GPIO_PIN_7
2750  0542 ae500a        	ldw	x,#20490
2751  0545 1f03          	ldw	(OFST-89,sp),x
2753                     ; 407 				PortPin=GPIO_PIN_7;
2755  0547 a680          	ld	a,#128
2756  0549 6b05          	ld	(OFST-87,sp),a
2758                     ; 408 			}break;
2760  054b 2035          	jra	L7111
2761  054d               L357:
2762                     ; 410 				GPIOx=GPIOC;//GPIOC,GPIO_PIN_6
2764  054d ae500a        	ldw	x,#20490
2765  0550 1f03          	ldw	(OFST-89,sp),x
2767                     ; 411 				PortPin=GPIO_PIN_6;
2769  0552 a640          	ld	a,#64
2770  0554 6b05          	ld	(OFST-87,sp),a
2772                     ; 412 			}break;
2774  0556 202a          	jra	L7111
2775  0558               L557:
2776                     ; 414 				GPIOx=GPIOC;//GPIOC,GPIO_PIN_5
2778  0558 ae500a        	ldw	x,#20490
2779  055b 1f03          	ldw	(OFST-89,sp),x
2781                     ; 415 				PortPin=GPIO_PIN_5;
2783  055d a620          	ld	a,#32
2784  055f 6b05          	ld	(OFST-87,sp),a
2786                     ; 416 			}break;
2788  0561 201f          	jra	L7111
2789  0563               L757:
2790                     ; 418 				GPIOx=GPIOC;//GPIOC,GPIO_PIN_4
2792  0563 ae500a        	ldw	x,#20490
2793  0566 1f03          	ldw	(OFST-89,sp),x
2795                     ; 419 				PortPin=GPIO_PIN_4;
2797  0568 a610          	ld	a,#16
2798  056a 6b05          	ld	(OFST-87,sp),a
2800                     ; 420 			}break;
2802  056c 2014          	jra	L7111
2803  056e               L167:
2804                     ; 422 				GPIOx=GPIOC;//GPIOC,GPIO_PIN_3
2806  056e ae500a        	ldw	x,#20490
2807  0571 1f03          	ldw	(OFST-89,sp),x
2809                     ; 423 				PortPin=GPIO_PIN_3;
2811  0573 a608          	ld	a,#8
2812  0575 6b05          	ld	(OFST-87,sp),a
2814                     ; 424 			}break;
2816  0577 2009          	jra	L7111
2817  0579               L367:
2818                     ; 426 				GPIOx=GPIOA;//GPIOA,GPIO_PIN_3
2820  0579 ae5000        	ldw	x,#20480
2821  057c 1f03          	ldw	(OFST-89,sp),x
2823                     ; 427 				PortPin=GPIO_PIN_3;
2825  057e a608          	ld	a,#8
2826  0580 6b05          	ld	(OFST-87,sp),a
2828                     ; 428 			}break;
2830  0582               L7111:
2831                     ; 430 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
2833  0582 0d5c          	tnz	(OFST+0,sp)
2834  0584 2704          	jreq	L461
2835  0586 a6d0          	ld	a,#208
2836  0588 2002          	jra	L661
2837  058a               L461:
2838  058a a6c0          	ld	a,#192
2839  058c               L661:
2840  058c 88            	push	a
2841  058d 7b06          	ld	a,(OFST-86,sp)
2842  058f 88            	push	a
2843  0590 1e05          	ldw	x,(OFST-87,sp)
2844  0592 cd0000        	call	_GPIO_Init
2846  0595 85            	popw	x
2847                     ; 387 	for(is_high=0;is_high<2;is_high++)
2849  0596 0c5c          	inc	(OFST+0,sp)
2853  0598 7b5c          	ld	a,(OFST+0,sp)
2854  059a a102          	cp	a,#2
2855  059c 2403          	jruge	L071
2856  059e cc04ee        	jp	L7011
2857  05a1               L071:
2858                     ; 432 }
2861  05a1 5b5d          	addw	sp,#93
2862  05a3 81            	ret
3037                     	xdef	f_TIM2_CapComp_IRQ_Handler
3038                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3039                     	switch	.ubsct
3040  0000               _audio_running_std:
3041  0000 0000          	ds.b	2
3042                     	xdef	_audio_running_std
3043  0002               _audio_running_mean:
3044  0002 0000          	ds.b	2
3045                     	xdef	_audio_running_mean
3046  0004               _audio_std:
3047  0004 00            	ds.b	1
3048                     	xdef	_audio_std
3049  0005               _audio_mean:
3050  0005 00            	ds.b	1
3051                     	xdef	_audio_mean
3052                     	xdef	_audio_measurement_count
3053  0006               _button_pressed_event:
3054  0006 00000000      	ds.b	4
3055                     	xdef	_button_pressed_event
3056                     	xdef	_is_right_button_down
3057                     	xdef	_button_start_ms
3058                     	xdef	_pwm_state
3059                     	xdef	_pwm_led_index
3060                     	xdef	_pwm_sleep_remaining
3061  000a               _pwm_led_count:
3062  000a 0000          	ds.b	2
3063                     	xdef	_pwm_led_count
3064  000c               _pwm_sleep:
3065  000c 00000000      	ds.b	4
3066                     	xdef	_pwm_sleep
3067  0010               _pwm_brightness:
3068  0010 000000000000  	ds.b	172
3069                     	xdef	_pwm_brightness
3070  00bc               _pwm_brightness_buffer:
3071  00bc 000000000000  	ds.b	43
3072                     	xdef	_pwm_brightness_buffer
3073                     	xdef	_api_counter
3074                     	xdef	_set_millis
3075                     	xdef	_get_audio_level
3076                     	xdef	_get_random
3077                     	xdef	_is_button_down
3078                     	xdef	_clear_button_events
3079                     	xdef	_clear_button_event
3080                     	xdef	_get_button_event
3081                     	xdef	_update_buttons
3082                     	xdef	_is_sleep_valid
3083                     	xdef	_is_developer_valid
3084                     	xdef	_set_hue_max
3085                     	xdef	_flush_leds
3086                     	xdef	_set_led
3087                     	xdef	_set_debug
3088                     	xdef	_set_white_max
3089                     	xdef	_set_white
3090                     	xdef	_set_rgb_max
3091                     	xdef	_set_rgb
3092                     	xdef	_set_matrix_high_z
3093                     	xdef	_millis
3094                     	xdef	_setup_main
3095                     	xdef	_is_application_valid
3096                     	xdef	_setup_serial
3097                     	xref	_UART1_Cmd
3098                     	xref	_UART1_Init
3099                     	xref	_UART1_DeInit
3100                     	xref	_GPIO_ReadInputPin
3101                     	xref	_GPIO_Init
3102                     	xref.b	c_lreg
3103                     	xref.b	c_x
3104                     	xref.b	c_y
3124                     	xref	c_xymov
3125                     	xref	c_idiv
3126                     	xref	c_lgadc
3127                     	xref	c_lcmp
3128                     	xref	c_rtol
3129                     	xref	c_lsub
3130                     	xref	c_lzmp
3131                     	xref	c_itolx
3132                     	xref	c_ltor
3133                     	xref	c_imul
3134                     	end
