
'******************************** DEMO1.BAS *********************************
'*                                                                          *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0- 4.5 SEE PAGE 2 OF THE MANUAL  *
'*     : BEFORE TRYING TO RUN THIS DEMO!                                    *
'*     :                                                                    *
'*                                                                          *
'****************************************************************************

TYPE MagType
   x1 AS INTEGER
   y1 AS INTEGER
   NX AS INTEGER
   NY AS INTEGER
   WD AS INTEGER
   HT AS INTEGER
END TYPE

DEFINT A-Z

'$INCLUDE: 'mlib.inc'
DECLARE SUB Doodle ()
DECLARE SUB DoSelect (Choice$, MX%, MY%)
DECLARE SUB Effects ()
DECLARE SUB EndIt ()
DECLARE SUB Magnify ()
DECLARE SUB OpenMsg ()
DECLARE SUB HelpBar ()
DECLARE SUB ReadData ()
DECLARE SUB Reverse (Choice$)
DECLARE SUB ScanPix (MG() AS ANY, N%)
DECLARE SUB ZLoop ()
DECLARE SUB ZMHold (B%, X%, Y%)

DECLARE FUNCTION InDoodleArea% ()
DECLARE FUNCTION InMagnifyArea% ()
DECLARE FUNCTION InMenuArea% ()
DECLARE FUNCTION OnTarget% (Selection%)

'============================================================================
                                                 
SCREEN 12: CLS : CALL InitPointer(NumBut%)       'Initialize mouse.
IF NumBut% = 0 THEN EndIt                        'No mouse.
CALL DClicRate(7)  '<= DEFAULT=9  1/2 Sec.       'Set double click speed.
CALL DClicBut(1)   '<= DEFAULT=1  Left button    'Check left mouse button.
CALL DClicOn       '<= DEFAULT=ON                'Turn double click on.
                                                 '
OpenMsg                                          '
                                                 '
OPTION BASE 1                                    '
DIM SHARED Buf(1 TO 4, 1 TO 120)                 '
DIM SHARED Shape$(3), HotX%(3), HotY%(3)         '
DIM SHARED MG(1)  AS MagType                     '
                                                 '
GOSUB SetUp                                      '
                                                 '
CALL ReadData                                    'Convert DATA into a shape.
                                                 '
CALL ChangePointer(Shape$(1), HotX%(1), HotY%(1))'Hand shape.
                                                 'DATA block 1.
CALL ShowPointer                                 '
                                                 '
DO                                               'Main loop.
                                                 '
  DO                                             '
     CALL DClicM(BUT%, MX%, MY%, Dble%)          'Get mouse button/location
                                                 'and double click info.
     Ky$ = INKEY$                                '
                                                 '
  LOOP UNTIL Ky$ = CHR$(27) OR BUT% = 1          '
                                                 '
  IF LEN(Ky$) THEN                               '
                                                 '
     EndIt                                       '
                                                 '
  ELSEIF InMenuArea% THEN                        '
                                                 '
     IF Dble% THEN                               '
        CALL DoSelect(Choice$, MX%, MY%)         '
     ELSE                                        '
        CALL Reverse(Choice$)                    '
     END IF                                      '
                                                 '
  ELSEIF Choice$ = "Doodle" THEN Doodle          '
                                                 '
  ELSEIF Choice$ = "Magnify" THEN Magnify        '
                                                 '
                                                 '
  END IF                                         '
                                                 '
LOOP WHILE Ky$ <> CHR$(27)                       '
                                                 '
CALL EndIt                                       '
                                                 '
'============================================================================

'Subroutine ReadData converts this DATA back into a 64 byte string.

'Hand.
'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 2
'Format      : SOLID
DATA &H4,&H0,&HF3FD,&HE1FA,&HE1FB,&HE1FA,&HE1FD,&HE049,&HE000
DATA &H8000,&H0,&H0,&H0,&H0,&H8000,&HC001,&HE003,&HE003
DATA &H0,&HC00,&HC00,&HC00,&HC00,&HC00,&HDB6,&HDB6,&H6DB6
DATA &H6FFE,&H6FFE,&H7FFE,&H3FFE,&H1FFC,&HFF8,&H0

'Magnify
'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 11
'Format      : SOLID
DATA &H6,&H5,&HE07D,&HD0BA,&HBFDB,&H7FEA,&H3BCD,&H3D4F,&H2BCF
DATA &H3DCF,&H7FEF,&HBFDF,&HD08F,&HE057,&HFFEB,&HFFF5,&HFFFA,&HFFFC
DATA &H0,&HF00,&H0,&H0,&H4420,&H42A0,&H5420,&H4220,&H0
DATA &H0,&HF00,&H0,&H0,&H0,&H0,&H0

