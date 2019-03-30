' Electrical Calculations Version 1.3 by Bill Bowden 08/10/95
'
DIM s(24), s1(96)
DATA 10,11,12,13,15,16,18,20,22,24,27,30,33,36,39,43,47,51,56,62,68,75
DATA 82,91,100
s1data:
 DATA 100, 102, 105, 107, 110, 113, 115, 118, 121, 124, 127, 130, 133, 137
 DATA 140, 143, 147, 150, 154, 158, 162, 165, 169, 174, 178, 182, 187, 191
 DATA 196, 200, 205, 210, 215, 221, 226, 232, 237, 243, 249, 255, 261, 267
 DATA 274, 280, 287, 294, 301, 309, 316, 324, 332, 340, 348, 357, 365, 374
 DATA 383, 392, 402, 412, 422, 432, 442, 453, 464, 475, 487, 499, 511, 523
 DATA 536, 549, 562, 576, 590, 604, 619, 634, 349, 665, 681, 698, 715, 732
 DATA 750, 768, 787, 506, 825, 845, 866, 887, 909, 931, 953, 976,1000

FOR n = 0 TO 24: READ d: s(n) = d * 10: NEXT
RESTORE s1data: FOR n = 0 TO 96: READ d: s1(n) = d: NEXT
PI = 3.14159
digit$ = "#########.####": 'no. of digits and decimal places to display
b$ = CHR$(186)
b1$ = b$ + "          "
b2$ = b$ + "             "
resistor$ = "D8F3G7F7G7F7G3D8"
Capacitor$ = "D21NL10NR10BD8NL10NR10D21"
Inductor$ = "D8R5TA330R5TA300R5TA270R3TA240R5TA210R5TA180R5TA120R3TA60R3TA0R6T"
Inductor$ = Inductor$ + "A330R5TA300R5TA270R3TA240R5TA210R5TA180R5TA120R3TA60R"
Inductor$ = Inductor$ + "3TA0R6TA330R5TA300R5TA270R3TA240R5TA210R5TA180R5TA0D9"
short$ = "D50"
ON ERROR GOTO Invalid

Menu:
 r = 0: e = 0: i = 0: l = 0: c = 0: ii = 0: ei = 0: k = 0
 t = 0: n = 0: p = 0: f = 0: X = 0: q = 0: flag = 0
SCREEN 0
COLOR 15, 1
CLS
PRINT CHR$(201);
FOR n = 1 TO 78: PRINT CHR$(205); : NEXT
PRINT CHR$(187);
FOR n = 1 TO 23: PRINT b$; SPC(78); b$; : NEXT
LOCATE 25, 1
PRINT CHR$(200);
FOR n = 1 TO 78: PRINT CHR$(205); : NEXT
PRINT CHR$(188);
n = 0
LOCATE 3, 1
PRINT b1$; SPC(3); "Electrical Calculations  Ver 1.3 (Select option 1-9)"
PRINT
PRINT b1$; "1. Electrical laws and formulas."
PRINT b1$; "2. Voltage, current, resistance and power calculations."
PRINT b1$; "3. Resistors in series and parallel and standard values."
PRINT b1$; "4. Voltage dividers (2 or 3 element)."
PRINT b1$; "5. Reactance, resonance, and inductor Q factor."
PRINT b1$; "6. Instantaneous capacitor voltage (rise)."
PRINT b1$; "7. Instantaneous inductor current (rise)."
PRINT b1$; "8. Plot inductive response of series RLC circuit."
PRINT b1$; "9. Quit."
PRINT

WHILE 1
 GOSUB Waithere
 k = VAL(k$)
 ON k GOTO Formulas, Ohmslaw, Resistors, circuit, Xlr, Capacitor, Inductor, Plot, Exits
WEND
Exits:
 CLS
 SYSTEM

