'
'  This program inputs image data from a Basic BSAVEd file and converts it
' to a PCX format.  The input and output files are specified on the
' command-line.  The Basic image must be in the format corresponding to
' the process of using the Basic GET command to transfer pixel data on the
' screen to an array and then BSAVEing the array.  (This program will NOT
' work with images BSAVEd directly from the video buffer.)  If the input
' file (first parameter on command-line) does not include an extension,
' ".GET" will be assumed.  Whatever you specify for the extension of the
' PCX output file (second parameter), it will be set to ".PCX" by the
' program.  If you don't specify a second parameter, your PCX file will
' have the same name as your "GET file" except for the extension.  (It
' might be a good idea if you didn't use an extension of ".PCX" on your
' GET file if you aren't going to specify a different second parameter!)
'
'  Upon running the program, it prompts you for the QB video mode that you
' used to make the Basic picture.  (Modes 1 and 2 aren't supported, but
' you be able to get away with specifying mode 11 if you're trying to
' convert mode 2 pictures.)
'
'  If, before running this program, you SET the DOS environment variable
' INVERSE to "ON", the PCX file will be generated in inverse video.
'
'$DYNAMIC
'
'  Process command-line.
'
CALL PARSE(COMMAND$," ",S1$,S2$)
CALL PARSE(S1$,".",GETFILE$,EXT$)
GETFILE$=RTRIM$(GETFILE$)
EXT$=LTRIM$(EXT$)
IF EXT$="" THEN EXT$="GET"
S2$=LTRIM$(S2$)
IF S2$="" THEN S2$=GETFILE$+".PCX"
GETFILE$=GETFILE$+"."+EXT$
CALL PARSE(S2$,".",PCXFILE$,EXT$)
PCXFILE$=RTRIM$(PCXFILE$)
PCXFILE$=PCXFILE$+".PCX"
ON ERROR GOTO NOFILE
OPEN GETFILE$ FOR INPUT AS #1
CLOSE #1
ON ERROR GOTO 0
'
'  Make various initializations.
'
DIM MODE AS INTEGER,BITS AS INTEGER,PLANES AS INTEGER,S AS STRING*1
DIM BYTES AS LONG,HRES AS INTEGER,VRES AS INTEGER,W AS INTEGER,H AS INTEGER
DIM COUNT AS LONG,RED AS INTEGER,BLUE AS INTEGER,GREEN AS INTEGER,I AS INTEGER
DIM BPROW AS INTEGER,J AS INTEGER,SLAST AS STRING*1,BYTE AS INTEGER
DIM CODEBYTE AS STRING*1
'
'  Input video mode used to generate GET file.
'
MODE=0
WHILE MODE<3 OR MODE>13 OR (MODE>4 AND MODE<7) OR MODE=10
INPUT "What QB mode was used to make the GET file (3, 4, 7 - 9, 11, 12, or 13)";MODE
WEND
'
'  For modes that support the 256K palette, screen needs to be in actual
' video mode used to generate GET file in order to read palette data.
'
IF MODE>11 THEN
ON ERROR GOTO NOSCREEN
SCREEN MODE
ON ERROR GOTO 0
END IF
'
'  Get header data from GET file and make sure it *is* a GET file.
'
OPEN GETFILE$ FOR BINARY AS #1
GET#1,,S
IF ASC(S)<>&HFD THEN CLOSE #1 : GOTO NOTGETFILE
'
'  Make various initializations for creation of PCX header.
'
IF MODE=13 THEN HRES=320 : VRES=200 : PLANES=1 : BITS=8
IF MODE=12 OR MODE=11 THEN HRES=640 : VRES=480 : PLANES=4 : BITS=4
IF MODE=3 THEN HRES=720 : VRES=348 : PLANES=1 : BITS=1
IF MODE=4  THEN HRES=640 : VRES=400 : PLANES=1 : BITS=1
IF MODE=7 THEN HRES=320 : VRES=200 : PLANES=4 : BITS=4
IF MODE=8 THEN HRES=640 : VRES=200 : PLANES=4 : BITS=4
IF MODE=9 THEN HRES=640 : VRES=350 : PLANES=4 : BITS=4
IF MODE=11 THEN PLANES=1 : BITS=1
GET #1,,X
GET#1,,S
BYTES=ASC(S)
GET#1,,S
BYTES=BYTES+256&*ASC(S)-4&
GET#1,,W
GET#1,,H
BPROW=PLANES*INT(CSNG(W+7)/8+.001)
IF CLNG(H)*CLNG(BPROW)<>BYTES THEN CLOSE #1 : GOTO NOTGETFILE
IF MODE=13 THEN W=W/8
W=W-1 : H=H-1
'
'  Delete old PCX file of same name as that being created.
'
ON ERROR GOTO NOPCX
OPEN PCXFILE$ FOR INPUT AS #2
CLOSE #2
KILL PCXFILE$
GOTO FILEDELETED
NOPCX:
RESUME FILEDELETED
FILEDELETED:
ON ERROR GOTO 0
'
'  Open PCX file and output header.
'
OPEN PCXFILE$ FOR BINARY AS #2
S=CHR$(10)
PUT#2,,S
S=CHR$(5)
PUT#2,,S
S=CHR$(1)
PUT#2,,S
S=CHR$(INT(CSNG(BITS)/PLANES+.001))
PUT#2,,S
S=CHR$(0)
FOR I=1 TO 4
PUT#2,,S
NEXT I
PUT#2,,W
PUT#2,,H
PUT#2,,HRES
PUT#2,,VRES
'
'  Define 16-color palette for modes 12 and 13.  (Well, to be honest, the
' palette is defined for lower modes too--the data is just set to zero.)
'
RED=0 : GREEN=0 : BLUE=0
FOR I=0 TO 15
IF MODE>11 THEN CALL PALREAD(I,RED,GREEN,BLUE)
S=CHR$(RED)
PUT#2,,S
S=CHR$(GREEN)
PUT#2,,S
S=CHR$(BLUE)
PUT#2,,S
NEXT I
'
'  Hercules and ATT/Olivetti modes are aliased in the PCX file as mode 11.
' (This isn't really important because this byte isn't used for anything;
' most PCX files just have a 0 for this byte.)
'
IF MODE=3 OR MODE=4 THEN S=CHR$(&H11)
'
'  Use bios modes, not QB mode integers.  (It works out that for QB modes
' 11 and above the QB mode integer is the same as the hexadecimal bios
' mode integer.)
'
IF MODE=9 THEN S=CHR$(&H10)
IF MODE>=11 THEN S=CHR$(VAL("&H"+LTRIM$(RTRIM$(STR$(MODE)))))
PUT#2,,S
S=CHR$(PLANES)
PUT#2,,S
BPROW=BPROW/PLANES
PUT#2,,BPROW
S=CHR$(1)
PUT#2,,S
S=CHR$(0)
FOR I=1 TO 59
PUT#2,,S
NEXT I
'
'  PCX header is generated.  Transfer graphics data to PCX file.
'
'  Input "starter byte."
'
GET#1,,SLAST
COUNT=1&
'
'  Get INVERSE environment variable.
'
INVERSE$=UCASE$(LTRIM$(RTRIM$(ENVIRON$("INVERSE"))))
GETBYTE:
'
'  J stores the number of identical bytes to be repeated when PCX file is
' read by PCX viewer.
'
J=1
IF COUNT<BYTES THEN
'
'  Look for up to 63 identical graphics bytes and store them as two bytes,
' one giving a counter and the second giving the byte to be repeated.
'
FOR I=2 TO 63
GET#1,,S
COUNT=COUNT+1&
IF S=SLAST THEN J=I
IF S<>SLAST THEN EXIT FOR
IF COUNT=BYTES THEN EXIT FOR
NEXT I
END IF
'
'  CODEBYTE may store the above mentioned counter, or it may not be used
' at all.
'
CODEBYTE=CHR$(192+J)
BYTE=ASC(SLAST)
IF INVERSE$="ON" THEN
'
'  Reverse bits.  (BYTE needs to be regenerated in this case so it can be
' used properly below.)
'
SLAST=CHR$(&HFF AND (NOT BYTE))
BYTE=ASC(SLAST)
END IF
'
'  If there's only one identical image byte in the sequence, the code
' byte isn't needed unless the byte > 191.
'
IF BYTE>191 OR J>1 THEN PUT#2,,CODEBYTE
PUT#2,,SLAST
'
'  If all 63 bytes input above are identical, a new starter byte is
' needed.
'
IF J=63 AND COUNT<BYTES THEN
GET#1,,SLAST
COUNT=COUNT+1&
'
'  If end of graphics data is at hand, loop isn't going to be repeated.
' Hence, output data now, before quitting.
'
IF COUNT=BYTES THEN
BYTE=ASC(SLAST)
IF INVERSE$="ON" THEN
SLAST=CHR$(&HFF AND (NOT BYTE))
BYTE=ASC(SLAST)
END IF
IF BYTE>191 THEN
CODEBYTE=CHR$(193)
PUT#2,,CODEBYTE
END IF
PUT#2,,SLAST
END IF
END IF
'
'  If all (less than 63) bytes input above aren't identical, starter byte
' is already available--it's the last byte input from the GET file.
'
IF J<63 THEN SLAST=S
IF COUNT<BYTES THEN GOTO GETBYTE
'
'  Image data is transferred; CLOSE GET file.
'
CLOSE #1
IF BITS=8 THEN
'
'  Process 256-color palette.
'
S=CHR$(12)
PUT#2,,S
FOR I=0 TO 255
CALL PALREAD(I,RED,GREEN,BLUE)
S=CHR$(RED)
PUT#2,,S
S=CHR$(GREEN)
PUT#2,,S
S=CHR$(BLUE)
PUT#2,,S
NEXT I
END IF
'
'  PCX file is generated; CLOSE it and quit.
'
CLOSE #2
IF MODE>11 THEN SCREEN 0
GOTO QUITPROG
NOFILE:
'
'  Input file wasn't specified.
'
PRINT
PRINT "Syntax:"
PRINT
PRINT "GET2PCX get_file pcx_file"
PRINT
PRINT "  (get_file has default .GET extension.  pcx_file will have .PCX extens";
PRINT "sion and"
PRINT "will have otherwise same name as get_file if you don't specify it.)"
PRINT
GOTO QUITPROG
NOSCREEN:
'
'  You don't have support for the video mode that generated the Basic
' image.
'
PRINT
PRINT "You don't have support for screen mode ";LTRIM$(RTRIM$(STR$(MODE)));"."
GOTO QUITPROG
NOTGETFILE:
'
'  You didn't specify a valid GET file.
'
PRINT
PRINT "  ";GETFILE$;" doesn't appear to be a standard QB 'GET file.'  ";
PRINT "(Perhaps you"
PRINT "specified a wrong video mode.)"
QUITPROG:
END
'
'  This subroutine parses as string S$ into the two strings S1$ and S2$
' based on the delimiter DL$.
'
SUB PARSE(S$,DL$,S1$,S2$)
SI$=LTRIM$(RTRIM$(S$))
N=LEN(SI$)
S1$=SI$
S2$=""
IF N=0 THEN GOTO TERM
I=INSTR(SI$,DL$)
IF I=0 THEN GOTO TERM
S1$=MID$(SI$,1,I-1)
S2$=MID$(SI$,I+LEN(DL$),N-I-LEN(DL$)+1)
TERM:
END SUB
'
'  This subroutine inputs attribute ATTRIB and returns the RED, GREEN,
' and BLUE color values that are currently assigned to ATTRIB via the
' color palette.  At least, that's what it does for QB modes 11 and above
' since they support the 256K-color RGB palette.  The RGB data can be
' converted to the actual assigned color via
'
'  PALCOL = RED + 256& * GREEN + 65536& * BLUE.
'
'  For lesser screen modes, the palette color itself is returned via the
' RED parameter.  All parameters passed to/from the routine are of INTEGER
' type.
'
'  Do not input a value for ATTRIB larger than allowed by the video mode
' (which you must set *before* calling this routine).  For SCREEN 11 and
' other monochrome modes, 0 <= ATTRIB <= 1.  For SCREEN 1 and 10, 0 <=
' ATTRIB <= 3.  For SCREEN 7 - 9 and 12, 0 <= ATTRIB <= 15.  For SCREEN 13,
' ATTRIB can be as large as 255.
'
'  The subroutine uses various functions and subfunctions of interrupt 10.
' (Do not get the erroneous idea that I am a machine code/ASM hotshot!
' Although the code works, I'm sure that any number of such true hotshots
' can/will tear this code to pieces!  <g>)
'
SUB PALREAD(ATTRIB AS INTEGER,RED AS INTEGER,GREEN AS INTEGER,BLUE AS INTEGER)
DIM MCODE(1 TO 14) AS LONG,CX AS INTEGER,DX AS INTEGER,OS AS INTEGER
DIM BX AS INTEGER,AX AS INTEGER,MODE AS INTEGER
'
'  Set up machine code routines.
'
DEF SEG=VARSEG(MCODE(1))
'
'  FOR READING 256K-COLOR/RGB PALETTE
'
OS=VARPTR(MCODE(1))
POKE OS,&HB8 : POKE OS+1,&H15 : POKE OS+2,&H10        'MOV AX,1015
POKE OS+3,&HBB : POKE OS+4,ATTRIB : POKE OS+5,0       'MOV BX,[ATTRIB]
POKE OS+6,&H55                                        'PUSH BP
POKE OS+7,&H89 : POKE OS+8,&HE5                       'MOV BP,SP
POKE OS+9,&HCD : POKE OS+10,&H10                      'INT 10
POKE OS+11,&H8B : POKE OS+12,&H5E : POKE OS+13,6      'MOV BX,[BP+6]
POKE OS+14,&H89 : POKE OS+15,&H17                     'MOV [BX],DX
POKE OS+16,&H8B : POKE OS+17,&H5E : POKE OS+18,8      'MOV BX,[BP+8]
POKE OS+19,&H89 : POKE OS+20,&HF                      'MOV [BX],CX
POKE OS+21,&H5D                                       'POP BP
POKE OS+22,&HCB                                       'RETF
'
'  FOR READING 16-COLOR PALETTE
'
OS=OS+23
POKE OS,&HB8 : POKE OS+1,7 : POKE OS+2,&H10           'MOV AX,1007
POKE OS+3,&HBB : POKE OS+4,ATTRIB : POKE OS+5,0       'MOV BX,[ATTRIB]
POKE OS+6,&H55                                        'PUSH BP
POKE OS+7,&H89 : POKE OS+8,&HE5                       'MOV BP,SP
POKE OS+9,&HCD : POKE OS+10,&H10                      'INT 10
POKE OS+11,&H89 : POKE OS+12,&HD8                     'MOV AX,BX
POKE OS+13,&H8B : POKE OS+14,&H5E : POKE OS+15,6      'MOV BX,[BP+6]
POKE OS+16,&H89 : POKE OS+17,7                        'MOV [BX],AX
POKE OS+18,&H5D                                       'POP BP
POKE OS+19,&HCB                                       'RETF
'
'  FOR GETTING VIDEO MODE
'
OS=OS+20
POKE OS,&HB8 : POKE OS+1,0 : POKE OS+2,&HF            'MOV AX,F00
POKE OS+3,&H55                                        'PUSH BP
POKE OS+4,&H89 : POKE OS+5,&HE5                       'MOV BP,SP
POKE OS+6,&HCD : POKE OS+7,&H10                       'INT 10
POKE OS+8,&H8B : POKE OS+9,&H5E : POKE OS+10,6        'MOV BX,[BP+6]
POKE OS+11,&H89 : POKE OS+12,7                        'MOV [BX],AX
POKE OS+13,&H5D                                       'POP BP
POKE OS+14,&HCB                                       'RETF
'
'  First, get video mode.  (It determines how palette is interpreted.)
'
CALL ABSOLUTE(AX,OS)
MODE=AX AND &HFF
'
'  Offset has to be set back by at least 20.
'
OS=OS-20
IF MODE<&H11 THEN
'
'  16-COLOR (OR LESS) MODE
'
'  Just get color value.
'
CALL ABSOLUTE(BX,OS)
'
'  Palette color is in BH.  Return it as RED in parameter list.
'
RED=(BX AND &HFF00)/256
ELSE
'
'  256-COLOR MODE
'
'  Get RGB data (after setting OS back to beginning of MCODE array).
'
OS=OS-23
CALL ABSOLUTE(CX,DX,OS)
'
'  Red is in DH, green is in CH, and blue is in CL.
'
RED=(DX AND &HFF00)/256
GREEN=(CX AND &HFF00)/256
BLUE=CX AND &HFF
END IF
DEF SEG
END SUB
