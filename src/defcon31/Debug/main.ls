   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
 111                     ; 23  unsigned int ADC_Read(ADC_CHANNEL_TypeDef ADC_Channel_Number)
 111                     ; 24  {
 113                     	switch	.text
 114  0000               _ADC_Read:
 116  0000 88            	push	a
 117  0001 89            	pushw	x
 118       00000002      OFST:	set	2
 121                     ; 25    unsigned int result = 0;
 123                     ; 27 	 ADC1_DeInit();
 125  0002 cd0000        	call	_ADC1_DeInit
 127                     ; 29 	 ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 127                     ; 30              ADC_Channel_Number,
 127                     ; 31              ADC1_PRESSEL_FCPU_D18, 
 127                     ; 32              ADC1_EXTTRIG_TIM, 
 127                     ; 33              DISABLE, 
 127                     ; 34              ADC1_ALIGN_RIGHT, 
 127                     ; 35              ADC1_SCHMITTTRIG_ALL, 
 127                     ; 36              DISABLE);
 129  0005 4b00          	push	#0
 130  0007 4bff          	push	#255
 131  0009 4b08          	push	#8
 132  000b 4b00          	push	#0
 133  000d 4b00          	push	#0
 134  000f 4b70          	push	#112
 135  0011 7b09          	ld	a,(OFST+7,sp)
 136  0013 ae0100        	ldw	x,#256
 137  0016 97            	ld	xl,a
 138  0017 cd0000        	call	_ADC1_Init
 140  001a 5b06          	addw	sp,#6
 141                     ; 38    ADC1_Cmd(ENABLE);
 143  001c a601          	ld	a,#1
 144  001e cd0000        	call	_ADC1_Cmd
 146                     ; 41 	ADC1_StartConversion();
 148  0021 cd0000        	call	_ADC1_StartConversion
 151  0024               L35:
 152                     ; 42 	while(ADC1_GetFlagStatus(ADC1_FLAG_EOC) == FALSE);
 154  0024 a680          	ld	a,#128
 155  0026 cd0000        	call	_ADC1_GetFlagStatus
 157  0029 4d            	tnz	a
 158  002a 27f8          	jreq	L35
 159                     ; 44   result = ADC1_GetConversionValue();
 161  002c cd0000        	call	_ADC1_GetConversionValue
 163  002f 1f01          	ldw	(OFST-1,sp),x
 165                     ; 45   ADC1_ClearFlag(ADC1_FLAG_EOC);
 167  0031 a680          	ld	a,#128
 168  0033 cd0000        	call	_ADC1_ClearFlag
 170                     ; 47 	ADC1_DeInit();
 172  0036 cd0000        	call	_ADC1_DeInit
 174                     ; 49 	return result; 
 176  0039 1e01          	ldw	x,(OFST-1,sp)
 179  003b 5b03          	addw	sp,#3
 180  003d 81            	ret
 227                     ; 13 int main()
 227                     ; 14 {
 228                     	switch	.text
 229  003e               _main:
 233                     ; 15 	setup_main();
 235  003e cd0000        	call	_setup_main
 237  0041               L57:
 238                     ; 18 		if(is_application_valid()) run_application();
 240  0041 cd0000        	call	_is_application_valid
 242  0044 4d            	tnz	a
 243  0045 2703          	jreq	L101
 246  0047 cd0000        	call	_run_application
 248  004a               L101:
 249                     ; 19 		if(is_developer_valid()) run_developer();
 251  004a cd0000        	call	_is_developer_valid
 253  004d 4d            	tnz	a
 254  004e 2703          	jreq	L301
 257  0050 cd0000        	call	_run_developer
 259  0053               L301:
 260                     ; 20 		if(get_button_event(0,1)) run_sleep();//if long press on left button, enter sleep mode
 262  0053 ae0001        	ldw	x,#1
 263  0056 cd0000        	call	_get_button_event
 265  0059 4d            	tnz	a
 266  005a 27e5          	jreq	L57
 269  005c cd0000        	call	_run_sleep
 271  005f 20e0          	jra	L57
 284                     	xdef	_main
 285                     	xref	_run_sleep
 286                     	xref	_run_developer
 287                     	xref	_run_application
 288                     	xref	_get_button_event
 289                     	xref	_is_developer_valid
 290                     	xref	_setup_main
 291                     	xref	_is_application_valid
 292                     	xdef	_ADC_Read
 293                     	xref	_ADC1_ClearFlag
 294                     	xref	_ADC1_GetFlagStatus
 295                     	xref	_ADC1_GetConversionValue
 296                     	xref	_ADC1_StartConversion
 297                     	xref	_ADC1_Cmd
 298                     	xref	_ADC1_Init
 299                     	xref	_ADC1_DeInit
 318                     	end
