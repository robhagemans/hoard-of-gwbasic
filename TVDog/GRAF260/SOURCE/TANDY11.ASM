	PAGE	60,132
	TITLE	Tandy 1000 SL/TL BIOS Support Routines
	NAME	TANDY11

;------------------------------------------------------------------------------;
;									       ;
;				  TANDY11 1.1				       ;
;									       ;
;		    Tandy 1000 SL/TL BIOS Support Routines		       ;
;		    For The 640x200x16 Color Graphics Mode		       ;
;									       ;
;									       ;
;				  Written By:				       ;
;			      Joseph A. Albrecht			       ;
;                        9250 Old Cedar Ave  Apt. 103                          ;
;			    Bloomington, MN  55425			       ;
;									       ;
;------------------------------------------------------------------------------;

;MACRO to save registers
PUSHR		MACRO

	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DI
	PUSH	BP
	PUSH	DS
	PUSH	ES

		ENDM

;MACRO to restore registers
POPR		MACRO

	POP	ES
	POP	DS
	POP	BP
	POP	DI
	POP	DX
	POP	CX
	POP	BX
	POP	SI

		ENDM

;*******************************************************************************
Code	SEGMENT PARA PUBLIC 'CODE'	;Code segment

	ASSUME	CS:Code,DS:Code,ES:Code,SS:Code

	ORG	100H

Begin:
	JMP	Initialize		;Go to the initializing routine

;Video BIOS data area equates
VideoBIOS	EQU	49H
CRTMode		EQU	BYTE PTR ES:[49H]
ScreenWidth	EQU	WORD PTR ES:[4AH]
ScreenLength	EQU	WORD PTR ES:[4CH]
PageOffset	EQU	WORD PTR ES:[4EH]
CursorPos	EQU	WORD PTR ES:[50H]
CursorType	EQU	WORD PTR ES:[60H]
CurrentPage	EQU	BYTE PTR ES:[62H]
CRTAddress	EQU	WORD PTR ES:[63H]
ModeSelectReg	EQU	BYTE PTR ES:[65H]
Palette		EQU	BYTE PTR ES:[66H]

;ASCII character table address equates
ASCII1		EQU	ES:[110H]
ASCII2		EQU	ES:[7CH]

VideoSeg	EQU	0A000H
BIOSData	EQU	40H
OldINT10H	EQU	DWORD PTR CS:[INT10H]

EVEN					;Align data on a word boundry

INT10H		DW	2 DUP(?)	;Storage for old video interrupt
VideoBuf	DW	VideoSeg	;Video buffer segment address
X1		DW	?		;Variables used in ScrollUp & ScrollDown
Y1		DW	?		; .. routines
X2		DW	?		; ..
Y2		DW	?		; ..
Scroll		DW	?		; ..
NumBytes	DW	?		; ..
NumLines	DW	?		; ..
UpDn		DB	?		; ..
Mode		DB	255		;Indicates if in graphics mode or not
GraphChar	DB	8 DUP(?)	;Compare buffer for GetChar function

;Video BIOS data area values for mode 640x200x16 color graphics mode
VideoData       DB      11              ;Current CRT mode
		DW	80		;Screen column width
		DW	64000		;Byte length of screen
		DW	0		;Address of current display page
		DW	8 DUP(0)	;Current R/C for each display page
		DW	607H		;Current cursor type
		DW	0		;Current display page
		DW	3D4H		;Base address + 4 of CRTC
		DB	1BH		;Copy of value writen to Mode Select Reg
		DB	0		;Current color palette setting

;Video subsystem register values for 640x200x16 color graphics mode
Mode11		DB 13H
                DB 71H,50H,59H,0EH,0FFH,06H,0C8H,0E2H,00H,00H,18H,00H,46H
		DB 00H
		DB 00H
		DB 0FH,00H,10H,01H,02H
		DB 24H
		DB 1BH

EVEN					;Align data on a word boundry

;Scan line address table
ScanLine	DW	00000H,00140H,00280H,003C0H,00500H,00640H,00780H,008C0H
		DW	00A00H,00B40H,00C80H,00DC0H,00F00H,01040H,01180H,012C0H
		DW	01400H,01540H,01680H,017C0H,01900H,01A40H,01B80H,01CC0H
		DW	01E00H,01F40H,02080H,021C0H,02300H,02440H,02580H,026C0H
		DW	02800H,02940H,02A80H,02BC0H,02D00H,02E40H,02F80H,030C0H
		DW	03200H,03340H,03480H,035C0H,03700H,03840H,03980H,03AC0H
		DW	03C00H,03D40H,03E80H,03FC0H,04100H,04240H,04380H,044C0H
		DW	04600H,04740H,04880H,049C0H,04B00H,04C40H,04D80H,04EC0H
		DW	05000H,05140H,05280H,053C0H,05500H,05640H,05780H,058C0H
		DW	05A00H,05B40H,05C80H,05DC0H,05F00H,06040H,06180H,062C0H
		DW	06400H,06540H,06680H,067C0H,06900H,06A40H,06B80H,06CC0H
		DW	06E00H,06F40H,07080H,071C0H,07300H,07440H,07580H,076C0H
		DW	07800H,07940H,07A80H,07BC0H,07D00H,07E40H,07F80H,080C0H
		DW	08200H,08340H,08480H,085C0H,08700H,08840H,08980H,08AC0H
		DW	08C00H,08D40H,08E80H,08FC0H,09100H,09240H,09380H,094C0H
		DW	09600H,09740H,09880H,099C0H,09B00H,09C40H,09D80H,09EC0H
		DW	0A000H,0A140H,0A280H,0A3C0H,0A500H,0A640H,0A780H,0A8C0H
		DW	0AA00H,0AB40H,0AC80H,0ADC0H,0AF00H,0B040H,0B180H,0B2C0H
		DW	0B400H,0B540H,0B680H,0B7C0H,0B900H,0BA40H,0BB80H,0BCC0H
		DW	0BE00H,0BF40H,0C080H,0C1C0H,0C300H,0C440H,0C580H,0C6C0H
		DW	0C800H,0C940H,0CA80H,0CBC0H,0CD00H,0CE40H,0CF80H,0D0C0H
		DW	0D200H,0D340H,0D480H,0D5C0H,0D700H,0D840H,0D980H,0DAC0H
		DW	0DC00H,0DD40H,0DE80H,0DFC0H,0E100H,0E240H,0E380H,0E4C0H
		DW	0E600H,0E740H,0E880H,0E9C0H,0EB00H,0EC40H,0ED80H,0EEC0H
		DW	0F000H,0F140H,0F280H,0F3C0H,0F500H,0F640H,0F780H,0F8C0H

