'All Routines in this file were written by Dave Navarro

'GetKey - Loop until a key is pressed and return the key to your program

FUNCTION Getkey$ PUBLIC
   WHILE I$=""
      I$=INKEY$
   WEND
   Getkey$=I$
END FUNCTION

'ScrollDN - Scroll a specified part of the screen down

SUB ScrollDN (LC%, RC%, TR%, BR%, Rows%, Atr%) PUBLIC
   REG 1, Rows%+256*7
   REG 2, Atr%*256
   REG 3, (LC%-1)+256*(TR%-1)
   REG 4, (RC%-1)+256*(BR%-1)
   CALL INTERRUPT &h10
END SUB

'ScrollUp - Scroll a specified part of the screen up

SUB ScrollUp (LC%, RC%, TR%, BR%, Rows%, Atr%) PUBLIC
   REG 1, Rows%+256*6
   REG 2, Atr%*256
   REG 3, (LC%-1)+256*(TR%-1)
   REG 4, (RC%-1)+256*(BR%-1)
   CALL INTERRUPT &h10
END SUB

'GetScrn$ - Get a portion of the screen and put it in a string

FUNCTION GetScrn$(Ypos%,Xpos%,Ylen%) PUBLIC
    DEF SEG=VidAddr%
    GetScrn$=PEEK$((Ypos%-1)*160+(Xpos%-1)*2,Ylen%*2)
    DEF SEG
END FUNCTION

'PutScrn - Put a string saved with FNGetScrn back onto the screen

SUB PutScrn(Ypos%, Xpos%, Temp$) PUBLIC
    DEF SEG=VidAddr%
    POKE$ (Ypos%-1)*160+(Xpos%-1)*2, Temp$
    DEF SEG
END SUB

'VidAddr - Returns segment of video address

FUNCTION VidAddr% PUBLIC
   DEF SEG=0
	 Videotmp%=PEEK(&h449)
	 IF Videotmp%=7 THEN Videotmp%=&hB000 ELSE Videotmp%=&hB800
	 DEF SEG
   VidAddr%=Videotmp%
END FUNCTION

'CurDrive% - Returns current logged drive

FUNCTION CurDrive% PUBLIC
   CurDrive%=ASC(CurDir$)-64
END FUNCTION

'Exist - Returns true if file exists

FUNCTION Exist%(File$) PUBLIC
   ON ERROR GOTO NoFile
   Tmp$=DIR$(File$,&H17)
   IF Tmp$<>"" THEN Exist%=-1
   EXIT FUNCTION
   NoFile:
	 RESUME NEXT
	 ON ERROR GOTO 0
	 Exist%=0
END FUNCTION

'GetDosV% - Returns DOS version number, Example: 3.3 = 330

FUNCTION GetDosV% PUBLIC
    REG 1, &h3000
    CALL INTERRUPT &h21
    Ver%=REG(1)/256
    MVer%=REG(1)-(Ver%*256)
    GetDosV%=MVer%*100+Ver%
END FUNCTION

'DrvSpace# - Double precision integer containing free bytes on default drive

FUNCTION DrvSpace# PUBLIC
    REG 1, &h3600
    REG 4, 0
    CALL INTERRUPT &h21
    SecPC#=REG(1)              ' Sectors per cluster
    FrCl#=REG(2)               ' Free clusters
    BytPS#=REG(3)              ' Bytes per sector
    DrvSpace#=(FrCl#*(SecPC#*BytPS#))
END FUNCTION

'FileCount% - report the number of files with Atr% attributes in Path$

FUNCTION FileCount%(Path$,Atr%) PUBLIC
   Tmp$=DIR$(Path$,Atr%)
   IF Tmp$="" THEN
      FileCount%=0
      EXIT FUNCTION
   END IF
   Count%=1
   MoreFiles:
      Tmp$=DIR$
      IF Tmp$<>"" THEN INCR Count%:GOTO MoreFiles
   FileCount%=Count%
END FUNCTION

'GetDir - Return filenames in Dir Path$ in an array

SUB GetDir(Path$,Atr%,TDir$()) PUBLIC
   TDir$(1)=Expand$(DIR$(Path$,Atr%))
   IF TDir$(1)="" THEN EXIT SUB
   Count%=2
   MorFiles:
    TDir$(Count%)=Expand$(DIR$)
	  IF TDir$(Count%)="" OR Count%=UBOUND(TDIR$(1)) THEN Sortem
      INCR Count%
      GOTO MorFiles
   SortEm:
	  ARRAY SORT TDir$()
END SUB

'VLabel - Returns Volume Label

FUNCTION VLabel$ PUBLIC
   VLabel$=DIR$("*.*",8)
END FUNCTION

'SetDrive - Log to another drive, 1 = A:, 2 = B:, etc...

SUB SetDrive(Drive%) PUBLIC
    REG 1, &h0E00
    REG 4, Drive%-1
    CALL INTERRUPT &h21
END SUB

'Atrb - Return a printable string describing a files attributes

FUNCTION Atrb$(X$) PUBLIC
  X$=NoSpace$(X$)
  IF X$="" OR X$="." OR RIGHT$(X$,1)="\" OR RIGHT$(X$,3)="\.." THEN EXIT FUNCTION
  X%=ATTRIB(X$)
  IF (X% AND 1)=1 THEN Tmp$=Tmp$+"R" ELSE Tmp$=Tmp$+"."
  IF (X% AND 2)=2 THEN Tmp$=Tmp$+"H" ELSE Tmp$=Tmp$+"."
  IF (X% AND 4)=4 THEN Tmp$=Tmp$+"S" ELSE Tmp$=Tmp$+"."
  IF (X% AND 32)=32 THEN Tmp$=Tmp$+"A" ELSE Tmp$=Tmp$+"."
  Atrb$=Tmp$
END FUNCTION

'Attrb - Turns a printable string containing attributes into an integer

FUNCTION Attrb%(Atr$) PUBLIC
   Atr$=UCASE$(Atr$)
   IF INSTR(Atr$,"A") THEN Tmp%=Tmp%+32
   IF INSTR(Atr$,"R") THEN Tmp%=Tmp%+1
   IF INSTR(Atr$,"H") THEN Tmp%=Tmp%+2
   IF INSTR(Atr$,"S") THEN Tmp%=Tmp%+4
   Attrb%=Tmp%
END FUNCTION

'Path - Finds a file if it is in the path, and returns it's full pathname

FUNCTION ChkPath$(F$) PUBLIC
  IF INSTR(F$,"*")>0 OR INSTR(F$,"?")>0 THEN EXIT FUNCTION
  IF F$="" THEN EXIT FUNCTION
  A$=UCASE$(ENVIRON$("PATH"))
  WHILE INSTR(A$,";")
    B$=LEFT$(A$,INSTR(A$,";")-1)
    A$=MID$(A$,INSTR(A$,";")+1)
    IF RIGHT$(B$,1)="\" THEN B$=LEFT$(B$,LEN(B$)-1)
    IF DIR$(B$,16)="" THEN SkipMe
    IsPath%=Exist%(B$+"\"+F$)
    IF IsPath% THEN ChkPath$=B$+"\"+F$:EXIT FUNCTION
    SkipMe:
  WEND
  IF RIGHT$(A$,1)="\" THEN A$=LEFT$(A$,LEN(A$)-1)
  IF Exist%(A$+"\"+F$) THEN ChkPath$=A$+"\"+F$
END FUNCTION