Formulas:
 CLS
 PRINT " Electrical laws and formulas:"
 PRINT
 PRINT " SI unit of electricity is the Coulomb (Q). One Coulomb per second = 1 Ampere"
 PRINT " Constant current verses capacitor voltage      Q = CE = IT"
 PRINT " Constant voltage verses inductor current       Q = LI = ET   (if inductor R=0)"
 PRINT " Energy stored in a capacitor (Joules)          J = 1/2 (C * E^2)"
 PRINT " Energy stored in a inductor (Joules)           J = 1/2 (L * I^2)"
 PRINT " Instantaneous inductor current (rise)          i = (E/R) *(1- e^((-T*R)/L))"
 PRINT " Instantaneous capacitor voltage (rise)        ei = E - (E * e^(-T/( R*C)))"
 PRINT " Decibel comparison - power dB = 10 Log (P2/P1), voltage dB = 20 Log (E2/E1)"
 PRINT " I (amperes) = E (volts) / R (ohms)  or         E = IR or R = E/I"
 PRINT " I (amperes) = P (watts) / E (volts) or         P = IE or P=I^2*R or P=E^2/R"
 PRINT " Total series resistance (Ohms)                Rt = R1+R2+R3+R4+..."
 PRINT " Total parallel resistance (Ohms)              Rt = 1/((1/R1)+(1/R2)+...)."
 PRINT " Total series inductance (Henrys)              Lt = L1+L2+L3+L4+..."
 PRINT " Total parallel inductance (Henrys)            Lt = 1/((1/L1)+(1/L2)+...)"
 PRINT " Total series capacitance (Farads)             Ct = 1/((1/C1)+(1/C2)+...)"
 PRINT " Total parallel capacitance (Farads)           Ct = C1+C2+C3+C4+..."
 PRINT " Inductive reactance  (Ohms)                   Xl = 2 * Pi * F * L"
 PRINT " Capacitive reactance (Ohms)                   Xc = 1/(2 * Pi * F * C)"
 PRINT " Series impedance (Ohms)                        Z = (R^2 + X^2)^.5"
 PRINT " Parallel impedance (Ohms)                      Z = R * X / (R^2 + X^2)^.5"
 PRINT " Resonant frequency  (Hertz)                    F = 1/(2 * Pi * (L*C)^.5)"
 LOCATE 25, 1
 PRINT "                             press any key for next";
 GOSUB Waithere
 CLS
 PRINT " Transformers:"
 PRINT " Transformer primary/secondary voltages        Es = (Ns/Np) * Ep"
 PRINT " Transformer primary/secondary currents        Ip = (Ns/Np) * Is"
 PRINT " Transformer power in verses power out     P(out) = efficiency factor * P(in)"
 PRINT " Ideal transformer impedance ratio             Zp = Zs * (Np/Ns)^2"
 PRINT
 PRINT " Conversion factors for fractional and multiple units:"
 PRINT " Kilo  = 1000       Mega  = 1,000,000      Giga = 1,000,000,000"
 PRINT " Milli = 1/1000     Micro = 1/1,000,000    Nano = 1/1,000,000,000"
 PRINT " Pico  = 1/1,000,000,000,000"
 PRINT
 PRINT " Relative resistance of metals compared to copper (copper=1)"
 PRINT " Aluminum = 1.6   Brass  = 3.7-4.9   Chromium = 1.8   Gold = 1.4    Iron = 5.7"
 PRINT " Lead     = 12.8  Nickel = 5.1       Silver   = 0.94  Tin  = 6.7    Zinc = 3.4"
 PRINT
 PRINT " Color codes: Black=0   Brown=1  Red=2    Orange=3  Yellow=4    Green=5  Blue=6"
 PRINT "              Violet=7  Gray=8   White=9  Gold=5%   Silver=10%  None=20%"
 PRINT " Third band is multiplier, BROWN,BLACK,ORANGE,GOLD = 10 * 10^3 = (10K) +/- 5%"
 PRINT
 PRINT " Copper wire table: Gauge / Turns per enamel inch / Resistance per 1000 ft."
 PRINT " 10/9.6/1.018    12/12/1.619     14/15/2.575     16/19/4.1       18/23.6/5.5"
 PRINT " 20/29.4/10.35   22/37/16.46     24/46.3/26.2    26/58/41.6      28/72.7/66.2"
 PRINT " 30/90.5/105     32/113/167      34/143/266      36/175/423      38/224/673";
 LOCATE 25, 1
 PRINT "                            press any key for Menu";
 GOSUB Waithere
