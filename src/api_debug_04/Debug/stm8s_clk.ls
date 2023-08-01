   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _HSIDivFactor:
  16  0000 01            	dc.b	1
  17  0001 02            	dc.b	2
  18  0002 04            	dc.b	4
  19  0003 08            	dc.b	8
  20  0004               _CLKPrescTable:
  21  0004 01            	dc.b	1
  22  0005 02            	dc.b	2
  23  0006 04            	dc.b	4
  24  0007 08            	dc.b	8
  25  0008 0a            	dc.b	10
  26  0009 10            	dc.b	16
  27  000a 14            	dc.b	20
  28  000b 28            	dc.b	40
  57                     ; 72 void CLK_DeInit(void)
  57                     ; 73 {
  59                     	switch	.text
  60  0000               _CLK_DeInit:
  64                     ; 74   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  66  0000 350150c0      	mov	20672,#1
  67                     ; 75   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  69  0004 725f50c1      	clr	20673
  70                     ; 76   CLK->SWR  = CLK_SWR_RESET_VALUE;
  72  0008 35e150c4      	mov	20676,#225
  73                     ; 77   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  75  000c 725f50c5      	clr	20677
  76                     ; 78   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  78  0010 351850c6      	mov	20678,#24
  79                     ; 79   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  81  0014 35ff50c7      	mov	20679,#255
  82                     ; 80   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  84  0018 35ff50ca      	mov	20682,#255
  85                     ; 81   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  87  001c 725f50c8      	clr	20680
  88                     ; 82   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  90  0020 725f50c9      	clr	20681
  92  0024               L52:
  93                     ; 83   while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  95  0024 c650c9        	ld	a,20681
  96  0027 a501          	bcp	a,#1
  97  0029 26f9          	jrne	L52
  98                     ; 85   CLK->CCOR = CLK_CCOR_RESET_VALUE;
 100  002b 725f50c9      	clr	20681
 101                     ; 86   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 103  002f 725f50cc      	clr	20684
 104                     ; 87   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 106  0033 725f50cd      	clr	20685
 107                     ; 88 }
 110  0037 81            	ret
 200                     ; 569 uint32_t CLK_GetClockFreq(void)
 200                     ; 570 {
 201                     	switch	.text
 202  0038               _CLK_GetClockFreq:
 204  0038 5209          	subw	sp,#9
 205       00000009      OFST:	set	9
 208                     ; 571   uint32_t clockfrequency = 0;
 210                     ; 572   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
 212                     ; 573   uint8_t tmp = 0, presc = 0;
 216                     ; 576   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
 218  003a c650c3        	ld	a,20675
 219  003d 6b09          	ld	(OFST+0,sp),a
 221                     ; 578   if (clocksource == CLK_SOURCE_HSI)
 223  003f 7b09          	ld	a,(OFST+0,sp)
 224  0041 a1e1          	cp	a,#225
 225  0043 2641          	jrne	L57
 226                     ; 580     tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
 228  0045 c650c6        	ld	a,20678
 229  0048 a418          	and	a,#24
 230  004a 6b09          	ld	(OFST+0,sp),a
 232                     ; 581     tmp = (uint8_t)(tmp >> 3);
 234  004c 0409          	srl	(OFST+0,sp)
 235  004e 0409          	srl	(OFST+0,sp)
 236  0050 0409          	srl	(OFST+0,sp)
 238                     ; 582     presc = HSIDivFactor[tmp];
 240  0052 7b09          	ld	a,(OFST+0,sp)
 241  0054 5f            	clrw	x
 242  0055 97            	ld	xl,a
 243  0056 d60000        	ld	a,(_HSIDivFactor,x)
 244  0059 6b09          	ld	(OFST+0,sp),a
 246                     ; 583     clockfrequency = HSI_VALUE / presc;
 248  005b 7b09          	ld	a,(OFST+0,sp)
 249  005d b703          	ld	c_lreg+3,a
 250  005f 3f02          	clr	c_lreg+2
 251  0061 3f01          	clr	c_lreg+1
 252  0063 3f00          	clr	c_lreg
 253  0065 96            	ldw	x,sp
 254  0066 1c0001        	addw	x,#OFST-8
 255  0069 cd0000        	call	c_rtol
 258  006c ae2400        	ldw	x,#9216
 259  006f bf02          	ldw	c_lreg+2,x
 260  0071 ae00f4        	ldw	x,#244
 261  0074 bf00          	ldw	c_lreg,x
 262  0076 96            	ldw	x,sp
 263  0077 1c0001        	addw	x,#OFST-8
 264  007a cd0000        	call	c_ludv
 266  007d 96            	ldw	x,sp
 267  007e 1c0005        	addw	x,#OFST-4
 268  0081 cd0000        	call	c_rtol
 272  0084 201c          	jra	L77
 273  0086               L57:
 274                     ; 585   else if ( clocksource == CLK_SOURCE_LSI)
 276  0086 7b09          	ld	a,(OFST+0,sp)
 277  0088 a1d2          	cp	a,#210
 278  008a 260c          	jrne	L101
 279                     ; 587     clockfrequency = LSI_VALUE;
 281  008c aef400        	ldw	x,#62464
 282  008f 1f07          	ldw	(OFST-2,sp),x
 283  0091 ae0001        	ldw	x,#1
 284  0094 1f05          	ldw	(OFST-4,sp),x
 287  0096 200a          	jra	L77
 288  0098               L101:
 289                     ; 591     clockfrequency = HSE_VALUE;
 291  0098 ae2400        	ldw	x,#9216
 292  009b 1f07          	ldw	(OFST-2,sp),x
 293  009d ae00f4        	ldw	x,#244
 294  00a0 1f05          	ldw	(OFST-4,sp),x
 296  00a2               L77:
 297                     ; 594   return((uint32_t)clockfrequency);
 299  00a2 96            	ldw	x,sp
 300  00a3 1c0005        	addw	x,#OFST-4
 301  00a6 cd0000        	call	c_ltor
 305  00a9 5b09          	addw	sp,#9
 306  00ab 81            	ret
 341                     	xdef	_CLKPrescTable
 342                     	xdef	_HSIDivFactor
 343                     	xdef	_CLK_GetClockFreq
 344                     	xdef	_CLK_DeInit
 345                     	xref.b	c_lreg
 346                     	xref.b	c_x
 365                     	xref	c_ltor
 366                     	xref	c_ludv
 367                     	xref	c_rtol
 368                     	end
