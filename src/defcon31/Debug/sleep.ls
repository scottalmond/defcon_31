   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 5 void setup_sleep()
  44                     ; 6 {
  46                     	switch	.text
  47  0000               _setup_sleep:
  51                     ; 7 	setup_serial(0,0);//turn UART pins to inputs (to accept button inputs to leave sleep mode)
  53  0000 5f            	clrw	x
  54  0001 cd0000        	call	_setup_serial
  56                     ; 8 	clear_button_events();//flush any outstanding button events (like the long press used to enter sleep mode)
  58  0004 cd0000        	call	_clear_button_events
  60                     ; 9 }
  63  0007 81            	ret
  90                     ; 11 void run_sleep()
  90                     ; 12 {
  91                     	switch	.text
  92  0008               _run_sleep:
  96                     ; 13 	setup_sleep();
  98  0008 adf6          	call	_setup_sleep
 101  000a 2005          	jra	L33
 102  000c               L13:
 103                     ; 14 	while(is_sleep_valid()) flush_leds(1);//have red status LED shine when pushing a button, but before release, as feedback to user
 105  000c a601          	ld	a,#1
 106  000e cd0000        	call	_flush_leds
 108  0011               L33:
 111  0011 cd0000        	call	_is_sleep_valid
 113  0014 4d            	tnz	a
 114  0015 26f5          	jrne	L13
 115                     ; 15 	clear_button_events();
 117  0017 cd0000        	call	_clear_button_events
 119                     ; 16 }
 122  001a 81            	ret
 135                     	xref	_clear_button_events
 136                     	xref	_is_sleep_valid
 137                     	xref	_flush_leds
 138                     	xref	_setup_serial
 139                     	xdef	_run_sleep
 140                     	xdef	_setup_sleep
 159                     	end