GOTO Menu

Ohmslaw:
 COLOR 15, 1
 PRINT b2$; "Enter two known values. Press <ENTER> to skip the unknowns."
 PRINT
 PRINT b2$; "Voltage   (Volts) ="
 PRINT b2$; "Current    (Amps) ="
 PRINT b2$; "Resistance (Ohms) ="
 PRINT b2$; "Power     (Watts) ="
 Dline = 17: Dspace = 35: dout = 36: flag = 0

 LOCATE Dline, Dspace
 INPUT e
 GOSUB Ohms
 INPUT i
 GOSUB Ohms
 IF r = 0 THEN INPUT r: GOSUB Ohms
 IF p = 0 THEN INPUT p: GOSUB Ohms
 GOSUB Waithere
 GOTO Menu

Ohms:
 Dline = Dline + 1
 FOR Pass = 0 TO 1
  IF i > 0 AND r > 0 THEN e = i * r: p = i * e
  IF i > 0 AND e > 0 THEN r = e / i: p = (e * e) / r
  IF e > 0 AND r > 0 THEN i = e / r: p = (e * e) / r
  IF p > 0 AND r > 0 THEN i = (p / r) ^ .5: e = i * r
  IF e > 0 AND p > 0 THEN i = p / e
  IF i > 0 AND p > 0 THEN r = p / (i * i)
 NEXT Pass
 IF e > 0 THEN LOCATE 17, dout: PRINT USING digit$; e
 IF i > 0 THEN LOCATE 18, dout: PRINT USING digit$; i
 IF r > 0 THEN LOCATE 19, dout: PRINT USING digit$; r
 IF p > 0 THEN LOCATE 20, dout: PRINT USING digit$; p
 LOCATE Dline, Dspace
RETURN

Resistors:
 Dline = 17: Dspace = 12
 rp = 0
 rs = 0
 PRINT b1$; "   Enter resistor values. Press <ENTER> for totals."
 PRINT
 WHILE 1
  PRINT b1$;
  LOCATE Dline, Dspace
  n = n + 1: r$ = CHR$(82) + RIGHT$(STR$(n), LEN(STR$(n)) - 1): PRINT "   "; r$;
  INPUT r
  Dspace = Dspace + 14
  IF Dspace > 60 THEN Dspace = 12: Dline = Dline + 1
  IF r = 0 THEN
   IF rp = 0 THEN GOTO Menu
   rp = 1 / rp
   logp = LOG(rp) / LOG(10)
   logs = LOG(rs) / LOG(10)
   digitp = (rp * 10 ^ INT(-logp)) * 1000
   digits = (rs * 10 ^ INT(-logs)) * 1000
   pp = 0: ps = 0: sp = 0: ss = 0
   FOR n = 0 TO 95
     IF s1(n) <= digitp AND s1(n + 1) >= digitp AND pp = 0 THEN
       IF digitp < (s1(n) + s1(n + 1)) / 2 THEN pp = s1(n) ELSE pp = s1(n + 1)
     END IF

     IF s1(n) <= digits AND s1(n + 1) >= digits AND ps = 0 THEN
       IF digits < (s1(n) + s1(n + 1)) / 2 THEN ps = s1(n) ELSE ps = s1(n + 1)
     END IF
   NEXT n

   FOR n = 0 TO 23
     IF s(n) <= digitp AND s(n + 1) >= digitp AND sp = 0 THEN
       IF digitp < (s(n) + s(n + 1)) / 2 THEN sp = s(n) ELSE sp = s(n + 1)
     END IF
     IF s(n) <= digits AND s(n + 1) >= digits AND ss = 0 THEN
       IF digits < (s(n) + s(n + 1)) / 2 THEN ss = s(n) ELSE ss = s(n + 1)
     END IF
   NEXT n
   pp = (pp / 1000) / 10 ^ INT(-logp)
   ps = (ps / 1000) / 10 ^ INT(-logs)
   sp = (sp / 1000) / 10 ^ INT(-logp)
   ss = (ss / 1000) / 10 ^ INT(-logs)
   LOCATE Dline + 2, 1
   PRINT b1$; "   Total series -";
   PRINT USING digit$; rs;
   PRINT "   Total parallel -";
   PRINT USING digit$; rp
   PRINT b1$; "   Standard 5%  -";
   PRINT USING digit$; ss;
   PRINT "   Standard 5%    -";
   PRINT USING digit$; sp
   PRINT b1$; "   Standard 1%  -";
   PRINT USING digit$; ps;
   PRINT "   Standard 1%    -";
   PRINT USING digit$; pp
   GOSUB Waithere
   GOTO Menu
  END IF
  rp = rp + (1 / r)
  rs = rs + r
 WEND