;Functions address JMP table
Functions	DW	SetMode
		DW	SetCursorType
		DW	SetCursorPos
		DW	GetCursorPos
		DW	ReadLightPen
		DW	SelectPage
		DW	ScrollUp
		DW	ScrollDown
		DW	GetChar
		DW	WriteCharAtrb
		DW	WriteChar
		DW	SetColorPal
		DW	PlotPoint
		DW	GetPoint
		DW	WriteTTY
		DW	GetMode
		DW	SetPalette
		DW	255 - (($ - Functions) / 2) DUP (ExecINT10H)
		DW	Special

;-------------------------------------------------------------------------------

;
;Execution begins here on any INT 10H
;

Video		PROC	NEAR

	OR	AH,AH			;Setting video mode?
	JZ	Video1			;Yes
	JS	Video1			;Special program request
        CMP     CS:[Mode],11            ;See if in 640x200x16 color graphics
	JE	Video1			; .. modes before executing function
	JMP	OldINT10H		; ..
Video1:
	PUSH	SI			;Save SI
	MOV	SI,AX			;Index into functions table
	MOV	AL,AH			; ..
	XOR	AH,AH			; ..
	SHL	AX,1			; ..
	XCHG	SI,AX			; ..
	JMP	CS:Functions[SI]	;Service requested function

;
;Execute normal BIOS INT 10H
;

ExecINT10H:
	POP	SI			;Restore SI
	JMP	OldINT10H		;Execute normal BIOS INT 10H

;
;Set video mode function
;

SetMode:
	MOV	SI,AX			;Check if setting mode 11
	AND	SI,7FH			; ..
        CMP     SI,11                   ; ..
	JE	SetModeOK		; ..

;Save video mode just set
	POP	SI			;Restore SI

        CMP     CS:[Mode],11            ;See if previous mode was 640x200x16
        JNE     SetMode1                ; ..

        PUSH    AX                      ;Save registers
        PUSH    CX                      ; ..
        PUSH    DX                      ; ..
        CALL    ResetVid                ;Reset the video controller registers
        POP     DX                      ; .. after 640x200x16 color mode is 
        POP     CX                      ; .. used
        POP     AX                      ; ..

SetMode1:
	PUSHF				;Call normal video BIOS
	CALL	OldINT10H		; ..
	PUSH	ES			;Save current video mode
	MOV	AX,BIOSData		; ..
	MOV	ES,AX			; ..
	MOV	AL,CRTMode		; ..
	MOV	CS:[Mode],AL		; ..
	POP	ES			; ..
	IRET				;Return from interrupt handler

SetModeOK:
	PUSHR				;Save registers
	CLD				;Make sure string op's go forward
	MOV	SI,CS			;Establish local data segment
	MOV	DS,SI			; ..
	MOV	[Mode],AL		;Save video mode number
	MOV	SI,OFFSET Mode11	;Point to reg values for video system

;Disable the video display during initialization
	MOV	DX,3D8H			;Program Mode Select register to
	LODSB				; .. disable the video display
	OUT	DX,AL			; ..

;Initialize 6845 CRTC register values
	MOV	DX,3D4H			;Initialize 6845 CRTC registers 0-7
	MOV	AH,0			; ..
SetMode2:				; ..
	LODSB				; ..
	XCHG	AH,AL			; ..
	OUT	DX,AL			; ..
	XCHG	AH,AL			; ..
	INC	DX			; ..
	OUT	DX,AL			; ..
	DEC	DX			; ..
	INC	AH			; ..
	CMP	AH,7			; ..
	JLE	SetMode2		; ..
	MOV	AH,9			;Initialize 6845 CRTC register 9
	LODSB				; ..
	XCHG	AH,AL			; ..
	OUT	DX,AL			; ..
	XCHG	AH,AL			; ..
	INC	DX			; ..
	OUT	DX,AL			; ..
	DEC	DX			; ..
	MOV	AH,0CH			;Initialize 6845 CRTC register 12
	LODSB				; ..
	XCHG	AH,AL			; ..
	OUT	DX,AL			; ..
	XCHG	AH,AL			; ..
	INC	DX			; ..
	OUT	DX,AL			; ..
	DEC	DX			; ..
	MOV	AH,10H			;Initialize 6845 CRTC registers 16-18
SetMode3:				; ..
	LODSB				; ..
	XCHG	AH,AL			; ..
	OUT	DX,AL			; ..
	XCHG	AH,AL			; ..
	INC	DX			; ..
	OUT	DX,AL			; ..
	DEC	DX			; ..
	INC	AH			; ..
	CMP	AH,12H			; ..
	JLE	SetMode3		; ..

;Initialize remaining Video subsystem register values
	MOV	DX,3D9H			;Initialize Color Select register
	LODSB				; ..
	OUT	DX,AL			; ..
	MOV	DX,3DDH			;Initialize Extended RAM Page register
	LODSB				; ..
	OUT	DX,AL			; ..
	MOV	CX,3DEH			;Initialize Video Array Data registers
	MOV	DX,3DAH			; ..
	MOV	AH,1			; ..