'*** REM this block to view pen in non color. ***
'Pen.
'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 5
'Format      : SOLID
DATA &H0,&HF,&HBFE1,&H5FD0,&H7FA0,&H5F41,&HBE83,&HFF07,&HFE0F
DATA &HFC1F,&HF83F,&HF07F,&HE0FF,&HC1FF,&HC3FF,&HC7FF,&HBFFF,&H7FFF
DATA &H0,&H6,&HC,&H18,&H30,&H60,&HC0,&H180,&H300
DATA &H600,&HC00,&H1800,&H1000,&H0,&H0,&H0

'Pen
'Source      : DEMO.SHP
'Destination : DATA.DAT
'Record      : 21
'Format      : TRANS
DATA &H0,&HF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF
DATA &HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF,&HFFFF
DATA &H401E,&HA02F,&H805F,&HA0BE,&H417C,&HF8,&H1F0,&H3E0,&H7C0
DATA &HF80,&H1F00,&H3E00,&H3C00,&H3800,&H4000,&H8000

'============================================================================

SetUp:

NWide% = 9:   NHigh% = NWide%     'Number of gridblocks hor/ver.
    
GSizeH% = 15: GSizeV% = GSizeH%   'Size of each gridblock.
En% = 1
MG(En%).x1 = 480                  'X coordinates.
MG(En%).y1 = 14                   'Y coordinates.
MG(En%).NX = NWide%               'Number of grid blocks wide.
MG(En%).NY = NHigh%               'Number of grid blocks high.
MG(En%).WD = GSizeH%              'Width of each block (In pixels).
MG(En%).HT = GSizeV%              'Height of each block (In pixels).
                                        
PX1% = MG(En%).x1
PY1% = MG(En%).y1
PX2% = PX1% + NWide% * GSizeH%
PY2% = PY1% + NHigh% * GSizeV%

LINE (PX1% - 1, PY1% - 1)-(PX2%, PY2%), 15, B

LINE (PX1% - 1, PY2% + 15)-(PX2%, PY2% + 296), 15, B

LINE (PX1%, PY2% + 16)-(PX2% - 1, PY2% + 295), 4, BF

LINE (10, 13)-(470, 35), 15, B

LOCATE 2, 7
PRINT "   Quit      Effects      Magnify      Doodle   "

CALL HelpBar

RETURN

SUB Doodle
    
IF InDoodleArea% THEN                       '
                                            '
   CALL GetButtonM(Dummy%, MX%, MY%)        '
   CALL HidePointer                         '
   PSET (MX%, MY%), 15                      'Update position.
   CALL ShowPointer                         '
                                            '
   DO                                       '
                                            '
      ZMHold BUT%, MX%, MY%                 'Loop while pointer is in
                                            'the same position.
      IF InDoodleArea% THEN                 '
         CALL HidePointer                   'Draw a line from old pos
         LINE -(MX%, MY%), 15               'to new.
         CALL ShowPointer                   '
      ELSE                                  '
         EXIT DO                            '
      END IF                                '
                                            '
   LOOP WHILE BUT%                          '
                                            '
END IF                                      '

END SUB

SUB DoSelect (Choice$, MX%, MY%)

   Col% = (MX% \ 8) + 1  'For 8 X 16 character size, SCREEN 12.
   Row% = (MY% \ 16) + 1
  
   IF Row% = 2 THEN
  
      SELECT CASE Col%

         CASE 7 TO 16  '................. Quit
            
            EndIt

         CASE 17 TO 29 '................. Effects
           
            '*
            '* For demonstration puposes we will:
            '*
            '*        -  get the size of the mouse enviroment
            '*        -  save the mouse state
            '*        -  restore the mouse state
            '*
           
            Size% = GetSizeM%                    'Get size of environment.
           
            Buffer$ = SPACE$(Size%)              'Buffer$ needs to be the
                                                 'same size as the mouse
                                                 'environment.
            HidePointer
                                                 
               CALL SaveStateM(Buffer$, ErrNum%) 'Save environment.
                                                
               CALL Effects
                                                 
               CALL RestoreStateM(Buffer$, ErrNum%)'Restore environment.


            IF ErrNum% THEN                      'If an error occurred,
               SetPointer MX%, MY%               'set pointer in original
            END IF                               'position.
                                                 
            ShowPointer

         CASE 30 TO 42 '................. Magnify
           
            Choice$ = "Magnify"
            ChangePointer Shape$(2), HotX%(2), HotY%(2)'Mag glass.
                                                       'DATA block 2.
         CASE 43 TO 54 '................. Doodle
           
            Choice$ = "Doodle"
            ChangePointer Shape$(3), HotX%(3), HotY%(3)'Pen.
                                                       'DATA block 3.
      END SELECT

   END IF

