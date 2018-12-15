	PAGE	60,132
	TITLE	Tandy 1000 Memory Aduster
	NAME	ADJMEM

;------------------------------------------------------------------------------;
;									       ;
;				  ADJMEM 1.1				       ;
;									       ;
;			  Tandy 1000 Memory Adjuster			       ;
;									       ;
;									       ;
;				  Written By:				       ;
;			      Joseph A. Albrecht			       ;
;                        9250 Old Cedar Ave  Apt. 103                          ;
;			    Bloomington, MN  55425			       ;
;									       ;
;------------------------------------------------------------------------------;

;*******************************************************************************
Code	SEGMENT PARA PUBLIC 'CODE'	;Code segment

	ASSUME	CS:Code,DS:Code,ES:Code,SS:Code

	ORG	100H		;COM files start at 100H

Begin:
	JMP	Main		;Skip past data

Copyright	DB	10,13
		DB	'ADJMEM 1.1  Copyright 1989-2005 (C) by '
		DB	'Joseph A. Albrecht'
		DB	10, 13
CrLf		DB	10, 13
		DB	'$'

ErrorMsg	DB	7
		DB	13,10
		DB	'ADJMEM only runs on a Tandy 1000!'
		DB	13,10
		DB	'$'

TotalMem	DB	'Installed Memory: $'
AvailMem	DB	'Available Memory: $'
ProtectMem	DB	'Protected Memory: $'

		DB	'     '
AString		DB	'$'

;-------------------------------------------------------------------------------

Main	PROC		NEAR

	MOV	AX,0FFFFH		;Check byte at FFFF:000E for FFH
	MOV	ES,AX			; .. (IBM PC compatible)
	CMP	BYTE PTR ES:[0EH],0FFH	; ..
	JNE	NotTandy		; ..
Check1000:
	MOV	AX,0FC00H		;Check byte at FC00:0000 for 21H
	MOV	ES,AX			; .. (Tandy 1000 unique)
	CMP	BYTE PTR ES:[0],21H	; ..
	JE	TandyOK			; ..
NotTandy:
	MOV	AH,9			;Computer not a Tandy 1000 series
	MOV	DX,OFFSET ErrorMsg	; .. Print error message and exit
	INT	21H			; ..
	MOV	AX,4CFFH		; ..
	INT	21H			; ..

TandyOK:
	MOV	AX,CS		;Restore default ES
	MOV	ES,AX		; ..

	MOV	AH,9		    ;Print copyright message
	MOV	DX,OFFSET Copyright ; ..
	INT	21H		    ; ..

;Check command line for a leading '+' or '-'
	CLD			;Make sure string op's go forward
	MOV	SI,80H		;See if there is anything on command line
	LODSB			; ..
	CBW			; ..
	OR	AX,AX		; ..
	JNZ	Plus		;Yes, scan the command line
	JMP	ExitProgram	;No, exit the program

Plus:
	MOV	BX,AX		;Save command line count
	MOV	CX,BX		;Command line count in CX
	MOV	DI,81H		;Set command line starting address
	MOV	AL,'+'		;Search for a "+"
	REPNE	SCASB		; ..
	JNE	Minus		;Not there, check for a '-'
	JCXZ	Minus		; ..
	JMP	GetK		;Yes, now parse the number

Minus:
	MOV	CX,BX		;Command line count in CX
	MOV	DI,81H		;Set command line starting address
	MOV	AL,'-'		;Search for a "-"
	REPNE	SCASB		; ..
	JNE	NotThere	;Not there, exit the program
	JCXZ	NotThere	; ..
	JMP	GetK		;Yes, now parse the number
NotThere:
	JMP	ExitProgram	;Exit the progam

;Get the number of K bytes to adjust memory
GetK:
	MOV	CX,AX		;Save plus or minus sign
	XOR	DX,DX		;Initialize DX to 0
	MOV	BX,10		;Initial mutliplier
GetK1:
	MOV	AL,[DI]		;Get 1st digit
	SUB	AL,30H		;Check if too low
	JL	CheckMem	; ..
	CMP	AL,9		;Check if too high
	JG	CheckMem	; ..
	CBW			;Convert to word value
	PUSH	AX		;Save digit
	MOV	AX,DX		;Previous accumulated value in AX
	MUL	BX		;Multiply
	MOV	DX,AX		;Result in DX
	POP	AX		;Restore digit
	ADD	DX,AX		;ADD in digit
	INC	DI		;Point to next digit
	JMP	GetK1		;Do next digit

;Validate K bytes and adjust value if necessary
CheckMem:
	CMP	DX,112		;Validate K bytes and adjust if necessary
	JNA	CheckMem1	; ..
	MOV	DX,112		; ..