SetMode4:				; ..
	LODSB				; ..
	XCHG	AH,AL			; ..
	OUT	DX,AL			; ..
	XCHG	AH,AL			; ..
	XCHG	CX,DX			; ..
	OUT	DX,AL			; ..
	XCHG	CX,DX			; ..
	INC	AH			; ..
	CMP	AH,3			; ..
	JLE	SetMode4		; ..
	MOV	AL,5			; ..
	OUT	DX,AL			; ..
	LODSB				; ..
	XCHG	CX,DX			; ..
	OUT	DX,AL			; ..
	XCHG	CX,DX			; ..
	MOV	AL,8			; ..
	OUT	DX,AL			; ..
	LODSB				; ..
	XCHG	CX,DX			; ..
	OUT	DX,AL			; ..
	XCHG	CX,DX			; ..
	MOV	DX,3DFH			;Initialize CRT Processor Page register
	LODSB				; ..
	OUT	DX,AL			; ..
	PUSH	SI			;Save register values pointer

;Set color palette registers to default state
	MOV	CX,16			;Reset colors 0-15 to default state
	XOR	BH,BH			;Set initial color
	XOR	BL,BL			;Set initial paletter register
	MOV	DI,2			;Reset border color
	CALL	SetPal1			; ..
SetMode5:
	CALL	SetPal			;Set palette register
	INC	BL			;Bump up to next palette register
	INC	BH			;Bump up to next color
	LOOP	SetMode5		;Do remaining palette registers

;See if we should clear the screen
	TEST	[Mode],80H		;Check if screen should be cleared
	JNZ	SetMode6		; ..
	CALL	ClearScreen		; ..
	AND	[Mode],7FH		;Clear bit 7 of mode variable

;Re-enable the video display
SetMode6:
	POP	SI			;Restore regiser values pointer
	MOV	DX,3D8H			;Initialize Mode Select register
	LODSB				; ..
	OUT	DX,AL			; ..

;Initialize BIOS data area values
	MOV	DI,BIOSData		;ES:DI points to video BIOS data area
	MOV	ES,DI			; ..
	MOV	DI,VideoBIOS		; ..
	MOV	SI,OFFSET VideoData	;DS:SI points to data to copy
	MOV	CX,30			;Get number of bytes to copy
	REP	MOVSB			;Copy in new video BIOS data values
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;
;Reset video controller registers after entering 640x200x16 color mode
;
ResetVid:
	MOV	DX,3D8H
	MOV	AL,1
	OUT	DX,AL
	;
	; Load the CRTC registers.
	;
	MOV	DX,3D4H
	MOV	AL,0
	OUT	DX,AL
	INC	DX
	MOV	AL,71H
	OUT	DX,AL
	DEC	DX

	MOV	AL,1
	OUT	DX,AL
	INC	DX
	MOV	AL,50H
	OUT	DX,AL
	DEC	DX

	MOV	AL,2
	OUT	DX,AL
	INC	DX
	MOV	AL,5AH
	OUT	DX,AL
	DEC	DX

	MOV	AL,3
	OUT	DX,AL
	INC	DX
	MOV	AL,0FEH
	OUT	DX,AL
	DEC	DX

	MOV	AL,4
	OUT	DX,AL
	INC	DX
	MOV	AL,1CH
	OUT	DX,AL
	DEC	DX

	MOV	AL,5
	OUT	DX,AL
	INC	DX
	MOV	AL,01H
	OUT	DX,AL
	DEC	DX

	MOV	AL,6
	OUT	DX,AL
	INC	DX
	MOV	AL,19H
	OUT	DX,AL
	DEC	DX

	MOV	AL,7
	OUT	DX,AL
	INC	DX
	MOV	AL,1AH
	OUT	DX,AL
	DEC	DX

	MOV	AL,9
	OUT	DX,AL
	INC	DX
	MOV	AL,8
	OUT	DX,AL
	DEC	DX

	MOV	AL,0AH
	OUT	DX,AL
	INC	DX
	MOV	AL,6
	OUT	DX,AL
	DEC	DX

	MOV	AL,0BH
	OUT	DX,AL
	INC	DX
	MOV	AL,07H
	OUT	DX,AL
	DEC	DX

	MOV	AL,0CH
	OUT	DX,AL
	INC	DX
	MOV	AL,0
	OUT	DX,AL
	DEC	DX

	MOV	AL,0DH
	OUT	DX,AL
	INC	DX
	MOV	AL,0
	OUT	DX,AL
	DEC	DX

	MOV	AL,0EH
	OUT	DX,AL
	INC	DX
	MOV	AL,0
	OUT	DX,AL
	DEC	DX

	MOV	AL,0FH	
	OUT	DX,AL
	INC	DX
	MOV	AL,0
	OUT	DX,AL
	DEC	DX

	MOV	AL,10H
	OUT	DX,AL
	INC	DX
	MOV	AL,18H
	OUT	DX,AL
	DEC	DX

	MOV	AL,11H		; undocumented register
	OUT	DX,AL
	INC	DX
	MOV	AL,20H
	OUT	DX,AL
	DEC	DX

	MOV	AL,12H
	OUT	DX,AL
	INC	DX
	MOV	AL,07H
	OUT	DX,AL
	DEC	DX

	MOV	AL,13H
	OUT	DX,AL
	INC	DX
	MOV	AL,0
	OUT	DX,AL
	;
	; Set border color register.
	;
	MOV	DX,3D9H
	MOV	AL,0
	OUT	DX,AL
	;
	; Set the extended addressing mode register.
	;
	MOV	DX,3DDH
	MOV	AL,0
	OUT	DX,AL
	;
	; Set the video array registers.
	;
	MOV	DX,3DAH
	MOV	CX,3DEH
	MOV	AL,1
	OUT	DX,AL
	XCHG	DX,CX
	MOV	AL,0FH
	OUT	DX,AL
	XCHG	DX,CX

	MOV	AL,2
	OUT	DX,AL
	XCHG	DX,CX
	MOV	AL,0
	OUT	DX,AL
	XCHG	DX,CX

	MOV	AL,3
	OUT	DX,AL
	XCHG	DX,CX
	MOV	AL,10H
	OUT	DX,AL
	XCHG	DX,CX

	MOV	AL,5
	OUT	DX,AL
	XCHG	DX,CX
	MOV	AL,0
	OUT	DX,AL
	XCHG	DX,CX

	MOV	AL,8
	OUT	DX,AL
	XCHG	DX,CX
	MOV	AL,0
	OUT	DX,AL
	;
	; Set the CRT/Processor Page Register.
	;
	MOV	DX,3DFH
	MOV	AL,3FH
	OUT	DX,AL
	;
	; Reenable video (blink enabled).
	;
	MOV	DX,3D8H
	MOV	AL,29H
	OUT	DX,AL
        RET

