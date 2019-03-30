   10  '***************************************************************
   20  '* Set up Common for McRat subroutines, and Declare them
   30  '*
   40  COMMON  SHARED /McRat/ McRatComInt%, McRatComCsr%, McRatComPen%, McRatComRC%
   50  DECLARE SUB   McRatCsr (CType%,Parm1%,Parm2%)
   60  DECLARE SUB   McRatInt (Ck%,Buttons%)
   70  DECLARE SUB   McRatKey (Mk%,PRow%,PCol%,RRow%,RCol%)
   80  DECLARE SUB   McRatLoc (Row%,Col%)
   90  DECLARE SUB   McRatPen (MPen%)
  100  DECLARE SUB   McRatSet (Set%)
  110  DECLARE SUB   McRatWin (ULRow%,ULCol%,LRRow%,LRCol%)
  120  '
  130  '***************************************************************
  140  'Do not remove or modify the following copyright notification!
  150  CR1$ = "McRat - Mouse Control Interface Subroutines"+CHR$(13)
  160  CR2$ = "               Demo Program                "+CHR$(13)
  170  CR3$ = "    Version 1.0 - Released on 03-24-89     "+CHR$(13)
  180  CR4$ = "Copyright March, 1989 by Mark A. Mc Carthy "+CHR$(13)
  190  CLS
  200  PRINT ""
  210  PRINT SPACE$((80-LEN(CR1$))/2) CR1$;
  220  PRINT SPACE$((80-LEN(CR2$))/2) CR2$;
  230  PRINT SPACE$((80-LEN(CR3$))/2) CR3$;
  240  PRINT SPACE$((80-LEN(CR4$))/2) CR4$;
  250  PRINT ""
  260  'Do not remove or modify the preceeding copyright notification!
  270  '
  280  '***************************************************************
  290  '* See if a Mouse is installed on the system.
  300  '*
  310  McRatInt MCk%,BCk%
  320  IF    McRatComRC% <> 0 THEN
  330        PRINT "Error #" McRatComRC% "returned by McRatInt."
  340        ERROR 200
  350  END   IF
  360  IF    MCk% = -1 THEN
  370        PRINT "Mouse Hardware and Driver are installed"
  380        SELECT CASE BCk%
                   CASE  -1
                         PRINT "    and it has the standard two buttons."
                   CASE  0
                         PRINT "    and it has MORE than two buttons."
                   CASE  3
                         PRINT "    and it is a Mouse System Mouse."
                   CASE  ELSE
                         PRINT "    has a return of " BCk% " for buttons."
             END   SELECT
  480        PRINT "Press any key to continue....."
  490        IK$ = ""
  500        WHILE IK$ = "
  510              IK$ = INKEY$
  520        WEND
  530  ELSE
  540        PRINT "Can not locate Mouse Hardware and/or driver!"
  550        END
  560  END   IF
  570  '
  580  '***************************************************************
  590  '* Display Main Mouse selection screen.
  600  '*
  610  DsplyMainMenu:
  620  IF    McRatComInt% = -1 THEN
  630        McRatSet 0
  640        IF    McRatComRC% <> 0 THEN
  650              PRINT "Error #" McRatComRC% "returned by McRatSet."
  660              ERROR 200
  670        END   IF
  680  END   IF
  690  CLS
  700  COLOR 7,0
  710  PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป";
  720  PRINT "บmm/dd/yy     McRat Demo Program - with McRat Version 1.0 Routines     hh:mm:ssบ";
  730  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน";
  740  FOR   LR% = 1 TO 17
  750        PRINT "บ                                                                              บ";
  760  NEXT  LR%
  770  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน";
  780  PRINT "บ           Use the Mouse (either button), or the Tab and Enter Key            บ";
  790  PRINT "บ             to select an item on the menu.  Press <Esc> to exit.             บ";
  800  PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ";
  810  GOSUB DsplySelBox1
  820  GOSUB DsplySelBox2
  830  GOSUB DsplySelBox3
  840  GOSUB DsplySelBox4
  850  GOSUB DsplySelBox5
  860  GOSUB DsplySelBox6
  870  GOSUB DsplySelBox7
  880  GOSUB DsplySelBox8
  890  GOSUB DsplySelBox9
  900  HoldDate$ = ""
  910  HoldTime$ = ""
  920  IF    McRatComInt% = -1 THEN
  930        McRatWin 5,4,19,77
  940        IF    McRatComRC% <> 0 THEN
  950              PRINT "Error #" McRatComRC% "returned by McRatWin."
  960              ERROR 200
  970        END   IF
  980  END   IF
  990  MenuSel% = 0
 1000  '
 1010  GetMenuSelection:
 1020  Mk% = 0
 1030  IK$ = ""
 1040  IF    McRatComInt% = -1 THEN
 1050        McRatSet 1
 1060        IF    McRatComRC% <> 0 THEN
 1070              PRINT "Error #" McRatComRC% "returned by McRatSet."
 1080              ERROR 200
 1090        END   IF
 1100  END   IF
 1110  WHILE Mk% = 0 AND IK$ = ""
 1120        IF    McRatComInt% = -1 THEN
 1130              McRatKey Mk%,PRow%,PCol%,RRow%,RCol%
 1140              IF    McRatComRC% <> 0 THEN
 1150                    PRINT "Error #" McRatComRC% "returned by McRatKey."
 1160                    ERROR 200
 1170              END   IF
 1180        END   IF
 1190        IK$ = INKEY$
 1200        IF    HoldDate$ <> DATE$ OR _
                   HoldTime$ <> TIME$ THEN
 1210              HoldDate$ = DATE$
 1220              HoldTime$ = TIME$
 1230              IF    McRatComInt% = -1 THEN
 1240                    McRatSet 0
 1250                    IF    McRatComRC% <> 0 THEN
 1260                          PRINT "Error #" McRatComRC% "returned by McRatSet."
 1270                          ERROR 200
 1280                    END   IF
 1290              END   IF
 1300              LOCATE 02,02 : PRINT HoldDate$;
 1310              LOCATE 02,72 : PRINT HoldTime$;
 1320              IF    McRatComInt% = -1 THEN
 1330                    McRatSet 1
 1340                    IF    McRatComRC% <> 0 THEN
 1350                          PRINT "Error #" McRatComRC% "returned by McRatSet."
 1360                          ERROR 200
 1370                    END   IF
 1380              END   IF
 1390        END   IF
 1400  WEND
 1410  IF    McRatComInt% = -1 THEN
 1420        McRatSet 0
 1430        IF    McRatComRC% <> 0 THEN
 1440              PRINT "Error #" McRatComRC% "returned by McRatSet."
 1450              ERROR 200
 1460        END   IF
 1470  END   IF
 1480  '
 1490  LOCATE 25,1 : PRINT SPACE$(79);
 1500  '
 1510  IF    IK$ = CHR$(27) THEN
 1520        GOTO EndMCRATDEM
 1530  END   IF
 1540  '
 1550  IF    Mk% <> 0 THEN
 1560        MenuSel% = 0
 1570        IF    PRow% >=  5 AND _
                   PRow% <=  9 THEN
 1580              IF    PCol% >=  4 AND _
                         PCol% <= 27 THEN
 1590                    MenuSel% = 1
 1600              END   IF
 1610              IF    PCol% >= 29 AND _
                         PCol% <= 52 THEN
 1620                    MenuSel% = 2
 1630              END   IF
 1640              IF    PCol% >= 54 AND _
                         PCol% <= 77 THEN
 1650                    MenuSel% = 3
 1660              END   IF
 1670        END   IF
 1680        IF    PRow% >= 10 AND _
                   PRow% <= 14 THEN
 1690              IF    PCol% >=  4 AND _
                         PCol% <= 27 THEN
 1700                    MenuSel% = 4
 1710              END   IF
 1720              IF    PCol% >= 29 AND _
                         PCol% <= 52 THEN
 1730                    MenuSel% = 5
 1740              END   IF
 1750              IF    PCol% >= 54 AND _
                         PCol% <= 77 THEN
 1760                    MenuSel% = 6
 1770              END   IF
 1780        END   IF
 1790        IF    PRow% >= 15 AND _
                   PRow% <= 19 THEN
 1800              IF    PCol% >=  4 AND _
                         PCol% <= 27 THEN
 1810                    MenuSel% = 7
 1820              END   IF
 1830              IF    PCol% >= 29 AND _
                         PCol% <= 52 THEN
 1840                    MenuSel% = 8
 1850              END   IF
 1860              IF    PCol% >= 54 AND _
                         PCol% <= 77 THEN
 1870                    MenuSel% = 9
 1880              END   IF
 1890        END   IF
 1900        IF    MenuSel% = 0 THEN
 1910              LOCATE 25,1
 1920              PRINT "Invalid Mouse Position for Selction";
 1930              GOTO GetMenuSelection
 1940        END   IF
 1950        GOTO  ItemSelected
 1960  END   IF
 1970  '
 1980  IF    IK$ = CHR$(13) THEN
 1990        IF    MenuSel% = 0 THEN
 2000              LOCATE 25,1
 2010              PRINT "Invalid Position for Selction";
 2020              GOTO GetMenuSelection
 2030        ELSE
 2040              GOTO  ItemSelected
 2050        END   IF
 2060  END   IF
 2070  '
 2080  IF    IK$ = CHR$(9) OR _
             IK$ = CHR$(0)+CHR$(15) THEN
 2090        IF    MenuSel% > 0 THEN
 2100              COLOR 7,0
 2110              ON    MenuSel% GOSUB DsplySelBox1, _
                                        DsplySelBox2, _
                                        DsplySelBox3, _
                                        DsplySelBox4, _
                                        DsplySelBox5, _
                                        DsplySelBox6, _
                                        DsplySelBox7, _
                                        DsplySelBox8, _
                                        DsplySelBox9
 2120        END   IF
 2130        IF    IK$ = CHR$(9) THEN
 2140              MenuSel% = MenuSel% + 1
 2150        END   IF
 2160        IF    IK$ = CHR$(0)+CHR$(15) THEN
 2170              MenuSel% = MenuSel% - 1
 2180        END   IF
 2190        IF    MenuSel% < 0 THEN
 2200              MenuSel% = 9
 2210        END   IF
 2220        IF    MenuSel% > 9 THEN
 2230              MenuSel% = 0
 2240        END   IF
 2250        IF    MenuSel% > 0 THEN
 2260              COLOR 0,7
 2270              ON    MenuSel% GOSUB DsplySelBox1, _
                                        DsplySelBox2, _
                                        DsplySelBox3, _
                                        DsplySelBox4, _
                                        DsplySelBox5, _
                                        DsplySelBox6, _
                                        DsplySelBox7, _
                                        DsplySelBox8, _
                                        DsplySelBox9
 2280              COLOR 7,0
 2290        END   IF
 2300        GOTO GetMenuSelection
 2310  END   IF
 2320  LOCATE 25,01 : PRINT "Invalid Key Pressed.";
 2330  GOTO GetMenuSelection
 2340  '
 2350  ItemSelected:
 2360  CLS
 2370  HoldDate$ = ""
 2380  HoldTime$ = ""
 2390  LOCATE 01,01 : PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป";
 2400  LOCATE 02,01 : PRINT "บmm/dd/yy     McRat Demo Program - with McRat Version 1.0 Routines     hh:mm:ssบ";
 2410  LOCATE 03,01 : PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ";
 2420  LOCATE 22,01 : PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป";
 2430  LOCATE 23,01 : PRINT "บ                       Press any key to return to menu                        บ";
 2440  LOCATE 24,01 : PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ";
 2450  LOCATE 04,01
 2460  ON    MenuSel% GOSUB MenuSelection1, _
                            MenuSelection2, _
                            MenuSelection3, _
                            MenuSelection4, _
                            MenuSelection5, _
                            MenuSelection6, _
                            MenuSelection7, _
                            MenuSelection8, _
                            MenuSelection9
 2470  Mk% = 0
 2480  IK$ = ""
 2490  WHILE Mk% = 0 AND IK$ = ""
 2500        IF    McRatComInt% = -1 THEN
 2510              McRatKey Mk%,PRow%,PCol%,RRow%,RCol%
 2520              IF    McRatComRC% <> 0 THEN
 2530                    PRINT "Error #" McRatComRC% "returned by McRatKey."
 2540                    ERROR 200
 2550              END   IF
 2560        END   IF
 2570        IK$ = INKEY$
 2580        IF    HoldDate$ <> DATE$ OR _
                   HoldTime$ <> TIME$ THEN
 2590              HoldDate$ = DATE$
 2600              HoldTime$ = TIME$
 2610              LOCATE 02,02 : PRINT HoldDate$;
 2620              LOCATE 02,72 : PRINT HoldTime$;
 2630        END   IF
 2640  WEND
 2650  GOTO DsplyMainMenu
 2660  '
 2670  EndMCRATDEM:
 2680  COLOR 7,0
 2690  CLS
 2700  END
 2710  '
 2720  '***************************************************************
 2730  '* Display Main Menu Selection Boxes.
 2740  '*
 2750  DsplySelBox1:
 2760  LOCATE 05,04 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 2770  LOCATE 06,04 : PRINT "ณ McRat Common/Declaresณ";
 2780  LOCATE 07,04 : PRINT "ณ    in Main Program   ณ";
 2790  LOCATE 08,04 : PRINT "ณ    Copy: MCRATCOM    ณ";
 2800  LOCATE 09,04 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 2810  RETURN
 2820  '
 2830  DsplySelBox2:
 2840  LOCATE 05,29 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 2850  LOCATE 06,29 : PRINT "ณ Mouse Initialization ณ";
 2860  LOCATE 07,29 : PRINT "ณ                      ณ";
 2870  LOCATE 08,29 : PRINT "ณ    Call: McRatInt    ณ";
 2880  LOCATE 09,29 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 2890  RETURN
 2900  '
 2910  DsplySelBox3:
 2920  LOCATE 05,54 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 2930  LOCATE 06,54 : PRINT "ณ  Define Mouse Cursor ณ";
 2940  LOCATE 07,54 : PRINT "ณ                      ณ";
 2950  LOCATE 08,54 : PRINT "ณ    Call: McRatCsr    ณ";
 2960  LOCATE 09,54 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 2970  RETURN
 2980  '
 2990  DsplySelBox4:
 3000  LOCATE 10,04 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3010  LOCATE 11,04 : PRINT "ณ Mouse Key/Position   ณ";
 3020  LOCATE 12,04 : PRINT "ณ      Checking        ณ";
 3030  LOCATE 13,04 : PRINT "ณ    Call: McRatKey    ณ";
 3040  LOCATE 14,04 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3050  RETURN
 3060  '
 3070  DsplySelBox5:
 3080  LOCATE 10,29 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3090  LOCATE 11,29 : PRINT "ณ  Set Mouse Position  ณ";
 3100  LOCATE 12,29 : PRINT "ณ                      ณ";
 3110  LOCATE 13,29 : PRINT "ณ    Call: McRatLoc    ณ";
 3120  LOCATE 14,29 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3130  RETURN
 3140  '
 3150  DsplySelBox6:
 3160  LOCATE 10,54 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3170  LOCATE 11,54 : PRINT "ณ   Set Mouse Cursor   ณ";
 3180  LOCATE 12,54 : PRINT "ณ        On/Off        ณ";
 3190  LOCATE 13,54 : PRINT "ณ    Call: McRatSet    ณ";
 3200  LOCATE 14,54 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3210  RETURN
 3220  '
 3230  DsplySelBox7:
 3240  LOCATE 15,04 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3250  LOCATE 16,04 : PRINT "ณ  Define Mouse Window ณ";
 3260  LOCATE 17,04 : PRINT "ณ                      ณ";
 3270  LOCATE 18,04 : PRINT "ณ    Call: McRatWin    ณ";
 3280  LOCATE 19,04 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3290  RETURN
 3300  '
 3310  DsplySelBox8:
 3320  LOCATE 15,29 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3330  LOCATE 16,29 : PRINT "ณ Light Pen Emulation  ณ";
 3340  LOCATE 17,29 : PRINT "ณ        On/Off        ณ";
 3350  LOCATE 18,29 : PRINT "ณ    Call: McRatPen    ณ";
 3360  LOCATE 19,29 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3370  RETURN
 3380  '
 3390  DsplySelBox9:
 3400  LOCATE 15,54 : PRINT "ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ";
 3410  LOCATE 16,54 : PRINT "ณ      Print McRat     ณ";
 3420  LOCATE 17,54 : PRINT "ณ     Documentation    ณ";
 3430  LOCATE 18,54 : PRINT "ณ Copyright March 1989 ณ";
 3440  LOCATE 19,54 : PRINT "ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู";
 3450  RETURN
 3460  '
 3470  MenuSelection1:
 3480  PRINT "Item:    MCRATCOM - Define McRat Common and Subroutines"
 3490  PRINT ""
 3500  PRINT "The basic statements  in MCRATCOM define  the COMMON items  for the McRat  sub-"
 3510  PRINT "routines, and DECLARE the subroutines that will be use for mouse control."
 3520  PRINT ""
 3530  PRINT "These statements should  be included  in the  Main Program prior  to other  ex-"
 3540  PRINT "ecutable statements."
 3550  PRINT ""
 3560  PRINT "   COMMON  SHARED /McRat/ McRatComInt%, McRatComCsr%, McRatComPen%, McRatComRC%"
 3570  PRINT "   DECLARE SUB   McRatCsr (CType%,Parm1%,Parm2%)"
 3580  PRINT "   DECLARE SUB   McRatInt (Ck%,Buttons%)"
 3590  PRINT "   DECLARE SUB   McRatKey (Mk%,PRow%,PCol%,RRow%,RCol%)"
 3600  PRINT "   DECLARE SUB   McRatLoc (Row%,Col%)"
 3610  PRINT "   DECLARE SUB   McRatPen (MPen%)"
 3620  PRINT "   DECLARE SUB   McRatSet (Set%)"
 3630  PRINT "   DECLARE SUB   McRatWin (ULRow%,ULCol%,LRRow%,LRCol%)"
 3640  RETURN
 3650  '
 3660  MenuSelection2:
 3670  PRINT "Item:    McRatInt - Mouse Check and Initialization"
 3680  PRINT "Usage    McRatInt Ck%,Buttons%"
 3690  PRINT ""
 3700  PRINT "This subroutine must  be called before  any other McRat  subroutine.  The  sub-"
 3710  PRINT "routine will check  to ensure that Mouse  the Hardware and Software  driver are"
 3720  PRINT "installed.  If the mouse is installed the " CHR$(34) "Ck%" CHR$(34) " parameter will be returned with"
 3730  PRINT "a value of -1, and the " CHR$(34) "Button%" CHR$(34) " parameter will be set to the number of buttons"
 3740  PRINT "on the mouse."
 3750  PRINT ""
 3760  PRINT "If initialization  of the mouse is  successful the  common items " CHR$(34) "McRatComInt%" CHR$(34) ""
 3770  PRINT "will be set to -1 and " CHR$(34) "McRatComRC%" CHR$(34) " will be set to 0."
 3780  PRINT ""
 3790  PRINT "    McRatComRC% Errors:      -1  Unexpected error during Initilization"
 3800  RETURN
 3810  '
 3820  MenuSelection3:
 3830  PRINT "Item:    McRatCsr - Define Mouse Cursor for text"
 3840  PRINT "Usage:   McRatCsr CType%,Parm1%,Parm2%"
 3850  PRINT ""
 3860  PRINT "This subroutine  will define  the define the  Mouse Cursor  that is  displayed."
 3870  PRINT "" CHR$(34) "CType%" CHR$(34) " is the type  of cursor to define 0=Software, 1=Hardware.   If Software"
 3880  PRINT "cursor,  the character  attribute at  cursor position  will be  ANDed  with the"
 3890  PRINT "" CHR$(34) "Parm1%" CHR$(34) " value and XORed with the " CHR$(34) "Parm2%" CHR$(34) " value.  If Hardware cursor, " CHR$(34) "Parm1%" CHR$(34) ""
 3900  PRINT "is the starting scan line, and Parm2% is the ending scan line."
 3910  PRINT ""
 3920  PRINT "    McRatComRC% Errors:      -1  Mouse Not Installed"
 3930  PRINT "                              1  Invalid Parameter 1 Value"
 3940  PRINT "                              2  Invalid Parameter 2 Value"
 3950  RETURN
 3960  '
 3970  MenuSelection4:
 3980  PRINT "Item:    McRatKey - Get Mouse Key and Positions"
 3990  PRINT "Usage:   McRatKey Mk%,PRow%,PCol%,RRow%,RCol%"
 4000  PRINT ""
 4010  PRINT "This subroutine will trap the mouse position at  the time the button is pressed"
 4020  PRINT "and  then release.  If  " CHR$(34) "Mk%" CHR$(34) " is 0  the mouse button was  not pushed during the"
 4030  PRINT "call.   If the mouse  button was pushed  " CHR$(34) "Mk%" CHR$(34) " will  be 1=Right Button,  2=Left"
 4040  PRINT "Button, 3=Middle Button.   " CHR$(34) "PRow%" CHR$(34) " and  " CHR$(34) "PCol%" CHR$(34) " will  be the character row  and"
 4050  PRINT "column that  the mouse  was at  when the  button  was pushed,  and " CHR$(34) "RRow%" CHR$(34) "  and"
 4060  PRINT "" CHR$(34) "RCol%" CHR$(34) " will be the character row and column that the mouse was at when he"
 4070  PRINT "button was released."
 4080  PRINT ""
 4090  PRINT "    McRatComRC% Errors:      -1  Mouse Not Installed"
 4100  RETURN
 4110  '
 4120  MenuSelection5:
 4130  PRINT "Item:    McRatLoc - Set Mouse Cursor Position"
 4140  PRINT "Usage:   McRatLoc Row%,Col%"
 4150  PRINT ""
 4160  PRINT "This  subroutine will  move the mouse  cursor to  the character row  and column"
 4170  PRINT "specified by " CHR$(34) "Row%" CHR$(34) " and " CHR$(34) "Col%" CHR$(34) "."
 4180  PRINT ""
 4190  PRINT "     McRatComRC% Errors:     -1  Mouse Not Installed"
 4200  PRINT "                              1  Invalid Row Parameter"
 4210  PRINT "                              2  Invalid Column Parameter"
 4220  RETURN
 4230  '
 4240  MenuSelection6:
 4250  PRINT "Item:    McRatSet - Toggle Mouse Cursor On and Off"
 4260  PRINT "Usage:   McRatSet I%"
 4270  PRINT ""
 4280  PRINT "This subroutine will turn the Mouse Cursor On and Off.  If " CHR$(34) "I%" CHR$(34) " is 0 the cursor"
 4290  PRINT "will be turn off, if " CHR$(34) "I%" CHR$(34) " in non 0 the cursor will be turned on."
 4300  PRINT ""
 4310  PRINT "Note:  The mouse  cursor must be turn off when ever you are doing printing that"
 4320  PRINT "may cause the screen to scroll.  If you  do not turn the cursor off, the cursor"
 4330  PRINT "display position will scroll with the screen."
 4340  PRINT ""
 4350  PRINT "    McRatComRC% Errors:      -1 Mouse Not Installed"
 4360  RETURN
 4370  '
 4380  MenuSelection7:
 4390  PRINT "Item:    McRatWin - Define Window for Mouse Cursor movement"
 4400  PRINT "Usage:   McRatWin ULRow%,ULCol%,LRRow%,LRCol%"
 4410  PRINT ""
 4420  PRINT "This  subroutine  will define  the  screen  window for  mouse  cursor movement."
 4430  PRINT "" CHR$(34) "ULRow%" CHR$(34) " and " CHR$(34) "ULCol%" CHR$(34) " specify  the Upper Left character Row and  Column for the"
 4440  PRINT "window,  and " CHR$(34) "LRRow%" CHR$(34) "  and " CHR$(34) "LRCol%" CHR$(34) "  define the  Lower Right character  Row and"
 4450  PRINT "Column for the window.   Once a window is define  mouse movement is limited  to"
 4460  PRINT "that area."
 4470  PRINT ""
 4480  PRINT "     McRatComRC% Errors:     -1  Mouse Not Installed"
 4490  PRINT "                              1  Invalid Upper/Left Row Parameter"
 4500  PRINT "                              2  Invalid Upper/Left Column Parameter"
 4510  PRINT "                              3  Invalid Lower/Right Row Parameter"
 4520  PRINT "                              4  Invalid Lower/Right Column Parameter"
 4530  RETURN
 4540  '
 4550  MenuSelection8:
 4560  PRINT "Item:    McRatPen - Toggle Mouse / Light Pen Emulation On and Off"
 4570  PRINT "Usage:   McRatPen I%"
 4580  PRINT ""
 4590  PRINT "This subroutine will turn  the Mouse / Light Pen Emulation On and Off.  If " CHR$(34) "I%" CHR$(34) ""
 4600  PRINT "is 0 the cursor will  be turn off, if " CHR$(34) "I%" CHR$(34) " in non 0 the cursor will be turned"
 4610  PRINT "on."
 4620  PRINT ""
 4630  PRINT "Note:  While Light  Pen Emulation is on  the standard BASIC commands  for Light"
 4640  PRINT "Pen trapping and processing should work.   With the MircoSoft Mouse and  driver"
 4650  PRINT "that I  was running  during testing,  both mouse  buttons had  to be pushed  to"
 4660  PRINT "register the light pen."
 4670  PRINT ""
 4680  PRINT "    McRatComRC% Errors:      -1 Mouse Not Installed"
 4690  RETURN
 4700  '
 4710  MenuSelection9:
 4720  PRINT "Item:   Print McRat Documentation and Registration Form"
 4730  LOCATE 12,37 : PRINT "Working"
 4740  SHELL "COPY MCRAT.DOC PRN: > NUL"
 4750  SHELL "COPY MCRAT.REG PRN: > NUL"
 4760  LOCATE 12,37 : PRINT "  Done "
 4770  RETURN
