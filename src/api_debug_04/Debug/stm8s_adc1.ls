   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  42                     ; 52 void ADC1_DeInit(void)
  42                     ; 53 {
  44                     	switch	.text
  45  0000               _ADC1_DeInit:
  49                     ; 54   ADC1->CSR  = ADC1_CSR_RESET_VALUE;
  51  0000 725f5400      	clr	21504
  52                     ; 55   ADC1->CR1  = ADC1_CR1_RESET_VALUE;
  54  0004 725f5401      	clr	21505
  55                     ; 56   ADC1->CR2  = ADC1_CR2_RESET_VALUE;
  57  0008 725f5402      	clr	21506
  58                     ; 57   ADC1->CR3  = ADC1_CR3_RESET_VALUE;
  60  000c 725f5403      	clr	21507
  61                     ; 58   ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
  63  0010 725f5406      	clr	21510
  64                     ; 59   ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
  66  0014 725f5407      	clr	21511
  67                     ; 60   ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
  69  0018 35ff5408      	mov	21512,#255
  70                     ; 61   ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
  72  001c 35035409      	mov	21513,#3
  73                     ; 62   ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
  75  0020 725f540a      	clr	21514
  76                     ; 63   ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
  78  0024 725f540b      	clr	21515
  79                     ; 64   ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
  81  0028 725f540e      	clr	21518
  82                     ; 65   ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
  84  002c 725f540f      	clr	21519
  85                     ; 66 }
  88  0030 81            	ret
 539                     ; 88 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
 539                     ; 89 {
 540                     	switch	.text
 541  0031               _ADC1_Init:
 543  0031 89            	pushw	x
 544       00000000      OFST:	set	0
 547                     ; 91   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 549                     ; 92   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 551                     ; 93   assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
 553                     ; 94   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 555                     ; 95   assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
 557                     ; 96   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 559                     ; 97   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 561                     ; 98   assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));
 563                     ; 103   ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 565  0032 7b08          	ld	a,(OFST+8,sp)
 566  0034 88            	push	a
 567  0035 9f            	ld	a,xl
 568  0036 97            	ld	xl,a
 569  0037 7b02          	ld	a,(OFST+2,sp)
 570  0039 95            	ld	xh,a
 571  003a cd0116        	call	_ADC1_ConversionConfig
 573  003d 84            	pop	a
 574                     ; 105   ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 576  003e 7b05          	ld	a,(OFST+5,sp)
 577  0040 ad33          	call	_ADC1_PrescalerConfig
 579                     ; 110   ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 581  0042 7b07          	ld	a,(OFST+7,sp)
 582  0044 97            	ld	xl,a
 583  0045 7b06          	ld	a,(OFST+6,sp)
 584  0047 95            	ld	xh,a
 585  0048 cd0144        	call	_ADC1_ExternalTriggerConfig
 587                     ; 115   ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 589  004b 7b0a          	ld	a,(OFST+10,sp)
 590  004d 97            	ld	xl,a
 591  004e 7b09          	ld	a,(OFST+9,sp)
 592  0050 95            	ld	xh,a
 593  0051 ad35          	call	_ADC1_SchmittTriggerConfig
 595                     ; 118   ADC1->CR1 |= ADC1_CR1_ADON;
 597  0053 72105401      	bset	21505,#0
 598                     ; 119 }
 601  0057 85            	popw	x
 602  0058 81            	ret
 637                     ; 126 void ADC1_Cmd(FunctionalState NewState)
 637                     ; 127 {
 638                     	switch	.text
 639  0059               _ADC1_Cmd:
 643                     ; 129   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 645                     ; 131   if (NewState != DISABLE)
 647  0059 4d            	tnz	a
 648  005a 2706          	jreq	L362
 649                     ; 133     ADC1->CR1 |= ADC1_CR1_ADON;
 651  005c 72105401      	bset	21505,#0
 653  0060 2004          	jra	L562
 654  0062               L362:
 655                     ; 137     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_ADON);
 657  0062 72115401      	bres	21505,#0
 658  0066               L562:
 659                     ; 139 }
 662  0066 81            	ret
 697                     ; 146 void ADC1_ScanModeCmd(FunctionalState NewState)
 697                     ; 147 {
 698                     	switch	.text
 699  0067               _ADC1_ScanModeCmd:
 703                     ; 149   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 705                     ; 151   if (NewState != DISABLE)
 707  0067 4d            	tnz	a
 708  0068 2706          	jreq	L503
 709                     ; 153     ADC1->CR2 |= ADC1_CR2_SCAN;
 711  006a 72125402      	bset	21506,#1
 713  006e 2004          	jra	L703
 714  0070               L503:
 715                     ; 157     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_SCAN);
 717  0070 72135402      	bres	21506,#1
 718  0074               L703:
 719                     ; 159 }
 722  0074 81            	ret
 758                     ; 214 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 758                     ; 215 {
 759                     	switch	.text
 760  0075               _ADC1_PrescalerConfig:
 762  0075 88            	push	a
 763       00000000      OFST:	set	0
 766                     ; 217   assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 768                     ; 220   ADC1->CR1 &= (uint8_t)(~ADC1_CR1_SPSEL);
 770  0076 c65401        	ld	a,21505
 771  0079 a48f          	and	a,#143
 772  007b c75401        	ld	21505,a
 773                     ; 222   ADC1->CR1 |= (uint8_t)(ADC1_Prescaler);
 775  007e c65401        	ld	a,21505
 776  0081 1a01          	or	a,(OFST+1,sp)
 777  0083 c75401        	ld	21505,a
 778                     ; 223 }
 781  0086 84            	pop	a
 782  0087 81            	ret
 829                     ; 233 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
 829                     ; 234 {
 830                     	switch	.text
 831  0088               _ADC1_SchmittTriggerConfig:
 833  0088 89            	pushw	x
 834       00000000      OFST:	set	0
 837                     ; 236   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 839                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 841                     ; 239   if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
 843  0089 9e            	ld	a,xh
 844  008a a1ff          	cp	a,#255
 845  008c 2620          	jrne	L153
 846                     ; 241     if (NewState != DISABLE)
 848  008e 9f            	ld	a,xl
 849  008f 4d            	tnz	a
 850  0090 270a          	jreq	L353
 851                     ; 243       ADC1->TDRL &= (uint8_t)0x0;
 853  0092 725f5407      	clr	21511
 854                     ; 244       ADC1->TDRH &= (uint8_t)0x0;
 856  0096 725f5406      	clr	21510
 858  009a 2078          	jra	L753
 859  009c               L353:
 860                     ; 248       ADC1->TDRL |= (uint8_t)0xFF;
 862  009c c65407        	ld	a,21511
 863  009f aaff          	or	a,#255
 864  00a1 c75407        	ld	21511,a
 865                     ; 249       ADC1->TDRH |= (uint8_t)0xFF;
 867  00a4 c65406        	ld	a,21510
 868  00a7 aaff          	or	a,#255
 869  00a9 c75406        	ld	21510,a
 870  00ac 2066          	jra	L753
 871  00ae               L153:
 872                     ; 252   else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
 874  00ae 7b01          	ld	a,(OFST+1,sp)
 875  00b0 a108          	cp	a,#8
 876  00b2 242f          	jruge	L163
 877                     ; 254     if (NewState != DISABLE)
 879  00b4 0d02          	tnz	(OFST+2,sp)
 880  00b6 2716          	jreq	L363
 881                     ; 256       ADC1->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel));
 883  00b8 7b01          	ld	a,(OFST+1,sp)
 884  00ba 5f            	clrw	x
 885  00bb 97            	ld	xl,a
 886  00bc a601          	ld	a,#1
 887  00be 5d            	tnzw	x
 888  00bf 2704          	jreq	L02
 889  00c1               L22:
 890  00c1 48            	sll	a
 891  00c2 5a            	decw	x
 892  00c3 26fc          	jrne	L22
 893  00c5               L02:
 894  00c5 43            	cpl	a
 895  00c6 c45407        	and	a,21511
 896  00c9 c75407        	ld	21511,a
 898  00cc 2046          	jra	L753
 899  00ce               L363:
 900                     ; 260       ADC1->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel);
 902  00ce 7b01          	ld	a,(OFST+1,sp)
 903  00d0 5f            	clrw	x
 904  00d1 97            	ld	xl,a
 905  00d2 a601          	ld	a,#1
 906  00d4 5d            	tnzw	x
 907  00d5 2704          	jreq	L42
 908  00d7               L62:
 909  00d7 48            	sll	a
 910  00d8 5a            	decw	x
 911  00d9 26fc          	jrne	L62
 912  00db               L42:
 913  00db ca5407        	or	a,21511
 914  00de c75407        	ld	21511,a
 915  00e1 2031          	jra	L753
 916  00e3               L163:
 917                     ; 265     if (NewState != DISABLE)
 919  00e3 0d02          	tnz	(OFST+2,sp)
 920  00e5 2718          	jreq	L173
 921                     ; 267       ADC1->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8)));
 923  00e7 7b01          	ld	a,(OFST+1,sp)
 924  00e9 a008          	sub	a,#8
 925  00eb 5f            	clrw	x
 926  00ec 97            	ld	xl,a
 927  00ed a601          	ld	a,#1
 928  00ef 5d            	tnzw	x
 929  00f0 2704          	jreq	L03
 930  00f2               L23:
 931  00f2 48            	sll	a
 932  00f3 5a            	decw	x
 933  00f4 26fc          	jrne	L23
 934  00f6               L03:
 935  00f6 43            	cpl	a
 936  00f7 c45406        	and	a,21510
 937  00fa c75406        	ld	21510,a
 939  00fd 2015          	jra	L753
 940  00ff               L173:
 941                     ; 271       ADC1->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8));
 943  00ff 7b01          	ld	a,(OFST+1,sp)
 944  0101 a008          	sub	a,#8
 945  0103 5f            	clrw	x
 946  0104 97            	ld	xl,a
 947  0105 a601          	ld	a,#1
 948  0107 5d            	tnzw	x
 949  0108 2704          	jreq	L43
 950  010a               L63:
 951  010a 48            	sll	a
 952  010b 5a            	decw	x
 953  010c 26fc          	jrne	L63
 954  010e               L43:
 955  010e ca5406        	or	a,21510
 956  0111 c75406        	ld	21510,a
 957  0114               L753:
 958                     ; 274 }
 961  0114 85            	popw	x
 962  0115 81            	ret