;Subroutine to set a palette register
SetPal:
	MOV	DI,16			;Port offset for palette registers

;Entered here to set border color
SetPal1:
	MOV	DX,3DAH			;Address & status register
	CLI				;Disable interrupts
SetPal2:
	IN	AL,DX			;Get status register
	AND	AL,8			;Look for bit 3
	JZ	SetPal2			;Wait for vertical retrace
	MOV	AL,BL			;Get palette number
	CBW				; ..
	ADD	AX,DI			;Add offset for palette register
	OUT	DX,AL			;Set palette
	MOV	AL,BH			;Get color to store
	MOV	DX,3DEH			;Palette data register
	OUT	DX,AL			;Set palette color
	MOV	DX,3DAH			;Address & status register
	XOR	AX,AX			;AL = 0 to reset address register
	OUT	DX,AL			;Reset it
	STI				;Re-enable interrupts
	RET

;Subroutine to clear the screen
ClearScreen:
	MOV	DI,VideoSeg		;ES:DI points to video buffer
	MOV	ES,DI			; ..
	XOR	DI,DI			; ..
	XOR	AX,AX			;Clear value in AX
	MOV	CX,32000		;Get number of bytes to process
	REP	STOSW			;Clear the video buffer
	RET

;
;Set cursor type function (Not supported in graphics mode)
;

SetCursorType:
	JMP	ExecINT10H		;Execute normal BIOS INT 10H

;
;Set cursor position function
;

SetCursorPos:
	CMP	DL,79			;Validate column (0-79)
	JA	SetCursorPos1		; ..
	CMP	DH,24			;Validate row (0-24)
	JA	SetCursorPos1		; ..
	PUSH	ES			;Save ES
	MOV	AX,BIOSData		;Get segment address of BIOS data area
	MOV	ES,AX			; ..
	MOV	CursorPos,DX		;Update cursor position
	POP	ES			;Restore ES
SetCursorPos1:
	POP	SI			;Restore SI
	IRET				;Return from interrupt handler

;
;Get cursor position function:
;

GetCursorPos:
	PUSH	ES			;Save ES
	MOV	DX,BIOSData		;Get segment address of BIOS data area
	MOV	ES,DX			; ..
	MOV	DX,CursorPos		;Return current cursor position in DX
	MOV	CX,CursorType		;Return current cursor type in CX
	POP	ES			;Restore ES
	POP	SI			;Restore SI
	IRET				;Return from interrupt handler

;
;Read light pen status funcion
;

ReadLightPen:
	JMP	ExecINT10H		;Execute normal BIOS INT 10H

;
;Select active page function
;

SelectPage:
	JMP	ExecINT10H		;Execute normal BIOS INT 10H

;
;Scroll up function
;

ScrollUp:
	PUSHR				;Save registers
	MOV	CS:[UpDn],0		;Scroll the screen up
	CALL	ScrollIt		; ..
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;
;Scroll down function
;

ScrollDown:
	PUSHR				;Save registers
	MOV	CS:[UpDn],1		;Scroll the screen down
	CALL	ScrollIt		; ..
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;Subroutine to scroll window up or down
ScrollIt:
	CMP	CL,79			;Validate column number
	JA	ScrollItA		; ..
	CMP	DL,79			; ..
	JA	ScrollItA		; ..
	CMP	CL,DL			; ..
	JA	ScrollItA		; ..
	CMP	CH,24			;Validate row number
	JA	ScrollItA		; ..
	CMP	DH,24			; ..
	JA	ScrollItA		; ..
	CMP	CH,DH			; ..
	JA	ScrollItA		; ..
	JMP	SHORT ScrollItB
ScrollItA:
	RET
ScrollItB:
	CLD				;Make sure string op's go forward
	MOV	SI,VideoSeg		;Point ES at video buffer
	MOV	ES,SI			; ..
	MOV	SI,CS			;Setup local data segment
	MOV	DS,SI			; ..
	MOV	BL,BH			;Form full word of color
	CBW				;Save number of lines to scroll
	MOV	[Scroll],AX		; ..
	MOV	AL,CL			;Get X1 position
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	[X1],AX			; ..
	MOV	AL,CH			;Get Y1 position
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	[Y1],AX			; ..
	MOV	AL,DL			;Get X2 position
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	[X2],AX			; ..
	MOV	AL,DH			;Get Y2 position
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	[Y2],AX			; ..
	SUB	AX,[Y1]			;Get total number of lines
	ADD	AX,8			; ..
	MOV	[NumLines],AX		; ..
	MOV	AX,[X2]			;Get number of bytes per line
	SUB	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	AX,4			; ..
	SHR	AX,1			; ..
	MOV	[NumBytes],AX		; ..
;See if entire window should be blanked
	MOV	AX,[Scroll]		;Check number of lines to scroll is
	SHL	AX,1			; .. same as window size
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	CMP	AX,[NumLines]		; ..
	JAE	ScrollIt1		; ..
	CMP	[Scroll],0		;Check for 0
	JE	ScrollIt1		; ..
	CMP	[Scroll],24		;Check for above 24
	JBE	ScrollIt2		; ..
;Blank entire window
ScrollIt1:
	MOV	DI,[Y1]			;Get starting address for ES:DI
	SHL	DI,1			; ..
	MOV	DI,ScanLine[DI]		; ..
	MOV	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	DI,AX			; ..
	MOV	CX,[NumLines]		;Get number of lines to blank
	JMP	ScrollIt7		; ..
ScrollIt2:
	CMP	[UpDn],1		;Check if scrolling up or down
	JE	ScrollIt3		; ..