circuit:
 DATA M,1E+6,K,1E+3,k,1E+3,m,1E-3,u,1E-6,n,1E-9,p,1E-12
 PRINT b2$; : INPUT "Frequency (Kilohertz) (0=DC)       "; f: f = f * 1000
 IF f <= 0 THEN f = 1E-20
 FOR n = 0 TO 2: FOR n1 = 0 TO 2: X(n, n1) = 0: NEXT: e(n) = 0: NEXT
 PRINT b2$; : INPUT "Source voltage (Volts) (Default=1) "; e(0)
 IF e(0) <= 0 THEN e(0) = 1
 FOR n = 0 TO 2
  PRINT b2$; "Component"; n + 1; " (examples R27, L50m, C.01u) ";
  INPUT Rx$(n)
  IF Rx$(n) = "" THEN c$(n) = short$
  IF Rx$(n) <> "" THEN GOSUB vector
 NEXT n
 Rx = X(0, 2) + X(1, 2) + X(2, 2)
 Cx = X(0, 1) + X(1, 1) + X(2, 1)
 Lx = X(0, 0) + X(1, 0) + X(2, 0)
 IF Rx + Cx + Lx = 0 THEN GOTO Menu
 i = e(0) / (((Lx - Cx) ^ 2) + (Rx ^ 2)) ^ .5
 Rx = Rx - X(0, 2)
 Cx = Cx - X(0, 1)
 Lx = Lx - X(0, 0)
 e(1) = i * (((Lx - Cx) ^ 2) + (Rx ^ 2)) ^ .5
 Rx = Rx - X(1, 2)
 Cx = Cx - X(1, 1)
 Lx = Lx - X(1, 0)
 e(2) = i * (((Lx - Cx) ^ 2) + (Rx ^ 2)) ^ .5

 SCREEN 1
 COLOR 1, 1
 Dline = 2: Dspace = 23
 DRAW "BM143,10"
 FOR n = 0 TO 2
 IF c$(n) <> short$ THEN
  DRAW "R20D1F2R2E2U2H2L2G2D1L20"
  LOCATE Dline, Dspace: PRINT USING "#####.####"; e(n);
  PRINT "  Volts"
  LOCATE Dline + 3, Dspace - 15: PRINT Rx$(n)
 END IF
 DRAW c$(n)
 Dline = Dline + 6
 NEXT n
 DRAW "NR20"
 LOCATE 21, 14: PRINT "  Common"
 LOCATE 23, 1
 PRINT USING "######.####"; f / 1000;
 PRINT " Khz.     ";
 PRINT USING "######.####"; i * 1000;
 PRINT " ma."
 GOSUB Waithere
 SCREEN 2
 GOTO Menu

