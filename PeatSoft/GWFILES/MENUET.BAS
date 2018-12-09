10 REM  from "Menuet", by Johann Sebastian Bach
20 REM *** PROGRAM BY  Susan K Baumann, Steven Mandell       ***
30 REM *** IN Q-BASIC PROGRAM BOOK    ***
40 REM *** GW-BASIC CONVERSION BY     ***
50 REM ***         KindlyRat  18 Feb 05              *** 
60 DIM MEASURE$(8)    
70 REM  Measure$ contains the notes to be
80 REM  played in each measure.
90 MEASURE$(1) = "O4 D4 O3 ML G A B O4 C"
100 MEASURE$(2) = "O4 D4 O3 MN G4 ML G4"
110 MEASURE$(3) = "O4 MN E4 ML C D E F#"
120 MEASURE$(4) = "O4 G4 O3 MN G4 ML G4"
130 MEASURE$(5) = "O4 MN C4 ML D C O3 B A"
140 MEASURE$(6) = "O3 MN B4 ML O4 C O3 B A G"
150 MEASURE$(7) = "O3 MN A4 ML B A G F#"
160 MEASURE$(8) = "G2. MN"
170 CLS
180 PRINT
190 PRINT " ***  An excerpt from 'Menuet', by Johann Sebastian Bach  ***"
200 PLAY "T180 L8 O3 MN"
210 FOR I = 1 TO 8
220  PLAY MEASURE$(I)
230 NEXT I
240 END
