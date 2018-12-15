;
;Assembly language interface file for QuickBASIC
;

	DOSSEG

	.MODEL	MEDIUM,BASIC

	.DATA

	.CODE

	PUBLIC	ClearScreen

ClearScreen	PROC

	MOV	AX,0EE00H
	INT	10H
	RET

ClearScreen	ENDP


	PUBLIC	ColorEnable

ColorEnable	PROC	Action: WORD

	MOV	AX,0EE01H
	MOV	BX,Action
	INT	10H
	RET

ColorEnable	ENDP


	PUBLIC	SetColor

SetColor	PROC	ColorType: WORD, Color: WORD

	MOV	AX,0EE02H
	MOV	BX,ColorType
	MOV	CX,Color
	INT	10H
	RET

SetColor	ENDP


	PUBLIC	GetColor

GetColor	PROC	ColorType: WORD

	MOV	AX,0EE03H
	MOV	BX,ColorType
	INT	10H
	MOV	AX,CX
	RET

GetColor	ENDP


	PUBLIC	SetAspect

SetAspect	PROC	XAspect: WORD, YAspect: WORD

	MOV	AX,0EE04H
	MOV	BX,XAspect
	MOV	CX,YAspect
	INT	10H
	RET

SetAspect	ENDP


	PUBLIC	GetAspect

GetAspect	PROC	XAspect: DWORD, YAspect: DWORD

	MOV	AX,0EE05H
	INT	10H
	LES	DI,XAspect
	MOV	ES:[DI],BX
	LES	DI,YAspect
	MOV	ES:[DI],CX
	RET

GetAspect	ENDP


	PUBLIC	PlotPoint

PlotPoint	PROC	X: WORD, Y: WORD

	MOV	AX,0EE06H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

PlotPoint	ENDP


	PUBLIC	PointColor

PointColor	PROC	X: WORD, Y: WORD, Color: DWORD

	MOV	AX,0EE07H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	LES	DI,Color
	MOV	ES:[DI],AX
	RET

PointColor	ENDP


	PUBLIC	MoveTo

MoveTo		PROC	X: WORD, Y: WORD

	MOV	AX,0EE08H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

MoveTo		ENDP


	PUBLIC	MoveRel

MoveRel		PROC	X: WORD, Y: WORD

	MOV	AX,0EE09H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

MoveRel		ENDP


	PUBLIC	CurrentPoint

CurrentPoint	PROC	X: DWORD, Y: DWORD

	MOV	AX,0EE0AH
	INT	10H
	LES	DI,X
	MOV	ES:[DI],BX
	LES	DI,Y
	MOV	ES:[DI],CX
	RET

CurrentPoint	ENDP


	PUBLIC	ExtLine

ExtLine		PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE0BH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

ExtLine		ENDP


	PUBLIC	LineTo

LineTo		PROC	X: WORD, Y: WORD

	MOV	AX,0EE0CH
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

LineTo		ENDP


	PUBLIC	LineRel

LineRel		PROC	X: WORD, Y: WORD

	MOV	AX,0EE0DH
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

LineRel		ENDP


	PUBLIC	DrawBox

DrawBox		PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE0EH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

DrawBox		ENDP


	PUBLIC	ExtCircle

ExtCircle	PROC	X: WORD, Y: WORD, Radius: WORD

	MOV	AX,0EE0FH
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Radius
	INT	10H
	RET

ExtCircle	ENDP


	PUBLIC	ExtPaint

ExtPaint	PROC	X: WORD, Y: WORD, Fill: WORD, Boundry: WORD

	MOV	AX,0EE10H
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Fill
	MOV	CX,Boundry
	INT	10H
	RET

ExtPaint	ENDP


	PUBLIC	FillBox

FillBox		PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE11H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

FillBox		ENDP


	PUBLIC	SetPalette

SetPalette	PROC	PalReg: WORD, Color: WORD

	MOV	AX,0EE12H
	MOV	BX,PalReg
	MOV	CX,Color
	INT	10H
	RET

SetPalette	ENDP


	PUBLIC	PaletteUsing

PaletteUsing	PROC	PalArray: DWORD

	USES	DS

	MOV	AX,0EE13H
	LDS	DX,PalArray
	INT	10H
	RET

