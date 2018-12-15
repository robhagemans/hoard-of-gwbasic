	PAGE	60,132
	TITLE	Tandy 1000 Graphics And Sound Extensions
	NAME	GRAFIX

;------------------------------------------------------------------------------;
;									       ;
;				  GRAFIX 2.60				       ;
;									       ;
;		   Tandy 1000 Graphics And Sound Extensions		       ;
;			160x200x16 Color Graphics Mode			       ;
;			320x200x16 Color Graphics Mode			       ;
;			640x200x16 Color Graphics Mode			       ;
;		     Texas Instruments SN76496 Sound Chip		       ;
;									       ;
;									       ;
;				  Written By:				       ;
;			      Joseph A. Albrecht			       ;
;                        9250 Old Cedar Ave  Apt. 103                          ;
;			    Bloomington, MN  55425			       ;
;									       ;
;------------------------------------------------------------------------------;

PUSHR	MACRO

	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	SI
	PUSH	DI
	PUSH	BP

	ENDM

POPR	MACRO

	POP	BP
	POP	DI
	POP	SI
	POP	DX
	POP	CX
	POP	BX
	POP	AX

	ENDM

;Stack frame equates
SS_AX		EQU	WORD PTR [BP+16]
SS_BX		EQU	WORD PTR [BP+14]
SS_CX		EQU	WORD PTR [BP+12]
SS_DX		EQU	WORD PTR [BP+10]
SS_SI		EQU	WORD PTR [BP+08]
SS_DI		EQU	WORD PTR [BP+06]
SS_BP		EQU	WORD PTR [BP+04]
SS_DS		EQU	WORD PTR [BP+02]
SS_ES		EQU	WORD PTR [BP+00]

;
;Self-modifying code equates
;

PlusX		EQU	4590H	;INC BP
				;NOP
PlusY		EQU	4747H	;INC DI
				;INC DI
MinusY		EQU	4F4FH	;DEC DI
				;DEC DI
ErrorA		EQU	80H	;Dummy values to fill out signed extended
ErrorB		EQU	80H	; .. word values for instructions
MinimumX	EQU	80H	; ..
MaximumX	EQU	80H	; ..
MinimumY	EQU	80H	; ..
MaximumY	EQU	80H	; ..
GrafixNo	EQU	0CFH	;IRET
GrafixYes	EQU	0FCH	;CLD
ScanAddr	EQU	OFFSET ScanLine       ;Scan line offset address
DeltaS		EQU	WORD PTR DS:[LA7]     ;Line plotting routine offsets
ErrorS		EQU	WORD PTR DS:[LA8+1]   ; .. into instructions
DeltaD		EQU	WORD PTR DS:[LA10]    ; ..
ErrorD		EQU	WORD PTR DS:[LA11+1]  ; ..
ClipLine	EQU	LA5 - $LLA1	      ;Value for clipping lines

;Equates for 'Put' procedure
ArrayB		EQU	BYTE PTR ES:[SI]
ArrayW		EQU	WORD PTR ES:[SI]

;Equates for 'Noise' and 'Sound' procedures
BufSize		EQU	64
BufEntry	EQU	6

Code	SEGMENT PARA PUBLIC 'Code'

	ASSUME	CS:Code,DS:Code,ES:Code,SS:Code

	ORG	100H

Start:
	JMP	Setup		 ;Jump to TSR initialization code

	EVEN

PaintEnd:			;End of paint stack for overflow check
		DW  1024 DUP (?);Paint Stack
PaintStack:			; ..
Above		DB  320 DUP (?) ;Used in 'Paint' for copy of above scan line
Below		DB  320 DUP (?) ;Used in 'Paint' for copy of below scan line
Middle		DB  320 DUP (?) ;Used in 'Paint' for copy of middle scan line

OldINT00	DW	2 DUP(?);Old divide overflow vector address
OldINT08	LABEL	DWORD	;Symbolic name to execute old interrupt 08H
INT08		DW	2 DUP(?);Old BIOS timer interrupt vector address
OldINT08X	LABEL	DWORD	;Symbolic name to execute old interrupt 08H
INT08X		DW	2 DUP(?);Old BIOS timer interrupt vector address
OldINT10	LABEL	DWORD	;Symbolic name to execute old interrupt 10H
INT10		DW	2 DUP(?);Old video BIOS interrupt vector address
SaveSP		DW	?	;Save current Stack Pointer
SaveSS		DW	?	;Save current Stack Segment
OldX		DW	?	;Last X ordinate value
OldY		DW	?	;Last Y ordinate value
DColorB		LABEL	BYTE	;Byte name for current drawing color
DColor		DW	0F000H	;Current drawing color/bit mask
BColorB		LABEL	BYTE	;Byte name for current background color
BColor		DW	?	;Current background color
TColorB		LABEL	BYTE	;Byte name for current text color
TColor		DW	?	;Current text color
MinX		DW	?	;Minimum X clipping value
MinY		DW	?	;Minimum Y clipping value
MaxX		DW	?	;Maximum X clipping value
MaxY		DW	?	;Maximum Y clipping value
MaxScrnX	DW	?	;Absolute maximum X value
MaxScrnY	DW	?	;Absolute maximum Y value
VideoSeg	DW	?	;Video segment address
ScanWords	DW	?	;Number of words per scan line
Tandy11		DW	0	;Flag indicating Tandy11 driver present
Memory		DW	32	;Amount of available memory
SystemMem	DW	?	;Amount of installed memory
DPage		DW	?	;Display page table index
APage		DW	?	;Active page table index
MaxPage		DW	?	;Maximum page value
Reg3DF		DW	?	;CRT page register mask value
PageShift	DW	?	;Page register shift value
Row		DW	?	;Current text row
Column		DW	?	;Current text column
TimerSpeed	DW	0	;Speed of 8253 timer chip flag
TimerValue	DW	0	;8253 timer chip speed value
TimerCount	DW	0	;Number of interrupts before executing INT 08H
GraphFlagB	LABEL	BYTE	;Byte name for GraphFlag
GraphFlag	DW	0	;Current graphics mode: On/Off
CursorFlagB	LABEL	BYTE	;Byte name for CursorFlag
CursorFlag	DW	0	;Current cursor status:
				;  Bit 0 - Cursor mode: On/Off
				;  Bit 1 - Cursor size: Half/Full
XorFlagB	LABEL	BYTE	;Byte name for XorFlag
XorFlag		DW	0	;Xor plot flag
TimerFlag	DW	0	;Timer interrupt status flag:
				;  Bit 0  - Sound channel 0 active
				;  Bit 1  - Sound channel 1 active
				;  Bit 2  - Sound channel 2 active
				;  Bit 3  - Noise channel active
				;  Bit 4  - Sound channel 0 busy
				;  Bit 5  - Sound channel 1 busy
				;  Bit 6  - Sound channel 2 busy
				;  Bit 7  - Noise channel busy
				;  Bit 8  - Sound buffering: On/Off
				;  Bit 9  - Noise buffering: On/Off
				;  Bit 10 - Delay Active
				;  Bit 11 - Skip Timer INT 08H routine
SoundCnt0	DW	?	;Clock ticks before turning off channel 0
SoundCnt1	DW	?	;Clock ticks before turning off channel 1
SoundCnt2	DW	?	;Clock ticks before turning off channel 2
NoiseCnt	DW	?	;Clock ticks before turning off noise channel
DelayCnt	DW	?	;Clock ticks before quitting delay loop
PBufPtr1	DW OFFSET SoundBuf1 ;Sound buffer 1 pointer for putting sounds
PBufPtr2	DW OFFSET SoundBuf2 ;Sound buffer 2 pointer for putting sounds
PBufPtr3	DW OFFSET SoundBuf3 ;Sound buffer 3 pointer for putting sounds
PBufPtr4	DW OFFSET NoiseBuf  ;Noise buffer pointer for putting noises
GBufPtr1	DW OFFSET SoundBuf1 ;Sound buffer 1 pointer for getting sounds
GBufPtr2	DW OFFSET SoundBuf2 ;Sound buffer 2 pointer for getting sounds
GBufPtr3	DW OFFSET SoundBuf3 ;Sound buffer 3 pointer for getting sounds
GBufPtr4	DW OFFSET NoiseBuf  ;Moise buffer pointer for getting noises
BufCnt1		DW	0	;Sound buffer 1 current total
BufCnt2		DW	0	;Sound buffer 2 current total
BufCnt3		DW	0	;Sound buffer 3 current total
BufCnt4		DW	0	;Noise buffer current total

;Buffer 1 - Sound channel 0
SoundBuf1	DW  BufSize * BufEntry /2 DUP (?)
BufEnd1:			;End of buffer 1
;Buffer 2 - Sound channel 1
SoundBuf2	DW  BufSize * BufEntry / 2 DUP (?)
BufEnd2:			;End of buffer 2
;Buffer 3 - Sound channel 2
SoundBuf3	DW  BufSize * BufEntry / 2 DUP (?)
BufEnd3:			;End of buffer 3
;Buffer 4 - Noise channel
NoiseBuf	DW  BufSize * BufEntry / 2 DUP (?)
BufEnd4:			;End of buffer 4

SoundTab	DW	Sound0	;Sound channel table
		DW	Sound1	; ..
		DW	Sound2	; ..

;Variables used in circle and ellipse drawing routines
XAspect		DW	?		;X portion of the aspect ratio
YAspect		DW	?		;Y portion of the aspect ratio
A		DW	?		;Major axis
B		DW	?		;Minor axis
ASquared	DW	2 DUP(?)	;A^2
BSquared	DW	2 DUP(?)	;B^2
TwoASquared	DW	2 DUP(?)	;2 * ASquared
TwoBSquared	DW	2 DUP(?)	;2 * BSquared
DeltaX		DW	2 DUP(?)	;Decision X
DeltaY		DW	2 DUP(?)	;Decision Y
Delta		DW	2 DUP(?)	;Decision error term
EllipseTable	DW	PlotEllipseX	;Normal plotting - No clipping
		DW	PlotEllipse	;Normal plotting - Clipping
		DW	XorEllipsePtX	;Xor plotting - No clipping
		DW	XorEllipsePt	;Xor plotting - Clipping

;Put routines address table
PutTable	DW	PutPresetEven
		DW	PutPresetEvenX
		DW	PutPresetOdd
		DW	PutPresetOddX
		DW	PutPsetEven
		DW	PutPsetEvenX
		DW	PutPsetOdd
		DW	PutPsetOddX
		DW	PutAndEven
		DW	PutAndEvenX
		DW	PutAndOdd
		DW	PutAndOddX
		DW	PutOrEven
		DW	PutOrEvenX
		DW	PutOrOdd
		DW	PutOrOddX
		DW	PutXorEven
		DW	PutXorEvenX
		DW	PutXorOdd
		DW	PutXorOddX

X1A		DW	?	;Variables used in 'Put' routines
Y1A		DW	?	; ..
X2A		DW	?	; ..
Y2A		DW	?	; ..
Action		DW	?	; ..
NextLine	DW	?	; ..
LastByte	DW	?	; ..
SaveCount	DW	?	; ..

;Line drawing pixel setting routines address table
LineTable	DW	$LLA	;Regular lines
		DW	$LLB	;Xor lines

X1		DW	?	;Variables used in box fill & drawing routines
Y1		DW	?	; ..
X2		DW	?	; ..
Y2		DW	?	; ..

;Scan line address table for all graphics mode
ScanLine	DW	200 DUP(?)

;CALL table for GRAFIX functions
Function	DW	ClearScreen	;00 Clear screen
		DW	ColorEnable	;01 Set color enable on/off
		DW	SetColor	;02 Set color
		DW	GetColor	;03 Get color
		DW	SetAspect	;04 Set aspect ratio
		DW	GetAspect	;05 Get aspect ratio
		DW	Point		;06 Plot point - Drawing color
		DW	GetPoint	;07 Get pixel color
		DW	MoveTo		;08 Move To
		DW	MoveRel		;09 Move Relative
		DW	GetXY		;10 Get current X,Y
		DW	$Line		;11 Line - Drawing color
		DW	LineTo		;12 Line To - Drawing color
		DW	LineRel		;13 Line Relative - Drawing color
		DW	DrawBox		;14 Draw Box - Specified color
		DW	Circle		;15 Circle - Drawing color
		DW	Paint		;16 Paint graphics shape
		DW	FillBox		;17 Fill Box - Specified color
		DW	SetPalette	;18 Change palette register
		DW	PaletteUsing	;19 Change all 16 palette registers
		DW	ResetPalette	;20 Reset all palette registers
		DW	Get		;21 Store a graphic image
		DW	Put		;22 Transfer an graphic image
		DW	SetCursor	;23 Set cursor mode
		DW	GetCursor	;24 Get cursor status
		DW	SetCursorPos	;25 Set cursor position
		DW	GetCursorPos	;26 Get cursor position
		DW	PrintString	;27 Print a string
		DW	Animate		;28 Animate an image
		DW	PointC		;29 Set pixel with specified color
		DW	LineC		;30 Line - Specified color
		DW	LineToC		;31 Line To - Specified color
		DW	LineRelC	;32 Line Relative - Specified color
		DW	CircleC		;33 Circle - Specified color
		DW	DrawBoxC	;34 Draw Box - Drawing color
		DW	FillBoxC	;35 Fill Box - Drawing color
		DW	XorPoint	;36 Xor Pixel - Drawing color
		DW	XorPointC	;37 Xor Pixel - Specified color
		DW	XorLine		;38 Xor Line - Drawing color
		DW	XorLineC	;39 Xor Line - Specified color
		DW	XorLineTo	;40 Xor Line To - Drawing color
		DW	XorLineToC	;41 Xor Line To - Specified color
		DW	XorLineRel	;42 Xor Line Relative - Drawing color
		DW	XorLineRelC	;43 Xor Line Relative - Specified color
		DW	XorDrawBox	;44 Xor Draw Box - Specified Color
		DW	XorDrawBoxC	;45 Xor Draw Box - Drawing Color
		DW	XorFillBox	;46 Xor Fill Box - Specified Color
		DW	XorFillBoxC	;47 Xor Fill Box - Drawing Color
		DW	XorCircle	;48 Xor Circle - Drawing color
		DW	XorCircleC	;49 Xor Circle - Specified color
		DW	Ellipse		;50 Ellipse - Drawing color
		DW	EllipseC	;51 Ellipse - Specified color
		DW	XorEllipse	;52 Xor Ellipse - Drawing color
		DW	XorEllipseC	;53 Xor Ellipse - Specified color
		DW	SetView		;54 Set current screen viewport
		DW	GetView		;55 Get current screen viewport
		DW	ResetView	;56 Reset screen viewport
		DW	GetScreen	;57 Store entire graphics screen
		DW	PutScreen	;58 Transfer entire graphics screen
		DW	SetDisplayPage	;59 Set current display page
		DW	GetDisplayPage	;60 Get current display page
		DW	SetActivePage	;61 Set current active page
		DW	GetActivePage	;62 Get current active page
		DW	PageCopy	;63 Copy source to destination page
		DW	128 - (($ - Function) / 2) DUP (DoNothing)

Filler		EQU	$

		DW	System		;80H - Global system functions
		DW	Sound		;81H - Generate a sound
		DW	Noise		;82H - Generate a noise
		DW	Delay		;83H - Delay loop
		DW	FastTimer	;84H - Set timer chip to fast speed
		DW	ResetTimer	;85H - Set timer chip to normal speed
		DW	GetTimer	;86H - Get timer chip speed
		DW	128 - (($ - Filler) / 2) DUP (DoNothing)

NewINT10:
	CMP	AH,0EEH		;Check for a function call
	JNE	ExecINT10	; ..
NewINT10A:
	OR	AL,AL		;Check for a graphics call
	JS	NewINT10B	; ..
GraphOK DB	GrafixNo	; ..
NewINT10B:
	STI			;Keep interrupts going
	PUSHR			;Save registers
	PUSH	DS		; ..
	PUSH	ES		; ..
	MOV	BP,CS		;Establish Data Segment for INT 10H extension
	MOV	DS,BP		; ..
	MOV	ES,[VideoSeg]	;Point ES at video segment
        XOR     AH,AH              ;Index into function table
        SHL     AX,1               ; ..
        MOV     BP,AX              ; ..
        MOV     AX,CS:Function[BP] ; ..
	MOV	BP,SP		;Set up stack frame reference
	CALL	AX		;CALL requested function
	POP	ES		;Restore registers
	POP	DS		; ..
	POPR			; ..
	IRET			;Return to interrupted program

ExecINT10:
	JMP	CS:[OldINT10]	;Execute the normal video BIOS

;
;Dummy function for blank CALL table entries
;

DoNothing:
	RET

;
;Clear the graphics screen to the current background color
;

ClearScreen:
	MOV	BX,[MinX]	;Use 'FillBox' to fill current clipping region
	MOV	CX,[MinY]	; .. with current background color
	MOV	SI,[MaxX]	; ..
	MOV	DI,[MaxY]	; ..
	XOR	DX,DX		; ..
	CALL	FillBox		; ..
	MOV	AX,[MinX]	;Reset OldX, OldY to MinX, MinY
	MOV	[OldX],AX	; ..
	MOV	AX,[MinX]	; ..
	MOV	[OldY],AX	; ..
	MOV	BX,1		;Reset cursor to 1, 1
	MOV	CX,BX		; ..
	CALL	SetCursorPos	; ..
	RET

;
;Turn the color enable off/on
;

ColorEnable:
	XOR	AX,AX		;Point to BIOS data area
	MOV	ES,AX		; ..
	MOV	SI,456H		; ..
	MOV	AL,ES:[SI]	;Get BIOS copy of mode select register
	MOV	DX,3D8H		;Port # of mode select register
	OR	BX,BX		;Turn enable color off?
	JNZ	ColorEnable1	; ..
	OR	AL,4		;Turn color enable bit off
	JMP	ColorEnable2	; ..
ColorEnable1:
	CMP	BX,1		;Turn color enable on?
	JNE	ColorEnable2	; ..
	AND	AL,3BH		;Turn color enable bit on
ColorEnable2:
	MOV	ES:[SI],AL	;Write new copy to BIOS area
	OUT	DX,AL		;Turn the color enable off
	RET

;
;Set the current drawing, text, background color
;

SetColor:
	CMP	BX,1		;Set drawing color?
	JNE	SetColor2	; ..
	MOV	[DColorB],CL	;Set the drawing color
	RET
SetColor2:
	CMP	BX,2		;Set text color?
	JNE	SetColor3	; ..
	MOV	[TColorB],CL	;Set the text color
	RET
SetColor3:
	CMP	BX,3		;Set background color?
	JNE	SetColor4	; ..
	MOV	[BColorB],CL	;Set the background color
	MOV	AH,11		;Fake an INT 10H interrupt
	MOV	BX,CX		; ..
	PUSHF			; ..
	CALL	[OldINT10]	; ..
SetColor4:
	RET

;
;Get the current draw, text, background color
;

GetColor:
	CMP	BX,1		;Get the drawing color
	JNE	GetColor2	; ..
	MOV	AL,[DColorB]	;Yes, get the drawing color
	XOR	AH,AH		; ..
	MOV	SS_CX,AX	;Store in CX position on stack
	RET
GetColor2:
	CMP	BX,2		;Get the text color
	JNE	GetColor3	; ..
	MOV	AX,[TColor]	;Yes, get the text color
	MOV	SS_CX,AX	;Store in CX position on stack
	RET
GetColor3:
	CMP	BX,3		;Get the background color
	JNE	GetColor4	; ..
	MOV	AX,[BColor]	;Yes, get the background color
	MOV	SS_CX,AX	;Store in CX position on stack
GetColor4:
	RET

;
;Set the aspect ratio for circle drawing
;

SetAspect:
	OR	BX,BX		;Valdiate XAspect
	JZ	SetAspect1	; ..
	OR	CX,CX		;Valdiate YAspect
	JZ	SetAspect1	; ..
	MOV	[XAspect],BX	;Store X & Y aspect ratio components
	MOV	[YAspect],CX	; ..
SetAspect1:
	RET

;
;Get the current aspect ratio for circle drawing
;

