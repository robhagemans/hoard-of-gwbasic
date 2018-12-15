'
'Subprogram definition file for PowerBASIC
'

$LINK "GRAFIX.PBU"

DECLARE SUB Animate ()
DECLARE SUB AudioOff ()
DECLARE SUB ClearKey ()
DECLARE SUB ClearScreen ()
DECLARE SUB ColorEnable ()
DECLARE SUB ColorOff ()
DECLARE SUB ColorOn ()
DECLARE SUB CurrentPoint ()
DECLARE SUB CursorOff ()
DECLARE SUB CursorOn ()
DECLARE SUB CursorStatus ()
DECLARE SUB DrawBox ()
DECLARE SUB DrawBoxC ()
DECLARE SUB Ellipse ()
DECLARE SUB EllipseC ()
DECLARE SUB ExitGraphics ()
DECLARE SUB ExtCircle ()
DECLARE SUB ExtCircleC ()
DECLARE SUB ExtLine ()
DECLARE SUB ExtLineC ()
DECLARE SUB ExtGet ()
DECLARE SUB ExtPaint ()
DECLARE SUB ExtPut ()
DECLARE SUB ExtSound ()
DECLARE SUB FastTimer ()
DECLARE SUB FillBox ()
DECLARE SUB FillBoxC ()
DECLARE SUB GetActivePage ()
DECLARE SUB GetAspect ()
DECLARE SUB GetBackColor ()
DECLARE SUB GetCursor ()
DECLARE SUB GetDisplayPage ()
DECLARE SUB GetInput (STRING, STRING)
DECLARE SUB GetPlotColor ()
DECLARE SUB GetScreen()
DECLARE SUB GetTandy11()
DECLARE SUB GetTextColor ()
DECLARE SUB GetTimer ()
DECLARE SUB GetView ()
DECLARE SUB GraphStatus ()
DECLARE SUB HalfCursor ()
DECLARE SUB HighGraphics ()
DECLARE SUB LineRel ()
DECLARE SUB LineRelC ()
DECLARE SUB LineTo ()
DECLARE SUB LineToC ()
DECLARE SUB LowGraphics ()
DECLARE SUB MediumGraphics ()
DECLARE SUB MoveRel ()
DECLARE SUB MoveTo ()
DECLARE SUB Noise ()
DECLARE SUB NoiseBufOff ()
DECLARE SUB NoiseBufOn ()
DECLARE SUB NoiseOff ()
DECLARE SUB NormalCursor ()
DECLARE SUB PaletteUsing ()
DECLARE SUB PageCopy ()
DECLARE SUB Pause ()
DECLARE SUB PlotPoint ()
DECLARE SUB PlotPointC ()
DECLARE SUB PointColor ()
DECLARE SUB PrintString (STRING)
DECLARE SUB PrintStringX (STRING)
DECLARE SUB PutScreen()
DECLARE SUB ResetPalette ()
DECLARE SUB ResetTimer ()
DECLARE SUB ResetView ()
DECLARE SUB SetActivePage ()
DECLARE SUB SetAspect ()
DECLARE SUB SetBackColor ()
DECLARE SUB SetColor ()
DECLARE SUB SetCursor ()
DECLARE SUB SetDisplayPage ()
DECLARE SUB SetPalette ()
DECLARE SUB SetPlotColor ()
DECLARE SUB SetSystem ()
DECLARE SUB SetTextColor ()
DECLARE SUB SetView ()
DECLARE SUB SoundBufOff ()
DECLARE SUB SoundBufOn ()
DECLARE SUB SoundOff ()
DECLARE SUB SpeakerOff ()
DECLARE SUB SpeakerOn ()
DECLARE SUB WaitKey ()
DECLARE SUB XorCircle ()
DECLARE SUB XorCircleC ()
DECLARE SUB XorDrawBox ()
DECLARE SUB XorDrawBoxC ()
DECLARE SUB XorEllipse ()
DECLARE SUB XorEllipseC ()
DECLARE SUB XorFillBox ()
DECLARE SUB XorFillBoxC ()
DECLARE SUB XorLine ()
DECLARE SUB XorLineC ()
DECLARE SUB XorLineRel ()
DECLARE SUB XorLineRelC ()
DECLARE SUB XorLineTo ()
DECLARE SUB XorLineToC ()
DECLARE SUB XorPoint ()
DECLARE SUB XorPointC ()

'Make sure default data type is integer
DEFINT A-Z

'Give color numbers meaningful names
Black% = 0
Blue% = 1
Green% = 2
Cyan% = 3
Red% = 4
Magenta% = 5
Brown% = 6
LightGray% = 7
DarkGray% = 8
LightBlue% = 9
LightGreen% = 10
LightCyan% = 11
LightRed% = 12
LightMagenta% = 13
Yellow% = 14
White% = 15

'Give put options meaningful names
PutPreset% = 1
PutPset% = 2
PutAnd% = 3
PutOr% = 4
PutXor% = 5

'Give Tandy11 driver status meaningful names
Tandy11.True% = 1
Tandy11.False% = 0