PaletteUsing	ENDP


	PUBLIC	ResetPalette

ResetPalette	PROC

	MOV	AX,0EE14H
	INT	10H
	RET

ResetPalette	ENDP


	PUBLIC	ExtGet

ExtGet		PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Image: DWORD

	USES	DS

	MOV	AX,0EE15H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	LDS	DX,Image
	INT	10H
	RET

ExtGet		ENDP


	PUBLIC	ExtPut

ExtPut		PROC	X: WORD, Y: WORD, Image: DWORD, Action: WORD

	USES	DS

	MOV	AX,0EE16H
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Action
	LDS	DX,Image
	INT	10H
	RET

ExtPut		ENDP


	PUBLIC	CursorAction

CursorAction	PROC	Action: WORD

	MOV	AX,0EE17H
	MOV	BX,Action
	INT	10H
	RET

CursorAction	ENDP


	PUBLIC	CursorStatus

CursorStatus	PROC	Status: DWORD, CursorSize: DWORD

	MOV	AX,0EE18H
	INT	10H
	LES	DI,Status
	MOV	ES:[DI],BX
	LES	DI,CursorSize
	MOV	ES:[DI],CX
	RET

CursorStatus	ENDP


	PUBLIC	SetCursor

SetCursor	PROC	Row: WORD, Column: WORD

	MOV	AX,0EE19H
	MOV	BX,Column
	MOV	CX,Row
	INT	10H
	RET

SetCursor	ENDP


	PUBLIC	GetCursor

GetCursor	PROC	Row: DWORD, Column: DWORD

	MOV	AX,0EE1AH
	INT	10H
	LES	DI,Row
	MOV	ES:[DI],CX
	LES	DI,Column
	MOV	ES:[DI],BX
	RET

GetCursor	ENDP


	PUBLIC	PrintStringA

PrintStringA	PROC	Action: WORD, StrLen: WORD, StrSeg: WORD, StrOfs: WORD

	USES	DS

	MOV	AX,0EE1BH
	MOV	BX,Action
	MOV	CX,StrLen
	MOV	DS,StrSeg
	MOV	DX,StrOfs
	INT	10H
	RET

PrintStringA	ENDP


	PUBLIC	Animate

Animate		PROC	X: WORD, Y: WORD, Speed: WORD, Image: DWORD

	USES	DS

	MOV	AX,0EE1CH
	MOV	SI,X
	MOV	DI,Y
	MOV	CX,Speed
	LDS	DX,Image
	INT	10H
	RET

Animate		ENDP


	PUBLIC	PlotPointC

PlotPointC	PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE1DH
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

PlotPointC	ENDP


	PUBLIC	ExtLineC

ExtLineC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE1EH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

ExtLineC	ENDP


	PUBLIC	LineToC

LineToC		PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE1FH
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

LineToC		ENDP


	PUBLIC	LineRelC

LineRelC	PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE20H
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

LineRelC	ENDP


	PUBLIC	ExtCircleC

ExtCircleC	PROC	X: WORD, Y: WORD, Radius: WORD, Color: WORD

	MOV	AX,0EE21H
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Radius
	MOV	DX,Color
	INT	10H
	RET

ExtCircleC	ENDP


	PUBLIC	DrawBoxC

DrawBoxC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE22H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

DrawBoxC	ENDP


	PUBLIC	FillBoxC

FillBoxC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE23H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

FillBoxC	ENDP


	PUBLIC	SetSystem

SetSystem	PROC	Action: WORD

	MOV	AX,0EE80H
	MOV	BX,Action
	INT	10H
	RET

SetSystem	ENDP


	PUBLIC	GetSystem

GetSystem	PROC	Action: WORD

	MOV	AX,0EE80H
	MOV	BX,Action
	INT	10H
	RET

GetSystem	ENDP


	PUBLIC	ExtSound

ExtSound	PROC	Frequency: WORD, Duration: WORD, Volume: WORD, Channel: WORD

	MOV	AX,0EE81H
	MOV	BX,Volume
	MOV	CX,Channel
	MOV	SI,Frequency
	MOV	DI,Duration
	INT	10H
	RET

ExtSound	ENDP


	PUBLIC	Noise

