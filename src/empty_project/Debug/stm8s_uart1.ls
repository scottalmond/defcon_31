   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  42                     ; 54 void UART1_DeInit(void)
  42                     ; 55 {
  44                     	switch	.text
  45  0000               _UART1_DeInit:
  49                     ; 58   (void)UART1->SR;
  51  0000 c65230        	ld	a,21040
  52                     ; 59   (void)UART1->DR;
  54  0003 c65231        	ld	a,21041
  55                     ; 61   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  57  0006 725f5233      	clr	21043
  58                     ; 62   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  60  000a 725f5232      	clr	21042
  61                     ; 64   UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  63  000e 725f5234      	clr	21044
  64                     ; 65   UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  66  0012 725f5235      	clr	21045
  67                     ; 66   UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  69  0016 725f5236      	clr	21046
  70                     ; 67   UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  72  001a 725f5237      	clr	21047
  73                     ; 68   UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  75  001e 725f5238      	clr	21048
  76                     ; 70   UART1->GTR = UART1_GTR_RESET_VALUE;
  78  0022 725f5239      	clr	21049
  79                     ; 71   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  81  0026 725f523a      	clr	21050
  82                     ; 72 }
  85  002a 81            	ret
 388                     .const:	section	.text
 389  0000               L01:
 390  0000 00000064      	dc.l	100
 391                     ; 91 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 391                     ; 92                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 391                     ; 93                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 391                     ; 94 {
 392                     	switch	.text
 393  002b               _UART1_Init:
 395  002b 520c          	subw	sp,#12
 396       0000000c      OFST:	set	12
 399                     ; 95   uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 403                     ; 98   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 405                     ; 99   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 407                     ; 100   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 409                     ; 101   assert_param(IS_UART1_PARITY_OK(Parity));
 411                     ; 102   assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 413                     ; 103   assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 415                     ; 106   UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 417  002d 72195234      	bres	21044,#4
 418                     ; 109   UART1->CR1 |= (uint8_t)WordLength;
 420  0031 c65234        	ld	a,21044
 421  0034 1a13          	or	a,(OFST+7,sp)
 422  0036 c75234        	ld	21044,a
 423                     ; 112   UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 425  0039 c65236        	ld	a,21046
 426  003c a4cf          	and	a,#207
 427  003e c75236        	ld	21046,a
 428                     ; 114   UART1->CR3 |= (uint8_t)StopBits;  
 430  0041 c65236        	ld	a,21046
 431  0044 1a14          	or	a,(OFST+8,sp)
 432  0046 c75236        	ld	21046,a
 433                     ; 117   UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 435  0049 c65234        	ld	a,21044
 436  004c a4f9          	and	a,#249
 437  004e c75234        	ld	21044,a
 438                     ; 119   UART1->CR1 |= (uint8_t)Parity;  
 440  0051 c65234        	ld	a,21044
 441  0054 1a15          	or	a,(OFST+9,sp)
 442  0056 c75234        	ld	21044,a
 443                     ; 122   UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 445  0059 725f5232      	clr	21042
 446                     ; 124   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 448  005d c65233        	ld	a,21043
 449  0060 a40f          	and	a,#15
 450  0062 c75233        	ld	21043,a
 451                     ; 126   UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 453  0065 c65233        	ld	a,21043
 454  0068 a4f0          	and	a,#240
 455  006a c75233        	ld	21043,a
 456                     ; 129   BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
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
 481                     ; 130   BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
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
 509                     ; 132   UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
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
 541                     ; 134   UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
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
 553                     ; 136   UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 555  0100 c65232        	ld	a,21042
 556  0103 1a0c          	or	a,(OFST+0,sp)
 557  0105 c75232        	ld	21042,a
 558                     ; 139   UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 560  0108 c65235        	ld	a,21045
 561  010b a4f3          	and	a,#243
 562  010d c75235        	ld	21045,a
 563                     ; 141   UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 565  0110 c65236        	ld	a,21046
 566  0113 a4f8          	and	a,#248
 567  0115 c75236        	ld	21046,a
 568                     ; 143   UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 568                     ; 144                                                         UART1_CR3_CPHA | UART1_CR3_LBCL));  
 570  0118 7b16          	ld	a,(OFST+10,sp)
 571  011a a407          	and	a,#7
 572  011c ca5236        	or	a,21046
 573  011f c75236        	ld	21046,a
 574                     ; 146   if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 576  0122 7b17          	ld	a,(OFST+11,sp)
 577  0124 a504          	bcp	a,#4
 578  0126 2706          	jreq	L371
 579                     ; 149     UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 581  0128 72165235      	bset	21045,#3
 583  012c 2004          	jra	L571
 584  012e               L371:
 585                     ; 154     UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 587  012e 72175235      	bres	21045,#3
 588  0132               L571:
 589                     ; 156   if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 591  0132 7b17          	ld	a,(OFST+11,sp)
 592  0134 a508          	bcp	a,#8
 593  0136 2706          	jreq	L771
 594                     ; 159     UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 596  0138 72145235      	bset	21045,#2
 598  013c 2004          	jra	L102
 599  013e               L771:
 600                     ; 164     UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 602  013e 72155235      	bres	21045,#2
 603  0142               L102:
 604                     ; 168   if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 606  0142 7b16          	ld	a,(OFST+10,sp)
 607  0144 a580          	bcp	a,#128
 608  0146 2706          	jreq	L302
 609                     ; 171     UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 611  0148 72175236      	bres	21046,#3
 613  014c 200a          	jra	L502
 614  014e               L302:
 615                     ; 175     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 617  014e 7b16          	ld	a,(OFST+10,sp)
 618  0150 a408          	and	a,#8
 619  0152 ca5236        	or	a,21046
 620  0155 c75236        	ld	21046,a
 621  0158               L502:
 622                     ; 177 }
 625  0158 5b0c          	addw	sp,#12
 626  015a 81            	ret
 681                     ; 185 void UART1_Cmd(FunctionalState NewState)
 681                     ; 186 {
 682                     	switch	.text
 683  015b               _UART1_Cmd:
 687                     ; 187   if (NewState != DISABLE)
 689  015b 4d            	tnz	a
 690  015c 2706          	jreq	L532
 691                     ; 190     UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 693  015e 721b5234      	bres	21044,#5
 695  0162 2004          	jra	L732
 696  0164               L532:
 697                     ; 195     UART1->CR1 |= UART1_CR1_UARTD;  
 699  0164 721a5234      	bset	21044,#5
 700  0168               L732:
 701                     ; 197 }
 704  0168 81            	ret
 829                     ; 212 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 829                     ; 213 {
 830                     	switch	.text
 831  0169               _UART1_ITConfig:
 833  0169 89            	pushw	x
 834  016a 89            	pushw	x
 835       00000002      OFST:	set	2
 838                     ; 214   uint8_t uartreg = 0, itpos = 0x00;
 842                     ; 217   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 844                     ; 218   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 846                     ; 221   uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 848  016b 9e            	ld	a,xh
 849  016c 6b01          	ld	(OFST-1,sp),a
 851                     ; 223   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 853  016e 9f            	ld	a,xl
 854  016f a40f          	and	a,#15
 855  0171 5f            	clrw	x
 856  0172 97            	ld	xl,a
 857  0173 a601          	ld	a,#1
 858  0175 5d            	tnzw	x
 859  0176 2704          	jreq	L61
 860  0178               L02:
 861  0178 48            	sll	a
 862  0179 5a            	decw	x
 863  017a 26fc          	jrne	L02
 864  017c               L61:
 865  017c 6b02          	ld	(OFST+0,sp),a
 867                     ; 225   if (NewState != DISABLE)
 869  017e 0d07          	tnz	(OFST+5,sp)
 870  0180 272a          	jreq	L713
 871                     ; 228     if (uartreg == 0x01)
 873  0182 7b01          	ld	a,(OFST-1,sp)
 874  0184 a101          	cp	a,#1
 875  0186 260a          	jrne	L123
 876                     ; 230       UART1->CR1 |= itpos;
 878  0188 c65234        	ld	a,21044
 879  018b 1a02          	or	a,(OFST+0,sp)
 880  018d c75234        	ld	21044,a
 882  0190 2045          	jra	L133
 883  0192               L123:
 884                     ; 232     else if (uartreg == 0x02)
 886  0192 7b01          	ld	a,(OFST-1,sp)
 887  0194 a102          	cp	a,#2
 888  0196 260a          	jrne	L523
 889                     ; 234       UART1->CR2 |= itpos;
 891  0198 c65235        	ld	a,21045
 892  019b 1a02          	or	a,(OFST+0,sp)
 893  019d c75235        	ld	21045,a
 895  01a0 2035          	jra	L133
 896  01a2               L523:
 897                     ; 238       UART1->CR4 |= itpos;
 899  01a2 c65237        	ld	a,21047
 900  01a5 1a02          	or	a,(OFST+0,sp)
 901  01a7 c75237        	ld	21047,a
 902  01aa 202b          	jra	L133
 903  01ac               L713:
 904                     ; 244     if (uartreg == 0x01)
 906  01ac 7b01          	ld	a,(OFST-1,sp)
 907  01ae a101          	cp	a,#1
 908  01b0 260b          	jrne	L333
 909                     ; 246       UART1->CR1 &= (uint8_t)(~itpos);
 911  01b2 7b02          	ld	a,(OFST+0,sp)
 912  01b4 43            	cpl	a
 913  01b5 c45234        	and	a,21044
 914  01b8 c75234        	ld	21044,a
 916  01bb 201a          	jra	L133
 917  01bd               L333:
 918                     ; 248     else if (uartreg == 0x02)
 920  01bd 7b01          	ld	a,(OFST-1,sp)
 921  01bf a102          	cp	a,#2
 922  01c1 260b          	jrne	L733
 923                     ; 250       UART1->CR2 &= (uint8_t)(~itpos);
 925  01c3 7b02          	ld	a,(OFST+0,sp)
 926  01c5 43            	cpl	a
 927  01c6 c45235        	and	a,21045
 928  01c9 c75235        	ld	21045,a
 930  01cc 2009          	jra	L133
 931  01ce               L733:
 932                     ; 254       UART1->CR4 &= (uint8_t)(~itpos);
 934  01ce 7b02          	ld	a,(OFST+0,sp)
 935  01d0 43            	cpl	a
 936  01d1 c45237        	and	a,21047
 937  01d4 c75237        	ld	21047,a
 938  01d7               L133:
 939                     ; 258 }
 942  01d7 5b04          	addw	sp,#4
 943  01d9 81            	ret
 979                     ; 266 void UART1_HalfDuplexCmd(FunctionalState NewState)
 979                     ; 267 {
 980                     	switch	.text
 981  01da               _UART1_HalfDuplexCmd:
 985                     ; 268   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 987                     ; 270   if (NewState != DISABLE)
 989  01da 4d            	tnz	a
 990  01db 2706          	jreq	L163
 991                     ; 272     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 993  01dd 72165238      	bset	21048,#3
 995  01e1 2004          	jra	L363
 996  01e3               L163:
 997                     ; 276     UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 999  01e3 72175238      	bres	21048,#3
1000  01e7               L363:
1001                     ; 278 }
1004  01e7 81            	ret
1061                     ; 286 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1061                     ; 287 {
1062                     	switch	.text
1063  01e8               _UART1_IrDAConfig:
1067                     ; 288   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1069                     ; 290   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1071  01e8 4d            	tnz	a
1072  01e9 2706          	jreq	L314
1073                     ; 292     UART1->CR5 |= UART1_CR5_IRLP;
1075  01eb 72145238      	bset	21048,#2
1077  01ef 2004          	jra	L514
1078  01f1               L314:
1079                     ; 296     UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1081  01f1 72155238      	bres	21048,#2
1082  01f5               L514:
1083                     ; 298 }
1086  01f5 81            	ret
1121                     ; 306 void UART1_IrDACmd(FunctionalState NewState)
1121                     ; 307 {
1122                     	switch	.text
1123  01f6               _UART1_IrDACmd:
1127                     ; 309   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1129                     ; 311   if (NewState != DISABLE)
1131  01f6 4d            	tnz	a
1132  01f7 2706          	jreq	L534
1133                     ; 314     UART1->CR5 |= UART1_CR5_IREN;
1135  01f9 72125238      	bset	21048,#1
1137  01fd 2004          	jra	L734
1138  01ff               L534:
1139                     ; 319     UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1141  01ff 72135238      	bres	21048,#1
1142  0203               L734:
1143                     ; 321 }
1146  0203 81            	ret
1205                     ; 330 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1205                     ; 331 {
1206                     	switch	.text
1207  0204               _UART1_LINBreakDetectionConfig:
1211                     ; 332   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1213                     ; 334   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1215  0204 4d            	tnz	a
1216  0205 2706          	jreq	L764
1217                     ; 336     UART1->CR4 |= UART1_CR4_LBDL;
1219  0207 721a5237      	bset	21047,#5
1221  020b 2004          	jra	L174
1222  020d               L764:
1223                     ; 340     UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1225  020d 721b5237      	bres	21047,#5
1226  0211               L174:
1227                     ; 342 }
1230  0211 81            	ret
1265                     ; 350 void UART1_LINCmd(FunctionalState NewState)
1265                     ; 351 {
1266                     	switch	.text
1267  0212               _UART1_LINCmd:
1271                     ; 352   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1273                     ; 354   if (NewState != DISABLE)
1275  0212 4d            	tnz	a
1276  0213 2706          	jreq	L115
1277                     ; 357     UART1->CR3 |= UART1_CR3_LINEN;
1279  0215 721c5236      	bset	21046,#6
1281  0219 2004          	jra	L315
1282  021b               L115:
1283                     ; 362     UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1285  021b 721d5236      	bres	21046,#6
1286  021f               L315:
1287                     ; 364 }
1290  021f 81            	ret
1325                     ; 372 void UART1_SmartCardCmd(FunctionalState NewState)
1325                     ; 373 {
1326                     	switch	.text
1327  0220               _UART1_SmartCardCmd:
1331                     ; 374   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1333                     ; 376   if (NewState != DISABLE)
1335  0220 4d            	tnz	a
1336  0221 2706          	jreq	L335
1337                     ; 379     UART1->CR5 |= UART1_CR5_SCEN;
1339  0223 721a5238      	bset	21048,#5
1341  0227 2004          	jra	L535
1342  0229               L335:
1343                     ; 384     UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1345  0229 721b5238      	bres	21048,#5
1346  022d               L535:
1347                     ; 386 }
1350  022d 81            	ret
1386                     ; 395 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1386                     ; 396 {
1387                     	switch	.text
1388  022e               _UART1_SmartCardNACKCmd:
1392                     ; 397   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1394                     ; 399   if (NewState != DISABLE)
1396  022e 4d            	tnz	a
1397  022f 2706          	jreq	L555
1398                     ; 402     UART1->CR5 |= UART1_CR5_NACK;
1400  0231 72185238      	bset	21048,#4
1402  0235 2004          	jra	L755
1403  0237               L555:
1404                     ; 407     UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1406  0237 72195238      	bres	21048,#4
1407  023b               L755:
1408                     ; 409 }
1411  023b 81            	ret
1468                     ; 417 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1468                     ; 418 {
1469                     	switch	.text
1470  023c               _UART1_WakeUpConfig:
1474                     ; 419   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1476                     ; 421   UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1478  023c 72175234      	bres	21044,#3
1479                     ; 422   UART1->CR1 |= (uint8_t)UART1_WakeUp;
1481  0240 ca5234        	or	a,21044
1482  0243 c75234        	ld	21044,a
1483                     ; 423 }
1486  0246 81            	ret
1522                     ; 431 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1522                     ; 432 {
1523                     	switch	.text
1524  0247               _UART1_ReceiverWakeUpCmd:
1528                     ; 433   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1530                     ; 435   if (NewState != DISABLE)
1532  0247 4d            	tnz	a
1533  0248 2706          	jreq	L526
1534                     ; 438     UART1->CR2 |= UART1_CR2_RWU;
1536  024a 72125235      	bset	21045,#1
1538  024e 2004          	jra	L726
1539  0250               L526:
1540                     ; 443     UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1542  0250 72135235      	bres	21045,#1
1543  0254               L726:
1544                     ; 445 }
1547  0254 81            	ret
1570                     ; 452 uint8_t UART1_ReceiveData8(void)
1570                     ; 453 {
1571                     	switch	.text
1572  0255               _UART1_ReceiveData8:
1576                     ; 454   return ((uint8_t)UART1->DR);
1578  0255 c65231        	ld	a,21041
1581  0258 81            	ret
1615                     ; 462 uint16_t UART1_ReceiveData9(void)
1615                     ; 463 {
1616                     	switch	.text
1617  0259               _UART1_ReceiveData9:
1619  0259 89            	pushw	x
1620       00000002      OFST:	set	2
1623                     ; 464   uint16_t temp = 0;
1625                     ; 466   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1627  025a c65234        	ld	a,21044
1628  025d 5f            	clrw	x
1629  025e a480          	and	a,#128
1630  0260 5f            	clrw	x
1631  0261 02            	rlwa	x,a
1632  0262 58            	sllw	x
1633  0263 1f01          	ldw	(OFST-1,sp),x
1635                     ; 467   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1637  0265 c65231        	ld	a,21041
1638  0268 5f            	clrw	x
1639  0269 97            	ld	xl,a
1640  026a 01            	rrwa	x,a
1641  026b 1a02          	or	a,(OFST+0,sp)
1642  026d 01            	rrwa	x,a
1643  026e 1a01          	or	a,(OFST-1,sp)
1644  0270 01            	rrwa	x,a
1645  0271 01            	rrwa	x,a
1646  0272 a4ff          	and	a,#255
1647  0274 01            	rrwa	x,a
1648  0275 a401          	and	a,#1
1649  0277 01            	rrwa	x,a
1652  0278 5b02          	addw	sp,#2
1653  027a 81            	ret
1687                     ; 475 void UART1_SendData8(uint8_t Data)
1687                     ; 476 {
1688                     	switch	.text
1689  027b               _UART1_SendData8:
1693                     ; 478   UART1->DR = Data;
1695  027b c75231        	ld	21041,a
1696                     ; 479 }
1699  027e 81            	ret
1733                     ; 487 void UART1_SendData9(uint16_t Data)
1733                     ; 488 {
1734                     	switch	.text
1735  027f               _UART1_SendData9:
1737  027f 89            	pushw	x
1738       00000000      OFST:	set	0
1741                     ; 490   UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1743  0280 721d5234      	bres	21044,#6
1744                     ; 492   UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1746  0284 54            	srlw	x
1747  0285 54            	srlw	x
1748  0286 9f            	ld	a,xl
1749  0287 a440          	and	a,#64
1750  0289 ca5234        	or	a,21044
1751  028c c75234        	ld	21044,a
1752                     ; 494   UART1->DR   = (uint8_t)(Data);
1754  028f 7b02          	ld	a,(OFST+2,sp)
1755  0291 c75231        	ld	21041,a
1756                     ; 495 }
1759  0294 85            	popw	x
1760  0295 81            	ret
1783                     ; 502 void UART1_SendBreak(void)
1783                     ; 503 {
1784                     	switch	.text
1785  0296               _UART1_SendBreak:
1789                     ; 504   UART1->CR2 |= UART1_CR2_SBK;
1791  0296 72105235      	bset	21045,#0
1792                     ; 505 }
1795  029a 81            	ret
1829                     ; 512 void UART1_SetAddress(uint8_t UART1_Address)
1829                     ; 513 {
1830                     	switch	.text
1831  029b               _UART1_SetAddress:
1833  029b 88            	push	a
1834       00000000      OFST:	set	0
1837                     ; 515   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1839                     ; 518   UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1841  029c c65237        	ld	a,21047
1842  029f a4f0          	and	a,#240
1843  02a1 c75237        	ld	21047,a
1844                     ; 520   UART1->CR4 |= UART1_Address;
1846  02a4 c65237        	ld	a,21047
1847  02a7 1a01          	or	a,(OFST+1,sp)
1848  02a9 c75237        	ld	21047,a
1849                     ; 521 }
1852  02ac 84            	pop	a
1853  02ad 81            	ret
1887                     ; 529 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1887                     ; 530 {
1888                     	switch	.text
1889  02ae               _UART1_SetGuardTime:
1893                     ; 532   UART1->GTR = UART1_GuardTime;
1895  02ae c75239        	ld	21049,a
1896                     ; 533 }
1899  02b1 81            	ret
1933                     ; 557 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1933                     ; 558 {
1934                     	switch	.text
1935  02b2               _UART1_SetPrescaler:
1939                     ; 560   UART1->PSCR = UART1_Prescaler;
1941  02b2 c7523a        	ld	21050,a
1942                     ; 561 }
1945  02b5 81            	ret
2088                     ; 569 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2088                     ; 570 {
2089                     	switch	.text
2090  02b6               _UART1_GetFlagStatus:
2092  02b6 89            	pushw	x
2093  02b7 88            	push	a
2094       00000001      OFST:	set	1
2097                     ; 571   FlagStatus status = RESET;
2099                     ; 574   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2101                     ; 578   if (UART1_FLAG == UART1_FLAG_LBDF)
2103  02b8 a30210        	cpw	x,#528
2104  02bb 2610          	jrne	L7501
2105                     ; 580     if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2107  02bd 9f            	ld	a,xl
2108  02be c45237        	and	a,21047
2109  02c1 2706          	jreq	L1601
2110                     ; 583       status = SET;
2112  02c3 a601          	ld	a,#1
2113  02c5 6b01          	ld	(OFST+0,sp),a
2116  02c7 202b          	jra	L5601
2117  02c9               L1601:
2118                     ; 588       status = RESET;
2120  02c9 0f01          	clr	(OFST+0,sp)
2122  02cb 2027          	jra	L5601
2123  02cd               L7501:
2124                     ; 591   else if (UART1_FLAG == UART1_FLAG_SBK)
2126  02cd 1e02          	ldw	x,(OFST+1,sp)
2127  02cf a30101        	cpw	x,#257
2128  02d2 2611          	jrne	L7601
2129                     ; 593     if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2131  02d4 c65235        	ld	a,21045
2132  02d7 1503          	bcp	a,(OFST+2,sp)
2133  02d9 2706          	jreq	L1701
2134                     ; 596       status = SET;
2136  02db a601          	ld	a,#1
2137  02dd 6b01          	ld	(OFST+0,sp),a
2140  02df 2013          	jra	L5601
2141  02e1               L1701:
2142                     ; 601       status = RESET;
2144  02e1 0f01          	clr	(OFST+0,sp)
2146  02e3 200f          	jra	L5601
2147  02e5               L7601:
2148                     ; 606     if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2150  02e5 c65230        	ld	a,21040
2151  02e8 1503          	bcp	a,(OFST+2,sp)
2152  02ea 2706          	jreq	L7701
2153                     ; 609       status = SET;
2155  02ec a601          	ld	a,#1
2156  02ee 6b01          	ld	(OFST+0,sp),a
2159  02f0 2002          	jra	L5601
2160  02f2               L7701:
2161                     ; 614       status = RESET;
2163  02f2 0f01          	clr	(OFST+0,sp)
2165  02f4               L5601:
2166                     ; 618   return status;
2168  02f4 7b01          	ld	a,(OFST+0,sp)
2171  02f6 5b03          	addw	sp,#3
2172  02f8 81            	ret
2207                     ; 647 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2207                     ; 648 {
2208                     	switch	.text
2209  02f9               _UART1_ClearFlag:
2213                     ; 649   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2215                     ; 652   if (UART1_FLAG == UART1_FLAG_RXNE)
2217  02f9 a30020        	cpw	x,#32
2218  02fc 2606          	jrne	L1211
2219                     ; 654     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2221  02fe 35df5230      	mov	21040,#223
2223  0302 2004          	jra	L3211
2224  0304               L1211:
2225                     ; 659     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2227  0304 72195237      	bres	21047,#4
2228  0308               L3211:
2229                     ; 661 }
2232  0308 81            	ret
2314                     ; 676 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2314                     ; 677 {
2315                     	switch	.text
2316  0309               _UART1_GetITStatus:
2318  0309 89            	pushw	x
2319  030a 89            	pushw	x
2320       00000002      OFST:	set	2
2323                     ; 678   ITStatus pendingbitstatus = RESET;
2325                     ; 679   uint8_t itpos = 0;
2327                     ; 680   uint8_t itmask1 = 0;
2329                     ; 681   uint8_t itmask2 = 0;
2331                     ; 682   uint8_t enablestatus = 0;
2333                     ; 685   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2335                     ; 688   itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2337  030b 9f            	ld	a,xl
2338  030c a40f          	and	a,#15
2339  030e 5f            	clrw	x
2340  030f 97            	ld	xl,a
2341  0310 a601          	ld	a,#1
2342  0312 5d            	tnzw	x
2343  0313 2704          	jreq	L27
2344  0315               L47:
2345  0315 48            	sll	a
2346  0316 5a            	decw	x
2347  0317 26fc          	jrne	L47
2348  0319               L27:
2349  0319 6b01          	ld	(OFST-1,sp),a
2351                     ; 690   itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2353  031b 7b04          	ld	a,(OFST+2,sp)
2354  031d 4e            	swap	a
2355  031e a40f          	and	a,#15
2356  0320 6b02          	ld	(OFST+0,sp),a
2358                     ; 692   itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2360  0322 7b02          	ld	a,(OFST+0,sp)
2361  0324 5f            	clrw	x
2362  0325 97            	ld	xl,a
2363  0326 a601          	ld	a,#1
2364  0328 5d            	tnzw	x
2365  0329 2704          	jreq	L67
2366  032b               L001:
2367  032b 48            	sll	a
2368  032c 5a            	decw	x
2369  032d 26fc          	jrne	L001
2370  032f               L67:
2371  032f 6b02          	ld	(OFST+0,sp),a
2373                     ; 696   if (UART1_IT == UART1_IT_PE)
2375  0331 1e03          	ldw	x,(OFST+1,sp)
2376  0333 a30100        	cpw	x,#256
2377  0336 261c          	jrne	L7611
2378                     ; 699     enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2380  0338 c65234        	ld	a,21044
2381  033b 1402          	and	a,(OFST+0,sp)
2382  033d 6b02          	ld	(OFST+0,sp),a
2384                     ; 702     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2386  033f c65230        	ld	a,21040
2387  0342 1501          	bcp	a,(OFST-1,sp)
2388  0344 270a          	jreq	L1711
2390  0346 0d02          	tnz	(OFST+0,sp)
2391  0348 2706          	jreq	L1711
2392                     ; 705       pendingbitstatus = SET;
2394  034a a601          	ld	a,#1
2395  034c 6b02          	ld	(OFST+0,sp),a
2398  034e 2041          	jra	L5711
2399  0350               L1711:
2400                     ; 710       pendingbitstatus = RESET;
2402  0350 0f02          	clr	(OFST+0,sp)
2404  0352 203d          	jra	L5711
2405  0354               L7611:
2406                     ; 714   else if (UART1_IT == UART1_IT_LBDF)
2408  0354 1e03          	ldw	x,(OFST+1,sp)
2409  0356 a30346        	cpw	x,#838
2410  0359 261c          	jrne	L7711
2411                     ; 717     enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2413  035b c65237        	ld	a,21047
2414  035e 1402          	and	a,(OFST+0,sp)
2415  0360 6b02          	ld	(OFST+0,sp),a
2417                     ; 719     if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2419  0362 c65237        	ld	a,21047
2420  0365 1501          	bcp	a,(OFST-1,sp)
2421  0367 270a          	jreq	L1021
2423  0369 0d02          	tnz	(OFST+0,sp)
2424  036b 2706          	jreq	L1021
2425                     ; 722       pendingbitstatus = SET;
2427  036d a601          	ld	a,#1
2428  036f 6b02          	ld	(OFST+0,sp),a
2431  0371 201e          	jra	L5711
2432  0373               L1021:
2433                     ; 727       pendingbitstatus = RESET;
2435  0373 0f02          	clr	(OFST+0,sp)
2437  0375 201a          	jra	L5711
2438  0377               L7711:
2439                     ; 733     enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2441  0377 c65235        	ld	a,21045
2442  037a 1402          	and	a,(OFST+0,sp)
2443  037c 6b02          	ld	(OFST+0,sp),a
2445                     ; 735     if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2447  037e c65230        	ld	a,21040
2448  0381 1501          	bcp	a,(OFST-1,sp)
2449  0383 270a          	jreq	L7021
2451  0385 0d02          	tnz	(OFST+0,sp)
2452  0387 2706          	jreq	L7021
2453                     ; 738       pendingbitstatus = SET;
2455  0389 a601          	ld	a,#1
2456  038b 6b02          	ld	(OFST+0,sp),a
2459  038d 2002          	jra	L5711
2460  038f               L7021:
2461                     ; 743       pendingbitstatus = RESET;
2463  038f 0f02          	clr	(OFST+0,sp)
2465  0391               L5711:
2466                     ; 748   return  pendingbitstatus;
2468  0391 7b02          	ld	a,(OFST+0,sp)
2471  0393 5b04          	addw	sp,#4
2472  0395 81            	ret
2508                     ; 776 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2508                     ; 777 {
2509                     	switch	.text
2510  0396               _UART1_ClearITPendingBit:
2514                     ; 778   assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2516                     ; 781   if (UART1_IT == UART1_IT_RXNE)
2518  0396 a30255        	cpw	x,#597
2519  0399 2606          	jrne	L1321
2520                     ; 783     UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2522  039b 35df5230      	mov	21040,#223
2524  039f 2004          	jra	L3321
2525  03a1               L1321:
2526                     ; 788     UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2528  03a1 72195237      	bres	21047,#4
2529  03a5               L3321:
2530                     ; 790 }
2533  03a5 81            	ret
2546                     	xref	_CLK_GetClockFreq
2547                     	xdef	_UART1_ClearITPendingBit
2548                     	xdef	_UART1_GetITStatus
2549                     	xdef	_UART1_ClearFlag
2550                     	xdef	_UART1_GetFlagStatus
2551                     	xdef	_UART1_SetPrescaler
2552                     	xdef	_UART1_SetGuardTime
2553                     	xdef	_UART1_SetAddress
2554                     	xdef	_UART1_SendBreak
2555                     	xdef	_UART1_SendData9
2556                     	xdef	_UART1_SendData8
2557                     	xdef	_UART1_ReceiveData9
2558                     	xdef	_UART1_ReceiveData8
2559                     	xdef	_UART1_ReceiverWakeUpCmd
2560                     	xdef	_UART1_WakeUpConfig
2561                     	xdef	_UART1_SmartCardNACKCmd
2562                     	xdef	_UART1_SmartCardCmd
2563                     	xdef	_UART1_LINCmd
2564                     	xdef	_UART1_LINBreakDetectionConfig
2565                     	xdef	_UART1_IrDACmd
2566                     	xdef	_UART1_IrDAConfig
2567                     	xdef	_UART1_HalfDuplexCmd
2568                     	xdef	_UART1_ITConfig
2569                     	xdef	_UART1_Cmd
2570                     	xdef	_UART1_Init
2571                     	xdef	_UART1_DeInit
2572                     	xref.b	c_lreg
2573                     	xref.b	c_x
2592                     	xref	c_lsub
2593                     	xref	c_smul
2594                     	xref	c_ludv
2595                     	xref	c_rtol
2596                     	xref	c_llsh
2597                     	xref	c_ltor
2598                     	end
