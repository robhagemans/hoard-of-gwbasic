DEFINT A-Z
'******************************* VIEWSHP.BAS ********************************
'*                                                                          *
'* This example will: Load all the shape data from [DEMO.SHP] file using    *
'*                  : the random access method.                             *
'*                  :                                                       *
'*                  : Display each shape when mouse button is pressed.      *
'*                                                                          *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0- 4.5 SEE PAGE 2 OF THE MANUAL  *
'*     : BEFORE TRYING TO RUN THIS DEMO!                                    *
'*     :                                                                    *
'*     : The first record (or 80 bytes) of each shape file is the header;   *
'*     : it is of importance only to the mouse editor.                      *
'*     :                                                                    *
'*                                                                          *
'****************************************************************************

'$INCLUDE: 'mlib.inc'

DECLARE SUB Target ()
DECLARE SUB MHold (B%)
DECLARE SUB LoadShape (SHPRec() AS MOUSEtype, OpenSHP$)

'============================================================================
SCREEN 12: CLS : CALL InitPointer(NumBut%)       'Initialize mouse.
IF NumBut% = 0 THEN SCREEN 0: END                'No mouse.
                                                 '
CALL GetSpeedM(H1%, V1%, D1%)                    'Get movement sensitivity.
CALL SetSpeedM(50, 50, 100)                      'Set new state.
                                                 '
REDIM SHPRec(0) AS MOUSEtype                     'Shape data array.
                                                 '
CALL LoadShape(SHPRec(), "DEMO.SHP")             'Open and load shape data.
                                                 '
CALL Target                                      '
                                                 '
PRINT "  <Press a key to end.> ";                '
PRINT "<Mouse button = next shape>": ShowPointer '
                                                 '
ElNum% = 1                                       '
                                                 '
DO                                               '
                                                 '
   CALL GetButtonM(BUT%, X%, Y%)                 'Check for button press.
                                                 '
   IF BUT% THEN                                  '
                                                 '
      IF ElNum% < UBOUND(SHPRec, 1) THEN         'Last record.
         ElNum% = ElNum% + 1                     '
      ELSE                                       '
         ElNum% = LBOUND(SHPRec, 1)              'First shape(second record).
      END IF                                     '
                                                 '
      CALL HidePointer                           '
                                                 '
      LOCATE 1, 58: PRINT "Record:"; ElNum% - 1; '
      PRINT SHPRec(ElNum%).FRM                   'Format (Trans or solid).
                                                 '
      CALL ShowPointer                           '
                                                 '
      SHPSTR$ = SHPRec(ElNum%).DAT               'Shape data.
      HSX% = SHPRec(ElNum%).HTX                  'Hot X.
      HSY% = SHPRec(ElNum%).HTY                  'Hot Y.
                                                 '
      CALL ChangePointer(SHPSTR$, HSX%, HSY%)    'Change shape of pointer.
                                                 '
      CALL MHold(BUT%)                           '
                                                 '
   END IF                                        '
                                                 '
LOOP WHILE INKEY$ = ""                           '
                                                 '
CALL SetSpeedM(H1%, V1%, D1%)                    'Restore sensitivity state.
                                                 '
SCREEN 0: END                                    '
                                                 '
'=============================================================================

'
'****************************************************************************
'*                                                                          *
'*           --------------------------------------------------------       *
'*           NOTE! THE FIRST RECORD IN EACH "SHP" FILE IS THE HEADER.       *
'*           --------------------------------------------------------       *
'*                                                                          *
'* SHPRec() AS MOUSEtype     : The array that holds the shape data.         *
'*             OpenSHP$      : The shape file that will be opened.          *
'*                           :                                              *
'* TYPE MOUSEtype            : Each record is 80 bytes.                     *
'*      DLT    AS INTEGER    : 2  bytes for editor use.                     *
'*      HTX    AS INTEGER    : 2  bytes for hotspot  X.                     *
'*      HTY    AS INTEGER    : 2  bytes for hotspot  Y.                     *
'*      MODE   AS STRING     : 10 bytes for solid or transparent ID.        *
'*      SHPSTR AS STRING     : 64 bytes for shape data.                     *
'* END TYPE                                                                 *
'*                                                                          *
'****************************************************************************
                                                 '
SUB LoadShape (SHPRec() AS MOUSEtype, OpenSHP$)  '
                                                 '
RecLen% = LEN(SHPRec(LBOUND(SHPRec, 1)))         'Length of a record.
                                                 '
FH% = FREEFILE                                   '
                                                 '
OPEN OpenSHP$ FOR RANDOM AS #FH% LEN = RecLen%   '
                                                 '
RecMax% = (LOF(FH%) \ RecLen%)                   'Calculate number of records.
                                                 'Skip header(start at 2).
REDIM SHPRec(2 TO RecMax%) AS MOUSEtype          'Dimension buffer to hold
                                                 'all the shapes from disk.
FOR Num% = 2 TO RecMax%                          'Load all the different
                                                 'pointer shape data strings
   GET #FH%, Num%, SHPRec(Num%)                  'plus hot spots off disk.
                                                 '
NEXT Num%                                        '
                                                 '
CLOSE #FH%                                       '
                                                 '
END SUB                                          '

SUB MHold (B%) STATIC'Loop while a mouse button is being held down.

DO: CALL GetButtonM(B%, X%, Y%)
 
LOOP WHILE B%

END SUB

SUB Target 'Draw a background.

LINE (15, 16)-(615, 465), 15, BF

Colr% = 0

FOR Size% = 220 TO 20 STEP -20
  
   Colr% = Colr% + 1
   CIRCLE (320, 240), Size%, Colr%
   PAINT (320, 240), Colr%, Colr%

NEXT

END SUB