;Scrolling up
	MOV	DI,[Y1]			;Get starting address for ES:DI
	SHL	DI,1			; ..
	MOV	DI,ScanLine[DI]		; ..
	MOV	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	DI,AX			; ..
	MOV	SI,DI			;Get starting address for DS:SI
	MOV	AX,2560			; ..
	MUL	[Scroll]		; ..
	ADD	SI,AX			; ..
	MOV	DX,320			; ..
	JMP	ScrollIt4		; ..
;Scrolling down
ScrollIt3:
	MOV	DI,[Y2]			;Get starting address for ES:DI
	SHL	DI,1			; ..
	MOV	DI,ScanLine[DI]		; ..
	MOV	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	DI,AX			; ..
	ADD	DI,2240			; ..
	MOV	AX,2560			;Get start address for DS:SI
	MUL	[Scroll]		; ..
	MOV	SI,DI			; ..
	SUB	SI,AX			; ..
	MOV	DX,-320			; ..
ScrollIt4:
	MOV	AX,[Scroll]		;Get number of lines to scroll
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	CX,[NumLines]		; ..
	SUB	CX,AX			; ..
	PUSH	AX			;Save registers
	PUSH	DS			; ..
	MOV	AX,[NumBytes]		;Get number of bytes per line
	PUSH	ES			;Point DS at video buffer
	POP	DS			; ..
;Scroll the screen
ScrollIt5:
	PUSH	CX			;Save registers
	PUSH	SI			; ..
	PUSH	DI			; ..
	MOV	CX,AX			;Get number of bytes to move
	REP	MOVSW			;Move the lines
	POP	DI			;Restore registers
	POP	SI			; ..
	POP	CX			; ..
	ADD	SI,DX			;Point to next set of scan lines
	ADD	DI,DX			; ..
	LOOP	ScrollIt5		;Do next set of scan lines
	POP	DS			;Restore registers
	POP	CX			; ..
	CMP	[UpDn],1		;Check if scrolling up or down
	JE	ScrollIt6		; ..
;Scrolling up
	MOV	DI,[Y2]			;Get starting address for ES:DI
	SHL	DI,1			; ..
	MOV	DI,ScanLine[DI]		; ..
	MOV	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	DI,AX			; ..
	MOV	AX,2560			; ..
	MUL	[Scroll]		; ..
	ADD	DI,2560			; ..
	SUB	DI,AX			; ..
	JMP	ScrollIt7		; ..
;Scrolling down
ScrollIt6:
	MOV	DI,[Y1]			;Get starting address for ES:DI
	SHL	DI,1			; ..
	MOV	DI,ScanLine[DI]		; ..
	MOV	AX,[X1]			; ..
	SHR	AX,1			; ..
	ADD	DI,AX			; ..
;Blank the window
ScrollIt7:
	MOV	AX,BX			;Get fill color
	MOV	BX,[NumBytes]		;Get number of bytes per line
ScrollIt8:
	PUSH	CX			;Blank the window
	PUSH	DI			; ..
	MOV	CX,BX			; ..
	REP	STOSW			; ..
	POP	DI			; ..
	POP	CX			; ..
	ADD	DI,320			; ..
	LOOP	ScrollIt8		; ..
	RET

;
;Get character function:
;

GetChar:
	POP	SI			;Restore SI
	PUSHR				;Save registes
	MOV	SI,CS			;Establish local data segment
	MOV	DS,SI			; ..
	MOV	BX,BIOSData		;Point ES at BIOS data area
	MOV	ES,BX			; ..
	MOV	BX,CursorPos		;Get current cursor position
	MOV	AL,BH			;Get current row (Y position)
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	SI,AX			;Get address of scan line
	SHL	SI,1			; ..
	MOV	SI,ScanLine[SI]		; ..
	MOV	AL,BL			;Get current column (X position)
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHR	AX,1			;Add column offset
	ADD	SI,AX			; ..
	MOV	AX,DS			;Point ES at current data segment
	MOV	ES,AX			; ..
	MOV	DI,OFFSET GraphChar	;Point DI at compare buffer
	PUSH	DS			;Save DS
	MOV	CX,VideoSeg		;Point DS at video buffer
	MOV	DS,CX			; ..
	MOV	CX,8			;Do 8 scan lines
	MOV	BX,0F00FH		;Set up clear pixel mask
	MOV	AH,80H			;Set up accumulator mask
GetChar1:
	PUSH	CX			;Save register
	MOV	CX,4			;4 bytes per scan line
	XOR	DL,DL			;Clear accumulator byte
GetChar2:
	PUSH	CX			;Save register
	LODSB				;Get a byte from video memory
	MOV	DH,AL			;Save byte
	AND	AL,BH			;Clear lower nybble
	OR	AL,AL			;See if it's 0
	JZ	GetChar3		; ..
	OR	DL,AH			;Store bit pattern in accumulator byte
GetChar3:
	ROR	AH,1			;Move to next accumulator bit
	AND	DH,BL			;Clear upper nybble
	OR	DH,DH			;See if it's 0
	JZ	GetChar4		; ..
	OR	DL,AH			;Store bit pattern in accumulator byte
GetChar4:
	ROR	AH,1			;Move to next accumulator bit
	POP	CX			;Restore register
	LOOP	GetChar2		;Do rest of scan line bytes
	MOV	AL,DL			;Store byte in compare buffer
	STOSB				; ..
	POP	CX			;Restore register
	ADD	SI,316			;Point to next scan line
	LOOP	GetChar1		;Do next scan line
	POP	DS			;Restore DS

;Search ASCII characters 0-127
	XOR	AX,AX			;Point ES:DX at ASCII characters 0-127
	MOV	ES,AX			; ..
	LES	DX,ASCII1		; ..
	MOV	BX,OFFSET GraphChar	;Point BX at compare buffer
	MOV	CX,1024			;Scan length of character table
	CALL	ScanCharTable		;See if it's there
	CMP	AX,0			;See if we have a match
	JE	GetChar5		; ..

;We have a match with ASCII characters 0-127
	XOR	AX,AX			;Point ES at ASCII characters 0-127
	MOV	ES,AX			; ..
	SUB	DX,ASCII1		;Get value of ASCII character
	SHR	DX,1			; ..
	SHR	DX,1			; ..
	SHR	DX,1			; ..
	JMP	SHORT GetChar7		; ..