END SUB

SUB Effects STATIC

GET (17 * 8 - 8, 16)-(29 * 8, 32), Buf(2, 1): PUT (17 * 8 - 8, 16), Buf(2, 1), PRESET

LOCATE 29, 2
PRINT "[ Click or key press = Stop ]" + SPACE$(47)

PosX% = 160
PosY% = 195

DO
  
   CALL GetButtonM(BUT%, x1%, y1%)
   
   Start! = TIMER + .1
   WHILE Done! < Start!: Done! = TIMER
   
      L1 = (L1 MOD 150) - 2
      LINE (PosX% + L1, L1 + PosY%)-((PosX% * 2) - L1, (PosY% + 100) - L1), CLR, B
  
      L2 = (L2 MOD 99) + 1
      LINE (PosX% + L2, L2 + PosY%)-((PosX% * 2) - L2, (PosY% + 100) - L2), CLR, B
  
   WEND
     
   CLR = (CLR + 1) MOD 16

LOOP UNTIL LEN(INKEY$) OR BUT%

GET (17 * 8 - 8, 16)-(29 * 8, 32), Buf(2, 1): PUT (17 * 8 - 8, 16), Buf(2, 1), PRESET

CALL HelpBar


END SUB

SUB EndIt

SCREEN 0
CLS
END







END SUB

SUB HelpBar

VIEW PRINT
LOCATE 29, 2
PRINT "[ Click or Esc = Quit | Double Click = Effects | Click = Magnify or Doodle ]"

END SUB

FUNCTION InDoodleArea%
          

IF InWinM(481, 166, 613, 443) THEN
   InDoodleArea% = -1
ELSE
   InDoodleArea% = 0
END IF

'BASIC equivalent.
'CALL GetButtonM(BUT%, x1%, y1%)
'
'SELECT CASE x1%
'
'   CASE 481 TO 613
'
'      SELECT CASE y1%
'
'         CASE 166 TO 443
'
'            InDoodleArea% = -1
'
'         CASE ELSE
'
'            InDoodleArea% = 0
'
'      END SELECT
'
'   CASE ELSE
'
'      InDoodleArea% = 0
'
'END SELECT

END FUNCTION

FUNCTION InMagnifyArea%
         
IF InWinM(10, 45, 470, 445) THEN
   InMagnifyArea% = -1
   EXIT FUNCTION
ELSE
   InMagnifyArea% = 0
END IF

'BASIC equivalent.
'CALL GetButtonM(BUT%, x1%, y1%)
'
'SELECT CASE x1%
'
'   CASE 10 TO 470
'
'      SELECT CASE y1%
'
'         CASE 45 TO 445
'
'            InMagnifyArea% = -1
'            EXIT FUNCTION
'
'         CASE ELSE
'
'      END SELECT
'
'   CASE ELSE
'
'END SELECT


IF InDoodleArea% THEN
   InMagnifyArea% = -1
ELSE
   InMagnifyArea% = 0
END IF



END FUNCTION

FUNCTION InMenuArea%

IF InWinM(10, 13, 470, 35) THEN
   InMenuArea% = -1
ELSE
   InMenuArea% = 0
END IF

'BASIC equivalent.
'CALL GetButtonM(BUT%, x1%, y1%)
'
'SELECT CASE x1%
'
'   CASE 10 TO 470
'
'      SELECT CASE y1%
'
'         CASE 13 TO 35
'
'            InMenuArea% = -1
'
'         CASE ELSE
'
'            InMenuArea% = 0
'
'      END SELECT
'
'   CASE ELSE
'
'      InMenuArea% = 0
'
'END SELECT

END FUNCTION

SUB Magnify
    
SHARED En%                                  'Share with main mod.
                                            '
IF InMagnifyArea% THEN                      '
                                            '
   CALL ScanPix(MG(), En%)                  'Scan area to magnify, and
                                            'draw it on the screen.
   ZLoop                                    'Loop while button is down.
                                            '
END IF                                      '

END SUB

