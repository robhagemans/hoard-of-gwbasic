DEFINT A-Z
'****************************** CVT2DATA.BAS ********************************
'*                                                                          *
'* This example will:Convert binary data in a [????.SHP] to DATA statements *
'*                  :which can then be compiled with your program.          *
'*                                                                          *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0- 4.5 SEE PAGE 2 OF THE MANUAL  *
'*     : BEFORE TRYING TO RUN THIS PROGRAM!                                 *
'*     :                                                                    *
'*     : The first record (or 80 bytes) of each shape file is the header;   *
'*     : it is of importance only to the mouse editor (which is included    *
'*     : with the registered version).                                      *
'*     :                                                                    *
'*                                                                          *
'****************************************************************************

'$INCLUDE: 'mlib.inc'

DECLARE SUB ReadData ()
DECLARE SUB Target ()
DECLARE SUB GetInput (SHP$, DAT$, RNum%)
DECLARE SUB Cvt2Data (SHP$, DAT$, RNum%)

'============================================================================
                                                 '
SCREEN 12: CLS : CALL InitPointer(NumBut%)       '
                                                 '
IF NumBut% = 0 THEN SCREEN 0: END                'No mouse.
                                                 '
CALL GetInput(SHP$, DAT$, RNum%)                 'User input.
                                                 '
CALL Cvt2Data(SHP$, DAT$, RNum%)                 'Convert to DATA statements.
                                                 '
CALL ReadData                                    'Convert DATA into a shape.
                                                 '
CLS : CALL Target                                'Draw a background.
                                                 '
PRINT "  <DATA created pointer shape shown.>";   '
                                                 '
PRINT "                <Press a key to end.>"    '
                                                 '
CALL ShowPointer                                 '
                                                 '
DO: LOOP UNTIL LEN(INKEY$)                       '
                                                 '
SCREEN 0: END                                    '
                                                 '
'============================================================================

'=======================< Example output of this program >===================

'The first 2 data constants (in each block) contain the hotspot x,y values.
'You must cut and paste your own to display other shapes.
'Just run this demo, next ALT+F+L oad DATA filename, cut and paste it here.
'Subroutine ReadData converts this DATA back into a pointer shape.

'Arrow pointer, in SOLID format.
'REMing this DATA block = TRANS.

'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 1
'Format      : SOLID
DATA &H0,&H0,&H3FFD,&HFFA,&H3FB,&HFA,&H3D,&HF,&H3
DATA &H1,&H3F,&H81F,&H1C0F,&H3E07,&H7F03,&HFF83,&HFFC7,&HFFFF
DATA &H0,&H4000,&H7000,&H7C00,&H7F00,&H7FC0,&H7FF0,&H7F00,&H6780
DATA &H43C0,&H1E0,&HF0,&H78,&H38,&H0,&H0


'Arrow pointer, in TRANSparent format.

'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 19
'Format      : TRANS
DATA &H0,&H0,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF
DATA &HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF
DATA &HC002,&HF005,&HFC04,&HFF05,&HFFC2,&HFFF0,&HFFFC,&HFFFE,&HFFC0
DATA &HF7E0,&HE3F0,&HC1F8,&H80FC,&H7C,&H38,&H0

'============================================================================

SUB Cvt2Data (SHP$, DAT$, RNum%)

FH1% = FREEFILE: OPEN SHP$ FOR BINARY AS #FH1%   '
FH2% = FREEFILE: OPEN DAT$ FOR OUTPUT AS #FH2%   'Sequential output.
EndData% = RNum% * 80 - 1                        'Calculate end of data, work
StartData% = EndData% - 62                       'backwards.Why? Because.
Xoff% = StartData% - 14                          'Hot spot X offset.
Yoff% = Xoff% + 2                                'Hot spot Y offset.
                                                 '
DIM Format AS STRING * 10: CLS                     '
                                                 '
RNum% = RNum% - 1                                'Get actual record.
GET #FH1%, Xoff%, HotX%                          'Get the hotspots.
GET #FH1%, Yoff%, HotY%                          '
GET #FH1%, Yoff% + 2, Format                     'Solid or Transparent shape.
                                                 '
PRINT #FH2%, "'Source      : "; SHP$             'Print to file.
PRINT #FH2%, "'Destination : "; DAT$
PRINT #FH2%, "'Record      :"; RNum%
PRINT #FH2%, "'Format      : "; Format
PRINT #FH2%, "DATA "; "&H"; HEX$(HotX%); ","; "&H"; HEX$(HotY%);

PRINT "'Source      : "; SHP$                    'Print to screen.
PRINT "'Destination : "; DAT$
PRINT "'Record      :"; RNum%
PRINT "'Format      : "; Format
PRINT "DATA "; "&H"; HEX$(HotX%); ","; "&H"; HEX$(HotY%);
Cntr% = 2

