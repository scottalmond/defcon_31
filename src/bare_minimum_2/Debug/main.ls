   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  46                     ; 9 main()
  46                     ; 10 {
  48                     	switch	.text
  49  0000               _main:
  53                     ; 11 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
  55  0000 4bf0          	push	#240
  56  0002 4b08          	push	#8
  57  0004 ae5000        	ldw	x,#20480
  58  0007 cd0000        	call	_GPIO_Init
  60  000a 85            	popw	x
  61                     ; 12 	GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
  63  000b 4bf0          	push	#240
  64  000d 4b20          	push	#32
  65  000f ae500f        	ldw	x,#20495
  66  0012 cd0000        	call	_GPIO_Init
  68  0015 85            	popw	x
  69                     ; 13 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_SLOW);
  71  0016 4bd0          	push	#208
  72  0018 4b04          	push	#4
  73  001a ae500f        	ldw	x,#20495
  74  001d cd0000        	call	_GPIO_Init
  76  0020 85            	popw	x
  77                     ; 14 	GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_SLOW);
  79  0021 4bd0          	push	#208
  80  0023 4b08          	push	#8
  81  0025 ae500f        	ldw	x,#20495
  82  0028 cd0000        	call	_GPIO_Init
  84  002b 85            	popw	x
  85                     ; 15 	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
  87  002c 4b08          	push	#8
  88  002e ae5000        	ldw	x,#20480
  89  0031 cd0000        	call	_GPIO_WriteHigh
  91  0034 84            	pop	a
  92                     ; 16 	GPIO_WriteHigh(GPIOD, GPIO_PIN_5);
  94  0035 4b20          	push	#32
  95  0037 ae500f        	ldw	x,#20495
  96  003a cd0000        	call	_GPIO_WriteHigh
  98  003d 84            	pop	a
  99  003e               L12:
 100                     ; 19 		GPIO_WriteLow(GPIOD, GPIO_PIN_3);
 102  003e 4b08          	push	#8
 103  0040 ae500f        	ldw	x,#20495
 104  0043 cd0000        	call	_GPIO_WriteLow
 106  0046 84            	pop	a
 107                     ; 20 		GPIO_WriteHigh(GPIOD, GPIO_PIN_2);
 109  0047 4b04          	push	#4
 110  0049 ae500f        	ldw	x,#20495
 111  004c cd0000        	call	_GPIO_WriteHigh
 113  004f 84            	pop	a
 114                     ; 21 		GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
 116  0050 4b08          	push	#8
 117  0052 ae5000        	ldw	x,#20480
 118  0055 cd0000        	call	_GPIO_WriteHigh
 120  0058 84            	pop	a
 121                     ; 22 		GPIO_WriteHigh(GPIOD, GPIO_PIN_5);
 123  0059 4b20          	push	#32
 124  005b ae500f        	ldw	x,#20495
 125  005e cd0000        	call	_GPIO_WriteHigh
 127  0061 84            	pop	a
 128                     ; 23 		for(iter=0;iter<30000;iter++){}
 130  0062 5f            	clrw	x
 131  0063 bf00          	ldw	_iter,x
 132  0065               L52:
 135  0065 be00          	ldw	x,_iter
 136  0067 1c0001        	addw	x,#1
 137  006a bf00          	ldw	_iter,x
 140  006c 9c            	rvf
 141  006d be00          	ldw	x,_iter
 142  006f a37530        	cpw	x,#30000
 143  0072 2ff1          	jrslt	L52
 144                     ; 24 		GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
 146  0074 4b08          	push	#8
 147  0076 ae500f        	ldw	x,#20495
 148  0079 cd0000        	call	_GPIO_WriteHigh
 150  007c 84            	pop	a
 151                     ; 25 		GPIO_WriteLow(GPIOD, GPIO_PIN_2);
 153  007d 4b04          	push	#4
 154  007f ae500f        	ldw	x,#20495
 155  0082 cd0000        	call	_GPIO_WriteLow
 157  0085 84            	pop	a
 158                     ; 26 		GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 160  0086 4b08          	push	#8
 161  0088 ae5000        	ldw	x,#20480
 162  008b cd0000        	call	_GPIO_WriteLow
 164  008e 84            	pop	a
 165                     ; 27 		GPIO_WriteLow(GPIOD, GPIO_PIN_5);
 167  008f 4b20          	push	#32
 168  0091 ae500f        	ldw	x,#20495
 169  0094 cd0000        	call	_GPIO_WriteLow
 171  0097 84            	pop	a
 172                     ; 28 		for(iter=0;iter<30000;iter++){}
 174  0098 5f            	clrw	x
 175  0099 bf00          	ldw	_iter,x
 176  009b               L33:
 179  009b be00          	ldw	x,_iter
 180  009d 1c0001        	addw	x,#1
 181  00a0 bf00          	ldw	_iter,x
 184  00a2 9c            	rvf
 185  00a3 be00          	ldw	x,_iter
 186  00a5 a37530        	cpw	x,#30000
 187  00a8 2ff1          	jrslt	L33
 189  00aa 2092          	jra	L12
 213                     	xdef	_main
 214                     	switch	.ubsct
 215  0000               _iter:
 216  0000 0000          	ds.b	2
 217                     	xdef	_iter
 218                     	xref	_GPIO_WriteLow
 219                     	xref	_GPIO_WriteHigh
 220                     	xref	_GPIO_Init
 240                     	end
