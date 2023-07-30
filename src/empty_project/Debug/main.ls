   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  49                     ; 7 int main()
  49                     ; 8 {
  51                     	switch	.text
  52  0000               _main:
  56                     ; 9 	setup_main();
  58  0000 cd0000        	call	_setup_main
  60  0003               L12:
  61                     ; 12 		if(is_application_valid()) run_application();
  63  0003 cd0000        	call	_is_application_valid
  65  0006 4d            	tnz	a
  66  0007 2703          	jreq	L52
  69  0009 cd0000        	call	_run_application
  71  000c               L52:
  72                     ; 13 		if(is_developer_valid()) run_developer();
  74  000c cd0000        	call	_is_developer_valid
  76  000f 4d            	tnz	a
  77  0010 2703          	jreq	L72
  80  0012 cd0000        	call	_run_developer
  82  0015               L72:
  83                     ; 14 		if(get_button_event(0,1)) run_sleep();//if long press on left button, enter sleep mode
  85  0015 ae0001        	ldw	x,#1
  86  0018 cd0000        	call	_get_button_event
  88  001b 4d            	tnz	a
  89  001c 27e5          	jreq	L12
  92  001e cd0000        	call	_run_sleep
  94  0021 20e0          	jra	L12
 107                     	xdef	_main
 108                     	xref	_run_sleep
 109                     	xref	_run_developer
 110                     	xref	_run_application
 111                     	xref	_get_button_event
 112                     	xref	_is_developer_valid
 113                     	xref	_setup_main
 114                     	xref	_is_application_valid
 133                     	end
