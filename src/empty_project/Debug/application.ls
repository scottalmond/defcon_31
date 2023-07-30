   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  14                     .const:	section	.text
  15  0000               _SUBMENU_COUNT:
  16  0000 03            	dc.b	3
  17  0001               _SUBMENU_TIME_OUT_MS:
  18  0001 00            	dc.b	0
  19  0002               _SCREEN_SAVER_COUNT_PONY:
  20  0002 03            	dc.b	3
  21  0003               _SCREEN_SAVER_COUNT_SPACE:
  22  0003 02            	dc.b	2
  23  0004               _SCREEN_SAVER_DURATION_MS:
  24  0004 8000          	dc.w	-32768
  55                     ; 11 void setup_application()
  55                     ; 12 {
  57                     	switch	.text
  58  0000               _setup_application:
  62                     ; 13 	setup_serial(0,0);
  64  0000 5f            	clrw	x
  65  0001 cd0000        	call	_setup_serial
  67                     ; 14 	clear_button_events();
  69  0004 cd0000        	call	_clear_button_events
  71                     ; 15 }
  74  0007 81            	ret
 139                     ; 17 void run_application()
 139                     ; 18 {
 140                     	switch	.text
 141  0008               _run_application:
 143  0008 5206          	subw	sp,#6
 144       00000006      OFST:	set	6
 147                     ; 21 	u32 show_top_menu_since_ms=0;
 149  000a ae0000        	ldw	x,#0
 150  000d 1f03          	ldw	(OFST-3,sp),x
 151  000f ae0000        	ldw	x,#0
 152  0012 1f01          	ldw	(OFST-5,sp),x
 154                     ; 22 	setup_application();
 156  0014 adea          	call	_setup_application
 159  0016 207b          	jra	L75
 160  0018               L55:
 161                     ; 25 		if(clear_button_event(0,0)) submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
 163  0018 5f            	clrw	x
 164  0019 cd0000        	call	_clear_button_event
 166  001c 4d            	tnz	a
 167  001d 270e          	jreq	L36
 170  001f 7b05          	ld	a,(OFST-1,sp)
 171  0021 5f            	clrw	x
 172  0022 97            	ld	xl,a
 173  0023 5c            	incw	x
 174  0024 a603          	ld	a,#3
 175  0026 cd0000        	call	c_smodx
 177  0029 01            	rrwa	x,a
 178  002a 6b05          	ld	(OFST-1,sp),a
 179  002c 02            	rlwa	x,a
 181  002d               L36:
 182                     ; 26 		if(is_button_down(0)) show_top_menu_since_ms=millis();
 184  002d 4f            	clr	a
 185  002e cd0000        	call	_is_button_down
 187  0031 4d            	tnz	a
 188  0032 270a          	jreq	L56
 191  0034 cd0000        	call	_millis
 193  0037 96            	ldw	x,sp
 194  0038 1c0001        	addw	x,#OFST-5
 195  003b cd0000        	call	c_rtol
 198  003e               L56:
 199                     ; 27 		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
 201  003e cd0000        	call	_millis
 203  0041 96            	ldw	x,sp
 204  0042 1c0001        	addw	x,#OFST-5
 205  0045 cd0000        	call	c_lcmp
 207  0048 2426          	jruge	L76
 208                     ; 29 			for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,submenu_index<<13,255);//set all LEDs to the same color
 210  004a 0f06          	clr	(OFST+0,sp)
 212  004c               L17:
 215  004c 4bff          	push	#255
 216  004e 7b06          	ld	a,(OFST+0,sp)
 217  0050 5f            	clrw	x
 218  0051 97            	ld	xl,a
 219  0052 9f            	ld	a,xl
 220  0053 4e            	swap	a
 221  0054 48            	sll	a
 222  0055 a4e0          	and	a,#224
 223  0057 5f            	clrw	x
 224  0058 95            	ld	xh,a
 225  0059 89            	pushw	x
 226  005a 7b09          	ld	a,(OFST+3,sp)
 227  005c cd0000        	call	_set_hue
 229  005f 5b03          	addw	sp,#3
 232  0061 0c06          	inc	(OFST+0,sp)
 236  0063 7b06          	ld	a,(OFST+0,sp)
 237  0065 a10a          	cp	a,#10
 238  0067 25e3          	jrult	L17
 239                     ; 30 			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs and the status LED to give feedback about the button push to the user
 241  0069 a60b          	ld	a,#11
 242  006b cd0000        	call	_flush_leds
 245  006e 2023          	jra	L75
 246  0070               L76:
 247                     ; 32 			show_top_menu_since_ms=0;
 249  0070 ae0000        	ldw	x,#0
 250  0073 1f03          	ldw	(OFST-3,sp),x
 251  0075 ae0000        	ldw	x,#0
 252  0078 1f01          	ldw	(OFST-5,sp),x
 254                     ; 33 			switch(submenu_index)
 256  007a 7b05          	ld	a,(OFST-1,sp)
 258                     ; 37 				case 2:{ show_puzzle(); }break;
 259  007c 4d            	tnz	a
 260  007d 2708          	jreq	L12
 261  007f 4a            	dec	a
 262  0080 2709          	jreq	L32
 263  0082 4a            	dec	a
 264  0083 270b          	jreq	L52
 265  0085 200c          	jra	L75
 266  0087               L12:
 267                     ; 35 				case 0:{ show_screen_savers(); }break;
 269  0087 ad29          	call	_show_screen_savers
 273  0089 2008          	jra	L75
 274  008b               L32:
 275                     ; 36 				case 1:{ show_cyclone(); }break;
 277  008b cd0247        	call	_show_cyclone
 281  008e 2003          	jra	L75
 282  0090               L52:
 283                     ; 37 				case 2:{ show_puzzle(); }break;
 285  0090 cd024e        	call	_show_puzzle
 289  0093               L301:
 290  0093               L75:
 291                     ; 23 	while(is_application_valid())
 293  0093 cd0000        	call	_is_application_valid
 295  0096 4d            	tnz	a
 296  0097 2703cc0018    	jrne	L55
 297                     ; 41 }
 300  009c 5b06          	addw	sp,#6
 301  009e 81            	ret
 347                     ; 43 bool is_submenu_valid()
 347                     ; 44 {
 348                     	switch	.text
 349  009f               _is_submenu_valid:
 353                     ; 45 	return is_application_valid()&&!is_button_down(0);
 355  009f cd0000        	call	_is_application_valid
 357  00a2 4d            	tnz	a
 358  00a3 270b          	jreq	L21
 359  00a5 4f            	clr	a
 360  00a6 cd0000        	call	_is_button_down
 362  00a9 4d            	tnz	a
 363  00aa 2604          	jrne	L21
 364  00ac a601          	ld	a,#1
 365  00ae 2001          	jra	L41
 366  00b0               L21:
 367  00b0 4f            	clr	a
 368  00b1               L41:
 371  00b1 81            	ret
 425                     ; 48 void show_screen_savers()
 425                     ; 49 {
 426                     	switch	.text
 427  00b2               _show_screen_savers:
 429  00b2 89            	pushw	x
 430       00000002      OFST:	set	2
 433                     ; 50 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 435  00b3 a601          	ld	a,#1
 436  00b5 6b01          	ld	(OFST-1,sp),a
 438                     ; 51 	u8 screen_saver_index=0;
 440  00b7 0f02          	clr	(OFST+0,sp)
 443  00b9 206e          	jra	L361
 444  00bb               L161:
 445                     ; 54 		if(is_auto_cycle)
 447  00bb 0d01          	tnz	(OFST-1,sp)
 448  00bd 2719          	jreq	L761
 449                     ; 56 			screen_saver_index=millis()/SCREEN_SAVER_DURATION_MS;
 451  00bf cd0000        	call	_millis
 453  00c2 a60f          	ld	a,#15
 454  00c4 cd0000        	call	c_lursh
 456  00c7 b603          	ld	a,c_lreg+3
 457  00c9 6b02          	ld	(OFST+0,sp),a
 459                     ; 57 			if(clear_button_event(1,1)) is_auto_cycle=0;
 461  00cb ae0101        	ldw	x,#257
 462  00ce cd0000        	call	_clear_button_event
 464  00d1 4d            	tnz	a
 465  00d2 271c          	jreq	L371
 468  00d4 0f01          	clr	(OFST-1,sp)
 470  00d6 2018          	jra	L371
 471  00d8               L761:
 472                     ; 59 			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
 474  00d8 ae0100        	ldw	x,#256
 475  00db cd0000        	call	_clear_button_event
 477  00de 4d            	tnz	a
 478  00df 2702          	jreq	L571
 481  00e1 0c02          	inc	(OFST+0,sp)
 483  00e3               L571:
 484                     ; 60 			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
 486  00e3 ae0101        	ldw	x,#257
 487  00e6 cd0000        	call	_clear_button_event
 489  00e9 4d            	tnz	a
 490  00ea 2704          	jreq	L371
 493  00ec a601          	ld	a,#1
 494  00ee 6b01          	ld	(OFST-1,sp),a
 496  00f0               L371:
 497                     ; 62 		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(is_space_sao()?SCREEN_SAVER_COUNT_SPACE:0);
 499  00f0 cd0000        	call	_is_space_sao
 501  00f3 4d            	tnz	a
 502  00f4 2708          	jreq	L02
 503  00f6 ae0005        	ldw	x,#5
 504  00f9 9f            	ld	a,xl
 505  00fa 5f            	clrw	x
 506  00fb 97            	ld	xl,a
 507  00fc 2003          	jra	L22
 508  00fe               L02:
 509  00fe ae0003        	ldw	x,#3
 510  0101               L22:
 511  0101 7b02          	ld	a,(OFST+0,sp)
 512  0103 51            	exgw	x,y
 513  0104 5f            	clrw	x
 514  0105 97            	ld	xl,a
 515  0106 65            	divw	x,y
 516  0107 909f          	ld	a,yl
 517  0109 6b02          	ld	(OFST+0,sp),a
 519                     ; 63 		switch(screen_saver_index)
 521  010b 7b02          	ld	a,(OFST+0,sp)
 523                     ; 69 			case 4:{  }break;
 524  010d 4d            	tnz	a
 525  010e 270e          	jreq	L521
 526  0110 4a            	dec	a
 527  0111 270f          	jreq	L721
 528  0113 4a            	dec	a
 529  0114 2711          	jreq	L131
 530  0116 4a            	dec	a
 531  0117 2710          	jreq	L361
 532  0119 4a            	dec	a
 533  011a 270d          	jreq	L361
 534  011c 200b          	jra	L361
 535  011e               L521:
 536                     ; 65 			case 0:{ set_frame_rainbow(); }break;
 538  011e ad11          	call	_set_frame_rainbow
 542  0120 2007          	jra	L361
 543  0122               L721:
 544                     ; 66 			case 1:{ set_frame_blink(); }break;
 546  0122 cd01cf        	call	_set_frame_blink
 550  0125 2002          	jra	L361
 551  0127               L131:
 552                     ; 67 			case 2:{ set_frame_audio(); }break;
 554  0127 ad4c          	call	_set_frame_audio
 558  0129               L302:
 559  0129               L361:
 560                     ; 52 	while(is_submenu_valid())
 562  0129 cd009f        	call	_is_submenu_valid
 564  012c 4d            	tnz	a
 565  012d 268c          	jrne	L161
 566                     ; 72 }
 569  012f 85            	popw	x
 570  0130 81            	ret
 607                     ; 74 void set_frame_rainbow()
 607                     ; 75 {
 608                     	switch	.text
 609  0131               _set_frame_rainbow:
 611  0131 5205          	subw	sp,#5
 612       00000005      OFST:	set	5
 615                     ; 77 	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,(u16)(millis()*32+(0xFFFF/10)*iter),255);
 617  0133 0f05          	clr	(OFST+0,sp)
 619  0135               L322:
 622  0135 4bff          	push	#255
 623  0137 7b06          	ld	a,(OFST+1,sp)
 624  0139 5f            	clrw	x
 625  013a 97            	ld	xl,a
 626  013b 90ae1999      	ldw	y,#6553
 627  013f cd0000        	call	c_imul
 629  0142 cd0000        	call	c_uitolx
 631  0145 96            	ldw	x,sp
 632  0146 1c0002        	addw	x,#OFST-3
 633  0149 cd0000        	call	c_rtol
 636  014c cd0000        	call	_millis
 638  014f a605          	ld	a,#5
 639  0151 cd0000        	call	c_llsh
 641  0154 96            	ldw	x,sp
 642  0155 1c0002        	addw	x,#OFST-3
 643  0158 cd0000        	call	c_ladd
 645  015b be02          	ldw	x,c_lreg+2
 646  015d 89            	pushw	x
 647  015e 7b08          	ld	a,(OFST+3,sp)
 648  0160 cd0000        	call	_set_hue
 650  0163 5b03          	addw	sp,#3
 653  0165 0c05          	inc	(OFST+0,sp)
 657  0167 7b05          	ld	a,(OFST+0,sp)
 658  0169 a10a          	cp	a,#10
 659  016b 25c8          	jrult	L322
 660                     ; 78 	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
 662  016d a615          	ld	a,#21
 663  016f cd0000        	call	_flush_leds
 665                     ; 79 }
 668  0172 5b05          	addw	sp,#5
 669  0174 81            	ret
 715                     ; 81 void set_frame_audio()
 715                     ; 82 {
 716                     	switch	.text
 717  0175               _set_frame_audio:
 719  0175 89            	pushw	x
 720       00000002      OFST:	set	2
 723                     ; 84 	audio_level=get_audio_level()/2;
 725  0176 cd0000        	call	_get_audio_level
 727  0179 44            	srl	a
 728  017a 6b01          	ld	(OFST-1,sp),a
 730                     ; 85 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 732  017c 0f02          	clr	(OFST+0,sp)
 734  017e               L352:
 735                     ; 87 		if(audio_level>iter)
 737  017e 7b01          	ld	a,(OFST-1,sp)
 738  0180 1102          	cp	a,(OFST+0,sp)
 739  0182 233c          	jrule	L162
 740                     ; 89 			if(iter>7)
 742  0184 7b02          	ld	a,(OFST+0,sp)
 743  0186 a108          	cp	a,#8
 744  0188 250c          	jrult	L362
 745                     ; 91 				set_rgb(iter,0,255);
 747  018a 4bff          	push	#255
 748  018c 7b03          	ld	a,(OFST+1,sp)
 749  018e 5f            	clrw	x
 750  018f 95            	ld	xh,a
 751  0190 cd0000        	call	_set_rgb
 753  0193 84            	pop	a
 755  0194 202a          	jra	L162
 756  0196               L362:
 757                     ; 93 			else if(iter>4)
 759  0196 7b02          	ld	a,(OFST+0,sp)
 760  0198 a105          	cp	a,#5
 761  019a 2518          	jrult	L762
 762                     ; 95 				set_rgb(iter,0,128);
 764  019c 4b80          	push	#128
 765  019e 7b03          	ld	a,(OFST+1,sp)
 766  01a0 5f            	clrw	x
 767  01a1 95            	ld	xh,a
 768  01a2 cd0000        	call	_set_rgb
 770  01a5 84            	pop	a
 771                     ; 96 				set_rgb(iter,1,128);
 773  01a6 4b80          	push	#128
 774  01a8 7b03          	ld	a,(OFST+1,sp)
 775  01aa ae0001        	ldw	x,#1
 776  01ad 95            	ld	xh,a
 777  01ae cd0000        	call	_set_rgb
 779  01b1 84            	pop	a
 781  01b2 200c          	jra	L162
 782  01b4               L762:
 783                     ; 99 				set_rgb(iter,1,255);
 785  01b4 4bff          	push	#255
 786  01b6 7b03          	ld	a,(OFST+1,sp)
 787  01b8 ae0001        	ldw	x,#1
 788  01bb 95            	ld	xh,a
 789  01bc cd0000        	call	_set_rgb
 791  01bf 84            	pop	a
 792  01c0               L162:
 793                     ; 85 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 795  01c0 0c02          	inc	(OFST+0,sp)
 799  01c2 7b02          	ld	a,(OFST+0,sp)
 800  01c4 a10a          	cp	a,#10
 801  01c6 25b6          	jrult	L352
 802                     ; 103 	flush_leds(RGB_LED_COUNT+3+1);//3 yellow LEDs is double-count, 1 for status led for button pushes
 804  01c8 a60e          	ld	a,#14
 805  01ca cd0000        	call	_flush_leds
 807                     ; 104 }
 810  01cd 85            	popw	x
 811  01ce 81            	ret
 906                     ; 106 void set_frame_blink()
 906                     ; 107 {
 907                     	switch	.text
 908  01cf               _set_frame_blink:
 910  01cf 5209          	subw	sp,#9
 911       00000009      OFST:	set	9
 914                     ; 109 	u8 LED_WHITE_COUNT=12;
 916                     ; 110 	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
 918  01d1 a61e          	ld	a,#30
 919  01d3 6b05          	ld	(OFST-4,sp),a
 921                     ; 111 	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
 923  01d5 a604          	ld	a,#4
 924  01d7 6b04          	ld	(OFST-5,sp),a
 926                     ; 112 	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
 928  01d9 ae002a        	ldw	x,#42
 929  01dc 1f02          	ldw	(OFST-7,sp),x
 931                     ; 113 	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
 933  01de cd0000        	call	_millis
 935  01e1 a607          	ld	a,#7
 936  01e3 cd0000        	call	c_lursh
 938  01e6 be02          	ldw	x,c_lreg+2
 939  01e8 1f07          	ldw	(OFST-2,sp),x
 941                     ; 116 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
 943  01ea 0f06          	clr	(OFST-3,sp)
 946  01ec 204a          	jra	L543
 947  01ee               L143:
 948                     ; 118 		x=get_random(x);
 950  01ee 1e07          	ldw	x,(OFST-2,sp)
 951  01f0 cd0000        	call	_get_random
 953  01f3 1f07          	ldw	(OFST-2,sp),x
 955                     ; 119 		led_index=x%m;
 957  01f5 1e07          	ldw	x,(OFST-2,sp)
 958  01f7 1602          	ldw	y,(OFST-7,sp)
 959  01f9 65            	divw	x,y
 960  01fa 51            	exgw	x,y
 961  01fb 01            	rrwa	x,a
 962  01fc 6b09          	ld	(OFST+0,sp),a
 963  01fe 02            	rlwa	x,a
 965                     ; 120 		if(led_index>=RGB_ELEMENT_COUNT)
 967  01ff 7b09          	ld	a,(OFST+0,sp)
 968  0201 1105          	cp	a,(OFST-4,sp)
 969  0203 2513          	jrult	L153
 970                     ; 122 			if(is_space_sao()) set_white(led_index-RGB_ELEMENT_COUNT,255);
 972  0205 cd0000        	call	_is_space_sao
 974  0208 4d            	tnz	a
 975  0209 272b          	jreq	L553
 978  020b 7b09          	ld	a,(OFST+0,sp)
 979  020d 1005          	sub	a,(OFST-4,sp)
 980  020f ae00ff        	ldw	x,#255
 981  0212 95            	ld	xh,a
 982  0213 cd0000        	call	_set_white
 984  0216 201e          	jra	L553
 985  0218               L153:
 986                     ; 124 			set_rgb(led_index/3,led_index%3,255);
 988  0218 4bff          	push	#255
 989  021a 7b0a          	ld	a,(OFST+1,sp)
 990  021c 5f            	clrw	x
 991  021d 97            	ld	xl,a
 992  021e a603          	ld	a,#3
 993  0220 62            	div	x,a
 994  0221 5f            	clrw	x
 995  0222 97            	ld	xl,a
 996  0223 9f            	ld	a,xl
 997  0224 97            	ld	xl,a
 998  0225 7b0a          	ld	a,(OFST+1,sp)
 999  0227 905f          	clrw	y
1000  0229 9097          	ld	yl,a
1001  022b a603          	ld	a,#3
1002  022d 9062          	div	y,a
1003  022f 909f          	ld	a,yl
1004  0231 95            	ld	xh,a
1005  0232 cd0000        	call	_set_rgb
1007  0235 84            	pop	a
1008  0236               L553:
1009                     ; 116 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
1011  0236 0c06          	inc	(OFST-3,sp)
1013  0238               L543:
1016  0238 7b06          	ld	a,(OFST-3,sp)
1017  023a 1104          	cp	a,(OFST-5,sp)
1018  023c 25b0          	jrult	L143
1019                     ; 127 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
1021  023e 7b04          	ld	a,(OFST-5,sp)
1022  0240 4c            	inc	a
1023  0241 cd0000        	call	_flush_leds
1025                     ; 128 }
1028  0244 5b09          	addw	sp,#9
1029  0246 81            	ret
1053                     ; 131 void show_cyclone()
1053                     ; 132 {
1054                     	switch	.text
1055  0247               _show_cyclone:
1059  0247               L173:
1060                     ; 133 	while(is_submenu_valid())
1062  0247 cd009f        	call	_is_submenu_valid
1064  024a 4d            	tnz	a
1065  024b 26fa          	jrne	L173
1066                     ; 137 }
1069  024d 81            	ret
1093                     ; 139 void show_puzzle()
1093                     ; 140 {
1094                     	switch	.text
1095  024e               _show_puzzle:
1099  024e               L704:
1100                     ; 141 	while(is_submenu_valid())
1102  024e cd009f        	call	_is_submenu_valid
1104  0251 4d            	tnz	a
1105  0252 26fa          	jrne	L704
1106                     ; 145 }
1109  0254 81            	ret
1173                     	xdef	_SCREEN_SAVER_DURATION_MS
1174                     	xdef	_SCREEN_SAVER_COUNT_SPACE
1175                     	xdef	_SCREEN_SAVER_COUNT_PONY
1176                     	xdef	_SUBMENU_TIME_OUT_MS
1177                     	xdef	_SUBMENU_COUNT
1178                     	xdef	_set_frame_blink
1179                     	xdef	_set_frame_audio
1180                     	xdef	_set_frame_rainbow
1181                     	xdef	_is_submenu_valid
1182                     	xdef	_show_puzzle
1183                     	xdef	_show_cyclone
1184                     	xdef	_show_screen_savers
1185                     	xdef	_run_application
1186                     	xdef	_setup_application
1187                     	xref	_get_audio_level
1188                     	xref	_get_random
1189                     	xref	_is_space_sao
1190                     	xref	_is_button_down
1191                     	xref	_clear_button_events
1192                     	xref	_clear_button_event
1193                     	xref	_set_hue
1194                     	xref	_flush_leds
1195                     	xref	_set_white
1196                     	xref	_set_rgb
1197                     	xref	_millis
1198                     	xref	_is_application_valid
1199                     	xref	_setup_serial
1200                     	xref.b	c_lreg
1201                     	xref.b	c_x
1220                     	xref	c_ladd
1221                     	xref	c_uitolx
1222                     	xref	c_imul
1223                     	xref	c_llsh
1224                     	xref	c_lursh
1225                     	xref	c_lcmp
1226                     	xref	c_rtol
1227                     	xref	c_smodx
1228                     	end
