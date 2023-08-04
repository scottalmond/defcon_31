   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 11 void setup_application()
  44                     ; 12 {
  46                     	switch	.text
  47  0000               _setup_application:
  51                     ; 13 	setup_serial(0,0);
  53  0000 5f            	clrw	x
  54  0001 cd0000        	call	_setup_serial
  56                     ; 14 	clear_button_events();
  58  0004 cd0000        	call	_clear_button_events
  60                     ; 15 }
  63  0007 81            	ret
 126                     .const:	section	.text
 127  0000               L01:
 128  0000 00000200      	dc.l	512
 129                     ; 18 void run_application()
 129                     ; 19 {
 130                     	switch	.text
 131  0008               _run_application:
 133  0008 520a          	subw	sp,#10
 134       0000000a      OFST:	set	10
 137                     ; 20 	u8 submenu_index=0;
 139  000a 0f09          	clr	(OFST-1,sp)
 141                     ; 22 	u32 show_top_menu_since_ms=0;
 143  000c ae0000        	ldw	x,#0
 144  000f 1f07          	ldw	(OFST-3,sp),x
 145  0011 ae0000        	ldw	x,#0
 146  0014 1f05          	ldw	(OFST-5,sp),x
 148                     ; 23 	setup_application();
 150  0016 ade8          	call	_setup_application
 153  0018 acbc00bc      	jpf	L16
 154  001c               L75:
 155                     ; 26 		if(clear_button_event(0,0))
 157  001c 5f            	clrw	x
 158  001d cd0000        	call	_clear_button_event
 160  0020 4d            	tnz	a
 161  0021 2718          	jreq	L56
 162                     ; 28 			submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
 164  0023 7b09          	ld	a,(OFST-1,sp)
 165  0025 5f            	clrw	x
 166  0026 97            	ld	xl,a
 167  0027 5c            	incw	x
 168  0028 a604          	ld	a,#4
 169  002a cd0000        	call	c_smodx
 171  002d 01            	rrwa	x,a
 172  002e 6b09          	ld	(OFST-1,sp),a
 173  0030 02            	rlwa	x,a
 175                     ; 29 			show_top_menu_since_ms=millis();
 177  0031 cd0000        	call	_millis
 179  0034 96            	ldw	x,sp
 180  0035 1c0005        	addw	x,#OFST-5
 181  0038 cd0000        	call	c_rtol
 184  003b               L56:
 185                     ; 31 		if(is_button_down(0)) show_top_menu_since_ms=millis();
 187  003b 4f            	clr	a
 188  003c cd0000        	call	_is_button_down
 190  003f 4d            	tnz	a
 191  0040 270a          	jreq	L76
 194  0042 cd0000        	call	_millis
 196  0045 96            	ldw	x,sp
 197  0046 1c0005        	addw	x,#OFST-5
 198  0049 cd0000        	call	c_rtol
 201  004c               L76:
 202                     ; 32 		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
 204  004c cd0000        	call	_millis
 206  004f 96            	ldw	x,sp
 207  0050 1c0001        	addw	x,#OFST-9
 208  0053 cd0000        	call	c_rtol
 211  0056 96            	ldw	x,sp
 212  0057 1c0005        	addw	x,#OFST-5
 213  005a cd0000        	call	c_ltor
 215  005d ae0000        	ldw	x,#L01
 216  0060 cd0000        	call	c_ladd
 218  0063 96            	ldw	x,sp
 219  0064 1c0001        	addw	x,#OFST-9
 220  0067 cd0000        	call	c_lcmp
 222  006a 2322          	jrule	L17
 223                     ; 34 			for(iter=0;iter<RGB_LED_COUNT;iter++)
 225  006c 0f0a          	clr	(OFST+0,sp)
 227  006e               L37:
 228                     ; 35 				set_hue_max(iter,submenu_index<<14);//set all LEDs to the same color
 230  006e 7b09          	ld	a,(OFST-1,sp)
 231  0070 5f            	clrw	x
 232  0071 97            	ld	xl,a
 233  0072 9f            	ld	a,xl
 234  0073 5f            	clrw	x
 235  0074 44            	srl	a
 236  0075 56            	rrcw	x
 237  0076 44            	srl	a
 238  0077 56            	rrcw	x
 239  0078 89            	pushw	x
 240  0079 7b0c          	ld	a,(OFST+2,sp)
 241  007b cd0000        	call	_set_hue_max
 243  007e 85            	popw	x
 244                     ; 34 			for(iter=0;iter<RGB_LED_COUNT;iter++)
 246  007f 0c0a          	inc	(OFST+0,sp)
 250  0081 7b0a          	ld	a,(OFST+0,sp)
 251  0083 a10a          	cp	a,#10
 252  0085 25e7          	jrult	L37
 253                     ; 36 			flush_leds((RGB_LED_COUNT<<1)+1);//10 RGB LEDs (2-elements each), only every-other enabled, and the status LED to give feedback about the button push to the user
 255  0087 a615          	ld	a,#21
 256  0089 cd0000        	call	_flush_leds
 259  008c 202e          	jra	L16
 260  008e               L17:
 261                     ; 38 			show_top_menu_since_ms=0;
 263  008e ae0000        	ldw	x,#0
 264  0091 1f07          	ldw	(OFST-3,sp),x
 265  0093 ae0000        	ldw	x,#0
 266  0096 1f05          	ldw	(OFST-5,sp),x
 268                     ; 39 			switch(submenu_index)
 270  0098 7b09          	ld	a,(OFST-1,sp)
 272                     ; 44 				case 3:{ show_counter(); }break;
 273  009a 4d            	tnz	a
 274  009b 270b          	jreq	L12
 275  009d 4a            	dec	a
 276  009e 270c          	jreq	L32
 277  00a0 4a            	dec	a
 278  00a1 270f          	jreq	L52
 279  00a3 4a            	dec	a
 280  00a4 2713          	jreq	L72
 281  00a6 2014          	jra	L16
 282  00a8               L12:
 283                     ; 41 				case 0:{ show_screen_savers(); }break;
 285  00a8 ad31          	call	_show_screen_savers
 289  00aa 2010          	jra	L16
 290  00ac               L32:
 291                     ; 42 				case 1:{ show_game(0); }break;//cyclone
 293  00ac 4f            	clr	a
 294  00ad cd038c        	call	_show_game
 298  00b0 200a          	jra	L16
 299  00b2               L52:
 300                     ; 43 				case 2:{ show_game(4); }break;//gate
 302  00b2 a604          	ld	a,#4
 303  00b4 cd038c        	call	_show_game
 307  00b7 2003          	jra	L16
 308  00b9               L72:
 309                     ; 44 				case 3:{ show_counter(); }break;
 311  00b9 cd0154        	call	_show_counter
 315  00bc               L501:
 316  00bc               L16:
 317                     ; 24 	while(is_application_valid())
 319  00bc cd0000        	call	_is_application_valid
 321  00bf 4d            	tnz	a
 322  00c0 2703          	jreq	L21
 323  00c2 cc001c        	jp	L75
 324  00c5               L21:
 325                     ; 48 }
 328  00c5 5b0a          	addw	sp,#10
 329  00c7 81            	ret
 375                     ; 51 bool is_submenu_valid()
 375                     ; 52 {
 376                     	switch	.text
 377  00c8               _is_submenu_valid:
 381                     ; 53 	return is_application_valid()&&!get_button_event(0,0);
 383  00c8 cd0000        	call	_is_application_valid
 385  00cb 4d            	tnz	a
 386  00cc 270b          	jreq	L61
 387  00ce 5f            	clrw	x
 388  00cf cd0000        	call	_get_button_event
 390  00d2 4d            	tnz	a
 391  00d3 2604          	jrne	L61
 392  00d5 a601          	ld	a,#1
 393  00d7 2001          	jra	L02
 394  00d9               L61:
 395  00d9 4f            	clr	a
 396  00da               L02:
 399  00da 81            	ret
 451                     ; 57 void show_screen_savers()
 451                     ; 58 {
 452                     	switch	.text
 453  00db               _show_screen_savers:
 455  00db 89            	pushw	x
 456       00000002      OFST:	set	2
 459                     ; 59 	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
 461  00dc a601          	ld	a,#1
 462  00de 6b01          	ld	(OFST-1,sp),a
 464                     ; 60 	u8 screen_saver_index=0;
 466  00e0 0f02          	clr	(OFST+0,sp)
 469  00e2 2068          	jra	L561
 470  00e4               L361:
 471                     ; 63 		if(clear_button_event(1,0))
 473  00e4 ae0100        	ldw	x,#256
 474  00e7 cd0000        	call	_clear_button_event
 476  00ea 4d            	tnz	a
 477  00eb 2704          	jreq	L171
 478                     ; 65 			is_auto_cycle=0;
 480  00ed 0f01          	clr	(OFST-1,sp)
 482                     ; 66 			screen_saver_index++;
 484  00ef 0c02          	inc	(OFST+0,sp)
 486  00f1               L171:
 487                     ; 68 		if(is_auto_cycle) screen_saver_index=millis()>>15;//proceed automatically to the next screen saver every 32 seconds
 489  00f1 0d01          	tnz	(OFST-1,sp)
 490  00f3 270c          	jreq	L371
 493  00f5 cd0000        	call	_millis
 495  00f8 a60f          	ld	a,#15
 496  00fa cd0000        	call	c_lursh
 498  00fd b603          	ld	a,c_lreg+3
 499  00ff 6b02          	ld	(OFST+0,sp),a
 501  0101               L371:
 502                     ; 69 		if(clear_button_event(1,1)) is_auto_cycle=!is_auto_cycle;
 504  0101 ae0101        	ldw	x,#257
 505  0104 cd0000        	call	_clear_button_event
 507  0107 4d            	tnz	a
 508  0108 270b          	jreq	L571
 511  010a 0d01          	tnz	(OFST-1,sp)
 512  010c 2604          	jrne	L42
 513  010e a601          	ld	a,#1
 514  0110 2001          	jra	L62
 515  0112               L42:
 516  0112 4f            	clr	a
 517  0113               L62:
 518  0113 6b01          	ld	(OFST-1,sp),a
 520  0115               L571:
 521                     ; 70 		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(IS_SPACE_SAO?SCREEN_SAVER_COUNT_SPACE:0);
 523  0115 7b02          	ld	a,(OFST+0,sp)
 524  0117 5f            	clrw	x
 525  0118 97            	ld	xl,a
 526  0119 a605          	ld	a,#5
 527  011b 62            	div	x,a
 528  011c 5f            	clrw	x
 529  011d 97            	ld	xl,a
 530  011e 01            	rrwa	x,a
 531  011f 6b02          	ld	(OFST+0,sp),a
 532  0121 02            	rlwa	x,a
 534                     ; 71 		switch(screen_saver_index)
 536  0122 7b02          	ld	a,(OFST+0,sp)
 538                     ; 77 			case 4:{ set_frame_space_bits(); }break;//exclusive to space bits badges
 539  0124 4d            	tnz	a
 540  0125 270e          	jreq	L721
 541  0127 4a            	dec	a
 542  0128 2710          	jreq	L131
 543  012a 4a            	dec	a
 544  012b 2712          	jreq	L331
 545  012d 4a            	dec	a
 546  012e 2714          	jreq	L531
 547  0130 4a            	dec	a
 548  0131 2716          	jreq	L731
 549  0133 2017          	jra	L561
 550  0135               L721:
 551                     ; 73 			case 0:{ set_frame_rainbow(); }break;
 553  0135 cd01ce        	call	_set_frame_rainbow
 557  0138 2012          	jra	L561
 558  013a               L131:
 559                     ; 74 			case 1:{ set_frame_audio(); }break;
 561  013a cd0232        	call	_set_frame_audio
 565  013d 200d          	jra	L561
 566  013f               L331:
 567                     ; 75 			case 2:{ set_frame_morse(); }break;
 569  013f cd075a        	call	_set_frame_morse
 573  0142 2008          	jra	L561
 574  0144               L531:
 575                     ; 76 			case 3:{ set_frame_blink(); }break;
 577  0144 cd0280        	call	_set_frame_blink
 581  0147 2003          	jra	L561
 582  0149               L731:
 583                     ; 77 			case 4:{ set_frame_space_bits(); }break;//exclusive to space bits badges
 585  0149 cd0301        	call	_set_frame_space_bits
 589  014c               L102:
 590  014c               L561:
 591                     ; 61 	while(is_submenu_valid())
 593  014c cd00c8        	call	_is_submenu_valid
 595  014f 4d            	tnz	a
 596  0150 2692          	jrne	L361
 597                     ; 80 }
 600  0152 85            	popw	x
 601  0153 81            	ret
 659                     ; 82 void show_counter()
 659                     ; 83 {//it counts the number of times you have clicked the right button.  Long-press to toggle clock mode.
 660                     	switch	.text
 661  0154               _show_counter:
 663  0154 5204          	subw	sp,#4
 664       00000004      OFST:	set	4
 667                     ; 84 	u16 state=1;
 669  0156 ae0001        	ldw	x,#1
 670  0159 1f02          	ldw	(OFST-2,sp),x
 672                     ; 85 	bool is_clock_mode=0;
 674  015b 0f01          	clr	(OFST-3,sp)
 677  015d 2066          	jra	L532
 678  015f               L132:
 679                     ; 89 		if(is_clock_mode) state=millis()>>8;
 681  015f 0d01          	tnz	(OFST-3,sp)
 682  0161 270e          	jreq	L142
 685  0163 cd0000        	call	_millis
 687  0166 a608          	ld	a,#8
 688  0168 cd0000        	call	c_lursh
 690  016b be02          	ldw	x,c_lreg+2
 691  016d 1f02          	ldw	(OFST-2,sp),x
 694  016f 2010          	jra	L342
 695  0171               L142:
 696                     ; 90 		else if(clear_button_event(1,0)) state++;
 698  0171 ae0100        	ldw	x,#256
 699  0174 cd0000        	call	_clear_button_event
 701  0177 4d            	tnz	a
 702  0178 2707          	jreq	L342
 705  017a 1e02          	ldw	x,(OFST-2,sp)
 706  017c 1c0001        	addw	x,#1
 707  017f 1f02          	ldw	(OFST-2,sp),x
 709  0181               L342:
 710                     ; 91 		if(clear_button_event(1,1)) is_clock_mode=!is_clock_mode;
 712  0181 ae0101        	ldw	x,#257
 713  0184 cd0000        	call	_clear_button_event
 715  0187 4d            	tnz	a
 716  0188 270b          	jreq	L742
 719  018a 0d01          	tnz	(OFST-3,sp)
 720  018c 2604          	jrne	L23
 721  018e a601          	ld	a,#1
 722  0190 2001          	jra	L43
 723  0192               L23:
 724  0192 4f            	clr	a
 725  0193               L43:
 726  0193 6b01          	ld	(OFST-3,sp),a
 728  0195               L742:
 729                     ; 92 		for(iter=0;iter<RGB_LED_COUNT;iter++)
 731  0195 0f04          	clr	(OFST+0,sp)
 733  0197               L152:
 734                     ; 94 			if((state>>iter)&0x01)
 736  0197 1e02          	ldw	x,(OFST-2,sp)
 737  0199 7b04          	ld	a,(OFST+0,sp)
 738  019b 4d            	tnz	a
 739  019c 2704          	jreq	L63
 740  019e               L04:
 741  019e 54            	srlw	x
 742  019f 4a            	dec	a
 743  01a0 26fc          	jrne	L04
 744  01a2               L63:
 745  01a2 01            	rrwa	x,a
 746  01a3 a501          	bcp	a,#1
 747  01a5 2711          	jreq	L752
 748                     ; 95 				set_hue_max(iter,millis()<<3);
 750  01a7 cd0000        	call	_millis
 752  01aa a603          	ld	a,#3
 753  01ac cd0000        	call	c_llsh
 755  01af be02          	ldw	x,c_lreg+2
 756  01b1 89            	pushw	x
 757  01b2 7b06          	ld	a,(OFST+2,sp)
 758  01b4 cd0000        	call	_set_hue_max
 760  01b7 85            	popw	x
 761  01b8               L752:
 762                     ; 92 		for(iter=0;iter<RGB_LED_COUNT;iter++)
 764  01b8 0c04          	inc	(OFST+0,sp)
 768  01ba 7b04          	ld	a,(OFST+0,sp)
 769  01bc a10a          	cp	a,#10
 770  01be 25d7          	jrult	L152
 771                     ; 97 		flush_leds(21);
 773  01c0 a615          	ld	a,#21
 774  01c2 cd0000        	call	_flush_leds
 776  01c5               L532:
 777                     ; 87 	while(is_submenu_valid())
 779  01c5 cd00c8        	call	_is_submenu_valid
 781  01c8 4d            	tnz	a
 782  01c9 2694          	jrne	L132
 783                     ; 99 }
 786  01cb 5b04          	addw	sp,#4
 787  01cd 81            	ret
 825                     ; 101 void set_frame_rainbow()
 825                     ; 102 {
 826                     	switch	.text
 827  01ce               _set_frame_rainbow:
 829  01ce 5205          	subw	sp,#5
 830       00000005      OFST:	set	5
 833                     ; 104 	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue_max(iter,(millis()<<5)+(iter<<13));
 835  01d0 0f05          	clr	(OFST+0,sp)
 837  01d2               L772:
 840  01d2 7b05          	ld	a,(OFST+0,sp)
 841  01d4 5f            	clrw	x
 842  01d5 97            	ld	xl,a
 843  01d6 9f            	ld	a,xl
 844  01d7 4e            	swap	a
 845  01d8 48            	sll	a
 846  01d9 a4e0          	and	a,#224
 847  01db 5f            	clrw	x
 848  01dc 95            	ld	xh,a
 849  01dd cd0000        	call	c_itolx
 851  01e0 96            	ldw	x,sp
 852  01e1 1c0001        	addw	x,#OFST-4
 853  01e4 cd0000        	call	c_rtol
 856  01e7 cd0000        	call	_millis
 858  01ea a605          	ld	a,#5
 859  01ec cd0000        	call	c_llsh
 861  01ef 96            	ldw	x,sp
 862  01f0 1c0001        	addw	x,#OFST-4
 863  01f3 cd0000        	call	c_ladd
 865  01f6 be02          	ldw	x,c_lreg+2
 866  01f8 89            	pushw	x
 867  01f9 7b07          	ld	a,(OFST+2,sp)
 868  01fb cd0000        	call	_set_hue_max
 870  01fe 85            	popw	x
 873  01ff 0c05          	inc	(OFST+0,sp)
 877  0201 7b05          	ld	a,(OFST+0,sp)
 878  0203 a10a          	cp	a,#10
 879  0205 25cb          	jrult	L772
 880                     ; 105 	iter=(millis()>>8)&0x0F;
 882  0207 cd0000        	call	_millis
 884  020a a608          	ld	a,#8
 885  020c cd0000        	call	c_lursh
 887  020f b603          	ld	a,c_lreg+3
 888  0211 a40f          	and	a,#15
 889  0213 b703          	ld	c_lreg+3,a
 890  0215 3f02          	clr	c_lreg+2
 891  0217 3f01          	clr	c_lreg+1
 892  0219 3f00          	clr	c_lreg
 893  021b b603          	ld	a,c_lreg+3
 894  021d 6b05          	ld	(OFST+0,sp),a
 896                     ; 106 	if(IS_SPACE_SAO&&iter<WHITE_LED_COUNT) set_white_max(iter);
 898  021f 7b05          	ld	a,(OFST+0,sp)
 899  0221 a10c          	cp	a,#12
 900  0223 2405          	jruge	L503
 903  0225 7b05          	ld	a,(OFST+0,sp)
 904  0227 cd0000        	call	_set_white_max
 906  022a               L503:
 907                     ; 107 	flush_leds((RGB_LED_COUNT<<1)+1+1);//max 2 colors ON at a time and one led for button pushes
 909  022a a616          	ld	a,#22
 910  022c cd0000        	call	_flush_leds
 912                     ; 108 }
 915  022f 5b05          	addw	sp,#5
 916  0231 81            	ret
 962                     ; 110 void set_frame_audio()
 962                     ; 111 {
 963                     	switch	.text
 964  0232               _set_frame_audio:
 966  0232 89            	pushw	x
 967       00000002      OFST:	set	2
 970                     ; 114 	audio_level=get_audio_level()>>1;
 972  0233 cd0000        	call	_get_audio_level
 974  0236 44            	srl	a
 975  0237 6b01          	ld	(OFST-1,sp),a
 977                     ; 115 	for(iter=0;iter<RGB_LED_COUNT;iter++)
 979  0239 0f02          	clr	(OFST+0,sp)
 981  023b               L133:
 982                     ; 117 		if(audio_level>=iter)
 984  023b 7b01          	ld	a,(OFST-1,sp)
 985  023d 1102          	cp	a,(OFST+0,sp)
 986  023f 2530          	jrult	L733
 987                     ; 119 			if(iter>7)
 989  0241 7b02          	ld	a,(OFST+0,sp)
 990  0243 a108          	cp	a,#8
 991  0245 2509          	jrult	L143
 992                     ; 121 				set_rgb_max(iter,0);
 994  0247 7b02          	ld	a,(OFST+0,sp)
 995  0249 5f            	clrw	x
 996  024a 95            	ld	xh,a
 997  024b cd0000        	call	_set_rgb_max
1000  024e 2021          	jra	L733
1001  0250               L143:
1002                     ; 123 			else if(iter>4)
1004  0250 7b02          	ld	a,(OFST+0,sp)
1005  0252 a105          	cp	a,#5
1006  0254 2512          	jrult	L543
1007                     ; 125 				set_rgb_max(iter,0);
1009  0256 7b02          	ld	a,(OFST+0,sp)
1010  0258 5f            	clrw	x
1011  0259 95            	ld	xh,a
1012  025a cd0000        	call	_set_rgb_max
1014                     ; 126 				set_rgb_max(iter,1);
1016  025d 7b02          	ld	a,(OFST+0,sp)
1017  025f ae0001        	ldw	x,#1
1018  0262 95            	ld	xh,a
1019  0263 cd0000        	call	_set_rgb_max
1022  0266 2009          	jra	L733
1023  0268               L543:
1024                     ; 129 				set_rgb_max(iter,1);
1026  0268 7b02          	ld	a,(OFST+0,sp)
1027  026a ae0001        	ldw	x,#1
1028  026d 95            	ld	xh,a
1029  026e cd0000        	call	_set_rgb_max
1031  0271               L733:
1032                     ; 115 	for(iter=0;iter<RGB_LED_COUNT;iter++)
1034  0271 0c02          	inc	(OFST+0,sp)
1038  0273 7b02          	ld	a,(OFST+0,sp)
1039  0275 a10a          	cp	a,#10
1040  0277 25c2          	jrult	L133
1041                     ; 133 	flush_leds(RGB_LED_COUNT+3+1);//3 yellow LEDs is double-count, 1 for status led for button pushes
1043  0279 a60e          	ld	a,#14
1044  027b cd0000        	call	_flush_leds
1046                     ; 134 }
1049  027e 85            	popw	x
1050  027f 81            	ret
1117                     ; 136 void set_frame_blink()
1117                     ; 137 {
1118                     	switch	.text
1119  0280               _set_frame_blink:
1121  0280 5205          	subw	sp,#5
1122       00000005      OFST:	set	5
1125                     ; 138 	const u8 MAX_SIMULTANEOUS_LEDS_ON=5;
1127  0282 a605          	ld	a,#5
1128  0284 6b01          	ld	(OFST-4,sp),a
1130                     ; 139 	u16 x=millis()>>7;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz, >>9 is ~2 Hz
1132  0286 cd0000        	call	_millis
1134  0289 a607          	ld	a,#7
1135  028b cd0000        	call	c_lursh
1137  028e be02          	ldw	x,c_lreg+2
1138  0290 1f04          	ldw	(OFST-1,sp),x
1140                     ; 142 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
1142  0292 0f02          	clr	(OFST-3,sp)
1145  0294 205b          	jra	L704
1146  0296               L304:
1147                     ; 144 		led_index=get_random(x^(x>>1))%RGB_LED_COUNT;
1149  0296 1e04          	ldw	x,(OFST-1,sp)
1150  0298 54            	srlw	x
1151  0299 01            	rrwa	x,a
1152  029a 1805          	xor	a,(OFST+0,sp)
1153  029c 01            	rrwa	x,a
1154  029d 1804          	xor	a,(OFST-1,sp)
1155  029f 01            	rrwa	x,a
1156  02a0 cd0000        	call	_get_random
1158  02a3 a60a          	ld	a,#10
1159  02a5 62            	div	x,a
1160  02a6 5f            	clrw	x
1161  02a7 97            	ld	xl,a
1162  02a8 01            	rrwa	x,a
1163  02a9 6b03          	ld	(OFST-2,sp),a
1164  02ab 02            	rlwa	x,a
1166                     ; 145 		set_hue_max(led_index,get_random(x^(x>>1)));
1168  02ac 1e04          	ldw	x,(OFST-1,sp)
1169  02ae 54            	srlw	x
1170  02af 01            	rrwa	x,a
1171  02b0 1805          	xor	a,(OFST+0,sp)
1172  02b2 01            	rrwa	x,a
1173  02b3 1804          	xor	a,(OFST-1,sp)
1174  02b5 01            	rrwa	x,a
1175  02b6 cd0000        	call	_get_random
1177  02b9 89            	pushw	x
1178  02ba 7b05          	ld	a,(OFST+0,sp)
1179  02bc cd0000        	call	_set_hue_max
1181  02bf 85            	popw	x
1182                     ; 146 		if(iter==0&&(((u8)millis()&0x7F)<0x47))
1184  02c0 0d02          	tnz	(OFST-3,sp)
1185  02c2 2624          	jrne	L314
1187  02c4 cd0000        	call	_millis
1189  02c7 b603          	ld	a,c_lreg+3
1190  02c9 a47f          	and	a,#127
1191  02cb a147          	cp	a,#71
1192  02cd 2419          	jruge	L314
1193                     ; 148 			set_rgb_max(led_index,0);
1195  02cf 7b03          	ld	a,(OFST-2,sp)
1196  02d1 5f            	clrw	x
1197  02d2 95            	ld	xh,a
1198  02d3 cd0000        	call	_set_rgb_max
1200                     ; 149 			set_rgb_max(led_index,1);
1202  02d6 7b03          	ld	a,(OFST-2,sp)
1203  02d8 ae0001        	ldw	x,#1
1204  02db 95            	ld	xh,a
1205  02dc cd0000        	call	_set_rgb_max
1207                     ; 150 			set_rgb_max(led_index,2);
1209  02df 7b03          	ld	a,(OFST-2,sp)
1210  02e1 ae0002        	ldw	x,#2
1211  02e4 95            	ld	xh,a
1212  02e5 cd0000        	call	_set_rgb_max
1214  02e8               L314:
1215                     ; 152 		x--;
1217  02e8 1e04          	ldw	x,(OFST-1,sp)
1218  02ea 1d0001        	subw	x,#1
1219  02ed 1f04          	ldw	(OFST-1,sp),x
1221                     ; 142 	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
1223  02ef 0c02          	inc	(OFST-3,sp)
1225  02f1               L704:
1228  02f1 7b02          	ld	a,(OFST-3,sp)
1229  02f3 1101          	cp	a,(OFST-4,sp)
1230  02f5 259f          	jrult	L304
1231                     ; 154 	flush_leds(MAX_SIMULTANEOUS_LEDS_ON<<1+1);
1233  02f7 7b01          	ld	a,(OFST-4,sp)
1234  02f9 48            	sll	a
1235  02fa 48            	sll	a
1236  02fb cd0000        	call	_flush_leds
1238                     ; 155 }
1241  02fe 5b05          	addw	sp,#5
1242  0300 81            	ret
1269                     	switch	.const
1270  0004               L534:
1271  0004 0004          	dc.w	4
1272  0006 00000000      	dc.l	0
1273  000a 031b          	dc.w	L514
1274  000c 00000001      	dc.l	1
1275  0010 0330          	dc.w	L714
1276  0012 00000002      	dc.l	2
1277  0016 0346          	dc.w	L124
1278  0018 00000003      	dc.l	3
1279  001c 0357          	dc.w	L324
1280  001e 0386          	dc.w	L734
1281                     ; 158 void set_frame_space_bits()
1281                     ; 159 {
1282                     	switch	.text
1283  0301               _set_frame_space_bits:
1287                     ; 160 	switch((millis()>>9)&0x03)
1289  0301 cd0000        	call	_millis
1291  0304 a609          	ld	a,#9
1292  0306 cd0000        	call	c_lursh
1294  0309 b603          	ld	a,c_lreg+3
1295  030b a403          	and	a,#3
1296  030d b703          	ld	c_lreg+3,a
1297  030f 3f02          	clr	c_lreg+2
1298  0311 3f01          	clr	c_lreg+1
1299  0313 3f00          	clr	c_lreg
1301  0315 ae0004        	ldw	x,#L534
1302  0318 cd0000        	call	c_jltab
1303  031b               L514:
1304                     ; 163 			set_white_max(0);
1306  031b 4f            	clr	a
1307  031c cd0000        	call	_set_white_max
1309                     ; 164 			set_white_max(1);
1311  031f a601          	ld	a,#1
1312  0321 cd0000        	call	_set_white_max
1314                     ; 165 			set_white_max(4);
1316  0324 a604          	ld	a,#4
1317  0326 cd0000        	call	_set_white_max
1319                     ; 166 			set_white_max(5);
1321  0329 a605          	ld	a,#5
1322  032b cd0000        	call	_set_white_max
1324                     ; 167 		}break;
1326  032e 2056          	jra	L734
1327  0330               L714:
1328                     ; 169 			set_white_max(5);
1330  0330 a605          	ld	a,#5
1331  0332 cd0000        	call	_set_white_max
1333                     ; 170 			set_white_max(6);
1335  0335 a606          	ld	a,#6
1336  0337 cd0000        	call	_set_white_max
1338                     ; 171 			set_white_max(9);
1340  033a a609          	ld	a,#9
1341  033c cd0000        	call	_set_white_max
1343                     ; 172 			set_white_max(10);
1345  033f a60a          	ld	a,#10
1346  0341 cd0000        	call	_set_white_max
1348                     ; 173 		}break;
1350  0344 2040          	jra	L734
1351  0346               L124:
1352                     ; 175 			set_white_max(1);
1354  0346 a601          	ld	a,#1
1355  0348 cd0000        	call	_set_white_max
1357                     ; 176 			set_white_max(2);
1359  034b a602          	ld	a,#2
1360  034d cd0000        	call	_set_white_max
1362                     ; 177 			set_white_max(3);
1364  0350 a603          	ld	a,#3
1365  0352 cd0000        	call	_set_white_max
1367                     ; 178 		}break;
1369  0355 202f          	jra	L734
1370  0357               L324:
1371                     ; 180 			if((millis()>>6)&0x01)
1373  0357 cd0000        	call	_millis
1375  035a a606          	ld	a,#6
1376  035c cd0000        	call	c_lursh
1378  035f b603          	ld	a,c_lreg+3
1379  0361 a401          	and	a,#1
1380  0363 b703          	ld	c_lreg+3,a
1381  0365 3f02          	clr	c_lreg+2
1382  0367 3f01          	clr	c_lreg+1
1383  0369 3f00          	clr	c_lreg
1384  036b cd0000        	call	c_lrzmp
1386  036e 270c          	jreq	L144
1387                     ; 182 				set_white_max(6);
1389  0370 a606          	ld	a,#6
1390  0372 cd0000        	call	_set_white_max
1392                     ; 183 				set_white_max(11);
1394  0375 a60b          	ld	a,#11
1395  0377 cd0000        	call	_set_white_max
1398  037a 200a          	jra	L734
1399  037c               L144:
1400                     ; 185 				set_white_max(7);
1402  037c a607          	ld	a,#7
1403  037e cd0000        	call	_set_white_max
1405                     ; 186 				set_white_max(10);
1407  0381 a60a          	ld	a,#10
1408  0383 cd0000        	call	_set_white_max
1410  0386               L734:
1411                     ; 190 	flush_leds(5);
1413  0386 a605          	ld	a,#5
1414  0388 cd0000        	call	_flush_leds
1416                     ; 191 }
1419  038b 81            	ret
1551                     	switch	.const
1552  0020               L401:
1553  0020 00000065      	dc.l	101
1554  0024               L011:
1555  0024 00000101      	dc.l	257
1556                     ; 194 void show_game(u8 state)
1556                     ; 195 {
1557                     	switch	.text
1558  038c               _show_game:
1560  038c 88            	push	a
1561  038d 5214          	subw	sp,#20
1562       00000014      OFST:	set	20
1565                     ; 196 	u32 start_state_ms=millis();
1567  038f cd0000        	call	_millis
1569  0392 96            	ldw	x,sp
1570  0393 1c000b        	addw	x,#OFST-9
1571  0396 cd0000        	call	c_rtol
1574                     ; 197 	bool is_increasing=0;
1576  0399 0f0a          	clr	(OFST-10,sp)
1578                     ; 198 	u8 TARGET_POSITION=5;//constant postiion of the winning position
1580  039b a605          	ld	a,#5
1581  039d 6b13          	ld	(OFST-1,sp),a
1583                     ; 199 	u8 player_position=0;
1585  039f 0f14          	clr	(OFST+0,sp)
1587                     ; 200 	u8 level=0;
1589  03a1 0f0f          	clr	(OFST-5,sp)
1591                     ; 201 	u8 iter,target_color=0,player_color=0;
1593  03a3 0f09          	clr	(OFST-11,sp)
1597  03a5 0f12          	clr	(OFST-2,sp)
1599                     ; 203 	u8 PERIOD_MS=state==0?100:200;//how many ms pass before the 
1601  03a7 0d15          	tnz	(OFST+1,sp)
1602  03a9 2604          	jrne	L45
1603  03ab a664          	ld	a,#100
1604  03ad 2002          	jra	L65
1605  03af               L45:
1606  03af a6c8          	ld	a,#200
1607  03b1               L65:
1608  03b1 6b11          	ld	(OFST-3,sp),a
1611  03b3 ac4e074e      	jpf	L155
1612  03b7               L745:
1613                     ; 206 		residual=millis()-start_state_ms;
1615  03b7 cd0000        	call	_millis
1617  03ba 96            	ldw	x,sp
1618  03bb 1c000b        	addw	x,#OFST-9
1619  03be cd0000        	call	c_lsub
1621  03c1 96            	ldw	x,sp
1622  03c2 1c0005        	addw	x,#OFST-15
1623  03c5 cd0000        	call	c_rtol
1626                     ; 207 		switch(state)
1628  03c8 7b15          	ld	a,(OFST+1,sp)
1630                     ; 325 			}break;
1631  03ca 4d            	tnz	a
1632  03cb 2722          	jreq	L544
1633  03cd 4a            	dec	a
1634  03ce 2603          	jrne	L211
1635  03d0 cc04c6        	jp	L744
1636  03d3               L211:
1637  03d3 4a            	dec	a
1638  03d4 2603          	jrne	L411
1639  03d6 cc0552        	jp	L154
1640  03d9               L411:
1641  03d9 4a            	dec	a
1642  03da 2603          	jrne	L611
1643  03dc cc05bd        	jp	L354
1644  03df               L611:
1645  03df 4a            	dec	a
1646  03e0 2603          	jrne	L021
1647  03e2 cc0652        	jp	L554
1648  03e5               L021:
1649  03e5 4a            	dec	a
1650  03e6 2603          	jrne	L221
1651  03e8 cc06f9        	jp	L754
1652  03eb               L221:
1653  03eb ac490749      	jpf	L755
1654  03ef               L544:
1655                     ; 210 				set_rgb_max(TARGET_POSITION,level);//single target objective to hit
1657  03ef 7b0f          	ld	a,(OFST-5,sp)
1658  03f1 97            	ld	xl,a
1659  03f2 7b13          	ld	a,(OFST-1,sp)
1660  03f4 95            	ld	xh,a
1661  03f5 cd0000        	call	_set_rgb_max
1663                     ; 211 				if(residual>PERIOD_MS)
1665  03f8 7b11          	ld	a,(OFST-3,sp)
1666  03fa b703          	ld	c_lreg+3,a
1667  03fc 3f02          	clr	c_lreg+2
1668  03fe 3f01          	clr	c_lreg+1
1669  0400 3f00          	clr	c_lreg
1670  0402 96            	ldw	x,sp
1671  0403 1c0005        	addw	x,#OFST-15
1672  0406 cd0000        	call	c_lcmp
1674  0409 242a          	jruge	L165
1675                     ; 213 					player_position+=is_increasing?1:-1;
1677  040b 0d0a          	tnz	(OFST-10,sp)
1678  040d 2704          	jreq	L06
1679  040f a601          	ld	a,#1
1680  0411 2002          	jra	L26
1681  0413               L06:
1682  0413 a6ff          	ld	a,#255
1683  0415               L26:
1684  0415 1b14          	add	a,(OFST+0,sp)
1685  0417 6b14          	ld	(OFST+0,sp),a
1687                     ; 214 					player_position+=RGB_LED_COUNT;
1689  0419 7b14          	ld	a,(OFST+0,sp)
1690  041b ab0a          	add	a,#10
1691  041d 6b14          	ld	(OFST+0,sp),a
1693                     ; 215 					player_position%=RGB_LED_COUNT;
1695  041f 7b14          	ld	a,(OFST+0,sp)
1696  0421 5f            	clrw	x
1697  0422 97            	ld	xl,a
1698  0423 a60a          	ld	a,#10
1699  0425 62            	div	x,a
1700  0426 5f            	clrw	x
1701  0427 97            	ld	xl,a
1702  0428 01            	rrwa	x,a
1703  0429 6b14          	ld	(OFST+0,sp),a
1704  042b 02            	rlwa	x,a
1706                     ; 216 					start_state_ms+=PERIOD_MS;
1708  042c 7b11          	ld	a,(OFST-3,sp)
1709  042e 96            	ldw	x,sp
1710  042f 1c000b        	addw	x,#OFST-9
1711  0432 cd0000        	call	c_lgadc
1714  0435               L165:
1715                     ; 218 				set_rgb_max(player_position,0);
1717  0435 7b14          	ld	a,(OFST+0,sp)
1718  0437 5f            	clrw	x
1719  0438 95            	ld	xh,a
1720  0439 cd0000        	call	_set_rgb_max
1722                     ; 219 				set_rgb_max(player_position,1);
1724  043c 7b14          	ld	a,(OFST+0,sp)
1725  043e ae0001        	ldw	x,#1
1726  0441 95            	ld	xh,a
1727  0442 cd0000        	call	_set_rgb_max
1729                     ; 220 				set_rgb_max(player_position,2);
1731  0445 7b14          	ld	a,(OFST+0,sp)
1732  0447 ae0002        	ldw	x,#2
1733  044a 95            	ld	xh,a
1734  044b cd0000        	call	_set_rgb_max
1736                     ; 221 				if(clear_button_event(1,0)||clear_button_event(1,1))
1738  044e ae0100        	ldw	x,#256
1739  0451 cd0000        	call	_clear_button_event
1741  0454 4d            	tnz	a
1742  0455 260c          	jrne	L565
1744  0457 ae0101        	ldw	x,#257
1745  045a cd0000        	call	_clear_button_event
1747  045d 4d            	tnz	a
1748  045e 2603          	jrne	L421
1749  0460 cc0749        	jp	L755
1750  0463               L421:
1751  0463               L565:
1752                     ; 223 					if(player_position==TARGET_POSITION)
1754  0463 7b14          	ld	a,(OFST+0,sp)
1755  0465 1113          	cp	a,(OFST-1,sp)
1756  0467 2639          	jrne	L765
1757                     ; 225 					  if(get_random(millis())&0x0F<(0x02+level<<2)) player_position+=is_increasing?1:-1;
1759  0469 9c            	rvf
1760  046a 7b0f          	ld	a,(OFST-5,sp)
1761  046c 97            	ld	xl,a
1762  046d a604          	ld	a,#4
1763  046f 42            	mul	x,a
1764  0470 1c0008        	addw	x,#8
1765  0473 a30010        	cpw	x,#16
1766  0476 2f05          	jrslt	L46
1767  0478 ae0001        	ldw	x,#1
1768  047b 2001          	jra	L66
1769  047d               L46:
1770  047d 5f            	clrw	x
1771  047e               L66:
1772  047e 1f03          	ldw	(OFST-17,sp),x
1774  0480 cd0000        	call	_millis
1776  0483 be02          	ldw	x,c_lreg+2
1777  0485 cd0000        	call	_get_random
1779  0488 01            	rrwa	x,a
1780  0489 1404          	and	a,(OFST-16,sp)
1781  048b 01            	rrwa	x,a
1782  048c 1403          	and	a,(OFST-17,sp)
1783  048e 01            	rrwa	x,a
1784  048f a30000        	cpw	x,#0
1785  0492 270e          	jreq	L765
1788  0494 0d0a          	tnz	(OFST-10,sp)
1789  0496 2704          	jreq	L07
1790  0498 a601          	ld	a,#1
1791  049a 2002          	jra	L27
1792  049c               L07:
1793  049c a6ff          	ld	a,#255
1794  049e               L27:
1795  049e 1b14          	add	a,(OFST+0,sp)
1796  04a0 6b14          	ld	(OFST+0,sp),a
1798  04a2               L765:
1799                     ; 227 					if(player_position==TARGET_POSITION)
1801  04a2 7b14          	ld	a,(OFST+0,sp)
1802  04a4 1113          	cp	a,(OFST-1,sp)
1803  04a6 2616          	jrne	L375
1804                     ; 229 						if(level==2) state=3;
1806  04a8 7b0f          	ld	a,(OFST-5,sp)
1807  04aa a102          	cp	a,#2
1808  04ac 2608          	jrne	L575
1811  04ae a603          	ld	a,#3
1812  04b0 6b15          	ld	(OFST+1,sp),a
1814  04b2 ac490749      	jpf	L755
1815  04b6               L575:
1816                     ; 230 						else state=1;
1818  04b6 a601          	ld	a,#1
1819  04b8 6b15          	ld	(OFST+1,sp),a
1820  04ba ac490749      	jpf	L755
1821  04be               L375:
1822                     ; 232 					else state=2;
1824  04be a602          	ld	a,#2
1825  04c0 6b15          	ld	(OFST+1,sp),a
1826  04c2 ac490749      	jpf	L755
1827  04c6               L744:
1828                     ; 236 				if((millis()>>7)&0x01)
1830  04c6 cd0000        	call	_millis
1832  04c9 a607          	ld	a,#7
1833  04cb cd0000        	call	c_lursh
1835  04ce b603          	ld	a,c_lreg+3
1836  04d0 a401          	and	a,#1
1837  04d2 b703          	ld	c_lreg+3,a
1838  04d4 3f02          	clr	c_lreg+2
1839  04d6 3f01          	clr	c_lreg+1
1840  04d8 3f00          	clr	c_lreg
1841  04da cd0000        	call	c_lrzmp
1843  04dd 2719          	jreq	L306
1844                     ; 238 					set_rgb_max(TARGET_POSITION,0);
1846  04df 7b13          	ld	a,(OFST-1,sp)
1847  04e1 5f            	clrw	x
1848  04e2 95            	ld	xh,a
1849  04e3 cd0000        	call	_set_rgb_max
1851                     ; 239 					set_rgb_max(TARGET_POSITION,1);
1853  04e6 7b13          	ld	a,(OFST-1,sp)
1854  04e8 ae0001        	ldw	x,#1
1855  04eb 95            	ld	xh,a
1856  04ec cd0000        	call	_set_rgb_max
1858                     ; 240 					set_rgb_max(TARGET_POSITION,2);
1860  04ef 7b13          	ld	a,(OFST-1,sp)
1861  04f1 ae0002        	ldw	x,#2
1862  04f4 95            	ld	xh,a
1863  04f5 cd0000        	call	_set_rgb_max
1865  04f8               L306:
1866                     ; 242 				if((millis()>>9)&0x01)
1868  04f8 cd0000        	call	_millis
1870  04fb a609          	ld	a,#9
1871  04fd cd0000        	call	c_lursh
1873  0500 b603          	ld	a,c_lreg+3
1874  0502 a501          	bcp	a,#1
1875  0504 2714          	jreq	L506
1876                     ; 244 					set_rgb_max(TARGET_POSITION-1,level);
1878  0506 7b0f          	ld	a,(OFST-5,sp)
1879  0508 97            	ld	xl,a
1880  0509 7b13          	ld	a,(OFST-1,sp)
1881  050b 4a            	dec	a
1882  050c 95            	ld	xh,a
1883  050d cd0000        	call	_set_rgb_max
1885                     ; 245 					set_rgb_max(TARGET_POSITION+1,level);
1887  0510 7b0f          	ld	a,(OFST-5,sp)
1888  0512 97            	ld	xl,a
1889  0513 7b13          	ld	a,(OFST-1,sp)
1890  0515 4c            	inc	a
1891  0516 95            	ld	xh,a
1892  0517 cd0000        	call	_set_rgb_max
1894  051a               L506:
1895                     ; 247 				if(clear_button_event(1,0)||clear_button_event(1,1))
1897  051a ae0100        	ldw	x,#256
1898  051d cd0000        	call	_clear_button_event
1900  0520 4d            	tnz	a
1901  0521 260c          	jrne	L116
1903  0523 ae0101        	ldw	x,#257
1904  0526 cd0000        	call	_clear_button_event
1906  0529 4d            	tnz	a
1907  052a 2603          	jrne	L621
1908  052c cc0749        	jp	L755
1909  052f               L621:
1910  052f               L116:
1911                     ; 249 					state=0;
1913  052f 0f15          	clr	(OFST+1,sp)
1914                     ; 250 					level++;
1916  0531 0c0f          	inc	(OFST-5,sp)
1918                     ; 251 					PERIOD_MS-=24;
1920  0533 7b11          	ld	a,(OFST-3,sp)
1921  0535 a018          	sub	a,#24
1922  0537 6b11          	ld	(OFST-3,sp),a
1924                     ; 252 					is_increasing=!is_increasing;//reverse direciton
1926  0539 0d0a          	tnz	(OFST-10,sp)
1927  053b 2604          	jrne	L47
1928  053d a601          	ld	a,#1
1929  053f 2001          	jra	L67
1930  0541               L47:
1931  0541 4f            	clr	a
1932  0542               L67:
1933  0542 6b0a          	ld	(OFST-10,sp),a
1935                     ; 253 					start_state_ms=millis();
1937  0544 cd0000        	call	_millis
1939  0547 96            	ldw	x,sp
1940  0548 1c000b        	addw	x,#OFST-9
1941  054b cd0000        	call	c_rtol
1944  054e ac490749      	jpf	L755
1945  0552               L154:
1946                     ; 257 				if((millis()>>7)&0x01)
1948  0552 cd0000        	call	_millis
1950  0555 a607          	ld	a,#7
1951  0557 cd0000        	call	c_lursh
1953  055a b603          	ld	a,c_lreg+3
1954  055c a401          	and	a,#1
1955  055e b703          	ld	c_lreg+3,a
1956  0560 3f02          	clr	c_lreg+2
1957  0562 3f01          	clr	c_lreg+1
1958  0564 3f00          	clr	c_lreg
1959  0566 cd0000        	call	c_lrzmp
1961  0569 2719          	jreq	L316
1962                     ; 259 					set_rgb_max(player_position,0);
1964  056b 7b14          	ld	a,(OFST+0,sp)
1965  056d 5f            	clrw	x
1966  056e 95            	ld	xh,a
1967  056f cd0000        	call	_set_rgb_max
1969                     ; 260 					set_rgb_max(player_position,1);
1971  0572 7b14          	ld	a,(OFST+0,sp)
1972  0574 ae0001        	ldw	x,#1
1973  0577 95            	ld	xh,a
1974  0578 cd0000        	call	_set_rgb_max
1976                     ; 261 					set_rgb_max(player_position,2);
1978  057b 7b14          	ld	a,(OFST+0,sp)
1979  057d ae0002        	ldw	x,#2
1980  0580 95            	ld	xh,a
1981  0581 cd0000        	call	_set_rgb_max
1983  0584               L316:
1984                     ; 263 				set_rgb_max(TARGET_POSITION,level);
1986  0584 7b0f          	ld	a,(OFST-5,sp)
1987  0586 97            	ld	xl,a
1988  0587 7b13          	ld	a,(OFST-1,sp)
1989  0589 95            	ld	xh,a
1990  058a cd0000        	call	_set_rgb_max
1992                     ; 264 				if(clear_button_event(1,0)||clear_button_event(1,1))
1994  058d ae0100        	ldw	x,#256
1995  0590 cd0000        	call	_clear_button_event
1997  0593 4d            	tnz	a
1998  0594 260c          	jrne	L716
2000  0596 ae0101        	ldw	x,#257
2001  0599 cd0000        	call	_clear_button_event
2003  059c 4d            	tnz	a
2004  059d 2603          	jrne	L031
2005  059f cc0749        	jp	L755
2006  05a2               L031:
2007  05a2               L716:
2008                     ; 266 					state=0;
2010  05a2 0f15          	clr	(OFST+1,sp)
2011                     ; 267 					is_increasing=!is_increasing;//reverse direciton
2013  05a4 0d0a          	tnz	(OFST-10,sp)
2014  05a6 2604          	jrne	L001
2015  05a8 a601          	ld	a,#1
2016  05aa 2001          	jra	L201
2017  05ac               L001:
2018  05ac 4f            	clr	a
2019  05ad               L201:
2020  05ad 6b0a          	ld	(OFST-10,sp),a
2022                     ; 268 					start_state_ms=millis();
2024  05af cd0000        	call	_millis
2026  05b2 96            	ldw	x,sp
2027  05b3 1c000b        	addw	x,#OFST-9
2028  05b6 cd0000        	call	c_rtol
2031  05b9 ac490749      	jpf	L755
2032  05bd               L354:
2033                     ; 273 				PERIOD_MS=100;
2035  05bd a664          	ld	a,#100
2036  05bf 6b11          	ld	(OFST-3,sp),a
2038                     ; 274 				if(residual>PERIOD_MS)
2040  05c1 96            	ldw	x,sp
2041  05c2 1c0005        	addw	x,#OFST-15
2042  05c5 cd0000        	call	c_ltor
2044  05c8 ae0020        	ldw	x,#L401
2045  05cb cd0000        	call	c_lcmp
2047  05ce 2518          	jrult	L126
2048                     ; 276 					player_position++;
2050  05d0 0c14          	inc	(OFST+0,sp)
2052                     ; 277 					player_position%=RGB_LED_COUNT;
2054  05d2 7b14          	ld	a,(OFST+0,sp)
2055  05d4 5f            	clrw	x
2056  05d5 97            	ld	xl,a
2057  05d6 a60a          	ld	a,#10
2058  05d8 62            	div	x,a
2059  05d9 5f            	clrw	x
2060  05da 97            	ld	xl,a
2061  05db 01            	rrwa	x,a
2062  05dc 6b14          	ld	(OFST+0,sp),a
2063  05de 02            	rlwa	x,a
2065                     ; 278 					start_state_ms+=PERIOD_MS;
2067  05df 96            	ldw	x,sp
2068  05e0 1c000b        	addw	x,#OFST-9
2069  05e3 a664          	ld	a,#100
2070  05e5 cd0000        	call	c_lgadc
2073  05e8               L126:
2074                     ; 280 				for(iter=0;iter<4;iter++)
2076  05e8 0f10          	clr	(OFST-4,sp)
2078  05ea               L326:
2079                     ; 282 					player_color=(player_position+iter)%RGB_LED_COUNT;//re-use variable for win animation index
2081  05ea 7b14          	ld	a,(OFST+0,sp)
2082  05ec 5f            	clrw	x
2083  05ed 1b10          	add	a,(OFST-4,sp)
2084  05ef 2401          	jrnc	L601
2085  05f1 5c            	incw	x
2086  05f2               L601:
2087  05f2 02            	rlwa	x,a
2088  05f3 a60a          	ld	a,#10
2089  05f5 cd0000        	call	c_smodx
2091  05f8 01            	rrwa	x,a
2092  05f9 6b12          	ld	(OFST-2,sp),a
2093  05fb 02            	rlwa	x,a
2095                     ; 283 					set_hue_max(player_color,(millis()<<3)-(iter<<11));
2097  05fc 7b10          	ld	a,(OFST-4,sp)
2098  05fe 5f            	clrw	x
2099  05ff 97            	ld	xl,a
2100  0600 4f            	clr	a
2101  0601 02            	rlwa	x,a
2102  0602 58            	sllw	x
2103  0603 58            	sllw	x
2104  0604 58            	sllw	x
2105  0605 cd0000        	call	c_itolx
2107  0608 96            	ldw	x,sp
2108  0609 1c0001        	addw	x,#OFST-19
2109  060c cd0000        	call	c_rtol
2112  060f cd0000        	call	_millis
2114  0612 a603          	ld	a,#3
2115  0614 cd0000        	call	c_llsh
2117  0617 96            	ldw	x,sp
2118  0618 1c0001        	addw	x,#OFST-19
2119  061b cd0000        	call	c_lsub
2121  061e be02          	ldw	x,c_lreg+2
2122  0620 89            	pushw	x
2123  0621 7b14          	ld	a,(OFST+0,sp)
2124  0623 cd0000        	call	_set_hue_max
2126  0626 85            	popw	x
2127                     ; 284 					if(iter==3)
2129  0627 7b10          	ld	a,(OFST-4,sp)
2130  0629 a103          	cp	a,#3
2131  062b 2619          	jrne	L136
2132                     ; 286 						set_rgb_max(player_color,0);
2134  062d 7b12          	ld	a,(OFST-2,sp)
2135  062f 5f            	clrw	x
2136  0630 95            	ld	xh,a
2137  0631 cd0000        	call	_set_rgb_max
2139                     ; 287 						set_rgb_max(player_color,1);
2141  0634 7b12          	ld	a,(OFST-2,sp)
2142  0636 ae0001        	ldw	x,#1
2143  0639 95            	ld	xh,a
2144  063a cd0000        	call	_set_rgb_max
2146                     ; 288 						set_rgb_max(player_color,2);
2148  063d 7b12          	ld	a,(OFST-2,sp)
2149  063f ae0002        	ldw	x,#2
2150  0642 95            	ld	xh,a
2151  0643 cd0000        	call	_set_rgb_max
2153  0646               L136:
2154                     ; 280 				for(iter=0;iter<4;iter++)
2156  0646 0c10          	inc	(OFST-4,sp)
2160  0648 7b10          	ld	a,(OFST-4,sp)
2161  064a a104          	cp	a,#4
2162  064c 259c          	jrult	L326
2163                     ; 291 			}break;
2165  064e ac490749      	jpf	L755
2166  0652               L554:
2167                     ; 293 				if(residual>PERIOD_MS)
2169  0652 7b11          	ld	a,(OFST-3,sp)
2170  0654 b703          	ld	c_lreg+3,a
2171  0656 3f02          	clr	c_lreg+2
2172  0658 3f01          	clr	c_lreg+1
2173  065a 3f00          	clr	c_lreg
2174  065c 96            	ldw	x,sp
2175  065d 1c0005        	addw	x,#OFST-15
2176  0660 cd0000        	call	c_lcmp
2178  0663 245f          	jruge	L336
2179                     ; 295 					if(player_position==TARGET_POSITION)//"player" is the autonomous moving piece.  user controls color of target gate through button presses
2181  0665 7b14          	ld	a,(OFST+0,sp)
2182  0667 1113          	cp	a,(OFST-1,sp)
2183  0669 2627          	jrne	L536
2184                     ; 297 						player_color=(get_random((u8)millis()^~player_color))%3;
2186  066b 7b12          	ld	a,(OFST-2,sp)
2187  066d 5f            	clrw	x
2188  066e 97            	ld	xl,a
2189  066f 53            	cplw	x
2190  0670 1f03          	ldw	(OFST-17,sp),x
2192  0672 cd0000        	call	_millis
2194  0675 b603          	ld	a,c_lreg+3
2195  0677 5f            	clrw	x
2196  0678 97            	ld	xl,a
2197  0679 01            	rrwa	x,a
2198  067a 1804          	xor	a,(OFST-16,sp)
2199  067c 01            	rrwa	x,a
2200  067d 1803          	xor	a,(OFST-17,sp)
2201  067f 01            	rrwa	x,a
2202  0680 cd0000        	call	_get_random
2204  0683 a603          	ld	a,#3
2205  0685 62            	div	x,a
2206  0686 5f            	clrw	x
2207  0687 97            	ld	xl,a
2208  0688 01            	rrwa	x,a
2209  0689 6b12          	ld	(OFST-2,sp),a
2210  068b 02            	rlwa	x,a
2212                     ; 298 						PERIOD_MS-=3;
2214  068c 7b11          	ld	a,(OFST-3,sp)
2215  068e a003          	sub	a,#3
2216  0690 6b11          	ld	(OFST-3,sp),a
2218  0692               L536:
2219                     ; 300 					player_position++;
2221  0692 0c14          	inc	(OFST+0,sp)
2223                     ; 301 					player_position%=RGB_LED_COUNT;
2225  0694 7b14          	ld	a,(OFST+0,sp)
2226  0696 5f            	clrw	x
2227  0697 97            	ld	xl,a
2228  0698 a60a          	ld	a,#10
2229  069a 62            	div	x,a
2230  069b 5f            	clrw	x
2231  069c 97            	ld	xl,a
2232  069d 01            	rrwa	x,a
2233  069e 6b14          	ld	(OFST+0,sp),a
2234  06a0 02            	rlwa	x,a
2236                     ; 302 					start_state_ms+=PERIOD_MS;
2238  06a1 7b11          	ld	a,(OFST-3,sp)
2239  06a3 96            	ldw	x,sp
2240  06a4 1c000b        	addw	x,#OFST-9
2241  06a7 cd0000        	call	c_lgadc
2244                     ; 303 					if(PERIOD_MS<120) state=3;//win game
2246  06aa 7b11          	ld	a,(OFST-3,sp)
2247  06ac a178          	cp	a,#120
2248  06ae 2404          	jruge	L736
2251  06b0 a603          	ld	a,#3
2252  06b2 6b15          	ld	(OFST+1,sp),a
2253  06b4               L736:
2254                     ; 304 					if(player_position==TARGET_POSITION && player_color!=target_color) state=5;
2256  06b4 7b14          	ld	a,(OFST+0,sp)
2257  06b6 1113          	cp	a,(OFST-1,sp)
2258  06b8 260a          	jrne	L336
2260  06ba 7b12          	ld	a,(OFST-2,sp)
2261  06bc 1109          	cp	a,(OFST-11,sp)
2262  06be 2704          	jreq	L336
2265  06c0 a605          	ld	a,#5
2266  06c2 6b15          	ld	(OFST+1,sp),a
2267  06c4               L336:
2268                     ; 306 				set_rgb_max(TARGET_POSITION,target_color);//stationary gate
2270  06c4 7b09          	ld	a,(OFST-11,sp)
2271  06c6 97            	ld	xl,a
2272  06c7 7b13          	ld	a,(OFST-1,sp)
2273  06c9 95            	ld	xh,a
2274  06ca cd0000        	call	_set_rgb_max
2276                     ; 307 				set_rgb_max(player_position,player_color);//moving key
2278  06cd 7b12          	ld	a,(OFST-2,sp)
2279  06cf 97            	ld	xl,a
2280  06d0 7b14          	ld	a,(OFST+0,sp)
2281  06d2 95            	ld	xh,a
2282  06d3 cd0000        	call	_set_rgb_max
2284                     ; 308 				if(clear_button_event(1,0)||clear_button_event(1,1))
2286  06d6 ae0100        	ldw	x,#256
2287  06d9 cd0000        	call	_clear_button_event
2289  06dc 4d            	tnz	a
2290  06dd 2609          	jrne	L546
2292  06df ae0101        	ldw	x,#257
2293  06e2 cd0000        	call	_clear_button_event
2295  06e5 4d            	tnz	a
2296  06e6 2761          	jreq	L755
2297  06e8               L546:
2298                     ; 310 					target_color++;
2300  06e8 0c09          	inc	(OFST-11,sp)
2302                     ; 311 					target_color%=3;
2304  06ea 7b09          	ld	a,(OFST-11,sp)
2305  06ec 5f            	clrw	x
2306  06ed 97            	ld	xl,a
2307  06ee a603          	ld	a,#3
2308  06f0 62            	div	x,a
2309  06f1 5f            	clrw	x
2310  06f2 97            	ld	xl,a
2311  06f3 01            	rrwa	x,a
2312  06f4 6b09          	ld	(OFST-11,sp),a
2313  06f6 02            	rlwa	x,a
2315  06f7 2050          	jra	L755
2316  06f9               L754:
2317                     ; 315 				if(millis()&0x40)
2319  06f9 cd0000        	call	_millis
2321  06fc b603          	ld	a,c_lreg+3
2322  06fe a540          	bcp	a,#64
2323  0700 270b          	jreq	L746
2324                     ; 316 					set_rgb_max(TARGET_POSITION,player_color);
2326  0702 7b12          	ld	a,(OFST-2,sp)
2327  0704 97            	ld	xl,a
2328  0705 7b13          	ld	a,(OFST-1,sp)
2329  0707 95            	ld	xh,a
2330  0708 cd0000        	call	_set_rgb_max
2333  070b 2009          	jra	L156
2334  070d               L746:
2335                     ; 318 					set_rgb_max(TARGET_POSITION,target_color);
2337  070d 7b09          	ld	a,(OFST-11,sp)
2338  070f 97            	ld	xl,a
2339  0710 7b13          	ld	a,(OFST-1,sp)
2340  0712 95            	ld	xh,a
2341  0713 cd0000        	call	_set_rgb_max
2343  0716               L156:
2344                     ; 319 				if((clear_button_event(1,0)&&(residual>0x0100))||clear_button_event(1,1))
2346  0716 ae0100        	ldw	x,#256
2347  0719 cd0000        	call	_clear_button_event
2349  071c 4d            	tnz	a
2350  071d 270f          	jreq	L756
2352  071f 96            	ldw	x,sp
2353  0720 1c0005        	addw	x,#OFST-15
2354  0723 cd0000        	call	c_ltor
2356  0726 ae0024        	ldw	x,#L011
2357  0729 cd0000        	call	c_lcmp
2359  072c 2409          	jruge	L556
2360  072e               L756:
2362  072e ae0101        	ldw	x,#257
2363  0731 cd0000        	call	_clear_button_event
2365  0734 4d            	tnz	a
2366  0735 2712          	jreq	L755
2367  0737               L556:
2368                     ; 321 					start_state_ms=millis();
2370  0737 cd0000        	call	_millis
2372  073a 96            	ldw	x,sp
2373  073b 1c000b        	addw	x,#OFST-9
2374  073e cd0000        	call	c_rtol
2377                     ; 322 					PERIOD_MS=200;
2379  0741 a6c8          	ld	a,#200
2380  0743 6b11          	ld	(OFST-3,sp),a
2382                     ; 323 					state=4;//restart game
2384  0745 a604          	ld	a,#4
2385  0747 6b15          	ld	(OFST+1,sp),a
2386  0749               L755:
2387                     ; 327 		flush_leds(12);//white (3 colors) * 3 tail + 2x goals + 1x status button
2389  0749 a60c          	ld	a,#12
2390  074b cd0000        	call	_flush_leds
2392  074e               L155:
2393                     ; 204 	while(is_submenu_valid())
2395  074e cd00c8        	call	_is_submenu_valid
2397  0751 4d            	tnz	a
2398  0752 2703          	jreq	L231
2399  0754 cc03b7        	jp	L745
2400  0757               L231:
2401                     ; 329 }
2404  0757 5b15          	addw	sp,#21
2405  0759 81            	ret
2408                     	switch	.const
2409  0028               L166_morse_units:
2410  0028 a9            	dc.b	169
2411  0029 77            	dc.b	119
2412  002a 4b            	dc.b	75
2413  002b 9d            	dc.b	157
2414  002c 74            	dc.b	116
2415  002d 9d            	dc.b	157
2416  002e 52            	dc.b	82
2417  002f 9c            	dc.b	156
2418  0030 a9            	dc.b	169
2419  0031 74            	dc.b	116
2420  0032 ae            	dc.b	174
2421  0033 54            	dc.b	84
2502                     ; 331 void set_frame_morse()
2502                     ; 332 {
2503                     	switch	.text
2504  075a               _set_frame_morse:
2506  075a 5214          	subw	sp,#20
2507       00000014      OFST:	set	20
2510                     ; 333 	u8 morse_units[]= {
2510                     ; 334 		#if IS_SPACE_SAO
2510                     ; 335 			 0b10101001,0b01110111,0b01001011,0b10011101,0b01110100,0b10011101,0b01010010,0b10011100,0b10101001,0b01110100,0b10101110,0b01010100 
2510                     ; 336 		#else
2510                     ; 337 			 0b11101010,0b01001010,0b11101001,0b11010111,0b01001110,0b11101110,0b01110100,0b10101011,0b10111001,0b01110111,0b01110111,0b00000000
2510                     ; 338 		#endif
2510                     ; 339 		};
2512  075c 96            	ldw	x,sp
2513  075d 1c0006        	addw	x,#OFST-14
2514  0760 90ae0028      	ldw	y,#L166_morse_units
2515  0764 a60c          	ld	a,#12
2516  0766 cd0000        	call	c_xymov
2518                     ; 340 	u16 morse_period_units=0x0008;//will become the period of the morse code cycling in lengths of *units* (there are dead bands at the end of each cycle while the patterns waits to repeat - needs to be an even multiple of 2 to make the clock math easy
2520  0769 ae0008        	ldw	x,#8
2521  076c 1f12          	ldw	(OFST-2,sp),x
2523                     ; 341 	u8 morse_shift=sizeof(morse_units);//number of *bytes* in morse_list
2525  076e a60c          	ld	a,#12
2526  0770 6b14          	ld	(OFST+0,sp),a
2528  0772               L527:
2529                     ; 346 		morse_period_units<<=1;
2531  0772 0813          	sll	(OFST-1,sp)
2532  0774 0912          	rlc	(OFST-2,sp)
2534                     ; 347 		morse_shift>>=1;
2536  0776 0414          	srl	(OFST+0,sp)
2538                     ; 344 	while(morse_shift)//for every multiple of 2 bytes in morse_units, divide morse_units by 2 and multiple morse_period_units by 2 to get morse_period_units to become the next even mulitple of 2 greater than morse_units
2540  0778 0d14          	tnz	(OFST+0,sp)
2541  077a 26f6          	jrne	L527
2542                     ; 349 	morse_bit=(millis()>>7)&(morse_period_units-1);//use time to index into the array
2544  077c 7b13          	ld	a,(OFST-1,sp)
2545  077e 4a            	dec	a
2546  077f b703          	ld	c_lreg+3,a
2547  0781 3f02          	clr	c_lreg+2
2548  0783 3f01          	clr	c_lreg+1
2549  0785 3f00          	clr	c_lreg
2550  0787 96            	ldw	x,sp
2551  0788 1c0001        	addw	x,#OFST-19
2552  078b cd0000        	call	c_rtol
2555  078e cd0000        	call	_millis
2557  0791 a607          	ld	a,#7
2558  0793 cd0000        	call	c_lursh
2560  0796 96            	ldw	x,sp
2561  0797 1c0001        	addw	x,#OFST-19
2562  079a cd0000        	call	c_land
2564  079d b603          	ld	a,c_lreg+3
2565  079f 6b14          	ld	(OFST+0,sp),a
2567                     ; 350 	morse_index=morse_bit>>3;//get the byte-wise index within the array
2569  07a1 7b14          	ld	a,(OFST+0,sp)
2570  07a3 44            	srl	a
2571  07a4 44            	srl	a
2572  07a5 44            	srl	a
2573  07a6 6b05          	ld	(OFST-15,sp),a
2575                     ; 351 	if(morse_index<sizeof(morse_units))//needs to be within the array to light any LEDs
2577  07a8 7b05          	ld	a,(OFST-15,sp)
2578  07aa a10c          	cp	a,#12
2579  07ac 2436          	jruge	L337
2580                     ; 353 		morse_shift=morse_bit&0x07;//3 LSBs are which bit within the byte to fetch
2582  07ae 7b14          	ld	a,(OFST+0,sp)
2583  07b0 a407          	and	a,#7
2584  07b2 6b14          	ld	(OFST+0,sp),a
2586                     ; 354 		if(morse_units[morse_index]>>(7-morse_shift)&0x01)//use "7-" to make it easier to generate and read the list constructor left-to-right
2588  07b4 96            	ldw	x,sp
2589  07b5 1c0006        	addw	x,#OFST-14
2590  07b8 9f            	ld	a,xl
2591  07b9 5e            	swapw	x
2592  07ba 1b05          	add	a,(OFST-15,sp)
2593  07bc 2401          	jrnc	L631
2594  07be 5c            	incw	x
2595  07bf               L631:
2596  07bf 02            	rlwa	x,a
2597  07c0 f6            	ld	a,(x)
2598  07c1 88            	push	a
2599  07c2 a607          	ld	a,#7
2600  07c4 1015          	sub	a,(OFST+1,sp)
2601  07c6 5f            	clrw	x
2602  07c7 97            	ld	xl,a
2603  07c8 84            	pop	a
2604  07c9 5d            	tnzw	x
2605  07ca 2704          	jreq	L041
2606  07cc               L241:
2607  07cc 44            	srl	a
2608  07cd 5a            	decw	x
2609  07ce 26fc          	jrne	L241
2610  07d0               L041:
2611  07d0 5f            	clrw	x
2612  07d1 a501          	bcp	a,#1
2613  07d3 270f          	jreq	L337
2614                     ; 357 				for(iter=0;iter<WHITE_LED_COUNT;iter++) set_white_max(iter);
2616  07d5 0f14          	clr	(OFST+0,sp)
2618  07d7               L737:
2621  07d7 7b14          	ld	a,(OFST+0,sp)
2622  07d9 cd0000        	call	_set_white_max
2626  07dc 0c14          	inc	(OFST+0,sp)
2630  07de 7b14          	ld	a,(OFST+0,sp)
2631  07e0 a10c          	cp	a,#12
2632  07e2 25f3          	jrult	L737
2633  07e4               L337:
2634                     ; 364 		flush_leds(WHITE_LED_COUNT+1);
2636  07e4 a60d          	ld	a,#13
2637  07e6 cd0000        	call	_flush_leds
2639                     ; 368 }
2642  07e9 5b14          	addw	sp,#20
2643  07eb 81            	ret
2656                     	xref	_get_audio_level
2657                     	xref	_get_random
2658                     	xref	_is_button_down
2659                     	xref	_clear_button_events
2660                     	xref	_clear_button_event
2661                     	xref	_get_button_event
2662                     	xref	_set_hue_max
2663                     	xref	_flush_leds
2664                     	xref	_set_white_max
2665                     	xref	_set_rgb_max
2666                     	xref	_millis
2667                     	xref	_is_application_valid
2668                     	xref	_setup_serial
2669                     	xdef	_set_frame_morse
2670                     	xdef	_set_frame_space_bits
2671                     	xdef	_show_counter
2672                     	xdef	_set_frame_blink
2673                     	xdef	_set_frame_audio
2674                     	xdef	_set_frame_rainbow
2675                     	xdef	_is_submenu_valid
2676                     	xdef	_show_game
2677                     	xdef	_show_screen_savers
2678                     	xdef	_run_application
2679                     	xdef	_setup_application
2680                     	xref.b	c_lreg
2681                     	xref.b	c_x
2700                     	xref	c_land
2701                     	xref	c_xymov
2702                     	xref	c_lgadc
2703                     	xref	c_lsub
2704                     	xref	c_jltab
2705                     	xref	c_lrzmp
2706                     	xref	c_itolx
2707                     	xref	c_llsh
2708                     	xref	c_lursh
2709                     	xref	c_lcmp
2710                     	xref	c_ladd
2711                     	xref	c_ltor
2712                     	xref	c_rtol
2713                     	xref	c_smodx
2714                     	end