;Search ASCII characters 128-255
GetChar5:
	XOR	AX,AX			;Point ES:DX at ASCII char's 128-255
	MOV	ES,AX			; ..
	LES	DX,ASCII2		; ..
	MOV	BX,OFFSET GraphChar	;Point BX at compare buffer
	MOV	CX,1024			;Scan length of character table
	CALL	ScanCharTable		;See if it's there
	CMP	AX,1			;See if we have a match
	JE	GetChar6		; ..
	XOR	DX,DX			;No match return 0 value
	JMP	SHORT GetChar7		; ..

;We have a match with ASCII characters 128-255
GetChar6:
	XOR	AX,AX			;Point ES at ASCII characters 128-255
	MOV	ES,AX			; ..
	SUB	DX,ASCII2		;Get value of ASCII character
	SHR	DX,1			; ..
	SHR	DX,1			; ..
	SHR	DX,1			; ..
	ADD	DX,128			; ..
GetChar7:
	MOV	AX,DX			;Return ASCII character value
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;Subtroutine to scan for a substring with another string
ScanCharTable:
	MOV	SI,BX			;Get source string
	MOV	DI,DX			;Get destination string
	MOV	AL,[SI]			;Scan for 1st byte of string
	CLD				; ..
	REPNZ	SCASB			; ..
	JCXZ	ScanCharTable1		;No match so exit

;1st byte of string matches, so check the rest of it
	MOV	DX,DI			;Save destination
	DEC	DI			;Point to beginning of string
	MOV	AX,8			;Get length of string
	XCHG	AX,CX			;Use source count
	REPZ	CMPSB			;Check for rest of string
	JCXZ	ScanCharTable2		;It's a match
	XCHG	AX,CX			;Use destination count and look through
	JMP	SHORT ScanCharTable	; .. rest of the string

;No matching string found
ScanCharTable1:
	MOV	AX,0			;No match:  AX = 0 (FALSE)
	RET				; ..

;Matching string found
ScanCharTable2:
	MOV	AX,1			;Match:  AX = 1 (TRUE)
	RET				; ..

;
;Write character/attribute function
;  (WriteCharAtrb and WriteChar are indentical in graphics mode)
;

WriteCharAtrb:

;
;Write character only function
;

WriteChar:
	PUSHR				;Save registers
	CALL	PutChar			;Write an ASCII character to the screen
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;
;Set color palette function
;

SetColorPal:
	JMP	ExecINT10H		;Execute normal video BIOS call

;
;Write dot function
;

PlotPoint:
	PUSH	CX			;Save registers
	MOV	SI,DX			;Get scan line address
	SHL	SI,1			; ..
	MOV	SI,CS:ScanLine[SI]	; ..
	OR	AL,AL			;See if pixel should be XOR'ed over
	JS	XorPoint		; .. existing pixel
	SHR	CX,1			;Get column offset
	JC	PlotPointOdd		;Check for odd/even pixel

;Plot a pixel for an even address
	ADD	SI,CX			;Add column offset to address
	MOV	CL,4			;Move color to proper position
	SHL	AL,CL			; ..
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	MOV	AH,[SI]			;Plot the point
	AND	AH,0FH			; ..
	OR	AH,AL			; ..
	MOV	[SI],AH			; ..
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;Plot a pixel for an odd address
PlotPointOdd:
	ADD	SI,CX			;Add column offset to address
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	MOV	AH,[SI]			;Plot the point
	AND	AH,0F0H			; ..
	OR	AH,AL			; ..
	MOV	[SI],AH			; ..
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;Xor a pixel onto the screen
XorPoint:
	AND	AL,7FH			;Clear bit 7 of AL
	SHR	CX,1			;Get column offset
	JC	XorPointOdd		;Check for odd/even pixel

;Xor a pixel for an even address
	ADD	SI,CX			;Add column offset to address
	MOV	CL,4			;Move color to proper position
	SHL	AL,CL			; ..
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	XOR	[SI],AL			;XOR the pixel over existing pixel
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;Xor a pixel for an odd address
XorPointOdd:
	ADD	SI,CX			;Add column offset to address
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	XOR	[SI],AL			;XOR the pixel over existing pixel
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;
;Get dot function
;

GetPoint:
	PUSH	CX			;Save registers
	PUSH	DS			; ..
	MOV	SI,DX			;Get scan line address
	SHL	SI,1			; ..
	MOV	SI,CS:ScanLine[SI]	; ..
	SHR	CX,1			;Get column offset
	JC	GetPointOdd		;Check for odd/even pixel

;Get pixel for an even address
	ADD	SI,CX			;Add column offset to address
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	MOV	AL,[SI]			;Get the pixel
	SHR	AL,1			; ..
	SHR	AL,1			; ..
	SHR	AL,1			; ..
	SHR	AL,1			; ..
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;Get pixel for an odd address
GetPointOdd:
	ADD	SI,CX			;Add column offset to address
	MOV	CX,DS			;Save DS
	MOV	DS,CS:[VideoBuf]	;Point DS at video buffer
	MOV	AL,[SI]			;Get the pixel
	AND	AL,0FH			; ..
	MOV	DS,CX			;Restore DS
	POP	CX			;Restore registers
	POP	SI			; ..
	IRET				;Return from interrupt

;
;Write a character in teletype mode function
;

;Check for control characters #7, #8, #10, and #13
WriteTTY:
	PUSHR				;Save registers
	MOV	SI,BIOSData		;Point ES at BIOS data area
	MOV	ES,SI			; ..
	MOV	CX,CursorPos		;Get current cursor position
	CMP	AL,7			;Check for Bell #7
	JNE	WriteTTY1		; ..
	CALL	Bell			; ..
	JMP	SHORT WriteTTY6		; ..
WriteTTY1:
	CMP	AL,8			;Check for Backspace #8
	JNE	WriteTTY2		; ..
	CALL	BackSpace		; ..
	JMP	SHORT WriteTTY5		; ..
WriteTTY2:
	CMP	AL,10			;Check for Linefeed #10
	JNE	WriteTTY3		; ..
	CALL	LineFeed		; ..
	JMP	SHORT WriteTTY5		; ..
