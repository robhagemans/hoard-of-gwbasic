10 '         The Size of an Asteroid
20 '
30 RD=180/3.14159: ' Radians to degrees
40 INPUT "Apparent visual magnitude, V";V
50 INPUT "Distance from Sun (au)   ";R0
60 INPUT "Distance from Earth (au) ";D0
70 INPUT "Earth-Sun distance (au)  ";R
80 PRINT "Asteroid type --"
90 INPUT "    C, S, or O(ther)";T$
100 IF T$="c" OR T$="C" THEN P=.037
110 IF T$="s" OR T$="S" THEN P=.14
120 IF T$="o" OR T$="O" THEN INPUT "What is the albedo";P
130 IF P>1 OR P<=0 THEN 120
140 PRINT "Now enter the photometric slope"
142 PRINT "parameter (G), or if unknown"
143 INPUT "enter 0.15.  Value of G ";G
150 PRINT
160 CI=(R0^2+D0^2-R^2)/(2*R0*D0)
170 F=ATN(SQR(1-CI*CI)/CI)
180 IF CI<0 THEN F=F+3.14159
190 '    F = solar phase angle in radians
200 PRINT USING "Solar phase angle, phi:  ###.#";F*RD
210 P1=EXP(-3.33*(TAN(F/2))^.63)
220 P2=EXP(-1.87*(TAN(F/2))^1.22)
230 H=V-5*LOG(D0*R0)/LOG(10)+2.5*LOG((1-G)*P1+G*P2)/LOG(10)
240 PRINT USING "Absolute mag (H):    ###.#";H
250 LD=3.12-.2*H-.5*LOG(P)/LOG(10)
260 D=10^LD
270 PRINT USING "Diameter (km):  ####.#";D
280 END
290 '
300 '   Basil Rowe's program calculates the size of an asteroid from
310 '   its apparent brightness and an assumption about its reflectivity
320 '   (albedo).  The calculation is explained on page 83 of the
330 '   June 1993 issue of Sky & Telescope.  Carbonaceous asteroids 
340 '   have albedos of about 0.04, while S-type (stony) asteroids 
350 '   reflect about 0.14 of the light.
 