vector:
 RESTORE circuit
 X = 1
 FOR n1 = 1 TO 7
   READ a$, ex
   IF a$ = RIGHT$(Rx$(n), 1) THEN X = ex
 NEXT n1
 p$ = UCASE$(LEFT$(Rx$(n), 1))
 IF p$ <> "R" AND p$ <> "L" AND p$ <> "C" THEN Rx$(n) = "R" + Rx$(n)
 value = VAL(RIGHT$(Rx$(n), LEN(Rx$(n)) - 1)) * X
 IF p$ = "L" THEN X(n, 0) = 2 * PI * f * value: c$(n) = Inductor$
 IF p$ = "C" THEN X(n, 1) = 1 / (2 * PI * f * value): c$(n) = Capacitor$
 IF p$ <> "L" AND p$ <> "C" THEN X(n, 2) = value: c$(n) = resistor$
RETURN

Xlr:
 PRINT b2$; "Enter known values. Press <ENTER> to skip the unknowns."
 PRINT
 PRINT b2$; "Inductance       (Millihenrys) ="
 PRINT b2$; "Capacity         (Microfarads) ="
 PRINT b2$; "Resonant Frequency (Kilohertz) ="
 PRINT b2$; "Reactance               (Ohms) ="
 PRINT b2$; "Inductor DC Resistance  (Ohms) ="
 PRINT b2$; "Inductor Q factor              ="
 Dline = 17: Dspace = 48: dout = 49: flag = 0

 LOCATE Dline, Dspace
 INPUT l
 l = l / 1000
 Dline = Dline + 1

 LOCATE Dline, Dspace
 INPUT c: c = c / 1000000: GOSUB Process
 IF flag = 0 THEN INPUT f: f = f * 1000: GOSUB Process
 IF flag = 0 THEN INPUT X: GOSUB Process
 INPUT r: GOSUB Process
 IF r = 0 OR X = 0 THEN INPUT q: GOSUB Process
 IF r = 0 AND X = 0 THEN GOTO Menu
 GOSUB Waithere
 GOTO Menu

Process:
 n = 0
 Dline = Dline + 1
 FOR Pass = 0 TO 1
  IF f > 0 AND l > 0 THEN X = 2 * PI * f * l: c = (1 / (2 * PI * f)) ^ 2 / l
  IF f > 0 AND c > 0 THEN X = 1 / (2 * PI * f * c): l = (1 / (2 * PI * f)) ^ 2 / c
  IF f > 0 AND X > 0 THEN c = 1 / (2 * PI * f * X): l = X / (2 * PI * f)
  IF l > 0 AND X > 0 THEN c = l / X ^ 2: f = X / (2 * PI * l)
  IF c > 0 AND X > 0 THEN l = X ^ 2 * c: f = 1 / (2 * PI * X * c)
  IF r > 0 AND X > 0 THEN q = X / r
  IF r > 0 AND q > 0 THEN X = q * r
  IF q > 0 AND X > 0 THEN r = X / q
  IF l > 0 AND c > 0 THEN f = 1 / (2 * PI * (l * c) ^ .5)
 NEXT Pass
 IF l > 0 THEN LOCATE 17, dout: PRINT USING digit$; l * 1000: n = n + 1
 IF c > 0 THEN LOCATE 18, dout: PRINT USING digit$; c * 1000000: n = n + 1
 IF f > 0 THEN LOCATE 19, dout: PRINT USING digit$; f / 1000: n = n + 1
 IF X > 0 THEN LOCATE 20, dout: PRINT USING digit$; X: n = n + 1
 IF r > 0 THEN LOCATE 21, dout: PRINT USING digit$; r
 IF q > 0 THEN LOCATE 22, dout: PRINT USING digit$; q
 IF n > 1 AND flag = 0 THEN flag = 1: Dline = 21
 LOCATE Dline, Dspace
RETURN

