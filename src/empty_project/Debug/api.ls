   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _hw_revision:
  16  0000 01            	dc.b	1
  17                     	bsct
  18  0000               _api_counter:
  19  0000 00000000      	dc.l	0
  20                     	switch	.const
  21  0001               _PWM_MAX_PERIOD:
  22  0001 fa            	dc.b	250
  23                     	bsct
  24  0004               _pwm_sleep_remaining:
  25  0004 0000          	dc.w	0
  26  0006               _pwm_led_index:
  27  0006 00            	dc.b	0
  28  0007               _pwm_state:
  29  0007 00            	dc.b	0
  30  0008               _audio_measurement_count:
  31  0008 00            	dc.b	0
  89                     ; 88 u16 get_random(u16 x)
  89                     ; 89 {
  91                     	switch	.text
  92  0000               _get_random:
  94  0000 5204          	subw	sp,#4
  95       00000004      OFST:	set	4
  98                     ; 90 	u16 a=1664525;
 100                     ; 91 	u16 c=1013904223;
 102                     ; 92 	return a * x + c;
 104  0002 90ae660d      	ldw	y,#26125
 105  0006 cd0000        	call	c_imul
 107  0009 1cf35f        	addw	x,#62303
 110  000c 5b04          	addw	sp,#4
 111  000e 81            	ret
 180                     	switch	.const
 181  0002               L41:
 182  0002 000f4240      	dc.l	1000000
 183                     ; 95 void setup_serial(bool is_enabled,bool is_fast_baud_rate)
 183                     ; 96 {
 184                     	switch	.text
 185  000f               _setup_serial:
 187  000f 89            	pushw	x
 188       00000000      OFST:	set	0
 191                     ; 97 	if(is_enabled)
 193  0010 9e            	ld	a,xh
 194  0011 4d            	tnz	a
 195  0012 2747          	jreq	L17
 196                     ; 99 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 198  0014 4bf0          	push	#240
 199  0016 4b20          	push	#32
 200  0018 ae500f        	ldw	x,#20495
 201  001b cd0000        	call	_GPIO_Init
 203  001e 85            	popw	x
 204                     ; 100 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 206  001f 4b40          	push	#64
 207  0021 4b40          	push	#64
 208  0023 ae500f        	ldw	x,#20495
 209  0026 cd0000        	call	_GPIO_Init
 211  0029 85            	popw	x
 212                     ; 101 		UART1_DeInit();
 214  002a cd0000        	call	_UART1_DeInit
 216                     ; 102 		UART1_Init(is_fast_baud_rate?9600:1000000, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 218  002d 4b0c          	push	#12
 219  002f 4b80          	push	#128
 220  0031 4b00          	push	#0
 221  0033 4b00          	push	#0
 222  0035 4b00          	push	#0
 223  0037 0d07          	tnz	(OFST+7,sp)
 224  0039 2708          	jreq	L01
 225  003b ae2580        	ldw	x,#9600
 226  003e cd0000        	call	c_itolx
 228  0041 2006          	jra	L21
 229  0043               L01:
 230  0043 ae0002        	ldw	x,#L41
 231  0046 cd0000        	call	c_ltor
 233  0049               L21:
 234  0049 be02          	ldw	x,c_lreg+2
 235  004b 89            	pushw	x
 236  004c be00          	ldw	x,c_lreg
 237  004e 89            	pushw	x
 238  004f cd0000        	call	_UART1_Init
 240  0052 5b09          	addw	sp,#9
 241                     ; 103 		UART1_Cmd(ENABLE);
 243  0054 a601          	ld	a,#1
 244  0056 cd0000        	call	_UART1_Cmd
 247  0059 201d          	jra	L37
 248  005b               L17:
 249                     ; 105 		UART1_Cmd(DISABLE);
 251  005b 4f            	clr	a
 252  005c cd0000        	call	_UART1_Cmd
 254                     ; 106 		UART1_DeInit();
 256  005f cd0000        	call	_UART1_DeInit
 258                     ; 107 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 260  0062 4b40          	push	#64
 261  0064 4b20          	push	#32
 262  0066 ae500f        	ldw	x,#20495
 263  0069 cd0000        	call	_GPIO_Init
 265  006c 85            	popw	x
 266                     ; 108 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 268  006d 4b40          	push	#64
 269  006f 4b40          	push	#64
 270  0071 ae500f        	ldw	x,#20495
 271  0074 cd0000        	call	_GPIO_Init
 273  0077 85            	popw	x
 274  0078               L37:
 275                     ; 110 }
 278  0078 85            	popw	x
 279  0079 81            	ret
 306                     ; 113 bool is_application_valid()
 306                     ; 114 {
 307                     	switch	.text
 308  007a               _is_application_valid:
 312                     ; 115 	return !is_button_down(2) && !get_button_event(0,1);
 314  007a a602          	ld	a,#2
 315  007c cd01dd        	call	_is_button_down
 317  007f 4d            	tnz	a
 318  0080 260d          	jrne	L02
 319  0082 ae0001        	ldw	x,#1
 320  0085 cd018e        	call	_get_button_event
 322  0088 4d            	tnz	a
 323  0089 2604          	jrne	L02
 324  008b a601          	ld	a,#1
 325  008d 2001          	jra	L22
 326  008f               L02:
 327  008f 4f            	clr	a
 328  0090               L22:
 331  0090 81            	ret
 357                     ; 119 bool is_developer_valid()
 357                     ; 120 {
 358                     	switch	.text
 359  0091               _is_developer_valid:
 363                     ; 121 	return is_button_down(2) && !get_button_event(0,1);
 365  0091 a602          	ld	a,#2
 366  0093 cd01dd        	call	_is_button_down
 368  0096 4d            	tnz	a
 369  0097 270d          	jreq	L62
 370  0099 ae0001        	ldw	x,#1
 371  009c cd018e        	call	_get_button_event
 373  009f 4d            	tnz	a
 374  00a0 2604          	jrne	L62
 375  00a2 a601          	ld	a,#1
 376  00a4 2001          	jra	L03
 377  00a6               L62:
 378  00a6 4f            	clr	a
 379  00a7               L03:
 382  00a7 81            	ret
 407                     ; 125 bool is_sleep_valid()
 407                     ; 126 {
 408                     	switch	.text
 409  00a8               _is_sleep_valid:
 413                     ; 127 	return !(get_button_event(0,0) || get_button_event(1,0) || get_button_event(0,1) || get_button_event(1,1));
 415  00a8 5f            	clrw	x
 416  00a9 cd018e        	call	_get_button_event
 418  00ac 4d            	tnz	a
 419  00ad 261f          	jrne	L43
 420  00af ae0100        	ldw	x,#256
 421  00b2 cd018e        	call	_get_button_event
 423  00b5 4d            	tnz	a
 424  00b6 2616          	jrne	L43
 425  00b8 ae0001        	ldw	x,#1
 426  00bb cd018e        	call	_get_button_event
 428  00be 4d            	tnz	a
 429  00bf 260d          	jrne	L43
 430  00c1 ae0101        	ldw	x,#257
 431  00c4 cd018e        	call	_get_button_event
 433  00c7 4d            	tnz	a
 434  00c8 2604          	jrne	L43
 435  00ca a601          	ld	a,#1
 436  00cc 2001          	jra	L63
 437  00ce               L43:
 438  00ce 4f            	clr	a
 439  00cf               L63:
 442  00cf 81            	ret
 468                     ; 130 void setup_main()
 468                     ; 131 {
 469                     	switch	.text
 470  00d0               _setup_main:
 474                     ; 132 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 476  00d0 c650c6        	ld	a,20678
 477  00d3 a4e7          	and	a,#231
 478  00d5 c750c6        	ld	20678,a
 479                     ; 134 	GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);//SWIM input to choose between application and developer modes
 481  00d8 4b40          	push	#64
 482  00da 4b02          	push	#2
 483  00dc ae500f        	ldw	x,#20495
 484  00df cd0000        	call	_GPIO_Init
 486  00e2 85            	popw	x
 487                     ; 137 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 489  00e3 725f5311      	clr	21265
 490                     ; 138 	TIM2->PSCR= 6;// init divider register 16MHz/2^X
 492  00e7 3506530e      	mov	21262,#6
 493                     ; 139 	TIM2->ARRH= 0;// init auto reload register
 495  00eb 725f530f      	clr	21263
 496                     ; 140 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 498  00ef 35fa5310      	mov	21264,#250
 499                     ; 141 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 501  00f3 c65300        	ld	a,21248
 502  00f6 aa85          	or	a,#133
 503  00f8 c75300        	ld	21248,a
 504                     ; 142 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 506  00fb 35035303      	mov	21251,#3
 507                     ; 143 	enableInterrupts();
 510  00ff 9a            rim
 512                     ; 157 }
 516  0100 81            	ret
 540                     ; 159 u32 millis()
 540                     ; 160 {
 541                     	switch	.text
 542  0101               _millis:
 546                     ; 161 	return api_counter;
 548  0101 ae0000        	ldw	x,#_api_counter
 549  0104 cd0000        	call	c_ltor
 553  0107 81            	ret
 588                     ; 164 void set_millis(u32 new_time)
 588                     ; 165 {
 589                     	switch	.text
 590  0108               _set_millis:
 592       00000000      OFST:	set	0
 595                     ; 166 	api_counter=new_time;
 597  0108 1e05          	ldw	x,(OFST+5,sp)
 598  010a bf02          	ldw	_api_counter+2,x
 599  010c 1e03          	ldw	x,(OFST+3,sp)
 600  010e bf00          	ldw	_api_counter,x
 601                     ; 167 }
 604  0110 81            	ret
 662                     ; 172 void update_buttons()
 662                     ; 173 {
 663                     	switch	.text
 664  0111               _update_buttons:
 666  0111 5208          	subw	sp,#8
 667       00000008      OFST:	set	8
 670                     ; 174 	bool is_any_down=0;
 672  0113 0f05          	clr	(OFST-3,sp)
 674                     ; 176 	u16 elapsed_pressed_ms=millis()-button_start_ms;
 676  0115 be0c          	ldw	x,_button_start_ms+2
 677  0117 cd0000        	call	c_uitolx
 679  011a 96            	ldw	x,sp
 680  011b 1c0001        	addw	x,#OFST-7
 681  011e cd0000        	call	c_rtol
 684  0121 adde          	call	_millis
 686  0123 96            	ldw	x,sp
 687  0124 1c0001        	addw	x,#OFST-7
 688  0127 cd0000        	call	c_lsub
 690  012a be02          	ldw	x,c_lreg+2
 691  012c 1f06          	ldw	(OFST-2,sp),x
 693                     ; 177 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 695  012e 0f08          	clr	(OFST+0,sp)
 697  0130               L112:
 698                     ; 179 		if(is_button_down(button_index))
 700  0130 7b08          	ld	a,(OFST+0,sp)
 701  0132 cd01dd        	call	_is_button_down
 703  0135 4d            	tnz	a
 704  0136 271b          	jreq	L712
 705                     ; 181 			if(!button_start_ms) button_start_ms=millis();//if button is down and haven't started a button press event, start it
 707  0138 ae000a        	ldw	x,#_button_start_ms
 708  013b cd0000        	call	c_lzmp
 710  013e 2608          	jrne	L122
 713  0140 adbf          	call	_millis
 715  0142 ae000a        	ldw	x,#_button_start_ms
 716  0145 cd0000        	call	c_rtol
 718  0148               L122:
 719                     ; 182 			set_debug(255);//only need to enable this when true.  Is automatically cleared every frame
 721  0148 a6ff          	ld	a,#255
 722  014a cd04b4        	call	_set_debug
 724                     ; 183 			is_any_down=1;
 726  014d a601          	ld	a,#1
 727  014f 6b05          	ld	(OFST-3,sp),a
 730  0151 2022          	jra	L322
 731  0153               L712:
 732                     ; 185 			if(elapsed_pressed_ms>BUTTON_LONG_PRESS_MS) button_pressed_event[button_index][1]=1;
 734  0153 1e06          	ldw	x,(OFST-2,sp)
 735  0155 a30201        	cpw	x,#513
 736  0158 250b          	jrult	L522
 739  015a 7b08          	ld	a,(OFST+0,sp)
 740  015c 5f            	clrw	x
 741  015d 97            	ld	xl,a
 742  015e 58            	sllw	x
 743  015f a601          	ld	a,#1
 744  0161 e707          	ld	(_button_pressed_event+1,x),a
 746  0163 2010          	jra	L322
 747  0165               L522:
 748                     ; 186 			else if(elapsed_pressed_ms>BUTTON_MINIMUM_PRESS_MS) button_pressed_event[button_index][0]=1;
 750  0165 1e06          	ldw	x,(OFST-2,sp)
 751  0167 a30033        	cpw	x,#51
 752  016a 2509          	jrult	L322
 755  016c 7b08          	ld	a,(OFST+0,sp)
 756  016e 5f            	clrw	x
 757  016f 97            	ld	xl,a
 758  0170 58            	sllw	x
 759  0171 a601          	ld	a,#1
 760  0173 e706          	ld	(_button_pressed_event,x),a
 761  0175               L322:
 762                     ; 177 	for(button_index=0;button_index<BUTTON_COUNT;button_index++)
 764  0175 0c08          	inc	(OFST+0,sp)
 768  0177 7b08          	ld	a,(OFST+0,sp)
 769  0179 a102          	cp	a,#2
 770  017b 25b3          	jrult	L112
 771                     ; 190 	if(!is_any_down) button_start_ms=0;
 773  017d 0d05          	tnz	(OFST-3,sp)
 774  017f 260a          	jrne	L332
 777  0181 ae0000        	ldw	x,#0
 778  0184 bf0c          	ldw	_button_start_ms+2,x
 779  0186 ae0000        	ldw	x,#0
 780  0189 bf0a          	ldw	_button_start_ms,x
 781  018b               L332:
 782                     ; 191 }
 785  018b 5b08          	addw	sp,#8
 786  018d 81            	ret
 832                     ; 194 bool get_button_event(u8 button_index,bool is_long)
 832                     ; 195 { return button_pressed_event[button_index][is_long]; }
 833                     	switch	.text
 834  018e               _get_button_event:
 836  018e 89            	pushw	x
 837       00000000      OFST:	set	0
 842  018f 9e            	ld	a,xh
 843  0190 5f            	clrw	x
 844  0191 97            	ld	xl,a
 845  0192 58            	sllw	x
 846  0193 01            	rrwa	x,a
 847  0194 1b02          	add	a,(OFST+2,sp)
 848  0196 2401          	jrnc	L25
 849  0198 5c            	incw	x
 850  0199               L25:
 851  0199 02            	rlwa	x,a
 852  019a e606          	ld	a,(_button_pressed_event,x)
 855  019c 85            	popw	x
 856  019d 81            	ret
 912                     ; 198 bool clear_button_event(u8 button_index,bool is_long)
 912                     ; 199 {
 913                     	switch	.text
 914  019e               _clear_button_event:
 916  019e 89            	pushw	x
 917  019f 88            	push	a
 918       00000001      OFST:	set	1
 921                     ; 200 	bool out=button_pressed_event[button_index][is_long];
 923  01a0 9e            	ld	a,xh
 924  01a1 5f            	clrw	x
 925  01a2 97            	ld	xl,a
 926  01a3 58            	sllw	x
 927  01a4 01            	rrwa	x,a
 928  01a5 1b03          	add	a,(OFST+2,sp)
 929  01a7 2401          	jrnc	L65
 930  01a9 5c            	incw	x
 931  01aa               L65:
 932  01aa 02            	rlwa	x,a
 933  01ab e606          	ld	a,(_button_pressed_event,x)
 934  01ad 6b01          	ld	(OFST+0,sp),a
 936                     ; 201 	button_pressed_event[button_index][is_long]=0;
 938  01af 7b02          	ld	a,(OFST+1,sp)
 939  01b1 5f            	clrw	x
 940  01b2 97            	ld	xl,a
 941  01b3 58            	sllw	x
 942  01b4 01            	rrwa	x,a
 943  01b5 1b03          	add	a,(OFST+2,sp)
 944  01b7 2401          	jrnc	L06
 945  01b9 5c            	incw	x
 946  01ba               L06:
 947  01ba 02            	rlwa	x,a
 948  01bb 6f06          	clr	(_button_pressed_event,x)
 949                     ; 202 	return out;
 951  01bd 7b01          	ld	a,(OFST+0,sp)
 954  01bf 5b03          	addw	sp,#3
 955  01c1 81            	ret
 991                     ; 205 void clear_button_events()
 991                     ; 206 {
 992                     	switch	.text
 993  01c2               _clear_button_events:
 995  01c2 88            	push	a
 996       00000001      OFST:	set	1
 999                     ; 208 	for(iter=0;iter<BUTTON_COUNT;iter++)
1001  01c3 0f01          	clr	(OFST+0,sp)
1003  01c5               L323:
1004                     ; 210 		clear_button_event(iter,0);
1006  01c5 7b01          	ld	a,(OFST+0,sp)
1007  01c7 5f            	clrw	x
1008  01c8 95            	ld	xh,a
1009  01c9 add3          	call	_clear_button_event
1011                     ; 211 		clear_button_event(iter,1);
1013  01cb 7b01          	ld	a,(OFST+0,sp)
1014  01cd ae0001        	ldw	x,#1
1015  01d0 95            	ld	xh,a
1016  01d1 adcb          	call	_clear_button_event
1018                     ; 208 	for(iter=0;iter<BUTTON_COUNT;iter++)
1020  01d3 0c01          	inc	(OFST+0,sp)
1024  01d5 7b01          	ld	a,(OFST+0,sp)
1025  01d7 a102          	cp	a,#2
1026  01d9 25ea          	jrult	L323
1027                     ; 213 }
1030  01db 84            	pop	a
1031  01dc 81            	ret
1067                     ; 216 bool is_button_down(u8 index)
1067                     ; 217 {
1068                     	switch	.text
1069  01dd               _is_button_down:
1073                     ; 218 	switch(index)
1076                     ; 222 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1078  01dd 4d            	tnz	a
1079  01de 2708          	jreq	L133
1080  01e0 4a            	dec	a
1081  01e1 2718          	jreq	L333
1082  01e3 4a            	dec	a
1083  01e4 2728          	jreq	L533
1084  01e6 2039          	jra	L753
1085  01e8               L133:
1086                     ; 220 		case 0:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_5); break; }//left button
1088  01e8 4b20          	push	#32
1089  01ea ae500f        	ldw	x,#20495
1090  01ed cd0000        	call	_GPIO_ReadInputPin
1092  01f0 5b01          	addw	sp,#1
1093  01f2 4d            	tnz	a
1094  01f3 2604          	jrne	L66
1095  01f5 a601          	ld	a,#1
1096  01f7 2001          	jra	L07
1097  01f9               L66:
1098  01f9 4f            	clr	a
1099  01fa               L07:
1102  01fa 81            	ret
1103  01fb               L333:
1104                     ; 221 		case 1:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_6); break; }//right button
1107  01fb 4b40          	push	#64
1108  01fd ae500f        	ldw	x,#20495
1109  0200 cd0000        	call	_GPIO_ReadInputPin
1111  0203 5b01          	addw	sp,#1
1112  0205 4d            	tnz	a
1113  0206 2604          	jrne	L27
1114  0208 a601          	ld	a,#1
1115  020a 2001          	jra	L47
1116  020c               L27:
1117  020c 4f            	clr	a
1118  020d               L47:
1121  020d 81            	ret
1122  020e               L533:
1123                     ; 222 		case 2:{ return !GPIO_ReadInputPin(GPIOD, GPIO_PIN_1); break; }//SWIM IO input
1126  020e 4b02          	push	#2
1127  0210 ae500f        	ldw	x,#20495
1128  0213 cd0000        	call	_GPIO_ReadInputPin
1130  0216 5b01          	addw	sp,#1
1131  0218 4d            	tnz	a
1132  0219 2604          	jrne	L67
1133  021b a601          	ld	a,#1
1134  021d 2001          	jra	L001
1135  021f               L67:
1136  021f 4f            	clr	a
1137  0220               L001:
1140  0220 81            	ret
1141  0221               L753:
1142                     ; 224 	return 0;
1144  0221 4f            	clr	a
1147  0222 81            	ret
1197                     ; 227 void update_audio()
1197                     ; 228 {
1198                     	switch	.text
1199  0223               _update_audio:
1201  0223 5203          	subw	sp,#3
1202       00000003      OFST:	set	3
1205                     ; 230 	reading=ADC1->DRL;//only get 8 least significant bits of the 10 available, assuming reading is not changing fast enough or near enough the 1/4-full-scale point to matter
1207  0225 c65405        	ld	a,21509
1208  0228 6b03          	ld	(OFST+0,sp),a
1210                     ; 231 	ADC1_ClearFlag(ADC1_FLAG_EOC);
1212  022a a680          	ld	a,#128
1213  022c cd0000        	call	_ADC1_ClearFlag
1215                     ; 232 	audio_measurement_count++;
1217  022f 3c08          	inc	_audio_measurement_count
1218                     ; 233 	audio_running_mean+=reading;
1220  0231 7b03          	ld	a,(OFST+0,sp)
1221  0233 5f            	clrw	x
1222  0234 97            	ld	xl,a
1223  0235 1f01          	ldw	(OFST-2,sp),x
1225  0237 be02          	ldw	x,_audio_running_mean
1226  0239 72fb01        	addw	x,(OFST-2,sp)
1227  023c bf02          	ldw	_audio_running_mean,x
1228                     ; 234 	reading_residual=reading>audio_mean?reading-audio_mean:audio_mean-reading;
1230  023e 7b03          	ld	a,(OFST+0,sp)
1231  0240 b105          	cp	a,_audio_mean
1232  0242 2306          	jrule	L401
1233  0244 7b03          	ld	a,(OFST+0,sp)
1234  0246 b005          	sub	a,_audio_mean
1235  0248 2004          	jra	L601
1236  024a               L401:
1237  024a b605          	ld	a,_audio_mean
1238  024c 1003          	sub	a,(OFST+0,sp)
1239  024e               L601:
1240  024e 6b03          	ld	(OFST+0,sp),a
1242                     ; 235 	audio_running_std+=reading_residual;
1244  0250 7b03          	ld	a,(OFST+0,sp)
1245  0252 5f            	clrw	x
1246  0253 97            	ld	xl,a
1247  0254 1f01          	ldw	(OFST-2,sp),x
1249  0256 be00          	ldw	x,_audio_running_std
1250  0258 72fb01        	addw	x,(OFST-2,sp)
1251  025b bf00          	ldw	_audio_running_std,x
1252                     ; 236 	if(!audio_measurement_count)//every 256 measurements, average them (/256) and store them
1254  025d 3d08          	tnz	_audio_measurement_count
1255  025f 260c          	jrne	L304
1256                     ; 238 		audio_mean=audio_running_mean>>8;
1258  0261 450205        	mov	_audio_mean,_audio_running_mean
1259                     ; 239 		audio_running_mean=0;
1261  0264 5f            	clrw	x
1262  0265 bf02          	ldw	_audio_running_mean,x
1263                     ; 240 		audio_std=audio_running_std>>8;
1265  0267 450004        	mov	_audio_std,_audio_running_std
1266                     ; 241 		audio_running_std=0;
1268  026a 5f            	clrw	x
1269  026b bf00          	ldw	_audio_running_std,x
1270  026d               L304:
1271                     ; 243 	ADC1_StartConversion();
1273  026d cd0000        	call	_ADC1_StartConversion
1275                     ; 244 }
1278  0270 5b03          	addw	sp,#3
1279  0272 81            	ret
1303                     ; 246 u8 get_audio_level()
1303                     ; 247 { return audio_std; }
1304                     	switch	.text
1305  0273               _get_audio_level:
1311  0273 b604          	ld	a,_audio_std
1314  0275 81            	ret
1339                     ; 250 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
1341                     	switch	.text
1342  0276               f_TIM2_UPD_OVF_IRQHandler:
1346                     ; 251 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
1348  0276 72115304      	bres	21252,#0
1349                     ; 252 	api_counter++;
1351  027a ae0000        	ldw	x,#_api_counter
1352  027d a601          	ld	a,#1
1353  027f cd0000        	call	c_lgadc
1355                     ; 256 }
1358  0282 80            	iret
1411                     ; 259 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
1412                     	switch	.text
1413  0283               f_TIM2_CapComp_IRQ_Handler:
1415  0283 8a            	push	cc
1416  0284 84            	pop	a
1417  0285 a4bf          	and	a,#191
1418  0287 88            	push	a
1419  0288 86            	pop	cc
1420       00000004      OFST:	set	4
1421  0289 3b0002        	push	c_x+2
1422  028c be00          	ldw	x,c_x
1423  028e 89            	pushw	x
1424  028f 3b0002        	push	c_y+2
1425  0292 be00          	ldw	x,c_y
1426  0294 89            	pushw	x
1427  0295 5204          	subw	sp,#4
1430                     ; 261 	u8 sleep_amount=PWM_MAX_PERIOD;//max sleep duration before wrap-over occurs
1432  0297 a6fa          	ld	a,#250
1433  0299 6b04          	ld	(OFST+0,sp),a
1435                     ; 262 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
1437  029b b607          	ld	a,_pwm_state
1438  029d a401          	and	a,#1
1439  029f 6b03          	ld	(OFST-1,sp),a
1441                     ; 264 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
1443  02a1 72135304      	bres	21252,#1
1444                     ; 266 	if(pwm_sleep_remaining==0)
1446  02a5 be04          	ldw	x,_pwm_sleep_remaining
1447  02a7 2657          	jrne	L744
1448                     ; 268 		set_matrix_high_z();
1450  02a9 cd04b7        	call	_set_matrix_high_z
1452                     ; 269 		if(pwm_led_index<pwm_led_count[buffer_index])
1454  02ac 7b03          	ld	a,(OFST-1,sp)
1455  02ae 5f            	clrw	x
1456  02af 97            	ld	xl,a
1457  02b0 e60e          	ld	a,(_pwm_led_count,x)
1458  02b2 b106          	cp	a,_pwm_led_index
1459  02b4 2333          	jrule	L154
1460                     ; 271 			set_led(pwm_brightness[pwm_led_index][0][buffer_index]);//turn on the next LED
1462  02b6 b606          	ld	a,_pwm_led_index
1463  02b8 97            	ld	xl,a
1464  02b9 a604          	ld	a,#4
1465  02bb 42            	mul	x,a
1466  02bc 01            	rrwa	x,a
1467  02bd 1b03          	add	a,(OFST-1,sp)
1468  02bf 2401          	jrnc	L611
1469  02c1 5c            	incw	x
1470  02c2               L611:
1471  02c2 02            	rlwa	x,a
1472  02c3 e614          	ld	a,(_pwm_brightness,x)
1473  02c5 cd04db        	call	_set_led
1475                     ; 272 			pwm_sleep_remaining=0x00FF&(pwm_brightness[pwm_led_index][1][buffer_index]+15);//set how long to sleep in this state //+15 works ok here as magic number to correct timing errors from interrupts
1477  02c8 b606          	ld	a,_pwm_led_index
1478  02ca 97            	ld	xl,a
1479  02cb a604          	ld	a,#4
1480  02cd 42            	mul	x,a
1481  02ce 01            	rrwa	x,a
1482  02cf 1b03          	add	a,(OFST-1,sp)
1483  02d1 2401          	jrnc	L021
1484  02d3 5c            	incw	x
1485  02d4               L021:
1486  02d4 02            	rlwa	x,a
1487  02d5 e616          	ld	a,(_pwm_brightness+2,x)
1488  02d7 5f            	clrw	x
1489  02d8 97            	ld	xl,a
1490  02d9 1c000f        	addw	x,#15
1491  02dc 01            	rrwa	x,a
1492  02dd a4ff          	and	a,#255
1493  02df 5f            	clrw	x
1494  02e0 b705          	ld	_pwm_sleep_remaining+1,a
1495  02e2 9f            	ld	a,xl
1496  02e3 b704          	ld	_pwm_sleep_remaining,a
1497                     ; 273 			pwm_led_index++;//prepare state machine to go to the next led later
1499  02e5 3c06          	inc	_pwm_led_index
1501  02e7 2017          	jra	L744
1502  02e9               L154:
1503                     ; 275 			pwm_led_index=0;//reset state machine to 0
1505  02e9 3f06          	clr	_pwm_led_index
1506                     ; 276 			pwm_sleep_remaining=pwm_sleep[buffer_index];
1508  02eb 7b03          	ld	a,(OFST-1,sp)
1509  02ed 5f            	clrw	x
1510  02ee 97            	ld	xl,a
1511  02ef 58            	sllw	x
1512  02f0 ee10          	ldw	x,(_pwm_sleep,x)
1513  02f2 bf04          	ldw	_pwm_sleep_remaining,x
1514                     ; 277 			if(pwm_state&0x02) pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
1516  02f4 b607          	ld	a,_pwm_state
1517  02f6 a502          	bcp	a,#2
1518  02f8 2706          	jreq	L744
1521  02fa b607          	ld	a,_pwm_state
1522  02fc a803          	xor	a,#3
1523  02fe b707          	ld	_pwm_state,a
1524  0300               L744:
1525                     ; 280 	sleep_amount=pwm_sleep_remaining<sleep_amount?pwm_sleep_remaining:sleep_amount;
1527  0300 7b04          	ld	a,(OFST+0,sp)
1528  0302 5f            	clrw	x
1529  0303 97            	ld	xl,a
1530  0304 bf00          	ldw	c_x,x
1531  0306 be04          	ldw	x,_pwm_sleep_remaining
1532  0308 b300          	cpw	x,c_x
1533  030a 2404          	jruge	L221
1534  030c b605          	ld	a,_pwm_sleep_remaining+1
1535  030e 2002          	jra	L421
1536  0310               L221:
1537  0310 7b04          	ld	a,(OFST+0,sp)
1538  0312               L421:
1539  0312 6b04          	ld	(OFST+0,sp),a
1541                     ; 281 	pwm_sleep_remaining-=sleep_amount;
1543  0314 7b04          	ld	a,(OFST+0,sp)
1544  0316 5f            	clrw	x
1545  0317 97            	ld	xl,a
1546  0318 1f01          	ldw	(OFST-3,sp),x
1548  031a be04          	ldw	x,_pwm_sleep_remaining
1549  031c 72f001        	subw	x,(OFST-3,sp)
1550  031f bf04          	ldw	_pwm_sleep_remaining,x
1551                     ; 283 	TIM2->CCR1L = ( (TIM2->CCR1L) + sleep_amount )%PWM_MAX_PERIOD;//set wakeup alarm relative to current time
1553  0321 c65312        	ld	a,21266
1554  0324 5f            	clrw	x
1555  0325 1b04          	add	a,(OFST+0,sp)
1556  0327 2401          	jrnc	L621
1557  0329 5c            	incw	x
1558  032a               L621:
1559  032a 02            	rlwa	x,a
1560  032b 90ae00fa      	ldw	y,#250
1561  032f cd0000        	call	c_idiv
1563  0332 51            	exgw	x,y
1564  0333 01            	rrwa	x,a
1565  0334 c75312        	ld	21266,a
1566  0337 02            	rlwa	x,a
1567                     ; 284 }
1570  0338 5b04          	addw	sp,#4
1571  033a 85            	popw	x
1572  033b bf00          	ldw	c_y,x
1573  033d 320002        	pop	c_y+2
1574  0340 85            	popw	x
1575  0341 bf00          	ldw	c_x,x
1576  0343 320002        	pop	c_x+2
1577  0346 80            	iret
1642                     ; 286 void flush_leds(u8 led_count)
1642                     ; 287 {
1644                     	switch	.text
1645  0347               _flush_leds:
1647  0347 88            	push	a
1648  0348 5203          	subw	sp,#3
1649       00000003      OFST:	set	3
1652                     ; 288 	u8 led_read_index=0,led_write_index=0;
1656  034a 0f02          	clr	(OFST-1,sp)
1659  034c               L515:
1660                     ; 290 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
1662  034c b607          	ld	a,_pwm_state
1663  034e a502          	bcp	a,#2
1664  0350 26fa          	jrne	L515
1665                     ; 291 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
1667  0352 b607          	ld	a,_pwm_state
1668  0354 a401          	and	a,#1
1669  0356 a801          	xor	a,#1
1670  0358 6b01          	ld	(OFST-2,sp),a
1672                     ; 292 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
1674  035a 7b04          	ld	a,(OFST+1,sp)
1675  035c 5f            	clrw	x
1676  035d 97            	ld	xl,a
1677  035e 4f            	clr	a
1678  035f 02            	rlwa	x,a
1679  0360 7b01          	ld	a,(OFST-2,sp)
1680  0362 905f          	clrw	y
1681  0364 9097          	ld	yl,a
1682  0366 9058          	sllw	y
1683  0368 90ef10        	ldw	(_pwm_sleep,y),x
1684                     ; 294 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1686  036b 0f03          	clr	(OFST+0,sp)
1689  036d 205d          	jra	L525
1690  036f               L125:
1691                     ; 296 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
1693  036f 7b03          	ld	a,(OFST+0,sp)
1694  0371 5f            	clrw	x
1695  0372 97            	ld	xl,a
1696  0373 e6c0          	ld	a,(_pwm_brightness_buffer,x)
1697  0375 a105          	cp	a,#5
1698  0377 254b          	jrult	L135
1699                     ; 298 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
1701  0379 7b02          	ld	a,(OFST-1,sp)
1702  037b 97            	ld	xl,a
1703  037c a604          	ld	a,#4
1704  037e 42            	mul	x,a
1705  037f 01            	rrwa	x,a
1706  0380 1b01          	add	a,(OFST-2,sp)
1707  0382 2401          	jrnc	L231
1708  0384 5c            	incw	x
1709  0385               L231:
1710  0385 02            	rlwa	x,a
1711  0386 7b03          	ld	a,(OFST+0,sp)
1712  0388 e714          	ld	(_pwm_brightness,x),a
1713                     ; 299 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
1715  038a 7b02          	ld	a,(OFST-1,sp)
1716  038c 97            	ld	xl,a
1717  038d a604          	ld	a,#4
1718  038f 42            	mul	x,a
1719  0390 01            	rrwa	x,a
1720  0391 1b01          	add	a,(OFST-2,sp)
1721  0393 2401          	jrnc	L431
1722  0395 5c            	incw	x
1723  0396               L431:
1724  0396 02            	rlwa	x,a
1725  0397 7b03          	ld	a,(OFST+0,sp)
1726  0399 905f          	clrw	y
1727  039b 9097          	ld	yl,a
1728  039d 90e6c0        	ld	a,(_pwm_brightness_buffer,y)
1729  03a0 e716          	ld	(_pwm_brightness+2,x),a
1730                     ; 300 			led_write_index++;
1732  03a2 0c02          	inc	(OFST-1,sp)
1734                     ; 301 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
1736  03a4 7b01          	ld	a,(OFST-2,sp)
1737  03a6 5f            	clrw	x
1738  03a7 97            	ld	xl,a
1739  03a8 58            	sllw	x
1740  03a9 7b03          	ld	a,(OFST+0,sp)
1741  03ab 905f          	clrw	y
1742  03ad 9097          	ld	yl,a
1743  03af 90e6c0        	ld	a,(_pwm_brightness_buffer,y)
1744  03b2 905f          	clrw	y
1745  03b4 9097          	ld	yl,a
1746  03b6 9001          	rrwa	y,a
1747  03b8 e011          	sub	a,(_pwm_sleep+1,x)
1748  03ba 9001          	rrwa	y,a
1749  03bc e210          	sbc	a,(_pwm_sleep,x)
1750  03be 9001          	rrwa	y,a
1751  03c0 9050          	negw	y
1752  03c2 ef10          	ldw	(_pwm_sleep,x),y
1753  03c4               L135:
1754                     ; 303 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
1756  03c4 7b03          	ld	a,(OFST+0,sp)
1757  03c6 5f            	clrw	x
1758  03c7 97            	ld	xl,a
1759  03c8 6fc0          	clr	(_pwm_brightness_buffer,x)
1760                     ; 294 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
1762  03ca 0c03          	inc	(OFST+0,sp)
1764  03cc               L525:
1767  03cc 7b03          	ld	a,(OFST+0,sp)
1768  03ce a12b          	cp	a,#43
1769  03d0 2406          	jruge	L335
1771  03d2 7b02          	ld	a,(OFST-1,sp)
1772  03d4 1104          	cp	a,(OFST+1,sp)
1773  03d6 2597          	jrult	L125
1774  03d8               L335:
1775                     ; 305 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1777  03d8 7b01          	ld	a,(OFST-2,sp)
1778  03da 5f            	clrw	x
1779  03db 97            	ld	xl,a
1780  03dc 7b02          	ld	a,(OFST-1,sp)
1781  03de e70e          	ld	(_pwm_led_count,x),a
1782                     ; 308 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1784  03e0 72120007      	bset	_pwm_state,#1
1785                     ; 309 }
1788  03e4 5b04          	addw	sp,#4
1789  03e6 81            	ret
1878                     ; 311 void set_hue(u8 index,u16 color,u8 brightness)
1878                     ; 312 {
1879                     	switch	.text
1880  03e7               _set_hue:
1882  03e7 88            	push	a
1883  03e8 5205          	subw	sp,#5
1884       00000005      OFST:	set	5
1887                     ; 313 	u8 red=0,green=0,blue=0;
1889  03ea 0f01          	clr	(OFST-4,sp)
1893  03ec 0f02          	clr	(OFST-3,sp)
1897  03ee 0f03          	clr	(OFST-2,sp)
1899                     ; 314 	u16 residual=color%(0x2AAB);
1901  03f0 1e09          	ldw	x,(OFST+4,sp)
1902  03f2 90ae2aab      	ldw	y,#10923
1903  03f6 65            	divw	x,y
1904  03f7 51            	exgw	x,y
1905  03f8 1f04          	ldw	(OFST-1,sp),x
1907                     ; 315 	residual=(u8)(residual*brightness/0x2AAB);
1909  03fa 1e04          	ldw	x,(OFST-1,sp)
1910  03fc 7b0b          	ld	a,(OFST+6,sp)
1911  03fe cd0000        	call	c_bmulx
1913  0401 90ae2aab      	ldw	y,#10923
1914  0405 65            	divw	x,y
1915  0406 9f            	ld	a,xl
1916  0407 5f            	clrw	x
1917  0408 97            	ld	xl,a
1918  0409 1f04          	ldw	(OFST-1,sp),x
1920                     ; 316 	switch(color/(0x2AAB))//0xFFFF/6
1922  040b 1e09          	ldw	x,(OFST+4,sp)
1923  040d 90ae2aab      	ldw	y,#10923
1924  0411 65            	divw	x,y
1926                     ; 347 			break;
1927  0412 5d            	tnzw	x
1928  0413 2711          	jreq	L535
1929  0415 5a            	decw	x
1930  0416 271a          	jreq	L735
1931  0418 5a            	decw	x
1932  0419 2725          	jreq	L145
1933  041b 5a            	decw	x
1934  041c 272e          	jreq	L345
1935  041e 5a            	decw	x
1936  041f 2739          	jreq	L545
1937  0421 5a            	decw	x
1938  0422 2742          	jreq	L745
1939  0424 204c          	jra	L326
1940  0426               L535:
1941                     ; 319 			red=brightness;
1943  0426 7b0b          	ld	a,(OFST+6,sp)
1944  0428 6b01          	ld	(OFST-4,sp),a
1946                     ; 320 			green=residual;
1948  042a 7b05          	ld	a,(OFST+0,sp)
1949  042c 6b02          	ld	(OFST-3,sp),a
1951                     ; 321 			blue=0;
1953  042e 0f03          	clr	(OFST-2,sp)
1955                     ; 322 			break;
1957  0430 2040          	jra	L326
1958  0432               L735:
1959                     ; 324 			red=brightness-residual;
1961  0432 7b0b          	ld	a,(OFST+6,sp)
1962  0434 1005          	sub	a,(OFST+0,sp)
1963  0436 6b01          	ld	(OFST-4,sp),a
1965                     ; 325 			green=brightness;
1967  0438 7b0b          	ld	a,(OFST+6,sp)
1968  043a 6b02          	ld	(OFST-3,sp),a
1970                     ; 326 			blue=0;
1972  043c 0f03          	clr	(OFST-2,sp)
1974                     ; 327 			break;
1976  043e 2032          	jra	L326
1977  0440               L145:
1978                     ; 329 			red=0;
1980  0440 0f01          	clr	(OFST-4,sp)
1982                     ; 330 			green=brightness;
1984  0442 7b0b          	ld	a,(OFST+6,sp)
1985  0444 6b02          	ld	(OFST-3,sp),a
1987                     ; 331 			blue=residual;
1989  0446 7b05          	ld	a,(OFST+0,sp)
1990  0448 6b03          	ld	(OFST-2,sp),a
1992                     ; 332 			break;
1994  044a 2026          	jra	L326
1995  044c               L345:
1996                     ; 334 			red=0;
1998  044c 0f01          	clr	(OFST-4,sp)
2000                     ; 335 			green=brightness-residual;
2002  044e 7b0b          	ld	a,(OFST+6,sp)
2003  0450 1005          	sub	a,(OFST+0,sp)
2004  0452 6b02          	ld	(OFST-3,sp),a
2006                     ; 336 			blue=brightness;
2008  0454 7b0b          	ld	a,(OFST+6,sp)
2009  0456 6b03          	ld	(OFST-2,sp),a
2011                     ; 337 			break;
2013  0458 2018          	jra	L326
2014  045a               L545:
2015                     ; 339 			red=residual;
2017  045a 7b05          	ld	a,(OFST+0,sp)
2018  045c 6b01          	ld	(OFST-4,sp),a
2020                     ; 340 			green=0;
2022  045e 0f02          	clr	(OFST-3,sp)
2024                     ; 341 			blue=brightness;
2026  0460 7b0b          	ld	a,(OFST+6,sp)
2027  0462 6b03          	ld	(OFST-2,sp),a
2029                     ; 342 			break;
2031  0464 200c          	jra	L326
2032  0466               L745:
2033                     ; 344 			red=brightness;
2035  0466 7b0b          	ld	a,(OFST+6,sp)
2036  0468 6b01          	ld	(OFST-4,sp),a
2038                     ; 345 			green=0;
2040  046a 0f02          	clr	(OFST-3,sp)
2042                     ; 346 			blue=brightness-residual;
2044  046c 7b0b          	ld	a,(OFST+6,sp)
2045  046e 1005          	sub	a,(OFST+0,sp)
2046  0470 6b03          	ld	(OFST-2,sp),a
2048                     ; 347 			break;
2050  0472               L326:
2051                     ; 350 	set_rgb(index,0,red);
2053  0472 7b01          	ld	a,(OFST-4,sp)
2054  0474 88            	push	a
2055  0475 7b07          	ld	a,(OFST+2,sp)
2056  0477 5f            	clrw	x
2057  0478 95            	ld	xh,a
2058  0479 ad1c          	call	_set_rgb
2060  047b 84            	pop	a
2061                     ; 351 	set_rgb(index,1,green);
2063  047c 7b02          	ld	a,(OFST-3,sp)
2064  047e 88            	push	a
2065  047f 7b07          	ld	a,(OFST+2,sp)
2066  0481 ae0001        	ldw	x,#1
2067  0484 95            	ld	xh,a
2068  0485 ad10          	call	_set_rgb
2070  0487 84            	pop	a
2071                     ; 352 	set_rgb(index,2,blue);
2073  0488 7b03          	ld	a,(OFST-2,sp)
2074  048a 88            	push	a
2075  048b 7b07          	ld	a,(OFST+2,sp)
2076  048d ae0002        	ldw	x,#2
2077  0490 95            	ld	xh,a
2078  0491 ad04          	call	_set_rgb
2080  0493 84            	pop	a
2081                     ; 353 }
2084  0494 5b06          	addw	sp,#6
2085  0496 81            	ret
2138                     ; 355 void set_rgb(u8 index,u8 color,u8 brightness)
2138                     ; 356 {
2139                     	switch	.text
2140  0497               _set_rgb:
2142  0497 89            	pushw	x
2143       00000000      OFST:	set	0
2146                     ; 357 	pwm_brightness_buffer[index*3+color]=brightness;
2148  0498 9e            	ld	a,xh
2149  0499 97            	ld	xl,a
2150  049a a603          	ld	a,#3
2151  049c 42            	mul	x,a
2152  049d 01            	rrwa	x,a
2153  049e 1b02          	add	a,(OFST+2,sp)
2154  04a0 2401          	jrnc	L441
2155  04a2 5c            	incw	x
2156  04a3               L441:
2157  04a3 02            	rlwa	x,a
2158  04a4 7b05          	ld	a,(OFST+5,sp)
2159  04a6 e7c0          	ld	(_pwm_brightness_buffer,x),a
2160                     ; 358 }
2163  04a8 85            	popw	x
2164  04a9 81            	ret
2208                     ; 360 void set_white(u8 index,u8 brightness)
2208                     ; 361 {
2209                     	switch	.text
2210  04aa               _set_white:
2212  04aa 89            	pushw	x
2213       00000000      OFST:	set	0
2216                     ; 362 	pwm_brightness_buffer[31+index]=brightness;
2218  04ab 9e            	ld	a,xh
2219  04ac 5f            	clrw	x
2220  04ad 97            	ld	xl,a
2221  04ae 7b02          	ld	a,(OFST+2,sp)
2222  04b0 e7df          	ld	(_pwm_brightness_buffer+31,x),a
2223                     ; 363 }
2226  04b2 85            	popw	x
2227  04b3 81            	ret
2262                     ; 366 void set_debug(u8 brightness)
2262                     ; 367 {
2263                     	switch	.text
2264  04b4               _set_debug:
2268                     ; 368 	pwm_brightness_buffer[30]=brightness;
2270  04b4 b7de          	ld	_pwm_brightness_buffer+30,a
2271                     ; 369 }
2274  04b6 81            	ret
2299                     ; 371 void set_matrix_high_z()
2299                     ; 372 {
2300                     	switch	.text
2301  04b7               _set_matrix_high_z:
2305                     ; 375 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
2307  04b7 4b00          	push	#0
2308  04b9 4bf8          	push	#248
2309  04bb ae500a        	ldw	x,#20490
2310  04be cd0000        	call	_GPIO_Init
2312  04c1 85            	popw	x
2313                     ; 376 		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
2315  04c2 4b00          	push	#0
2316  04c4 4b0c          	push	#12
2317  04c6 ae500f        	ldw	x,#20495
2318  04c9 cd0000        	call	_GPIO_Init
2320  04cc 85            	popw	x
2321                     ; 377 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
2323  04cd 4b00          	push	#0
2324  04cf 4b08          	push	#8
2325  04d1 ae5000        	ldw	x,#20480
2326  04d4 cd0000        	call	_GPIO_Init
2328  04d7 85            	popw	x
2329                     ; 381 }
2332  04d8 81            	ret
2356                     ; 384 u8 get_audio_sample()
2356                     ; 385 {
2357                     	switch	.text
2358  04d9               _get_audio_sample:
2362                     ; 391 	return 0;//revision 1 hw misrouted this connection, made it un-readable
2364  04d9 4f            	clr	a
2367  04da 81            	ret
2370                     	switch	.const
2371  0006               L337_led_lookup:
2372  0006 00            	dc.b	0
2373  0007 01            	dc.b	1
2374  0008 00            	dc.b	0
2375  0009 02            	dc.b	2
2376  000a 01            	dc.b	1
2377  000b 02            	dc.b	2
2378  000c 01            	dc.b	1
2379  000d 00            	dc.b	0
2380  000e 02            	dc.b	2
2381  000f 00            	dc.b	0
2382  0010 02            	dc.b	2
2383  0011 01            	dc.b	1
2384  0012 05            	dc.b	5
2385  0013 00            	dc.b	0
2386  0014 05            	dc.b	5
2387  0015 01            	dc.b	1
2388  0016 05            	dc.b	5
2389  0017 02            	dc.b	2
2390  0018 06            	dc.b	6
2391  0019 00            	dc.b	0
2392  001a 06            	dc.b	6
2393  001b 01            	dc.b	1
2394  001c 06            	dc.b	6
2395  001d 02            	dc.b	2
2396  001e 06            	dc.b	6
2397  001f 05            	dc.b	5
2398  0020 06            	dc.b	6
2399  0021 04            	dc.b	4
2400  0022 05            	dc.b	5
2401  0023 04            	dc.b	4
2402  0024 04            	dc.b	4
2403  0025 03            	dc.b	3
2404  0026 05            	dc.b	5
2405  0027 03            	dc.b	3
2406  0028 06            	dc.b	6
2407  0029 03            	dc.b	3
2408  002a 03            	dc.b	3
2409  002b 04            	dc.b	4
2410  002c 03            	dc.b	3
2411  002d 05            	dc.b	5
2412  002e 03            	dc.b	3
2413  002f 06            	dc.b	6
2414  0030 00            	dc.b	0
2415  0031 05            	dc.b	5
2416  0032 00            	dc.b	0
2417  0033 06            	dc.b	6
2418  0034 01            	dc.b	1
2419  0035 06            	dc.b	6
2420  0036 00            	dc.b	0
2421  0037 04            	dc.b	4
2422  0038 01            	dc.b	1
2423  0039 04            	dc.b	4
2424  003a 02            	dc.b	2
2425  003b 04            	dc.b	4
2426  003c 00            	dc.b	0
2427  003d 03            	dc.b	3
2428  003e 01            	dc.b	1
2429  003f 03            	dc.b	3
2430  0040 02            	dc.b	2
2431  0041 03            	dc.b	3
2432  0042 07            	dc.b	7
2433  0043 07            	dc.b	7
2434  0044 03            	dc.b	3
2435  0045 00            	dc.b	0
2436  0046 03            	dc.b	3
2437  0047 01            	dc.b	1
2438  0048 03            	dc.b	3
2439  0049 02            	dc.b	2
2440  004a 04            	dc.b	4
2441  004b 00            	dc.b	0
2442  004c 01            	dc.b	1
2443  004d 05            	dc.b	5
2444  004e 02            	dc.b	2
2445  004f 05            	dc.b	5
2446  0050 04            	dc.b	4
2447  0051 01            	dc.b	1
2448  0052 04            	dc.b	4
2449  0053 02            	dc.b	2
2450  0054 02            	dc.b	2
2451  0055 06            	dc.b	6
2452  0056 04            	dc.b	4
2453  0057 06            	dc.b	6
2454  0058 04            	dc.b	4
2455  0059 05            	dc.b	5
2456  005a 05            	dc.b	5
2457  005b 06            	dc.b	6
2668                     ; 395 void set_led(u8 led_index)
2668                     ; 396 {
2669                     	switch	.text
2670  04db               _set_led:
2672  04db 88            	push	a
2673  04dc 525c          	subw	sp,#92
2674       0000005c      OFST:	set	92
2677                     ; 400 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
2677                     ; 401 		{0,1},{0,2},{1,2},//LED7  RGB
2677                     ; 402 		{1,0},{2,0},{2,1},//LED3  RGB
2677                     ; 403 		{5,0},{5,1},{5,2},//LED1  RGB
2677                     ; 404 		{6,0},{6,1},{6,2},//LED20 RGB
2677                     ; 405 		{6,5},{6,4},{5,4},//LED22 RGB
2677                     ; 406 		{4,3},{5,3},{6,3},//LED23 RGB
2677                     ; 407 		{3,4},{3,5},{3,6},//LED21 RGB
2677                     ; 408 		{0,5},{0,6},{1,6},//LED19 RGB
2677                     ; 409 		{0,4},{1,4},{2,4},//LED18 RGB
2677                     ; 410 		{0,3},{1,3},{2,3},//LED2  RGB
2677                     ; 411 		{7,7},//debug; GND is tied low, no charlieplexing involved
2677                     ; 412 		{3,0},//LED6
2677                     ; 413 		{3,1},//LED4
2677                     ; 414 		{3,2},//LED5
2677                     ; 415 		{4,0},//LED14
2677                     ; 416 		{1,5},//LED8
2677                     ; 417 		{2,5},//LED9
2677                     ; 418 		{4,1},//LED10
2677                     ; 419 		{4,2},//LED16
2677                     ; 420 		{2,6},//LED17
2677                     ; 421 		{4,6},//LED12
2677                     ; 422 		{4,5},//LED13
2677                     ; 423 		{5,6} //LED11
2677                     ; 424 	};
2679  04de 96            	ldw	x,sp
2680  04df 1c0006        	addw	x,#OFST-86
2681  04e2 90ae0006      	ldw	y,#L337_led_lookup
2682  04e6 a656          	ld	a,#86
2683  04e8 cd0000        	call	c_xymov
2685                     ; 425 	bool is_high=0;
2687  04eb 0f5c          	clr	(OFST+0,sp)
2689  04ed               L1011:
2690                     ; 429 		switch(led_lookup[led_index][!is_high])
2692  04ed 0d5c          	tnz	(OFST+0,sp)
2693  04ef 2605          	jrne	L061
2694  04f1 ae0001        	ldw	x,#1
2695  04f4 2001          	jra	L261
2696  04f6               L061:
2697  04f6 5f            	clrw	x
2698  04f7               L261:
2699  04f7 9096          	ldw	y,sp
2700  04f9 72a90006      	addw	y,#OFST-86
2701  04fd 1701          	ldw	(OFST-91,sp),y
2703  04ff 7b5d          	ld	a,(OFST+1,sp)
2704  0501 905f          	clrw	y
2705  0503 9097          	ld	yl,a
2706  0505 9058          	sllw	y
2707  0507 72f901        	addw	y,(OFST-91,sp)
2708  050a bf00          	ldw	c_y,x
2709  050c 51            	exgw	x,y
2710  050d 92d600        	ld	a,([c_y.w],x)
2711  0510 51            	exgw	x,y
2713                     ; 465 			}break;
2714  0511 4d            	tnz	a
2715  0512 2717          	jreq	L537
2716  0514 4a            	dec	a
2717  0515 271f          	jreq	L737
2718  0517 4a            	dec	a
2719  0518 2727          	jreq	L147
2720  051a 4a            	dec	a
2721  051b 272f          	jreq	L347
2722  051d 4a            	dec	a
2723  051e 2737          	jreq	L547
2724  0520 4a            	dec	a
2725  0521 273f          	jreq	L747
2726  0523 4a            	dec	a
2727  0524 2747          	jreq	L157
2728  0526 4a            	dec	a
2729  0527 274f          	jreq	L357
2730  0529 2056          	jra	L1111
2731  052b               L537:
2732                     ; 432 				GPIOx=GPIOD;
2734  052b ae500f        	ldw	x,#20495
2735  052e 1f03          	ldw	(OFST-89,sp),x
2737                     ; 433 				PortPin=GPIO_PIN_3;
2739  0530 a608          	ld	a,#8
2740  0532 6b05          	ld	(OFST-87,sp),a
2742                     ; 434 			}break;
2744  0534 204b          	jra	L1111
2745  0536               L737:
2746                     ; 436 				GPIOx=GPIOD;
2748  0536 ae500f        	ldw	x,#20495
2749  0539 1f03          	ldw	(OFST-89,sp),x
2751                     ; 437 				PortPin=GPIO_PIN_2;
2753  053b a604          	ld	a,#4
2754  053d 6b05          	ld	(OFST-87,sp),a
2756                     ; 438 			}break;
2758  053f 2040          	jra	L1111
2759  0541               L147:
2760                     ; 440 				GPIOx=GPIOC;
2762  0541 ae500a        	ldw	x,#20490
2763  0544 1f03          	ldw	(OFST-89,sp),x
2765                     ; 441 				PortPin=GPIO_PIN_7;
2767  0546 a680          	ld	a,#128
2768  0548 6b05          	ld	(OFST-87,sp),a
2770                     ; 442 			}break;
2772  054a 2035          	jra	L1111
2773  054c               L347:
2774                     ; 444 				GPIOx=GPIOC;
2776  054c ae500a        	ldw	x,#20490
2777  054f 1f03          	ldw	(OFST-89,sp),x
2779                     ; 445 				PortPin=GPIO_PIN_6;
2781  0551 a640          	ld	a,#64
2782  0553 6b05          	ld	(OFST-87,sp),a
2784                     ; 446 			}break;
2786  0555 202a          	jra	L1111
2787  0557               L547:
2788                     ; 448 				GPIOx=GPIOC;
2790  0557 ae500a        	ldw	x,#20490
2791  055a 1f03          	ldw	(OFST-89,sp),x
2793                     ; 449 				PortPin=GPIO_PIN_5;
2795  055c a620          	ld	a,#32
2796  055e 6b05          	ld	(OFST-87,sp),a
2798                     ; 450 			}break;
2800  0560 201f          	jra	L1111
2801  0562               L747:
2802                     ; 452 				GPIOx=GPIOC;
2804  0562 ae500a        	ldw	x,#20490
2805  0565 1f03          	ldw	(OFST-89,sp),x
2807                     ; 453 				PortPin=GPIO_PIN_4;
2809  0567 a610          	ld	a,#16
2810  0569 6b05          	ld	(OFST-87,sp),a
2812                     ; 454 			}break;
2814  056b 2014          	jra	L1111
2815  056d               L157:
2816                     ; 456 				GPIOx=GPIOC;
2818  056d ae500a        	ldw	x,#20490
2819  0570 1f03          	ldw	(OFST-89,sp),x
2821                     ; 457 				PortPin=GPIO_PIN_3;
2823  0572 a608          	ld	a,#8
2824  0574 6b05          	ld	(OFST-87,sp),a
2826                     ; 458 			}break;
2828  0576 2009          	jra	L1111
2829  0578               L357:
2830                     ; 460 				GPIOx=GPIOA;
2832  0578 ae5000        	ldw	x,#20480
2833  057b 1f03          	ldw	(OFST-89,sp),x
2835                     ; 461 				PortPin=GPIO_PIN_3;
2837  057d a608          	ld	a,#8
2838  057f 6b05          	ld	(OFST-87,sp),a
2840                     ; 462 			}break;
2842  0581               L1111:
2843                     ; 467 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
2845  0581 0d5c          	tnz	(OFST+0,sp)
2846  0583 2704          	jreq	L461
2847  0585 a6d0          	ld	a,#208
2848  0587 2002          	jra	L661
2849  0589               L461:
2850  0589 a6c0          	ld	a,#192
2851  058b               L661:
2852  058b 88            	push	a
2853  058c 7b06          	ld	a,(OFST-86,sp)
2854  058e 88            	push	a
2855  058f 1e05          	ldw	x,(OFST-87,sp)
2856  0591 cd0000        	call	_GPIO_Init
2858  0594 85            	popw	x
2859                     ; 468 		is_high=!is_high;
2861  0595 0d5c          	tnz	(OFST+0,sp)
2862  0597 2604          	jrne	L071
2863  0599 a601          	ld	a,#1
2864  059b 2001          	jra	L271
2865  059d               L071:
2866  059d 4f            	clr	a
2867  059e               L271:
2868  059e 6b5c          	ld	(OFST+0,sp),a
2870                     ; 469 	}while(is_high);
2872  05a0 0d5c          	tnz	(OFST+0,sp)
2873  05a2 2703          	jreq	L471
2874  05a4 cc04ed        	jp	L1011
2875  05a7               L471:
2876                     ; 470 }
2879  05a7 5b5d          	addw	sp,#93
2880  05a9 81            	ret
2904                     ; 473 bool is_space_sao()
2904                     ; 474 {
2905                     	switch	.text
2906  05aa               _is_space_sao:
2910                     ; 475 	return 1;//TODO: implement EEPROM read
2912  05aa a601          	ld	a,#1
2915  05ac 81            	ret
2949                     ; 478 u8 get_eeprom_byte(u16 eeprom_address)
2949                     ; 479 {
2950                     	switch	.text
2951  05ad               _get_eeprom_byte:
2955                     ; 480 	return (*(PointerAttr uint8_t *) (0x4000+eeprom_address));
2957  05ad d64000        	ld	a,(16384,x)
2960  05b0 81            	ret
3142                     	xdef	f_TIM2_CapComp_IRQ_Handler
3143                     	xdef	f_TIM2_UPD_OVF_IRQHandler
3144                     	switch	.ubsct
3145  0000               _audio_running_std:
3146  0000 0000          	ds.b	2
3147                     	xdef	_audio_running_std
3148  0002               _audio_running_mean:
3149  0002 0000          	ds.b	2
3150                     	xdef	_audio_running_mean
3151  0004               _audio_std:
3152  0004 00            	ds.b	1
3153                     	xdef	_audio_std
3154  0005               _audio_mean:
3155  0005 00            	ds.b	1
3156                     	xdef	_audio_mean
3157                     	xdef	_audio_measurement_count
3158  0006               _button_pressed_event:
3159  0006 00000000      	ds.b	4
3160                     	xdef	_button_pressed_event
3161  000a               _button_start_ms:
3162  000a 00000000      	ds.b	4
3163                     	xdef	_button_start_ms
3164                     	xdef	_pwm_state
3165                     	xdef	_pwm_led_index
3166                     	xdef	_pwm_sleep_remaining
3167  000e               _pwm_led_count:
3168  000e 0000          	ds.b	2
3169                     	xdef	_pwm_led_count
3170  0010               _pwm_sleep:
3171  0010 00000000      	ds.b	4
3172                     	xdef	_pwm_sleep
3173  0014               _pwm_brightness:
3174  0014 000000000000  	ds.b	172
3175                     	xdef	_pwm_brightness
3176                     	xdef	_PWM_MAX_PERIOD
3177  00c0               _pwm_brightness_buffer:
3178  00c0 000000000000  	ds.b	43
3179                     	xdef	_pwm_brightness_buffer
3180                     	xdef	_api_counter
3181                     	xdef	_hw_revision
3182                     	xref	_ADC1_ClearFlag
3183                     	xref	_ADC1_StartConversion
3184                     	xref	_UART1_Cmd
3185                     	xref	_UART1_Init
3186                     	xref	_UART1_DeInit
3187                     	xref	_GPIO_ReadInputPin
3188                     	xref	_GPIO_Init
3189                     	xdef	_get_eeprom_byte
3190                     	xdef	_set_millis
3191                     	xdef	_get_audio_level
3192                     	xdef	_get_random
3193                     	xdef	_is_space_sao
3194                     	xdef	_update_audio
3195                     	xdef	_is_button_down
3196                     	xdef	_clear_button_events
3197                     	xdef	_clear_button_event
3198                     	xdef	_get_button_event
3199                     	xdef	_update_buttons
3200                     	xdef	_is_sleep_valid
3201                     	xdef	_is_developer_valid
3202                     	xdef	_set_hue
3203                     	xdef	_flush_leds
3204                     	xdef	_set_led
3205                     	xdef	_get_audio_sample
3206                     	xdef	_set_debug
3207                     	xdef	_set_white
3208                     	xdef	_set_rgb
3209                     	xdef	_set_matrix_high_z
3210                     	xdef	_millis
3211                     	xdef	_setup_main
3212                     	xdef	_is_application_valid
3213                     	xdef	_setup_serial
3214                     	xref.b	c_lreg
3215                     	xref.b	c_x
3216                     	xref.b	c_y
3236                     	xref	c_xymov
3237                     	xref	c_bmulx
3238                     	xref	c_idiv
3239                     	xref	c_lgadc
3240                     	xref	c_lzmp
3241                     	xref	c_lsub
3242                     	xref	c_rtol
3243                     	xref	c_uitolx
3244                     	xref	c_ltor
3245                     	xref	c_itolx
3246                     	xref	c_imul
3247                     	end
