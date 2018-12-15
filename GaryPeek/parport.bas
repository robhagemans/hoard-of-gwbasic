100 REM **********************************************************************
110 REM FILE NAME  - PARPRTIO.BAS
120 REM
130 REM LAST UPDATE - 1/18/03
140 REM
150 REM DESCRIPTION - DEMONSTRATES HOW TO READ AND WRITE THE IBM PC
160 REM               PARALLEL PORT HARDWARE DIRECTLY FOR USE AS
170 REM               LOGIC LEVEL INPUTS AND OUTPUTS
180 REM **********************************************************************
200 CLS
210 PRINT "1. LPT1"
220 PRINT "2. LPT2"
230 PRINT "3. LPT3"
240 PRINT
250 INPUT "WHICH PORT";P
260 IF P=1 THEN PORT$="LPT1":GOTO 400
270 IF P=2 THEN PORT$="LPT2":GOTO 400
280 IF P=3 THEN PORT$="LPT3":GOTO 400
290 CLS:END
300 REM -----
400 CLS
410 PRINT "1. DISPLAY INPUTS"
420 PRINT "2. OUTPUT A VALUE"
440 PRINT
450 INPUT "WHICH TEST";T
460 IF T=1 THEN 600
470 IF T=2 THEN 700
490 GOTO 200
500 REM -----
600 GOSUB 4000:REM READ INPUTS INTO "VALUE"
610 PRINT VALUE;"Dec ",HEX$(VALUE);" Hex",BIT7;BIT6;BIT5;BIT4;BIT3;BIT2;BIT1;BIT0
620 IN$=INKEY$:IF IN$=CHR$(27) THEN 400
630 GOTO 600
640 REM -----
700 CLS
710 INPUT "VALUE";V$
720 IF V$="" THEN 400
730 VALUE=VAL(V$)
740 GOSUB 2000:REM SEND "VALUE" TO PORT
750 GOTO 700
760 REM
1500 REM *********************************************************************
1510 REM ------------------- SEND VALUE TO PARALLEL PORT ---------------------
1520 REM
1530 REM The following subroutine provides direct access to the hardware
1540 REM of the parallel printer ports. It is not a printer driver, but a
1550 REM way of turning individual bits of a port ON and OFF. The outputs
1560 REM are logic level compatible and can drive external circuitry
1570 REM PROVIDED THE PROPER INTERFACING TECHNIQUES ARE USED.
1580 REM
1590 REM The following is a list of the output bits of a parallel printer
1600 REM port and their corresponding pins on the port connector.
1610 REM
1620 REM  SIGNAL  D7    D6    D5    D4    D3    D2    D1    D0     GND
1630 REM  BIT     7     6     5     4     3     2     1     0
1640 REM  PIN     9     8     7     6     5     4     3     2    18 to 25
1650 REM
1660 REM enter with - PORT$ = "LPT1", "LPT2", or "LPT3" to select port used
1670 REM              (LPT1, LPT2, and LPT3 are Printer #1, #2 and #3)
1680 REM              VALUE = 0 to 255, 8 bit value to send to port
1690 REM
2000 IF PORT$="LPT1" THEN OUTPORT=&H3BC
2010 IF PORT$="LPT2" THEN OUTPORT=&H378
2020 IF PORT$="LPT3" THEN OUTPORT=&H278
2030 OUT OUTPORT,VALUE:REM SEND VALUE TO PORT
2040 RETURN
2050 REM
2060 REM
3500 REM ********************************************************************
3510 REM ------------------ GET VALUE FROM PARALLEL PORT --------------------
3520 REM
3530 REM The following subroutine provides direct access to the hardware
3540 REM of the parallel printer ports. It is a way of reading the indi-
3550 REM vidual bits of a port which are at two separate addresses. The
3560 REM inputs are logic level compatible and can read external circuitry
3570 REM PROVIDED THE PROPER INTERFACING TECHNIQUES ARE USED.
3580 REM
3590 REM If a printer is connected to the port some of the signals from
3600 REM the first address reflect the status of certain printer signals.
3610 REM
3620 REM The following is a list of 8 input bits of a parallel printer
3630 REM port and their corresponding pins on the port connector.
3640 REM
3650 REM   ******************** INPUT FROM FIRST ADDRESS ********************
3660 REM                   ___                      _____
3670 REM   SIGNAL   BUSY   ACK   PAPER OUT  SELECT  ERROR
3680 REM   BIT       7     6        5         4       3     2     1     0
3690 REM   PIN       11    10       12       13      15    N/A   N/A   N/A
3700 REM
3710 REM   ******************* INPUT FROM SECOND ADDRESS ********************
3720 REM                                   _________   ____  _______  ______
3730 REM   SIGNAL                 IRQ EN   SELECT IN   INIT  AUTO LF  STROBE
3740 REM   BIT       7    6    5     4       3           2      1        0
3750 REM   PIN      N/A             N/A   17(not used)  16      14       1
3760 REM
3770 REM   *********************** COMBINED ADDRESSES ***********************
3780 REM   BIT      7     6      5      4     3     2     1     0     GND
3790 REM   PIN     11    10     12     13    15    16    14     1   18 to 25
3800 REM
3810 REM enter with - PORT$ = "LPT1", "LPT2", or "LPT3" to select port used
3820 REM              (LPT1, LPT2, and LPT3 are Printer #1, #2 and #3)
3830 REM exit with -  VALUE = 0 to 255, 8 bit value read from port
3840 REM              BIT7 through BIT0 = 0 or 1, individual bits from port
3850 REM
4000 IF PORT$="LPT1" THEN INPORTA=&H3BD:INPORTB=&H3BE
4010 IF PORT$="LPT2" THEN INPORTA=&H379:INPORTB=&H37A
4020 IF PORT$="LPT3" THEN INPORTA=&H279:INPORTB=&H27A
4030 MSB=(INP(INPORTA) AND 248)        :REM USE ONLY 5 MOST SIGNIFIGANT BITS 
4040 LSB=(INP(INPORTB) AND 7)          :REM USE ONLY 3 LEAST SIGNIFIGANT BITS
4050 VALUE=0:ALLBITS=(MSB OR LSB)      :REM COMBINE THE 8 BITS
4060 IF (ALLBITS AND 128)<>128 THEN BIT7=1:VALUE=VALUE+128 ELSE BIT7=0
4070 IF (ALLBITS AND 64)=64 THEN BIT6=1:VALUE=VALUE+64 ELSE BIT6=0
4080 IF (ALLBITS AND 32)=32 THEN BIT5=1:VALUE=VALUE+32 ELSE BIT5=0
4090 IF (ALLBITS AND 16)=16 THEN BIT4=1:VALUE=VALUE+16 ELSE BIT4=0
4100 IF (ALLBITS AND 8)=8 THEN BIT3=1:VALUE=VALUE+8 ELSE BIT3=0
4110 IF (ALLBITS AND 4)=4 THEN BIT2=1:VALUE=VALUE+4 ELSE BIT2=0
4120 IF (ALLBITS AND 2)<>2 THEN BIT1=1:VALUE=VALUE+2 ELSE BIT1=0
4130 IF (ALLBITS AND 1)<>1 THEN BIT0=1:VALUE=VALUE+1 ELSE BIT0=0
4140 RETURN
