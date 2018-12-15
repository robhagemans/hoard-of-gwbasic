10 '           FIELD ROTATION
20 '
30 PI=ATN(1)*4: DR=PI/180: RD=180/PI
40 INPUT "Observer's latitude (deg) ";LA
50 LA=LA*DR: CL=COS(LA): SL=SIN(LA)
60 INPUT "Day of the month (1-31)";J
70 INPUT "Month (1-12) ";M
80 INPUT "Right ascension (h,m)   ";H5,M5
90 INPUT "Declination (deg)       ";DE
100 AD=H5+M5/60: DE=DE*DR: ' Hours and radians
110 SD=SIN(DE): CD=COS(DE): TD=SD/CD
120 GOSUB 650: PRINT
130 INPUT "From (h,m): ";H1,M1
140 T1=H1+M1/60: ' Starting time (hours)
150 INPUT "To (h,m):   ";H2,M2
160 T2=H2+M2/60: ' Ending time (hours)
170 IF T2<T1 THEN T2=T2+24: ' If crossing midnight
180 PRINT
190 PRINT "Positive rotation rates are clockwise:"
200 DU=60*(T2-T1)+.01: ' Exposure duration (min.)
210 FOR T=0 TO DU STEP 1
220    LT=T1+T/60: ' Local mean time (hours)
230    GOSUB 520: A=AZ
240    DD=SIN(AH): DS=(SL/CL)*CD-SD*CH
250    IF DS<>0 THEN 270
260    C=SGN(DD)*PI/2: GOTO 280: ' In case DS=0
270    C=ATN(DD/DS): IF DS<0 THEN C=C+PI
280    Q=C*RD: ' Parallactic angle in degrees
290    IF T<>0 THEN 310
300    Q0=Q: Q1=Q: ' Save initial value of Q
310    XX=Q-Q1: XT=Q-Q0
320    IF ABS(XX)<=180 THEN 340
330    XX=XX-360*SGN(XX): Q=Q-360*SGN(Q)
340    Q1=Q
350    IF T<>0 THEN GOSUB 470
360    IF T=0 THEN GOSUB 700
370    IF XT>MX THEN MX=XT
380    IF XT<MN THEN MN=XT
390 NEXT
400 PRINT: PRINT "Cumulative field rotation: ";
410 PRINT USING "####.## deg";MX-MN
420 PRINT
430 PRINT USING "Start alt.  ###    Az. ###";H0;A0
440 PRINT USING "Ending alt. ###    Az. ###";H;A
450 END
460 '
470 IF LT>=24 THEN LT=LT-24
480 PRINT USING " ##h ##m ";INT(LT);(LT-INT(LT))*60;
490 PRINT USING "    Rotation +###.## deg/min ";XX
500 RETURN
510 '     Compute hour angle, altitude, and azimuth
520 HD=15*(1.002737*LT+ST-AD): ' Hour angle (deg)
530 IF HD>=360 THEN HD=HD-360
540 AH=HD*DR: CH=COS(AH): SA=SL*SD+CL*CD*CH
550 IF ABS(SA)<1 THEN 580
560 IF ABS(SA)>1 THEN SA=1*SGN(SA)
570 H=SA*90: GOTO 590: ' If zenith or nadir
580 H=ATN(SA/SQR(1-SA*SA))*RD: ' Altitude (degrees)
590 A1=SIN(AH): A2=CH*SL-TD*CL: IF A2<>0 THEN 610
600 AZ=SGN(A1)*PI/2: GOTO 620: ' Special case A2=0
610 AZ=ATN(A1/A2): IF A2<0 THEN AZ=AZ+PI
620 AZ=AZ*RD+180: ' Azimuth in degrees from north
630 IF AZ>=360 THEN AZ=AZ-360
640 RETURN
650 '    Find approx. sidereal time at midnight
660 N=INT(275*M/9)-2*INT((M+9)/12)+J-30
670 ST=(6.61+.06571*N)/24
680 ST=(ST-INT(ST))*24: ' Express in hours
690 RETURN
700 '   Initialize values
710 MX=XX: MN=XX: A0=A: H0=H
720 RETURN
800 '   
810 '   ROTATE.BAS -- This program by Alphonse
820 '   Pouplier computes the rate at which 
830 '   the field will rotate for a telescope
840 '   whose polar axis is misaligned on the 
850 '   celestial pole.  This subject is discussed
860 '   in detail in Sky & Telescope, September
870 '   1992, page 318.
