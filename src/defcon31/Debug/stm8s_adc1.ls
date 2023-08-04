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
 571  003a cd0108        	call	_ADC1_ConversionConfig
 573  003d 84            	pop	a
 574                     ; 105   ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 576  003e 7b05          	ld	a,(OFST+5,sp)
 577  0040 ad25          	call	_ADC1_PrescalerConfig
 579                     ; 110   ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 581  0042 7b07          	ld	a,(OFST+7,sp)
 582  0044 97            	ld	xl,a
 583  0045 7b06          	ld	a,(OFST+6,sp)
 584  0047 95            	ld	xh,a
 585  0048 cd0136        	call	_ADC1_ExternalTriggerConfig
 587                     ; 115   ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 589  004b 7b0a          	ld	a,(OFST+10,sp)
 590  004d 97            	ld	xl,a
 591  004e 7b09          	ld	a,(OFST+9,sp)
 592  0050 95            	ld	xh,a
 593  0051 ad27          	call	_ADC1_SchmittTriggerConfig
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
 698                     ; 214 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 698                     ; 215 {
 699                     	switch	.text
 700  0067               _ADC1_PrescalerConfig:
 702  0067 88            	push	a
 703       00000000      OFST:	set	0
 706                     ; 217   assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 708                     ; 220   ADC1->CR1 &= (uint8_t)(~ADC1_CR1_SPSEL);
 710  0068 c65401        	ld	a,21505
 711  006b a48f          	and	a,#143
 712  006d c75401        	ld	21505,a
 713                     ; 222   ADC1->CR1 |= (uint8_t)(ADC1_Prescaler);
 715  0070 c65401        	ld	a,21505
 716  0073 1a01          	or	a,(OFST+1,sp)
 717  0075 c75401        	ld	21505,a
 718                     ; 223 }
 721  0078 84            	pop	a
 722  0079 81            	ret
 769                     ; 233 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
 769                     ; 234 {
 770                     	switch	.text
 771  007a               _ADC1_SchmittTriggerConfig:
 773  007a 89            	pushw	x
 774       00000000      OFST:	set	0
 777                     ; 236   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 779                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 781                     ; 239   if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
 783  007b 9e            	ld	a,xh
 784  007c a1ff          	cp	a,#255
 785  007e 2620          	jrne	L723
 786                     ; 241     if (NewState != DISABLE)
 788  0080 9f            	ld	a,xl
 789  0081 4d            	tnz	a
 790  0082 270a          	jreq	L133
 791                     ; 243       ADC1->TDRL &= (uint8_t)0x0;
 793  0084 725f5407      	clr	21511
 794                     ; 244       ADC1->TDRH &= (uint8_t)0x0;
 796  0088 725f5406      	clr	21510
 798  008c 2078          	jra	L533
 799  008e               L133:
 800                     ; 248       ADC1->TDRL |= (uint8_t)0xFF;
 802  008e c65407        	ld	a,21511
 803  0091 aaff          	or	a,#255
 804  0093 c75407        	ld	21511,a
 805                     ; 249       ADC1->TDRH |= (uint8_t)0xFF;
 807  0096 c65406        	ld	a,21510
 808  0099 aaff          	or	a,#255
 809  009b c75406        	ld	21510,a
 810  009e 2066          	jra	L533
 811  00a0               L723:
 812                     ; 252   else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
 814  00a0 7b01          	ld	a,(OFST+1,sp)
 815  00a2 a108          	cp	a,#8
 816  00a4 242f          	jruge	L733
 817                     ; 254     if (NewState != DISABLE)
 819  00a6 0d02          	tnz	(OFST+2,sp)
 820  00a8 2716          	jreq	L143
 821                     ; 256       ADC1->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel));
 823  00aa 7b01          	ld	a,(OFST+1,sp)
 824  00ac 5f            	clrw	x
 825  00ad 97            	ld	xl,a
 826  00ae a601          	ld	a,#1
 827  00b0 5d            	tnzw	x
 828  00b1 2704          	jreq	L61
 829  00b3               L02:
 830  00b3 48            	sll	a
 831  00b4 5a            	decw	x
 832  00b5 26fc          	jrne	L02
 833  00b7               L61:
 834  00b7 43            	cpl	a
 835  00b8 c45407        	and	a,21511
 836  00bb c75407        	ld	21511,a
 838  00be 2046          	jra	L533
 839  00c0               L143:
 840                     ; 260       ADC1->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel);
 842  00c0 7b01          	ld	a,(OFST+1,sp)
 843  00c2 5f            	clrw	x
 844  00c3 97            	ld	xl,a
 845  00c4 a601          	ld	a,#1
 846  00c6 5d            	tnzw	x
 847  00c7 2704          	jreq	L22
 848  00c9               L42:
 849  00c9 48            	sll	a
 850  00ca 5a            	decw	x
 851  00cb 26fc          	jrne	L42
 852  00cd               L22:
 853  00cd ca5407        	or	a,21511
 854  00d0 c75407        	ld	21511,a
 855  00d3 2031          	jra	L533
 856  00d5               L733:
 857                     ; 265     if (NewState != DISABLE)
 859  00d5 0d02          	tnz	(OFST+2,sp)
 860  00d7 2718          	jreq	L743
 861                     ; 267       ADC1->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8)));
 863  00d9 7b01          	ld	a,(OFST+1,sp)
 864  00db a008          	sub	a,#8
 865  00dd 5f            	clrw	x
 866  00de 97            	ld	xl,a
 867  00df a601          	ld	a,#1
 868  00e1 5d            	tnzw	x
 869  00e2 2704          	jreq	L62
 870  00e4               L03:
 871  00e4 48            	sll	a
 872  00e5 5a            	decw	x
 873  00e6 26fc          	jrne	L03
 874  00e8               L62:
 875  00e8 43            	cpl	a
 876  00e9 c45406        	and	a,21510
 877  00ec c75406        	ld	21510,a
 879  00ef 2015          	jra	L533
 880  00f1               L743:
 881                     ; 271       ADC1->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8));
 883  00f1 7b01          	ld	a,(OFST+1,sp)
 884  00f3 a008          	sub	a,#8
 885  00f5 5f            	clrw	x
 886  00f6 97            	ld	xl,a
 887  00f7 a601          	ld	a,#1
 888  00f9 5d            	tnzw	x
 889  00fa 2704          	jreq	L23
 890  00fc               L43:
 891  00fc 48            	sll	a
 892  00fd 5a            	decw	x
 893  00fe 26fc          	jrne	L43
 894  0100               L23:
 895  0100 ca5406        	or	a,21510
 896  0103 c75406        	ld	21510,a
 897  0106               L533:
 898                     ; 274 }
 901  0106 85            	popw	x
 902  0107 81            	ret
 959                     ; 286 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
 959                     ; 287 {
 960                     	switch	.text
 961  0108               _ADC1_ConversionConfig:
 963  0108 89            	pushw	x
 964       00000000      OFST:	set	0
 967                     ; 289   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 969                     ; 290   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 971                     ; 291   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 973                     ; 294   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_ALIGN);
 975  0109 72175402      	bres	21506,#3
 976                     ; 296   ADC1->CR2 |= (uint8_t)(ADC1_Align);
 978  010d c65402        	ld	a,21506
 979  0110 1a05          	or	a,(OFST+5,sp)
 980  0112 c75402        	ld	21506,a
 981                     ; 298   if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
 983  0115 9e            	ld	a,xh
 984  0116 a101          	cp	a,#1
 985  0118 2606          	jrne	L104
 986                     ; 301     ADC1->CR1 |= ADC1_CR1_CONT;
 988  011a 72125401      	bset	21505,#1
 990  011e 2004          	jra	L304
 991  0120               L104:
 992                     ; 306     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_CONT);
 994  0120 72135401      	bres	21505,#1
 995  0124               L304:
 996                     ; 310   ADC1->CSR &= (uint8_t)(~ADC1_CSR_CH);
 998  0124 c65400        	ld	a,21504
 999  0127 a4f0          	and	a,#240
