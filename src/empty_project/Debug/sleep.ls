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
  89                     ; 11 void run_sleep()
  89                     ; 12 {
  90                     	switch	.text
  91  0008               _run_sleep:
  95                     ; 13 	setup_sleep();
  97  0008 adf6          	call	_setup_sleep
 100  000a 2005          	jra	L33
 101  000c               L13:
 102                     ; 14 	while(is_sleep_valid()) flush_leds(1);//have red status LED shine when pushing a button, but before release, as feedback to user
 104  000c a601          	ld	a,#1
 105  000e cd0000        	call	_flush_leds
 107  0011               L33:
 110  0011 cd0000        	call	_is_sleep_valid
 112  0014 4d            	tnz	a
 113  0015 26f5          	jrne	L13
 114                     ; 15 }
 117  0017 81            	ret
 130                     	xref	_clear_button_events
 131                     	xref	_is_sleep_valid
 132                     	xref	_flush_leds
 133                     	xref	_setup_serial
 134                     	xdef	_run_sleep
 135                     	xdef	_setup_sleep
 154                     	end
