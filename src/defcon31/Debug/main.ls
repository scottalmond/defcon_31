   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  46                     ; 14 int main()
  46                     ; 15 {
  48                     	switch	.text
  49  0000               _main:
  53                     ; 16 	setup();
  55  0000 cd0000        	call	_setup
  57  0003               L12:
  58                     ; 19 		if(is_application_valid())
  60  0003 cd0000        	call	_is_application_valid
  62  0006 4d            	tnz	a
  63  0007 2705          	jreq	L52
  64                     ; 21 			run_application();
  66  0009 cd0000        	call	_run_application
  69  000c 20f5          	jra	L12
  70  000e               L52:
  71                     ; 23 			run_developer();
  73  000e cd0000        	call	_run_developer
  75  0011 20f0          	jra	L12
  88                     	xdef	_main
  89                     	xref	_run_developer
  90                     	xref	_run_application
  91                     	xref	_setup
  92                     	xref	_is_application_valid
 111                     	end