GetAspect:
	MOV	AX,[XAspect]	;Get X aspect ratio component
	MOV	SS_BX,AX	;Store in BX position on stack
	MOV	AX,[YAspect]	;Get Y aspect ratio component
	MOV	SS_CX,AX	;Store in CX position on stack
	RET

;
;Sets the current screen viewport MinX, MinY, MaxX, MaxY
;

SetView:
	CALL	SortCoords	;Force MinX < MaxX, MinY < MaxY
	OR	BX,BX		;Validate MinX
	JS	SetView1	; ..
	OR	CX,CX		;Validate MinY
	JS	SetView1	; ..
	CMP	SI,[MaxScrnX]	;Validate MaxX
	JG	SetView1	; ..
	CMP	DI,[MaxScrnY]	;Validate MaxY
	JG	SetView1	; ..
	MOV	[MinX],BX	;Update MinX, MinY, MaxX, MaxY
	MOV	[MinY],CX	; ..
	MOV	[MaxX],SI	; ..
	MOV	[MaxY],DI	; ..
SetView1:
	RET

;
;Returns the current screen viewport MinX, MinY, MaxX, MaxY
;

GetView:
	MOV	AX,[MinX]	;Get MinX
	MOV	SS_BX,AX	; ..
	MOV	AX,[MinY]	;Get MinY
	MOV	SS_CX,AX	; ..
	MOV	AX,[MaxX]	;Get MaxX
	MOV	SS_SI,AX	; ..
	MOV	AX,[MaxY]	;Get MaxY
	MOV	SS_DI,AX	; ..
	RET

;
;Reset the current screen viewport MinX, MinY, MaxX, MaxY to default size
;

ResetView:
	XOR	AX,AX		;Reset MinX, MinY
	MOV	[MinX],AX	; ..
	MOV	[MinY],AX	; ..
	MOV	AX,[MaxScrnX]	;Reset MaxX
	MOV	[MaxX],AX	; ..
	MOV	AX,[MaxScrnY]	;Reset MaxY
	MOV	[MaxY],AX	; ..
	RET

;
;Xor a point point using the current drawing or specified color
;

XorPoint:
	MOV	DL,[DColorB]	;Get current drawing color

;Entered here for using the specified color
XorPointC:
	MOV	[OldX],SI	;Update old X,Y values
	MOV	[OldY],DI	; ..

;Entered here for XorDrawBox
XorPointX:
	CMP	SI,[MinX]	;Validate X
	JL	XorPoint2	; ..
	CMP	SI,[MaxX]	; ..
	JG	XorPoint2	; ..
	CMP	DI,[MinY]	;Validate Y
	JL	XorPoint2	; ..
	CMP	DI,[MaxY]	; ..
	JG	XorPoint2	; ..
	SHL	DI,1		;Get scan line address from table
	MOV	DI,ScanLine[DI] ; ..
	SHR	SI,1		;Get column offset
	JC	XorPoint1	;Check for odd/even pixel
	MOV	CL,4		;Move color to proper position
	SHL	DL,CL		; ..
XorPoint1:
	ADD	DI,SI		;Add column offset
	XOR	ES:[DI],DL	;Xor the point
XorPoint2:
	RET

;
;Plot a point using the current drawing or specified color
;

Point:
	MOV	DL,[DColorB]	;Get current drawing color

;Entered here for using the specified color
PointC:
	MOV	[OldX],SI	;Update old X,Y values
	MOV	[OldY],DI	; ..

	CMP	SI,[MinX]	;Validate X
	JL	Point2		; ..
	CMP	SI,[MaxX]	; ..
	JG	Point2		; ..
	CMP	DI,[MinY]	;Validate Y
	JL	Point2		; ..
	CMP	DI,[MaxY]	; ..
	JG	Point2		; ..
	MOV	AH,0F0H		;Set mask for an odd pixel
	SHL	DI,1		;Get scan line address from table
	MOV	DI,ScanLine[DI] ; ..
	SHR	SI,1		;Get column offset
	JC	Point1		;Check for odd/even pixel
	NOT	AH		;Set mask for an even pixel
	MOV	CL,4		;Move color to proper position
	SHL	DL,CL		; ..
Point1:
	ADD	DI,SI		;Add column offset
	MOV	AL,ES:[DI]	;Plot the point
	AND	AL,AH		; ..
	OR	AL,DL		; ..
	MOV	ES:[DI],AL	; ..
Point2:
	RET

;
;Get the pixel color a point X,Y
;

GetPoint:
	CMP	SI,[MinX]	;Validate X
	JL	GetPoint2	; ..
	CMP	SI,[MaxX]	; ..
	JG	GetPoint2	; ..
	CMP	DI,[MinY]	;Validate Y
	JL	GetPoint2	; ..
	CMP	DI,[MaxY]	; ..
	JG	GetPoint2	; ..
	SHL	DI,1		;Put offset address in DI from table
	MOV	DI,ScanLine[DI] ; ..
	XOR	CL,CL		;Set shift count for an odd pixel
	SHR	SI,1		;Get column offset
	JC	GetPoint1	;Check for odd/even pixel
	MOV	CL,4		;Set shift count for an even pixel
GetPoint1:
	ADD	DI,SI		;Add column offset
	MOV	AL,ES:[DI]	;Get byte from video memory
	SHR	AL,CL		;Move color to proper position
	AND	AX,0FH		;Mask off unwanted bits
	MOV	SS_AX,AX	;Store in AX position on stack
GetPoint2:
	RET

;
;Move to the specified position from OldX, OldY without plotting any points
;

MoveTo:
	MOV	[OldX],SI	;Update old X,Y values
	MOV	[OldY],DI	; ..
	RET

;
;Move a relative distance from OldX, OldY without plotting any points
;

MoveRel:
	ADD	[OldX],SI	;Update old X,Y values
	ADD	[OldY],DI	; ..
	RET

;
;Get current X,Y position
;

GetXY:
	MOV	AX,[OldX]	;Return the current X position
	MOV	SS_BX,AX	;Store in BX position on stack
	MOV	AX,[OldY]	;Return the current Y position
	MOV	SS_CX,AX	;Store in CX position on stack
	RET

;
;Xor a line from X1,Y1 - X2,Y2 using the current drawing color
;

XorLine:
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	RET

;
;Draw a line from X1,Y1 - X2,Y2 using the specified color
;

XorLineC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line to the specified position from OldX, OldY using the current drawing
;color
;

XorLineTo:
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	RET

;
;Xor a line to the specified position from OldX, OldY using the specified color
;

XorLineToC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Xor a line a relative distance from OldX, OldY using the current drawing color
;

XorLineRel:
	ADD	SI,[OldX]	;Calculate relative position
	ADD	DI,[OldY]	; ..
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	RET

;
;Xor a line a relative distance from OldX, OldY using the specified color
;

XorLineRelC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	ADD	SI,[OldX]	;Calculate relative position
	ADD	DI,[OldY]	; ..
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	MOV	[XorFlagB],1	;Set Xor flag
	CALL	$Line		;Xor the line
	MOV	[XorFlagB],0	;Reset Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line from X1,Y1 - X2,Y2 using the specified color
;

LineC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	$Line		;Plot the line
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line to the specified position from OldX, OldY using the specified color
;

LineToC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	CALL	$Line		;Plot the line
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line a relative distance from OldX, OldY using the specified color
;

LineRelC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	ADD	SI,[OldX]	;Calculate relative position
	ADD	DI,[OldY]	; ..
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	CALL	$Line		;Plot the line
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line to the specified position from OldX, OldY using the current drawing
;color
;

LineTo:
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..
	JMP	$Line		;Plot the line

;
;Draw a line a relative distance from OldX, OldY using the current drawing color
;

LineRel:
	ADD	SI,[OldX]	;Calculate relative position
	ADD	DI,[OldY]	; ..
	MOV	BX,[OldX]	;Set up proper values for $Line
	MOV	CX,[OldY]	; ..

;
;Draw a line from X1, Y1 - X2, Y2 using the current drawing color
;

;
;Internal primative line drawing routine. Uses Breshenham's fast differential
;integer line algorithm. This algorithm finds the closet integer coordinates
;to the actual line's path using only integer arithmetic and is very fast.
;

$Line:
	MOV	[OldX],SI	;Update OldX, OldY
	MOV	[OldY],DI	; ..

;Entered here to avoid updating OldX, OldY
$LineX:
	CMP	CX,DI		;If Y1 = Y2 do straight horizontal line routine
	JE	Horizontal	; ..
	CMP	BX,SI		;If X1 = X2 do straight vertical line routine
	JE	Vertical	; ..
	PUSH	BX		;Save registers
	PUSH	CX		; ..
	PUSH	SI		; ..
	PUSH	DI		; ..
	CALL	CheckRange	;Check if line is withing clipping region
	POP	DI		;Restore registers
	POP	SI		; ..
	POP	CX		; ..
	POP	BX		; ..
	XOR	DX,DX		;Get clip indicator
	OR	AX,AX		; ..
	JNZ	$Line1		; ..
	MOV	DX,ClipLine	; ..

$Line1:
	MOV	AX,PlusY	;Assume positive Y increment with a straight
	MOV	BP,AX		; .. move in a Y direction

;Swap X1, X2 & Y1, Y2 if X1 > X2
	CMP	BX,SI		;Force X1 < X2
	JL	$Line2		;Skip if X1 < X2
	XCHG	BX,SI		;Swap'em
	XCHG	CX,DI		; ..

;Find (Y2 - Y1)
$Line2:
	SUB	DI,CX		;Subtract Y1
	JGE	$Line3		;Skip if (Y2 - Y1) is nonnegative
	NEG	DI		;Absolute value of (Y2 - Y1)
	MOV	AX,MinusY	;Negative Y increment
	MOV	BP,AX		; ..

;Find (X2 - X1)
$Line3:
	SUB	SI,BX		;Subtract X1

;Sort (Y2 - Y1) and (X2 - X1)
	XCHG	SI,DI		;Assume straight move = Y
	CMP	SI,DI		;Compare dx with dy
	JGE	$Line4		; ..
	MOV	AX,PlusX	;Straight move = X
	XCHG	SI,DI		; ..

;Get initial line values
$Line4:
	MOV	DeltaS,AX	;Update straight move
	MOV	DeltaD,BP	;Update diagonal move
	SHL	DI,1		;Straight move
	MOV	ErrorS,DI	; .. (dy * 2)
	SUB	DI,SI		;Initial value for error term
	MOV	AX,DI		; .. (dy * 2) - dx
	SUB	DI,SI		;Diagonal move
	MOV	ErrorD,DI	; .. (dy * 2) - (dx * 2)
	MOV	BP,BX		;Get starting X
	MOV	DI,CX		;Get starting Y
	SHL	DI,1		; ..
	ADD	DI,ScanAddr	; ..
	MOV	BL,[DColorB]	;Get line color in BL & BH
	MOV	BH,BL		; ..
	MOV	CL,4		; ..
	SHL	BH,CL		; ..
	MOV	CX,SI		;Get pixel count
	INC	CX		; ..
	MOV	SI,[XorFlag]	;Jump to selected line plotting routine
	SHL	SI,1		; ..
	JMP	LineTable[SI]	; ..

;
;Draw a straight horizontal line
;

Horizontal:
	CMP	[XorFlagB],1	;See if line should be Xor'ed
	JE	Horizontal1	; ..
	JMP	FillBoxCX	;Draw the line
Horizontal1:
	JMP	XorFillBoxCX	;Xor the line

;
;Draw a straight vertical line
;

Vertical:
	CALL	ValidateCoords	;See if line is in range
	OR	AX,AX		; ..
	JZ	Vertical1	; ..
	RET
Vertical1:
	MOV	SI,CX		;Get starting scan line table entry
	SHL	SI,1		; ..
	ADD	SI,ScanAddr	; ..
	SUB	DI,CX		;Get number of lines
	INC	DI		; ..
	MOV	CX,DI		; ..
	MOV	AX,[DColor]	;Get initial color and bit mask
	CMP	[XorFlagB],1	;See if line should be Xor'ed
	JE	Vertical3	; ..

;Draw the straight vertical line
	PUSH	DS		;Save DS
	MOV	DS,[VideoSeg]	;Point DS at video buffer
	SHR	BX,1		;Get starting column offset
	JC	Vertical2	;Check for odd/even pixel
	SHL	AL,1		;Move color to proper position
	SHL	AL,1		; ..
	SHL	AL,1		; ..
	SHL	AL,1		; ..
	NOT	AH		;Get proper bit mask

Vertical2:
	MOV	DI,CS:[SI]	;Get scan line address
	MOV	DL,[BX+DI]	;Plot the pixel
	AND	DL,AH		; ..
	OR	DL,AL		; ..
	MOV	[BX+DI],DL	; ..
	INC	SI		;Point to line
	INC	SI		; ..
	LOOP	Vertical2	;Plot next pixel
	POP	DS		;Restore DS
	RET

;Xor the straight vertical line
Vertical3:
	SHR	BX,1		;Get starting column offset
	JC	Vertical4	;Check for odd/even pixel
	SHL	AL,1		;Move color to proper position
	SHL	AL,1		; ..
	SHL	AL,1		; ..
	SHL	AL,1		; ..

Vertical4:
	MOV	DI,[SI]		;Get scan line address
	XOR	ES:[BX+DI],AL	;Xor the pixel
	INC	SI		;Point to line
	INC	SI		; ..
	LOOP	Vertical4	;Xor next pixel
	RET

;
;Plotting routine for regular lines
;

;Update self-modifying code instructions
$LLA:
	PUSH	AX			;Save AX
	MOV	BYTE PTR DS:[LA5+1],BL	;Update line color
	MOV	BYTE PTR DS:[LA6+1],BH	; ..
	MOV	SI,DX			;See if line should be clipped
	MOV	AX,$LLA1-(LA9+2)	; ..
	ADD	AX,SI			; ..
	MOV	BYTE PTR DS:[LA9+1],AL	; ..
	MOV	AX,$LLA1-(LA12+2)	; ..
	ADD	AX,SI			; ..
	MOV	BYTE PTR DS:[LA12+1],AL ; ..
	MOV	AX,[MinX]		;Update minimum X
	MOV	WORD PTR DS:[LA1+2],AX	; . ..
	MOV	AX,[MaxX]		;Update maximum X
	MOV	WORD PTR DS:[LA2+2],AX	; ..
	MOV	AX,[MinY]		;Update minimum Y
	SHL	AX,1			; ..
	ADD	AX,ScanAddr		; ..
	MOV	WORD PTR DS:[LA3+2],AX	; ..
	MOV	AX,[MaxY]		;Update maximum Y
	SHL	AX,1			; ..
	ADD	AX,ScanAddr		; ..
	MOV	WORD PTR DS:[LA4+2],AX	; ..
	POP	AX			;Restore AX
	PUSH	DS			;Save DS
	MOV	DS,[VideoSeg]		;Point DS at video buffer

$LLA1:
LA1:	CMP	BP,MinimumX	;Validate X
	JL	$LLA3		; ..
LA2:	CMP	BP,MaximumX	; ..
	JG	$LLA3		; ..
LA3:	CMP	DI,MinimumY	;Validate Y
	JB	$LLA3		; ..
LA4:	CMP	DI,MaximumY	; ..
	JA	$LLA3		; ..
LA5:	MOV	DX,0F001H	;Get line color and bit mask for odd pixel
	MOV	SI,BP		;Get column offset
	SHR	SI,1		; ..
	JC	$LLA2		;Check for odd/even pixel
LA6:	MOV	DX,0F10H	;Get line color and bit mask for even pixel
$LLA2:
	ADD	SI,CS:[DI]	;Add scan line address
	MOV	BL,[SI]		;Plot the point
	AND	BL,DH		; ..
	OR	BL,DL		; ..
	MOV	[SI],BL		; ..

$LLA3:
	OR	AX,AX		;Determine straight or diagonal move
	JNS	$LLA4		; ..

;Straight move
LA7:	INC	DI		;Update straight move
	INC	DI		; ..
LA8:	ADD	AX,ErrorA	;Update error term
LA9:	LOOP	$LLA1		;Do next pixel
	POP	DS		;Restore DS
	RET

;Diagonal move
$LLA4:
	INC	BP		;Update X
LA10:	INC	DI		;Update Y
	INC	DI		; ..
LA11:	ADD	AX,ErrorB	;Update error term
LA12:	LOOP	$LLA1		;Do next pixel
	POP	DS		;Restore DS
	RET

;
;Plotting routine for Xor lines
;

;Update self-modifying code instructions
$LLB:
	PUSH	AX			;Save AX
	MOV	SI,DX			;See if line should be clipped
	MOV	AX,$LLB1-(LB7+2)	; ..
	ADD	AX,SI			; ..
	MOV	BYTE PTR DS:[LB7+1],AL	; ..
	MOV	AX,$LLB1-(LB10+2)	; ..
	ADD	AX,SI			; ..
	MOV	BYTE PTR DS:[LB10+1],AL ; ..
	MOV	AX,DeltaS		;Update straight move increment
	MOV	WORD PTR DS:[LB5],AX	; ..
	MOV	AX,ErrorS		;Update straight error term
	MOV	WORD PTR DS:[LB6+1],AX	; ..
	MOV	AX,DeltaD		;Update diagonal Y increment
	MOV	WORD PTR DS:[LB8],AX	; ..
	MOV	AX,ErrorD		;Update diagonal error term
	MOV	WORD PTR DS:[LB9+1],AX	; ..
	MOV	AX,[MinX]		;Update minimum X
	MOV	WORD PTR DS:[LB1+2],AX	; ..
	MOV	AX,[MaxX]		;Update maximum X
	MOV	WORD PTR DS:[LB2+2],AX	; ..
	MOV	AX,[MinY]		;Update minimum Y
	SHL	AX,1			; ..
	ADD	AX,ScanAddr		; ..
	MOV	WORD PTR DS:[LB3+2],AX	; ..
	MOV	AX,[MaxY]		;Update maximum Y
	SHL	AX,1			; ..
	ADD	AX,ScanAddr		; ..
	MOV	WORD PTR DS:[LB4+2],AX	; ..
	POP	AX			;Restore AX

$LLB1:
LB1:	CMP	BP,MinimumX	;Validate X
	JL	$LLB3		; ..
LB2:	CMP	BP,MaximumX	; ..
	JG	$LLB3		; ..
LB3:	CMP	DI,MinimumY	;Validate Y
	JB	$LLB3		; ..
LB4:	CMP	DI,MaximumY	; ..
	JA	$LLB3		; ..
	MOV	DL,BL		;Get line color odd pixel
	MOV	SI,BP		;Get column offset
	SHR	SI,1		; ..
	JC	$LLB2		;Check for odd/even pixel
	MOV	DL,BH		;Get line color even pixel
$LLB2:
	ADD	SI,[DI]		;Add scan line address
	XOR	ES:[SI],DL	;Xor the point

$LLB3:
	OR	AX,AX		;Determine straight or diagonal move
	JNS	$LLB4		; ..

;Straight move
LB5:	INC	DI		;Update straight move
	INC	DI		; ..
LB6:	ADD	AX,ErrorA	;Update error term
LB7:	LOOP	$LLB1		;Do next pixel
	RET

;Diagonal move
$LLB4:
	INC	BP		;Update X
LB8:	INC	DI		;Update Y
	INC	DI		; ..
LB9:	ADD	AX,ErrorB	;Update error term
LB10:	LOOP	$LLB1		;Do next pixel
	RET

;
;Checks if X1, Y1, X2, Y2 fall outside the clipping region
;

CheckRange:
	CALL	SortCoords	;Force X1 < X2, Y1 < Y2

;Entered here to avoid sorting coordinates
CheckRangeX:
	XOR	AX,AX		;Clear clip indicator index
	CMP	BX,[MinX]	;Validate X1
	JL	CheckRange1	; ..
	CMP	SI,[MaxX]	;Validate X2
	JG	CheckRange1	; ..
	CMP	CX,[MinY]	;Validate Y1
	JL	CheckRange1	; ..
	CMP	DI,[MaxY]	;Validate Y2
	JG	CheckRange1	; ..
	RET
CheckRange1:
	INC	AX		;Indicate line should be clipped
	RET			; ..

;
;Routine validate and clip X1, Y1, X2, Y2
;

ValidateCoords:
	CALL	SortCoords	;Force X1 < X2, Y1 < Y2

