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
 772                     ; 461 uint16_t UART1_ReceiveData9(void)
 772                     ; 462 {
 773                     	switch	.text
 774  016d               _UART1_ReceiveData9:
 776  016d 89            	pushw	x
 777       00000002      OFST:	set	2
 780                     ; 463   uint16_t temp = 0;
 782                     ; 465   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
 784  016e c65234        	ld	a,21044
 785  0171 5f            	clrw	x
 786  0172 a480          	and	a,#128
 787  0174 5f            	clrw	x
 788  0175 02            	rlwa	x,a
 789  0176 58            	sllw	x
 790  0177 1f01          	ldw	(OFST-1,sp),x
 792                     ; 466   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
 794  0179 c65231        	ld	a,21041
 795  017c 5f            	clrw	x
 796  017d 97            	ld	xl,a
 797  017e 01            	rrwa	x,a
 798  017f 1a02          	or	a,(OFST+0,sp)
 799  0181 01            	rrwa	x,a
 800  0182 1a01          	or	a,(OFST-1,sp)
 801  0184 01            	rrwa	x,a
 802  0185 01            	rrwa	x,a
 803  0186 a4ff          	and	a,#255
 804  0188 01            	rrwa	x,a
 805  0189 a401          	and	a,#1
 806  018b 01            	rrwa	x,a
 809  018c 5b02          	addw	sp,#2
 810  018e 81            	ret
 844                     ; 474 void UART1_SendData8(uint8_t Data)
 844                     ; 475 {
 845                     	switch	.text
 846  018f               _UART1_SendData8:
 850                     ; 477   UART1->DR = Data;
 852  018f c75231        	ld	21041,a
 853                     ; 478 }
 856  0192 81            	ret
 890                     ; 486 void UART1_SendData9(uint16_t Data)
 890                     ; 487 {
 891                     	switch	.text
 892  0193               _UART1_SendData9:
 894  0193 89            	pushw	x
 895       00000000      OFST:	set	0
 898                     ; 489   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
 900  0194 721d5234      	bres	21044,#6
 901                     ; 491   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
 903  0198 54            	srlw	x
 904  0199 54            	srlw	x
 905  019a 9f            	ld	a,xl
 906  019b a440          	and	a,#64
 907  019d ca5234        	or	a,21044
 908  01a0 c75234        	ld	21044,a
 909                     ; 493   UART1->DR   = (uint8_t)(Data);
 911  01a3 7b02          	ld	a,(OFST+2,sp)
 912  01a5 c75231        	ld	21041,a
 913                     ; 494 }
 916  01a8 85            	popw	x
 917  01a9 81            	ret
 940                     ; 501 void UART1_SendBreak(void)
 940                     ; 502 {
 941                     	switch	.text
 942  01aa               _UART1_SendBreak:
 946                     ; 503   UART1->CR2 |= UART1_CR2_SBK;
 948  01aa 72105235      	bset	21045,#0
 949                     ; 504 }
 952  01ae 81            	ret
 986                     ; 511 void UART1_SetAddress(uint8_t UART1_Address)
 986                     ; 512 {
 987                     	switch	.text
 988  01af               _UART1_SetAddress:
 990  01af 88            	push	a
 991       00000000      OFST:	set	0
 994                     ; 514   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
 996                     ; 517   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
 998  01b0 c65237        	ld	a,21047
 999  01b3 a4f0          	and	a,#240
1000  01b5 c75237        	ld	21047,a
1001                     ; 519   UART1->CR4 |= UART1_Address;
1003  01b8 c65237        	ld	a,21047
1004  01bb 1a01          	or	a,(OFST+1,sp)
1005  01bd c75237        	ld	21047,a
1006                     ; 520 }
1009  01c0 84            	pop	a
1010  01c1 81            	ret
1044                     ; 556 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1044                     ; 557 {
1045                     	switch	.text
1046  01c2               _UART1_SetPrescaler:
1050                     ; 559   UART1->PSCR = UART1_Prescaler;
1052  01c2 c7523a        	ld	21050,a
1053                     ; 560 }
1056  01c5 81            	ret
1199                     ; 568 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
1199                     ; 569 {
1200                     	switch	.text
1201  01c6               _UART1_GetFlagStatus:
1203  01c6 89            	pushw	x
1204  01c7 88            	push	a
1205       00000001      OFST:	set	1
1208                     ; 570   FlagStatus status = RESET;
1210                     ; 573   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
1212                     ; 577   if (UART1_FLAG == UART1_FLAG_LBDF)
1214  01c8 a30210        	cpw	x,#528
1215  01cb 2610          	jrne	L154
1216                     ; 579     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
1218  01cd 9f            	ld	a,xl
1219  01ce c45237        	and	a,21047
1220  01d1 2706          	jreq	L354
1221                     ; 582       status = SET;
1223  01d3 a601          	ld	a,#1
1224  01d5 6b01          	ld	(OFST+0,sp),a
1227  01d7 202b          	jra	L754
1228  01d9               L354:
1229                     ; 587       status = RESET;
1231  01d9 0f01          	clr	(OFST+0,sp)
1233  01db 2027          	jra	L754
1234  01dd               L154:
1235                     ; 590   else if (UART1_FLAG == UART1_FLAG_SBK)
1237  01dd 1e02          	ldw	x,(OFST+1,sp)
1238  01df a30101        	cpw	x,#257
1239  01e2 2611          	jrne	L164
1240                     ; 592     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
1242  01e4 c65235        	ld	a,21045
1243  01e7 1503          	bcp	a,(OFST+2,sp)
1244  01e9 2706          	jreq	L364
1245                     ; 595       status = SET;
1247  01eb a601          	ld	a,#1
1248  01ed 6b01          	ld	(OFST+0,sp),a
1251  01ef 2013          	jra	L754
1252  01f1               L364:
1253                     ; 600       status = RESET;
1255  01f1 0f01          	clr	(OFST+0,sp)
1257  01f3 200f          	jra	L754
1258  01f5               L164:
1259                     ; 605     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
1261  01f5 c65230        	ld	a,21040
1262  01f8 1503          	bcp	a,(OFST+2,sp)
1263  01fa 2706          	jreq	L174
1264                     ; 608       status = SET;
1266  01fc a601          	ld	a,#1
1267  01fe 6b01          	ld	(OFST+0,sp),a
1270  0200 2002          	jra	L754
1271  0202               L174:
1272                     ; 613       status = RESET;
1274  0202 0f01          	clr	(OFST+0,sp)
1276  0204               L754:
1277                     ; 617   return status;
1279  0204 7b01          	ld	a,(OFST+0,sp)
1282  0206 5b03          	addw	sp,#3
1283  0208 81            	ret
1318                     ; 646 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
1318                     ; 647 {
1319                     	switch	.text
1320  0209               _UART1_ClearFlag:
1324                     ; 648   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
1326                     ; 651   if (UART1_FLAG == UART1_FLAG_RXNE)
1328  0209 a30020        	cpw	x,#32
1329  020c 2606          	jrne	L315
1330                     ; 653     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
1332  020e 35df5230      	mov	21040,#223
1334  0212 2004          	jra	L515
1335  0214               L315:
1336                     ; 658     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
1338  0214 72195237      	bres	21047,#4
1339  0218               L515:
1340                     ; 660 }
1343  0218 81            	ret
1441                     ; 775 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
1441                     ; 776 {
1442                     	switch	.text
1443  0219               _UART1_ClearITPendingBit:
1447                     ; 777   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
1449                     ; 780   if (UART1_IT == UART1_IT_RXNE)
1451  0219 a30255        	cpw	x,#597
1452  021c 2606          	jrne	L165
1453                     ; 782     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
1455  021e 35df5230      	mov	21040,#223
1457  0222 2004          	jra	L365
1458  0224               L165:
1459                     ; 787     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
1461  0224 72195237      	bres	21047,#4
1462  0228               L365:
1463                     ; 789 }
1466  0228 81            	ret
1479                     	xdef	_UART1_ClearITPendingBit
1480                     	xdef	_UART1_ClearFlag
1481                     	xdef	_UART1_GetFlagStatus
1482                     	xdef	_UART1_SetPrescaler
1483                     	xdef	_UART1_SetAddress
1484                     	xdef	_UART1_SendBreak
1485                     	xdef	_UART1_SendData9
1486                     	xdef	_UART1_SendData8
1487                     	xdef	_UART1_ReceiveData9
1488                     	xdef	_UART1_ReceiveData8
1489                     	xdef	_UART1_Cmd
1490                     	xdef	_UART1_Init
1491                     	xdef	_UART1_DeInit
1492                     	xref	_CLK_GetClockFreq
1493                     	xref.b	c_lreg
1494                     	xref.b	c_x
1513                     	xref	c_lsub
1514                     	xref	c_smul
1515                     	xref	c_ludv
1516                     	xref	c_rtol
1517                     	xref	c_llsh
1518                     	xref	c_ltor
1519                     	end