1019                     ; 286 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
1019                     ; 287 {
1020                     	switch	.text
1021  0116               _ADC1_ConversionConfig:
1023  0116 89            	pushw	x
1024       00000000      OFST:	set	0
1027                     ; 289   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
1029                     ; 290   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
1031                     ; 291   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
1033                     ; 294   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_ALIGN);
1035  0117 72175402      	bres	21506,#3
1036                     ; 296   ADC1->CR2 |= (uint8_t)(ADC1_Align);
1038  011b c65402        	ld	a,21506
1039  011e 1a05          	or	a,(OFST+5,sp)
1040  0120 c75402        	ld	21506,a
1041                     ; 298   if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
1043  0123 9e            	ld	a,xh
1044  0124 a101          	cp	a,#1
1045  0126 2606          	jrne	L324
1046                     ; 301     ADC1->CR1 |= ADC1_CR1_CONT;
1048  0128 72125401      	bset	21505,#1
1050  012c 2004          	jra	L524
1051  012e               L324:
1052                     ; 306     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_CONT);
1054  012e 72135401      	bres	21505,#1
1055  0132               L524:
1056                     ; 310   ADC1->CSR &= (uint8_t)(~ADC1_CSR_CH);
1058  0132 c65400        	ld	a,21504
1059  0135 a4f0          	and	a,#240
1060  0137 c75400        	ld	21504,a
1061                     ; 312   ADC1->CSR |= (uint8_t)(ADC1_Channel);
1063  013a c65400        	ld	a,21504
1064  013d 1a02          	or	a,(OFST+2,sp)
1065  013f c75400        	ld	21504,a
1066                     ; 313 }
1069  0142 85            	popw	x
1070  0143 81            	ret
1116                     ; 325 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
1116                     ; 326 {
1117                     	switch	.text
1118  0144               _ADC1_ExternalTriggerConfig:
1120  0144 89            	pushw	x
1121       00000000      OFST:	set	0
1124                     ; 328   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
1126                     ; 329   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1128                     ; 332   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTSEL);
1130  0145 c65402        	ld	a,21506
1131  0148 a4cf          	and	a,#207
1132  014a c75402        	ld	21506,a
1133                     ; 334   if (NewState != DISABLE)
1135  014d 9f            	ld	a,xl
1136  014e 4d            	tnz	a
1137  014f 2706          	jreq	L154
1138                     ; 337     ADC1->CR2 |= (uint8_t)(ADC1_CR2_EXTTRIG);
1140  0151 721c5402      	bset	21506,#6
1142  0155 2004          	jra	L354
1143  0157               L154:
1144                     ; 342     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTTRIG);
1146  0157 721d5402      	bres	21506,#6
1147  015b               L354:
1148                     ; 346   ADC1->CR2 |= (uint8_t)(ADC1_ExtTrigger);
1150  015b c65402        	ld	a,21506
1151  015e 1a01          	or	a,(OFST+1,sp)
1152  0160 c75402        	ld	21506,a
1153                     ; 347 }
1156  0163 85            	popw	x
1157  0164 81            	ret
1181                     ; 358 void ADC1_StartConversion(void)
1181                     ; 359 {
1182                     	switch	.text
1183  0165               _ADC1_StartConversion:
1187                     ; 360   ADC1->CR1 |= ADC1_CR1_ADON;
1189  0165 72105401      	bset	21505,#0
1190                     ; 361 }
1193  0169 81            	ret
1237                     ; 370 uint16_t ADC1_GetConversionValue(void)
1237                     ; 371 {
1238                     	switch	.text
1239  016a               _ADC1_GetConversionValue:
1241  016a 5205          	subw	sp,#5
1242       00000005      OFST:	set	5
1245                     ; 372   uint16_t temph = 0;
1247                     ; 373   uint8_t templ = 0;
1249                     ; 375   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) // Right alignment 
1251  016c c65402        	ld	a,21506
1252  016f a508          	bcp	a,#8
1253  0171 2715          	jreq	L705
1254                     ; 378     templ = ADC1->DRL;
1256  0173 c65405        	ld	a,21509
1257  0176 6b03          	ld	(OFST-2,sp),a
1259                     ; 380     temph = ADC1->DRH;
1261  0178 c65404        	ld	a,21508
1262  017b 5f            	clrw	x
1263  017c 97            	ld	xl,a
1264  017d 1f04          	ldw	(OFST-1,sp),x
1266                     ; 382     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1268  017f 1e04          	ldw	x,(OFST-1,sp)
1269  0181 7b03          	ld	a,(OFST-2,sp)
1270  0183 02            	rlwa	x,a
1271  0184 1f04          	ldw	(OFST-1,sp),x
1274  0186 2021          	jra	L115
1275  0188               L705:
1276                     ; 387     temph = ADC1->DRH;
1278  0188 c65404        	ld	a,21508
1279  018b 5f            	clrw	x
1280  018c 97            	ld	xl,a
1281  018d 1f04          	ldw	(OFST-1,sp),x
1283                     ; 389     templ = ADC1->DRL;
1285  018f c65405        	ld	a,21509
1286  0192 6b03          	ld	(OFST-2,sp),a
1288                     ; 391     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1290  0194 1e04          	ldw	x,(OFST-1,sp)
1291  0196 4f            	clr	a
1292  0197 02            	rlwa	x,a
1293  0198 1f01          	ldw	(OFST-4,sp),x
1295  019a 7b03          	ld	a,(OFST-2,sp)
1296  019c 97            	ld	xl,a
1297  019d a640          	ld	a,#64
1298  019f 42            	mul	x,a
1299  01a0 01            	rrwa	x,a
1300  01a1 1a02          	or	a,(OFST-3,sp)
1301  01a3 01            	rrwa	x,a
1302  01a4 1a01          	or	a,(OFST-4,sp)
1303  01a6 01            	rrwa	x,a
1304  01a7 1f04          	ldw	(OFST-1,sp),x
1306  01a9               L115:
1307                     ; 394   return ((uint16_t)temph);
1309  01a9 1e04          	ldw	x,(OFST-1,sp)
1312  01ab 5b05          	addw	sp,#5
1313  01ad 81            	ret
1379                     ; 502 FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel)
1379                     ; 503 {
1380                     	switch	.text
1381  01ae               _ADC1_GetAWDChannelStatus:
1383  01ae 88            	push	a
1384  01af 88            	push	a
1385       00000001      OFST:	set	1
1388                     ; 504   uint8_t status = 0;
1390                     ; 507   assert_param(IS_ADC1_CHANNEL_OK(Channel));
1392                     ; 509   if (Channel < (uint8_t)8)
1394  01b0 a108          	cp	a,#8
1395  01b2 2412          	jruge	L545
1396                     ; 511     status = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << Channel));
1398  01b4 5f            	clrw	x
1399  01b5 97            	ld	xl,a
1400  01b6 a601          	ld	a,#1
1401  01b8 5d            	tnzw	x
1402  01b9 2704          	jreq	L25
1403  01bb               L45:
1404  01bb 48            	sll	a
1405  01bc 5a            	decw	x
1406  01bd 26fc          	jrne	L45
1407  01bf               L25:
1408  01bf c4540d        	and	a,21517
1409  01c2 6b01          	ld	(OFST+0,sp),a
1412  01c4 2014          	jra	L745
1413  01c6               L545:
1414                     ; 515     status = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8)));
1416  01c6 7b02          	ld	a,(OFST+1,sp)
1417  01c8 a008          	sub	a,#8
1418  01ca 5f            	clrw	x
1419  01cb 97            	ld	xl,a
1420  01cc a601          	ld	a,#1
1421  01ce 5d            	tnzw	x
1422  01cf 2704          	jreq	L65
1423  01d1               L06:
1424  01d1 48            	sll	a
1425  01d2 5a            	decw	x
1426  01d3 26fc          	jrne	L06
1427  01d5               L65:
1428  01d5 c4540c        	and	a,21516
1429  01d8 6b01          	ld	(OFST+0,sp),a
1431  01da               L745:
1432                     ; 518   return ((FlagStatus)status);
1434  01da 7b01          	ld	a,(OFST+0,sp)
1437  01dc 85            	popw	x
1438  01dd 81            	ret
1596                     ; 527 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
1596                     ; 528 {
1597                     	switch	.text
1598  01de               _ADC1_GetFlagStatus:
1600  01de 88            	push	a
1601  01df 88            	push	a
1602       00000001      OFST:	set	1
1605                     ; 529   uint8_t flagstatus = 0;
1607                     ; 530   uint8_t temp = 0;
1609                     ; 533   assert_param(IS_ADC1_FLAG_OK(Flag));
1611                     ; 535   if ((Flag & 0x0F) == 0x01)
1613  01e0 a40f          	and	a,#15
1614  01e2 a101          	cp	a,#1
1615  01e4 2609          	jrne	L736
1616                     ; 538     flagstatus = (uint8_t)(ADC1->CR3 & ADC1_CR3_OVR);
1618  01e6 c65403        	ld	a,21507
1619  01e9 a440          	and	a,#64
1620  01eb 6b01          	ld	(OFST+0,sp),a
1623  01ed 2045          	jra	L146
1624  01ef               L736:
1625                     ; 540   else if ((Flag & 0xF0) == 0x10)
1627  01ef 7b02          	ld	a,(OFST+1,sp)
1628  01f1 a4f0          	and	a,#240
1629  01f3 a110          	cp	a,#16
1630  01f5 2636          	jrne	L346
1631                     ; 543     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1633  01f7 7b02          	ld	a,(OFST+1,sp)
1634  01f9 a40f          	and	a,#15
1635  01fb 6b01          	ld	(OFST+0,sp),a
1637                     ; 544     if (temp < 8)
1639  01fd 7b01          	ld	a,(OFST+0,sp)
1640  01ff a108          	cp	a,#8
1641  0201 2414          	jruge	L546
1642                     ; 546       flagstatus = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1644  0203 7b01          	ld	a,(OFST+0,sp)
1645  0205 5f            	clrw	x
1646  0206 97            	ld	xl,a
1647  0207 a601          	ld	a,#1
1648  0209 5d            	tnzw	x
1649  020a 2704          	jreq	L46
1650  020c               L66:
1651  020c 48            	sll	a
1652  020d 5a            	decw	x
1653  020e 26fc          	jrne	L66
1654  0210               L46:
1655  0210 c4540d        	and	a,21517
1656  0213 6b01          	ld	(OFST+0,sp),a
1659  0215 201d          	jra	L146
1660  0217               L546:
1661                     ; 550       flagstatus = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1663  0217 7b01          	ld	a,(OFST+0,sp)
1664  0219 a008          	sub	a,#8
1665  021b 5f            	clrw	x
1666  021c 97            	ld	xl,a
1667  021d a601          	ld	a,#1
1668  021f 5d            	tnzw	x
1669  0220 2704          	jreq	L07
1670  0222               L27:
1671  0222 48            	sll	a
1672  0223 5a            	decw	x
1673  0224 26fc          	jrne	L27
1674  0226               L07:
1675  0226 c4540c        	and	a,21516
1676  0229 6b01          	ld	(OFST+0,sp),a
1678  022b 2007          	jra	L146
1679  022d               L346:
1680                     ; 555     flagstatus = (uint8_t)(ADC1->CSR & Flag);
1682  022d c65400        	ld	a,21504
1683  0230 1402          	and	a,(OFST+1,sp)
1684  0232 6b01          	ld	(OFST+0,sp),a
1686  0234               L146:
1687                     ; 557   return ((FlagStatus)flagstatus);
1689  0234 7b01          	ld	a,(OFST+0,sp)
1692  0236 85            	popw	x
1693  0237 81            	ret
1737                     ; 567 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
1737                     ; 568 {
1738                     	switch	.text
1739  0238               _ADC1_ClearFlag:
1741  0238 88            	push	a
1742  0239 88            	push	a
1743       00000001      OFST:	set	1
1746                     ; 569   uint8_t temp = 0;
1748                     ; 572   assert_param(IS_ADC1_FLAG_OK(Flag));
1750                     ; 574   if ((Flag & 0x0F) == 0x01)
1752  023a a40f          	and	a,#15
1753  023c a101          	cp	a,#1
1754  023e 2606          	jrne	L576
1755                     ; 577     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_OVR);
1757  0240 721d5403      	bres	21507,#6
1759  0244 204b          	jra	L776
1760  0246               L576:
1761                     ; 579   else if ((Flag & 0xF0) == 0x10)
1763  0246 7b02          	ld	a,(OFST+1,sp)
1764  0248 a4f0          	and	a,#240
1765  024a a110          	cp	a,#16
1766  024c 263a          	jrne	L107
1767                     ; 582     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1769  024e 7b02          	ld	a,(OFST+1,sp)
1770  0250 a40f          	and	a,#15
1771  0252 6b01          	ld	(OFST+0,sp),a
1773                     ; 583     if (temp < 8)
1775  0254 7b01          	ld	a,(OFST+0,sp)
1776  0256 a108          	cp	a,#8
1777  0258 2416          	jruge	L307
1778                     ; 585       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
1780  025a 7b01          	ld	a,(OFST+0,sp)
1781  025c 5f            	clrw	x
1782  025d 97            	ld	xl,a
1783  025e a601          	ld	a,#1
1784  0260 5d            	tnzw	x
1785  0261 2704          	jreq	L67
1786  0263               L001:
1787  0263 48            	sll	a
1788  0264 5a            	decw	x
1789  0265 26fc          	jrne	L001
1790  0267               L67:
1791  0267 43            	cpl	a
1792  0268 c4540d        	and	a,21517
1793  026b c7540d        	ld	21517,a
1795  026e 2021          	jra	L776
1796  0270               L307:
1797                     ; 589       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
1799  0270 7b01          	ld	a,(OFST+0,sp)
1800  0272 a008          	sub	a,#8
1801  0274 5f            	clrw	x
1802  0275 97            	ld	xl,a
1803  0276 a601          	ld	a,#1
1804  0278 5d            	tnzw	x
1805  0279 2704          	jreq	L201
1806  027b               L401:
1807  027b 48            	sll	a
1808  027c 5a            	decw	x
1809  027d 26fc          	jrne	L401
1810  027f               L201:
1811  027f 43            	cpl	a
1812  0280 c4540c        	and	a,21516
1813  0283 c7540c        	ld	21516,a
1814  0286 2009          	jra	L776
1815  0288               L107:
1816                     ; 594     ADC1->CSR &= (uint8_t) (~Flag);
1818  0288 7b02          	ld	a,(OFST+1,sp)
1819  028a 43            	cpl	a
1820  028b c45400        	and	a,21504
1821  028e c75400        	ld	21504,a
1822  0291               L776:
1823                     ; 596 }
1826  0291 85            	popw	x
1827  0292 81            	ret
1993                     ; 616 ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit)
1993                     ; 617 {
1994                     	switch	.text
1995  0293               _ADC1_GetITStatus:
1997  0293 89            	pushw	x
1998  0294 88            	push	a
1999       00000001      OFST:	set	1
2002                     ; 618   ITStatus itstatus = RESET;
2004                     ; 619   uint8_t temp = 0;
2006                     ; 622   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2008                     ; 624   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
2010  0295 01            	rrwa	x,a
2011  0296 a4f0          	and	a,#240
2012  0298 5f            	clrw	x
2013  0299 02            	rlwa	x,a
2014  029a a30010        	cpw	x,#16
2015  029d 2636          	jrne	L1001
2016                     ; 627     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
2018  029f 7b03          	ld	a,(OFST+2,sp)
2019  02a1 a40f          	and	a,#15
2020  02a3 6b01          	ld	(OFST+0,sp),a
2022                     ; 628     if (temp < 8)
2024  02a5 7b01          	ld	a,(OFST+0,sp)
2025  02a7 a108          	cp	a,#8
2026  02a9 2414          	jruge	L3001
2027                     ; 630       itstatus = (ITStatus)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
2029  02ab 7b01          	ld	a,(OFST+0,sp)
2030  02ad 5f            	clrw	x
2031  02ae 97            	ld	xl,a
2032  02af a601          	ld	a,#1
2033  02b1 5d            	tnzw	x
2034  02b2 2704          	jreq	L011
2035  02b4               L211:
2036  02b4 48            	sll	a
2037  02b5 5a            	decw	x
2038  02b6 26fc          	jrne	L211
2039  02b8               L011:
2040  02b8 c4540d        	and	a,21517
2041  02bb 6b01          	ld	(OFST+0,sp),a
2044  02bd 201d          	jra	L7001
2045  02bf               L3001:
2046                     ; 634       itstatus = (ITStatus)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
2048  02bf 7b01          	ld	a,(OFST+0,sp)
2049  02c1 a008          	sub	a,#8
2050  02c3 5f            	clrw	x
2051  02c4 97            	ld	xl,a
2052  02c5 a601          	ld	a,#1
2053  02c7 5d            	tnzw	x
2054  02c8 2704          	jreq	L411
2055  02ca               L611:
2056  02ca 48            	sll	a
2057  02cb 5a            	decw	x
2058  02cc 26fc          	jrne	L611
2059  02ce               L411:
2060  02ce c4540c        	and	a,21516
2061  02d1 6b01          	ld	(OFST+0,sp),a
2063  02d3 2007          	jra	L7001
2064  02d5               L1001:
2065                     ; 639     itstatus = (ITStatus)(ADC1->CSR & (uint8_t)ITPendingBit);
2067  02d5 c65400        	ld	a,21504
2068  02d8 1403          	and	a,(OFST+2,sp)
2069  02da 6b01          	ld	(OFST+0,sp),a
2071  02dc               L7001:
2072                     ; 641   return ((ITStatus)itstatus);
2074  02dc 7b01          	ld	a,(OFST+0,sp)
2077  02de 5b03          	addw	sp,#3
2078  02e0 81            	ret
2123                     ; 662 void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit)
2123                     ; 663 {
2124                     	switch	.text
2125  02e1               _ADC1_ClearITPendingBit:
2127  02e1 89            	pushw	x
2128  02e2 88            	push	a
2129       00000001      OFST:	set	1
2132                     ; 664   uint8_t temp = 0;
2134                     ; 667   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2136                     ; 669   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
2138  02e3 01            	rrwa	x,a
2139  02e4 a4f0          	and	a,#240
2140  02e6 5f            	clrw	x
2141  02e7 02            	rlwa	x,a
2142  02e8 a30010        	cpw	x,#16
2143  02eb 263a          	jrne	L3301
2144                     ; 672     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
2146  02ed 7b03          	ld	a,(OFST+2,sp)
2147  02ef a40f          	and	a,#15
2148  02f1 6b01          	ld	(OFST+0,sp),a
2150                     ; 673     if (temp < 8)
2152  02f3 7b01          	ld	a,(OFST+0,sp)
2153  02f5 a108          	cp	a,#8
2154  02f7 2416          	jruge	L5301
2155                     ; 675       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
2157  02f9 7b01          	ld	a,(OFST+0,sp)
2158  02fb 5f            	clrw	x
2159  02fc 97            	ld	xl,a
2160  02fd a601          	ld	a,#1
2161  02ff 5d            	tnzw	x
2162  0300 2704          	jreq	L221
2163  0302               L421:
2164  0302 48            	sll	a
2165  0303 5a            	decw	x
2166  0304 26fc          	jrne	L421
2167  0306               L221:
2168  0306 43            	cpl	a
2169  0307 c4540d        	and	a,21517
2170  030a c7540d        	ld	21517,a
2172  030d 2021          	jra	L1401
2173  030f               L5301:
2174                     ; 679       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
2176  030f 7b01          	ld	a,(OFST+0,sp)
2177  0311 a008          	sub	a,#8
2178  0313 5f            	clrw	x
2179  0314 97            	ld	xl,a
2180  0315 a601          	ld	a,#1
2181  0317 5d            	tnzw	x
2182  0318 2704          	jreq	L621
2183  031a               L031:
2184  031a 48            	sll	a
2185  031b 5a            	decw	x
2186  031c 26fc          	jrne	L031
2187  031e               L621:
2188  031e 43            	cpl	a
2189  031f c4540c        	and	a,21516
2190  0322 c7540c        	ld	21516,a
2191  0325 2009          	jra	L1401
2192  0327               L3301:
2193                     ; 684     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ITPendingBit);
2195  0327 7b03          	ld	a,(OFST+2,sp)
2196  0329 43            	cpl	a
2197  032a c45400        	and	a,21504
2198  032d c75400        	ld	21504,a
2199  0330               L1401:
2200                     ; 686 }
2203  0330 5b03          	addw	sp,#3
2204  0332 81            	ret
2217                     	xdef	_ADC1_ClearITPendingBit
2218                     	xdef	_ADC1_GetITStatus
2219                     	xdef	_ADC1_ClearFlag
2220                     	xdef	_ADC1_GetFlagStatus
2221                     	xdef	_ADC1_GetAWDChannelStatus
2222                     	xdef	_ADC1_GetConversionValue
2223                     	xdef	_ADC1_StartConversion
2224                     	xdef	_ADC1_ExternalTriggerConfig
2225                     	xdef	_ADC1_ConversionConfig
2226                     	xdef	_ADC1_SchmittTriggerConfig
2227                     	xdef	_ADC1_PrescalerConfig
2228                     	xdef	_ADC1_ScanModeCmd
2229                     	xdef	_ADC1_Cmd
2230                     	xdef	_ADC1_Init
2231                     	xdef	_ADC1_DeInit
2250                     	end
