10 KEY OFF:CLS
20 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
30 PRINT"∞⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø∞"
40 PRINT"∞≥                                   ≥∞"
50 PRINT"∞≥            7029-A.BAS             ≥∞"
60 PRINT"∞≥      MEMORY SIZING ROUTINE        ≥∞"
70 PRINT"∞≥                                   ≥∞"
80 PRINT"∞≥                                   ≥∞"
90 PRINT"∞≥ BROUGHT TO YOU BY THE MEMBERS OF  ≥∞"
100 PRINT"∞≥      ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹‹      ≥∞"
110 PRINT"∞≥        €   €   € €     €   €      ≥∞"
120 PRINT"∞≥        €   €‹‹‹€ €     €   €      ≥∞"
130 PRINT"∞≥        €   €     €     €   €      ≥∞"
140 PRINT"∞≥      ‹‹€‹‹ €     €‹‹‹‹ €‹‹‹€      ≥∞"
150 PRINT"∞≥                                   ≥∞"
160 PRINT"∞≥      International PC Owners      ≥∞"
170 PRINT"∞≥                                   ≥∞"
180 PRINT"∞≥P.O. Box 10426, Pittsburgh PA 15234≥∞"
190 PRINT"∞≥                                   ≥∞"
200 PRINT"∞¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ∞"
210 PRINT"∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
220 PRINT
230 PRINT "       PRESS ANY KEY TO CONTINUE
240 A$=INKEY$: IF A$="" THEN 240
250 CLS
1000 REM   *** MEMORY SIZING ROUTINE ***
1010 '     COPYRIGHT (C) BY ROBERT BAER  FEBRUARY 5,1983
1020 '     IPCO MAY SELL FOR OWN SUPPORT
1030 '     THOSE WHO COPY REQUESTED TO DONATE $5.00 TO:
1040 '      International PC Owners, Inc.
1050 '      P.O. Box 10426
1060 '      Pittsburgh, PA. 15234
1070 '
1080 '     REQUIREMENTS: 64K MEMORY; ADDITIONAL MEMORY TO BE CONTIGUOUS.
1090 '      SET PLANAR SWITCHES FOR 64K SO SYSTEM IS READY IN SHORTEST TIME.
1100 '     THIS PROGRAM ALLOWS ONE TO "SYSGEN" ANY AMOUNT OF MEMORY FROM 64K
1110 '     TO MAXIMUM AVAILABLE, IN "1K" CHUNKS (WHERE 1K=1024 BYTES).
1120 '     NOTE THAT THE KEYBOARD CASE DOES NOT DROP TO LOWER(IF IN UPPER).
1130 '
1140 '
1150 DEF SEG=0 : POKE 8,&HC2 : 'KILL PARITY CHECK SYSTEM ZAPPER
1160 I=&H1000 : ' SETUP AND CHECK MEMORY IN 64K CHUNKS
1170 DEF SEG=I : J=PEEK(0) : POKE 0,0 : J=PEEK(0) : IF J<>0 THEN 1190
1180 I=I+&H1000 : IF I<>&HA000 THEN 1170 : 'SMALLEST STEP IS 64K!!!
1190 M=I/64 : DEF SEG : 'NOW KNOW MAX MEMORY AVAILABLE
1200 REM  SUBRT ' TO SIZE MEMORY(512K IS EXAMPLE DUMMY)
1210 DATA &HB8,&H40,&H00      :'MOV  AX,0040    SETUP
1220 DATA &H50                :'PUSH AX               REGISTER
1230 DATA &H1F                :'POP  DS                        DS
1240 DATA &HB8,&H34,&H12      :'MOV  AX,1234    FAKE
1250 DATA &HA3,&H72,&H00      :'MOV  [72],AX         KEYBOARD RESET
1260 DATA &HB8,&H00,&H02      :'MOV  AX,0200    LOAD
1270 DATA &HA3,&H15,&H00      :'MOV  [15],AX         512K ADDED MEMORY
1280 DATA &HB8,&H40,&H02      :'MOV  AX,0240    LOAD
1290 DATA &HA3,&H13,&H00      :'MOV  [13],AX         576K TOTAL MEMORY
1300 DATA &HBB,&HE0,&H0F      :'MOV  BX,0FE0    LOAD
1310 DATA &H53                :'PUSH BX              REGISTER
1320 DATA &H07                :'POP  ES                       ES
1330 DATA &H26                :'SEG  ES
1340 DATA &HFF,&H2E,&H21,&H00 :'JMP  L,[21]     SETUP NEW SIZE;RESET SYSTEM
1350 DATA &H22,&HE4,&H00,&HF0 :'                AT F000:E422
1360 REM  LOCATION IS 0:FE00
1370 DEF SEG=&HFE0 : SUBRT=0
1380 FOR I=0 TO 36 : READ J : POKE I,J : NEXT I
1390 PRINT "ENTER DESIRED MEMORY TO USE, FROM 64K TO";STR$(M);
1400 INPUT "K :",T$ : IF VAL(T$)<64 OR VAL(T$)>M THEN 1390
1410 GOSUB 1440 : POKE &H12,L : POKE &H13,H
1420 T=VAL(T$)-64 : T$=STR$(T) : GOSUB 1440 : POKE &HC,L : POKE &HD,H
1430 KEY OFF : CLS : LOCATE ,,1 : CALL SUBRT : DO IT!!!!
1440 REM
1450 T=VAL(T$) : H=INT(T/256) : L=T-H*256 : RETURN
1460 END
0 KEY OFF : CLS : LOCATE ,,1 : CALL SUBRT : DO IT!!!!
1440 REM
1450 T=VAL(T$)