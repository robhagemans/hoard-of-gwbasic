DEFINT A-Z
'******************************** DEMO4.BAS *********************************
'*                                                                          *
'* Demonstrates: SetBoundM                                                  *
'*               InWinM                                                     *
'*               CALLing different pointer shapes.                          *
'*                                                                          *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0- 4.5 SEE PAGE 2 OF THE MANUAL  *
'*     : BEFORE TRYING TO RUN THIS DEMO!                                    *
'*     :                                                                    *
'*                                                                          *
'****************************************************************************
'                                                '
'$INCLUDE: 'mlib.inc'                            '
                                                 '
TYPE WindowType                                  '
      x1 AS INTEGER                              '
      y1 AS INTEGER                              '
      x2 AS INTEGER                              '
      y2 AS INTEGER                              '
      wc AS INTEGER'Win color.                   '
END TYPE                                         '
                                                 '
DECLARE SUB InitWin ()                           '
DECLARE SUB CreateWin ()                         '
DECLARE SUB NumberWin ()                         '
DECLARE FUNCTION ActiveWin ()                    '
                                                 '
DIM SHARED Win(1 TO 8) AS WindowType             '
DIM SHARED WinLB%, WinUB%                        '
WinLB% = LBOUND(Win, 1)                          'Set these vars now, so we
WinUB% = UBOUND(Win, 1)                          'only make one call to get
                                                 'upper/lower bounds.
SCREEN 12: CLS : CALL InitPointer(NumBut%)       '
IF NumBut% = 0 THEN                              '
   SCREEN 0                                      '
   PRINT "No mouse"                              '
   END                                           '
END IF                                           '
                                                 '
CALL SetBoundM(1, 1, 638, 110)                   'Confine pointer to area
                                                 'around windows.
                                                 '
CALL InitWin                                     '
CALL CreateWin                                   '
CALL NumberWin                                   '
                                                 '
LOCATE 10, 1                                     '
PRINT "Clicked in window:"                       '
                                                 '
LOCATE 28, 1                                     '
PRINT "Press a key to end..."                    '
CALL ShowPointer                                 '
                                                 '
DO                                               '
                                                 '
  DO                                             '
                                                 '
     CALL GetButtonM(But%, MX%, MY%)             '
                                                 '
     hWin% = ActiveWin                           'Continuously check which
     SELECT CASE hWin%                           'window pointer is in.
        CASE 1: ARROW0                           'Call a different shape
        CASE 2: HANDV0                           'for each window.
        CASE 3: HOURGLASS0                       'These shapes were created
        CASE 4: PEN0                             'by: ME.EXE(mouse editor)
        CASE 5: MAGNIFYGLASS0                    'CVTASM.EXE(convert-assembly)
        CASE 6: PAINTCUP0                        'assembled(MASM compatible)
        CASE 7: MOUSE0                           'linked to MLIB. ME/CVTASM
        CASE 8: WATCH0                           'included in registered ver.
     CASE ELSE: ARROW1                           'Not in a window, call
                hWin% = 0                        'default shape.
     END SELECT                                  '
                                                 '
     IF LEN(INKEY$) THEN SCREEN 0: END           '
                                                 '
  LOOP UNTIL But%                                '
                                                 '
  IF hWin% THEN                                  'Pointer is in a window.
                                                 'do some things and stuff.
     x1 = Win(hWin%).x1                          '
     y1 = Win(hWin%).y1                          '
     x2 = Win(hWin%).x2                          '
     y2 = Win(hWin%).y2                          '
     DIM Box(1 TO 1822)                          '
     HidePointer                                 '
     GET (x1, y1)-(x2, y2), Box                  '
     PUT (162, 135), Box, PSET                   '
     ShowPointer                                 '
  END IF                                         '
                                                 '
  WHILE But%                                     'Loop while button is down.
     CALL GetButtonM(But%, MX%, MY%)             '
  WEND                                           '
                                                 '
LOOP                                             '

FUNCTION ActiveWin

ActiveWin = 0 'Prove otherwise.

FOR El = WinLB% TO WinUB%                        'Check first through last
                                                 'Win(?) element, or until
                                                 'a match is made.
   x1 = Win(El).x1 'Easier to read.
   y1 = Win(El).y1
   x2 = Win(El).x2
   y2 = Win(El).y2

                                                 'NOTE! InWinM always checks
                                                 'current pointer position.
                                                 'InWinM returns -1, if true.
 
   IF InWinM(x1, y1, x2, y2) THEN                'Pointer is inside Win(?),
                                                 'return element number.
      ActiveWin = El
      EXIT FOR
     
   END IF

NEXT El

END FUNCTION

SUB CreateWin
'Draw 8 windows.

FOR Num% = LBOUND(Win, 1) TO UBOUND(Win, 1)

LINE (Win(Num%).x1, Win(Num%).y1)-(Win(Num%).x2, Win(Num%).y2), Win(Num%).wc, B
LINE (Win(Num%).x1 + 2, Win(Num%).y1 + 2)-(Win(Num%).x2 - 2, Win(Num%).y2 - 2), Win(Num%).wc, BF

NEXT Num%

END SUB

SUB InitWin
'Initialize Win() array.

Y = 0

FOR X = 1 TO 640 STEP 80
  
   Y = Y + 1
  
   Win(Y).x1 = X
   Win(Y).y1 = 10
   Win(Y).x2 = X + 72
   Win(Y).y2 = 100
   Win(Y).wc = Y   'win color.

NEXT

END SUB

SUB NumberWin
'Number each window.

FOR X = 1 TO 80 STEP 10

   LOCATE 2, X + 3
   PRINT X \ 10 + 1

NEXT

END SUB