;Entered here to avoid sorting coordinates
ValidateCoordsX:
	CALL	CheckCoords	;See if X1, Y1, X2, Y2 are in range
	OR	AX,AX		; ..
	JNZ	ValidateCoords4 ; ..
	CMP	BX,[MinX]	;Clip X1
	JGE	ValidateCoords1 ; ..
	MOV	BX,[MinX]	; ..
ValidateCoords1:
	CMP	SI,[MaxX]	;Clip X2
	JLE	ValidateCoords2 ; ..
	MOV	SI,[MaxX]	; ..
ValidateCoords2:
	CMP	CX,[MinY]	;Clip Y1
	JGE	ValidateCoords3 ; ..
	MOV	CX,[MinY]	; ..
ValidateCoords3:
	CMP	DI,[MaxY]	;Clip Y2
	JLE	ValidateCoords4 ; ..
	MOV	DI,[MaxY]	; ..
ValidateCoords4:
	RET

;
;Routine to force X1 < X2, Y1 < Y2
;

SortCoords:
	CMP	BX,SI		;Adjust if X1 > X2
	JL	SortCoords1	; ..
	XCHG	BX,SI		; ..
SortCoords1:
	CMP	CX,DI		;Adjust if Y1 > Y2
	JL	SortCoords2	; ..
	XCHG	CX,DI		; ..
SortCoords2:
	RET

;
;Routine to determine if X1, X2, Y1, Y2 are within the current clipping region
;

CheckCoords:
	XOR	AX,AX		;Clear clipping indicator
	CMP	BX,[MaxX]	;Validate X1
	JG	CheckCoords1	; ..
	CMP	SI,[MinX]	;Validate X2
	JL	CheckCoords1	; ..
	CMP	CX,[MaxY]	;Validate Y1
	JG	CheckCoords1	; ..
	CMP	DI,[MinY]	;Validate Y2
	JL	CheckCoords1	; ..
	RET
CheckCoords1:
	INC	AX		;Set clipping on
	RET			; ..


;
;Xor a line box from X1, Y1 - X2, Y2 using the specified color
;

XorDrawBox:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	DrawBoxC	;Draw the box
	MOV	[XorFlagB],0	;Reset the Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Xor a line box from X1, Y1 - X2, Y2 using the current drawing color
;

XorDrawBoxC:
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	DrawBoxC	;Draw the box
	MOV	[XorFlagB],0	;Reset the Xor flag
	RET

;
;Draw a line box from X1, Y1 - X2, Y2 using the specified color
;

DrawBox:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	DrawBoxC	;Draw the box
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a line box from X1, Y1 - X2, Y2 using the current drawing color
;

DrawBoxC:
	MOV	[OldX],SI	;Update old X,Y values
	MOV	[OldY],DI	; ..
	CMP	BX,SI		;If X1 = X2 draw only 1 line
	JNE	DrawBoxC1	; ..
	CALL	Vertical	; ..
	RET			; ..
DrawBoxC1:
	CMP	CX,DI		;If Y1 = Y2 draw only 1 line
	JNE	DrawBoxC2	; ..
	CALL	Horizontal	; ..
	RET			; ..
DrawBoxC2:
	MOV	[X1],BX		;Store X1, Y1, X2, Y2
	MOV	[Y1],CX		; ..
	MOV	[X2],SI		; ..
	MOV	[Y2],DI		; ..
	MOV	BX,[X1]		;Draw top horizontal line of box
	MOV	CX,[Y1]		; ..
	MOV	SI,[X2]		; ..
	MOV	DI,[Y1]		; ..
	CALL	Horizontal	; ..
	MOV	BX,[X1]		;Draw bottom horizontal line of box
	MOV	CX,[Y2]		; ..
	MOV	SI,[X2]		; ..
	MOV	DI,[Y2]		; ..
	CALL	Horizontal	; ..
	MOV	BX,[X1]		;Draw left vertical line of box
	MOV	CX,[Y1]		; ..
	MOV	SI,[X1]		; ..
	MOV	DI,[Y2]		; ..
	CALL	Vertical	; ..
	MOV	BX,[X2]		;Draw right vertical line of box
	MOV	CX,[Y1]		; ..
	MOV	SI,[X2]		; ..
	MOV	DI,[Y2]		; ..
	CALL	Vertical	; ..
	CMP	[XorFlagB],1	;See if corners should be redrawn if Xor'ed
	JNE	DrawBoxC3	; ..
	MOV	SI,[X1]		;Do X1, Y1
	MOV	DI,[Y1]		; ..
	MOV	DL,[DColorB]	; ..
	CALL	XorPointX	; ..
	MOV	SI,[X2]		;Do X2, Y1
	MOV	DI,[Y1]		; ..
	MOV	DL,[DColorB]	; ..
	CALL	XorPointX	; ..
	MOV	SI,[X1]		;Do X1, Y2
	MOV	DI,[Y2]		; ..
	MOV	DL,[DColorB]	; ..
	CALL	XorPointX	; ..
	MOV	SI,[X2]		;Do X2, Y2
	MOV	DI,[Y2]		; ..
	MOV	DL,[DColorB]	; ..
	CALL	XorPointX	; ..
DrawBoxC3:
	RET

;
;Xor a circle at origin X, Y with the specified radius using the current drawing
;color
;

XorCircle:
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	Circle		;Draw the circle
	MOV	[XorFlagB],0	;Reset the Xor flag
	RET

;
;Xor a circle at origin X, Y with the specified radius using the specified color
;

XorCircleC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	Circle		;Draw the circle
	MOV	[XorFlagB],0	;Reset the Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a circle at origin X, Y with the specified radius using the specified
;color
;

CircleC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	Circle		;Draw the circle
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a circle at origin X, Y with the specified radius using the current
;drawing color
;

Circle:
	CALL	RadiusToAB	;Get A, B from Radius
	CALL	EllipseX	;Draw the circle
	RET

;
;Xor an ellipse at origin XC, YC using major axis A, and minor axis B using the
;the current drawing color
;

XorEllipse:
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	Ellipse		;Draw the ellipse
	MOV	[XorFlagB],0	;Clear the Xor flag
	RET

;
;Xor an ellipse at origin XC, YC using major axis A, and minor axis B using the
;specified color
;

XorEllipseC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	MOV	[XorFlagB],1	;Set the Xor flag
	CALL	Ellipse		;Draw the ellipse
	MOV	[XorFlagB],0	;Clear the Xor flag
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw an ellipse at origin XC, YC using major axis A, and minor axis B using the
;specified color
;

EllipseC:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	Ellipse		;Draw the ellipse
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw an ellipse at origin XC, YC using major axis A, and minor axis B using the
;current drawing color
;
;This is a modified version of an ellipse routine from:
;  Programmer's Guide To PC & PS/2 Video Systems
;  by Richard Wilton
;  Microsoft Press, 1987
;

BadAB:
	CMP	[B],0			;See if B < 0
	JS	BadAB2			; ..
BadAB1:
	JMP	$LineX			;A or B = 0
BadAB2:
	RET				;A or B < 0

Ellipse:
	MOV	[A],BX			;Store A, B
	MOV	[B],CX			; ..

;Entered here for circle drawing
EllipseX:
	MOV	[OldX],SI		;Store XC, YC
	MOV	[OldY],DI		; ..

;Validate ellipse coords and select appropriate plotting routine
	MOV	BX,[OldX]	;Get X1, X2
	MOV	SI,BX		; ..
	SUB	BX,[A]		; ..
	ADD	SI,[A]		; ..
	MOV	CX,[OldY]	;Get Y1, Y2
	MOV	DI,CX		; ..
	SUB	CX,[B]		; ..
	ADD	DI,[B]		; ..
	CMP	[A],0		;Check for negative/zero major axis
	JE	BadAB		; ..
	JS	BadAB2		; ..
	CMP	[B],0		;Check for negative/zero minor axis
	JE	BadAB1		; ..
	JS	BadAB2		; ..
	CALL	SortCoords	;Force X1 < X2, Y1 < Y2
	CALL	CheckCoords	;Validate X1, Y1, X2, Y2
	OR	AX,AX		;See if ellipse is within clipping region
	JNZ	BadAB2		;No
	MOV	BP,[XorFlag]	;Add Xor plotting routine pointer to index
	SHL	BP,1		; ..
	SHL	BP,1		; ..
	CALL	CheckRangeX	;See ellipse should be clipped
	SHL	AX,1		; ..
	ADD	BP,AX		; ..
	MOV	BP,CS:EllipseTable[BP] ;Point to selected plotting routine

;Get starting X, Y
	XOR	SI,SI		;X = 0
	MOV	DI,[B]		;Y = B

;Update self-modifying code instructions
	MOV	AL,[DColorB]		;Update ellipse color
	MOV	BYTE PTR DS:[PE7+2],AL	; ..
	MOV	BYTE PTR DS:[XE7+3],AL	; ..
	MOV	CL,4			; ..
	SHL	AL,CL			; ..
	MOV	BYTE PTR DS:[PE6+2],AL	; ..
	MOV	BYTE PTR DS:[XE6+3],AL	; ..
	MOV	AX,[MinX]		;Update minimum X
	MOV	WORD PTR DS:[PE1+2],AX	; ..
	MOV	WORD PTR DS:[XE1+2],AX	; ..
	MOV	AX,[MaxX]		;Update maximum X
	MOV	WORD PTR DS:[PE2+2],AX	; ..
	MOV	WORD PTR DS:[XE2+2],AX	; ..
	MOV	AX,[MinY]		;Update minimum Y
	MOV	WORD PTR DS:[PE3+2],AX	; ..
	MOV	WORD PTR DS:[XE3+2],AX	; ..
	MOV	AX,[MaxY]		;Update maximum Y
	MOV	WORD PTR DS:[PE4+2],AX	; ..
	MOV	WORD PTR DS:[XE4+2],AX	; ..

;Initialize constants
	MOV	AX,[A]			;A^2
	MUL	AX			; ..
	MOV	[ASquared],AX		; ..
	MOV	[ASquared+2],DX		; ..
	SHL	AX,1			;2 * A^2
	RCL	DX,1			; ..
	MOV	[TwoASquared],AX	; ..
	MOV	[TwoASquared+2],DX	; ..

	MOV	AX,[B]			;B^2
	MUL	AX			; ..
	MOV	[BSquared],AX		; ..
	MOV	[BSquared+2],DX		; ..
	SHL	AX,1			;2 * B^2
	RCL	DX,1			; ..
	MOV	[TwoBSquared],AX	; ..
	MOV	[TwoBSquared+2],DX	; ..

;Plot pixels from (0, B) until DeltaY / DeltaX = -1

;Initialize decision variables

	XOR	AX,AX			;DeltaX = 0
	MOV	[DeltaX],AX		; ..
	MOV	[DeltaX+2],AX		; ..

	MOV	AX,[TwoAsquared]	;DeltaY = TwoAsquared * B
	MOV	DX,[TwoAsquared+2]	; ..
	MOV	CX,[B]			; ..
	CALL	LongMultiply		; ..
	MOV	[DeltaY],AX		; ..
	MOV	[DeltaY+2],DX		; ..

;Delta = BSquared - ASquared + ASquared * B + ASquared / 4
	MOV	AX,[ASquared]		;ASquared / 4
	MOV	DX,[ASquared+2]		; ..
	SAR	DX,1			; ..
	RCR	AX,1			; ..
	SAR	DX,1			; ..
	RCR	AX,1			; ..

	ADD	AX,[BSquared]		;BSquared + ASquared / 4
	ADC	DX,[BSquared+2]		; ..
	MOV	[Delta],AX		; ..
	MOV	[Delta+2],DX		; ..

	MOV	AX,[ASquared]		;ASquared * B
	MOV	DX,[ASquared+2]		; ..
	MOV	CX,[B]			; ..
	CALL	LongMultiply		; ..
	SUB	[Delta],AX		;Delta = BSquared - ASquared * B +
	SBB	[Delta+2],DX		; .. ASquared / 4

;Loop until DeltaY / DeltaX >= -1

Ellipse1:
	MOV	AX,[DeltaX]		;Jump if DeltaX >= DeltaY
	MOV	DX,[DeltaX+2]		; ..
	SUB	AX,[DeltaY]		; ..
	SBB	DX,[DeltaY+2]		; ..
	JNS	Ellipse3		; ..

	CALL	Set4Pixels		;Plot ellipse points

	CMP	[Delta+2],0		;Jump if Delta < 0
	JS	Ellipse2		; ..

	DEC	DI			;Decrement Y

	MOV	AX,[DeltaY]		;DeltaY = DeltaY - TwoASquared
	MOV	DX,[DeltaY+2]		; ..
	SUB	AX,[TwoAsquared]	; ..
	SBB	DX,[TwoAsquared+2]	; ..
	MOV	[DeltaY],AX		; ..
	MOV	[DeltaY+2],DX		; ..

	SUB	[Delta],AX		;Delta = Delta - DeltaY
	SBB	[Delta+2],DX		; ..

Ellipse2:
	INC	SI			;Increment X

	MOV	AX,[DeltaX]		;DeltaX = DeltaX + TwoBSquared
	MOV	DX,[DeltaX+2]		; ..
	ADD	AX,[TwoBSquared]	; ..
	ADC	DX,[TwoBSquared+2]	; ..
	MOV	[DeltaX],AX		; ..
	MOV	[DeltaX+2],DX		; ..

	ADD	AX,[BSquared]		;Delta = Delta + DeltaX + BSquared
	ADC	DX,[BSquared+2]		; ..
	ADD	[Delta],AX		; ..
	ADC	[Delta+2],DX		; ..

	JMP	Ellipse1

;Plot pixels from current (X, Y) until Y < 0

;Delta = (3 * (ASquared - BSquared) / 2) - (DeltaX + DeltaY)) / 2
Ellipse3:
	MOV	AX,[ASquared]		;ASquared - BSqared
	MOV	DX,[ASquared+2]		; ..
	SUB	AX,[BSquared]		; ..
	SBB	DX,[BSquared+2]		; ..
	MOV	BX,AX			; ..
	MOV	CX,DX			; ..

	SAR	DX,1			;(ASquared - BSquared) / 2
	RCR	AX,1			; ..

	ADD	AX,BX			;3 * (ASquared - BSquared) / 2
	ADC	DX,CX			; ..

	SUB	AX,[DeltaX]		;3 * (ASquared - BSquared) / 2 -
	SBB	DX,[DeltaX+2]		; .. (DeltaX - DeltaY)
	SUB	AX,[DeltaY]		; ..
	SBB	DX,[DeltaY+2]		; ..

	SAR	DX,1			;(3 * (ASquared - BSquared) / 2 -
	RCR	AX,1			; .. (DeltaX - DeltaY) / 2)

	ADD	[Delta],AX		;Update Delta
	ADC	[Delta+2],DX		; ..

;Loop until Y < 0

Ellipse4:
	CALL	Set4Pixels		;Plot ellipse points

	CMP	[Delta+2],0		;Jump if Delta >= 0
	JNS	Ellipse5		; ..

	INC	SI			;Increment X

	MOV	AX,[DeltaX]		;DeltaX = DeltaX + TwoBSquared
	MOV	DX,[DeltaX+2]		; ..
	ADD	AX,[TwoBSquared]	; ..
	ADC	DX,[TwoBSquared+2]	; ..
	MOV	[DeltaX],AX		; ..
	MOV	[DeltaX+2],DX		; ..

	ADD	[Delta],AX		;Delta = Delta + DeltaX
	ADC	[Delta+2],DX		; ..

Ellipse5:
	MOV	AX,[DeltaY]		;DeltaY = DeltaY - TwoASquared
	MOV	DX,[DeltaY+2]		; ..
	SUB	AX,[TwoASquared]	; ..
	SBB	DX,[TwoASquared+2]	; ..
	MOV	[DeltaY],AX		; ..
	MOV	[DeltaY+2],DX		; ..

	SUB	AX,[ASquared]		;Delta = Delta + ASquared - DeltaY
	SBB	DX,[ASquared+2]		; ..
	SUB	[Delta],AX		; ..
	SBB	[Delta+2],DX		; ..

	DEC	DI			;Decrement Y
	JNS	Ellipse4		;Loop if Y >= 0
	RET				;Exit

;
;Plot 4 points of the ellipse
;

Set4Pixels:
	MOV	AX,[OldX]		;Store XC, YC
	MOV	DX,[OldY]		; ..

	OR	SI,SI			;Don't plot if X = 0
	JZ	Set4PixelsA		; ..

;Plot points if X <> 0

;Plot XC + X, YC + Y
	MOV	CX,AX			;Get XC + X
	ADD	CX,SI			; ..
	MOV	BX,DX			;Get YC + Y
	ADD	BX,DI			; ..
	CALL	BP			;Plot the point

;Plot XC - X, YC + Y
	MOV	CX,AX			;Get XC - X
	SUB	CX,SI			; ..
	MOV	BX,DX			;Get YC + Y
	ADD	BX,DI			; ..
	CALL	BP			;Plot the point

	OR	DI,DI			;Don't plot if Y = 0
	JZ	Set4PixelsB		; ..

;Plot points if X <> 0 AND Y <> 0

;Plot XC + X, YC - Y
	MOV	CX,AX			;Get XC + X
	ADD	CX,SI			; ..
	MOV	BX,DX			;Get YC - Y
	SUB	BX,DI			; ..
	CALL	BP			;Plot the point

;Plot XC - X, YC - Y
	MOV	CX,AX			;Get XC - X
	SUB	CX,SI			; ..
	MOV	BX,DX			;Get YC - Y
	SUB	BX,DI			; ..
	CALL	BP			;Plot the point
	RET				;Exit

;Plot points if X = 0
Set4PixelsA:

;Plot XC, YC + Y
	MOV	CX,AX			;Get XC
	MOV	BX,DX			;Get YC + Y
	ADD	BX,DI			; ..
	CALL	BP			;Plot the point

	OR	DI,DI			;Don't plot Y = 0
	JZ	Set4PixelsB		; ..

;Plot points if X = 0 AND Y <> 0

;Plot XC, YC - Y
	MOV	CX,AX			;Get XC
	MOV	BX,DX			;Get YC - Y
	SUB	BX,DI			; ..
	CALL	BP			;Plot the point

Set4PixelsB:
	RET				;Exit

;
;Plot ellipse points XC +- X, YC +- Y in CX, BX
;

PlotEllipse:
PE1:	CMP	CX,MinimumX		;Validate X
	JL	PlotEllipse2		; ..
PE2:	CMP	CX,MaximumX		; ..
	JG	PlotEllipse2		; ..
PE3:	CMP	BX,MinimumY		;Validate Y
	JL	PlotEllipse2		; ..
PE4:	CMP	BX,MaximumY		; ..
	JG	PlotEllipse2		; ..

;Entered here for no clipping
PlotEllipseX:
	SHL	BX,1			;Get scan line address from table
	MOV	BX,ScanLine[BX]		; ..
	SHR	CX,1			;Get column offset
	JC	PlotEllipse1		; ..

;Plot a point for an even pixel
	ADD	BX,CX			;Add column offset
	MOV	CL,ES:[BX]		;Plot the point
	AND	CL,0FH			; ..
PE6:	OR	CL,10H			; ..
	MOV	ES:[BX],CL		; ..
	RET

;Plot a point for an odd pixel
PlotEllipse1:
	ADD	BX,CX			;Add column offset
	MOV	CL,ES:[BX]		;Plot the point
	AND	CL,0F0H			; ..
PE7:	OR	CL,01H			; ..
	MOV	ES:[BX],CL		; ..
PlotEllipse2:
	RET

;
;Xor ellipse points XC +- X, YC +- Y in CX, BX
;

XorEllipsePt:
XE1:	CMP	CX,MinimumX		;Validate X
	JL	XorEllipsePt2		; ..
XE2:	CMP	CX,MaximumX		; ..
	JG	XorEllipsePt2		; ..
XE3:	CMP	BX,MinimumY		;Validate Y
	JL	XorEllipsePt2		; ..
XE4:	CMP	BX,MaximumY		; ..
	JG	XorEllipsePt2		; ..

;Entered here for no clipping
XorEllipsePtX:
	SHL	BX,1			;Get scan line address from table
	MOV	BX,ScanLine[BX]		; ..
	SHR	CX,1			;Get column offset
	JC	XorEllipsePt1		; ..

