100 REM ************************************************************
120 REM FILENAME     SLOWMOUS.BAS	SLOW DOWN THE MOUSE SPEED
130 REM WRITTEN BY   GARY PEEK
170 REM ************************************************************
200 PRINT "Reducing mouse sensitivity ..."
320 GOSUB 65250:REM LOAD ASSEMBLY LANGUAGE SUBROUTINE
400 GOSUB 63000:REM MOUSE RESET AND STATUS
490 XSENS=30:YSENS=30:THRESHOLD=70:GOSUB 64600:REM SET MOUSE SENSITIVITY
600 END
62270 REM ********************************************************************
62275 REM ------------------- MOUSE - RESET AND STATUS -----------------------
62280 REM
62285 REM exit with - STATUS = -1 if mouse found and reset, otherwise 0
62290 REM             BUTTONS = number of buttons
62295 REM
63000 REGAX%=0:REGBX%=0:REGCX%=0:REGDX%=0
63005 INTERRUPT%=&H33:GOSUB 65000:REM CALL ASM
63010 STATUS=REGAX%:BUTTONS=REGBX%
63015 RETURN
63020 REM
64565 REM ********************************************************************
64570 REM ------------------- MOUSE - SET SENSITIVITY ------------------------
64575 REM
64580 REM enter with - XSENS, YSENS = 1 to 100, horiz. and vert. sensitivity
64585 REM              THRESHOLD = 0 to 100, threshold for double speed
64590 REM
64595 REM
64600 REGAX%=26:REGBX%=XSENS:REGCX%=YSENS:REGDX%=THRESHOLD
64605 INTERRUPT%=&H33:GOSUB 65000:REM CALL ASM
64610 RETURN
64615 REM
64620 REM
64930 REM ********************************************************************
64935 REM ----------- SET UP AND CALL ASSEMBLY LANGUAGE SUBROUTINE -----------
64940 REM
64945 REM This routine sets up and calls a previously loaded general purpose
64950 REM assembly language subroutine to access DOS and other interrupts.
64955 REM Knowledge of how to call these interrupts is required. Interrupts
64960 REM that use only registers AX,BX,CX,DX are the only ones supported.
64965 REM
64970 REM enter with - REGAX%,REGBX%,REGCX%,REGDX%
64975 REM              (registers required for calling the interrupt)
64980 REM              INTERRUPT%, the interrupt to call
64985 REM exit with -  REGAX%,REGBX%,REGCX%,REGDX%
64990 REM              (registers after returning from the interrupt)
64995 REM
65000 DEF SEG=&H4B                         :REM POINT TO SEGMENT
65005 POKE 33,INTERRUPT%                   :REM FILL IN THE INTERRUPT TO CALL
65010 POKE 4,INT(REGAX%/256):POKE 3,REGAX% MOD 256  :REM FILL IN THE REGISTERS
65015 POKE 6,INT(REGBX%/256):POKE 5,REGBX% MOD 256
65020 POKE 8,INT(REGCX%/256):POKE 7,REGCX% MOD 256
65025 POKE 10,INT(REGDX%/256):POKE 9,REGDX% MOD 256
65030 REM ASMSUB=0:CALL ASMSUB          :REM USE THIS LINE FOR THE INTERPRETER
65035 CALL ABSOLUTE(0)              :REM USE THIS LINE FOR THE COMPILER
65040 REGAX=(PEEK(4)*256)+PEEK(3):IF REGAX>32767 THEN REGAX=REGAX-65536!
65045 REGAX%=REGAX
65050 REGBX=(PEEK(6)*256)+PEEK(5):IF REGBX>32767 THEN REGBX=REGBX-65536!
65055 REGBX%=REGBX
65060 REGCX=(PEEK(8)*256)+PEEK(7):IF REGCX>32767 THEN REGCX=REGCX-65536!
65065 REGCX%=REGCX
65070 REGDX=(PEEK(10)*256)+PEEK(9):IF REGDX>32767 THEN REGDX=REGDX-65536!
65075 REGDX%=REGDX
65080 DEF SEG:RETURN                    :REM RETURN TO BASIC SEGMENT
65085 REM
65090 REM
65095 REM ********************************************************************
65100 REM ---------------- LOAD ASSEMBLY LANGUAGE SUBROUTINE -----------------
65105 REM
65110 REM This routine loads the following general purpose assembly language
65115 REM subroutine to access DOS and other interrupts. It is loaded into
65120 REM the area just below the DOS inter-program communication area.
65125 REM
65130 REM               ASSUME  CS:CODE
65135 REM               JMP     HERE
65140 REM 
65145 REM        WORKA  DW      0               ;STORAGE FOR REGISTERS-
65150 REM        WORKB  DW      0               ;BASIC WRITES THESE,
65155 REM        WORKC  DW      0               ;THEN THE INTERRUPT% HAPPENS,
65160 REM        WORKD  DW      0               ;THEN BASIC READS THESE
65165 REM
65170 REM        HERE:	MOV	AX,WORKA        ;GET PARM 1 FROM BASIC
65175 REM        	MOV	BX,WORKB        ;GET PARM 2 FROM BASIC
65180 REM        	MOV	CX,WORKC        ;GET PARM 3 FROM BASIC
65185 REM        	MOV	DX,WORKD        ;GET PARM 4 FROM BASIC
65190 REM               PUSH    DS              ;MAKE ES THE SAME AS DS
65195 REM               POP     ES
65200 REM        	INT	21H             ;DOS (or other) INTERRUPT
65205 REM        	MOV	WORKA,AX        ;SEND PARM 1 TO BASIC
65210 REM        	MOV	WORKB,BX        ;SEND PARM 2 TO BASIC
65215 REM        	MOV	WORKC,CX        ;SEND PARM 3 TO BASIC
65220 REM        	MOV	WORKD,DX        ;SEND PARM 4 TO BASIC
65225 REM               DB      0CBH            ;ASSEMBLER REJECTS "RETF"
65230 REM
65235 REM               CODE ENDS
65240 REM               END
65245 REM
65250 DEF SEG=&H4B:RESTORE 65270
65255 FOR I=0 TO 53:READ B:POKE I,B:NEXT I
65260 DEF SEG:RETURN
65265 REM -----
65270 DATA &HEB,&H09,&H90
65275 DATA &H00,&H00,&H00,&H00,&H00,&H00,&H00,&H00       :REM REGISTERS AX-DX
65280 DATA &H2E,&HA1,&H03,&H00
65285 DATA &H2E,&H8B,&H1E,&H05,&H00
65290 DATA &H2E,&H8B,&H0E,&H07,&H00
65295 DATA &H2E,&H8B,&H16,&H09,&H00
65300 DATA &H1E,&H07
65305 DATA &HCD,&H21                                     :REM INTERRUPT% XX
65310 DATA &H2E,&HA3,&H03,&H00
65315 DATA &H2E,&H89,&H1E,&H5,&H0
65320 DATA &H2E,&H89,&H0E,&H07,&H00
65325 DATA &H2E,&H89,&H16,&H09,&H00
65330 DATA &HCB                                          :REM RETF
