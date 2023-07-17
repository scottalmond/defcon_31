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
  72                     ; 24 u16 get_val(u8 index)
  72                     ; 25 {
  74                     	switch	.text
  75  0000               _get_val:
  79                     ; 26 	switch(index)
  82                     ; 38 			return pwm_led_count[1];
  83  0000 4d            	tnz	a
  84  0001 270b          	jreq	L3
  85  0003 4a            	dec	a
  86  0004 270d          	jreq	L5
  87  0006 4a            	dec	a
  88  0007 270d          	jreq	L7
  89  0009 4a            	dec	a
  90  000a 270d          	jreq	L11
  91  000c               L6:
  92                     ; 42 	return 0;
  94  000c 5f            	clrw	x
  97  000d 81            	ret
  98  000e               L3:
  99                     ; 29 			return pwm_state;
 101  000e b607          	ld	a,_pwm_state
 102  0010 5f            	clrw	x
 103  0011 97            	ld	xl,a
 106  0012 81            	ret
 107  0013               L5:
 108                     ; 32 			return pwm_sleep[0];
 110  0013 be02          	ldw	x,_pwm_sleep
 113  0015 81            	ret
 114  0016               L7:
 115                     ; 35 			return pwm_sleep[1];
 117  0016 be04          	ldw	x,_pwm_sleep+2
 120  0018 81            	ret
 121  0019               L11:
 122                     ; 38 			return pwm_led_count[1];
 124  0019 b601          	ld	a,_pwm_led_count+1
 125  001b 5f            	clrw	x
 126  001c 97            	ld	xl,a
 129  001d 81            	ret
 197                     ; 45 void serial_setup(bool is_enabled,u32 baud_rate)
 197                     ; 46 {
 198                     	switch	.text
 199  001e               _serial_setup:
 201  001e 88            	push	a
 202       00000000      OFST:	set	0
 205                     ; 47 	if(is_enabled)
 207  001f 4d            	tnz	a
 208  0020 2735          	jreq	L77
 209                     ; 49 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 211  0022 4bf0          	push	#240
 212  0024 4b20          	push	#32
 213  0026 ae500f        	ldw	x,#20495
 214  0029 cd0000        	call	_GPIO_Init
 216  002c 85            	popw	x
 217                     ; 50 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 219  002d 4b40          	push	#64
 220  002f 4b40          	push	#64
 221  0031 ae500f        	ldw	x,#20495
 222  0034 cd0000        	call	_GPIO_Init
 224  0037 85            	popw	x
 225                     ; 51 		UART1_DeInit();
 227  0038 cd0000        	call	_UART1_DeInit
 229                     ; 52 		UART1_Init(baud_rate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 231  003b 4b0c          	push	#12
 232  003d 4b80          	push	#128
 233  003f 4b00          	push	#0
 234  0041 4b00          	push	#0
 235  0043 4b00          	push	#0
 236  0045 1e0b          	ldw	x,(OFST+11,sp)
 237  0047 89            	pushw	x
 238  0048 1e0b          	ldw	x,(OFST+11,sp)
 239  004a 89            	pushw	x
 240  004b cd0000        	call	_UART1_Init
 242  004e 5b09          	addw	sp,#9
 243                     ; 53 		UART1_Cmd(ENABLE);
 245  0050 a601          	ld	a,#1
 246  0052 cd0000        	call	_UART1_Cmd
 249  0055 201d          	jra	L101
 250  0057               L77:
 251                     ; 55 		UART1_Cmd(DISABLE);
 253  0057 4f            	clr	a
 254  0058 cd0000        	call	_UART1_Cmd
 256                     ; 56 		UART1_DeInit();
 258  005b cd0000        	call	_UART1_DeInit
 260                     ; 57 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 262  005e 4b40          	push	#64
 263  0060 4b20          	push	#32
 264  0062 ae500f        	ldw	x,#20495
 265  0065 cd0000        	call	_GPIO_Init
 267  0068 85            	popw	x
 268                     ; 58 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 270  0069 4b40          	push	#64
 271  006b 4b40          	push	#64
 272  006d ae500f        	ldw	x,#20495
 273  0070 cd0000        	call	_GPIO_Init
 275  0073 85            	popw	x
 276  0074               L101:
 277                     ; 60 }
 280  0074 84            	pop	a
 281  0075 81            	ret
 306                     ; 62 bool is_application_valid()
 306                     ; 63 {
 307                     	switch	.text
 308  0076               _is_application_valid:
 312                     ; 64 	return 0;
 314  0076 4f            	clr	a
 317  0077 81            	ret
 342                     ; 67 void setup()
 342                     ; 68 {
 343                     	switch	.text
 344  0078               _setup:
 348                     ; 69 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 350  0078 c650c6        	ld	a,20678
 351  007b a4e7          	and	a,#231
 352  007d c750c6        	ld	20678,a
 353                     ; 72 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 355  0080 725f5311      	clr	21265
 356                     ; 73 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 358  0084 3505530e      	mov	21262,#5
 359                     ; 74 	TIM2->ARRH= 0;// init auto reload register
 361  0088 725f530f      	clr	21263
 362                     ; 75 	TIM2->ARRL= PWM_MAX_PERIOD;// init auto reload register
 364  008c 35fa5310      	mov	21264,#250
 365                     ; 76 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 367  0090 c65300        	ld	a,21248
 368  0093 aa85          	or	a,#133
 369  0095 c75300        	ld	21248,a
 370                     ; 77 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 372  0098 35035303      	mov	21251,#3
 373                     ; 78 	enableInterrupts();
 376  009c 9a            rim
 378                     ; 82 }
 382  009d 81            	ret
 406                     ; 84 u32 millis()
 406                     ; 85 {
 407                     	switch	.text
 408  009e               _millis:
 412                     ; 86 	return api_counter/2;
 414  009e ae0000        	ldw	x,#_api_counter
 415  00a1 cd0000        	call	c_ltor
 417  00a4 3400          	srl	c_lreg
 418  00a6 3601          	rrc	c_lreg+1
 419  00a8 3602          	rrc	c_lreg+2
 420  00aa 3603          	rrc	c_lreg+3
 423  00ac 81            	ret
 448                     ; 90 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
 450                     	switch	.text
 451  00ad               f_TIM2_UPD_OVF_IRQHandler:
 455                     ; 91 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
 457  00ad 72115304      	bres	21252,#0
 458                     ; 92 	api_counter++;
 460  00b1 ae0000        	ldw	x,#_api_counter
 461  00b4 a601          	ld	a,#1
 462  00b6 cd0000        	call	c_lgadc
 464                     ; 95 }
 467  00b9 80            	iret
 520                     ; 98 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
 521                     	switch	.text
 522  00ba               f_TIM2_CapComp_IRQ_Handler:
 524  00ba 8a            	push	cc
 525  00bb 84            	pop	a
 526  00bc a4bf          	and	a,#191
 527  00be 88            	push	a
 528  00bf 86            	pop	cc
 529       00000004      OFST:	set	4
 530  00c0 3b0002        	push	c_x+2
 531  00c3 be00          	ldw	x,c_x
 532  00c5 89            	pushw	x
 533  00c6 3b0002        	push	c_y+2
 534  00c9 be00          	ldw	x,c_y
 535  00cb 89            	pushw	x
 536  00cc 5204          	subw	sp,#4
 539                     ; 100 	u8 sleep_amount=PWM_MAX_PERIOD;//max sleep duration before wrap-over occurs
 541  00ce a6fa          	ld	a,#250
 542  00d0 6b04          	ld	(OFST+0,sp),a
 544                     ; 101 	bool buffer_index=pwm_state&0x01;//primary vs rendant side to pull data from
 546  00d2 b607          	ld	a,_pwm_state
 547  00d4 a401          	and	a,#1
 548  00d6 6b03          	ld	(OFST-1,sp),a
 550                     ; 103 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
 552  00d8 72135304      	bres	21252,#1
 553                     ; 105 	if(pwm_sleep_remaining==0)
 555  00dc be04          	ldw	x,_pwm_sleep_remaining
 556  00de 264d          	jrne	L561
 557                     ; 107 		set_matrix_high_z();
 559  00e0 cd023a        	call	_set_matrix_high_z
 561                     ; 108 		if(pwm_led_index<pwm_led_count[buffer_index])
 563  00e3 7b03          	ld	a,(OFST-1,sp)
 564  00e5 5f            	clrw	x
 565  00e6 97            	ld	xl,a
 566  00e7 e600          	ld	a,(_pwm_led_count,x)
 567  00e9 b106          	cp	a,_pwm_led_index
 568  00eb 2329          	jrule	L761
 569                     ; 110 			set_led(pwm_brightness[pwm_led_index][0][buffer_index]);//turn on the next LED
 571  00ed b606          	ld	a,_pwm_led_index
 572  00ef 97            	ld	xl,a
 573  00f0 a604          	ld	a,#4
 574  00f2 42            	mul	x,a
 575  00f3 01            	rrwa	x,a
 576  00f4 1b03          	add	a,(OFST-1,sp)
 577  00f6 2401          	jrnc	L42
 578  00f8 5c            	incw	x
 579  00f9               L42:
 580  00f9 02            	rlwa	x,a
 581  00fa e606          	ld	a,(_pwm_brightness,x)
 582  00fc cd025e        	call	_set_led
 584                     ; 111 			pwm_sleep_remaining=pwm_brightness[pwm_led_index][1][buffer_index];//set how long to sleep in this state
 586  00ff b606          	ld	a,_pwm_led_index
 587  0101 97            	ld	xl,a
 588  0102 a604          	ld	a,#4
 589  0104 42            	mul	x,a
 590  0105 01            	rrwa	x,a
 591  0106 1b03          	add	a,(OFST-1,sp)
 592  0108 2401          	jrnc	L62
 593  010a 5c            	incw	x
 594  010b               L62:
 595  010b 02            	rlwa	x,a
 596  010c e608          	ld	a,(_pwm_brightness+2,x)
 597  010e 5f            	clrw	x
 598  010f 97            	ld	xl,a
 599  0110 bf04          	ldw	_pwm_sleep_remaining,x
 600                     ; 112 			pwm_led_index++;//prepare state machine to go to the next led later
 602  0112 3c06          	inc	_pwm_led_index
 604  0114 2017          	jra	L561
 605  0116               L761:
 606                     ; 114 			pwm_led_index=0;//reset state machine to 0
 608  0116 3f06          	clr	_pwm_led_index
 609                     ; 115 			pwm_sleep_remaining=pwm_sleep[buffer_index];
 611  0118 7b03          	ld	a,(OFST-1,sp)
 612  011a 5f            	clrw	x
 613  011b 97            	ld	xl,a
 614  011c 58            	sllw	x
 615  011d ee02          	ldw	x,(_pwm_sleep,x)
 616  011f bf04          	ldw	_pwm_sleep_remaining,x
 617                     ; 116 			if(pwm_state&0x02) pwm_state^=0x03;//if flag to swap A/B is set, then clear the flag and swap sides
 619  0121 b607          	ld	a,_pwm_state
 620  0123 a502          	bcp	a,#2
 621  0125 2706          	jreq	L561
 624  0127 b607          	ld	a,_pwm_state
 625  0129 a803          	xor	a,#3
 626  012b b707          	ld	_pwm_state,a
 627  012d               L561:
 628                     ; 119 	sleep_amount=pwm_sleep_remaining<sleep_amount?pwm_sleep_remaining:sleep_amount;
 630  012d 7b04          	ld	a,(OFST+0,sp)
 631  012f 5f            	clrw	x
 632  0130 97            	ld	xl,a
 633  0131 bf00          	ldw	c_x,x
 634  0133 be04          	ldw	x,_pwm_sleep_remaining
 635  0135 b300          	cpw	x,c_x
 636  0137 2404          	jruge	L03
 637  0139 b605          	ld	a,_pwm_sleep_remaining+1
 638  013b 2002          	jra	L23
 639  013d               L03:
 640  013d 7b04          	ld	a,(OFST+0,sp)
 641  013f               L23:
 642  013f 6b04          	ld	(OFST+0,sp),a
 644                     ; 120 	pwm_sleep_remaining-=sleep_amount;
 646  0141 7b04          	ld	a,(OFST+0,sp)
 647  0143 5f            	clrw	x
 648  0144 97            	ld	xl,a
 649  0145 1f01          	ldw	(OFST-3,sp),x
 651  0147 be04          	ldw	x,_pwm_sleep_remaining
 652  0149 72f001        	subw	x,(OFST-3,sp)
 653  014c bf04          	ldw	_pwm_sleep_remaining,x
 654                     ; 122 	TIM2->CCR1L = ( (TIM2->CCR1L) + sleep_amount )%PWM_MAX_PERIOD;//set wakeup alarm relative to current time
 656  014e c65312        	ld	a,21266
 657  0151 5f            	clrw	x
 658  0152 1b04          	add	a,(OFST+0,sp)
 659  0154 2401          	jrnc	L43
 660  0156 5c            	incw	x
 661  0157               L43:
 662  0157 02            	rlwa	x,a
 663  0158 90ae00fa      	ldw	y,#250
 664  015c cd0000        	call	c_idiv
 666  015f 51            	exgw	x,y
 667  0160 01            	rrwa	x,a
 668  0161 c75312        	ld	21266,a
 669  0164 02            	rlwa	x,a
 670                     ; 123 }
 673  0165 5b04          	addw	sp,#4
 674  0167 85            	popw	x
 675  0168 bf00          	ldw	c_y,x
 676  016a 320002        	pop	c_y+2
 677  016d 85            	popw	x
 678  016e bf00          	ldw	c_x,x
 679  0170 320002        	pop	c_x+2
 680  0173 80            	iret
 747                     ; 125 void flush_leds(u8 led_count)
 747                     ; 126 {
 749                     	switch	.text
 750  0174               _flush_leds:
 752  0174 88            	push	a
 753  0175 5203          	subw	sp,#3
 754       00000003      OFST:	set	3
 757                     ; 127 	u8 led_read_index=0,led_write_index=0;
 761  0177 0f02          	clr	(OFST-1,sp)
 763                     ; 128 	bool buffer_index=!(pwm_state&0x01);//write to the buffer index that is NOT being used/volatile
 765  0179 b607          	ld	a,_pwm_state
 766  017b a501          	bcp	a,#1
 767  017d 2605          	jrne	L04
 768  017f ae0001        	ldw	x,#1
 769  0182 2001          	jra	L24
 770  0184               L04:
 771  0184 5f            	clrw	x
 772  0185               L24:
 773  0185 01            	rrwa	x,a
 774  0186 6b01          	ld	(OFST-2,sp),a
 775  0188 02            	rlwa	x,a
 778  0189               L332:
 779                     ; 129 	while(pwm_state&0x02){}//wait for volatile flag to clear (if still raised from the previous call)
 781  0189 b607          	ld	a,_pwm_state
 782  018b a502          	bcp	a,#2
 783  018d 26fa          	jrne	L332
 784                     ; 130 	pwm_sleep[buffer_index]=led_count*256;//prepare the max value of sleep, and subtract from it for each LED illuminated
 786  018f 7b04          	ld	a,(OFST+1,sp)
 787  0191 5f            	clrw	x
 788  0192 97            	ld	xl,a
 789  0193 4f            	clr	a
 790  0194 02            	rlwa	x,a
 791  0195 7b01          	ld	a,(OFST-2,sp)
 792  0197 905f          	clrw	y
 793  0199 9097          	ld	yl,a
 794  019b 9058          	sllw	y
 795  019d 90ef02        	ldw	(_pwm_sleep,y),x
 796                     ; 132 	for(led_read_index=0;led_read_index<PWM_MAX_PERIOD && led_write_index<led_count;led_read_index++)
 798  01a0 0f03          	clr	(OFST+0,sp)
 801  01a2 205b          	jra	L342
 802  01a4               L732:
 803                     ; 134 		if(pwm_brightness_buffer[led_read_index]>0)
 805  01a4 7b03          	ld	a,(OFST+0,sp)
 806  01a6 5f            	clrw	x
 807  01a7 97            	ld	xl,a
 808  01a8 6db2          	tnz	(_pwm_brightness_buffer,x)
 809  01aa 274b          	jreq	L742
 810                     ; 136 			pwm_brightness[led_write_index][0][buffer_index]=led_read_index;
 812  01ac 7b02          	ld	a,(OFST-1,sp)
 813  01ae 97            	ld	xl,a
 814  01af a604          	ld	a,#4
 815  01b1 42            	mul	x,a
 816  01b2 01            	rrwa	x,a
 817  01b3 1b01          	add	a,(OFST-2,sp)
 818  01b5 2401          	jrnc	L44
 819  01b7 5c            	incw	x
 820  01b8               L44:
 821  01b8 02            	rlwa	x,a
 822  01b9 7b03          	ld	a,(OFST+0,sp)
 823  01bb e706          	ld	(_pwm_brightness,x),a
 824                     ; 137 			pwm_brightness[led_write_index][1][buffer_index]=pwm_brightness_buffer[led_read_index];
 826  01bd 7b02          	ld	a,(OFST-1,sp)
 827  01bf 97            	ld	xl,a
 828  01c0 a604          	ld	a,#4
 829  01c2 42            	mul	x,a
 830  01c3 01            	rrwa	x,a
 831  01c4 1b01          	add	a,(OFST-2,sp)
 832  01c6 2401          	jrnc	L64
 833  01c8 5c            	incw	x
 834  01c9               L64:
 835  01c9 02            	rlwa	x,a
 836  01ca 7b03          	ld	a,(OFST+0,sp)
 837  01cc 905f          	clrw	y
 838  01ce 9097          	ld	yl,a
 839  01d0 90e6b2        	ld	a,(_pwm_brightness_buffer,y)
 840  01d3 e708          	ld	(_pwm_brightness+2,x),a
 841                     ; 138 			led_write_index++;
 843  01d5 0c02          	inc	(OFST-1,sp)
 845                     ; 139 			pwm_sleep[buffer_index]-=pwm_brightness_buffer[led_read_index];
 847  01d7 7b01          	ld	a,(OFST-2,sp)
 848  01d9 5f            	clrw	x
 849  01da 97            	ld	xl,a
 850  01db 58            	sllw	x
 851  01dc 7b03          	ld	a,(OFST+0,sp)
 852  01de 905f          	clrw	y
 853  01e0 9097          	ld	yl,a
 854  01e2 90e6b2        	ld	a,(_pwm_brightness_buffer,y)
 855  01e5 905f          	clrw	y
 856  01e7 9097          	ld	yl,a
 857  01e9 9001          	rrwa	y,a
 858  01eb e003          	sub	a,(_pwm_sleep+1,x)
 859  01ed 9001          	rrwa	y,a
 860  01ef e202          	sbc	a,(_pwm_sleep,x)
 861  01f1 9001          	rrwa	y,a
 862  01f3 9050          	negw	y
 863  01f5 ef02          	ldw	(_pwm_sleep,x),y
 864  01f7               L742:
 865                     ; 141 		pwm_brightness_buffer[led_read_index]=0;//clean up for next use
 867  01f7 7b03          	ld	a,(OFST+0,sp)
 868  01f9 5f            	clrw	x
 869  01fa 97            	ld	xl,a
 870  01fb 6fb2          	clr	(_pwm_brightness_buffer,x)
 871                     ; 132 	for(led_read_index=0;led_read_index<PWM_MAX_PERIOD && led_write_index<led_count;led_read_index++)
 873  01fd 0c03          	inc	(OFST+0,sp)
 875  01ff               L342:
 878  01ff 7b03          	ld	a,(OFST+0,sp)
 879  0201 a1fa          	cp	a,#250
 880  0203 2406          	jruge	L152
 882  0205 7b02          	ld	a,(OFST-1,sp)
 883  0207 1104          	cp	a,(OFST+1,sp)
 884  0209 2599          	jrult	L732
 885  020b               L152:
 886                     ; 143 	pwm_led_count[buffer_index]=led_write_index;//save the led count for the volatile pwm rutine state machine.
 888  020b 7b01          	ld	a,(OFST-2,sp)
 889  020d 5f            	clrw	x
 890  020e 97            	ld	xl,a
 891  020f 7b02          	ld	a,(OFST-1,sp)
 892  0211 e700          	ld	(_pwm_led_count,x),a
 893                     ; 146 	pwm_state|=0x02;//raise flag that data is ready for volatile pwm process to pick up and use
 895  0213 72120007      	bset	_pwm_state,#1
 896                     ; 147 }
 899  0217 5b04          	addw	sp,#4
 900  0219 81            	ret
 953                     ; 149 void set_rgb(u8 index,u8 color,u8 brightness)
 953                     ; 150 {
 954                     	switch	.text
 955  021a               _set_rgb:
 957  021a 89            	pushw	x
 958       00000000      OFST:	set	0
 961                     ; 151 	pwm_brightness_buffer[index*3+color]=brightness;
 963  021b 9e            	ld	a,xh
 964  021c 97            	ld	xl,a
 965  021d a603          	ld	a,#3
 966  021f 42            	mul	x,a
 967  0220 01            	rrwa	x,a
 968  0221 1b02          	add	a,(OFST+2,sp)
 969  0223 2401          	jrnc	L25
 970  0225 5c            	incw	x
 971  0226               L25:
 972  0226 02            	rlwa	x,a
 973  0227 7b05          	ld	a,(OFST+5,sp)
 974  0229 e7b2          	ld	(_pwm_brightness_buffer,x),a
 975                     ; 152 }
 978  022b 85            	popw	x
 979  022c 81            	ret
1023                     ; 154 void set_white(u8 index,u8 brightness)
1023                     ; 155 {
1024                     	switch	.text
1025  022d               _set_white:
1027  022d 89            	pushw	x
1028       00000000      OFST:	set	0
1031                     ; 156 	pwm_brightness_buffer[31+index]=brightness;
1033  022e 9e            	ld	a,xh
1034  022f 5f            	clrw	x
1035  0230 97            	ld	xl,a
1036  0231 7b02          	ld	a,(OFST+2,sp)
1037  0233 e7d1          	ld	(_pwm_brightness_buffer+31,x),a
1038                     ; 157 }
1041  0235 85            	popw	x
1042  0236 81            	ret
1077                     ; 159 void set_debug(u8 brightness)
1077                     ; 160 {
1078                     	switch	.text
1079  0237               _set_debug:
1083                     ; 161 	pwm_brightness_buffer[30]=brightness;
1085  0237 b7d0          	ld	_pwm_brightness_buffer+30,a
1086                     ; 162 }
1089  0239 81            	ret
1114                     ; 164 void set_matrix_high_z()
1114                     ; 165 {
1115                     	switch	.text
1116  023a               _set_matrix_high_z:
1120                     ; 168 		GPIO_Init(GPIOC, GPIO_PIN_7 | GPIO_PIN_6 | GPIO_PIN_5 | GPIO_PIN_4 | GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);//2, 3, 4, 5, 6
1122  023a 4b00          	push	#0
1123  023c 4bf8          	push	#248
1124  023e ae500a        	ldw	x,#20490
1125  0241 cd0000        	call	_GPIO_Init
1127  0244 85            	popw	x
1128                     ; 169 		GPIO_Init(GPIOD, GPIO_PIN_3 | GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
1130  0245 4b00          	push	#0
1131  0247 4b0c          	push	#12
1132  0249 ae500f        	ldw	x,#20495
1133  024c cd0000        	call	_GPIO_Init
1135  024f 85            	popw	x
1136                     ; 170 		GPIO_Init(GPIOA, GPIO_PIN_3 , GPIO_MODE_IN_FL_NO_IT);
1138  0250 4b00          	push	#0
1139  0252 4b08          	push	#8
1140  0254 ae5000        	ldw	x,#20480
1141  0257 cd0000        	call	_GPIO_Init
1143  025a 85            	popw	x
1144                     ; 174 }
1147  025b 81            	ret
1171                     ; 177 u8 get_audio_sample()
1171                     ; 178 {
1172                     	switch	.text
1173  025c               _get_audio_sample:
1177                     ; 184 	return 0;//revision 1 hw misrouted this connection, made it un-readable
1179  025c 4f            	clr	a
1182  025d 81            	ret
1185                     	switch	.const
1186  0002               L163_led_lookup:
1187  0002 00            	dc.b	0
1188  0003 01            	dc.b	1
1189  0004 00            	dc.b	0
1190  0005 02            	dc.b	2
1191  0006 01            	dc.b	1
1192  0007 02            	dc.b	2
1193  0008 01            	dc.b	1
1194  0009 00            	dc.b	0
1195  000a 02            	dc.b	2
1196  000b 00            	dc.b	0
1197  000c 02            	dc.b	2
1198  000d 01            	dc.b	1
1199  000e 05            	dc.b	5
1200  000f 00            	dc.b	0
1201  0010 05            	dc.b	5
1202  0011 01            	dc.b	1
1203  0012 05            	dc.b	5
1204  0013 02            	dc.b	2
1205  0014 06            	dc.b	6
1206  0015 00            	dc.b	0
1207  0016 06            	dc.b	6
1208  0017 01            	dc.b	1
1209  0018 06            	dc.b	6
1210  0019 02            	dc.b	2
1211  001a 06            	dc.b	6
1212  001b 05            	dc.b	5
1213  001c 06            	dc.b	6
1214  001d 04            	dc.b	4
1215  001e 05            	dc.b	5
1216  001f 04            	dc.b	4
1217  0020 04            	dc.b	4
1218  0021 03            	dc.b	3
1219  0022 05            	dc.b	5
1220  0023 03            	dc.b	3
1221  0024 06            	dc.b	6
1222  0025 03            	dc.b	3
1223  0026 03            	dc.b	3
1224  0027 04            	dc.b	4
1225  0028 03            	dc.b	3
1226  0029 05            	dc.b	5
1227  002a 03            	dc.b	3
1228  002b 06            	dc.b	6
1229  002c 00            	dc.b	0
1230  002d 05            	dc.b	5
1231  002e 00            	dc.b	0
1232  002f 06            	dc.b	6
1233  0030 01            	dc.b	1
1234  0031 06            	dc.b	6
1235  0032 00            	dc.b	0
1236  0033 04            	dc.b	4
1237  0034 01            	dc.b	1
1238  0035 04            	dc.b	4
1239  0036 02            	dc.b	2
1240  0037 04            	dc.b	4
1241  0038 00            	dc.b	0
1242  0039 03            	dc.b	3
1243  003a 01            	dc.b	1
1244  003b 03            	dc.b	3
1245  003c 02            	dc.b	2
1246  003d 03            	dc.b	3
1247  003e 07            	dc.b	7
1248  003f 07            	dc.b	7
1249  0040 03            	dc.b	3
1250  0041 00            	dc.b	0
1251  0042 03            	dc.b	3
1252  0043 01            	dc.b	1
1253  0044 03            	dc.b	3
1254  0045 02            	dc.b	2
1255  0046 04            	dc.b	4
1256  0047 00            	dc.b	0
1257  0048 01            	dc.b	1
1258  0049 05            	dc.b	5
1259  004a 02            	dc.b	2
1260  004b 05            	dc.b	5
1261  004c 04            	dc.b	4
1262  004d 01            	dc.b	1
1263  004e 04            	dc.b	4
1264  004f 02            	dc.b	2
1265  0050 02            	dc.b	2
1266  0051 06            	dc.b	6
1267  0052 04            	dc.b	4
1268  0053 06            	dc.b	6
1269  0054 04            	dc.b	4
1270  0055 05            	dc.b	5
1271  0056 05            	dc.b	5
1272  0057 06            	dc.b	6
1483                     ; 188 void set_led(u8 led_index)
1483                     ; 189 {
1484                     	switch	.text
1485  025e               _set_led:
1487  025e 88            	push	a
1488  025f 525c          	subw	sp,#92
1489       0000005c      OFST:	set	92
1492                     ; 193 	const u8 led_lookup[LED_COUNT][2]={//[0] is HIGH mat, [1] is LOW mat
1492                     ; 194 		{0,1},{0,2},{1,2},//LED7  RGB
1492                     ; 195 		{1,0},{2,0},{2,1},//LED3  RGB
1492                     ; 196 		{5,0},{5,1},{5,2},//LED1  RGB
1492                     ; 197 		{6,0},{6,1},{6,2},//LED20 RGB
1492                     ; 198 		{6,5},{6,4},{5,4},//LED22 RGB
1492                     ; 199 		{4,3},{5,3},{6,3},//LED23 RGB
1492                     ; 200 		{3,4},{3,5},{3,6},//LED21 RGB
1492                     ; 201 		{0,5},{0,6},{1,6},//LED19 RGB
1492                     ; 202 		{0,4},{1,4},{2,4},//LED18 RGB
1492                     ; 203 		{0,3},{1,3},{2,3},//LED2  RGB
1492                     ; 204 		{7,7},//debug; GND is tied low, no charlieplexing involved
1492                     ; 205 		{3,0},//LED6
1492                     ; 206 		{3,1},//LED4
1492                     ; 207 		{3,2},//LED5
1492                     ; 208 		{4,0},//LED14
1492                     ; 209 		{1,5},//LED8
1492                     ; 210 		{2,5},//LED9
1492                     ; 211 		{4,1},//LED10
1492                     ; 212 		{4,2},//LED16
1492                     ; 213 		{2,6},//LED17
1492                     ; 214 		{4,6},//LED12
1492                     ; 215 		{4,5},//LED13
1492                     ; 216 		{5,6} //LED11
1492                     ; 217 	};
1494  0261 96            	ldw	x,sp
1495  0262 1c0006        	addw	x,#OFST-86
1496  0265 90ae0002      	ldw	y,#L163_led_lookup
1497  0269 a656          	ld	a,#86
1498  026b cd0000        	call	c_xymov
1500                     ; 218 	bool is_high=0;
1502  026e 0f5c          	clr	(OFST+0,sp)
1504  0270               L725:
1505                     ; 222 		switch(led_lookup[led_index][!is_high])
1507  0270 0d5c          	tnz	(OFST+0,sp)
1508  0272 2605          	jrne	L66
1509  0274 ae0001        	ldw	x,#1
1510  0277 2001          	jra	L07
1511  0279               L66:
1512  0279 5f            	clrw	x
1513  027a               L07:
1514  027a 9096          	ldw	y,sp
1515  027c 72a90006      	addw	y,#OFST-86
1516  0280 1701          	ldw	(OFST-91,sp),y
1518  0282 7b5d          	ld	a,(OFST+1,sp)
1519  0284 905f          	clrw	y
1520  0286 9097          	ld	yl,a
1521  0288 9058          	sllw	y
1522  028a 72f901        	addw	y,(OFST-91,sp)
1523  028d bf00          	ldw	c_y,x
1524  028f 51            	exgw	x,y
1525  0290 92d600        	ld	a,([c_y.w],x)
1526  0293 51            	exgw	x,y
1528                     ; 258 			}break;
1529  0294 4d            	tnz	a
1530  0295 2717          	jreq	L363
1531  0297 4a            	dec	a
1532  0298 271f          	jreq	L563
1533  029a 4a            	dec	a
1534  029b 2727          	jreq	L763
1535  029d 4a            	dec	a
1536  029e 272f          	jreq	L173
1537  02a0 4a            	dec	a
1538  02a1 2737          	jreq	L373
1539  02a3 4a            	dec	a
1540  02a4 273f          	jreq	L573
1541  02a6 4a            	dec	a
1542  02a7 2747          	jreq	L773
1543  02a9 4a            	dec	a
1544  02aa 274f          	jreq	L104
1545  02ac 2056          	jra	L735
1546  02ae               L363:
1547                     ; 225 				GPIOx=GPIOD;
1549  02ae ae500f        	ldw	x,#20495
1550  02b1 1f03          	ldw	(OFST-89,sp),x
1552                     ; 226 				PortPin=GPIO_PIN_3;
1554  02b3 a608          	ld	a,#8
1555  02b5 6b05          	ld	(OFST-87,sp),a
1557                     ; 227 			}break;
1559  02b7 204b          	jra	L735
1560  02b9               L563:
1561                     ; 229 				GPIOx=GPIOD;
1563  02b9 ae500f        	ldw	x,#20495
1564  02bc 1f03          	ldw	(OFST-89,sp),x
1566                     ; 230 				PortPin=GPIO_PIN_2;
1568  02be a604          	ld	a,#4
1569  02c0 6b05          	ld	(OFST-87,sp),a
1571                     ; 231 			}break;
1573  02c2 2040          	jra	L735
1574  02c4               L763:
1575                     ; 233 				GPIOx=GPIOC;
1577  02c4 ae500a        	ldw	x,#20490
1578  02c7 1f03          	ldw	(OFST-89,sp),x
1580                     ; 234 				PortPin=GPIO_PIN_7;
1582  02c9 a680          	ld	a,#128
1583  02cb 6b05          	ld	(OFST-87,sp),a
1585                     ; 235 			}break;
1587  02cd 2035          	jra	L735
1588  02cf               L173:
1589                     ; 237 				GPIOx=GPIOC;
1591  02cf ae500a        	ldw	x,#20490
1592  02d2 1f03          	ldw	(OFST-89,sp),x
1594                     ; 238 				PortPin=GPIO_PIN_6;
1596  02d4 a640          	ld	a,#64
1597  02d6 6b05          	ld	(OFST-87,sp),a
1599                     ; 239 			}break;
1601  02d8 202a          	jra	L735
1602  02da               L373:
1603                     ; 241 				GPIOx=GPIOC;
1605  02da ae500a        	ldw	x,#20490
1606  02dd 1f03          	ldw	(OFST-89,sp),x
1608                     ; 242 				PortPin=GPIO_PIN_5;
1610  02df a620          	ld	a,#32
1611  02e1 6b05          	ld	(OFST-87,sp),a
1613                     ; 243 			}break;
1615  02e3 201f          	jra	L735
1616  02e5               L573:
1617                     ; 245 				GPIOx=GPIOC;
1619  02e5 ae500a        	ldw	x,#20490
1620  02e8 1f03          	ldw	(OFST-89,sp),x
1622                     ; 246 				PortPin=GPIO_PIN_4;
1624  02ea a610          	ld	a,#16
1625  02ec 6b05          	ld	(OFST-87,sp),a
1627                     ; 247 			}break;
1629  02ee 2014          	jra	L735
1630  02f0               L773:
1631                     ; 249 				GPIOx=GPIOC;
1633  02f0 ae500a        	ldw	x,#20490
1634  02f3 1f03          	ldw	(OFST-89,sp),x
1636                     ; 250 				PortPin=GPIO_PIN_3;
1638  02f5 a608          	ld	a,#8
1639  02f7 6b05          	ld	(OFST-87,sp),a
1641                     ; 251 			}break;
1643  02f9 2009          	jra	L735
1644  02fb               L104:
1645                     ; 253 				GPIOx=GPIOA;
1647  02fb ae5000        	ldw	x,#20480
1648  02fe 1f03          	ldw	(OFST-89,sp),x
1650                     ; 254 				PortPin=GPIO_PIN_3;
1652  0300 a608          	ld	a,#8
1653  0302 6b05          	ld	(OFST-87,sp),a
1655                     ; 255 			}break;
1657  0304               L735:
1658                     ; 260 		GPIO_Init(GPIOx, PortPin, is_high?GPIO_MODE_OUT_PP_HIGH_SLOW:GPIO_MODE_OUT_PP_LOW_SLOW);
1660  0304 0d5c          	tnz	(OFST+0,sp)
1661  0306 2704          	jreq	L27
1662  0308 a6d0          	ld	a,#208
1663  030a 2002          	jra	L47
1664  030c               L27:
1665  030c a6c0          	ld	a,#192
1666  030e               L47:
1667  030e 88            	push	a
1668  030f 7b06          	ld	a,(OFST-86,sp)
1669  0311 88            	push	a
1670  0312 1e05          	ldw	x,(OFST-87,sp)
1671  0314 cd0000        	call	_GPIO_Init
1673  0317 85            	popw	x
1674                     ; 261 		is_high=!is_high;
1676  0318 0d5c          	tnz	(OFST+0,sp)
1677  031a 2604          	jrne	L67
1678  031c a601          	ld	a,#1
1679  031e 2001          	jra	L001
1680  0320               L67:
1681  0320 4f            	clr	a
1682  0321               L001:
1683  0321 6b5c          	ld	(OFST+0,sp),a
1685                     ; 262 	}while(is_high);
1687  0323 0d5c          	tnz	(OFST+0,sp)
1688  0325 2703          	jreq	L201
1689  0327 cc0270        	jp	L725
1690  032a               L201:
1691                     ; 263 }
1694  032a 5b5d          	addw	sp,#93
1695  032c 81            	ret
1808                     	xdef	f_TIM2_CapComp_IRQ_Handler
1809                     	xdef	f_TIM2_UPD_OVF_IRQHandler
1810                     	xdef	_pwm_state
1811                     	xdef	_pwm_led_index
1812                     	xdef	_pwm_sleep_remaining
1813                     	switch	.ubsct
1814  0000               _pwm_led_count:
1815  0000 0000          	ds.b	2
1816                     	xdef	_pwm_led_count
1817  0002               _pwm_sleep:
1818  0002 00000000      	ds.b	4
1819                     	xdef	_pwm_sleep
1820  0006               _pwm_brightness:
1821  0006 000000000000  	ds.b	172
1822                     	xdef	_pwm_brightness
1823                     	xdef	_PWM_MAX_PERIOD
1824  00b2               _pwm_brightness_buffer:
1825  00b2 000000000000  	ds.b	43
1826                     	xdef	_pwm_brightness_buffer
1827                     	xdef	_api_counter
1828                     	xdef	_hw_revision
1829                     	xdef	_get_val
1830                     	xdef	_flush_leds
1831                     	xdef	_set_led
1832                     	xdef	_get_audio_sample
1833                     	xdef	_set_debug
1834                     	xdef	_set_white
1835                     	xdef	_set_rgb
1836                     	xdef	_set_matrix_high_z
1837                     	xdef	_millis
1838                     	xdef	_setup
1839                     	xdef	_is_application_valid
1840                     	xdef	_serial_setup
1841                     	xref	_UART1_Cmd
1842                     	xref	_UART1_Init
1843                     	xref	_UART1_DeInit
1844                     	xref	_GPIO_Init
1845                     	xref.b	c_lreg
1846                     	xref.b	c_x
1847                     	xref.b	c_y
1867                     	xref	c_xymov
1868                     	xref	c_idiv
1869                     	xref	c_lgadc
1870                     	xref	c_ltor
1871                     	end