Noise		PROC	NoiseType: WORD, Volume: WORD, Duration: WORD

	MOV	AX,0EE82H
	MOV	BX,NoiseType
	MOV	CX,Volume
	MOV	DX,Duration
	INT	10H
	RET

Noise		ENDP

	PUBLIC	Pause

Pause		PROC	Duration: WORD

	MOV	AX,0EE83H
	MOV	BX,Duration
	INT	10H
	RET

Pause		ENDP


	PUBLIC	SpeakerOff

SpeakerOff	PROC

	MOV	AX,8002H
	INT	1AH
	RET

SpeakerOff	ENDP


	PUBLIC	SpeakerOn

SpeakerOn	PROC

	MOV	AL,9FH
	OUT	0C0H,AL
	MOV	AL,0BFH
	OUT	0C0H,AL
	MOV	AL,0DFH
	OUT	0C0H,AL
	MOV	AX,8003H
	INT	1AH
	RET

SpeakerOn	ENDP


	PUBLIC	XorPoint

XorPoint	PROC	X: WORD, Y: WORD

	MOV	AX,0EE24H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

XorPoint	ENDP


	PUBLIC	XorPointC

XorPointC	PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE25H
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

XorPointC	ENDP


	PUBLIC	XorLine

XorLine		PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE26H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

XorLine		ENDP


	PUBLIC	XorLineC

XorLineC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE27H
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

XorLineC	ENDP


	PUBLIC	XorLineTo

XorLineTo	PROC	X: WORD, Y: WORD

	MOV	AX,0EE28H
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

XorLineTo	ENDP


	PUBLIC	XorLineToC

XorLineToC	PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE29H
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

XorLineToC	ENDP


	PUBLIC	XorLineRel

XorLineRel	PROC	X: WORD, Y: WORD

	MOV	AX,0EE2AH
	MOV	SI,X
	MOV	DI,Y
	INT	10H
	RET

XorLineRel	ENDP


	PUBLIC	XorLineRelC

XorLineRelC	PROC	X: WORD, Y: WORD, Color: WORD

	MOV	AX,0EE2BH
	MOV	SI,X
	MOV	DI,Y
	MOV	DX,Color
	INT	10H
	RET

XorLineRelC	ENDP


	PUBLIC	XorDrawBox

XorDrawBox	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE2CH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

XorDrawBox	ENDP


	PUBLIC	XorDrawBoxC

XorDrawBoxC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE2DH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

XorDrawBoxC	ENDP


	PUBLIC	XorFillBox

XorFillBox	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD, Color: WORD

	MOV	AX,0EE2EH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	MOV	DX,Color
	INT	10H
	RET

XorFillBox	ENDP


	PUBLIC	XorFillBoxC

XorFillBoxC	PROC	X1: WORD, Y1: WORD, X2: WORD, Y2: WORD

	MOV	AX,0EE2FH
	MOV	BX,X1
	MOV	CX,Y1
	MOV	SI,X2
	MOV	DI,Y2
	INT	10H
	RET

XorFillBoxC	ENDP


	PUBLIC	XorCircle

XorCircle	PROC	X: WORD, Y: WORD, Radius: WORD

	MOV	AX,0EE30H
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Radius
	INT	10H
	RET

XorCircle	ENDP


	PUBLIC	XorCircleC

XorCircleC	PROC	X: WORD, Y: WORD, Radius: WORD, Color: WORD

	MOV	AX,0EE31H
	MOV	SI,X
	MOV	DI,Y
	MOV	BX,Radius
	MOV	DX,Color
	INT	10H
	RET

XorCircleC	ENDP


	PUBLIC	Ellipse

Ellipse		PROC	XC: WORD, YC: WORD, A: WORD, B:WORD

	MOV	AX,0EE32H
	MOV	SI,XC
	MOV	DI,YC
	MOV	BX,A
	MOV	CX,B
	INT	10H
	RET

Ellipse		ENDP


	PUBLIC	EllipseC

EllipseC	PROC	XC: WORD, YC: WORD, A: WORD, B: WORD, Color: WORD

	MOV	AX,0EE33H
	MOV	SI,XC
	MOV	DI,YC
	MOV	BX,A
	MOV	CX,B
	MOV	DX,Color
	INT	10H
	RET

EllipseC	ENDP


	PUBLIC	XorEllipse

