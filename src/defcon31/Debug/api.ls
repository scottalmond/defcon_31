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
  73                     	switch	.const
  74  0002               L21:
  75  0002 000d          	dc.w	L3
  76  0004 0012          	dc.w	L5
  77  0006 001d          	dc.w	L7
  78  0008 0027          	dc.w	L11
  79  000a 0032          	dc.w	L31
  80  000c 003d          	dc.w	L51
  81  000e 0048          	dc.w	L71
  82  0010 0053          	dc.w	L12
  83  0012 005e          	dc.w	L32
  84  0014 0069          	dc.w	L52
  85  0016 0074          	dc.w	L72
  86                     ; 28 u16 get_val(u8 index)
  86                     ; 29 {
  87                     	scross	off
  88                     	switch	.text
  89  0000               _get_val:
  93                     ; 30 	switch(index)
  96                     ; 63 			return pwm_brightness[3][1][pwm_state&0x01];
  97  0000 a10b          	cp	a,#11
  98  0002 2407          	jruge	L01
  99  0004 5f            	clrw	x
 100  0005 97            	ld	xl,a
 101  0006 58            	sllw	x
 102  0007 de0002        	ldw	x,(L21,x)
 103  000a fc            	jp	(x)
 104  000b               L01:
 105  000b               L6:
 106                     ; 67 	return 0;
 108  000b 5f            	clrw	x
 111  000c 81            	ret
 112  000d               L3:
 113                     ; 33 			return pwm_state;//2-3
 115  000d b607          	ld	a,_pwm_state
 116  000f 5f            	clrw	x
 117  0010 97            	ld	xl,a
 120  0011 81            	ret
 121  0012               L5:
 122                     ; 36 			return pwm_led_count[pwm_state&0x01];//4?
 124  0012 b607          	ld	a,_pwm_state
 125  0014 a401          	and	a,#1
 126  0016 5f            	clrw	x
 127  0017 97            	ld	xl,a
 128  0018 e600          	ld	a,(_pwm_led_count,x)
 129  001a 5f            	clrw	x
 130  001b 97            	ld	xl,a
 133  001c 81            	ret
 134  001d               L7:
 135                     ; 39 			return pwm_sleep[pwm_state&0x01];
 137  001d b607          	ld	a,_pwm_state
 138  001f a401          	and	a,#1
 139  0021 5f            	clrw	x
 140  0022 97            	ld	xl,a
 141  0023 58            	sllw	x
 142  0024 ee02          	ldw	x,(_pwm_sleep,x)
 145  0026 81            	ret
 146  0027               L11:
 147                     ; 42 			return pwm_brightness[0][0][pwm_state&0x01];
 149  0027 b607          	ld	a,_pwm_state
 150  0029 a401          	and	a,#1
 151  002b 5f            	clrw	x
 152  002c 97            	ld	xl,a
 153  002d e606          	ld	a,(_pwm_brightness,x)
 154  002f 5f            	clrw	x
 155  0030 97            	ld	xl,a
 158  0031 81            	ret
 159  0032               L31:
 160                     ; 45 			return pwm_brightness[1][0][pwm_state&0x01];
 162  0032 b607          	ld	a,_pwm_state
 163  0034 a401          	and	a,#1
 164  0036 5f            	clrw	x
 165  0037 97            	ld	xl,a
 166  0038 e60a          	ld	a,(_pwm_brightness+4,x)
 167  003a 5f            	clrw	x
 168  003b 97            	ld	xl,a
 171  003c 81            	ret
 172  003d               L51:
 173                     ; 48 			return pwm_brightness[2][0][pwm_state&0x01];
 175  003d b607          	ld	a,_pwm_state
 176  003f a401          	and	a,#1
 177  0041 5f            	clrw	x
 178  0042 97            	ld	xl,a
 179  0043 e60e          	ld	a,(_pwm_brightness+8,x)
 180  0045 5f            	clrw	x
 181  0046 97            	ld	xl,a
 184  0047 81            	ret
 185  0048               L71:
 186                     ; 51 			return pwm_brightness[3][0][pwm_state&0x01];
 188  0048 b607          	ld	a,_pwm_state
 189  004a a401          	and	a,#1
 190  004c 5f            	clrw	x
 191  004d 97            	ld	xl,a
 192  004e e612          	ld	a,(_pwm_brightness+12,x)
 193  0050 5f            	clrw	x
 194  0051 97            	ld	xl,a
 197  0052 81            	ret
 198  0053               L12:
 199                     ; 54 			return pwm_brightness[0][1][pwm_state&0x01];
 201  0053 b607          	ld	a,_pwm_state
 202  0055 a401          	and	a,#1
 203  0057 5f            	clrw	x
 204  0058 97            	ld	xl,a
 205  0059 e608          	ld	a,(_pwm_brightness+2,x)
 206  005b 5f            	clrw	x
 207  005c 97            	ld	xl,a
 210  005d 81            	ret
 211  005e               L32:
 212                     ; 57 			return pwm_brightness[1][1][pwm_state&0x01];
 214  005e b607          	ld	a,_pwm_state
 215  0060 a401          	and	a,#1
 216  0062 5f            	clrw	x
 217  0063 97            	ld	xl,a
 218  0064 e60c          	ld	a,(_pwm_brightness+6,x)
 219  0066 5f            	clrw	x
 220  0067 97            	ld	xl,a
 223  0068 81            	ret
 224  0069               L52:
 225                     ; 60 			return pwm_brightness[2][1][pwm_state&0x01];
 227  0069 b607          	ld	a,_pwm_state
 228  006b a401          	and	a,#1
 229  006d 5f            	clrw	x
 230  006e 97            	ld	xl,a
 231  006f e610          	ld	a,(_pwm_brightness+10,x)
 232  0071 5f            	clrw	x
 233  0072 97            	ld	xl,a
 236  0073 81            	ret
 237  0074               L72:
 238                     ; 63 			return pwm_brightness[3][1][pwm_state&0x01];
 240  0074 b607          	ld	a,_pwm_state
 241  0076 a401          	and	a,#1
 242  0078 5f            	clrw	x
 243  0079 97            	ld	xl,a
 244  007a e614          	ld	a,(_pwm_brightness+14,x)
 245  007c 5f            	clrw	x
 246  007d 97            	ld	xl,a
 249  007e 81            	ret
 250  007f               L13:
 251  007f 208a          	jra	L6
 319                     ; 70 void serial_setup(bool is_enabled,u32 baud_rate)
 319                     ; 71 {
 320                     	switch	.text
 321  0081               _serial_setup:
 323  0081 88            	push	a
 324       00000000      OFST:	set	0
 327                     ; 72 	if(is_enabled)
 329  0082 4d            	tnz	a
 330  0083 2735          	jreq	L511
 331                     ; 74 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 333  0085 4bf0          	push	#240
 334  0087 4b20          	push	#32
 335  0089 ae500f        	ldw	x,#20495
 336  008c cd0000        	call	_GPIO_Init
 338  008f 85            	popw	x
 339                     ; 75 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 341  0090 4b40          	push	#64
 342  0092 4b40          	push	#64
 343  0094 ae500f        	ldw	x,#20495
 344  0097 cd0000        	call	_GPIO_Init
 346  009a 85            	popw	x
 347                     ; 76 		UART1_DeInit();
 349  009b cd0000        	call	_UART1_DeInit
 351                     ; 77 		UART1_Init(baud_rate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 353  009e 4b0c          	push	#12
 354  00a0 4b80          	push	#128
 355  00a2 4b00          	push	#0
 356  00a4 4b00          	push	#0
 357  00a6 4b00          	push	#0
 358  00a8 1e0b          	ldw	x,(OFST+11,sp)
 359  00aa 89            	pushw	x
 360  00ab 1e0b          	ldw	x,(OFST+11,sp)
 361  00ad 89            	pushw	x
 362  00ae cd0000        	call	_UART1_Init
 364  00b1 5b09          	addw	sp,#9
 365                     ; 78 		UART1_Cmd(ENABLE);
 367  00b3 a601          	ld	a,#1
 368  00b5 cd0000        	call	_UART1_Cmd
 371  00b8 201d          	jra	L711
 372  00ba               L511:
 373                     ; 80 		UART1_Cmd(DISABLE);
 375  00ba 4f            	clr	a
 376  00bb cd0000        	call	_UART1_Cmd
 378                     ; 81 		UART1_DeInit();
 380  00be cd0000        	call	_UART1_DeInit
 382                     ; 82 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 384  00c1 4b40          	push	#64
 385  00c3 4b20          	push	#32
 386  00c5 ae500f        	ldw	x,#20495
 387  00c8 cd0000        	call	_GPIO_Init
 389  00cb 85            	popw	x
 390                     ; 83 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 392  00cc 4b40          	push	#64
 393  00ce 4b40          	push	#64
 394  00d0 ae500f        	ldw	x,#20495
 395  00d3 cd0000        	call	_GPIO_Init
 397  00d6 85            	popw	x
 398  00d7               L711:
 399                     ; 85 }
 402  00d7 84            	pop	a
 403  00d8 81            	ret
 428                     ; 87 bool is_application_valid()
 428                     ; 88 {
 429                     	switch	.text
 430  00d9               _is_application_valid:
 434                     ; 89 	return 0;
 436  00d9 4f            	clr	a
 439  00da 81            	ret
 464                     ; 92 void setup()
 464                     ; 93 {
 465                     	switch	.text
 466  00db               _setup:
 470                     ; 94 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 472  00db c650c6        	ld	a,20678
 473  00de a4e7          	and	a,#231
 474  00e0 c750c6        	ld	20678,a
 475                     ; 97 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 477  00e3 725f5311      	clr	21265
 478                     ; 98 	TIM2->PSCR= 6;// init divider register 16MHz/2^X
 480  00e7 3506530e      	mov	21262,#6
 481                     ; 99 	TIM2->ARRH= 0;// init auto reload register
 483  00eb 725f530f      	clr	21263
 484                     ; 100 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 486  00ef 35fa5310      	mov	21264,#250
 487                     ; 101 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 489  00f3 c65300        	ld	a,21248
 490  00f6 aa85          	or	a,#133
 491  00f8 c75300        	ld	21248,a
 492                     ; 102 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 494  00fb 35035303      	mov	21251,#3
 495                     ; 103 	enableInterrupts();
 498  00ff 9a            rim
 500                     ; 107 }
 504  0100 81            	ret
 528                     ; 109 u32 millis()
 528                     ; 110 {
 529                     	switch	.text
 530  0101               _millis:
 534                     ; 111 	return api_counter;
 536  0101 ae0000        	ldw	x,#_api_counter
 537  0104 cd0000        	call	c_ltor
 541  0107 81            	ret
 566                     ; 115 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
 568                     	switch	.text
 569  0108               f_TIM2_UPD_OVF_IRQHandler:
 573                     ; 116 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
 575  0108 72115304      	bres	21252,#0
 576                     ; 117 	api_counter++;
 578  010c ae0000        	ldw	x,#_api_counter
 579  010f a601          	ld	a,#1
 580  0111 cd0000        	call	c_lgadc
 582                     ; 120 }
 585  0114 80            	iret
 638                     ; 123 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
 639                     	switch	.text
 640  0115               f_TIM2_CapComp_IRQ_Handler:
 642  0115 8a            	push	cc
 643  0116 84            	pop	a
 644  0117 a4bf          	and	a,#191
 645  0119 88            	push	a
 646  011a 86            	pop	cc
 647       00000004      OFST:	set	4
 648  011b 3b0002        	push	c_x+2
 649  011e be00          	ldw	x,c_x
 650  0120 89            	pushw	x
 651  0121 3b0002        	push	c_y+2
 652  0124 be00          	ldw	x,c_y
 653  0126 89            	pushw	x
 654  0127 5204          	subw	sp,#4
 657                     ; 125 	u8 sleep_amount=PWM_MAX_PERIOD;//max sleep duration before wrap-over occurs
 659  0129 a6fa          	ld	a,#250
 660  012b 6b04          	ld	(OFST+0,sp),a
 662                     ; 126 	bool buffer_index=pwm_state&0x01;//primary vs redundant side to pull data from
 664  012d b607          	ld	a,_pwm_state
 665  012f a401          	and	a,#1
 666  0131 6b03          	ld	(OFST-1,sp),a
 668                     ; 128 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
 670  0133 72135304      	bres	21252,#1
 671                     ; 130 	if(pwm_sleep_remaining==0)
 673  0137 be04          	ldw	x,_pwm_sleep_remaining
 674  0139 2657          	jrne	L302
 675                     ; 132 		set_matrix_high_z();
 677  013b cd0370        	call	_set_matrix_high_z
 679                     ; 133 		if(pwm_led_index<pwm_led_count[buffer_index])
 681  013e 7b03          	ld	a,(OFST-1,sp)
 682  0140 5f            	clrw	x
 683  0141 97            	ld	xl,a
 684  0142 e600          	ld	a,(_pwm_led_count,x)
 685  0144 b106          	cp	a,_pwm_led_index
 686  0146 2333          	jrule	L502
 687                     ; 135 			set_led(pwm_brightness[pwm_led_index][0][buffer_index]);//turn on the next LED
 689  0148 b606          	ld	a,_pwm_led_index
 690  014a 97            	ld	xl,a
 691  014b a604          	ld	a,#4
 692  014d 42            	mul	x,a
 693  014e 01            	rrwa	x,a
 694  014f 1b03          	add	a,(OFST-1,sp)
 695  0151 2401          	jrnc	L03
 696  0153 5c            	incw	x
 697  0154               L03:
 698  0154 02            	rlwa	x,a
 699  0155 e606          	ld	a,(_pwm_brightness,x)
 700  0157 cd0394        	call	_set_led
 702                     ; 136 			pwm_sleep_remaining=0x00FF&(pwm_brightness[pwm_led_index][1][buffer_index]+15);//set how long to sleep in this state //+15 works ok here as magic number to correct timing errors from interrupts
 704  015a b606          	ld	a,_pwm_led_index
 705  015c 97            	ld	xl,a
 706  015d a604          	ld	a,#4
 707  015f 42            	mul	x,a
 708  0160 01            	rrwa	x,a
 709  0161 1b03          	add	a,(OFST-1,sp)
 710  0163 2401          	jrnc	L23
 711  0165 5c            	incw	x
 712  0166               L23:
 713  0166 02            	rlwa	x,a
 714  0167 e608          	ld	a,(_pwm_brightness+2,x)
 715  0169 5f            	clrw	x
 716  016a 97            	ld	xl,a
 717  016b 1c000f        	addw	x,#15
 718  016e 01            	rrwa	x,a
 719  016f a4ff          	and	a,#255
 720  0171 5f            	clrw	x
 721  0172 b705          	ld	_pwm_sleep_remaining+1,a
 722  0174 9f            	ld	a,xl
 723  0175 b704          	ld	_pwm_sleep_remaining,a
 724                     ; 137 			pwm_led_index++;//prepare state machine to go to the next led later
 726  0177 3c06          	inc	_pwm_led_index
 728  0179 2017          	jra	L302
 729  017b               L502:
 730                     ; 139 			pwm_led_index=0;//reset state machine to 0
 732  017b 3f06          	clr	_pwm_led_index
 733                     ; 140 			pwm_sleep_remaining=pwm_sleep[buffer_index];
 735  017d 7b03          	ld	a,(OFST-1,sp)
 736  017f 5f            	clrw	x
 737  0180 97            	ld	xl,a
 738  0181 58            	sllw	x
 739  0182 ee02          	ldw	x,(_pwm_sleep,x)
 740  0184 bf04          	ldw	_pwm_sleep_remaining,x
 741                     ; 141 			if(pwm_state&0x02) pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
 743  0186 b607          	ld	a,_pwm_state
 744  0188 a502          	bcp	a,#2
 745  018a 2706          	jreq	L302
 748  018c b607          	ld	a,_pwm_state
 749  018e a803          	xor	a,#3
 750  0190 b707          	ld	_pwm_state,a
 751  0192               L302:
 752                     ; 144 	sleep_amount=pwm_sleep_remaining<sleep_amount?pwm_sleep_remaining:sleep_amount;
 754  0192 7b04          	ld	a,(OFST+0,sp)
 755  0194 5f            	clrw	x
 756  0195 97            	ld	xl,a
 757  0196 bf00          	ldw	c_x,x
 758  0198 be04          	ldw	x,_pwm_sleep_remaining
 759  019a b300          	cpw	x,c_x
 760  019c 2404          	jruge	L43
 761  019e b605          	ld	a,_pwm_sleep_remaining+1
 762  01a0 2002          	jra	L63
 763  01a2               L43:
 764  01a2 7b04          	ld	a,(OFST+0,sp)
 765  01a4               L63:
 766  01a4 6b04          	ld	(OFST+0,sp),a
 768                     ; 145 	pwm_sleep_remaining-=sleep_amount;
 770  01a6 7b04          	ld	a,(OFST+0,sp)
 771  01a8 5f            	clrw	x
 772  01a9 97            	ld	xl,a
 773  01aa 1f01          	ldw	(OFST-3,sp),x
 775  01ac be04          	ldw	x,_pwm_sleep_remaining
 776  01ae 72f001        	subw	x,(OFST-3,sp)
 777  01b1 bf04          	ldw	_pwm_sleep_remaining,x
 778                     ; 147 	TIM2->CCR1L = ( (TIM2->CCR1L) + sleep_amount )%PWM_MAX_PERIOD;//set wakeup alarm relative to current time
 780  01b3 c65312        	ld	a,21266
 781  01b6 5f            	clrw	x
 782  01b7 1b04          	add	a,(OFST+0,sp)
 783  01b9 2401          	jrnc	L04
 784  01bb 5c            	incw	x
 785  01bc               L04:
 786  01bc 02            	rlwa	x,a
 787  01bd 90ae00fa      	ldw	y,#250
 788  01c1 cd0000        	call	c_idiv
 790  01c4 51            	exgw	x,y
 791  01c5 01            	rrwa	x,a
 792  01c6 c75312        	ld	21266,a
 793  01c9 02            	rlwa	x,a
 794                     ; 148 }
 797  01ca 5b04          	addw	sp,#4
 798  01cc 85            	popw	x
 799  01cd bf00          	ldw	c_y,x
 800  01cf 320002        	pop	c_y+2
 801  01d2 85            	popw	x
 802  01d3 bf00          	ldw	c_x,x
 803  01d5 320002        	pop	c_x+2
 804  01d8 80            	iret
 869                     ; 150 void flush_leds(u8 led_count)
 869                     ; 151 {
 871                     	switch	.text
 872  01d9               _flush_leds:
 874  01d9 88            	push	a
 875  01da 5203          	subw	sp,#3
 876       00000003      OFST:	set	3
 879                     ; 152 	u8 led_read_index=0,led_write_index=0;
 883  01dc 0f02          	clr	(OFST-1,sp)
 886  01de               L152:
 887                     ; 154 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
 889  01de b607          	ld	a,_pwm_state
 890  01e0 a502          	bcp	a,#2
 891  01e2 26fa          	jrne	L152
 892                     ; 155 	buffer_index=0x01^(pwm_state&0x01);//need to wait for above flag to be cleared before evaluating this
 894  01e4 b607          	ld	a,_pwm_state
 895  01e6 a401          	and	a,#1
 896  01e8 a801          	xor	a,#1
 897  01ea 6b01          	ld	(OFST-2,sp),a
 899                     ; 156 	pwm_sleep[buffer_index]=led_count<<8;//prepare the max value of sleep, and subtract from it for each LED illuminated
 901  01ec 7b04          	ld	a,(OFST+1,sp)
 902  01ee 5f            	clrw	x
 903  01ef 97            	ld	xl,a
 904  01f0 4f            	clr	a
 905  01f1 02            	rlwa	x,a
 906  01f2 7b01          	ld	a,(OFST-2,sp)
 907  01f4 905f          	clrw	y
 908  01f6 9097          	ld	yl,a
 909  01f8 9058          	sllw	y
 910  01fa 90ef02        	ldw	(_pwm_sleep,y),x
 911                     ; 158 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
 913  01fd 0f03          	clr	(OFST+0,sp)
 916  01ff 205d          	jra	L162
 917  0201               L552:
 918                     ; 160 		if(pwm_brightness_buffer[led_read_index]>4)//min brightness, below this value instaiblity occurs magic number to avoid interrupt timing error
 920  0201 7b03          	ld	a,(OFST+0,sp)
 921  0203 5f            	clrw	x
 922  0204 97            	ld	xl,a
 923  0205 e6b2          	ld	a,(_pwm_brightness_buffer,x)
 924  0207 a105          	cp	a,#5
 925  0209 254b          	jrult	L562
 926                     ; 162 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
 928  020b 7b02          	ld	a,(OFST-1,sp)
 929  020d 97            	ld	xl,a
 930  020e a604          	ld	a,#4
 931  0210 42            	mul	x,a
 932  0211 01            	rrwa	x,a
 933  0212 1b01          	add	a,(OFST-2,sp)
 934  0214 2401          	jrnc	L44
 935  0216 5c            	incw	x
 936  0217               L44:
 937  0217 02            	rlwa	x,a
 938  0218 7b03          	ld	a,(OFST+0,sp)
 939  021a e706          	ld	(_pwm_brightness,x),a
 940                     ; 163 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
 942  021c 7b02          	ld	a,(OFST-1,sp)
 943  021e 97            	ld	xl,a
 944  021f a604          	ld	a,#4
 945  0221 42            	mul	x,a
 946  0222 01            	rrwa	x,a
 947  0223 1b01          	add	a,(OFST-2,sp)
 948  0225 2401          	jrnc	L64
 949  0227 5c            	incw	x
 950  0228               L64:
 951  0228 02            	rlwa	x,a
 952  0229 7b03          	ld	a,(OFST+0,sp)
 953  022b 905f          	clrw	y
 954  022d 9097          	ld	yl,a
 955  022f 90e6b2        	ld	a,(_pwm_brightness_buffer,y)
 956  0232 e708          	ld	(_pwm_brightness+2,x),a
 957                     ; 164 			led_write_index++;
 959  0234 0c02          	inc	(OFST-1,sp)
 961                     ; 165 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
 963  0236 7b01          	ld	a,(OFST-2,sp)
 964  0238 5f            	clrw	x
 965  0239 97            	ld	xl,a
 966  023a 58            	sllw	x
 967  023b 7b03          	ld	a,(OFST+0,sp)
 968  023d 905f          	clrw	y
 969  023f 9097          	ld	yl,a
 970  0241 90e6b2        	ld	a,(_pwm_brightness_buffer,y)
 971  0244 905f          	clrw	y
 972  0246 9097          	ld	yl,a
 973  0248 9001          	rrwa	y,a
 974  024a e003          	sub	a,(_pwm_sleep+1,x)
 975  024c 9001          	rrwa	y,a
 976  024e e202          	sbc	a,(_pwm_sleep,x)
 977  0250 9001          	rrwa	y,a
 978  0252 9050          	negw	y
 979  0254 ef02          	ldw	(_pwm_sleep,x),y
 980  0256               L562:
 981                     ; 167 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
 983  0256 7b03          	ld	a,(OFST+0,sp)
 984  0258 5f            	clrw	x
 985  0259 97            	ld	xl,a
 986  025a 6fb2          	clr	(_pwm_brightness_buffer,x)
 987                     ; 158 	for(led_read_index=0;(led_read_index<LED_COUNT && led_write_index<led_count);led_read_index++)
 989  025c 0c03          	inc	(OFST+0,sp)
 991  025e               L162:
 994  025e 7b03          	ld	a,(OFST+0,sp)
 995  0260 a12b          	cp	a,#43
 996  0262 2406          	jruge	L762
 998  0264 7b02          	ld	a,(OFST-1,sp)
 999  0266 1104          	cp	a,(OFST+1,sp)
1000  0268 2597          	jrult	L552
1001  026a               L762:
1002                     ; 169 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
1004  026a 7b01          	ld	a,(OFST-2,sp)
1005  026c 5f            	clrw	x
1006  026d 97            	ld	xl,a
1007  026e 7b02          	ld	a,(OFST-1,sp)
1008  0270 e700          	ld	(_pwm_led_count,x),a
1009                     ; 172 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
1011  0272 72120007      	bset	_pwm_state,#1
1012                     ; 173 }
1015  0276 5b04          	addw	sp,#4
1016  0278 81            	ret
1105                     	switch	.const
1106  0018               L25:
1107  0018 00002aab      	dc.l	10923
1108                     ; 175 void set_hue(u8 index,u16 color,u8 brightness)
1108                     ; 176 {
1109                     	switch	.text
1110  0279               _set_hue:
1112  0279 88            	push	a
1113  027a 520b          	subw	sp,#11
1114       0000000b      OFST:	set	11
1117                     ; 177 	u8 red=0,green=0,blue=0;
1119  027c 0f05          	clr	(OFST-6,sp)
1123  027e 0f06          	clr	(OFST-5,sp)
1127  0280 0f07          	clr	(OFST-4,sp)
1129                     ; 178 	u32 residual=color%(0x2AAB);
1131  0282 1e0f          	ldw	x,(OFST+4,sp)
1132  0284 90ae2aab      	ldw	y,#10923
1133  0288 65            	divw	x,y
1134  0289 51            	exgw	x,y
1135  028a cd0000        	call	c_uitolx
1137  028d 96            	ldw	x,sp
1138  028e 1c0008        	addw	x,#OFST-3
1139  0291 cd0000        	call	c_rtol
1142                     ; 179 	residual=(u8)(residual*brightness/0x2AAB);
1144  0294 7b11          	ld	a,(OFST+6,sp)
1145  0296 b703          	ld	c_lreg+3,a
1146  0298 3f02          	clr	c_lreg+2
1147  029a 3f01          	clr	c_lreg+1
1148  029c 3f00          	clr	c_lreg
1149  029e 96            	ldw	x,sp
1150  029f 1c0001        	addw	x,#OFST-10
1151  02a2 cd0000        	call	c_rtol
1154  02a5 96            	ldw	x,sp
1155  02a6 1c0008        	addw	x,#OFST-3
1156  02a9 cd0000        	call	c_ltor
1158  02ac 96            	ldw	x,sp
1159  02ad 1c0001        	addw	x,#OFST-10
1160  02b0 cd0000        	call	c_lmul
1162  02b3 ae0018        	ldw	x,#L25
1163  02b6 cd0000        	call	c_ludv
1165  02b9 b603          	ld	a,c_lreg+3
1166  02bb 6b0b          	ld	(OFST+0,sp),a
1167  02bd 4f            	clr	a
1168  02be 6b0a          	ld	(OFST-1,sp),a
1169  02c0 6b09          	ld	(OFST-2,sp),a
1170  02c2 6b08          	ld	(OFST-3,sp),a
1172                     ; 180 	switch(color/(0x2AAB))//0xFFFF/6
1174  02c4 1e0f          	ldw	x,(OFST+4,sp)
1175  02c6 90ae2aab      	ldw	y,#10923
1176  02ca 65            	divw	x,y
1178                     ; 211 			break;
1179  02cb 5d            	tnzw	x
1180  02cc 2711          	jreq	L172
1181  02ce 5a            	decw	x
1182  02cf 271a          	jreq	L372
1183  02d1 5a            	decw	x
1184  02d2 2725          	jreq	L572
1185  02d4 5a            	decw	x
1186  02d5 272e          	jreq	L772
1187  02d7 5a            	decw	x
1188  02d8 2739          	jreq	L103
1189  02da 5a            	decw	x
1190  02db 2742          	jreq	L303
1191  02dd 204c          	jra	L753
1192  02df               L172:
1193                     ; 183 			red=brightness;
1195  02df 7b11          	ld	a,(OFST+6,sp)
1196  02e1 6b05          	ld	(OFST-6,sp),a
1198                     ; 184 			green=residual;
1200  02e3 7b0b          	ld	a,(OFST+0,sp)
1201  02e5 6b06          	ld	(OFST-5,sp),a
1203                     ; 185 			blue=0;
1205  02e7 0f07          	clr	(OFST-4,sp)
1207                     ; 186 			break;
1209  02e9 2040          	jra	L753
1210  02eb               L372:
1211                     ; 188 			red=brightness-residual;
1213  02eb 7b11          	ld	a,(OFST+6,sp)
1214  02ed 100b          	sub	a,(OFST+0,sp)
1215  02ef 6b05          	ld	(OFST-6,sp),a
1217                     ; 189 			green=brightness;
1219  02f1 7b11          	ld	a,(OFST+6,sp)
1220  02f3 6b06          	ld	(OFST-5,sp),a
1222                     ; 190 			blue=0;
1224  02f5 0f07          	clr	(OFST-4,sp)
1226                     ; 191 			break;
1228  02f7 2032          	jra	L753
1229  02f9               L572:
1230                     ; 193 			red=0;
1232  02f9 0f05          	clr	(OFST-6,sp)
1234                     ; 194 			green=brightness;
1236  02fb 7b11          	ld	a,(OFST+6,sp)
1237  02fd 6b06          	ld	(OFST-5,sp),a
1239                     ; 195 			blue=residual;
1241  02ff 7b0b          	ld	a,(OFST+0,sp)
1242  0301 6b07          	ld	(OFST-4,sp),a
1244                     ; 196 			break;
1246  0303 2026          	jra	L753
1247  0305               L772:
1248                     ; 198 			red=0;
1250  0305 0f05          	clr	(OFST-6,sp)
1252                     ; 199 			green=brightness-residual;
1254  0307 7b11          	ld	a,(OFST+6,sp)
1255  0309 100b          	sub	a,(OFST+0,sp)
1256  030b 6b06          	ld	(OFST-5,sp),a
1258                     ; 200 			blue=brightness;
1260  030d 7b11          	ld	a,(OFST+6,sp)
1261  030f 6b07          	ld	(OFST-4,sp),a
1263                     ; 201 			break;
1265  0311 2018          	jra	L753
1266  0313               L103:
1267                     ; 203 			red=residual;
1269  0313 7b0b          	ld	a,(OFST+0,sp)
1270  0315 6b05          	ld	(OFST-6,sp),a
1272                     ; 204 			green=0;
1274  0317 0f06          	clr	(OFST-5,sp)
1276                     ; 205 			blue=brightness;
1278  0319 7b11          	ld	a,(OFST+6,sp)
1279  031b 6b07          	ld	(OFST-4,sp),a
1281                     ; 206 			break;
1283  031d 200c          	jra	L753
1284  031f               L303:
1285                     ; 208 			red=brightness;
1287  031f 7b11          	ld	a,(OFST+6,sp)
1288  0321 6b05          	ld	(OFST-6,sp),a
1290                     ; 209 			green=0;
1292  0323 0f06          	clr	(OFST-5,sp)
1294                     ; 210 			blue=brightness-residual;
1296  0325 7b11          	ld	a,(OFST+6,sp)
1297  0327 100b          	sub	a,(OFST+0,sp)
1298  0329 6b07          	ld	(OFST-4,sp),a
1300                     ; 211 			break;
1302  032b               L753:
1303                     ; 214 	set_rgb(index,0,red);
1305  032b 7b05          	ld	a,(OFST-6,sp)
1306  032d 88            	push	a
1307  032e 7b0d          	ld	a,(OFST+2,sp)
1308  0330 5f            	clrw	x
1309  0331 95            	ld	xh,a
1310  0332 ad1c          	call	_set_rgb
1312  0334 84            	pop	a
1313                     ; 215 	set_rgb(index,1,green);
1315  0335 7b06          	ld	a,(OFST-5,sp)
1316  0337 88            	push	a
1317  0338 7b0d          	ld	a,(OFST+2,sp)
1318  033a ae0001        	ldw	x,#1
1319  033d 95            	ld	xh,a
1320  033e ad10          	call	_set_rgb
1322  0340 84            	pop	a
1323                     ; 216 	set_rgb(index,2,blue);
1325  0341 7b07          	ld	a,(OFST-4,sp)
1326  0343 88            	push	a
1327  0344 7b0d          	ld	a,(OFST+2,sp)
1328  0346 ae0002        	ldw	x,#2
1329  0349 95            	ld	xh,a
1330  034a ad04          	call	_set_rgb
1332  034c 84            	pop	a
1333                     ; 217 }
1336  034d 5b0c          	addw	sp,#12
1337  034f 81            	ret
1390                     ; 219 void set_rgb(u8 index,u8 color,u8 brightness)
1390                     ; 220 {
1391                     	switch	.text
1392  0350               _set_rgb:
1394  0350 89            	pushw	x
1395       00000000      OFST:	set	0
1398                     ; 221 	pwm_brightness_buffer[index*3+color]=brightness;
1400  0351 9e            	ld	a,xh
1401  0352 97            	ld	xl,a
1402  0353 a603          	ld	a,#3
1403  0355 42            	mul	x,a
1404  0356 01            	rrwa	x,a
1405  0357 1b02          	add	a,(OFST+2,sp)
1406  0359 2401          	jrnc	L06
1407  035b 5c            	incw	x
1408  035c               L06:
1409  035c 02            	rlwa	x,a
1410  035d 7b05          	ld	a,(OFST+5,sp)
1411  035f e7b2          	ld	(_pwm_brightness_buffer,x),a
1412                     ; 222 }
1415  0361 85            	popw	x
1416  0362 81            	ret
1460                     ; 224 void set_white(u8 index,u8 brightness)
1460                     ; 225 {
1461                     	switch	.text
1462  0363               _set_white:
1464  0363 89            	pushw	x
1465       00000000      OFST:	set	0
1468                     ; 226 	pwm_brightness_buffer[31+index]=brightness;
1470  0364 9e            	ld	a,xh
1471  0365 5f            	clrw	x
1472  0366 97            	ld	xl,a
1473  0367 7b02          	ld	a,(OFST+2,sp)
1474  0369 e7d1          	ld	(_pwm_brightness_buffer+31,x),a
1475                     ; 227 }
1478  036b 85            	popw	x
1479  036c 81            	ret
1514                     ; 229 void set_debug(u8 brightness)
1514                     ; 230 {
1515                     	switch	.text
1516  036d               _set_debug:
1520                     ; 231 	pwm_brightness_buffer[30]=brightness;
1522  036d b7d0          	ld	_pwm_brightness_buffer+30,a
1523                     ; 232 }
1526  036f 81            	ret
1551                     ; 234 void set_matrix_high_z()
1551                     ; 235 {
1552                     	switch	.text
1553  0370               _set_matrix_high_z:
1557                     ; 238 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1559  0370 4b00          	push	#0
1560  0372 4bf8          	push	#248
1561  0374 ae500a        	ldw	x,#20490
1562  0377 cd0000        	call	_GPIO_Init
1564  037a 85            	popw	x
1565                     ; 239 		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
1567  037b 4b00          	push	#0
1568  037d 4b0c          	push	#12
1569  037f ae500f        	ldw	x,#20495
1570  0382 cd0000        	call	_GPIO_Init
1572  0385 85            	popw	x
1573                     ; 240 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
1575  0386 4b00          	push	#0
1576  0388 4b08          	push	#8
1577  038a ae5000        	ldw	x,#20480
1578  038d cd0000        	call	_GPIO_Init
1580  0390 85            	popw	x
1581                     ; 244 }
1584  0391 81            	ret
1608                     ; 247 u8 get_audio_sample()
1608                     ; 248 {
1609                     	switch	.text
1610  0392               _get_audio_sample:
1614                     ; 254 	return 0;//revision 1 hw misrouted this connection, made it un-readable
1616  0392 4f            	clr	a
1619  0393 81            	ret
1622                     	switch	.const
1623  001c               L764_led_lookup:
1624  001c 00            	dc.b	0
1625  001d 01            	dc.b	1
1626  001e 00            	dc.b	0
1627  001f 02            	dc.b	2
1628  0020 01            	dc.b	1
1629  0021 02            	dc.b	2
1630  0022 01            	dc.b	1
1631  0023 00            	dc.b	0
1632  0024 02            	dc.b	2
1633  0025 00            	dc.b	0
1634  0026 02            	dc.b	2
1635  0027 01            	dc.b	1
1636  0028 05            	dc.b	5
1637  0029 00            	dc.b	0
1638  002a 05            	dc.b	5
1639  002b 01            	dc.b	1
1640  002c 05            	dc.b	5
1641  002d 02            	dc.b	2
1642  002e 06            	dc.b	6
1643  002f 00            	dc.b	0
1644  0030 06            	dc.b	6
1645  0031 01            	dc.b	1
1646  0032 06            	dc.b	6
1647  0033 02            	dc.b	2
1648  0034 06            	dc.b	6
1649  0035 05            	dc.b	5
1650  0036 06            	dc.b	6
1651  0037 04            	dc.b	4
1652  0038 05            	dc.b	5
1653  0039 04            	dc.b	4
1654  003a 04            	dc.b	4
1655  003b 03            	dc.b	3
1656  003c 05            	dc.b	5
1657  003d 03            	dc.b	3
1658  003e 06            	dc.b	6
1659  003f 03            	dc.b	3
1660  0040 03            	dc.b	3
1661  0041 04            	dc.b	4
1662  0042 03            	dc.b	3
1663  0043 05            	dc.b	5
1664  0044 03            	dc.b	3
1665  0045 06            	dc.b	6
1666  0046 00            	dc.b	0
1667  0047 05            	dc.b	5
1668  0048 00            	dc.b	0
1669  0049 06            	dc.b	6
1670  004a 01            	dc.b	1
1671  004b 06            	dc.b	6
1672  004c 00            	dc.b	0
1673  004d 04            	dc.b	4
1674  004e 01            	dc.b	1
1675  004f 04            	dc.b	4
1676  0050 02            	dc.b	2
1677  0051 04            	dc.b	4
1678  0052 00            	dc.b	0
1679  0053 03            	dc.b	3
1680  0054 01            	dc.b	1
1681  0055 03            	dc.b	3
1682  0056 02            	dc.b	2
1683  0057 03            	dc.b	3
1684  0058 07            	dc.b	7
1685  0059 07            	dc.b	7
1686  005a 03            	dc.b	3
1687  005b 00            	dc.b	0
1688  005c 03            	dc.b	3
1689  005d 01            	dc.b	1
1690  005e 03            	dc.b	3
1691  005f 02            	dc.b	2
1692  0060 04            	dc.b	4
1693  0061 00            	dc.b	0
1694  0062 01            	dc.b	1
1695  0063 05            	dc.b	5
1696  0064 02            	dc.b	2
1697  0065 05            	dc.b	5
1698  0066 04            	dc.b	4
1699  0067 01            	dc.b	1
1700  0068 04            	dc.b	4
1701  0069 02            	dc.b	2
1702  006a 02            	dc.b	2
1703  006b 06            	dc.b	6
1704  006c 04            	dc.b	4
1705  006d 06            	dc.b	6
1706  006e 04            	dc.b	4
1707  006f 05            	dc.b	5
1708  0070 05            	dc.b	5
1709  0071 06            	dc.b	6
1920                     ; 258 void set_led(u8 led_index)
1920                     ; 259 {
1921                     	switch	.text
1922  0394               _set_led:
1924  0394 88            	push	a
1925  0395 525c          	subw	sp,#92
1926       0000005c      OFST:	set	92
1929                     ; 263 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1929                     ; 264 		{0,1},{0,2},{1,2},//LED7  RGB
1929                     ; 265 		{1,0},{2,0},{2,1},//LED3  RGB
1929                     ; 266 		{5,0},{5,1},{5,2},//LED1  RGB
1929                     ; 267 		{6,0},{6,1},{6,2},//LED20 RGB
1929                     ; 268 		{6,5},{6,4},{5,4},//LED22 RGB
1929                     ; 269 		{4,3},{5,3},{6,3},//LED23 RGB
1929                     ; 270 		{3,4},{3,5},{3,6},//LED21 RGB
1929                     ; 271 		{0,5},{0,6},{1,6},//LED19 RGB
1929                     ; 272 		{0,4},{1,4},{2,4},//LED18 RGB
1929                     ; 273 		{0,3},{1,3},{2,3},//LED2  RGB
1929                     ; 274 		{7,7},//debug; GND is tied low, no charlieplexing involved
1929                     ; 275 		{3,0},//LED6
1929                     ; 276 		{3,1},//LED4
1929                     ; 277 		{3,2},//LED5
1929                     ; 278 		{4,0},//LED14
1929                     ; 279 		{1,5},//LED8
1929                     ; 280 		{2,5},//LED9
1929                     ; 281 		{4,1},//LED10
1929                     ; 282 		{4,2},//LED16
1929                     ; 283 		{2,6},//LED17
1929                     ; 284 		{4,6},//LED12
1929                     ; 285 		{4,5},//LED13
1929                     ; 286 		{5,6} //LED11
1929                     ; 287 	};
1931  0397 96            	ldw	x,sp
1932  0398 1c0006        	addw	x,#OFST-86
1933  039b 90ae001c      	ldw	y,#L764_led_lookup
1934  039f a656          	ld	a,#86
1935  03a1 cd0000        	call	c_xymov
1937                     ; 288 	bool is_high=0;
1939  03a4 0f5c          	clr	(OFST+0,sp)
1941  03a6               L536:
1942                     ; 292 		switch(led_lookup[led_index][!is_high])
1944  03a6 0d5c          	tnz	(OFST+0,sp)
1945  03a8 2605          	jrne	L47
1946  03aa ae0001        	ldw	x,#1
1947  03ad 2001          	jra	L67
1948  03af               L47:
1949  03af 5f            	clrw	x
1950  03b0               L67:
1951  03b0 9096          	ldw	y,sp
1952  03b2 72a90006      	addw	y,#OFST-86
1953  03b6 1701          	ldw	(OFST-91,sp),y
1955  03b8 7b5d          	ld	a,(OFST+1,sp)
1956  03ba 905f          	clrw	y
1957  03bc 9097          	ld	yl,a
1958  03be 9058          	sllw	y
1959  03c0 72f901        	addw	y,(OFST-91,sp)
1960  03c3 bf00          	ldw	c_y,x
1961  03c5 51            	exgw	x,y
1962  03c6 92d600        	ld	a,([c_y.w],x)
1963  03c9 51            	exgw	x,y
1965                     ; 328 			}break;
1966  03ca 4d            	tnz	a
1967  03cb 2717          	jreq	L174
1968  03cd 4a            	dec	a
1969  03ce 271f          	jreq	L374
1970  03d0 4a            	dec	a
1971  03d1 2727          	jreq	L574
1972  03d3 4a            	dec	a
1973  03d4 272f          	jreq	L774
1974  03d6 4a            	dec	a
1975  03d7 2737          	jreq	L105
1976  03d9 4a            	dec	a
1977  03da 273f          	jreq	L305
1978  03dc 4a            	dec	a
1979  03dd 2747          	jreq	L505
1980  03df 4a            	dec	a
1981  03e0 274f          	jreq	L705
1982  03e2 2056          	jra	L546
1983  03e4               L174:
1984                     ; 295 				GPIOx=GPIOD;
1986  03e4 ae500f        	ldw	x,#20495
1987  03e7 1f03          	ldw	(OFST-89,sp),x
1989                     ; 296 				PortPin=GPIO_PIN_3;
1991  03e9 a608          	ld	a,#8
1992  03eb 6b05          	ld	(OFST-87,sp),a
1994                     ; 297 			}break;
1996  03ed 204b          	jra	L546
1997  03ef               L374:
1998                     ; 299 				GPIOx=GPIOD;
2000  03ef ae500f        	ldw	x,#20495
2001  03f2 1f03          	ldw	(OFST-89,sp),x
2003                     ; 300 				PortPin=GPIO_PIN_2;
2005  03f4 a604          	ld	a,#4
2006  03f6 6b05          	ld	(OFST-87,sp),a
2008                     ; 301 			}break;
2010  03f8 2040          	jra	L546
2011  03fa               L574:
2012                     ; 303 				GPIOx=GPIOC;
2014  03fa ae500a        	ldw	x,#20490
2015  03fd 1f03          	ldw	(OFST-89,sp),x
2017                     ; 304 				PortPin=GPIO_PIN_7;
2019  03ff a680          	ld	a,#128
2020  0401 6b05          	ld	(OFST-87,sp),a
2022                     ; 305 			}break;
2024  0403 2035          	jra	L546
2025  0405               L774:
2026                     ; 307 				GPIOx=GPIOC;
2028  0405 ae500a        	ldw	x,#20490
2029  0408 1f03          	ldw	(OFST-89,sp),x
2031                     ; 308 				PortPin=GPIO_PIN_6;
2033  040a a640          	ld	a,#64
2034  040c 6b05          	ld	(OFST-87,sp),a
2036                     ; 309 			}break;
2038  040e 202a          	jra	L546
2039  0410               L105:
2040                     ; 311 				GPIOx=GPIOC;
2042  0410 ae500a        	ldw	x,#20490
2043  0413 1f03          	ldw	(OFST-89,sp),x
2045                     ; 312 				PortPin=GPIO_PIN_5;
2047  0415 a620          	ld	a,#32
2048  0417 6b05          	ld	(OFST-87,sp),a
2050                     ; 313 			}break;
2052  0419 201f          	jra	L546
2053  041b               L305:
2054                     ; 315 				GPIOx=GPIOC;
2056  041b ae500a        	ldw	x,#20490
2057  041e 1f03          	ldw	(OFST-89,sp),x
2059                     ; 316 				PortPin=GPIO_PIN_4;
2061  0420 a610          	ld	a,#16
2062  0422 6b05          	ld	(OFST-87,sp),a
2064                     ; 317 			}break;
2066  0424 2014          	jra	L546
2067  0426               L505:
2068                     ; 319 				GPIOx=GPIOC;
2070  0426 ae500a        	ldw	x,#20490
2071  0429 1f03          	ldw	(OFST-89,sp),x
2073                     ; 320 				PortPin=GPIO_PIN_3;
2075  042b a608          	ld	a,#8
2076  042d 6b05          	ld	(OFST-87,sp),a
2078                     ; 321 			}break;
2080  042f 2009          	jra	L546
2081  0431               L705:
2082                     ; 323 				GPIOx=GPIOA;
2084  0431 ae5000        	ldw	x,#20480
2085  0434 1f03          	ldw	(OFST-89,sp),x
2087                     ; 324 				PortPin=GPIO_PIN_3;
2089  0436 a608          	ld	a,#8
2090  0438 6b05          	ld	(OFST-87,sp),a
2092                     ; 325 			}break;
2094  043a               L546:
2095                     ; 330 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
2097  043a 0d5c          	tnz	(OFST+0,sp)
2098  043c 2704          	jreq	L001
2099  043e a6d0          	ld	a,#208
2100  0440 2002          	jra	L201
2101  0442               L001:
2102  0442 a6c0          	ld	a,#192
2103  0444               L201:
2104  0444 88            	push	a
2105  0445 7b06          	ld	a,(OFST-86,sp)
2106  0447 88            	push	a
2107  0448 1e05          	ldw	x,(OFST-87,sp)
2108  044a cd0000        	call	_GPIO_Init
2110  044d 85            	popw	x
2111                     ; 331 		is_high=!is_high;
2113  044e 0d5c          	tnz	(OFST+0,sp)
2114  0450 2604          	jrne	L401
2115  0452 a601          	ld	a,#1
2116  0454 2001          	jra	L601
2117  0456               L401:
2118  0456 4f            	clr	a
2119  0457               L601:
2120  0457 6b5c          	ld	(OFST+0,sp),a
2122                     ; 332 	}while(is_high);
2124  0459 0d5c          	tnz	(OFST+0,sp)
2125  045b 2703          	jreq	L011
2126  045d cc03a6        	jp	L536
2127  0460               L011:
2128                     ; 333 }
2131  0460 5b5d          	addw	sp,#93
2132  0462 81            	ret
2245                     	xdef	f_TIM2_CapComp_IRQ_Handler
2246                     	xdef	f_TIM2_UPD_OVF_IRQHandler
2247                     	xdef	_pwm_state
2248                     	xdef	_pwm_led_index
2249                     	xdef	_pwm_sleep_remaining
2250                     	switch	.ubsct
2251  0000               _pwm_led_count:
2252  0000 0000          	ds.b	2
2253                     	xdef	_pwm_led_count
2254  0002               _pwm_sleep:
2255  0002 00000000      	ds.b	4
2256                     	xdef	_pwm_sleep
2257  0006               _pwm_brightness:
2258  0006 000000000000  	ds.b	172
2259                     	xdef	_pwm_brightness
2260                     	xdef	_PWM_MAX_PERIOD
2261  00b2               _pwm_brightness_buffer:
2262  00b2 000000000000  	ds.b	43
2263                     	xdef	_pwm_brightness_buffer
2264                     	xdef	_api_counter
2265                     	xdef	_hw_revision
2266                     	xdef	_set_hue
2267                     	xdef	_get_val
2268                     	xdef	_flush_leds
2269                     	xdef	_set_led
2270                     	xdef	_get_audio_sample
2271                     	xdef	_set_debug
2272                     	xdef	_set_white
2273                     	xdef	_set_rgb
2274                     	xdef	_set_matrix_high_z
2275                     	xdef	_millis
2276                     	xdef	_setup
2277                     	xdef	_is_application_valid
2278                     	xdef	_serial_setup
2279                     	xref	_UART1_Cmd
2280                     	xref	_UART1_Init
2281                     	xref	_UART1_DeInit
2282                     	xref	_GPIO_Init
2283                     	xref.b	c_lreg
2284                     	xref.b	c_x
2285                     	xref.b	c_y
2305                     	xref	c_xymov
2306                     	xref	c_ludv
2307                     	xref	c_lmul
2308                     	xref	c_rtol
2309                     	xref	c_uitolx
2310                     	xref	c_idiv
2311                     	xref	c_lgadc
2312                     	xref	c_ltor
2313                     	end