CheckMem1:
	PUSH	DS		;Save DS
	MOV	AX,40H		;Point DS at video BIOS data area
	MOV	DS,AX		; ..
	MOV	AX,DS:[15H]	;Get installed memory
	MOV	BX,DS:[13H]	;Get available memory
	POP	DS		;Restore DS
	CMP	AX,BX		;Check for 128K memory expansion option
	JNE	CheckMem2	; ..
	JMP	ExitProgram	; ..
CheckMem2:
	CMP	CL,'+'		;See if adding or subtracting memory
	JE	CheckPlus	; ..

CheckMinus:
	MOV	SI,BX		;See if subtracting too much memory and adjust
	MOV	DI,AX		; .. value if necessary
	SUB	SI,DX		; ..
	SUB	DI,128		; ..
	CMP	SI,DI		; ..
	JGE	CheckMinus1	; ..
	MOV	DX,BX		;Adjust value
	SUB	DX,DI		; ..
CheckMinus1:
	NEG	DX		;Make K bytes negative
	JMP	GetParagraph	;Get paragraph count

CheckPlus:
	MOV	SI,BX		;See if adding too much memory and adjust value
	MOV	DI,AX		; .. if necessary
	ADD	SI,DX		; ..
	SUB	DI,16		; ..
	CMP	SI,DI		; ..
	JLE	GetParagraph	; ..
	MOV	DX,BX		;Adjust value
	SUB	DI,DX		; ..
	MOV	DX,DI		; ..
GetParagraph:
	MOV	AX,DX		;Get paragraph count
	MOV	CL,6		; .. (K bytes * 64)
	SHL	AX,CL		; ..

;Adjust the current system memory
AdjustMem:
	PUSH	DS		;Save DS
	MOV	BX,DS		;Get current PSP address
	DEC	BX		;PSP Addr - 1 = Memory Block Header
	MOV	DS,BX		; ..
	MOV	BX,DS:[3]	; ..
	ADD	BX,AX		;Adjust paragraph count
	MOV	DS:[3],BX	; ..
	MOV	BX,40H		;Get memory size in K
	MOV	DS,BX		; ..
	MOV	BX,DS:[13H]	; ..
	ADD	BX,DX		;Adjust memory K size
	MOV	DS:[13H],BX	; ..
	POP	DS		;Restore DS
	MOV	AH,49H		;Deallocate Environment Block
	MOV	DX,002CH	; ..
	MOV	ES,DX		; ..
	INT	21H		; ..

;Print memory status and exit program
ExitProgram:
	CALL	PrintMem	;Print current memory status
	MOV	AX,4C00H	;Exit to DOS
	INT	21H		; ..

Main		ENDP		;End of main program
;-------------------------------------------------------------------------------

;Print installed and protected memory values
PrintMem:
	PUSH	ES			;Save ES
	MOV	AX,40H			;Point to BIOS data area
	MOV	ES,AX			; ..
	MOV	AH,9			;Print total installed memory
	MOV	DX,OFFSET TotalMem	; ..
	INT	21H			; ..
	MOV	AX,ES:[15H]		; ..
	CALL	PrintNum		; ..
	MOV	AH,2			;Print a 'K'
	MOV	DL,'K'			; ..
	INT	21H			; ..
	MOV	AH,9			;Print a final carriage return
	MOV	DX,OFFSET CRLF		; .. linefeed
	INT	21H			; ..
	MOV	AH,9			;Print protected memory
	MOV	DX,OFFSET ProtectMem	; ..
	INT	21H			; ..
	MOV	AX,ES:[15H]		; ..
	SUB	AX,ES:[13H]		; ..
	CALL	PrintNum		; ..
	MOV	AH,2			;Print a 'K'
	MOV	DL,'K'			; ..
	INT	21H			; ..
	MOV	AH,9			;Print a final carriage return +
	MOV	DX,OFFSET CRLF		; .. linefeed
	INT	21H			; ..
	POP	ES			;Restore ES
	RET
;-------------------------------------------------------------------------------

;
;Convert number in AX to ASCII and print on screen
;
PrintNum:
	MOV	BX,OFFSET AString ;Pointer to end of ASCII string
	MOV	SI,10		;Put divisor in SI
PrintNum1:
	XOR	DX,DX		;Clear dividend high word
	DIV	SI		;AX/SI
	ADD	DL,'0'		;Convert remainder to ASCII
	DEC	BX		;Back step in buffer
	MOV	[BX],DL		;Put character there
	OR	AX,AX		;All done?
	JNZ	PrintNum1	;If not, do another digit
	MOV	DX,BX		;Print the number
	MOV	AH,9		; ..
	INT	21H		; ..
	RET
;-------------------------------------------------------------------------------

Code	ENDS
;*******************************************************************************

	END	Begin