Inductor:
 PRINT b2$; "Enter 4 known values. Press <ENTER> to skip the unknown."
 PRINT
 PRINT b2$; "Inductance         (Millihenrys) ="
 PRINT b2$; "Resistance                (Ohms) ="
 PRINT b2$; "Steady State Current (Milliamps) ="
 PRINT b2$; "Time              (Milliseconds) ="
 PRINT b2$; "Instanteneous current (Milliamps)="
 Dline = 17: Dspace = 50: dout = 51: flag = 0

 LOCATE Dline, Dspace
 INPUT l: l = l / 1000
 LOCATE Dline + 1, Dspace
 INPUT r
 LOCATE Dline + 2, Dspace
 INPUT i: i = i / 1000
 LOCATE Dline + 3, Dspace
 INPUT t: t = t / 1000: GOSUB Solve
 IF ii = 0 THEN LOCATE Dline + 4, Dspace: INPUT ii: ii = ii / 1000: GOSUB Solve
 GOSUB Waithere
 GOTO Menu

Solve:
 IF l > 0 AND t > 0 AND i > 0 AND ii > 0 THEN r = (-l * (LOG((ii - i) / -i))) / t
 IF r > 0 AND l > 0 AND t > 0 AND i > 0 THEN ii = (i) * (1 - EXP((-t * r) / l))
 IF r > 0 AND t > 0 AND i > 0 AND ii > 0 THEN l = (-r * t) / LOG((ii - i) / (-i))
 IF r > 0 AND l > 0 AND i > 0 AND ii > 0 THEN t = (-l * (LOG((ii - i) / -i))) / r
 IF r > 0 AND t > 0 AND l > 0 AND ii > 0 THEN i = -ii / (EXP(-1 * (1 / (l / r)) * t) - 1)

 IF l > 0 THEN LOCATE 17, dout: PRINT USING digit$; l * 1000
 IF r > 0 THEN LOCATE 18, dout: PRINT USING digit$; r
 IF i > 0 THEN LOCATE 19, dout: PRINT USING digit$; i * 1000
 IF t > 0 THEN LOCATE 20, dout: PRINT USING digit$; t * 1000
 IF ii > 0 THEN LOCATE 21, dout: PRINT USING digit$; ii * 1000
RETURN

Capacitor:
 PRINT b2$; "Enter 4 known values. Press <ENTER> to skip the unknown."
 PRINT
 PRINT b2$; "Capacity           (Microfarads) ="
 PRINT b2$; "Resistance                (Ohms) ="
 PRINT b2$; "Supply Voltage           (Volts) ="
 PRINT b2$; "Time              (Milliseconds) ="
 PRINT b2$; "Instantaneous voltage    (Volts) ="
 Dline = 17: Dspace = 50: dout = 51: flag = 0
 LOCATE Dline, Dspace
 INPUT c: c = c / 1000000
 LOCATE Dline + 1, Dspace
 INPUT r
 LOCATE Dline + 2, Dspace
 INPUT e
 LOCATE Dline + 3, Dspace
 INPUT t: t = t / 1000: GOSUB Voltage
 IF ei = 0 THEN LOCATE Dline + 4, Dspace: INPUT ei: GOSUB Voltage
 GOSUB Waithere
GOTO Menu

Voltage:
 IF r > 0 AND c > 0 AND t > 0 AND e > 0 THEN ei = e - (e * EXP(-t / (r * c)))
 IF r > 0 AND c > 0 AND e > 0 AND ei > 0 AND t = 0 THEN t = -LOG((e - ei) / e) * r * c
 IF e > 0 AND c > 0 AND t > 0 AND ei > 0 AND r = 0 THEN r = -t / (LOG((e - ei) / e) * c)
 IF e > 0 AND r > 0 AND t > 0 AND ei > 0 AND c = 0 THEN c = -t / (LOG((e - ei) / e) * r)
 IF r > 0 AND c > 0 AND t > 0 AND ei > 0 AND e = 0 THEN e = -ei / (EXP(-(1 / (r * c)) * t) - 1)
 IF c > 0 THEN LOCATE 17, dout: PRINT USING digit$; c * 1000000
 IF r > 0 THEN LOCATE 18, dout: PRINT USING digit$; r
 IF e > 0 THEN LOCATE 19, dout: PRINT USING digit$; e
 IF t > 0 THEN LOCATE 20, dout: PRINT USING digit$; t * 1000
 IF ei > 0 THEN LOCATE 21, dout: PRINT USING digit$; ei