;Plot a point for an even pixel
	ADD	BX,CX			;Add column offset
XE6:	XOR	BYTE PTR ES:[BX],10H	;Xor the point
	RET

;Xor a point for an odd pixel
XorEllipsePt1:
	ADD	BX,CX			;Add column offset
XE7:	XOR	BYTE PTR ES:[BX],01H	;Xor the point
XorEllipsePt2:
	RET

;
;Mulitply the number in DX:AX by number in CX. Return in DX:AX
;

LongMultiply:
	MOV	BX,AX		;Save Lo-order word
	MOV	AX,DX		;AX = Hi-order word
	MUL	CX		;AX = Hi-order word of result
	XCHG	AX,CX		;AX = Multipler, CX = Hi-order word
	MOV	DX,BX		;DX = Lo-order word
	MUL	DX		;AX = Lo-order word of result
	ADD	DX,CX		;DX = Hi-order word of result
	RET

;
;Converts Radius to A, B in proportion to the aspect ratio
;

;Replace INT 0 vector address with new interrupt handler
RadiusToAB:
	CLI			;Critical code -- interrupts off
	PUSH	AX		;Save registers
	PUSH	ES		; ..
	XOR	AX,AX		;Point ES at interrupt vector table
	MOV	ES,AX		; ..
	MOV	AX,ES:[0]	;Save INT 0 vector address
	MOV	[OldINT00],AX	; ..
	MOV	AX,ES:[2]	; ..
	MOV	[OldINT00+2],AX ; ..
	MOV	AX,OFFSET INT00 ;Set new INT 0 vector address
	MOV	ES:[0],AX	; ..
	MOV	ES:[2],CS	; ..
	POP	ES		;Restore registers
	POP	AX		; ..
	STI			;Re-enable interrupts

;Determine scaling
	MOV	[A],BX		;Store initial A, B
	MOV	[B],BX		; ..
	MOV	AX,[XAspect]	;Get XAspect, YAspect
	MOV	BX,[YAspect]	; ..
	CMP	AX,BX		;Don't do any scaling if XAspect = YAspect
	JE	RestoreINT00	; ..
	JB	ScaleA		;Scale A if YAspect > XAspect

;Scale B
	MOV	CX,100		;Aspect = XAspect * 100 / YAspect
	MUL	CX		; ..
	DIV	BX		; ..
	MOV	BX,AX		; ..
	MOV	AX,[B]		;B = B * 100 / Aspect
	MUL	CX		; ..
	DIV	BX		; ..
	MOV	[B],AX		; ..
	JMP	RestoreINT00	;Restore INT 0 interrupt vector address

;Scale A
ScaleA:
	XCHG	AX,BX		;Swap XAspect, YAspect
	MOV	CX,100		;Aspect = YAspect * 100 / XAspect
	MUL	CX		; ..
	DIV	BX		; ..
	MOV	BX,AX		; ..
	MOV	AX,[A]		;A = A * 100 / Aspect
	MUL	CX		; ..
	DIV	BX		; ..
	MOV	[A],AX		; ..
	JMP	RestoreINT00	;Restore INT 0 interrupt vector address

;Trap any divide overflows and exit
INT00:
	ADD	SP,4		;Remove CS:IP from stack
	POPF			;Restore flags

;Restore INT 0 interrupt vector address
RestoreINT00:
	CLI			;Critical code -- interrupts off
	PUSH	AX		;Save registers
	PUSH	ES		; ..
	XOR	AX,AX		;Point ES at interrupt vector table
	MOV	ES,AX		; ..
	MOV	AX,[OldINT00]	;Restore INT 0 vector address
	MOV	ES:[0],AX	; ..
	MOV	AX,[OldINT00+2] ; ..
	MOV	ES:[2],AX	; ..
	POP	ES		;Restore registers
	POP	AX		; ..
	STI			;Re-enable interrupts
	RET

;
;Paint the enclosed figure starting at X, Y with the specified color which is
;surrounded by the specified boundry color.
;
;This is a modified version of a paint routine from:
;  Bluebook of Assembly Language Routines for the IBM PC & XT
;  by Christopher L. Morgan
;  The Waite Group, 1984
;

;PUSH X, Y onto the paint stack
PushPaint MACRO
	LOCAL	PushPaint1

	CMP	SP,OFFSET PaintEnd ;Check if paint stack is full
	JA	PushPaint1	   ; ..
	JMP	PaintExit	   ; ..
PushPaint1:
	PUSH	SI		;PUSH X
	PUSH	DI		;PUSH Y
	ENDM

;Restore stack pointers SS:SP and exit
PaintExit:
	CLI			;Critical code -- interrupts off
	MOV	SS,[SaveSS]	;Restore SS:SP
	MOV	SP,[SaveSP]	; ..
	STI			;Re-enable interrupts
	RET

;Initialize paint color and paint stack
Paint:
	MOV	DH,CL		;Boundry color in DH
	MOV	DL,BL		;Fill color in DL
	CLI			;Critical code -- interrupts off
	MOV	[SaveSS],SS	;Save SS:SP
	MOV	[SaveSP],SP	; ..
	MOV	SP,CS		;Set up local stack
	MOV	SS,SP		; ..
	MOV	SP,OFFSET PaintStack ;Set SP to top of stack
	STI			;Re-enable interrupts
	PushPaint		;PUSH seed onto stack

;Main loop for painting
Paint1:
	CMP	SP,OFFSET PaintStack ;Exit if stack is empty
	JE	PaintExit	     ; ..

;Get the next place to paint
	POP	DI		;POP the next place to paint
	POP	SI		; ..

;Check screen boundries
	CMP	SI,[MinX]	;Left side of screen?
	JL	Paint1		; ..
	CMP	SI,[MaxX]	;Right side of screen?
	JG	Paint1		; ..
	CMP	DI,[MinY]	;Top of screen?
	JL	Paint1		; ..
	CMP	DI,[MaxY]	;Bottom of screen?
	JG	Paint1		; ..

;Copy above, below, and middle scan lines
	PUSH	SI		;Save registers
	PUSH	DI		; ..
	PUSH	DS		; ..

	MOV	AX,DS		;Point ES at current data segment
	MOV	ES,AX		; ..
	MOV	AX,[ScanWords]	;Get number of words to copy
	MOV	BX,ScanAddr	;Get starting scan line address
	SHL	DI,1		; ..
	ADD	BX,DI		; ..
	MOV	DS,[VideoSeg]	;Point DS at video buffer

;Copy above scan line
	MOV	SI,CS:[BX-2]	 ;Copy above scan line
	MOV	DI,OFFSET Above  ; ..
	MOV	CX,AX		 ; ..
	REP	MOVSW		 ; ..

;Copy below scan line
	MOV	SI,CS:[BX+2]	 ;Copy below scan line
	MOV	DI,OFFSET Below  ; ..
	MOV	CX,AX		 ; ..
	REP	MOVSW		 ; ..

;Copy middle scan line
	MOV	SI,CS:[BX]	 ;Copy middle scan line
	MOV	DI,OFFSET Middle ; ..
	MOV	CX,AX		 ; ..
	REP	MOVSW		 ; ..

	POP	DS		;Restore registers
	POP	DI		; ..
	POP	SI		; ..

;Get initial color
	MOV	CX,0F04H	;Setup AND mask/bit shift count
	MOV	BX,SI		;Index into scan line
	SHR	BX,1		; ..
	MOV	AL,Middle[BX]	;Middle scan line color in BL
	JC	Paint2		;Check for odd/even pixel
	SHR	AL,CL		;Move to lower nybble
Paint2:
	AND	AL,CH		;Mask off unwanted bits
	CMP	AL,DL		;Is it filled?
	JE	Paint1		; ..
	CMP	AL,DH		;Is it boundry?
	JE	Paint1		; ..
	MOV	BP,[MaxX]	;Get iteration count value
	SUB	BP,SI		; ..
	INC	BP		; ..

;Scan right until boundry is reached
Paint3:
	INC	SI		;X = X + 1
	MOV	BX,SI		;Index into scan line
	SHR	BX,1		; ..
	MOV	AL,Middle[BX]	;Middle scan line color in BL
	JC	Paint3A		;Check for odd/even pixel
	SHR	AL,CL		;Move color to proper position
Paint3A:
	AND	AL,CH		;Mask off unwanted bits
	CMP	AL,DL		;Is it filled?
	JE	Paint4		; ..
	CMP	AL,DH		;Is it boundry?
	JE	Paint4		; ..
	DEC	BP		;Continue scanning right
        JNZ     Paint3          ; ..

;PUSH above and below
Paint4:
	DEC	SI		;Restore X
	MOV	BX,SI		;Index into scan lines
	SHR	BX,1		; ..
	MOV	AL,Above[BX]	;Above scan line color in AL
	MOV	AH,Below[BX]	;Below scan line color in AH
	JC	Paint4A		;Check for odd/even pixel
	SHR	AX,CL		; ..
Paint4A:
	AND	AX,0F0FH	;Mask off unwanted bits
	CMP	AL,DL		;Is it filled?
	JE	Paint5		; ..
	CMP	AL,DH		;Is it boundry?
	JE	Paint5		; ..
	DEC	DI		;Y = Y - 1
	PushPaint		;PUSH above
	INC	DI		;Restore Y
Paint5:
	CMP	AH,DL		;Is it filled?
	JE	Paint6		; ..
	CMP	AH,DH		;Is it boundry?
	JE	Paint6		; ..
	INC	DI		;Y = Y + 1
	PushPaint		;PUSH below
	DEC	DI		;Restore Y
Paint6:
	MOV	[X2],SI		;Store X ordinate end of scan line
	MOV	BP,SI		;Get iteration count
	SUB	BP,[MinX]	; ..
	INC	BP		; ..
	JMP	Paint9

PushAbove:
	DEC	DI		;Y = Y - 1
	PushPaint		;PUSH above if new place to paint
	INC	DI		;Restore Y
	JMP	Paint8

PushBelow:
	INC	DI		;Y = Y + 1
	PushPaint		;PUSH below if new place to paint
	DEC	DI		;Restore Y
	JMP	Paint9

;Scan left, checking above and below

;Check above
Paint7:
	CMP	AL,DL		;Is it filled?
	JE	Paint8		; ..
	CMP	AL,DH		;Is it boundry?
	JE	Paint8		; ..
	CMP	BL,DL		;Last above filled?
	JE	PushAbove	; ..
	CMP	BL,DH		;Last above boundry?
	JE	PushAbove	; ..

;Check below
Paint8:
	CMP	AH,DL		;Is it filled?
	JE	Paint9		; ..
	CMP	AH,DH		;Is it boundry?
	JE	Paint9		; ..
	CMP	BH,DL		;Last below filled?
	JE	PushBelow	; ..
	CMP	BH,DH		;Last below boundry?
	JE	PushBelow	; ..
Paint9:
	MOV	ES,AX		;Save last above and below state

;Move left
	DEC	SI		;X = X - 1
	MOV	BX,SI		;Index into scan lines
	SHR	BX,1		; ..
	MOV	AL,Above[BX]	;Above scan line color in AL
	MOV	AH,Below[BX]	;Below scan line color in AH
	MOV	BL,Middle[BX]	;Middle scan line color in BL
	JC	Paint9A		;Check for odd/even pixel
	SHR	AX,CL		;Move color to proper position
	SHR	BL,CL		; ..
Paint9A:
	AND	AX,0F0FH	;Mask off unwanted bits
	AND	BL,CH		; ..
	CMP	BL,DL		;Hit filled yet?
	JE	Paint10		; ..
	CMP	BL,DH		;Hit boundry yet?
	JE	Paint10		; ..
	MOV	BX,ES		;Restore last above and below state
	DEC	BP		;Continue scanning left
	JNZ	Paint7		; ..
Paint10:
	INC	SI		;Restore X
	MOV	BP,[X2]		;Save ending column
	MOV	ES,[VideoSeg]	;Point ES at video segment

;Get starting and ending addresses
	SHL	DI,1		;Get starting address in DI
	MOV	DI,ScanLine[DI] ; ..
	MOV	BX,DI		; ..
	MOV	AX,SI		; ..
	SHR	AX,1		; ..
	ADD	DI,AX		; ..
	MOV	AX,BP		;Get ending address in BX
	SHR	AX,1		; ..
	ADD	BX,AX		; ..
	MOV	AL,DL		;Fill color in AL and DL
	MOV	CL,4		; ..
	SHL	AL,CL		; ..

;Fill partial bytes if necessary
	TEST	SI,1		;Check for partial byte
	JZ	Paint11		; ..
	MOV	AH,ES:[DI]	;Plot the point
	AND	AH,0F0H		; ..
	OR	AH,DL		; ..
	MOV	ES:[DI],AH	; ..
	INC	DI		;Point to next byte
Paint11:
	TEST	BP,1		;Check for partial byte
	JNZ	Paint12		; ..
	MOV	AH,ES:[BX]	;Plot the point
	AND	AH,0FH		; ..
	OR	AH,AL		; ..
	MOV	ES:[BX],AH	; ..
	DEC	BX		;Point to previous byte

;Fill the scan line with paint color
Paint12:
	SUB	BX,DI		;Get byte count
	JB	Paint13		;Skip if no more to do
	MOV	CX,BX		;Byte count in CX
	INC	CX		; ..
	OR	AL,DL		;Form full byte of color
	REP	STOSB		;Fill the scan line
Paint13:
	JMP	Paint1		;Do next scan line

;
;Draw a solid filled box from X1, Y1 - X2, Y2 using the specified color
;

FillBox:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	FillBoxC	; ..
	POP	[DColor]	;Restore current drawing color
	RET

;
;Draw a solid filled box from X1, Y1 - X2, Y2 using the current drawing color
;

FillBoxC:
	MOV	[OldX],SI	;Update old X, Y values
	MOV	[OldY],DI	; ..
FillBoxCX:
	CALL	ValidateCoords	;See box in is range
	OR	AX,AX		; ..
	JZ	FillBoxC1	; ..
	RET			; ..
FillBoxC1:
	SUB	DI,CX		;Get number of rows to process
	INC	DI		; ..
	MOV	[NextLine],DI	; ..
	MOV	BP,CX		;Get starting scan line table address in BP
	SHL	BP,1		; ..
	ADD	BP,ScanAddr	; ..
	MOV	AL,[DColorB]	;Form fill color in AL, Plot colors in DH & DL
	MOV	DL,AL		; ..
	MOV	DH,AL		; ..
	MOV	CL,4		; ..
	SHL	DH,CL		; ..
	OR	AL,DH		; ..

;Get starting and ending addresses
FillBoxC3:
	MOV	DI,BX		;Get starting and ending addresses
	SHR	DI,1		; ..
	ADD	DI,CS:[BP]	; ..
	MOV	CX,SI		; ..
	SHR	CX,1		; ..
	ADD	CX,CS:[BP]	; ..

;Fill partial bytes if necessary
	TEST	BX,1		;Check for partial byte
	JZ	FillBoxC4	; ..
	MOV	AH,ES:[DI]	;Plot the point
	AND	AH,0F0H		; ..
	OR	AH,DL		; ..
	MOV	ES:[DI],AH	; ..
	INC	DI		;Point to next byte
FillBoxC4:
	TEST	SI,1		;Check for partial byte
	JNZ	FillBoxC5	; ..
	XCHG	DI,CX		;Plot the point
	MOV	AH,ES:[DI]	; ..
	AND	AH,0FH		; ..
	OR	AH,DH		; ..
	MOV	ES:[DI],AH	; ..
	XCHG	CX,DI		; ..
	DEC	CX		;Point to previous byte

;Fill the scan line with color
FillBoxC5:
	SUB	CX,DI		;Get byte count
	JB	FillBoxC6	; ..
	INC	CX		; ..
	REP	STOSB		;Fill the scan line
FillBoxC6:
	INC	BP		;Point to next row
	INC	BP		; ..
	DEC	[NextLine]	;Do next row
	JNZ	FillBoxC3	; ..
	RET

;
;Xor a solid filled box from X1, Y1 - X2, Y2 using the specified color
;

XorFillBox:
	PUSH	[DColor]	;Save current drawing color
	MOV	[DColorB],DL	;Set drawing color
	CALL	XorFillBoxC	; ..
	POP	[DColor]	;Restore current drawing color
	RET

;
;Xor a solid filled box from X1, Y1 - X2, Y2 using the current drawing color
;

XorFillBoxC:
	MOV	[OldX],SI	;Update old X,Y values
	MOV	[OldY],DI	; ..
XorFillBoxCX:
	CALL	ValidateCoords	;See box in is range
	OR	AX,AX		; ..
	JZ	XorFillBoxCX1	; ..
	RET			; ..
XorFillBoxCX1:
	MOV	AX,CX		;Index into scan line table
	SHL	AX,1		; ..
	ADD	AX,ScanAddr	; ..
	SUB	SI,BX		;Get number of pixels per row
	INC	SI		; ..
	MOV	DX,SI		; ..
	MOV	SI,AX		;Get starting scan line address
	XOR	AX,AX		;Determine if even number of pixels
	SHR	DX,1		; ..
	JNC	XorFillBoxCX2	; ..
	MOV	AX,1		; ..
XorFillBoxCX2:			; ..
	MOV	[LastByte],AX	; ..
	SUB	DI,CX		;Get number of rows
	INC	DI		; ..
	MOV	BP,DI		; ..
	MOV	AL,[DColorB]	;Get XOR color mask in AH & AL
	MOV	AH,AL		; ..
	MOV	CL,4		; ..
	SHL	AH,CL		; ..
	PUSH	DS		;Save DS
	MOV	DS,[VideoSeg]	;Point DS at video buffer
	SHR	BX,1		;Determine odd/even processing
	JC	XorBoxOdd	; ..

XorBoxEven:
	OR	AL,AH		;Get XOR color mask in AL

