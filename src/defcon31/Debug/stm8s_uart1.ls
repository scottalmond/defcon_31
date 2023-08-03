   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  42                     ; 53 void UART1_DeInit(void)
  42                     ; 54 {
  44                     	switch	.text
  45  0000               _UART1_DeInit:
  49                     ; 57   (void)UART1->SR;
  51  0000 c65230        	ld	a,21040
  52                     ; 58   (void)UART1->DR;
  54  0003 c65231        	ld	a,21041
  55                     ; 60   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  // Set UART1_BRR2 to reset value 0x00 
  57  0006 725f5233      	clr	21043
  58                     ; 61   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  // Set UART1_BRR1 to reset value 0x00 
  60  000a 725f5232      	clr	21042
  61                     ; 63   UART1->CR1 = UART1_CR1_RESET_VALUE;  // Set UART1_CR1 to reset value 0x00 
  63  000e 725f5234      	clr	21044
  64                     ; 64   UART1->CR2 = UART1_CR2_RESET_VALUE;  // Set UART1_CR2 to reset value 0x00 
  66  0012 725f5235      	clr	21045
  67                     ; 65   UART1->CR3 = UART1_CR3_RESET_VALUE;  // Set UART1_CR3 to reset value 0x00 
  69  0016 725f5236      	clr	21046
  70                     ; 66   UART1->CR4 = UART1_CR4_RESET_VALUE;  // Set UART1_CR4 to reset value 0x00 
  72  001a 725f5237      	clr	21047
  73                     ; 67   UART1->CR5 = UART1_CR5_RESET_VALUE;  // Set UART1_CR5 to reset value 0x00 
  75  001e 725f5238      	clr	21048
  76                     ; 69   UART1->GTR = UART1_GTR_RESET_VALUE;
  78  0022 725f5239      	clr	21049
  79                     ; 70   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  81  0026 725f523a      	clr	21050
  82                     ; 71 }
  85  002a 81            	ret
 388                     .const:	section	.text
 389  0000               L01:
 390  0000 00000064      	dc.l	100
 391                     ; 90 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 391                     ; 91                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 391                     ; 92                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 391                     ; 93 {
 392                     	switch	.text
 393  002b               _UART1_Init:
 395  002b 520c          	subw	sp,#12
 396       0000000c      OFST:	set	12
 399                     ; 94   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 403                     ; 97   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 405                     ; 98   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 407                     ; 99   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 409                     ; 100   assert_param(IS_UART1_PARITY_OK(Parity));
 411                     ; 101   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 413                     ; 102   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 415                     ; 105   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 417  002d 72195234      	bres	21044,#4
 418                     ; 108   UART1->CR1 |= (uint8_t)WordLength;
 420  0031 c65234        	ld	a,21044
 421  0034 1a13          	or	a,(OFST+7,sp)
 422  0036 c75234        	ld	21044,a
 423                     ; 111   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 425  0039 c65236        	ld	a,21046
 426  003c a4cf          	and	a,#207
 427  003e c75236        	ld	21046,a
 428                     ; 113   UART1->CR3 |= (uint8_t)StopBits;  
 430  0041 c65236        	ld	a,21046
 431  0044 1a14          	or	a,(OFST+8,sp)
 432  0046 c75236        	ld	21046,a
 433                     ; 116   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 435  0049 c65234        	ld	a,21044
 436  004c a4f9          	and	a,#249
 437  004e c75234        	ld	21044,a
 438                     ; 118   UART1->CR1 |= (uint8_t)Parity;  
 440  0051 c65234        	ld	a,21044
 441  0054 1a15          	or	a,(OFST+9,sp)
 442  0056 c75234        	ld	21044,a
 443                     ; 121   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 445  0059 725f5232      	clr	21042
 446                     ; 123   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 448  005d c65233        	ld	a,21043
 449  0060 a40f          	and	a,#15
 450  0062 c75233        	ld	21043,a
 451                     ; 125   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 453  0065 c65233        	ld	a,21043
 454  0068 a4f0          	and	a,#240
 455  006a c75233        	ld	21043,a
 456                     ; 128   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 458  006d 96            	ldw	x,sp
 459  006e 1c000f        	addw	x,#OFST+3
 460  0071 cd0000        	call	c_ltor
 462  0074 a604          	ld	a,#4
 463  0076 cd0000        	call	c_llsh
 465  0079 96            	ldw	x,sp
 466  007a 1c0001        	addw	x,#OFST-11
 467  007d cd0000        	call	c_rtol
 470  0080 cd0000        	call	_CLK_GetClockFreq
 472  0083 96            	ldw	x,sp
 473  0084 1c0001        	addw	x,#OFST-11
 474  0087 cd0000        	call	c_ludv
 476  008a 96            	ldw	x,sp
 477  008b 1c0009        	addw	x,#OFST-3
 478  008e cd0000        	call	c_rtol
 481                     ; 129   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 483  0091 96            	ldw	x,sp
 484  0092 1c000f        	addw	x,#OFST+3
 485  0095 cd0000        	call	c_ltor
 487  0098 a604          	ld	a,#4
 488  009a cd0000        	call	c_llsh
 490  009d 96            	ldw	x,sp
 491  009e 1c0001        	addw	x,#OFST-11
 492  00a1 cd0000        	call	c_rtol
 495  00a4 cd0000        	call	_CLK_GetClockFreq
 497  00a7 a664          	ld	a,#100
 498  00a9 cd0000        	call	c_smul
 500  00ac 96            	ldw	x,sp
 501  00ad 1c0001        	addw	x,#OFST-11
 502  00b0 cd0000        	call	c_ludv
 504  00b3 96            	ldw	x,sp
 505  00b4 1c0005        	addw	x,#OFST-7
 506  00b7 cd0000        	call	c_rtol
 509                     ; 131   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 511  00ba 96            	ldw	x,sp
 512  00bb 1c0009        	addw	x,#OFST-3
 513  00be cd0000        	call	c_ltor
 515  00c1 a664          	ld	a,#100
 516  00c3 cd0000        	call	c_smul
 518  00c6 96            	ldw	x,sp
 519  00c7 1c0001        	addw	x,#OFST-11
 520  00ca cd0000        	call	c_rtol
 523  00cd 96            	ldw	x,sp
 524  00ce 1c0005        	addw	x,#OFST-7
 525  00d1 cd0000        	call	c_ltor
 527  00d4 96            	ldw	x,sp
 528  00d5 1c0001        	addw	x,#OFST-11
 529  00d8 cd0000        	call	c_lsub
 531  00db a604          	ld	a,#4
 532  00dd cd0000        	call	c_llsh
 534  00e0 ae0000        	ldw	x,#L01
 535  00e3 cd0000        	call	c_ludv
 537  00e6 b603          	ld	a,c_lreg+3
 538  00e8 a40f          	and	a,#15
 539  00ea ca5233        	or	a,21043
 540  00ed c75233        	ld	21043,a
 541                     ; 133   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 543  00f0 1e0b          	ldw	x,(OFST-1,sp)
 544  00f2 54            	srlw	x
 545  00f3 54            	srlw	x
 546  00f4 54            	srlw	x
 547  00f5 54            	srlw	x
 548  00f6 01            	rrwa	x,a
 549  00f7 a4f0          	and	a,#240
 550  00f9 5f            	clrw	x
 551  00fa ca5233        	or	a,21043
 552  00fd c75233        	ld	21043,a
 553                     ; 135   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 555  0100 c65232        	ld	a,21042
 556  0103 1a0c          	or	a,(OFST+0,sp)
 557  0105 c75232        	ld	21042,a
 558                     ; 138   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 560  0108 c65235        	ld	a,21045
 561  010b a4f3          	and	a,#243
 562  010d c75235        	ld	21045,a
 563                     ; 140   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 565  0110 c65236        	ld	a,21046
 566  0113 a4f8          	and	a,#248
 567  0115 c75236        	ld	21046,a
 568                     ; 142   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 568                     ; 143                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 570  0118 7b16          	ld	a,(OFST+10,sp)
 571  011a a407          	and	a,#7
 572  011c ca5236        	or	a,21046
 573  011f c75236        	ld	21046,a
 574                     ; 145   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 576  0122 7b17          	ld	a,(OFST+11,sp)
 577  0124 a504          	bcp	a,#4
 578  0126 2706          	jreq	L371
 579                     ; 148     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 581  0128 72165235      	bset	21045,#3
 583  012c 2004          	jra	L571
 584  012e               L371:
 585                     ; 153     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 587  012e 72175235      	bres	21045,#3
 588  0132               L571:
 589                     ; 155   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 591  0132 7b17          	ld	a,(OFST+11,sp)
 592  0134 a508          	bcp	a,#8
 593  0136 2706          	jreq	L771
 594                     ; 158     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 596  0138 72145235      	bset	21045,#2
 598  013c 2004          	jra	L102
 599  013e               L771:
 600                     ; 163     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 602  013e 72155235      	bres	21045,#2
 603  0142               L102:
 604                     ; 167   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 606  0142 7b16          	ld	a,(OFST+10,sp)
 607  0144 a580          	bcp	a,#128
 608  0146 2706          	jreq	L302
 609                     ; 170     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 611  0148 72175236      	bres	21046,#3
 613  014c 200a          	jra	L502
 614  014e               L302:
 615                     ; 174     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 617  014e 7b16          	ld	a,(OFST+10,sp)
 618  0150 a408          	and	a,#8
 619  0152 ca5236        	or	a,21046
 620  0155 c75236        	ld	21046,a
 621  0158               L502:
 622                     ; 176 }
 625  0158 5b0c          	addw	sp,#12
 626  015a 81            	ret
 681                     ; 184 void UART1_Cmd(FunctionalState NewState)
 681                     ; 185 {
 682                     	switch	.text
 683  015b               _UART1_Cmd:
 687                     ; 186   if (NewState != DISABLE)
 689  015b 4d            	tnz	a
 690  015c 2706          	jreq	L532
 691                     ; 189     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 693  015e 721b5234      	bres	21044,#5
 695  0162 2004          	jra	L732
 696  0164               L532:
 697                     ; 194     UART1->CR1 |= UART1_CR1_UARTD;  
 699  0164 721a5234      	bset	21044,#5
 700  0168               L732:
 701                     ; 196 }
 704  0168 81            	ret
 727                     ; 451 uint8_t UART1_ReceiveData8(void)
 727                     ; 452 {
 728                     	switch	.text
 729  0169               _UART1_ReceiveData8:
 733                     ; 453   return ((uint8_t)UART1->DR);
 735  0169 c65231        	ld	a,21041
 738  016c 81            	ret
 772                     ; 474 void UART1_SendData8(uint8_t Data)
 772                     ; 475 {
 773                     	switch	.text
 774  016d               _UART1_SendData8:
 778                     ; 477   UART1->DR = Data;
 780  016d c75231        	ld	21041,a
 781                     ; 478 }
 784  0170 81            	ret
 927                     ; 568 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
 927                     ; 569 {
 928                     	switch	.text
 929  0171               _UART1_GetFlagStatus:
 931  0171 89            	pushw	x
 932  0172 88            	push	a
 933       00000001      OFST:	set	1
 936                     ; 570   FlagStatus status = RESET;
 938                     ; 573   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
 940                     ; 577   if (UART1_FLAG == UART1_FLAG_LBDF)
 942  0173 a30210        	cpw	x,#528
 943  0176 2610          	jrne	L153
 944                     ; 579     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
 946  0178 9f            	ld	a,xl
 947  0179 c45237        	and	a,21047
 948  017c 2706          	jreq	L353
 949                     ; 582       status = SET;
 951  017e a601          	ld	a,#1
 952  0180 6b01          	ld	(OFST+0,sp),a
 955  0182 202b          	jra	L753
 956  0184               L353:
 957                     ; 587       status = RESET;
 959  0184 0f01          	clr	(OFST+0,sp)
 961  0186 2027          	jra	L753
 962  0188               L153:
 963                     ; 590   else if (UART1_FLAG == UART1_FLAG_SBK)
 965  0188 1e02          	ldw	x,(OFST+1,sp)
 966  018a a30101        	cpw	x,#257
 967  018d 2611          	jrne	L163
 968                     ; 592     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
 970  018f c65235        	ld	a,21045
 971  0192 1503          	bcp	a,(OFST+2,sp)
 972  0194 2706          	jreq	L363
 973                     ; 595       status = SET;
 975  0196 a601          	ld	a,#1
 976  0198 6b01          	ld	(OFST+0,sp),a
 979  019a 2013          	jra	L753
 980  019c               L363:
 981                     ; 600       status = RESET;
 983  019c 0f01          	clr	(OFST+0,sp)
 985  019e 200f          	jra	L753
 986  01a0               L163:
 987                     ; 605     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
 989  01a0 c65230        	ld	a,21040
 990  01a3 1503          	bcp	a,(OFST+2,sp)
 991  01a5 2706          	jreq	L173
 992                     ; 608       status = SET;
 994  01a7 a601          	ld	a,#1
 995  01a9 6b01          	ld	(OFST+0,sp),a
 998  01ab 2002          	jra	L753
 999  01ad               L173:
1000                     ; 613       status = RESET;
1002  01ad 0f01          	clr	(OFST+0,sp)
1004  01af               L753:
1005                     ; 617   return status;
1007  01af 7b01          	ld	a,(OFST+0,sp)
1010  01b1 5b03          	addw	sp,#3
1011  01b3 81            	ret
1046                     ; 646 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
1046                     ; 647 {
1047                     	switch	.text
1048  01b4               _UART1_ClearFlag:
1052                     ; 648   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
1054                     ; 651   if (UART1_FLAG == UART1_FLAG_RXNE)
1056  01b4 a30020        	cpw	x,#32
1057  01b7 2606          	jrne	L314
1058                     ; 653     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
1060  01b9 35df5230      	mov	21040,#223
1062  01bd 2004          	jra	L514
1063  01bf               L314:
1064                     ; 658     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
1066  01bf 72195237      	bres	21047,#4
1067  01c3               L514:
1068                     ; 660 }
1071  01c3 81            	ret
1084                     	xdef	_UART1_ClearFlag
1085                     	xdef	_UART1_GetFlagStatus
1086                     	xdef	_UART1_SendData8
1087                     	xdef	_UART1_ReceiveData8
1088                     	xdef	_UART1_Cmd
1089                     	xdef	_UART1_Init
1090                     	xdef	_UART1_DeInit
1091                     	xref	_CLK_GetClockFreq
1092                     	xref.b	c_lreg
1093                     	xref.b	c_x
1112                     	xref	c_lsub
1113                     	xref	c_smul
1114                     	xref	c_ludv
1115                     	xref	c_rtol
1116                     	xref	c_llsh
1117                     	xref	c_ltor
1118                     	end