RETURN

Plot:
 CLS
 PRINT ""
 PRINT "     Test circuit is a series RLC with the signal applied to the capacitor"
 PRINT "     and the output taken across the LR components.  The R component is the"
 PRINT "     resistance of the inductor or a resistor in series with the inductor"
 PRINT "     or the sum of both. Coil capacitance is assumed zero. Output graph"
 PRINT "     represents the frequency response across the LR components from half"
 PRINT "     the frequency of resonance to twice the frequency of resonance."
 PRINT
 PRINT "           Input    <----| |------+------------> Output"
 PRINT "                          C       |"
 PRINT "                                  |"
 PRINT "                              Inductor"
 PRINT "                             Under Test"
 PRINT "                                  |"
 PRINT "                                  |"
 PRINT "           Common   <-------------+------------> Common"
 PRINT
 PRINT
 INPUT "     Enter coil inductance in millihenrys.    "; l: l = l / 1000
 INPUT "     Enter series capacitance in microfarads. "; c: c = c / 1000000
 INPUT "     Enter coil resistance in Ohms.           "; r
 IF r = 0 OR c = 0 OR l = 0 THEN GOTO Menu
 f = 1 / (2 * PI * (l * c) ^ .5)
 X = 2 * PI * f * l
 e = (1 / r) * X
 Peak = ((20 * LOG(e)) / LOG(10)) + 4
 max = 0
 Range = (2 * f) - .5 * f
 SCREEN 1
 COLOR 1, 1
 DRAW "BM15,0": DRAW "M15,190": DRAW "BM0,190"
 DRAW "M320,190": DRAW "BM15,200"
 LOCATE 24, 1: PRINT CLNG(0); "dB";
 LOCATE 25, 1: PRINT " .5F";
 LOCATE 25, 39: PRINT "2F";
 LOCATE 2, 30: PRINT "R="; CLNG(r);
 LOCATE 3, 29: PRINT "Fo="; CLNG(f);
 FOR Scale = .5 * f TO f * 2 STEP Range / 320
  xc = 1 / (2 * PI * Scale * c)
  xl = 2 * PI * Scale * l
  X = xc - xl
  zt = ((X ^ 2) + (r ^ 2)) ^ .5
  X = ((xl ^ 2) + (r ^ 2)) ^ .5
  e = (1 / zt) * X
  db = Peak - ((20 * LOG(e)) / LOG(10))
  IF e > max THEN max = e: fmax = Scale: smax = n
  n = n + 1
  p$ = "M" + STR$(n) + "," + STR$(CLNG((190 / Peak) * db))
  DRAW p$
 NEXT Scale

 LOCATE 25, 8
 db = (20 * LOG(max)) / LOG(10)
 j = (db / Peak) * 25
 j = CINT(25 - j)
 LOCATE j, 1: PRINT USING "###.##"; db;
 PRINT " dB";
 j = CINT((smax / 320) * 36)
 LOCATE 25, j
 PRINT CLNG(fmax); " Hz.";
 LOCATE 1, 30: PRINT "Q=";
 PRINT USING "###.#"; max
 GOSUB Waithere
 SCREEN 2
 GOTO Menu

Waithere:
 k$ = INKEY$
 IF k$ = "" THEN GOTO Waithere
RETURN

Invalid:
 SCREEN 2
 LOCATE 25, 12
 PRINT "Data invalid or out of range, press <ENTER> to resume.";
 GOSUB Waithere
RESUME Menu