FUNCTION OnTarget% (Selection%)

   OnTarget% = -1                           'Let CASE prove otherwise.
  
   CALL GetButtonM(BUT%, MX%, MY%)
 
   Col% = (MX% \ 8) + 1  'For 8 X 16 character size, screen 12.
   Row% = (MY% \ 16) + 1

   IF Row% = 2 THEN

      SELECT CASE Col%

         CASE 7 TO 16:   Selection% = 1     'Quit
         CASE 30 TO 42:  Selection% = 3     'Magnify
         CASE 43 TO 54:  Selection% = 4     'Doodle
         
      CASE ELSE
        
         OnTarget% = 0

      END SELECT
     
   ELSE
     
      OnTarget% = 0

   END IF

   IF BUT% = 0 THEN OnTarget% = 0

END FUNCTION

SUB OpenMsg

PRINT
PRINT "A very simple demo on double clicking, plus a few other general"
PRINT "mouse related procedures."

PRINT
PRINT
PRINT "Press a key/button to continue..."

DO
  
   CALL GetButtonM(BUT%, x1%, y1%)
  
LOOP UNTIL BUT% OR LEN(INKEY$)

CLS

END SUB

'
'****************************************************************************
'*                                                                          *
'* Read the shape DATA into the Shape$ array.                               *
'*                                                                          *
'*                                                                          *
'****************************************************************************
'
SUB ReadData

'============================================================================

Y = 0                                            '
                                                 '
FOR X = 1 TO 3                                   '
                                                 '
   Y = Y + 1                                     '
   READ HotX%(Y), HotY%(Y)                       'First 2 statements are
                                                 'X and Y hotspots.
   FOR xdata = 1 TO 32                           '
      READ SHPdata%                              '
      Shape$(Y) = Shape$(Y) + MKI$(SHPdata%)     'Build data string.
   NEXT xdata                                    '
                                                 '
NEXT X                                           '
                                                 '
'============================================================================

END SUB

SUB Reverse (Choice$)

Dummy% = OnTarget%(Selection%)                   'Which one.

GOSUB ReverseIt                                  'Reverse colors.

IF OnTarget%(Selection%) THEN
  
   CALL GetButtonM(BUT%, MX%, MY%)
  
   CALL DoSelect(Choice$, MX%, MY%)
  
   SaveSelection% = Selection%

   WHILE OnTarget%(Selection%): WEND
  
   IF Selection% <> SaveSelection% THEN          'Make sure Selection%
      Selection% = SaveSelection%                'is the same.
   END IF

   ZLoop

END IF

GOSUB ReverseIt

ZLoop

EXIT SUB

ReverseIt:

HidePointer

SELECT CASE Selection%
   CASE 1: GET (7 * 8 - 8, 16)-(16 * 8, 32), Buf(1, 1):  PUT (7 * 8 - 8, 16), Buf(1, 1), PRESET
   CASE 3: GET (30 * 8 - 8, 16)-(42 * 8, 32), Buf(3, 1): PUT (30 * 8 - 8, 16), Buf(3, 1), PRESET
   CASE 4: GET (43 * 8 - 8, 16)-(54 * 8, 32), Buf(4, 1): PUT (43 * 8 - 8, 16), Buf(4, 1), PRESET
END SELECT

ShowPointer

RETURN

END SUB

SUB ScanPix (MG() AS MagType, N%) STATIC

CALL GetButtonM(BUT%, MX%, MY%)

STX% = MX% - 4 'Starting pixel position.
STY% = MY% - 4

 H1% = MG(N%).WD \ 2
 V1% = MG(N%).HT \ 2
 XG% = MG(N%).x1 + H1%
 YG% = MG(N%).y1 + V1%
 RE% = STX% + MG(N%).NX - 1
 CE% = STY% + MG(N%).NY - 1

CALL HidePointer

'Scan left to right.
FOR SX% = STX% TO RE%

   'Scan top to bottom.
   FOR SY% = STY% TO CE%

      Colr% = POINT(SX%, SY%)
      
      'Calculate row and column.
      R1% = XG% + ((SX% - STX%) * MG(N%).WD)
      C1% = YG% + ((SY% - STY%) * MG(N%).HT)

      'Draw a filled box with the same color as the pixel.
      LINE (R1% - H1%, C1% - V1%)-(R1% + H1%, C1% + V1%), Colr%, BF
      
   NEXT SY%

NEXT SX%

CALL ShowPointer

END SUB

SUB ZLoop
  
   DO
   CALL GetButtonM(BUT%, x1%, y1%)
   LOOP WHILE BUT%

END SUB

SUB ZMHold (B%, X%, Y%) STATIC

OldPos% = X% + Y%

DO: CALL GetButtonM(B%, X%, Y%)
 
LOOP UNTIL X% + Y% <> OldPos% OR B% = 0

END SUB