WriteTTY3:
	CMP	AL,13			;Check for Carriage return #13
	JNE	WriteTTY4		; ..
	CALL	CarriageRtn		; ..
	JMP	SHORT WriteTTY5		; ..

;Write the character on the screen
WriteTTY4:
	PUSH	CX			;Save registers
	PUSH	ES			; ..
	MOV	CX,1			;Write 1 character
	CALL	PutChar			;Write the character on screen
	POP	ES			;Restore registers
	POP	CX			; ..

;Update the BIOS data area Cursor Position variable
	INC	CL			;Bump up to next screen position
	CMP	CL,80			;Check if at last column position
	JB	WriteTTY5		; ..
	CALL	CarriageRtn		; ..
	CALL	LineFeed		; ..
WriteTTY5:
	MOV	CursorPos,CX		;Update the Cursor Position variable
WriteTTY6:
	POPR				;Restore registers
	IRET				;Return from interrupt handler

;Subroutine to handle control character #7 (Bell)
Bell:
	PUSHF				;Execute normal video BIOS call
	CALL	OldINT10H		; ..
	RET

;Subroutine to handle control character #8 (Backspace)
BackSpace:
	DEC	CL			;Point to previous column position
	JNL	BackSpace1		;Check if we should back up 1 row
	MOV	CL,79			; ..
	DEC	CH			; ..
	JNL	BackSpace1		; ..
	MOV	CH,0			; ..
BackSpace1:
	RET

;Subroutine to handle control character #10 (Linefeed)
LineFeed:
	INC	CH			;Bump up to next row
	CMP	CH,24			;Check if we should scroll the screen
	JBE	LineFeed1		; .. 1 line

;Scroll the screen 1 line
	PUSH	CX			;Save registers
	PUSH	ES			; ..
	MOV	AL,1			;Scroll up 1 line
	MOV	BH,0			;Use current background color
	MOV	CX,0			;Upper left row, column in CX
	MOV	DX,184FH		;Lower right row, column in DX
	MOV	CS:[UpDn],0		;Indicate to scroll up
	CALL	ScrollIt		;Scroll the screen
	POP	ES			;Restore registers
	POP	CX			; ..
	MOV	CH,24			;Set current row to bottom of screen
LineFeed1:
	RET

;Subroutine to handle control character #13 (Carriage return)
CarriageRtn:
	MOV	CL,0			;Set current column to 0
	RET

;Subroutine to write an ASCII character onto the graphics screen at the current
;cursor position the specified amount of times in CX
PutChar:
	CLD				;Make sure string op's go forward
	MOV	BP,AX			;Save ASCII character
	MOV	AX,BIOSData		;Point ES at BIOS data area
	MOV	ES,AX			; ..
	MOV	AX,CursorPos		;Get scan line address
	MOV	DX,AX			; ..
	MOV	AL,AH			; ..
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	MOV	DI,AX			; ..
	SHL	DI,1			; ..
	MOV	DI,CS:ScanLine[DI]	; ..
	MOV	AL,DL			;Add column offset
	CBW				; ..
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	ADD	DI,AX			; ..
	MOV	AX,BP			;Restore ASCII character
	XOR	DX,DX			;Point ES at interrupt vector table
	MOV	ES,DX			; ..
	LDS	SI,ASCII1		;Get address of ASCII characters 0-127
	OR	AL,AL			;Check for ASCII character 128-155
	JNS	PutChar1		; ..
	LDS	SI,ASCII2		;Get address of ASCII characters 128-255
	SUB	AL,128			;Adjust ASCII value back to 0-127
PutChar1:
	CBW				;Get starting position in ASCII
	SHL	AX,1			; .. character table
	SHL	AX,1			; ..
	SHL	AX,1			; ..
	ADD	SI,AX			; ..
	MOV	DX,VideoSeg		;Point ES video buffer
	MOV	ES,DX			; ..
	OR	BL,BL			;See if ASCII character should XOR'ed
	JS	XorChar			; .. over old character

;Write an ASCII character over existing one at current cursor position
	MOV	BH,BL			;Form OR value in BX
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	MOV	DL,80H			;Set up test bit mask
PutChar3:
	PUSH	CX			;Save character counter
	MOV	CX,8			;Do 8 scan lines
PutChar4:
	MOV	BP,4			;Do 4 bytes per scan line
	LODSB				;Get a byte from character table
	MOV	DH,AL			;Store byte in DH
PutChar5:
	XOR	AL,AL			;Clear accumulator
	TEST	DH,DL			;See if we should store the pixel
	JZ	PutChar6		; ..
	OR	AL,BL			;Store the pixel
PutChar6:
	ROR	DL,1			;Point to next test bit
	TEST	DH,DL			;See if we should store the pixel
	JZ	PutChar7		; ..
	OR	AL,BH			;Store the pixel
PutChar7:
	ROR	DL,1			;Point to next test bit
	STOSB				;Move byte into video buffer
	DEC	BP			;Do next byte of scan line
	JNZ	PutChar5		;Do next byte of scan line
	ADD	DI,316			;Point to next scan line
	LOOP	PutChar4		;Do next scan line
	SUB	SI,8			;Restore character table pointer
	SUB	DI,2556			;Point to next character position
	POP	CX			;Restore character counter
	LOOP	PutChar3		;Do next character
	RET

;XOR an ASCII character over existing one at current cursor position
XorChar:
	AND	BL,7FH			;Clear bit 7 of BL
	MOV	BH,BL			;Form XOR value in BX
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	SHL	BL,1			; ..
	MOV	DL,80H			;Set up test bit mask
XorChar1:
	PUSH	CX			;Save character counter
	MOV	CX,8			;Do 8 scan lines
XorChar2:
	MOV	BP,4			;Do 4 bytes per scan line
	LODSB				;Get a byte from character table
	MOV	DH,AL			;Store byte in DH
XorChar3:
	MOV	AL,ES:[DI]		;Get a byte from video buffer
	TEST	DH,DL			;See if pixel should be XOR'ed
	JZ	XorChar4		; ..
	XOR	AL,BL			;XOR current pixel over old one
