'LScroll and RScroll are handy routines I found in Compuserve's TB Library
'both are written by Ethan Winer and work without modification in PB 2.1

'LScroll - Scroll a part of the screen left
'Example:  CALL LScroll (TopRow%, LeftCol%, BotRow%, RightCol%, Lines%)

SUB LScroll INLINE PUBLIC
$INLINE &H55,&H1E,&H8B,&HEC,&H8B,&H76,&H18,&H8E,&H5E,&H1A,&H8A,&H04,&HFE,&HC8
$INLINE &HB1,&HA0,&HF6,&HE1,&H8B,&H76,&H14,&H8E,&H5E,&H16,&H8B,&H1C,&H4B,&H03
$INLINE &HC3,&H03,&HC3,&H8B,&HD8,&H8B,&H76,&H08,&H8E,&H5E,&H0A,&H2B,&H1C,&H2B
$INLINE &H1C,&HB9,&H00,&H00,&H8E,&HC1,&HB9,&H00,&HB0,&H26,&H8A,&H16,&H10,&H04
$INLINE &H80,&HE2,&H30,&H80,&HFA,&H30,&H74,&H14,&H81,&HC1,&H00,&H08,&H26,&H8A
$INLINE &H16,&H87,&H04,&H80,&HFA,&H00,&H75,&H06,&HBA,&HDA,&H03,&HEB,&H04,&H90
$INLINE &HBA,&H00,&H00,&H8E,&HC1,&H8B,&H76,&H10,&H8E,&H5E,&H12,&H8A,&H2C,&H8B
$INLINE &H76,&H18,&H8E,&H5E,&H1A,&H2A,&H2C,&HFE,&HC5,&H8B,&H76,&H0C,&H8E,&H5E
$INLINE &H0E,&H8A,&H0C,&H8B,&H76,&H14,&H8E,&H5E,&H16,&H2A,&H0C,&HFE,&HC1,&H06
$INLINE &H1F,&HFC,&H8B,&HF0,&H8B,&HFB,&H50,&H80,&HFA,&H00,&H74,&H0A,&HEC,&HA8
$INLINE &H01,&H75,&HFB,&HEC,&HA8,&H01,&H74,&HFB,&HAD,&HAB,&HFE,&HC9,&H75,&HEB
$INLINE &H58,&H50,&H2B,&HC3,&HD0,&HE8,&H8A,&HC8,&H58,&H50,&H2B,&HF0,&H8B,&HC6
$INLINE &HD0,&HE8,&H8A,&HE0,&H80,&HFA,&H00,&H74,&H0A,&HEC,&HA8,&H01,&H75,&HFB
$INLINE &HEC,&HA8,&H01,&H74,&HFB,&HB0,&H20,&HAA,&H47,&HFE,&HC9,&H75,&HE9,&H8A
$INLINE &HCC,&H58,&H05,&HA0,&H00,&H81,&HC3,&HA0,&H00,&HFE,&HCD,&H75,&HAF,&H1F
$INLINE &H5D
END SUB

'RScroll - Scroll a part of the screen right
'Example: CALL RScroll(TopRow%, LeftCol%, BotRow%, RightCol%, Lines%)

SUB RScroll INLINE PUBLIC
$INLINE &H55,&H1E,&H8B,&HEC,&H8B,&H76,&H18,&H8E,&H5E,&H1A,&H8A,&H04,&HFE,&HC8
$INLINE &HB1,&HA0,&HF6,&HE1,&H8B,&H76,&H0C,&H8E,&H5E,&H0E,&H8B,&H1C,&H4B,&H03
$INLINE &HC3,&H03,&HC3,&H8B,&HD8,&H8B,&H76,&H08,&H8E,&H5E,&H0A,&H03,&H1C,&H03
$INLINE &H1C,&HB9,&H00,&H00,&H8E,&HC1,&HB9,&H00,&HB0,&H26,&H8A,&H16,&H10,&H04
$INLINE &H80,&HE2,&H30,&H80,&HFA,&H30,&H74,&H14,&H81,&HC1,&H00,&H08,&H26,&H8A
$INLINE &H16,&H87,&H04,&H80,&HFA,&H00,&H75,&H06,&HBA,&HDA,&H03,&HEB,&H04,&H90
$INLINE &HBA,&H00,&H00,&H8E,&HC1,&H8B,&H76,&H10,&H8E,&H5E,&H12,&H8A,&H2C,&H8B
$INLINE &H76,&H18,&H8E,&H5E,&H1A,&H2A,&H2C,&HFE,&HC5,&H8B,&H76,&H0C,&H8E,&H5E
$INLINE &H0E,&H8A,&H0C,&H8B,&H76,&H14,&H8E,&H5E,&H16,&H2A,&H0C,&HFE,&HC1,&H06
$INLINE &H1F,&HFD,&H8B,&HF0,&H8B,&HFB,&H50,&H80,&HFA,&H00,&H74,&H0A,&HEC,&HA8
$INLINE &H01,&H75,&HFB,&HEC,&HA8,&H01,&H74,&HFB,&HAD,&HAB,&HFE,&HC9,&H75,&HEB
$INLINE &H58,&H50,&H53,&H2B,&HD8,&HD0,&HEB,&H8A,&HCB,&H5B,&H58,&H50,&H2B,&HC6
$INLINE &HD0,&HE8,&H8A,&HE0,&H80,&HFA,&H00,&H74,&H0A,&HEC,&HA8,&H01,&H75,&HFB
$INLINE &HEC,&HA8,&H01,&H74,&HFB,&HB0,&H20,&HAA,&H4F,&HFE,&HC9,&H75,&HE9,&H8A
$INLINE &HCC,&H58,&H05,&HA0,&H00,&H81,&HC3,&HA0,&H00,&HFE,&HCD,&H75,&HAF,&H1F
$INLINE &H5D
END SUB

