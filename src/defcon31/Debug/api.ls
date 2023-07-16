   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     	bsct
  15  0000               _api_counter:
  16  0000 00000000      	dc.l	0
  90                     ; 5 void serial_setup(bool is_enabled,u32 baud_rate)
  90                     ; 6 {
  92                     	switch	.text
  93  0000               _serial_setup:
  95  0000 88            	push	a
  96       00000000      OFST:	set	0
  99                     ; 7 	if(is_enabled)
 101  0001 4d            	tnz	a
 102  0002 2735          	jreq	L34
 103                     ; 9 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 105  0004 4bf0          	push	#240
 106  0006 4b20          	push	#32
 107  0008 ae500f        	ldw	x,#20495
 108  000b cd0000        	call	_GPIO_Init
 110  000e 85            	popw	x
 111                     ; 10 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 113  000f 4b40          	push	#64
 114  0011 4b40          	push	#64
 115  0013 ae500f        	ldw	x,#20495
 116  0016 cd0000        	call	_GPIO_Init
 118  0019 85            	popw	x
 119                     ; 11 		UART1_DeInit();
 121  001a cd0000        	call	_UART1_DeInit
 123                     ; 12 		UART1_Init(baud_rate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 125  001d 4b0c          	push	#12
 126  001f 4b80          	push	#128
 127  0021 4b00          	push	#0
 128  0023 4b00          	push	#0
 129  0025 4b00          	push	#0
 130  0027 1e0b          	ldw	x,(OFST+11,sp)
 131  0029 89            	pushw	x
 132  002a 1e0b          	ldw	x,(OFST+11,sp)
 133  002c 89            	pushw	x
 134  002d cd0000        	call	_UART1_Init
 136  0030 5b09          	addw	sp,#9
 137                     ; 13 		UART1_Cmd(ENABLE);
 139  0032 a601          	ld	a,#1
 140  0034 cd0000        	call	_UART1_Cmd
 143  0037 201d          	jra	L54
 144  0039               L34:
 145                     ; 15 		UART1_Cmd(DISABLE);
 147  0039 4f            	clr	a
 148  003a cd0000        	call	_UART1_Cmd
 150                     ; 16 		UART1_DeInit();
 152  003d cd0000        	call	_UART1_DeInit
 154                     ; 17 		GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 156  0040 4b40          	push	#64
 157  0042 4b20          	push	#32
 158  0044 ae500f        	ldw	x,#20495
 159  0047 cd0000        	call	_GPIO_Init
 161  004a 85            	popw	x
 162                     ; 18 		GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 164  004b 4b40          	push	#64
 165  004d 4b40          	push	#64
 166  004f ae500f        	ldw	x,#20495
 167  0052 cd0000        	call	_GPIO_Init
 169  0055 85            	popw	x
 170  0056               L54:
 171                     ; 20 }
 174  0056 84            	pop	a
 175  0057 81            	ret
 200                     ; 22 bool is_application_valid()
 200                     ; 23 {
 201                     	switch	.text
 202  0058               _is_application_valid:
 206                     ; 24 	return 0;
 208  0058 4f            	clr	a
 211  0059 81            	ret
 235                     ; 27 void setup()
 235                     ; 28 {
 236                     	switch	.text
 237  005a               _setup:
 241                     ; 29 	CLK->CKDIVR &= (u8)~(CLK_CKDIVR_HSIDIV);			// fhsi= fhsirc (HSIDIV= 0), run at 16 MHz
 243  005a c650c6        	ld	a,20678
 244  005d a4e7          	and	a,#231
 245  005f c750c6        	ld	20678,a
 246                     ; 32 	TIM2->CCR1H=0;//this will always be zero based on application architecutre
 248  0062 725f5311      	clr	21265
 249                     ; 33 	TIM2->PSCR= 5;// init divider register 16MHz/2^X
 251  0066 3505530e      	mov	21262,#5
 252                     ; 34 	TIM2->ARRH= 0;// init auto reload register
 254  006a 725f530f      	clr	21263
 255                     ; 35 	TIM2->ARRL= 250;// init auto reload register
 257  006e 35fa5310      	mov	21264,#250
 258                     ; 36 	TIM2->CR1|= TIM2_CR1_ARPE | TIM2_CR1_URS | TIM2_CR1_CEN;// enable timer
 260  0072 c65300        	ld	a,21248
 261  0075 aa85          	or	a,#133
 262  0077 c75300        	ld	21248,a
 263                     ; 37 	TIM2->IER= TIM2_IER_UIE | TIM2_IER_CC1IE;// enable TIM2 interrupt
 265  007a 35035303      	mov	21251,#3
 266                     ; 38 	enableInterrupts();
 269  007e 9a            rim
 271                     ; 39 }
 275  007f 81            	ret
 299                     ; 41 u32 millis()
 299                     ; 42 {
 300                     	switch	.text
 301  0080               _millis:
 305                     ; 43 	return api_counter/2;
 307  0080 ae0000        	ldw	x,#_api_counter
 308  0083 cd0000        	call	c_ltor
 310  0086 3400          	srl	c_lreg
 311  0088 3601          	rrc	c_lreg+1
 312  008a 3602          	rrc	c_lreg+2
 313  008c 3603          	rrc	c_lreg+3
 316  008e 81            	ret
 341                     ; 47 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void) {
 343                     	switch	.text
 344  008f               f_TIM2_UPD_OVF_IRQHandler:
 348                     ; 48 	TIM2->SR1&=~TIM2_SR1_UIF;//reset interrupt
 350  008f 72115304      	bres	21252,#0
 351                     ; 49 	api_counter++;
 353  0093 ae0000        	ldw	x,#_api_counter
 354  0096 a601          	ld	a,#1
 355  0098 cd0000        	call	c_lgadc
 357                     ; 52 }
 360  009b 80            	iret
 383                     ; 55 @far @interrupt void TIM2_CapComp_IRQ_Handler (void) {
 384                     	switch	.text
 385  009c               f_TIM2_CapComp_IRQ_Handler:
 389                     ; 56 	TIM2->SR1&=~TIM2_SR1_CC1IF;//reset interrupt
 391  009c 72135304      	bres	21252,#1
 392                     ; 59 }
 395  00a0 80            	iret
 418                     	xdef	f_TIM2_CapComp_IRQ_Handler
 419                     	xdef	f_TIM2_UPD_OVF_IRQHandler
 420                     	xdef	_millis
 421                     	xdef	_setup
 422                     	xdef	_is_application_valid
 423                     	xdef	_serial_setup
 424                     	xdef	_api_counter
 425                     	xref	_UART1_Cmd
 426                     	xref	_UART1_Init
 427                     	xref	_UART1_DeInit
 428                     	xref	_GPIO_Init
 429                     	xref.b	c_lreg
 448                     	xref	c_lgadc
 449                     	xref	c_ltor
 450                     	end
