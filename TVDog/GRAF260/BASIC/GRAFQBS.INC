' 
'Subprogram definition file for QuickBASIC
' 

DECLARE SUB Animate (BYVAL X%, BYVAL Y%, BYVAL Speed%, SEG Image%)
DECLARE SUB AudioOff ()
DECLARE SUB ClearKey ()
DECLARE SUB ClearScreen ()
DECLARE SUB ColorEnable (BYVAL Action%)
DECLARE SUB ColorOff ()
DECLARE SUB ColorOn ()
DECLARE SUB CurrentPoint (SEG X%, SEG Y%)
DECLARE SUB CursorAction (BYVAL Action%)
DECLARE SUB CursorOff ()
DECLARE SUB CursorOn ()
DECLARE SUB CursorStatus (SEG Status%, SEG CursorSize%)
DECLARE SUB DrawBox (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB DrawBoxC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB Ellipse (BYVAL XC%, BYVAL YC%, BYVAL A%, BYVAL B%)
DECLARE SUB EllipseC (BYVAL XC%, BYVAL YC%, BYVAL A%, BYVAL B%, BYVAL Hue%)
DECLARE SUB ExitGraphics ()
DECLARE SUB ExtCircle (BYVAL X%, BYVAL Y%, BYVAL Radius%)
DECLARE SUB ExtCircleC (BYVAL X%, BYVAL Y%, BYVAL Radius%, BYVAL Hue%)
DECLARE SUB ExtLine (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB ExtLineC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB ExtGet (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, SEG Image%)
DECLARE SUB ExtPaint (BYVAL X%, BYVAL Y%, BYVAL Fill%, BYVAL Boundry%)
DECLARE SUB ExtPut (BYVAL X%, BYVAL Y%, SEG Image%, BYVAL Action%)
DECLARE SUB ExtSound (BYVAL Frequency%, BYVAL Duration%, BYVAL Volume%, BYVAL Channel%)
DECLARE SUB FastTimer (BYVAL Speed%)
DECLARE SUB FillBox (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB FillBoxC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB GetActivePage (SEG Page%)
DECLARE SUB GetAspect (SEG XAspect%, SEG YAspect%)
DECLARE SUB GetBackColor (BackColor%)
DECLARE FUNCTION GetColor% (BYVAL ColorType%)
DECLARE SUB GetCursor (SEG Row%, SEG Column%)
DECLARE SUB GetDisplayPage (SEG Page%)
DECLARE SUB GetInput (Prompt$, GraphicInput$)
DECLARE SUB GetPlotColor (PlotColor%)
DECLARE FUNCTION GetSystem% (BYVAL Action%)
DECLARE SUB GetScreen(SEG Image%)
DECLARE SUB GetTandy11(SEG Tandy11%)
DECLARE SUB GetTextColor (TextColor%)
DECLARE SUB GetTimer (SEG TimerValue%)
DECLARE SUB GetView (SEG MinX%, SEG MinY%, SEG MaxX%, SEG MaxY%)
DECLARE SUB GraphStatus (Status%)
DECLARE SUB HalfCursor ()
DECLARE SUB HighGraphics ()
DECLARE SUB LineRel (BYVAL X%, BYVAL Y%)
DECLARE SUB LineRelC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB LineTo (BYVAL X%, BYVAL Y%)
DECLARE SUB LineToC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB LowGraphics ()
DECLARE SUB MediumGraphics ()
DECLARE SUB MoveRel (BYVAL X%, BYVAL Y%)
DECLARE SUB MoveTo (BYVAL X%, BYVAL Y%)
DECLARE SUB Noise (BYVAL NoiseType%, BYVAL Volume%, BYVAL Duration%)
DECLARE SUB NoiseBufOff ()
DECLARE SUB NoiseBufOn ()
DECLARE SUB NoiseOff ()
DECLARE SUB NormalCursor ()
DECLARE SUB PageCopy (BYVAL Source%, BYVAL Destination%)
DECLARE SUB PaletteUsing (SEG PalArray%)
DECLARE SUB Pause (BYVAL Duration%)
DECLARE SUB PlotPoint (BYVAL X%, BYVAL Y%)
DECLARE SUB PlotPointC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB PointColor (BYVAL X%, BYVAL Y%, SEG PixelColor%)
DECLARE SUB PrintString (GS$)
DECLARE SUB PrintStringX (GS$)
DECLARE SUB PrintStringA (BYVAL Action%, BYVAL Strlen%, BYVAL StrSeg%, BYVAL StrOfs%)
DECLARE SUB PutScreen(SEG Image%)
DECLARE SUB ResetPalette ()
DECLARE SUB ResetTimer ()
DECLARE SUB ResetView ()
DECLARE SUB SetAspect (BYVAL XAspect%, BYVAL YAspect%)
DECLARE SUB SetBackColor (BackColor%)
DECLARE SUB SetColor (BYVAL ColorType%, BYVAL Hue%)
DECLARE SUB SetCursor (BYVAL Row%, BYVAL Column%)
DECLARE SUB SetPalette (BYVAL PalReg%, BYVAL Hue%)
DECLARE SUB SetPlotColor (PlotColor%)
DECLARE SUB SetSystem (BYVAL Action%)
DECLARE SUB SetTextColor (TextColor%)
DECLARE SUB SetView (BYVAL MinX%, BYVAL MinY%, BYVAL MaxX%, BYVAL MaxY%)
DECLARE SUB SoundBufOff ()
DECLARE SUB SoundBufOn ()
DECLARE SUB SoundOff ()
DECLARE SUB SpeakerOff ()
DECLARE SUB SpeakerOn ()
DECLARE SUB WaitKey ()
DECLARE SUB XorCircle (BYVAL X%, BYVAL Y%, BYVAL Radius%)
DECLARE SUB XorCircleC (BYVAL X%, BYVAL Y%, BYVAL Radius%, BYVAL Hue%)
DECLARE SUB XorDrawBox (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB XorDrawBoxC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB XorEllipse (BYVAL XC%, BYVAL YC%, BYVAL A%, BYVAL B%)
DECLARE SUB XorEllipseC (BYVAL XC%, BYVAL YC%, BYVAL A%, BYVAL B%, BYVAL Hue%)
DECLARE SUB XorFillBox (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB XorFillBoxC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB XorLine (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%)
DECLARE SUB XorLineC (BYVAL X1%, BYVAL Y1%, BYVAL X2%, BYVAL Y2%, BYVAL Hue%)
DECLARE SUB XorLineRel (BYVAL X%, BYVAL Y%)
DECLARE SUB XorLineRelC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB XorLineTo (BYVAL X%, BYVAL Y%)
DECLARE SUB XorLineToC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB XorPoint (BYVAL X%, BYVAL Y%)
DECLARE SUB XorPointC (BYVAL X%, BYVAL Y%, BYVAL Hue%)
DECLARE SUB SetDisplayPage (BYVAL Page%)
DECLARE SUB SetActivePage (BYVAL Page%)

'Make sure default data type is integer
DEFINT A-Z

'Give color numbers meaningful names
CONST Black% = 0
CONST Blue% = 1
CONST Green% = 2
CONST Cyan% = 3
CONST Red% = 4
CONST Magenta% = 5
CONST Brown% = 6
CONST LightGray% = 7
CONST DarkGray% = 8
CONST LightBlue% = 9
CONST LightGreen% = 10
CONST LightCyan% = 11
CONST LightRed% = 12
CONST LightMagenta% = 13
CONST Yellow% = 14
CONST White% = 15

'Give put options meaningful names
CONST PutPreset% = 1
CONST PutPset% = 2
CONST PutAnd% = 3
CONST PutOr% = 4
CONST PutXor% = 5

'Give Tandy11 driver status meaningful names
CONST Tandy11.True% = 1
CONST Tandy11.False% = 0
