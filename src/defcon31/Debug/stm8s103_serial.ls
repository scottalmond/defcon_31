   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  77                     ; 6  char Serial_read_char(bool is_blocking)
  77                     ; 7  {
  79                     	switch	.text
  80  0000               _Serial_read_char:
  82  0000 88            	push	a
  83       00000000      OFST:	set	0
  86  0001               L14:
  87                     ; 8 	 while (is_blocking && UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
  89  0001 0d01          	tnz	(OFST+1,sp)
  90  0003 2709          	jreq	L54
  92  0005 ae0080        	ldw	x,#128
  93  0008 cd0000        	call	_UART1_GetFlagStatus
  95  000b 4d            	tnz	a
  96  000c 27f3          	jreq	L14
  97  000e               L54:
  98                     ; 9 	 UART1_ClearFlag(UART1_FLAG_RXNE);
 100  000e ae0020        	ldw	x,#32
 101  0011 cd0000        	call	_UART1_ClearFlag
 103                     ; 10 	 return (UART1_ReceiveData8());
 105  0014 cd0000        	call	_UART1_ReceiveData8
 109  0017 5b01          	addw	sp,#1
 110  0019 81            	ret
 146                     ; 19  void Serial_print_char (char value)
 146                     ; 20  {
 147                     	switch	.text
 148  001a               _Serial_print_char:
 152                     ; 21 	 UART1_SendData8(value);
 154  001a cd0000        	call	_UART1_SendData8
 157  001d               L76:
 158                     ; 22 	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
 160  001d ae0080        	ldw	x,#128
 161  0020 cd0000        	call	_UART1_GetFlagStatus
 163  0023 4d            	tnz	a
 164  0024 27f7          	jreq	L76
 165                     ; 23  }
 168  0026 81            	ret
 206                     ; 25   void Serial_begin(uint32_t baud_rate)
 206                     ; 26  {
 207                     	switch	.text
 208  0027               _Serial_begin:
 210       00000000      OFST:	set	0
 213                     ; 27 	 GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
 215  0027 4bf0          	push	#240
 216  0029 4b20          	push	#32
 217  002b ae500f        	ldw	x,#20495
 218  002e cd0000        	call	_GPIO_Init
 220  0031 85            	popw	x
 221                     ; 28 	 GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 223  0032 4b40          	push	#64
 224  0034 4b40          	push	#64
 225  0036 ae500f        	ldw	x,#20495
 226  0039 cd0000        	call	_GPIO_Init
 228  003c 85            	popw	x
 229                     ; 30 	 UART1_DeInit(); //Deinitialize UART peripherals 
 231  003d cd0000        	call	_UART1_DeInit
 233                     ; 33 		UART1_Init(baud_rate, 
 233                     ; 34                 UART1_WORDLENGTH_8D, 
 233                     ; 35                 UART1_STOPBITS_1, 
 233                     ; 36                 UART1_PARITY_NO, 
 233                     ; 37                 UART1_SYNCMODE_CLOCK_DISABLE, 
 233                     ; 38                 UART1_MODE_TXRX_ENABLE); //(BaudRate, Wordlegth, StopBits, Parity, SyncMode, Mode)
 235  0040 4b0c          	push	#12
 236  0042 4b80          	push	#128
 237  0044 4b00          	push	#0
 238  0046 4b00          	push	#0
 239  0048 4b00          	push	#0
 240  004a 1e0a          	ldw	x,(OFST+10,sp)
 241  004c 89            	pushw	x
 242  004d 1e0a          	ldw	x,(OFST+10,sp)
 243  004f 89            	pushw	x
 244  0050 cd0000        	call	_UART1_Init
 246  0053 5b09          	addw	sp,#9
 247                     ; 40 		UART1_Cmd(ENABLE);
 249  0055 a601          	ld	a,#1
 250  0057 cd0000        	call	_UART1_Cmd
 252                     ; 41  }
 255  005a 81            	ret
 309                     ; 43  void Serial_print_u32(u32 number)
 309                     ; 44  {
 310                     	switch	.text
 311  005b               _Serial_print_u32:
 313  005b 89            	pushw	x
 314       00000002      OFST:	set	2
 317                     ; 47 	 Serial_print_string("0x");
 319  005c ae0000        	ldw	x,#L731
 320  005f ad5d          	call	_Serial_print_string
 322                     ; 48 	 for(iter=28;iter>=0;iter-=4)
 324  0061 a61c          	ld	a,#28
 325  0063 6b02          	ld	(OFST+0,sp),a
 327  0065               L141:
 328                     ; 50 		 digit=(number>>iter)&0x0F;
 330  0065 96            	ldw	x,sp
 331  0066 1c0005        	addw	x,#OFST+3
 332  0069 cd0000        	call	c_ltor
 334  006c 7b02          	ld	a,(OFST+0,sp)
 335  006e cd0000        	call	c_lursh
 337  0071 b603          	ld	a,c_lreg+3
 338  0073 a40f          	and	a,#15
 339  0075 b703          	ld	c_lreg+3,a
 340  0077 3f02          	clr	c_lreg+2
 341  0079 3f01          	clr	c_lreg+1
 342  007b 3f00          	clr	c_lreg
 343  007d b603          	ld	a,c_lreg+3
 344  007f 6b01          	ld	(OFST-1,sp),a
 346                     ; 51 		 if(digit>9) Serial_print_char('A'+(digit-10));
 348  0081 7b01          	ld	a,(OFST-1,sp)
 349  0083 a10a          	cp	a,#10
 350  0085 2508          	jrult	L741
 353  0087 7b01          	ld	a,(OFST-1,sp)
 354  0089 ab37          	add	a,#55
 355  008b ad8d          	call	_Serial_print_char
 358  008d 2006          	jra	L151
 359  008f               L741:
 360                     ; 52 		 else Serial_print_char('0'+digit);
 362  008f 7b01          	ld	a,(OFST-1,sp)
 363  0091 ab30          	add	a,#48
 364  0093 ad85          	call	_Serial_print_char
 366  0095               L151:
 367                     ; 53 		 if(iter==16) Serial_print_char('_');
 369  0095 7b02          	ld	a,(OFST+0,sp)
 370  0097 a110          	cp	a,#16
 371  0099 2605          	jrne	L351
 374  009b a65f          	ld	a,#95
 375  009d cd001a        	call	_Serial_print_char
 377  00a0               L351:
 378                     ; 48 	 for(iter=28;iter>=0;iter-=4)
 380  00a0 7b02          	ld	a,(OFST+0,sp)
 381  00a2 a004          	sub	a,#4
 382  00a4 6b02          	ld	(OFST+0,sp),a
 386  00a6 9c            	rvf
 387  00a7 7b02          	ld	a,(OFST+0,sp)
 388  00a9 a100          	cp	a,#0
 389  00ab 2eb8          	jrsge	L141
 390                     ; 55  }
 393  00ad 85            	popw	x
 394  00ae 81            	ret
 419                     ; 77  void Serial_newline(void)
 419                     ; 78  {
 420                     	switch	.text
 421  00af               _Serial_newline:
 425                     ; 79 	 UART1_SendData8(0x0a);
 427  00af a60a          	ld	a,#10
 428  00b1 cd0000        	call	_UART1_SendData8
 431  00b4               L761:
 432                     ; 80 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending 
 434  00b4 ae0080        	ldw	x,#128
 435  00b7 cd0000        	call	_UART1_GetFlagStatus
 437  00ba 4d            	tnz	a
 438  00bb 27f7          	jreq	L761
 439                     ; 81  }
 442  00bd 81            	ret
 489                     ; 83  void Serial_print_string (char string[])
 489                     ; 84  {
 490                     	switch	.text
 491  00be               _Serial_print_string:
 493  00be 89            	pushw	x
 494  00bf 88            	push	a
 495       00000001      OFST:	set	1
 498                     ; 86 	 char i=0;
 500  00c0 0f01          	clr	(OFST+0,sp)
 503  00c2 2016          	jra	L122
 504  00c4               L512:
 505                     ; 90 		UART1_SendData8(string[i]);
 507  00c4 7b01          	ld	a,(OFST+0,sp)
 508  00c6 5f            	clrw	x
 509  00c7 97            	ld	xl,a
 510  00c8 72fb02        	addw	x,(OFST+1,sp)
 511  00cb f6            	ld	a,(x)
 512  00cc cd0000        	call	_UART1_SendData8
 515  00cf               L722:
 516                     ; 91 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 518  00cf ae0080        	ldw	x,#128
 519  00d2 cd0000        	call	_UART1_GetFlagStatus
 521  00d5 4d            	tnz	a
 522  00d6 27f7          	jreq	L722
 523                     ; 92 		i++;
 525  00d8 0c01          	inc	(OFST+0,sp)
 527  00da               L122:
 528                     ; 88 	 while (string[i] != 0x00)
 530  00da 7b01          	ld	a,(OFST+0,sp)
 531  00dc 5f            	clrw	x
 532  00dd 97            	ld	xl,a
 533  00de 72fb02        	addw	x,(OFST+1,sp)
 534  00e1 7d            	tnz	(x)
 535  00e2 26e0          	jrne	L512
 536                     ; 94  }
 539  00e4 5b03          	addw	sp,#3
 540  00e6 81            	ret
 565                     ; 96  bool Serial_available()
 565                     ; 97  {
 566                     	switch	.text
 567  00e7               _Serial_available:
 571                     ; 98 	 return UART1_GetFlagStatus(UART1_FLAG_RXNE);
 573  00e7 ae0020        	ldw	x,#32
 574  00ea cd0000        	call	_UART1_GetFlagStatus
 578  00ed 81            	ret
 591                     	xdef	_Serial_print_u32
 592                     	xdef	_Serial_read_char
 593                     	xdef	_Serial_available
 594                     	xdef	_Serial_newline
 595                     	xdef	_Serial_print_string
 596                     	xdef	_Serial_print_char
 597                     	xdef	_Serial_begin
 598                     	xref	_UART1_ClearFlag
 599                     	xref	_UART1_GetFlagStatus
 600                     	xref	_UART1_SendData8
 601                     	xref	_UART1_ReceiveData8
 602                     	xref	_UART1_Cmd
 603                     	xref	_UART1_Init
 604                     	xref	_UART1_DeInit
 605                     	xref	_GPIO_Init
 606                     .const:	section	.text
 607  0000               L731:
 608  0000 307800        	dc.b	"0x",0
 609                     	xref.b	c_lreg
 629                     	xref	c_lursh
 630                     	xref	c_ltor
 631                     	end