XorBoxEvenX:
	MOV	DI,CS:[SI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CX,DX		;Get number of pixels to transfer
	OR	CX,CX		;See if only 1 pixel
	JZ	XorBoxEven2	; ..

XorBoxEven1:
	XOR	[DI],AL		;Transfer byte
	INC	DI		;Point to next video byte
	LOOP	XorBoxEven1	;Do next byte
	CMP	CS:[LastByte],1 ;See if odd number of pixels
	JNE	XorBoxEven3	; ..
XorBoxEven2:
	XOR	[DI],AH		;Transfer last pixel
XorBoxEven3:
	INC	SI		;Point to next scan line
	INC	SI		; ..
	DEC	BP		;Do next scan line
	JNZ	XorBoxEvenX	; ..
	POP	DS		;Restore DS
	RET

XorBoxOdd:
	MOV	DI,CS:[SI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CX,DX		;Get number of pixels to transfer
	OR	CX,CX		;See if only 1 pixel
	JZ	XorBoxOdd2	; ..

XorBoxOdd1:
	XOR	[DI],AX		;Transfer byte
	INC	DI		;Point to next video byte
	LOOP	XorBoxOdd1	;Do next byte
	CMP	CS:[LastByte],1 ;See if odd number of pixels
	JNE	XorBoxOdd3	; ..
XorBoxOdd2:
	XOR	[DI],AL		;Transfer last pixel
XorBoxOdd3:
	INC	SI		;Point to next scan line
	INC	SI		; ..
	DEC	BP		;Do next scan line
	JNZ	XorBoxOdd	; ..
	POP	DS		;Restore DS
	RET

;
;Change a palette register color
;

SetPalette:
	MOV	DI,16		;Port offset for palette registers

;Entered here to set border register
SetPalette1:
	MOV	DX,3DAH		;Address & status register
	CLI			;Clear interrupts
SetPalette2:
	IN	AL,DX		;Get status register
	AND	AL,8		;Look for bit 3
	JZ	SetPalette2	;Wait for vertical retrace
	MOV	AX,BX		;Get palette number
	ADD	AX,DI		;ADD offset for palette or border
	OUT	DX,AL		;Set palette
	MOV	AX,CX		;Get color to store
	MOV	DX,3DEH		;Palette data register
	OUT	DX,AL		;Set palette color
	MOV	DX,3DAH		;Address & status register
	XOR	AX,AX		;AL = 0 to reset address register
	OUT	DX,AL		;Reset it
	STI			;Re-enable interrupts
	RET

;
;Change all 16 palette registers using 16 elements of an integer array
;

PaletteUsing:
	MOV	[BColorB],0	;Reset border color to palette register 0
	MOV	DS,SS_DS	;Get segment address of array
	MOV	SI,DX		;OFFSET address in SI
	XOR	BX,BX		;Border register is 0
	XOR	CX,CX		;Color to store in CX
	MOV	DI,2		;Border register offset is 2
	CALL	SetPalette1	;Set the border color
	MOV	BP,16		;Set count for colors 0-15
	XOR	BX,BX		;Palette register number in BX
PaletteUsing1:
	MOV	CX,[SI]		;Color to store in CX
	CALL	SetPalette	;Set the palette register color
	INC	BX		;Bump up to next palette register number
	INC	SI		;Point to next color in the array
	INC	SI		; ..
	DEC	BP		;Do next color
	JNZ	PaletteUsing1	; ..
	RET

;
;Reset the all 16 palette registers to their default state
;

ResetPalette:
	MOV	[BColorB],0	;Reset background color to black
	XOR	BX,BX		;Border register is 0
	XOR	CX,CX		;Color to store in CX
	MOV	DI,2		;Border register offset is 2
	CALL	SetPalette1	;Set the border color
	MOV	BP,16		;Set count for colors 0-15
	XOR	BX,BX		;Palette register number in BX
ResetPalette1:
	MOV	CX,BX		;Palette registers are same as color
	CALL	SetPalette	;Set the palette register
	INC	BX		;Do next palette register
	DEC	BP		;Do next color
	JNZ	ResetPalette1	; ..
	RET

;
;Store entire graphics screen into an array
;

GetScreen:
	MOV	ES,SS_DS	;ES:DI points to array
	MOV	DI,DX		; ..
	MOV	AX,[MaxScrnX]	;Store number of columns in 1st word
	INC	AX		; ..
	MOV	ES:[DI],AX	; ..
	MOV	AX,[MaxScrnY]	;Get number of scan lines to process
	INC	AX		; ..
	MOV	ES:[DI+2],AX	;Store number of lines in 2nd word
	ADD	DI,4		;Point to start of array
	MOV	DX,[ScanWords]	;Get number of words per scan line
	MOV	BX,ScanAddr	;Point to starting scan line address
	MOV	DS,[VideoSeg]	;DS:SI point video buffer

GetScreen1:
	MOV	SI,CS:[BX]	;Get current scan line address
	MOV	CX,DX		;Get number of words to copy
	REP	MOVSW		;Copy current scan line into array
	INC	BX		;Point to next scan line
	INC	BX		; ..
	DEC	AX		;Do next scan line
	JNZ	GetScreen1	; ..
	RET

;
;Transfer an entire array into graphics screen
;

PutScreen:
	MOV	ES,[VideoSeg]	;ES:DI points to video buffer
	MOV	BX,ScanAddr	;Get starting scan line address
	MOV	DS,SS_DS	;DS:SI points to array
	MOV	SI,DX		; ..
	MOV	DX,[SI]		;Get number of words per scan line
	SHR	DX,1		; ..
	SHR	DX,1		; ..
	MOV	AX,[SI+2]	;Get number of scan lines to process
	ADD	SI,4		;Point to start of array

PutScreen1:
	MOV	DI,CS:[BX]	;Get current scan line address
	MOV	CX,DX		;Get number of words to copy
	REP	MOVSW		;Copy current scan line into video buffer
	INC	BX		;Point to next scan line
	INC	BX		; ..
	DEC	AX		;Do next scan line
	JNZ	PutScreen1	; ..
	RET

;
;Store a graphics image from X1, Y1 - X2, Y2 into an array
;

Get:
	CALL	ValidateCoords	;See if Get area is in range
	OR	AX,AX		; ..
	JZ	GetOK		; ..

;Get area out of range, put default values into array
	MOV	ES,SS_DS	;ES:BX = Address of array
	MOV	BX,DX		; ..
	MOV	AX,1		;Store default values in array
	MOV	ES:[BX],AX	; .. 1 Column, 1 Row, Zero 1st byte
	MOV	ES:[BX+2],AX	; ..
	MOV	AL,0		; ..
	MOV	ES:[BX+4],AL	; ..
	RET

GetOK:
	MOV	ES,SS_DS	;ES:DI = Address of array
	XCHG	DX,DI		; ..
	MOV	BP,CX		;Get starting scan line address
	SHL	BP,1		; ..
	ADD	BP,ScanAddr	; ..
	SUB	DX,CX		;Get number of lines
	INC	DX		; ..
	MOV	CX,DX		; ..
	SUB	SI,BX		;Get number of columns
	INC	SI		; ..
	MOV	AX,SI		;Store number of columns in 1st word of array
	STOSW			; ..
	MOV	AX,CX		;Store number of lines in 2nd word of array
	STOSW			; ..
	MOV	DX,SI		;Get number of bytes per line
	SHR	DX,1		; ..
	JNC	Get1		; ..
	INC	DX		; ..
Get1:
	MOV	DS,[VideoSeg]	;Get segment address of video buffer
	SHR	BX,1		;Check for odd/even processing
	JC	GetOdd		; ..

GetEven:
	PUSH	CX		;Save row counter
	MOV	SI,CS:[BP]	;Get starting address of in video buffer
	ADD	SI,BX		; ..
	MOV	CX,DX		;Get number of bytes per row

GetEven1:
	LODSB			;Get pixels from video buffer
	STOSB			;Store pixels in array
	LOOP	GetEven1	;Do next byte
	POP	CX		;Restore row counter
	INC	BP		;Point to row
	INC	BP		; ..
	LOOP	GetEven		;Do next row
	RET

GetOdd:
	PUSH	CX		;Save registers
	PUSH	DX		; ..
	MOV	SI,CS:[BP]	;Get scan line address from table
	ADD	SI,BX		;Add column offset
	MOV	CL,4		;Set up shift count

GetOdd1:
	LODSW			;Get pixels from the video buffer
	DEC	SI		; ..
	ROL	AX,CL		;Move pixels to proper position
	STOSB			;Store it in the array
	DEC	DX		;Do next byte
	JNZ	GetOdd1		; ..
	POP	DX		;Restore registers
	POP	CX		; ..
	INC	BP		;Point to row
	INC	BP		; ..
	LOOP	GetOdd		;Do next row
	RET

;
;Transfer an image stored with 'Get' starting at X,Y using 1 of 5 actions:
;  PRESET, PSET, AND, OR, XOR
;

PUSHP	MACRO

	PUSH	BX		;Save registers
	PUSH	CX		; ..
	PUSH	SI		; ..
	PUSH	DI		; ..
	PUSH	BP		; ..

	ENDM

POPP	MACRO

	POP	BP		;Restore registers
	POP	DI		; ..
	POP	SI		; ..
	POP	CX		; ..
	POP	BX		; ..

	ENDM

Put:
	MOV	[OldY],SI	;Update old X,Y values
	MOV	[OldX],DI	; ..
	MOV	DS,SS_DS	;Get segment address of array

;Entered here for 'PlotCursor'
PutX:
	CALL	CheckPut	;Validate image and get initial values
	OR	AX,AX		;Everything OK?
	JNZ	PutExit		;No, image is outside clipping region

;Entered here for 'Animate'
PutAction:
	PUSH	DS		;Save DS
	MOV	DS,CS:[VideoSeg];Point DS at video buffer
PutAction1:
	PUSHP			;Save registers
	CALL	CS:[Action]	;Call selected routine
	POPP			;Restore registers
	INC	DI		;Point to next scan line
	INC	DI		; ..
	ADD	SI,CS:[NextLine];Point to next array line
	LOOP	PutAction1	;Do next scan line
	POP	DS		;Restore DS
PutExit:
	RET

;XOR for even pixels in both the video buffer and array
PutXorEven:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutXorEven2	; ..
PutXorEven1:
	LODS	ArrayB		;Store array pixels AL
	XOR	[DI],AL		;Xor pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorEven1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutXorEven3	; ..
PutXorEven2:
	LODS	ArrayB		;Xor last pixel
	AND	AL,0F0H		; ..
	XOR	[DI],AL		; ..
PutXorEven3:
	RET

;XOR for even pixels in the video buffer, odd pixels in the array
PutXorEvenX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Get shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutXorEvenX2	; ..
PutXorEvenX1:
	LODS	ArrayW		;Store array pixels AL
	DEC	SI		; ..
	ROL	AX,CL		; ..
	XOR	[DI],AL		;Xor pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorEvenX1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutXorEvenX3	; ..
PutXorEvenX2:
	LODS	ArrayB		;Xor last pixel
	SHL	AL,CL		; ..
	XOR	[DI],AL		; ..
PutXorEvenX3:
	RET

;XOR for odd pixels in the video buffer, even pixels in the array
PutXorOdd:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0F00FH	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutXorOdd4	; ..
PutXorOdd1:
	LODS	ArrayW		;Store array pixels AX & BX
	MOV	BX,AX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,DX		; ..
	XOR	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorOdd2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutXorOdd3
PutXorOdd2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,DX		; ..
	XOR	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorOdd1	; ..
PutXorOdd3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutXorOdd5	; ..
PutXorOdd4:
	LODS	ArrayB		;Xor last pixel
	SHR	AL,CL		; ..
	XOR	[DI],AL		; ..
PutXorOdd5:
	RET

;XOR for odd pixels in both the video buffer and array
PutXorOddX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0F00FH	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutXorOddX4	; ..
PutXorOddX1:
	LODS	ArrayW		;Store array pixels AX & BX
	MOV	BX,AX		; ..
	LODS	ArrayB		; ..
	DEC	SI		; ..
	AND	BL,DL		; ..
	AND	AL,DH		; ..
	OR	BL,AL		; ..
	ROL	BX,CL		; ..
	MOV	AX,BX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,DX		; ..
	XOR	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorOddX2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutXorOddX3
PutXorOddX2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,DX		; ..
	XOR	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutXorOddX1	;Do next byte
PutXorOddX3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutXorOddX5	; ..
PutXorOddX4:
	LODS	ArrayB		;Xor last pixel
	AND	AL,0FH		; ..
	XOR	[DI],AL		; ..
PutXorOddX5:
	RET

;OR for even pixels in both the video buffer and array
PutOrEven:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutOrEven2	; ..
PutOrEven1:
	LODS	ArrayB		;Store array pixels AL
	OR	[DI],AL		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrEven1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutOrEven3	; ..
PutOrEven2:
	LODS	ArrayB		;Or last pixel
	AND	AL,0F0H		; ..
	OR	[DI],AL		; ..
PutOrEven3:
	RET

;OR for even pixels in the video buffer, odd pixels in the array
PutOrEvenX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Get shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutOrEvenX2	; ..
PutOrEvenX1:
	LODS	ArrayW		;Store array pixels AL
	DEC	SI		; ..
	ROL	AX,CL		; ..
	OR	[DI],AL		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrEvenX1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutOrEvenX3	; ..
PutOrEvenX2:
	LODS	ArrayB		;Or last pixel
	SHL	AL,CL		; ..
	OR	[DI],AL		; ..
PutOrEvenX3:
	RET

;OR for odd pixels in the video buffer, even pixels in the array
PutOrOdd:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0F00FH	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutOrOdd4	; ..
PutOrOdd1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,DX		; ..
	OR	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrOdd2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutOrOdd3
PutOrOdd2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,DX		; ..
	OR	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrOdd1	; ..
PutOrOdd3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutOrOdd5	; ..
PutOrOdd4:
	LODS	ArrayB		;Or last pixel
	SHR	AL,CL		; ..
	OR	[DI],AL		; ..
PutOrOdd5:
	RET

;OR for odd pixels in both the video buffer and array
PutOrOddX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0F00FH	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutOrOddX4	; ..
PutOrOddX1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	LODS	ArrayB		; ..
	DEC	SI		; ..
	AND	BL,DL		; ..
	AND	AL,DH		; ..
	OR	BL,AL		; ..
	ROL	BX,CL		; ..
	MOV	AX,BX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,DX		; ..
	OR	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrOddX2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutOrOddX3
PutOrOddX2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,DX		; ..
	OR	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutOrOddX1	; ..
PutOrOddX3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutOrOddX5	; ..
PutOrOddX4:
	LODS	ArrayB		;Or last pixel
	AND	AL,0FH		; ..
	OR	[DI],AL		; ..
PutOrOddX5:
	RET

;AND for even pixels in both the video buffer and array
PutAndEven:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutAndEven2	; ..
PutAndEven1:
	LODS	ArrayB		;Store array pixels in AL
	AND	[DI],AL		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndEven1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutAndEven3	; ..
PutAndEven2:
	LODS	ArrayB		;And last pixel
	OR	AL,0FH		; ..
	AND	[DI],AL		; ..
PutAndEven3:
	RET

;AND for even pixels in the video buffer, odd pixels in the array
PutAndEvenX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Get shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutAndEvenX2	; ..
PutAndEvenX1:
	LODS	ArrayW		;Store array pixels in AL
	DEC	SI		; ..
	ROL	AX,CL		; ..
	AND	[DI],AL		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndEvenX1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutAndEvenX3	; ..
PutAndEvenX2:
	LODS	ArrayB		;And last pixel
	SHL	AL,CL		; ..
	AND	[DI],AL		; ..
PutAndEvenX3:
	RET

;AND for odd pixels in the video buffer, even pixels in the array
PutAndOdd:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0FF0H	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutAndOdd4	; ..
PutAndOdd1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	ROR	AX,CL		;Move pixels to proper position
	OR	AX,DX		;Mask off unwanted bits
	AND	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndOdd2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutAndOdd3
PutAndOdd2:
	ROL	BX,CL		;Move pixels to proper position
	OR	BX,DX		;Mask off unwanted bits
	AND	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndOdd1	; ..
PutAndOdd3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutAndOdd5	; ..
PutAndOdd4:
	LODS	ArrayB		;And last pixel
	SHR	AL,CL		; ..
	OR	AL,0F0H		; ..
	AND	[DI],AL		; ..
PutAndOdd5:
	RET

;AND for odd pixels in both the video buffer and array
PutAndOddX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	MOV	DX,0FF0H	;Get AND mask
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutAndOddX4	; ..
PutAndOddX1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	LODS	ArrayB		; ..
	DEC	SI		; ..
	AND	BL,DH		; ..
	AND	AL,DL		; ..
	OR	BL,AL		; ..
	ROL	BX,CL		; ..
	MOV	AX,BX		; ..
	ROR	AX,CL		;Move pixels to proper position
	OR	AX,DX		;Mask off unwanted bits
	AND	[DI],AX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndOddX2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutAndOddX3
PutAndOddX2:
	ROL	BX,CL		;Move pixels to proper position
	OR	BX,DX		;Mask off unwanted bits
	AND	[DI],BX		;Transfer pixels
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutAndOddX1	; ..
PutAndOddX3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutAndOddX5	; ..
PutAndOddX4:
	LODS	ArrayB		;And last pixel
	OR	AL,0F0H		; ..
	AND	[DI],AL		; ..
PutAndOddX5:
	RET

;PSET for even pixels in both the video buffer and array
PutPsetEven:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there is only 1 pixel to do?
	JZ	PutPsetEven2	; ..
PutPsetEven1:
	LODS	ArrayB		;Store array pixels in AL
	MOV	DL,[DI]		;Store video pixel in DL
	AND	DL,0		;Transfer pixels
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetEven1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPsetEven3	; ..
PutPsetEven2:
	LODS	ArrayB		;Transfer last pixel
	AND	AL,0F0H		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0FH		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPsetEven3:
	RET

;PSET for even pixels in the video buffer, odd pixels in the array
PutPsetEvenX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Get shift count
	OR	BP,BP		;Is there is only 1 pixel to do?
	JZ	PutPsetEvenX2	; ..
PutPsetEvenX1:
	LODS	ArrayW		;Store array pixels in AL
	DEC	SI		; ..
	ROL	AX,CL		; ..
	MOV	DL,[DI]		;Store video pixel in DL
	AND	DL,0		;Transfer pixels
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetEvenX1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPsetEvenX3	; ..
PutPsetEvenX2:
	LODS	ArrayB		;Transfer last pixel
	SHL	AL,CL		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0FH		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPsetEvenX3:
	RET

;PSET for odd pixels in the video buffer, even pixels in the array
PutPsetOdd:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutPsetOdd4	; ..
PutPsetOdd1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,0F00FH	; ..
	MOV	DX,[DI]		;Store video pixels in DX
	AND	DX,0FF0H	;Transfer pixels
	OR	DX,AX		; ..
	MOV	[DI],DX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetOdd2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutPsetOdd3
PutPsetOdd2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,0F00FH	; ..
	MOV	AX,[DI]		;Store video pixels in DX
	AND	AX,0FF0H	;Transfer pixels
	OR	AX,BX		; ..
	MOV	[DI],AX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetOdd1	; ..
PutPsetOdd3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPsetOdd5	; ..
PutPsetOdd4:
	LODS	ArrayB		;Transfer last pixel
	SHR	AL,CL		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0F0H		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPsetOdd5:
	RET

;PSET for odd pixels in both the video buffer and array
PutPsetOddX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there only 1 pixel to do?
	MOV	CL,4		;Set up shift count
	JZ	PutPsetOddX4	; ..
PutPsetOddX1:
	LODS	ArrayW		;Store array pixels in AX & BX
	MOV	BX,AX		; ..
	LODS	ArrayB		; ..
	DEC	SI		; ..
	AND	BL,0FH		; ..
	AND	AL,0F0H		; ..
	OR	BL,AL		; ..
	ROL	BX,CL		; ..
	MOV	AX,BX		; ..
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,0F00FH	; ..
	MOV	DX,[DI]		;Store video pixels in DX
	AND	DX,0FF0H	;Transfer pixels
	OR	DX,AX		; ..
	MOV	[DI],DX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetOddX2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutPsetOddX3
PutPsetOddX2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,0F00FH	; ..
	MOV	AX,[DI]		;Store video pixels in DX
	AND	AX,0FF0H	;Transfer pixels
	OR	AX,BX		; ..
	MOV	[DI],AX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPsetOddX1	; ..
PutPsetOddX3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPsetOddX5	; ..
PutPsetOddX4:
	LODS	ArrayB		;Transfer last pixel
	AND	AL,0FH		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0F0H		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPsetOddX5:
	RET

;PRESET for even pixels in both the video buffer and array
PutPresetEven:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutPresetEven2	; ..
PutPresetEven1:
	LODS	ArrayB		;Store array pixels in AL
	NOT	AL		;Make pixels their numeric opposite
	MOV	DL,[DI]		;Store video pixels in DL
	AND	DL,0		;Transfer pixels
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetEven1	; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPresetEven3	; ..
PutPresetEven2:
	LODS	ArrayB		;Transfer last pixel
	NOT	AL		; ..
	AND	AL,0F0H		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0FH		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPresetEven3:
	RET

;PRESET for even pixels in the video buffer, odd pixels in the array
PutPresetEvenX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Get shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutPresetEvenX2 ; ..
PutPresetEvenX1:
	LODS	ArrayW		;Store array pixels in AL
	DEC	SI		; ..
	ROL	AX,CL		; ..
	NOT	AL		;Make pixels their numeric opposite
	MOV	DL,[DI]		;Store video pixels in DL
	AND	DL,0		;Transfer pixels
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetEvenX1 ; ..
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPresetEvenX3 ; ..
PutPresetEvenX2:
	LODS	ArrayB		;Transfer last pixel
	NOT	AL		; ..
	SHL	AL,CL		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0FH		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPresetEvenX3:
	RET

;PRESET for odd pixels in the video buffer, even pixels in the array
PutPresetOdd:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutPresetOdd4	; ..
PutPresetOdd1:
	LODS	ArrayW		;Get pixels from array
	NOT	AX		;Make pixels their numeric opposite
	MOV	BX,AX		;Store pixels in AX & BX
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,0F00FH	; ..
	MOV	DX,[DI]		;Store video pixels in DX
	AND	DX,0FF0H	;Transfer pixels
	OR	DX,AX		; ..
	MOV	[DI],DX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetOdd2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutPresetOdd3
PutPresetOdd2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,0F00FH	; ..
	MOV	AX,[DI]		;Store video pixels in DX
	AND	AX,0FF0H	;Transfer pixels
	OR	AX,BX		; ..
	MOV	[DI],AX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetOdd1	;Do next byte
PutPresetOdd3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPresetOdd5	; ..
PutPresetOdd4:
	LODS	ArrayB		;Transfer last pixel
	NOT	AL		; ..
	SHR	AL,CL		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0F0H		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPresetOdd5:
	RET

;PRESET for odd pixels in both the video buffer and array
PutPresetOddX:
	MOV	DI,CS:[DI]	;Get starting address
	ADD	DI,BX		; ..
	MOV	CL,4		;Set up shift count
	OR	BP,BP		;Is there only 1 pixel to do?
	JZ	PutPresetOddX4	; ..
PutPresetOddX1:
	LODS	ArrayW		;Get pixels from array
	MOV	BX,AX		; ..
	LODS	ArrayB		; ..
	DEC	SI		; ..
	AND	BL,0FH		; ..
	AND	AL,0F0H		; ..
	OR	BL,AL		; ..
	ROL	BX,CL		; ..
	MOV	AX,BX		; ..
	NOT	AX		;Make pixels their numeric opposite
	MOV	BX,AX		;Store pixels in AX & BX
	ROR	AX,CL		;Move pixels to proper position
	AND	AX,0F00FH	; ..
	MOV	DX,[DI]		;Store video pixels in DX
	AND	DX,0FF0H	;Transfer pixels
	OR	DX,AX		; ..
	MOV	[DI],DX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetOddX2	; ..
	DEC	SI		;Adjust for last pixel
	JMP	PutPresetOddX3
PutPresetOddX2:
	ROL	BX,CL		;Move pixels to proper position
	AND	BX,0F00FH	; ..
	MOV	AX,[DI]		;Store video pixels in DX
	AND	AX,0FF0H	;Transfer pixels
	OR	AX,BX		; ..
	MOV	[DI],AX		; ..
	INC	DI		;Point to next video byte
	DEC	BP		;Do next byte
	JNZ	PutPresetOddX1	;Do next byte
PutPresetOddX3:
	CMP	CS:[LastByte],1 ;Odd number of pixels to do?
	JNE	PutPresetOddX5	; ..
PutPresetOddX4:
	LODS	ArrayB		;Transfer last pixel
	NOT	AL		; ..
	AND	AL,0FH		; ..
	MOV	DL,[DI]		; ..
	AND	DL,0F0H		; ..
	OR	DL,AL		; ..
	MOV	[DI],DL		; ..
PutPresetOddX5:
	RET

;
;Animate a figure with the 'Put' function using the XOR option
;

Animate:
	MOV	[OldY],SI	;Update old X,Y values
	MOV	[OldX],DI	; ..
	MOV	[SaveCount],CX	;Save delay value
	MOV	DS,SS_DS	;Get segment address of array
	MOV	BX,5		;Use XOR option
	CALL	CheckPut	;Validate image, and get initial values
	OR	AX,AX		;Everything OK?
	JNZ	Animate2	;No, image outside clipping region
	PUSHR			;Save registers
	CALL	PutAction	;Transfer the image
	MOV	CX,CS:[SaveCount] ;Delay between initial and final Put
Animate1:			  ; ..
	LOOP	Animate1	  ; ..
	POPR			;Restore registers
	CALL	PutAction	;Erase the image
Animate2:
	RET

;
;Validates image is within clipping region and initializes all Put values
;

CheckPutError:
	MOV	AX,1		;Indicate image out of range
	RET

CheckPut:
	MOV	AX,DS		;Point ES at array
	MOV	ES,AX		; ..
	MOV	AX,CS		;Restore local data segment
	MOV	DS,AX		; ..
	CMP	BX,5		;Validate action indicator
	JA	CheckPutError	; ..
	DEC	BX		;Get initial index for selected routine
	SHL	BX,1		; ..
	SHL	BX,1		; ..
	SHL	BX,1		; ..
	MOV	[Action],BX	; ..
	MOV	BP,DX		;Get offset address of array
	MOV	BX,SI		;Form X1, Y1
	MOV	CX,DI		; ..
	ADD	SI,ES:[BP]	;Form X2
	DEC	SI		; .. X1 + Columns - 1
	ADD	DI,ES:[BP+2]	;Form Y2
	DEC	DI		; .. Y1 + Rows - 1
	CALL	SortCoords	;Force X1 < X2, Y1 < Y2
	MOV	[X1],BX		;Save X1, Y1, X2, Y2 before clipping
	MOV	[Y1],CX		; ..
	MOV	[X2],SI		; ..
	MOV	[Y2],DI		; ..
	CALL	ValidateCoordsX ; ..
	OR	AX,AX		;See if image is out of range
	JNZ	CheckPutError	; ..
	MOV	[X1A],BX	;Save X1, Y1, X2, Y2 after clipping
	MOV	[Y1A],CX	; ..
	MOV	[X2A],SI	; ..
	MOV	[Y2A],DI	; ..
	MOV	AX,ES:[BP]	;Get length of one array line
	SHR	AX,1		; ..
	JNC	CheckPut3	; ..
	INC	AX		; ..
CheckPut3:			; ..
	MOV	[NextLine],AX	; ..
	ADD	BP,4		;Point to 1st color in array
	SUB	CX,[Y1]		;Get offset into array relative to clipping
	MUL	CX		; .. region
	SUB	BX,[X1]		; .. ((Columns / 2) * (Y1A - Y1)) +
	SHR	BX,1		; .. ((X1A - X1) / 2)
	ADD	BP,AX		; ..
	ADD	BP,BX		; ..
	MOV	SI,BP		; ..
	MOV	BX,[X1A]	;Get starting column offset
	MOV	AX,BX		; ..
	SHR	BX,1		; ..
	MOV	DI,[Action]	;Add odd/even video buffer pixel index
	AND	AX,1		; ..
	SHL	AX,1		; ..
	SHL	AX,1		; ..
	ADD	DI,AX		; ..
	MOV	AX,[X1A]	;Add odd/even array pixel index
	SUB	AX,[X1]		; ..
	AND	AX,1		; ..
	SHL	AX,1		; ..
	ADD	DI,AX		; ..
	MOV	AX,PutTable[DI] ;Get address of selected routine
	MOV	[Action],AX	; ..
	XOR	AX,AX		;Get bytes per line
	MOV	BP,[X2A]	; .. (X2A - X1A + 1) / 2
	SUB	BP,[X1A]	; ..
	INC	BP		; ..
	SHR	BP,1		; ..
	JNC	CheckPut4	; ..
	MOV	AX,1		; ..
CheckPut4:			; ..
	MOV	[LastByte],AX	; ..
	MOV	CX,[Y2A]	;Get number of rows
	SUB	CX,[Y1A]	; .. Y2A - Y1A + 1
	INC	CX		; ..
	MOV	DI,[Y1A]	;Get starting scan line address
	SHL	DI,1		; ..
	ADD	DI,ScanAddr	; ..
	XOR	AX,AX		;Indicate everything is OK
	RET

;
;Turn the graphics cursor On or Off
;

SetCursor:
	OR	BX,BX		;Off?
	JNZ	SetCursor2	; ..
	TEST	[CursorFlagB],1 ;See if cursor is already off
	JZ	SetCursor1	; ..
	MOV	BX,[Column]	;Turn graphics cursor off
	MOV	CX,[Row]	; ..
	CALL	PlotCursor1	; ..
	AND	[CursorFlagB],0FEH ;Set cursor flag off
SetCursor1:
	RET
SetCursor2:
	CMP	BX,1		;On?
	JNE	SetCursor4	; ..
	TEST	[CursorFlagB],1 ;See if cursor is already on
	JNZ	SetCursor3	; ..
	OR	[CursorFlagB],1 ;Set cursor flag on
	MOV	BX,[Column]	;Turn graphics cursor on
	MOV	CX,[Row]	; ..
	CALL	PlotCursor1	; ..
SetCursor3:
	RET
SetCursor4:
	CMP	BX,2		;Half cursor off?
	JNE	SetCursor6	; ..
	TEST	[CursorFlagB],2 ;See if half cursor is already off
	JZ	SetCursor5	; ..
	MOV	BX,[Column]	;Turn half cursor off
	MOV	CX,[Row]	; ..
	CALL	PlotCursor1	; ..
	MOV	BX,[Column]	   ;Turn regular cursor back on
	MOV	CX,[Row]	   ; ..
	AND	[CursorFlagB],0FDH ; ..
	CALL	PlotCursor1	   ; ..
SetCursor5:
	RET
SetCursor6:
	CMP	BX,3		;Half cursor on?
	JNE	SetCursor7	; ..
	TEST	[CursorFlagB],2 ;See if half cursor is already On
	JNZ	SetCursor7	; ..
	MOV	BX,[Column]	;Turn regular cursor off
	MOV	CX,[Row]	; ..
	CALL	PlotCursor1	; ..
	MOV	BX,[Column]	;Turn half cursor on
	MOV	CX,[Row]	; ..
	OR	[CursorFlagB],2 ; ..
	CALL	PlotCursor1	; ..
SetCursor7:
	RET

;
;Return the current graphics cursor status Off or On, Full or Half
;

GetCursor:
	MOV	AL,[CursorFlagB];Get the current status on or off
	MOV	BX,AX		; ..
	AND	AX,1		; ..
	MOV	SS_BX,AX	;Store in BX position on stack
	AND	BX,2		;Get the current size full or half
	SHR	BX,1		; ..
	MOV	SS_CX,BX	;Store in CX position on stack
	RET

;
;Set the graphics cursor position in text row and column format
;

SetCursorPos:
	DEC	BX		;Adjust row & column values for BIOS call
	DEC	CX		; .. (Row = 0-24, Column = 0-39, or 0-79)
	MOV	AH,2		;Set cursor function
	MOV	DH,CL		;Row in DH
	MOV	DL,BL		;Column in DL
	PUSH	BX		;Save row & column
	PUSH	CX		; ..
	XOR	BX,BX		;Must be page 0 for graphics mode
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
	POP	CX		;Restore row & column
	POP	BX		; ..
	CALL	PlotCursor	;Plot the new cursor position
	RET

;
;Get the current row and column of the graphics cursor
;

GetCursorPos:
	MOV	AX,[Column]	;Get current row value
	INC	AX		;Adjust row value (1-25)
	MOV	SS_BX,AX	;Store in BX position on stack
	MOV	AX,[Row]	;Get current column
	INC	AX		;Adjust column value (1-40 or 1-80)
	MOV	SS_CX,AX	;Store in CX position on stack
	RET

;
;Print a text string on the graphics screen
;

PrintString:
	OR	CX,CX		;Check for null string
	JNZ	PrintString1	; ..
	RET
PrintString1:
	PUSH	DS		;Save DS
	PUSH	BX		;Save action indicator
	MOV	BX,[TColor]	;Text color in BX
	MOV	DS,SS_DS	;Get segment address of string
	MOV	SI,DX		;String offset address in SI
PrintString2:
	MOV	AH,14		;BIOS write TTY function
	LODSB			;Character to print in AL
	PUSHF			;Fake an INT 10H interrupt
	CALL	CS:[OldINT10]	; ..
	LOOP	PrintString2	;Print next character
PrintString3:
	POP	BX		;Restore action indicator
	CMP	BX,0		;Check to skip final CR & LF sequence
	JE	PrintString4
	MOV	AH,14		;BIOS write TTY function
	MOV	AL,13		;Print a final carriage return
	PUSHF			;Fake an INT 10H interrupt
	CALL	CS:[OldINT10]	; ..
	MOV	AH,14		;BIOS write TTY function
	MOV	AL,10		;Print a final linefeed
	PUSHF			;Fake an INT 10H interrupt
	CALL	CS:[OldINT10]	; ..
PrintString4:
	POP	DS		;Restore DS
	MOV	BX,[Row]	;Erase old cursor
	MOV	CX,[Column]	; ..
	CALL	PlotCursor1	; ..
	MOV	AH,3		;BIOS get cursor position function
	MOV	BX,0		;Page must be 0 for graphics mode
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
	XOR	BX,BX		;Clear BX & CX for call to 'PlotCursor'
	XOR	CX,CX		; ..
	MOV	BL,DL		;Column in BX
	MOV	CL,DH		;Row in CX
	CALL	PlotCursor	;Move cursor to new position
	RET

;
;Plot the graphics cursor onto the screen
;

PlotCursor:
	TEST	[CursorFlagB],1 ;See if cursor is off
	JZ	PlotCursor1	; ..
	PUSH	BX		;Save row and column
	PUSH	CX		; ..
	MOV	SI,[Column]	;Erase old cursor
	MOV	DI,[Row]	; ..
	CALL	PlotCursorX	; ..
	POP	CX		;Restore row and column
	POP	BX		; ..

;Entered here for initial plot or erase
PlotCursor1:
	MOV	[Column],BX	;Update row and column
	MOV	[Row],CX	; ..
	TEST	[CursorFlagB],1 ;See if cursor is off
	JZ	PlotCursor2	; ..
	MOV	SI,BX		;Plot new cursor
	MOV	DI,CX		; ..
	CALL	PlotCursorX	; ..
PlotCursor2:
	RET

;Plot graphics cursor with appropriate color
PlotCursorX:
	MOV	CL,3		;Form X1, Y1, X2, Y2
	SHL	SI,CL		; ..
	SHL	DI,CL		; ..
	MOV	BX,SI		; ..
	MOV	CX,DI		; ..
	ADD	SI,7		; ..
	ADD	DI,3		; ..
	TEST	[CursorFlagB],2 ; ..
	JNZ	PlotCursorX1	; ..
	ADD	DI,4		; ..
PlotCursorX1:
	PUSH	[DColor]	;Save plot color
	MOV	[DColorB],3	;Plot cursor with color #3
	CALL	XorFillBoxCX1	;Plot it
	POP	[DColor]	;Restore plot color
	RET
;
;Set current display page
;

SetDisplayPage:
	CMP	BX,[MaxPage]		;Validate display page number
	JA	SetDisplayPage1		; ..
	MOV	CX,[PageShift]		;Get page register bit shift count
	XOR	BX,[MaxPage]		;Save new display page
	MOV	[DPage],BX		; ..
	SHL	BX,CL			;Get display page register bit values
	MOV	AX,[APage]		;Get active page register bit values
	SHL	AX,CL			; ..
	MOV	CL,3			;Form new page register bit settings
	SHL	AX,CL			; ..
	OR	AX,BX			; ..
	OR	AX,[Reg3DF]		; ..
	MOV	DX,3DFH			;Set new display page
	OUT	DX,AL			; ..
SetDisplayPage1:
	RET

;
;Get current display page
;

GetDisplayPage:
	MOV	AX,[DPage]		;Return current display page in BX
	XOR	AX,[MaxPage]		; ..
	MOV	SS_BX,AX		; ..
	RET

;
;Set current active page
;

SetActivePage:
	CMP	BX,[MaxPage]		;Validate active page
	JA	SetActivePage1		; ..
	MOV	CX,[PageShift]		;Get page register bit shift count
	XOR	BX,[MaxPage]		;Save new active page
	MOV	[APage],BX		; ..
	SHL	BX,CL			;Get active page register bit values
	MOV	AX,[DPage]		;Get display page register bit values
	SHL	AX,CL			; ..
	MOV	CL,3			;Form new page register bit settings
	SHL	BX,CL			; ..
	OR	AX,BX			; ..
	OR	AX,[Reg3DF]		; ..
	MOV	DX,3DFH			;Set new active page
	OUT	DX,AL			; ..
SetActivePage1:
	RET

;
;Get current active page
;

GetActivePage:
	MOV	AX,[APage]		;Return current active page in BX
	XOR	AX,[MaxPage]		; ..
	MOV	SS_BX,AX		; ..
	RET

;
;Copy source video page to destination video page
;

PageCopy:
	CMP	SI,DI			;Make sure pages are not the same
	JE	PageCopy1		; ..
	CMP	SI,[MaxPage]		;Validate source page
	JA	PageCopy1		; ..
	CMP	DI,[MaxPage]		;Validate destination page
	JNA	PageCopy2		; ..
PageCopy1:
	RET

;Get source page register bit settings
PageCopy2:
	MOV	CX,[PageShift]		;Get page register bit shift count
	XOR	SI,[MaxPage]		;Get source page register bit values
	SHL	SI,CL			; ..
	MOV	DX,[DPage]		;Get display page register bit values
	SHL	DX,CL			; ..
	MOV	CL,3			;Form source page register bit settings
	SHL	SI,CL			; ..
	OR	DX,SI			; ..
	OR	DX,[Reg3DF]		; ..
	MOV	AH,DL			; ..

;Get destination page register bit settings
	MOV	CX,[PageShift]		;Get page register bit shift count
	XOR	DI,[MaxPage]		;Get dest page register bit values
	SHL	DI,CL			; ..
	MOV	DX,[DPage]		;Get display page register bit values
	SHL	DX,CL			; ..
	MOV	CL,3			;Form dest page register bit settings
	SHL	DI,CL			; ..
	OR	DX,DI			; ..
	OR	DX,[Reg3DF]		; ..
	MOV	AL,DL			; ..

;Setup inital values
	MOV	BP,[MaxScrnY]		;Get number of scan lines to process
	INC	BP			; ..
	MOV	BX,ScanAddr		;Get inital scan line address
	MOV	DX,3DFH			;Get page register port address

	PUSH	DS			;Save segment registers
	PUSH	ES			; ..

;Copy the source scan line to buffer
PageCopy3:
	XCHG	AH,AL			;Point to source page
	OUT	DX,AL			; ..
	MOV	CX,[ScanWords]		;Get number of words to copy
	MOV	SI,[BX]			;Point DS:SI at source scan line
	MOV	DS,[VideoSeg]		; ..
	MOV	DI,CS			;Point ES:DI at buffer
	MOV	ES,DI			; ..
	MOV	DI,OFFSET Above		; ..
	REP	MOVSW			;Copy source scan line to buffer

;Copy buffer to destination scan line
	XCHG	AH,AL			;Point to destination page
	OUT	DX,AL			; ..
	MOV	SI,CS			;Point DS:SI at buffer
	MOV	DS,SI			; ..
	MOV	SI,OFFSET Above		; ..
	MOV	ES,[VideoSeg]		;Point ES:DI at dest scan line
	MOV	DI,[BX]			; ..
	MOV	CX,[ScanWords]		;Get number of words to copy
	REP	MOVSW			;Copy buffer to dest scan line

	INC	BX			;Point to next scan line
	INC	BX			; ..
	DEC	BP			;Do next scan line
	JNZ	PageCopy3		; ..
	POP	ES			;Restore segment registers
	POP	DS			; ..
	MOV	BX,[APage]		;Reset current active page
	XOR	BX,[MaxPage]		; ..
	CALL	SetActivePage		; ..
	RET

;
;Return residency or graphics status - Set graphics and audio system
;

System:
	OR	BX,BX		;Status check?
	JNZ	System1		; ..
	MOV	SS_AX,0DEADH	;Store in AX position on stack
	RET
System1:
	CMP	BX,1		;Return graphics status?
	JNE	System2		; ..
	MOV	AX,[GraphFlag]	;Return the current graphics status
	MOV	SS_AX,AX	;Store in AX position on stack
	RET
System2:
	CMP	BX,2		;Enable graphics functions?
	JNE	System3		; ..
	CALL	Set320		;Initalize variables for 320x200x16 color mode
	MOV	AX,0009H	;Enter 320 x 200 x 16 color graphics mode
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
	RET			; ..
System3:
	CMP	BX,3		;Disable graphics functions?
	JNE	System4		; ..
	MOV	[GraphFlagB],0	   ;Disable graphics functions
	MOV	[GraphOK],GrafixNo ; ..
	MOV	AX,3		;Reset video mode to 80 x 25 color
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
	RET
System4:
	CMP	BX,4		;Turn all current sound processing off?
	JNE	System5		; ..
	CALL	SoundOff	;Reset sound system
	RET
System5:
	CMP	BX,5		;Turn sound buffering on?
	JNE	System7		; ..
	TEST	[TimerFlag],100H;See if buffering is already on
	JNZ	System6		; ..
	OR	[TimerFlag],100H;Turn all sound buffer processing on
	CALL	ResetSoundBuf	;Reset sound buffer variables
System6:
	RET
System7:
	CMP	BX,6		;Turn sound buffering off?
	JNE	System9		; ..
	AND	[TimerFlag],68FH;Turn all sound buffer processing off
	RET
System9:
	CMP	BX,7		;Turn all noise processing off?
	JNE	System10	; ..
	CALL	NoiseOff	;Reset noise system
	RET
System10:
	CMP	BX,8		;Turn noise buffering on?
	JNE	System12	; ..
	TEST	[TimerFlag],200H;See if buffering is already on
	JNZ	System11	; ..
	OR	[TimerFlag],200H;Turn all noise buffer processing on
	CALL	ResetNoiseBuf	;Reset noise buffer variables
System11:
	RET
System12:
	CMP	BX,9		;Turn noise buffering off?
	JNE	System14	; ..
	AND	[TimerFlag],57FH;Turn all noise buffer processing off
System13:
	RET
System14:
	CMP	BX,10		;Turn all sound & noise processing off?
	JNE	System15	; ..
	CALL	SoundOff	;Reset sound system
	CALL	NoiseOff	;Reset noise system
System15:
	CMP	[Tandy11],0	;See if TANDY11 driver is installed
	JE	System16	; ..
	CMP	BX,11		;Enable graphics functions?
	JNE	System16	; ..
	CALL	Set640		;Initalize variables for 640x200x16 color mode
        MOV     AX,11           ;Enter 640x200x16 color graphics mode
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
	RET
System16:
	CMP	BX,12		;Get 640x200x16 color graphics mode flag
	JNE	System17	; ..
	MOV	AX,[Tandy11]	;Get status flag indicating if 640x200x16 color
	MOV	SS_AX,AX	; .. graphics mode is supported
	RET
System17:
	CMP	BX,13		;Enable graphics functions?
	JNE	System18	; ..
	CALL	Set160		;Initalize variables for 160x200x16 color mode
	MOV	AX,8		;Enter 160x200x16 color graphics mode
	PUSHF			;Fake an INT 10H interrupt
	CALL	[OldINT10]	; ..
System18:
	RET

;
;Initialize all variables for 160x200x16 color graphics mode
;

Set160:
	CALL	InitVariables		 ;Init all common graphic variables
	MOV	[XAspect],3		 ; ..
	MOV	[YAspect],5		 ; ..
	MOV	[ScanWords],40		 ; ..
	MOV	[Reg3DF],40H		 ; ..
	MOV	AX,159			 ; ..
	MOV	[MaxX],AX		 ; ..
	MOV	[MaxScrnX],AX		 ; ..
	MOV	[PageShift],0		 ; ..
	MOV	AX,7			 ; ..
	MOV	[APage],AX		 ; ..
	MOV	[DPage],AX		 ; ..
	MOV	[MaxPage],AX		 ; ..

;Generate scanline address table
	SHR	SI,1			;Get scan line in bytes
Make160:
	MOV	AX,BX			;S = S / 2
	SHR	AX,1			; ..
	MUL	SI			;S = S / 2 * 80
	MOV	DX,BX			;S = S / 2 * 80 + ((S MOD 2) * 8192)
	AND	DX,1			; ..
	SHL	DX,CL			; ..
	ADD	AX,DX			; ..
	STOSW				;Store table entry
	INC	BX			;Point to next table entry
	DEC	BP			;Do next entry
	JNZ	Make160			; ..
	RET

;
;Initialize all variables for 320x200x16 color graphics mode
;

Set320:
	CALL	InitVariables		 ;Init all common graphic variables
	MOV	[XAspect],6		 ; ..
	MOV	[YAspect],5		 ; ..
	MOV	[ScanWords],80		 ; ..
	MOV	[Reg3DF],0C0H		 ; ..
	MOV	AX,319			 ; ..
	MOV	[MaxX],AX		 ; ..
	MOV	[MaxScrnX],AX		 ; ..
	MOV	[PageShift],1		 ; ..
	MOV	AX,3			 ; ..
	MOV	[APage],AX		 ; ..
	MOV	[DPage],AX		 ; ..
	MOV	[MaxPage],AX		 ; ..

;Generate scanline address table
Make320:
	MOV	AX,BX			;S = S / 4
	SHR	AX,1			; ..
	SHR	AX,1			; ..
	MUL	SI			;S = S / 4 * 160
	MOV	DX,BX			;S = S / 4 * 160 + ((S MOD 4) * 8192)
	AND	DX,3			; ..
	SHL	DX,CL			; ..
	ADD	AX,DX			; ..
	STOSW				;Store table entry
	INC	BX			;Point to next table entry
	DEC	BP			;Do next entry
	JNZ	Make320			; ..
	RET

;
;Initialize all variables for 640x200x16 color graphics mode
;

Set640:
	CALL	InitVariables		 ;Init all common graphic variables
	MOV	[XAspect],12		 ; ..
	MOV	[YAspect],5		 ; ..
	MOV	[VideoSeg],0A000H	 ; ..
	MOV	[ScanWords],160		 ; ..
	MOV	[Reg3DF],0		 ; ..
	MOV	AX,639			 ; ..
	MOV	[MaxX],AX		 ; ..
	MOV	[MaxScrnX],AX		 ; ..
	MOV	[PageShift],2		 ; ..
	MOV	AX,1			 ; ..
	MOV	[APage],AX		 ; ..
	MOV	[DPage],AX		 ; ..
	MOV	[MaxPage],AX		 ; ..

;Generate scanline address table
	SHL	SI,1			;Get scan line in bytes
Make640:
	MOV	AX,BX			;S = S * 320
	MUL	SI			; ..
	STOSW				;Store table entry
	INC	BX			;Point to next table entry
	DEC	BP			;Do next entry
	JNZ	Make640			; ..
	RET

;Initialize all common graphic variables
InitVariables:
	MOV	AX,1			;Enable grapics functions
	MOV	[GraphFlagB],AL		;Enable graphics functions
	MOV	[GraphOK],GrafixYes	; ..
	MOV	[DColorB],AL		;Reset graphic variables
	MOV	[TColorB],15		; ..
	MOV	[VideoSeg],0B800H	; ..
	MOV	AX,199			; ..
	MOV	[MaxScrnY],AX		; ..
	MOV	[MaxY],AX		; ..
	XOR	AX,AX			; ..
	MOV	[BColorB],AL		; ..
	MOV	[CursorFlagB],AL	; ..
	MOV	[OldX],AX		; ..
	MOV	[OldY],AX		; ..
	MOV	[Row],AX		; ..
	MOV	[Column],AX		; ..
	MOV	[MinX],AX		; ..
	MOV	[MinY],AX		; ..

;Set up common register values for scan line table generation
	PUSH	CS			;Point ES at current data segment
	POP	ES			; ..
	MOV	DI,ScanAddr		;Point to scanline address table
	MOV	SI,160			;Get number of bytes per scanline
	MOV	BP,200			;Get number tables entries
	XOR	BX,BX			;Initialize scan line counter
	MOV	CL,13			;Get shift count for MOD operation
	RET

;
;Turns all current sound processing off
;

SoundOff:
	AND	[TimerFlag],688H;Turn all sound buffer processing off
	CALL	Sound0Off	;Turn off all sound channels
	CALL	Sound1Off	; ..
	CALL	Sound2Off	; ..
	CALL	ResetSoundBuf	;Reset sound buffers
	RET

;
;Turn sound channel 0 off
;

Sound0Off:
	PUSH	AX		;Save AX
	MOV	AX,0083H	;Turn off sound channel 0
	OUT	0C0H,AX		; ..
	POP	AX		;Restore AX
	RET

;
;Turn sound channel 1 off
;

Sound1Off:
	PUSH	AX		;Save AX
	MOV	AX,00A3H	;Turn off sound channel 1
	OUT	0C0H,AX		; ..
	POP	AX		;Restore AX
	RET

;
;Turn sound channel 2 off
;

Sound2Off:
	PUSH	AX		;Save AX
	MOV	AX,00C3H	;Turn off sound channel 2
	OUT	0C0H,AX		; ..
	POP	AX		;Restore AX
	RET

;
;Turns all current noise processing off
;

NoiseOff:
	AND	[TimerFlag],577H;Turn all noise buffer processing off
	CALL	NoiseOffX	;Turn noise channel off
	CALL	ResetNoiseBuf	;Reset noise buffer
	RET

;
;Turn sound channel 2 off
;

NoiseOffX:
	PUSH	AX		;Save AX
	MOV	AL,0FFH		;Turn noise channel off
	OUT	0C0H,AL		; ..
	POP	AX		;Restore AX
	RET

;
;Reset all sound buffer variables
;

ResetSoundBuf:
	MOV	[BufCnt1],0    ;Reset all counters
	MOV	[BufCnt2],0    ; ..
	MOV	[BufCnt3],0    ; ..
	MOV	[GBufPtr1],OFFSET SoundBuf1 ;Reset all pointers
	MOV	[PBufPtr1],OFFSET SoundBuf1 ; ..
	MOV	[GBufPtr2],OFFSET SoundBuf2 ; ..
	MOV	[PBufPtr2],OFFSET SoundBuf2 ; ..
	MOV	[GBufPtr3],OFFSET SoundBuf3 ; ..
	MOV	[PBufPtr3],OFFSET SoundBuf3 ; ..
	RET

;
;Reset all noise buffer variables
;

ResetNoiseBuf:
	MOV	[BufCnt4],0    ;Reset counter
	MOV	[GBufPtr4],OFFSET NoiseBuf ;Reset all pointers
	MOV	[PBufPtr4],OFFSET NoiseBuf ; ..
	RET

;
;Produce a sound with the specified frequency, duration, volume, sound channel
;

Sound:
	OR	DI,DI		;Check for zero length sound
	JNZ	SoundA		; ..
	RET			; ..
SoundA:
	AND	BX,15		;Make sure volume is 0-15
	AND	CX,3		;Make sure sound channel is 0-2
	CMP	SI,110		;Make sure frequency is at least 110Hz
	JAE	SoundB		; ..
	MOV	SI,110		; ..
SoundB:
	MOV	BP,CX		;Jump to selected sound channel routine
	SHL	BP,1		; ..
	JMP	CS:SoundTab[BP] ; ..

;Sound channel 0
Sound0:
	TEST	[TimerFlag],1	;Check if current sound still active
	JZ	Sound0B		; ..
	OR	[TimerFlag],10H ;Turn on busy flag bit
	TEST	[TimerFlag],100H;See if sound buffer is active
	JZ	Sound0A		; ..
	JMP	PutSound1	; ..
Sound0A:
	CMP	[SoundCnt0],0	;Keep looping until time has expired before
	JA	Sound0A		; .. making next sound
Sound0B:
	MOV	[SoundCnt0],DI	;Set number of ticks for channel 0
	OR	[TimerFlag],1	;Turn channel 0 flag bit on
	JMP	MakeSound	;Play the sound

;Sound channel 1
Sound1:
	TEST	[TimerFlag],2	;Check if current sound still active
	JZ	Sound1B		; ..
	OR	[TimerFlag],20H ;Turn on busy flag bit
	TEST	[TimerFlag],100H;See if sound buffer is active
	JZ	Sound1A		; ..
	JMP	PutSound2	; ..
Sound1A:
	CMP	[SoundCnt1],0	;Keep looping until time has expired before
	JA	Sound1A		; .. making next sound
Sound1B:
	MOV	[SoundCnt1],DI	;Set number of ticks for channel 0
	OR	[TimerFlag],2	;Turn channel 1 flag bit on
	JMP	MakeSound	;Play the sound

;Sound channel 2
Sound2:
	TEST	[TimerFlag],4	;Check if current sound still active
	JZ	Sound2B		; ..
	OR	[TimerFlag],40H ;Turn on busy flag bit
	TEST	[TimerFlag],100H;See if sound buffering is active
	JZ	Sound2A		; ..
	JMP	PutSound3	; ..
Sound2A:
	CMP	[SoundCnt2],0	;Keep looping until time has expired before
	JA	Sound2A		; .. making next sound
Sound2B:
	MOV	[SoundCnt2],DI	;Set number of ticks for channel 0
	OR	[TimerFlag],4	;Turn channel 2 flag bit on

;Get the current sound channel volume
MakeSound:
	MOV	BH,CL		;Sound volume formula:
	MOV	CL,5		; .. 90H OR (Channel * 32) OR (Volume XOR 15)
	SHL	BH,CL		; ..
	MOV	CH,BL		; ..
	XOR	CH,15		; ..
	OR	CH,BH		; ..
	OR	CH,90H		; ..

;Get the current sound channel tone (2 bytes)
	MOV	DX,1		;Calculate the tone (111860 / Frequency)
	MOV	AX,0B4F4H	; ..
	DIV	SI		; ..
	MOV	DX,AX		; ..
	AND	AL,15		;Byte 1 formula:
	OR	AL,BH		; .. 80H OR (Channel * 32) OR (Tone AND 15)
	OR	AL,80H		; ..
	AND	DX,3F0H		;Byte 2 formula:
	MOV	CL,4		; .. (Tone AND 3F0H) / 16
	SHR	DX,CL		; ..
	MOV	AH,DL		; ..

;Play the sound
	OUT	0C0H,AX		;Set the tone
	MOV	AL,CH		;Set the volume
	OUT	0C0H,AL		; ..
	RET

;
;Generate a periodic or white noise with the specified volume and duration
;

Noise:
	OR	DX,DX		;Check for zero length noise
	JNZ	Noise1		; ..
	RET
Noise1:
	TEST	[TimerFlag],8	;See if current noise still active
	JZ	Noise3		; ..
	OR	[TimerFlag],80H ;Turn on busy flag
	TEST	[TimerFlag],200H;See if buffering active
	JZ	Noise2		; ..
	JMP	PutNoise	;Put noise into sound buffer
Noise2:
	CMP	[NoiseCnt],0	;Keep looping until time has expired
	JA	Noise2		; ..
Noise3:
	MOV	[NoiseCnt],DX	;Set duration
	OR	[TimerFlag],8	;Turn noise channel flag bit on

;Get noise volume
	MOV	AH,CL		;Noise volume formula:
	AND	AH,15		; .. 0F0H OR ((Volume AND 15) XOR 15)
	XOR	AH,15		; ..
	OR	AH,0F0H		; ..

;Get noise type
	MOV	AL,BL		;Noise type formula:
	MOV	CL,2		; .. 0E0H OR ((Type / 4) * 4) OR (Type AND 3)
	AND	AL,3		; ..
	SHR	BL,CL		; ..
	SHL	BL,CL		; ..
	OR	AL,BL		; ..
	OR	AL,0E0H		; ..

;Make the noise
	OUT	0C0H,AX		;Set the type and volume
	RET

;
;Put the current sound into the sound buffer
;

;Sound buffer number 1
PutSound1:
	PUSH	BP		;Save BP
PutSound1A:
	CMP	[BufCnt1],BufSize ;Keep looping until there is an opening in
	JE	PutSound1A	  ; .. the buffer
	MOV	BP,[PBufPtr1]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd1   ; ..
	JNE	PutSound1B	    ; ..
	MOV	BP,OFFSET SoundBuf1 ;Point to beginning of buffer
PutSound1B:
	MOV	CS:[BP],BX	;Store the volume
	MOV	CS:[BP+2],SI	;Store the frequency
	MOV	CS:[BP+4],DI	;Store the duration
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[PBufPtr1],BP	; ..
	INC	[BufCnt1]	;Increment current sound total
	POP	BP		;Restore BP
	RET

;Sound buffer number 2
PutSound2:
	PUSH	BP		;Save BP
PutSound2A:
	CMP	[BufCnt2],BufSize ;Keep looping until there is an opening in
	JE	PutSound2A	  ; .. the buffer
	MOV	BP,[PBufPtr2]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd2   ; ..
	JNE	PutSound2B	    ; ..
	MOV	BP,OFFSET SoundBuf2 ;Point to beginning of buffer
PutSound2B:
	MOV	CS:[BP],BX	;Store the volume
	MOV	CS:[BP+2],SI	;Store the frequency
	MOV	CS:[BP+4],DI	;Store the duration
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[PBufPtr2],BP	; ..
	INC	[BufCnt2]	;Increment current sound total
	POP	BP		;Restore BP
	RET

;Sound buffer number 3
PutSound3:
	PUSH	BP		;Save BP
PutSound3A:
	CMP	[BufCnt3],BufSize ;Keep looping until there is an opening in
	JE	PutSound3A	  ; .. the buffer
	MOV	BP,[PBufPtr3]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd3   ; ..
	JNE	PutSound3B	    ; ..
	MOV	BP,OFFSET SoundBuf3 ;Point to beginning of buffer
PutSound3B:
	MOV	CS:[BP],BX	;Store the volume
	MOV	CS:[BP+2],SI	;Store the frequency
	MOV	CS:[BP+4],DI	;Store the duration
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[PBufPtr3],BP	; ..
	INC	[BufCnt3]	;Increment current sound total
	POP	BP		;Restore BP
	RET

;
;Put the current noise into the noise buffer
;

PutNoise:
	PUSH	BP		;Save BP
PutNoise1:
	CMP	[BufCnt4],BufSize ;Keep looping until there is an opening in
	JE	PutNoise1	  ; .. the buffer
	MOV	BP,[PBufPtr4]	   ;See if at end of buffer
	CMP	BP,OFFSET BufEnd4  ; ..
	JNE	PutNoise2	   ; ..
	MOV	BP,OFFSET NoiseBuf ;Point to beginning of buffer
PutNoise2:
	MOV	CS:[BP],BX	;Store the type
	MOV	CS:[BP+2],CX	;Store the volume
	MOV	CS:[BP+4],DX	;Store the duration
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[PBufPtr4],BP	; ..
	INC	[BufCnt4]	;Increment current sound total
	POP	BP		;Restore BP
	RET

;
;Get the current sound from the sound buffer and generate it
;

;Sound buffer number 1
GetSound1:
	CMP	[BufCnt1],0	;See if buffer is empty
	JE	GetSound1B	; ..
	PUSHR			;Save registers
	MOV	BP,[GBufPtr1]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd1   ; ..
	JNE	GetSound1A	    ; ..
	MOV	BP,OFFSET SoundBuf1 ;Point to beginning of buffer
GetSound1A:
	MOV	BX,CS:[BP]	;Get the volume
	MOV	SI,CS:[BP+2]	;Get the frequency
	MOV	DI,CS:[BP+4]	;Get the duration
	MOV	CL,0		;Get the voice
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[GBufPtr1],BP	; ..
	DEC	[BufCnt1]	;Decrement current sound total
	CALL	Sound		;Play the sound
	POPR			;Restore registers
GetSound1B:
	RET

;Sound buffer number 2
GetSound2:
	CMP	[BufCnt2],0	;See if buffer is empty
	JE	GetSound2B	; ..
	PUSHR			;Save registers
	MOV	BP,[GBufPtr2]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd2   ; ..
	JNE	GetSound2A	    ; ..
	MOV	BP,OFFSET SoundBuf2 ;Point to beginning of buffer
GetSound2A:
	MOV	BX,CS:[BP]	;Get the volume
	MOV	SI,CS:[BP+2]	;Get the frequency
	MOV	DI,CS:[BP+4]	;Get the duration
	MOV	CL,1		;Get the voice
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[GBufPtr2],BP	; ..
	DEC	[BufCnt2]	;Decrement current sound total
	CALL	Sound		;Play the sound
	POPR			;Restore registers
GetSound2B:
	RET

;Sound buffer number 3
GetSound3:
	CMP	[BufCnt3],0	;See if buffer is empty
	JE	GetSound3B	; ..
	PUSHR			;Save registers
	MOV	BP,[GBufPtr3]	    ;See if at end of buffer
	CMP	BP,OFFSET BufEnd3   ; ..
	JNE	GetSound3A	    ; ..
	MOV	BP,OFFSET SoundBuf3 ;Point to beginning of buffer
GetSound3A:
	MOV	BX,CS:[BP]	;Get the volume
	MOV	SI,CS:[BP+2]	;Get the frequency
	MOV	DI,CS:[BP+4]	;Get the duration
	MOV	CL,2		;Get the voice
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[GBufPtr3],BP	; ..
	DEC	[BufCnt3]	;Decrement current sound total
	CALL	Sound		;Play the sound
	POPR			;Restore registers
GetSound3B:
	RET

;
;Get the current noise from the noise buffer and generate it
;

GetNoise:
	CMP	[BufCnt4],0	;See if buffer is empty
	JE	GetNoise2	; ..
	PUSHR			;Save registers
	MOV	BP,[GBufPtr4]	   ;See if at end of buffer
	CMP	BP,OFFSET BufEnd4  ; ..
	JNE	GetNoise1	   ; ..
	MOV	BP,OFFSET NoiseBuf ;Point to beginning of buffer
GetNoise1:
	MOV	BX,CS:[BP]	;Get the type
	MOV	CX,CS:[BP+2]	;Get the volume
	MOV	DX,CS:[BP+4]	;Get the duration
	ADD	BP,BufEntry	;Increment buffer pointer
	MOV	[GBufPtr4],BP	; ..
	DEC	[BufCnt4]	;Decrement current sound total
	CALL	Noise		;Make the noise
	POPR			;Restore registers
GetNoise2:
	RET

;
;Delay for the specified number of clock ticks
;

Delay:
	OR	BX,BX		;Make sure delay is greater than zero
	JZ	Delay2		; ..
	OR	[TimerFlag],400H;Turn delay flag bit on
	MOV	[DelayCnt],BX	;Set number of ticks for delay
Delay1:
	CMP	[DelayCnt],0	;Keep looping until time has expired
	JA	Delay1		; ..
	AND	[TimerFlag],NOT 400H ;Set delay flag bit off
Delay2:
	RET

;
;Set the 8253 timer chip for 2 - 256 times it's normal speed
;

FastTimer:
	CMP	BX,2		;Validate speed
	JB	FastTimer1	; ..
	CMP	BX,256		; ..
	JA	FastTimer1	; ..
	CALL	ResetTimer	;Make sure timer is reset to restore INT vector
	MOV	DX,1		;Get the timer chip speed value
	XOR	AX,AX		; .. (65536 / Speed)
	DIV	BX		; ..
	MOV	[TimerSpeed],BX ;Set the 8253 timer variable values
	MOV	[TimerCount],BX ; ..
	MOV	[TimerValue],AX ; ..
	CLI			;Disable interrupts
	XOR	AX,AX		;Set new INT 08H vector address
	MOV	ES,AX		; ..
	MOV	BX,08H * 4	; ..
	MOV	AX,ES:[BX]	; ..
	MOV	[INT08X],AX	; ..
	MOV	AX,ES:[BX+2]	; ..
	MOV	[INT08X+2],AX	; ..
	MOV	AX,OFFSET Timer ; ..
	MOV	ES:[BX],AX	; ..
	MOV	AX,CS		; ..
	MOV	ES:[BX+2],AX	; ..
	CALL	SetTimer	;The the 8253 timer chip speed
	STI			;Re-enable interrupts
FastTimer1:
	RET

;
;Reset the 8253 timer chip to normal speed
;

ResetTimer:
	MOV	[TimerValue],0	;Set the 8253 timer chip to normal speed
ResetTimer1:
	CMP	[TimerSpeed],0	;Keep looping until speed is set to normal
	JNE	ResetTimer1	; .. by interrupt handler
	RET

;
;Return the 8253 timer chip speed
;

GetTimer:
	MOV	AX,[TimerSpeed] ;Return timer chip speed in BX
	OR	AX,AX		;See if it's 0, if so return 1
	JNZ	GetTimer1	; ..
	INC	AX		; ..
GetTimer1:
	MOV	SS_BX,AX	; ..
	RET

;
;This internal routine takes over the BIOS timer interrupt and updates the
;number of clock ticks that have elapsed since the start of the last sound,
;noise, or delay function. When the specified number of ticks has passed the
;sound or noise is turned off and the sound buffer is checked to see if if
;another sound is waiting to be played. In the case of the delay function,
;control is returned to the interrupted program.
;

Timer:
	PUSH	AX		;Save registers
	PUSH	DS		; ..
	MOV	AX,CS		;Set up local data segment
	MOV	DS,AX		; ..
	TEST	[TimerFlag],800H ;See if we should skip interrupt
	JZ	TimerB		 ; ..
	AND	[TimerFlag],NOT 800H ;Reset skip flag
	MOV	AX,[TimerSpeed] ;Reset timer counter
	MOV	[TimerCount],AX ; ..
	CMP	[TimerValue],0	;See if timer speed should be set to normal
	JNE	TimerA		; ..
	CLI			;Disable interrupts
	PUSH	BX		;Restore old INT 08H vector address
	PUSH	ES		; ..
	XOR	AX,AX		; ..
	MOV	ES,AX		; ..
	MOV	BX,08H * 4	; ..
	MOV	AX,[INT08X]	; ..
	MOV	ES:[BX],AX	; ..
	MOV	AX,[INT08X+2]	; ..
	MOV	ES:[BX+2],AX	; ..
	POP	ES		; ..
	POP	BX		; ..
	MOV	[TimerSpeed],0	;Reset timer speed to normal
	CALL	SetTimer	; ..
	STI			;Re-enable interrupts
TimerA:
	JMP	Timer7		;Execute normal BIOS timer interrupt
TimerB:
	MOV	AX,[TimerFlag]	;Store timer flag for testing
	TEST	AX,40FH		;See if there is processing to do
	JNZ	Timer1		; ..
	JMP	Timer6		; ..
Timer1:
	TEST	AL,1		;Check for sound channel 0
	JZ	Timer2		; ..
	DEC	[SoundCnt0]	;See if time has expired
	JNZ	Timer2		; ..
	AND	[TimerFlag],NOT 1 ;Turn channel 0 flag bit off
	TEST	AL,10H		;See if another sound is waiting to play
	JNZ	Timer1A		; ..
	CALL	Sound0Off	;Turn sound channel 0 off
Timer1A:
	TEST	AX,100H		;See if sound buffer is active
	JZ	Timer1B		; ..
	CALL	GetSound1	;Get next sound to play from the buffer
	CMP	[BufCnt1],0	;See if busy flag should be reset
	JNE	Timer2		; ..
Timer1B:
	AND	[TimerFlag],NOT 10H ;Reset sound channel 0 busy flag
Timer2:
	TEST	AL,2		;Check for sound channel 1
	JZ	Timer3		; ..
	DEC	[SoundCnt1]	;See if time has expired
	JNZ	Timer3		; ..
	AND	[TimerFlag],NOT 2 ;Turn channel 1 flag bit off
	TEST	AL,20H		;See if another sound is waiting to play
	JNZ	Timer2A		; ..
	CALL	Sound1Off	;Turn sound channel 1 off
Timer2A:
	TEST	AX,100H		;See if sound buffer is active
	JZ	Timer2B		; ..
	CALL	GetSound2	;Get next sound to play from the buffer
	CMP	[BufCnt2],0	;See if busy flag should be reset
	JNE	Timer3		; ..
Timer2B:
	AND	[TimerFlag],NOT 20H ;Reset sound channel 1 busy flag
Timer3:
	TEST	AL,4		;Check for sound channel 2
	JZ	Timer4		; ..
	DEC	[SoundCnt2]	;See if time has expired
	JNZ	Timer4		; ..
	AND	[TimerFlag],NOT 4 ;Turn channel 2 flag bit off
	TEST	AL,40H		;See if another sound is waiting to play
	JNZ	Timer3A		; ..
	CALL	Sound2Off	;Turn sound channel 2 off
Timer3A:
	TEST	AX,100H		;See if sound buffer is active
	JZ	Timer3B		; ..
	CALL	GetSound3	;Get next sound to play from the buffer
	CMP	[BufCnt3],0	;See if busy flag should be reset
	JNE	Timer4		; ..
Timer3B:
	AND	[TimerFlag],NOT 40H ;Reset sound channel 2 busy flag
Timer4:
	TEST	AL,8		;Check for noise channel
	JZ	Timer5		; ..
	DEC	[NoiseCnt]	;See if time has expired
	JNZ	Timer5		; ..
	AND	[TimerFlag],NOT 8 ;Turn noise flag bit off
	TEST	AL,80H		;See if another noise is waiting
	JNZ	Timer4A		; ..
	CALL	NoiseOffX	;Turn noise off
Timer4A:
	TEST	AX,200H		;See if noise buffer is active
	JZ	Timer4B		; ..
	CALL	GetNoise	;Get next noise to make from the buffer
	CMP	[BufCnt4],0	;See if busy flag should be reset
	JNE	Timer5		; ..
Timer4B:
	AND	[TimerFlag],NOT 80H ;Reset noise channel busy flag
Timer5:
	TEST	AX,400H		;Check for delay
	JZ	Timer6		; ..
	DEC	[DelayCnt]	;Decrement delay counter
Timer6:
	CMP	[TimerSpeed],0	;See if timer speed is normal
	JE	Timer7		; ..
	DEC	[TimerCount]	;See if it's time to execute INT 08H
	JNZ	Timer8		; ..
	OR	[TimerFlag],800H;Skip this routine next time around
	POP	DS		;Restore registers
	POP	AX		; ..
	JMP	CS:[OldINT08X]	;Execute saved BIOS timer interrupt
Timer7:
	POP	DS		;Restore registers
	POP	AX		; ..
	JMP	CS:[OldINT08]	;Execute normal BIOS timer interrupt
Timer8:
	MOV	AL,20H		;Tell interrupt controller we're done here
	OUT	20H,AL		; ..
	POP	DS		;Restore registers
	POP	AX		; ..
	IRET			;Return from interrupt

;
;Set the speed of the 8253 timer chip
;

SetTimer:
	MOV	AL,36H		;Program 8253 command register
	OUT	43H,AL		; ..
	MOV	AX,[TimerValue] ;Set 8253 timer speed (Channel 0)
	OUT	40H,AL		; ..
	MOV	AL,AH		; ..
	OUT	40H,AL		; ..
	RET

;------------------------------------------------------------------------------;
;									       ;
;   The install part of the program first checks if the computer is a Tandy    ;
;   1000 series. If that test passes it checks to see if GRAFIX is already     ;
;   installed. If not installed, the standard INT 10H vector is saved and      ;
;   the new extension code above is linked into the BIOS vector.	       ;
;									       ;
;   The installation code adjusts the Tandy 1000's memory size downward the    ;
;   necessary amount to allow the use of full graphics memory. This is	       ;
;   performed by adjusting the actual low memory word specifying the number    ;
;   of kilobytes and by adjusting the number of paragraphs remaining in this   ;
;   executing task's memory allocation block header. The protection of the     ;
;   of video memory is skipped if '/N' is present on the command line.	       ;
;									       ;
;------------------------------------------------------------------------------;

;Verify computer is a Tandy 1000 series
Setup:
	MOV	AX,0FFFFH		;Check byte at FFFF:000E for 0FFH
	MOV	ES,AX			; .. (IBM PC compatible)
	CMP	BYTE PTR ES:[0EH],0FFH	; ..
	JE	Setup1			; ..
	MOV	DX,OFFSET NoTandy	;Computer not an IBM PC compatible
	JMP	NoInstall		; ..
Setup1:
	MOV	AX,0FC00H		;Check byte at FC00:0000 for 21H
	MOV	ES,AX			; .. (Tandy 1000 unique)
	CMP	BYTE PTR ES:[0],21H	; ..
	JE	Setup2			; ..
	MOV	DX,OFFSET NoTandy	;Computer is not a Tandy 1000 series
	JMP	NoInstall		; ..

;See if computer is a Tandy 1000 SL/TL
Setup2:
	MOV	AH,0C0H			;Use machine indentification service on
	INT	15H			; .. Tandy 1000 SL/TL
	JC	Setup3			;Computer is not a Tandy 1000 SL/TL
	CMP	BYTE PTR ES:[BX+2],0FFH ;Check model ID byte for 0FFH
	JNE	Setup3			;Computer is not a Tandy 1000 SL/TL
	SHL	[Memory],1		;It is, double normal protected memory

;See if GRAFIX is already installed
Setup3:
	MOV	AH,0EEH		;See if this program is already resident
	MOV	AL,80H		; ..
	MOV	BX,0		; ..
	INT	10H		; ..
	CMP	AX,0DEADH	;Test for return value
	JNE	SetUp4
	MOV	DX,OFFSET InstallError ;Print error message and exit
	JMP	NoInstall	       ; ..

;See if TANDY11 driver is installed
Setup4:
	MOV	AX,0FF00H	;Get residency status of TANDY11 driver
	MOV	BX,0		; ..
	INT	10H		; ..
	CMP	AX,0DEADH	;Is it installed?
	JNE	Setup5		;No
	MOV	[Tandy11],1	;Yes, indicate TANDY11 driver is present

;Check if we should skip memory protect option (/N on command line)
Setup5:
	MOV	DI,80H		;Get command line length
	XOR	CH,CH		; ..
	MOV	CL,[DI]		; ..
	OR	CL,CL		;Is it there anything there to check?
	JZ	Setup7		;No
	CLD			;Make sure string op's go forward
	MOV	AX,CS		;Point ES at PSP
	MOV	ES,AX		; ..
	INC	DI		;Point to start of command line
	MOV	AL,'/'		;Check for '/'
	REPNE	SCASB		; ..
	JNE	Setup7		;Not there
	JCXZ	Setup7		; ..
	MOV	AL,[DI]		;Get the parameter
	CMP	AL,'a'		;Convert to upper case
	JL	Setup6		; ..
	SUB	AL,20H		; ..
Setup6:
	CMP	AL,'N'		;Skip memory protect option?
	JE	Setup8		;Yes
	CMP	AL,'M'		;See if amount of memory protection was
	JNE	Setup7		; .. specified
	CALL	GetK		; ..

;See how much memory should be protected
Setup7:
	PUSH	DS		;Save DS
	MOV	AX,40H		;Point DS at BIOS data area
	MOV	DS,AX		; ..
	MOV	AX,DS:[15H]	;Get total installed memory
	MOV	BX,DS:[13H]	;Get current available memory
	POP	DS		;Restore DS
	CMP	AX,BX		;See if 128K expansion option is installed
	JE	Setup8		; ..
	SUB	AX,BX		;Get current protected memory
	SUB	AX,[Memory]	;See if current protected memory is greater than
	JNS	Setup8		; .. required protected memory

;Protect system memory
	NEG	AX		;Absolute value of required protected memory
	MOV	BX,AX		;Save required protected memory
	MOV	CL,6		;Convert to number of paragraphs
	SHL	AX,CL		; ..
	PUSH	DS		;Save DS
	MOV	DX,DS		;Get current PSP segment address
	DEC	DX		;PSP segment address - 1 = Memory Block Header
	MOV	DS,DX		; ..
	SUB	DS:[3],AX	;Decrease paragraph count
	MOV	DX,40H		;Decrease memory size
	MOV	DS,DX		; ..
	SUB	DS:[13H],BX	; ..
	POP	DS		;Restore DS
	MOV	AH,49H		;Deallocate Environment Block
	MOV	DX,002CH	; ..
	MOV	ES,DX		; ..
	INT	21H		; ..

;Print openning messages
Setup8:
	MOV	AH,9			;Print GRAFIX installed message
	MOV	DX,OFFSET InstallMsg	; ..
	INT	21H			; ..
	MOV	AH,9			;Print TANDY11 status message
	MOV	DX,OFFSET Tandy11OK	; ..
	CMP	[Tandy11],1		; ..
	JE	Setup9			; ..
	MOV	DX,OFFSET NoTandy11	; ..
Setup9:					; ..
	INT	21H			; ..
	CALL	PrintMem	;Print current memory status

;Install new interrupt vectors and remain resident
Setup10:
	CLI			;Set the 8253 timer chip to normal speed
	CALL	SetTimer	; ..
	STI			; ..
	MOV	AX,3510H	;Get vector address for INT 10H
	INT	21H		; ..
	MOV	[INT10+2],ES	;Save vector address
	MOV	[INT10],BX	; ..
	MOV	AX,3508H	;Get vector address for INT 08
	INT	21H		; ..
	MOV	[INT08+2],ES	;Save vector address
	MOV	[INT08],BX	; ..
	MOV	AX,2510H	   ;Change video BIOS vector to new address
	MOV	DX,OFFSET NewINT10 ; ..
	INT	21H		   ; ..
	MOV	AX,2508H	;Change BIOS timer vector to new address
	MOV	DX,OFFSET Timer ; ..
	INT	21H		; ..
	MOV	ES,CS:[2CH]	;Get environment segment
	MOV	AH,49H		;Free memory function
	INT	21H		; ..
	MOV	DX,OFFSET Setup ;Setup paragraph count for terminate
	MOV	CL,4		; ..
	SHR	DX,CL		; ..
	INC	DX		; ..
	MOV	AX,3100H	;Terminate and Stay Resident
	INT	21H		; ..

;Print installed and protected memory values
PrintMem:
	PUSH	ES			;Save ES
	MOV	AX,40H			;Point to BIOS data area
	MOV	ES,AX			; ..
	MOV	AX,ES:[13H]		;Save total available memory
	MOV	[Memory],AX		; ..
	MOV	AX,ES:[15H]		;Save total installed memory
	MOV	[SystemMem],AX		; ..
	MOV	AH,9			;Print total installed memory
	MOV	DX,OFFSET TotalMem	; ..
	INT	21H			; ..
	MOV	AX,ES:[15H]		; ..
	CALL	PrintNum		; ..
	MOV	AH,2			;Print a 'K'
	MOV	DL,'K'			; ..
	INT	21H			; ..
	MOV	AH,9			;Print a final carriage return
	MOV	DX,OFFSET CrLf		; .. linefeed
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
	MOV	DX,OFFSET CrLf		; .. linefeed
	INT	21H			; ..
	POP	ES			;Restore ES
	RET

;
;Get the number of K bytes to adjust memory
;

GetK:
	XOR	DX,DX		;Initialize DX to 0
	MOV	BX,10		;Initial mutliplier
GetK1:
	INC	DI		;Point to next digit
	MOV	AL,[DI]		;Get 1st digit
	SUB	AL,30H		;Check if too low
	JL	GetK2		; ..
	CMP	AL,9		;Check if too high
	JG	GetK2		; ..
	CBW			;Convert to word value
	PUSH	AX		;Save digit
	MOV	AX,DX		;Previous accumulated value in AX
	MUL	BX		;Multiply
	MOV	DX,AX		;Result in DX
	POP	AX		;Restore digit
	ADD	DX,AX		;ADD in digit
	JMP	GetK1		;Do next digit
GetK2:
	CMP	DX,16		;Check if protected memory less than 16K
	JAE	GetK3		; ..
	MOV	DX,16		; ..
GetK3:
	CMP	DX,128		;Check if protected memory greater than 128K
	JBE	GetK4		; ..
	MOV	DX,128		; ..
GetK4:
	MOV	[Memory],DX	;Store amount of memory to protect
	RET

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

;Print error message and exit
NoInstall:
	MOV	AH,9		;Print error message and exit
	INT	21H		; ..
	MOV	AX,4CFFH	; ..
	INT	21H		; ..

InstallMsg:
	DB	13,10
	DB	13,10,'GRAFIX 2.60 Copyright (C) 1988-2005 by Joseph A. Albrecht'
	DB	13,10
	DB	13,10,'       Tandy 1000 Graphics And Sound Extensions'
	DB	13,10,'            160x200x16 Color Graphics Mode'
	DB	13,10,'            320x200x16 Color Graphics Mode'
	DB	'$'
Tandy11OK:
	DB	13,10,'            640x200x16 Color Graphics Mode'
NoTandy11:
	DB	13,10,'         Texas Instruments SN76496 Sound Chip'
	DB	13,10
CrLf	DB	13,10
	DB	'$'

TotalMem	DB	'Installed Memory: $'
AvailMem	DB	'Available Memory: $'
ProtectMem	DB	'Protected Memory: $'
		DB	'      '
AString		DB	'$'

InstallError:
	DB	7
	DB	13,10
	DB	'GRAFIX is already installed!'
	DB	13,10
	DB	'$'

NoTandy:
	DB	7
	DB	13,10
	DB	'GRAFIX only runs on a Tandy 1000!'
	DB	13,10
	DB	'$'

Code	ENDS

	END	Start