FOR OffSet% = StartData% TO EndData% STEP 2      '64 bytes.

  Cntr% = Cntr% + 1
  GET #FH1%, OffSet%, Get2Byte%
  SHPDAT$ = SHPDAT$ + MKI$(Get2Byte%)

  SELECT CASE Cntr%
     CASE IS = 1
        PRINT #FH2%, "DATA "; "&H"; HEX$(Get2Byte%);
        PRINT "DATA "; "&H"; HEX$(Get2Byte%);
     CASE IS <= 8
        PRINT #FH2%, ","; ; "&H"; HEX$(Get2Byte%);
        PRINT ","; "&H"; HEX$(Get2Byte%);
     CASE IS > 8
        PRINT #FH2%, ","; ; "&H"; HEX$(Get2Byte%)
        PRINT ","; "&H"; HEX$(Get2Byte%)
        Cntr% = 0
  END SELECT

NEXT OffSet%

CLOSE
PRINT : PRINT : PRINT "Converted pointer shape shown."
PRINT : PRINT : PRINT "Press a key to continue."

ShowPointer                                      'Show the shape that was
CALL ChangePointer(SHPDAT$, HotX%, HotY%)        'just converted to DATA
Hold$ = INPUT$(1): HidePointer                   'statements.

END SUB

SUB GetInput (SHP$, DAT$, RNum%)

TryAgain1:

PRINT "               ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT "               ³                                                   ³"
PRINT "               ³       Source: Name of the [XXX.SHP] file that     ³"
PRINT "               ³               contains the shape information      ³"
PRINT "               ³               to convert to DATA statements.      ³"
PRINT "               ³                                                   ³"
PRINT "               ³               NOTE! You must supply the complete  ³"
PRINT "               ³               filename.                           ³"
PRINT "               ³                                                   ³"
PRINT "               ³  Destination: Name of the output file that will   ³"
PRINT "               ³               hold the DATA statements.           ³"
PRINT "               ³                                                   ³"
PRINT "               ³                                                   ³"
PRINT "               ³ Shape number: Number of the desired shape.        ³"
PRINT "               ³               (Run VIEWSHP.BAS to get number)     ³"
PRINT "               ³                                                   ³"
PRINT "               ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"


INPUT "Source       <ENTER=[DEMO.SHP]> : "; SHP$ 'File to open.
INPUT "Destination  <ENTER=[DATA.DAT]> : "; DAT$ 'Data output file.
                                                 '
IF LEN(SHP$) = 0 THEN SHP$ = "DEMO.SHP"          '
IF LEN(DAT$) = 0 THEN DAT$ = "DATA.DAT"          '
                                                 '
FH% = FREEFILE                                   '
OPEN SHP$ FOR INPUT AS #FH%                      '
                                                 '
MaxRec% = (LOF(FH%) \ 80) - 1: CLOSE             'Calculate number of records,
                                                 'minus 1, header not counted.
TryAgain:                                        '
                                                 '
PRINT "Shape number < 1 -"; MaxRec%; ">  : ";    'Get which record...
                                                 '
INPUT RNum%                                      '
                                                 '
IF RNum% <= 0 THEN                               '
   PRINT "Bad shape number.  Redo..."            '
   GOTO TryAgain                                 '
ELSEIF RNum > MaxRec% THEN                       'Passed end of file.
   PRINT "Bad shape number.  Redo..."            '
   GOTO TryAgain                                 '
END IF                                           '
                                                 '
RNum% = RNum% + 1                                'Skip over header.
                                                 '
END SUB                                          '

'
'****************************************************************************
'*                                                                          *
'* Read the shape DATA into SHPDAT$, then tell the Changepointer            *
'* routine to change the mouse cursor to the new shape.                     *
'*                                                                          *
'****************************************************************************
'
SUB ReadData

'============================================================================

READ HotX%, HotY%                                'First 2 statements are
                                                 'X and Y hotspots.
FOR xdata = 1 TO 32                              '
   READ SHPdata%                                 '
   SHPDAT$ = SHPDAT$ + MKI$(SHPdata%)            'Build data string.
NEXT xdata                                       '
                                                 '
CALL ChangePointer(SHPDAT$, HotX%, HotY%)        'Change it.
                                                 '
'============================================================================

END SUB

SUB Target

LINE (15, 16)-(615, 465), 15, BF
                                               
Colr% = 0
FOR Size% = 220 TO 20 STEP -20

   Colr% = Colr% + 1
   CIRCLE (320, 240), Size%, Colr%
   PAINT (320, 240), Colr%, Colr%

NEXT

END SUB