XorEllipse	PROC	XC: WORD, YC: WORD, A: WORD, B: WORD

	MOV	AX,0EE34H
	MOV	SI,XC
	MOV	DI,YC
	MOV	BX,A
	MOV	CX,B
	INT	10H
	RET

XorEllipse	ENDP


	PUBLIC	XorEllipseC

XorEllipseC	PROC	XC: WORD, YC: WORD, A: WORD, B: WORD, Color: WORD

	MOV	AX,0EE35H
	MOV	SI,XC
	MOV	DI,YC
	MOV	BX,A
	MOV	CX,B
	MOV	DX,Color
	INT	10H
	RET

XorEllipseC	ENDP


	PUBLIC	SetView

SetView		PROC	MinX: WORD, MinY: WORD, MaxX: WORD, MaxY: WORD

	MOV	AX,0EE36H
	MOV	BX,MinX
	MOV	CX,MinY
	MOV	SI,MaxX
	MOV	DI,MaxY
	INT	10H
	RET

SetView		ENDP


	PUBLIC	GetView

GetView		PROC	MinX: DWORD, MinY: DWORD, MaxX: DWORD, MaxY: DWORD

	MOV	AX,0EE37H
	INT	10H
	MOV	AX,DI
	LES	DI,MinX
	MOV	ES:[DI],BX
	LES	DI,MinY
	MOV	ES:[DI],CX
	LES	DI,MaxX
	MOV	ES:[DI],SI
	LES	DI,MaxY
	MOV	ES:[DI],AX
	RET

GetView		ENDP


	PUBLIC	ResetView

ResetView	PROC

	MOV	AX,0EE38H
	INT	10H
	RET

ResetView	ENDP


	PUBLIC	GetTandy11

GetTandy11	PROC	Tandy11: DWORD

	MOV	AX,0EE80H
	MOV	BX,12
	INT	10H
	LES	BX,Tandy11
	MOV	ES:[BX],AX
	RET

GetTandy11	ENDP


	PUBLIC	GetScreen

GetScreen	PROC	Image: DWORD

	USES	DS

	LDS	DX,Image
	MOV	AX,0EE39H
	INT	10H
	RET

GetScreen	ENDP


	PUBLIC	PutScreen

PutScreen	PROC	Image: DWORD

	USES	DS

	LDS	DX,Image
	MOV	AX,0EE3AH
	INT	10H
	RET

PutScreen	ENDP


	PUBLIC	SetDisplayPage

SetDisplayPage	PROC	DPage: WORD

	MOV	AX,0EE3BH
	MOV	BX,DPage
	INT	10H
	RET

SetDisplayPage	ENDP


	PUBLIC	GetDisplayPage

GetDisplayPage	PROC	DPage: DWORD

	MOV	AX,0EE3CH
	INT	10H
	LES	DI,DPage
	MOV	ES:[DI],BX
	RET

GetDisplayPage	ENDP


	PUBLIC	SetActivePage

SetActivePage	PROC	APage: WORD

	MOV	AX,0EE3DH
	MOV	BX,APage
	INT	10H
	RET

SetActivePage	ENDP


	PUBLIC	GetActivePage

GetActivePage	PROC	APage: DWORD

	MOV	AX,0EE3EH
	INT	10H
	LES	DI,APage
	MOV	ES:[DI],BX
	RET

GetActivePage	ENDP


	PUBLIC	PageCopy

PageCopy	PROC	Source: WORD, Destination: WORD

	MOV	AX,0EE3FH
	MOV	SI,Source
	MOV	DI,Destination
	INT	10H
	RET

PageCopy	ENDP


	PUBLIC	FastTimer

FastTimer	PROC	Speed: WORD

	MOV	AX,0EE84H
	MOV	BX,Speed
	INT	10H
	RET

FastTimer	ENDP


	PUBLIC	ResetTimer

ResetTimer	PROC

	MOV	AX,0EE85H
	INT	10H
	RET

ResetTimer	ENDP


	PUBLIC	GetTimer

GetTimer	PROC	Timer: DWORD

	MOV	AX,0EE86H
	INT	10H
	LES	DI,Timer
	MOV	ES:[DI],BX
	RET

GetTimer	ENDP

	END
