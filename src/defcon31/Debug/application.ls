   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.8.1 - 09 Jan 2023
   3                     ; Generator (Limited) V4.5.5 - 08 Nov 2022
  44                     ; 6 void run_application()
  44                     ; 7 {
  46                     	switch	.text
  47  0000               _run_application:
  51                     ; 8 	serial_setup(0,0);
  53  0000 ae0000        	ldw	x,#0
  54  0003 89            	pushw	x
  55  0004 ae0000        	ldw	x,#0
  56  0007 89            	pushw	x
  57  0008 4f            	clr	a
  58  0009 cd0000        	call	_serial_setup
  60  000c 5b04          	addw	sp,#4
  62  000e               L32:
  63                     ; 10 	while(is_application_valid())
  65  000e cd0000        	call	_is_application_valid
  67  0011 4d            	tnz	a
  68  0012 26fa          	jrne	L32
  69                     ; 14 }
  72  0014 81            	ret
  85                     	xdef	_run_application
  86                     	xref	_is_application_valid
  87                     	xref	_serial_setup
 106                     	end