XorChar4:
	ROR	DL,1			;Point to next test bit
	TEST	DH,DL			;See if pixel should be XOR'ed
	JZ	XorChar5		; ..
	XOR	AL,BH			;XOR current pixel over old one
XorChar5:
	ROR	DL,1			;Point to next test bit
	STOSB				;Move byte into video buffer
	DEC	BP			;Do next byte on scan line
	JNZ	XorChar3		; ..
	ADD	DI,316			;Point to next scan line
	LOOP	XorChar2		;Do next scan line
	SUB	SI,8			;Restore character table pointer
	SUB	DI,2556			;Point to next character position
	POP	CX			;Restore character counter
	LOOP	XorChar1		;Do next character
	RET

;
;Get video mode function
;

GetMode:
	PUSH	ES			;Save ES
	MOV	AX,BIOSData		;Point ES at BIOS data area
	MOV	ES,AX			; ..
	MOV	AX,ScreenWidth		;Get current number of screen columns
	MOV	AH,CRTMode		;Get current video mode
	XCHG	AH,AL			;Return current mode & screen columns
	MOV	BH,CurrentPage		;Return current video page
	POP	ES			;Restore ES
	POP	SI			;Restore SI
	IRET				;Return from interrupt handler
;
;Set palette registers function:
;

SetPalette:
	JMP	ExecINT10H		;Execute normal BIOS INT 10H

;
;Return residency status of driver
;

Special:
	POP	SI			;Retore SI
	CMP	AX,0FF00H		;Return residency status?
	JNE	SpecialExit		; ..
	CMP	BX,0			;Validate it's a call to this program
	JNE	SpecialExit		; ..
	MOV	AX,0DEADH		;Indicate this program is resident
	IRET				;Return from interrupt handler
SpecialExit:
	JMP	OldINT10H		;Execute normal video BIOS call

Video		ENDP

;-------------------------------------------------------------------------------

;
;Checks if computer is a Tandy 1000 SL/TL, then checks if the Tandy 1000 SL/TL
;is in monochrome mode, and finally checks to see if the program is already
;resident. If all these inspections pass, the program will install itself.
;

Initialize	PROC	NEAR

;Verify computer is a Tandy 1000 SL/TL
	MOV	AX,0FFFFH		;Check byte at FFFF:000E for FFH
	MOV	ES,AX			; .. (IBM PC compatible)
	CMP	BYTE PTR ES:[0EH],0FFH	; ..
	JE	Initialize1		; ..
	MOV	DX,OFFSET ErrorMsg1	;Computer not an IBM PC compatible
	JMP	InstallError		; ..
Initialize1:
	MOV	AX,0FC00H		;Check byte at FC00:0000 for 21H
	MOV	ES,AX			; .. (Tandy 1000 unique)
	CMP	BYTE PTR ES:[0],21H	; ..
	JE	Initialize2		; ..
	MOV	DX,OFFSET ErrorMsg1	;Computer not a Tandy 1000 series
	JMP	InstallError		; ..
Initialize2:
	MOV	AH,0C0H			;Use machine indentification service on
	INT	15H			; .. Tandy 1000 SL/TL
	JNC	Initialize3		; ..
	MOV	DX,OFFSET ErrorMsg1	;Computer not a Tandy 1000 SL/TL
	JMP	InstallError		; ..
Initialize3:
	CMP	BYTE PTR ES:[BX+2],0FFH ;Check model ID byte
	JE	Initialize4		; .. (0FFH = Tandy 1000 SL/TL)
	MOV	DX,OFFSET ErrorMsg1	;Computer not a Tandy 1000 SL/TL
	JMP	InstallError		; ..

;See if the program is already installed
Initialize4:
	MOV	AX,0FF00H		;Check if program is already installed
	MOV	BX,0			; ..
	INT	10H			; ..
	CMP	AX,0DEADH		; ..
	JNE	Initialize5		; ..
	MOV	DX,OFFSET ErrorMsg2	;Program already installed
	JMP	InstallError		; ..

;Save old video interrupt
Initialize5:
	MOV	AH,35H			;Get interrupt vector
	MOV	AL,10H			; ..
	INT	21H			; ..
	MOV	[INT10H],BX		;Save the old video vector
	MOV	[INT10H+2],ES		; ..

;Install new interrupt
	MOV	AH,25H			;Set interrupt vector
	MOV	AL,10H			; ..
	MOV	DX,OFFSET Video		; ..
	INT	21H			; ..

;Print installed message
	MOV	AH,9			;Print installed message
	MOV	DX,OFFSET InstallMsg	; ..
	INT	21H			; ..

;Terminate and stay resident
	MOV	ES,CS:[2CH]		;Get environment segment
	MOV	AH,49H			;Free memory function
	INT	21H			; ..
	MOV	AX,3100H		;Keep process function
	MOV	DX,OFFSET Initialize	;Point to last byte of TSR code
	MOV	CL,4			;Get # of paragraphs to keep
	SHR	DX,CL			; ..
	INC	DX			; ..
	INT	21H			; ..

;Print error message and exit
InstallError:
	MOV	AH,9			;Print error message
	INT	21H			; ..
	MOV	AX,4CFFH		;Exit with error code of 255
	INT	21H			; ..

ErrorMsg1	DB	7
		DB	13,10
		DB	'TANDY11 only runs on a Tandy 1000 SL/TL'
		DB	13,10
		DB	'$'

ErrorMsg2	DB	7
		DB	13,10
		DB	'TANDY11 is already installed!'
		DB	13,10
		DB	'$'

InstallMsg	DB	13,10
		DB	'TANDY11 1.1  Copyright (C) 1989-2005 by '
		DB	'Joseph A. Albrecht'
		DB	13,10
		DB	13,10
		DB	'Tandy 1000 SL/TL 640x200x16 color graphics BIOS '
		DB	'support routines now installed.'
		DB	13,10
		DB	'$'

Initialize	ENDP

;-------------------------------------------------------------------------------

Code		ENDS
;*******************************************************************************

		END	Begin