'CompId% is a conversion I did from a misc BASICA example

'CompId% - Determines the type of computer being used
'             0 - Type is undetermined.  The computer could be a "clone"
'                 which does not have a 100% compatible BIOS.
'             1 - AT or compatible, including 386, or PS/2 Model 50/60
'             2 - PC Jr.
'             3 - XT, portable, or compatible
'             4 - PC or compatible
'	     -1 - PS/2 Model 25 or Model 30
'	     -3 - PS/2 Model 80

FUNCTION CompId%
    DEF SEG = &HF000
    Machine% = PEEK(&HFFFE)
    DEF SEG
    ComputerType% = Machine% - 251
    IF ComputerType% > 4 OR ComputerType% < 0 THEN
        ComputerType% = 0
    END IF
    CompId%=ComputerType%
END FUNCTION

'Reverse is a routine I wrote for PB Tools to reverse a string
'a very simple routine that comes in handy.

'Reverse - Reverse the charactors in a string

FUNCTION Reverse$(S$) PUBLIC
    FOR I%=LEN(S$) to 1 STEP  - 1
       Tmp$=Tmp$+MID$(S$,I%,1)
    NEXT I%
    Reverse$=Tmp$
END FUNCTION

'Month$ - Returns the name of a month when given numeric value
'written by Berry Erick for TB, modified for PB by myself.

FUNCTION Month$(mnth%)
   IF mnth%=1 then mn$="January"
   IF mnth%=2 then mn$="February"
   IF mnth%=3 then mn$="March"
   IF mnth%=4 then mn$="April"
   IF mnth%=5 then mn$="May"
   IF mnth%=6 then mn$="June"
   IF mnth%=7 then mn$="July"
   IF mnth%=8 then mn$="August"
   IF mnth%=9 then mn$="September"
   IF mnth%=10 then mn$="October"
   IF mnth%=11 then mn$="November"
   IF mnth%=12 then mn$="December"
   Mnth$=Mn$
END FUNCTION

'Weekday$ - Returns day of the week for current date
'written by Berry Erick for TB, modified for PB by myself

FUNCTION Weekday$(wkdy%)
   IF wkdy%=0 then wk$="Sunday"
   IF wkdy%=1 then wk$="Monday"
   IF wkdy%=2 then wk$="Tuesday"
   IF wkdy%=3 then wk$="Wednesday"
   IF wkdy%=4 then wk$="Thursday"
   IF wkdy%=5 then wk$="Friday"
   IF wkdy%=6 then wk$="Saturday"
   Weekday$=Wk$
END FUNCTION

'DayWeek% - Returns the day of the week (1-7) for the current date
'Idea from Berry Erick, written by myself

FUNCTION DayWeek%(Dat$)
   Temp$=DATE$
   DATE$=Dat$
   REG 1, &h2A00
   DayWeek%=REG(1) MOD 256
   DATE$=Temp$
END FUNCTION

'GetTodaysDate - Returns the current date
'written by Berry Erick, modified for PB by myself.

SUB GetTodaysDate (wk$, dm$, mn$, yr$)
   REG 1, &H2A00
   wkdy%= REG(1) MOD 256
   date%= REG(4) MOD 256
   Mnth%=REG(4)\256
   year%= REG(3)
   wk$=Weekday$(wkdy%)
   SELECT CASE date%
          CASE 1,21,31
               dm$=STR$(date%)+"st"
          CASE 3,23
               dm$=STR$(date%)+"rd"
          CASE 2,22
               dm$=STR$(date%)+"nd"
          CASE ELSE
               dm$=STR$(date%)+"th"
   END SELECT
   mn$=Month$(mnth%)
   yr$=RIGHT$(STR$(year%),4)
END SUB

'Min% - Returns time in minutes from midnight
'written by Dave Navarro

FUNCTION Min%(Tim$)
   Min%=VAL(LEFT$(Tim$,2))*60+VAL(MID$(Tim$,4,2))
END FUNCTION

'Elapsed% - Returns the number of minutes elapsed between two times
'written by Dave Navarro

FUNCTION Elapsed%(Tim1$, Tim2$)
   Tim1%=Min%(Tim1$)
   Tim2%=Min%(Tim2$)
   IF Tim2%<Tim1% THEN Tim2%=Tim2%+1440
   Elapsed%=Tim2%-Tim1%
