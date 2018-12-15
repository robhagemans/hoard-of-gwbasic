100 REM  LOOKBAK2.BAS - May 2001; Updated Sept. 2003
110 REM  by Thomas A. Weil, taweil@aol.com
112 REM  Now handles user-specified values for both OmegaM and OmegaL.
114 REM  Includes some code from Ned Wright's Cosmology Calculator,
116 REM  http://www.astro.ucla.edu/~wright/CosmoCalc.html
120 INPUT "Enter Matter Density of the universe, OmegaM (0 - 2.0)"; OMG
130 IF OMG<0 OR OMG>2 GOTO 120
140 INPUT "Enter Cosmological Constant, OmegaL (0. - 1.0)"; LAM
150 IF LAM<0 OR LAM>1 GOTO 140
160 INPUT "Will you enter (A)ge of the universe or (H)ubble constant"; AH$
170 IF AH$="H" OR AH$="h" GOTO 210
180 IF AH$<>"A" AND AH$<>"a" GOTO 160
190 INPUT "Enter Age of the universe NOW in billions of years"; TN
200 TN=TN*1E+09 : HN=60 : M=8 : GOTO 220
210 INPUT "Enter Hubble constant in km/sec/Mpc"; HN : M=1
212 REM  N is the number of iterations to be used in each FOR-NEXT.
214 REM  Ned Wright's Cosmology Calculator uses N=1000, but N=200
216 REM  is faster and still seems to be quite accurate.
218 REM  HFAC converts the Hubble constant to units of km/sec/Mpc from speed
219 REM  as a fraction of the speed of light per light year of distance.
220 N=200 : DELTA=.0000001 : HFAC=9.7782E+11 : E=2.718282 : PARSEC=3.2616
222 REM  For user-specified TN, we now calculate HN, but since ORD depends
224 REM  on HN, we need to iterate AgeFac until the results converge.
226 REM  AgeFac is the factor to multiply the inverse of the Hubble
228 REM  constant by to determine the age of the universe.
230 FOR J=1 TO M
232 REM  OMC is Omega(Curvature); OMC=0 gives us a "flat" universe.
234 REM  ORD is Omega(Radiation), which is radiation pressure, which was a
236 REM  major contributor to expansion when the universe was very young.
240 ORD=.4165/(HN*HN) : OMC=1-OMG-LAM-ORD : Z=5 : AZ=1/(1+Z) : AA=0
242 REM  Calc. age at redshift Z, and lookback time, and add them to get Age
244 REM  Now (TN).  For this calculation we assume Z=5, but any value would do.
250 TRS=0 : TLB=0 : FOR I=1 TO N : A=AZ*(I-.5)/N : AA=AZ+(1-AZ)*(I-.5)/N
260 TRS=TRS+1/SQR(OMC+(OMG/A)+(ORD/(A*A))+(LAM*A*A))
270 TLB=TLB+1/SQR(OMC+(OMG/AA)+(ORD/(AA*AA))+(LAM*AA*AA)) : NEXT I
280 AGEFAC=TLB/N*(1-AZ)+TRS/N*AZ
290 IF AH$="H" OR AH$="h" GOTO 310
300 HN=AGEFAC/TN*HFAC
310 NEXT J
320 TN=AGEFAC/HN*HFAC
330 INPUT "Will you enter (T)ime THEN or (R)edshift of the light we see NOW"; TR$
340 IF TR$="R" OR TR$="r" GOTO 470
350 IF TR$<>"T" AND TR$<>"t" GOTO 330
360 INPUT "Enter Age of the universe THEN, in billions of years"; TTT
370 TTT=TTT*1E+09 : IF TTT>299999 GOTO 410
380 PRINT
390 PRINT " You cannot see back to a time earlier than about 300,000 years"
392 REM     My first article in S&T, Sept. 1997, page 59, explains why.
400 PRINT : GOTO 330
410 PRINT " Finding what redshift matches Age THEN ......" : Z=(TN-TTT)/TN
420 AZ=1/(1+Z) : TRS=0 : FOR I=1 TO N : A=AZ*(I-.5)/N
430 TRS=TRS+1/SQR(OMC+OMG/A+ORD/(A*A)+LAM*A*A) : NEXT I
440 TT=TRS/N*HFAC/HN*AZ : TOL=TOL+DELTA
450 IF TT/TTT>1-TOL AND TT/TTT<1+TOL GOTO 480
452 REM  If Time Then (TT) doesn't match yet, adjust Z accordingly
460 Z=Z*(.2+.8*TT/TTT) : GOTO 420
470 INPUT "Enter redshift value for the light we see NOW"; Z
472 REM  Calculate Distances
480 DCMR=0 : AZ=1/(1+Z) : FOR I=1 TO N
490 A=AZ+(1-AZ)*(I-.5)/N : ADOT=SQR(OMC+(OMG/A)+(ORD/(A*A))+(LAM*A*A))
500 DCMR=DCMR+1/(A*ADOT) : NEXT I
510 DCMR=(1-AZ)*DCMR/N : X=SQR(ABS(OMC))*DCMR : IF X<=.1 GOTO 550
520 IF OMC>0 GOTO 540
530 RATIO=SIN(X)/X : GOTO 580
540 RATIO=.5*(E^X-E^(-X))/X : GOTO 580
550 Y=X*X : IF OMC>=0 GOTO 570
560 Y=(-Y)
570 RATIO=1+Y/6+Y*Y/120
580 DL=AZ*RATIO*DCMR/(AZ*AZ)*977.82/HN : DN=DL/(1+Z) : DT=DN/(1+Z)
582 REM  Calculate Time Then (TT) at redshift Z
590 AZ=1/(1+Z) : AGE=0 : FOR I=1 TO N
600 A=AZ*(I-.5)/N : AGE=AGE+1/SQR(OMC+OMG/A+ORD/(A*A)+LAM*A*A) : NEXT I
610 TT=HFAC/HN*AZ*AGE/N : TV=TN-TT : DMOD=5*.4343*LOG(DL*1E+09/(10*PARSEC))
620 IF TT<300000 GOTO 380
630 HT=HN*SQR(OMG*(1+Z)^3+(1-OMG-LAM-ORD)*(1+Z)^2+LAM+ORD*(1+Z)^4)
640 ST=HT*DT/977.82 : SC=Z+1 : SN=HN*DN*1E+09/HFAC
650 PRINT USING "Age Factor NOW  (Age=Fac/H0) = ##.####";AGEFAC
660 PRINT USING "Age of the universe NOW  =####.#### billion years"; TN/1E+09
670 PRINT USING "Age of the universe THEN =####.#### billion years"; TT/1E+09
680 PRINT USING "Light travel time        =####.#### billion years"; TV/1E+09
690 PRINT USING "Redshift of the light we see NOW      =#####.###"; Z
700 PRINT USING "Scale of the universe NOW versus THEN =#####.###"; SC
710 PRINT USING "Distance of object THEN =  #####.### billion light-years"; DT
720 PRINT USING "Distance of object NOW  = ######.### billion light-years"; DN
730 PRINT USING "Luminosity Distance NOW =#######.### billion light-years"; DL
740 PRINT USING "Distance Modulus     = ######.###"; DMOD
750 PRINT USING "Speed away from us THEN =####.### x speed of light*"; ST
760 PRINT USING "Speed away from us NOW  =####.### x speed of light*"; SN
770 PRINT USING "Hubble constant THEN   =########.## km/sec/megaparsec"; HT
780 PRINT USING "Hubble constant NOW    =########.## km/sec/megaparsec"; HN
790 PRINT " * Not the object's own speed, but caused by the expansion of space."
800 END
900 REM  ---------------------------
910 REM  APPEARED IN COMPUTERS IN ASTRONOMY,
920 REM  SKY & TELESCOPE, AUGUST 2001, PAGE 62.
930 REM  Corrections made Sept. 2003 to lines 232, 550, and 630, with
932 REM  many thanks to Bruce Nelson, a great mathematician whose hobby
934 REM  is cosmology and who decided to re-derive all these equations!
936 REM  The updates give smoother results when OMC is small and more
938 REM  accurate results for HT and ST for very large values of Z.
940 REM  ---------------------------
950 REM ** SAMPLE RUN, for OmegaM=.35, OmegaL=.65, H0=61, and Z=1.7 **
960 REM Enter Matter Density of the Universe, OmegaM (0 - 2.0)? .35
970 REM Enter Cosmological Constant, OmegaL (0. - 1.0)? .65
980 REM Will you enter (A)ge of the universe or (H)ubble constant? H
990 REM Enter Hubble constant in km/sec/Mpc? 61
1000 REM Will you enter (T)ime THEN or (R)edshift of the light we see NOW? R
1010 REM Enter redshift value for the light we see NOW? 1.7
1020 REM Age Factor NOW  (Age=Fac/H0) =  0.9226
1030 REM Age of the universe NOW  =  14.7887 billion years
1040 REM Age of the universe THEN =   4.0054 billion years
1050 REM Light travel time        =  10.7833 billion years
1060 REM Redshift of the light we see NOW      =    1.700
1070 REM Scale of the universe NOW versus THEN =    2.700
1080 REM Distance of object THEN =      6.292 billion light-years
1090 REM Distance of object NOW  =     16.987 billion light-years
1100 REM Luminosity Distance NOW =     45.865 billion light-years
1110 REM Distance Modulus     =     45.741
1120 REM Speed away from us THEN =   1.078 x speed of light*
1130 REM Speed away from us NOW  =   1.060 x speed of light*
1140 REM Hubble constant THEN   =     167.55 km/sec/megaparsec
1150 REM Hubble constant NOW    =      61.00 km/sec/megaparsec
1160 REM  * Not the object's own speed, but caused by the expansion of space.