1000  0129 c75400        	ld	21504,a
1001                     ; 312   ADC1->CSR |= (uint8_t)(ADC1_Channel);
1003  012c c65400        	ld	a,21504
1004  012f 1a02          	or	a,(OFST+2,sp)
1005  0131 c75400        	ld	21504,a
1006                     ; 313 }
1009  0134 85            	popw	x
1010  0135 81            	ret
1056                     ; 325 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
1056                     ; 326 {
1057                     	switch	.text
1058  0136               _ADC1_ExternalTriggerConfig:
1060  0136 89            	pushw	x
1061       00000000      OFST:	set	0
1064                     ; 328   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
1066                     ; 329   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1068                     ; 332   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTSEL);
1070  0137 c65402        	ld	a,21506
1071  013a a4cf          	and	a,#207
1072  013c c75402        	ld	21506,a
1073                     ; 334   if (NewState != DISABLE)
1075  013f 9f            	ld	a,xl
1076  0140 4d            	tnz	a
1077  0141 2706          	jreq	L724
1078                     ; 337     ADC1->CR2 |= (uint8_t)(ADC1_CR2_EXTTRIG);
1080  0143 721c5402      	bset	21506,#6
1082  0147 2004          	jra	L134
1083  0149               L724:
1084                     ; 342     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTTRIG);
1086  0149 721d5402      	bres	21506,#6
1087  014d               L134:
1088                     ; 346   ADC1->CR2 |= (uint8_t)(ADC1_ExtTrigger);
1090  014d c65402        	ld	a,21506
1091  0150 1a01          	or	a,(OFST+1,sp)
1092  0152 c75402        	ld	21506,a
1093                     ; 347 }
1096  0155 85            	popw	x
1097  0156 81            	ret
1121                     ; 358 void ADC1_StartConversion(void)
1121                     ; 359 {
1122                     	switch	.text
1123  0157               _ADC1_StartConversion:
1127                     ; 360   ADC1->CR1 |= ADC1_CR1_ADON;
1129  0157 72105401      	bset	21505,#0
1130                     ; 361 }
1133  015b 81            	ret
1177                     ; 370 uint16_t ADC1_GetConversionValue(void)
1177                     ; 371 {
1178                     	switch	.text
1179  015c               _ADC1_GetConversionValue:
1181  015c 5205          	subw	sp,#5
1182       00000005      OFST:	set	5
1185                     ; 372   uint16_t temph = 0;
1187                     ; 373   uint8_t templ = 0;
1189                     ; 375   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) // Right alignment 
1191  015e c65402        	ld	a,21506
1192  0161 a508          	bcp	a,#8
1193  0163 2715          	jreq	L564
1194                     ; 378     templ = ADC1->DRL;
1196  0165 c65405        	ld	a,21509
1197  0168 6b03          	ld	(OFST-2,sp),a
1199                     ; 380     temph = ADC1->DRH;
1201  016a c65404        	ld	a,21508
1202  016d 5f            	clrw	x
1203  016e 97            	ld	xl,a
1204  016f 1f04          	ldw	(OFST-1,sp),x
1206                     ; 382     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1208  0171 1e04          	ldw	x,(OFST-1,sp)
1209  0173 7b03          	ld	a,(OFST-2,sp)
1210  0175 02            	rlwa	x,a
1211  0176 1f04          	ldw	(OFST-1,sp),x
1214  0178 2021          	jra	L764
1215  017a               L564:
1216                     ; 387     temph = ADC1->DRH;
1218  017a c65404        	ld	a,21508
1219  017d 5f            	clrw	x
1220  017e 97            	ld	xl,a
1221  017f 1f04          	ldw	(OFST-1,sp),x
1223                     ; 389     templ = ADC1->DRL;
1225  0181 c65405        	ld	a,21509
1226  0184 6b03          	ld	(OFST-2,sp),a
1228                     ; 391     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1230  0186 1e04          	ldw	x,(OFST-1,sp)
1231  0188 4f            	clr	a
1232  0189 02            	rlwa	x,a
1233  018a 1f01          	ldw	(OFST-4,sp),x
1235  018c 7b03          	ld	a,(OFST-2,sp)
1236  018e 97            	ld	xl,a
1237  018f a640          	ld	a,#64
1238  0191 42            	mul	x,a
1239  0192 01            	rrwa	x,a
1240  0193 1a02          	or	a,(OFST-3,sp)
1241  0195 01            	rrwa	x,a
1242  0196 1a01          	or	a,(OFST-4,sp)
1243  0198 01            	rrwa	x,a
1244  0199 1f04          	ldw	(OFST-1,sp),x
1246  019b               L764:
1247                     ; 394   return ((uint16_t)temph);
1249  019b 1e04          	ldw	x,(OFST-1,sp)
1252  019d 5b05          	addw	sp,#5
1253  019f 81            	ret
1319                     ; 502 FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel)
1319                     ; 503 {
1320                     	switch	.text
1321  01a0               _ADC1_GetAWDChannelStatus:
1323  01a0 88            	push	a
1324  01a1 88            	push	a
1325       00000001      OFST:	set	1
1328                     ; 504   uint8_t status = 0;
1330                     ; 507   assert_param(IS_ADC1_CHANNEL_OK(Channel));
1332                     ; 509   if (Channel < (uint8_t)8)
1334  01a2 a108          	cp	a,#8
1335  01a4 2412          	jruge	L325
1336                     ; 511     status = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << Channel));
1338  01a6 5f            	clrw	x
1339  01a7 97            	ld	xl,a
1340  01a8 a601          	ld	a,#1
1341  01aa 5d            	tnzw	x
1342  01ab 2704          	jreq	L05
1343  01ad               L25:
1344  01ad 48            	sll	a
1345  01ae 5a            	decw	x
1346  01af 26fc          	jrne	L25
1347  01b1               L05:
1348  01b1 c4540d        	and	a,21517
1349  01b4 6b01          	ld	(OFST+0,sp),a
1352  01b6 2014          	jra	L525
1353  01b8               L325:
1354                     ; 515     status = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8)));
1356  01b8 7b02          	ld	a,(OFST+1,sp)
1357  01ba a008          	sub	a,#8
1358  01bc 5f            	clrw	x
1359  01bd 97            	ld	xl,a
1360  01be a601          	ld	a,#1
1361  01c0 5d            	tnzw	x
1362  01c1 2704          	jreq	L45
1363  01c3               L65:
1364  01c3 48            	sll	a
1365  01c4 5a            	decw	x
1366  01c5 26fc          	jrne	L65
1367  01c7               L45:
1368  01c7 c4540c        	and	a,21516
1369  01ca 6b01          	ld	(OFST+0,sp),a
1371  01cc               L525:
1372                     ; 518   return ((FlagStatus)status);
1374  01cc 7b01          	ld	a,(OFST+0,sp)
1377  01ce 85            	popw	x
1378  01cf 81            	ret
1536                     ; 527 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
1536                     ; 528 {
1537                     	switch	.text
1538  01d0               _ADC1_GetFlagStatus:
1540  01d0 88            	push	a
1541  01d1 88            	push	a
1542       00000001      OFST:	set	1
1545                     ; 529   uint8_t flagstatus = 0;
1547                     ; 530   uint8_t temp = 0;
1549                     ; 533   assert_param(IS_ADC1_FLAG_OK(Flag));
1551                     ; 535   if ((Flag & 0x0F) == 0x01)
1553  01d2 a40f          	and	a,#15
1554  01d4 a101          	cp	a,#1
1555  01d6 2609          	jrne	L516
1556                     ; 538     flagstatus = (uint8_t)(ADC1->CR3 & ADC1_CR3_OVR);
1558  01d8 c65403        	ld	a,21507
1559  01db a440          	and	a,#64
1560  01dd 6b01          	ld	(OFST+0,sp),a
1563  01df 2045          	jra	L716
1564  01e1               L516:
1565                     ; 540   else if ((Flag & 0xF0) == 0x10)
1567  01e1 7b02          	ld	a,(OFST+1,sp)
1568  01e3 a4f0          	and	a,#240
1569  01e5 a110          	cp	a,#16
1570  01e7 2636          	jrne	L126
1571                     ; 543     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1573  01e9 7b02          	ld	a,(OFST+1,sp)
1574  01eb a40f          	and	a,#15
1575  01ed 6b01          	ld	(OFST+0,sp),a
1577                     ; 544     if (temp < 8)
1579  01ef 7b01          	ld	a,(OFST+0,sp)
1580  01f1 a108          	cp	a,#8
1581  01f3 2414          	jruge	L326
1582                     ; 546       flagstatus = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1584  01f5 7b01          	ld	a,(OFST+0,sp)
1585  01f7 5f            	clrw	x
1586  01f8 97            	ld	xl,a
1587  01f9 a601          	ld	a,#1
1588  01fb 5d            	tnzw	x
1589  01fc 2704          	jreq	L26
1590  01fe               L46:
1591  01fe 48            	sll	a
1592  01ff 5a            	decw	x
1593  0200 26fc          	jrne	L46
1594  0202               L26:
1595  0202 c4540d        	and	a,21517
1596  0205 6b01          	ld	(OFST+0,sp),a
1599  0207 201d          	jra	L716
1600  0209               L326:
1601                     ; 550       flagstatus = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1603  0209 7b01          	ld	a,(OFST+0,sp)
1604  020b a008          	sub	a,#8
1605  020d 5f            	clrw	x
1606  020e 97            	ld	xl,a
1607  020f a601          	ld	a,#1
1608  0211 5d            	tnzw	x
1609  0212 2704          	jreq	L66
1610  0214               L07:
1611  0214 48            	sll	a
1612  0215 5a            	decw	x
1613  0216 26fc          	jrne	L07
1614  0218               L66:
1615  0218 c4540c        	and	a,21516
1616  021b 6b01          	ld	(OFST+0,sp),a
1618  021d 2007          	jra	L716
1619  021f               L126:
1620                     ; 555     flagstatus = (uint8_t)(ADC1->CSR & Flag);
1622  021f c65400        	ld	a,21504
1623  0222 1402          	and	a,(OFST+1,sp)
1624  0224 6b01          	ld	(OFST+0,sp),a
1626  0226               L716:
1627                     ; 557   return ((FlagStatus)flagstatus);
1629  0226 7b01          	ld	a,(OFST+0,sp)
1632  0228 85            	popw	x
1633  0229 81            	ret
1677                     ; 567 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
1677                     ; 568 {
1678                     	switch	.text
1679  022a               _ADC1_ClearFlag:
1681  022a 88            	push	a
1682  022b 88            	push	a
1683       00000001      OFST:	set	1
1686                     ; 569   uint8_t temp = 0;
1688                     ; 572   assert_param(IS_ADC1_FLAG_OK(Flag));
1690                     ; 574   if ((Flag & 0x0F) == 0x01)
1692  022c a40f          	and	a,#15
1693  022e a101          	cp	a,#1
1694  0230 2606          	jrne	L356
1695                     ; 577     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_OVR);
1697  0232 721d5403      	bres	21507,#6
1699  0236 204b          	jra	L556
1700  0238               L356:
1701                     ; 579   else if ((Flag & 0xF0) == 0x10)
1703  0238 7b02          	ld	a,(OFST+1,sp)
1704  023a a4f0          	and	a,#240
1705  023c a110          	cp	a,#16
1706  023e 263a          	jrne	L756
1707                     ; 582     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1709  0240 7b02          	ld	a,(OFST+1,sp)
1710  0242 a40f          	and	a,#15
1711  0244 6b01          	ld	(OFST+0,sp),a
1713                     ; 583     if (temp < 8)
1715  0246 7b01          	ld	a,(OFST+0,sp)
1716  0248 a108          	cp	a,#8
1717  024a 2416          	jruge	L166
1718                     ; 585       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
1720  024c 7b01          	ld	a,(OFST+0,sp)
1721  024e 5f            	clrw	x
1722  024f 97            	ld	xl,a
1723  0250 a601          	ld	a,#1
1724  0252 5d            	tnzw	x
1725  0253 2704          	jreq	L47
1726  0255               L67:
1727  0255 48            	sll	a
1728  0256 5a            	decw	x
1729  0257 26fc          	jrne	L67
1730  0259               L47:
1731  0259 43            	cpl	a
1732  025a c4540d        	and	a,21517
1733  025d c7540d        	ld	21517,a
1735  0260 2021          	jra	L556
1736  0262               L166:
1737                     ; 589       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
1739  0262 7b01          	ld	a,(OFST+0,sp)
1740  0264 a008          	sub	a,#8
1741  0266 5f            	clrw	x
1742  0267 97            	ld	xl,a
1743  0268 a601          	ld	a,#1
1744  026a 5d            	tnzw	x
1745  026b 2704          	jreq	L001
1746  026d               L201:
1747  026d 48            	sll	a
1748  026e 5a            	decw	x
1749  026f 26fc          	jrne	L201
1750  0271               L001:
1751  0271 43            	cpl	a
1752  0272 c4540c        	and	a,21516
1753  0275 c7540c        	ld	21516,a
1754  0278 2009          	jra	L556
1755  027a               L756:
1756                     ; 594     ADC1->CSR &= (uint8_t) (~Flag);
1758  027a 7b02          	ld	a,(OFST+1,sp)
1759  027c 43            	cpl	a
1760  027d c45400        	and	a,21504
1761  0280 c75400        	ld	21504,a
1762  0283               L556:
1763                     ; 596 }
1766  0283 85            	popw	x
1767  0284 81            	ret
1933                     ; 616 ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit)
1933                     ; 617 {
1934                     	switch	.text
1935  0285               _ADC1_GetITStatus:
1937  0285 89            	pushw	x
1938  0286 88            	push	a
1939       00000001      OFST:	set	1
1942                     ; 618   ITStatus itstatus = RESET;
1944                     ; 619   uint8_t temp = 0;
1946                     ; 622   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
1948                     ; 624   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
1950  0287 01            	rrwa	x,a
1951  0288 a4f0          	and	a,#240
1952  028a 5f            	clrw	x
1953  028b 02            	rlwa	x,a
1954  028c a30010        	cpw	x,#16
1955  028f 2636          	jrne	L757
1956                     ; 627     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
1958  0291 7b03          	ld	a,(OFST+2,sp)
1959  0293 a40f          	and	a,#15
1960  0295 6b01          	ld	(OFST+0,sp),a
1962                     ; 628     if (temp < 8)
1964  0297 7b01          	ld	a,(OFST+0,sp)
1965  0299 a108          	cp	a,#8
1966  029b 2414          	jruge	L167
1967                     ; 630       itstatus = (ITStatus)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1969  029d 7b01          	ld	a,(OFST+0,sp)
1970  029f 5f            	clrw	x
1971  02a0 97            	ld	xl,a
1972  02a1 a601          	ld	a,#1
1973  02a3 5d            	tnzw	x
1974  02a4 2704          	jreq	L601
1975  02a6               L011:
1976  02a6 48            	sll	a
1977  02a7 5a            	decw	x
1978  02a8 26fc          	jrne	L011
1979  02aa               L601:
1980  02aa c4540d        	and	a,21517
1981  02ad 6b01          	ld	(OFST+0,sp),a
1984  02af 201d          	jra	L567
1985  02b1               L167:
1986                     ; 634       itstatus = (ITStatus)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1988  02b1 7b01          	ld	a,(OFST+0,sp)
1989  02b3 a008          	sub	a,#8
1990  02b5 5f            	clrw	x
1991  02b6 97            	ld	xl,a
1992  02b7 a601          	ld	a,#1
1993  02b9 5d            	tnzw	x
1994  02ba 2704          	jreq	L211
1995  02bc               L411:
1996  02bc 48            	sll	a
1997  02bd 5a            	decw	x
1998  02be 26fc          	jrne	L411
1999  02c0               L211:
2000  02c0 c4540c        	and	a,21516
2001  02c3 6b01          	ld	(OFST+0,sp),a
2003  02c5 2007          	jra	L567
2004  02c7               L757:
2005                     ; 639     itstatus = (ITStatus)(ADC1->CSR & (uint8_t)ITPendingBit);
2007  02c7 c65400        	ld	a,21504
2008  02ca 1403          	and	a,(OFST+2,sp)
2009  02cc 6b01          	ld	(OFST+0,sp),a
2011  02ce               L567:
2012                     ; 641   return ((ITStatus)itstatus);
2014  02ce 7b01          	ld	a,(OFST+0,sp)
2017  02d0 5b03          	addw	sp,#3
2018  02d2 81            	ret
2063                     ; 662 void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit)
2063                     ; 663 {
2064                     	switch	.text
2065  02d3               _ADC1_ClearITPendingBit:
2067  02d3 89            	pushw	x
2068  02d4 88            	push	a
2069       00000001      OFST:	set	1
2072                     ; 664   uint8_t temp = 0;
2074                     ; 667   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2076                     ; 669   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
2078  02d5 01            	rrwa	x,a
2079  02d6 a4f0          	and	a,#240
2080  02d8 5f            	clrw	x
2081  02d9 02            	rlwa	x,a
2082  02da a30010        	cpw	x,#16
2083  02dd 263a          	jrne	L1101
2084                     ; 672     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
2086  02df 7b03          	ld	a,(OFST+2,sp)
2087  02e1 a40f          	and	a,#15
2088  02e3 6b01          	ld	(OFST+0,sp),a
2090                     ; 673     if (temp < 8)
2092  02e5 7b01          	ld	a,(OFST+0,sp)
2093  02e7 a108          	cp	a,#8
2094  02e9 2416          	jruge	L3101
2095                     ; 675       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
2097  02eb 7b01          	ld	a,(OFST+0,sp)
2098  02ed 5f            	clrw	x
2099  02ee 97            	ld	xl,a
2100  02ef a601          	ld	a,#1
2101  02f1 5d            	tnzw	x
2102  02f2 2704          	jreq	L021
2103  02f4               L221:
2104  02f4 48            	sll	a
2105  02f5 5a            	decw	x
2106  02f6 26fc          	jrne	L221
2107  02f8               L021:
2108  02f8 43            	cpl	a
2109  02f9 c4540d        	and	a,21517
2110  02fc c7540d        	ld	21517,a
2112  02ff 2021          	jra	L7101
2113  0301               L3101:
2114                     ; 679       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
2116  0301 7b01          	ld	a,(OFST+0,sp)
2117  0303 a008          	sub	a,#8
2118  0305 5f            	clrw	x
2119  0306 97            	ld	xl,a
2120  0307 a601          	ld	a,#1
2121  0309 5d            	tnzw	x
2122  030a 2704          	jreq	L421
2123  030c               L621:
2124  030c 48            	sll	a
2125  030d 5a            	decw	x
2126  030e 26fc          	jrne	L621
2127  0310               L421:
2128  0310 43            	cpl	a
2129  0311 c4540c        	and	a,21516
2130  0314 c7540c        	ld	21516,a
2131  0317 2009          	jra	L7101
2132  0319               L1101:
2133                     ; 684     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ITPendingBit);
2135  0319 7b03          	ld	a,(OFST+2,sp)
2136  031b 43            	cpl	a
2137  031c c45400        	and	a,21504
2138  031f c75400        	ld	21504,a
2139  0322               L7101:
2140                     ; 686 }
2143  0322 5b03          	addw	sp,#3
2144  0324 81            	ret
2157                     	xdef	_ADC1_ClearITPendingBit
2158                     	xdef	_ADC1_GetITStatus
2159                     	xdef	_ADC1_ClearFlag
2160                     	xdef	_ADC1_GetFlagStatus
2161                     	xdef	_ADC1_GetAWDChannelStatus
2162                     	xdef	_ADC1_GetConversionValue
2163                     	xdef	_ADC1_StartConversion
2164                     	xdef	_ADC1_ExternalTriggerConfig
2165                     	xdef	_ADC1_ConversionConfig
2166                     	xdef	_ADC1_SchmittTriggerConfig
2167                     	xdef	_ADC1_PrescalerConfig
2168                     	xdef	_ADC1_Cmd
2169                     	xdef	_ADC1_Init
2170                     	xdef	_ADC1_DeInit
2189                     	end