END FUNCTION

'All mouse routines were derived from code for Turbo C found in "Programming
' the Microsoft Mouse" from MS Press

'IsMouse - Returns whether or not a mouse is installed and how many buttons
'written by Dave Navarro

FUNCTION IsMouse% PUBLIC
   REG 1, &h00
   CALL INTERRUPT &h33
   Stat%=REG(1)
   Bttn%=REG(2)
   IF Bttn%=-1 THEN Bttn%=2
   IF Stat% THEN IsMouse%=Bttn%
END FUNCTION

'MouseOn - Turn mouse cursor on
'written by Dave Navarro

SUB MouseOn PUBLIC
   REG 1, &h01
   CALL INTERRUPT &h33
END SUB

'MouseOff - Turn mouse curson off
'written by Dave Navarro

SUB MouseOff PUBLIC
   REG 1, &h02
   CALL INTERRUPT &h33
END SUB

'MouseStat - Return button pressed and current row & column position of cursor
'            Left button - 1, Right button - 2, Middle button - 4
'written by Dave Navarro

SUB MouseStat(Button%,Row%,Col%) PUBLIC
   REG 1, &h03
   CALL INTERRUPT &h33
   Button%=REG(2)
   Row%=REG(4)/8+1
   Col%=REG(3)/8+1
END SUB

'MLocate - Locates the mouse cursor at Row, Col
'written by Dave Navarro

SUB MLocate(Row%, Col%) PUBLIC
   REG 1, &h04
   REG 3, Col%*8-8
   REG 4, Row%*8-8
   CALL INTERRUPT &h33
END SUB

'MouseWin - defines window for mouse cursor
'written by Dave Navarro

SUB MouseWin(Row%, Col%, Rows%, Cols%) PUBLIC
   Rows%=Row%+Rows%-1
   Cols%=Col%+Cols%-1
   REG 1, &h08
   REG 3, Row%*8
   REG 4, Rows%*8
   CALL INTERRUPT &h33
   REG 1, &h07
   REG 3, Col%*8
   REG 4, Cols%*8
   CALL INTERRUPT &h33
   CALL MLocate(Row%, Col%)
END SUB

'Trim - Trims spaces from both ends of a string
'written by Dave Navarro

FUNCTION Trim$(T$) PUBLIC
    T$=LTRIM$(T$)
    Trim$=RTRIM$(T$)
END FUNCTION

'FFeed - Send a formfeed to the printer
'written by Dave Navarro

SUB FFeed PUBLIC
   LPRINT CHR$(12)
END SUB

' CvtDate$  - Convert a date from mm-dd-yy format to mm-dd-yyyy format
'written by Dave Navarro

FUNCTION CvtDate$(Tmp$) PUBLIC
     CvtDate$=LEFT$(Tmp$,6)+"19"+RIGHT$(Tmp$,2)
END FUNCTION

'Found on CIS in the TB conference
' Comment : Compaq 386 machines have the date offset by one.
'           Substitute &HFFF5 to &HFFFC in that case.

FUNCTION RomDate$ STATIC
  LOCAL Temp$
  DEF SEG = &HF000
  RomDate$ = PEEK$(&hFFF5, 10)
  DEF SEG
END FUNCTION

'PrtScrn - simulates pressing PrtSc
'written by Dave Navarro

SUB PrtScrn STATIC
    CALL INTERRUPT 5
END SUB

'DPOS - returns the cursor column according to DOS (works with ANSI)
'written by Dave Navarro

FUNCTION DPOS%
	REG 1,&H0300
	REG 2,&H0000
	CALL INTERRUPT &H10
	DPOS%=(REG(4) AND &H00FF)+1
END FUNCTION

'DCSRLIN - returns the cursor line according to DOS (works with ANSI)
'written by Dave Navarro

FUNCTION DCSRLIN%
	REG 1,&H0300
	REG 2,&H0000
	CALL INTERRUPT &H10
	DCSRLIN%=(REG(4) AND &HFF00)/256+1
END FUNCTION

'DPrint - Prints a text string via DOS, works with ANSI
'written by Dave Navarro
'WARNING!!  will not print dollar signs, if a dollar sign is encountered
'you will need to use DOS's princhar command instead of princhars

SUB Dprint(Temp$)
   Temp$=Temp$+"$"
   REG 1,&h0900
   REG 8,STRSEG(Temp$)
   REG 4,STRPTR(Temp$)
   CALL INTERRUPT &h21
END SUB

'CurDrive% - Returns current logged drive
'written by Dave Navarro

FUNCTION CurDrive% PUBLIC
   CurDrive%=ASC(CurDir$)-64
END FUNCTION

'Exist - Returns true if file exists
'written by Dave Navarro

FUNCTION Exist%(File$) PUBLIC
   Tmp$=DIR$(File$,&H17)
   IF Tmp$<>"" THEN Exist%=-1
END FUNCTION

'VLabel - Returns Volume Label
'written by Dave Navarro

FUNCTION VLabel$ PUBLIC
   VLabel$=DIR$("*.*",8)
END FUNCTION
