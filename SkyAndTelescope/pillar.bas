10 REM PILLAR.BAS by Rodney Kubesh
20 SCREEN 12
30 REM Set Theta, the maximum angle of crystal tilt
40 TH = 4
50 REM Sun angle Alpha, varied from 6 deg.
60 REM above horizon to 6 deg. below horizon
70 FOR I = 0 TO 12
80 A = 6 - I
90 REM Calculate sky color
100 B& = 63 * (1 - .06 * I) : REM Blue
110 G& = 40 * (1 - .06 * I) : REM Green
120 R& = 45 * (1 - .06 * I) : REM Red
130 PALETTE 3, B& * 65536 + G& * 256 + R&
140 PAINT (320, 320), 3
150 IF A >= 0 THEN
160 HI = 2 * TH - A
170 LO = -(2 * TH + A)
180 END IF
190 IF A < 0 THEN
200 HI = 2 * TH + ABS(A)
210 LO = ABS(A) - 2 * TH
220 END IF
230 FOR AN = LO TO HI STEP .5
240 REM Draw the Sun
250 SU = 450 - (1000 * TAN(A * 3.14159 / 180))
260 CIRCLE (320, SU), 10, 1
270 PAINT (320, SU), 1, 1
280 SP = 450 - (1000 * TAN(AN * 3.14159 / 180))
290 PALETTE 1, 334143
300 CIRCLE (320, SP), 3, 1
310 PAINT (320, SP), 1, 1
320 REM Draw the ground
330 LINE (0, 450)-(639, 480), , BF
340 NEXT AN
350 REM Hold screen for one second, then clear it
360 SLEEP 1
370 IF I < 12 THEN CLS
380 NEXT I
390 END
900 REM  ---------------------------
910 REM  APPEARED IN ASTRONOMICAL
920 REM  COMPUTING, SKY & TELESCOPE,
930 REM  MAY 1999, PAGE 70
940 REM  ---------------------------
