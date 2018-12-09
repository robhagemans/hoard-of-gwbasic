1 '*********************************************************************
2 '*   PC-MAP.  This program recreates a PC-File database into a new   *
3 '*            Format. Fields may be added or deleted, renamed,       *
4 '*            rearranged, and lengthened or shortened. Output is a   *
5 '*            Data file and Header file.  After using PC-File to     *
6 '*            sort the file (thus creating a new index), the new     *
7 '*            database is ready to go.                               *
8 '*            (1982) by F. Neil Lamka.                               *
9 '*********************************************************************
10 DEFINT A-Z:COMMON F$,DL,XL,NR
20 CLS:RC=80
25 ERCOUNT = 0
30 FALSE=0:TRUE=1
40 MC=RC\2:F9=RC\2+2
50 SCREEN 0,0:COLOR 7,0
60 WIDTH RC:KEY OFF
70 DIM OFM$(42),OFL(42) 'set up arrays for field names and lengths
80 DIM NFM$(42),NFL(42) 'set up arrays for new data base
90 CLS:LOCATE 10,MC-9:PRINT"PC-MAP Version 1.4";
95 LOCATE 12,MC-17:PRINT"A PC-FILE Data Base Conversion Aid";
100 LOCATE 14,MC-11:PRINT"(1982) F. Neil Lamka"
110 DR$="Which drive (ABCD) contains the origional data base? "
120 CL = 0
130 UC=1:GOSUB 20000
140 IF DR$<"A" OR DR$>"D" GOTO 110
150 OF$ = DR$+":"   'set file name for old data base
155 TF$=OF$
160 DR$="Which drive (ABCD) will contain the new data base? "
170 CL = -3 'set value for message color (15-3)
180 UC=1:GOSUB 20000
190 CL = 0 'reset line color value
200 IF DR$<"A" OR DR$>"D" GOTO 160
210 NF$ = DR$+ ":"  'set file name for new data base
220 ON ERROR GOTO 250
230 CLS:LOCATE 5,1:PRINT"Choose one of these files to convert:"
240 FILES OF$+"*.HDR":GOSUB 30000:ON ERROR GOTO 0:GOTO 260
250 RESUME 260
260 DR$="Which file:":UC=1:GOSUB 20000
270 IF DR$="" THEN 260 ELSE OF$ = TF$ + DR$ 'set file name to be used
280 ON ERROR GOTO 330
290 VL$=".HDR":FILES OF$+VL$ 'see if the hdr file exists
300 VL$=".DTA":FILES OF$+VL$ 'see if the data file exists
310 ON ERROR GOTO 0
320 CLS:GOTO 360  'go get new file name
330 RESUME 340
340 ON ERROR GOTO 0:DR$=OF$+VL$+" does not exist...please respecify: "
341 CL=-4:UC=1:SOUND 500,9:GOSUB 20000:CL=0
342 IF DR$="" THEN 260 ELSE OF$=TF$+DR$
350 GOTO 280
360 TF$=NF$
365 DR$="Enter name for new data base: ":CL= -3:UC=1:GOSUB 20000
370 IF DR$="" THEN 360 ELSE NF$=NF$+DR$ 'set new data base name
375 IF NF$=OF$ THEN DR$="INVALID NAME - SAME AS THE FIRST ONE - RESPECIFY ":NF$=TF$:UC=1:CL=-4:SOUND 500,4:GOSUB 20000:CL=0:GOTO 370
380 ON ERROR GOTO 440
400 VL$=".HDR":FILES NF$+VL$ 'see if a hdr file exists
410 CLS:DR$=NF$+VL$+" already exists...respecify or hit ENTER to reuse: "
415 ON ERROR GOTO 0
420 UC=1:CL=-4:SOUND 500,4:GOSUB 20000:CL=0
430 IF DR$="" THEN KILL NF$+VL$:GOTO 450 ELSE NF$=TF$+DR$:GOTO 380
440 RESUME 450 'if we get here then the files did not exist
450 ON ERROR GOTO 0
452 ON ERROR GOTO 462:VL$=".DTA":FILES NF$+VL$
454 CLS:DR$=NF$+VL$+" already exists...respecify or hit ENTER to reuse: "
456 ON ERROR GOTO 0
458 UC=1:CL=-3:SOUND 500,9:GOSUB 20000:CL=0
460 IF DR$="" THEN KILL NF$+VL$:GOTO 464 ELSE NF$=TF$+DR$:GOTO 380
462 RESUME 464 'files did not exist if we are here
464 ON ERROR GOTO 0
500 REM All files have been verified...now start the work
510 ODL=0:ODF=0 'set record length and number of entries in old db
520 NDL=0:NDF=0 'set record length and number of entries in new db
530 CLS
540 PRINT"Reading origional data base records ";MID$(OF$,3)
550 OPEN"i",#1,OF$+".HDR"  'open old header file
560 WHILE NOT EOF(1)       'read old data base header description
570 INPUT#1,TS$:ODF =ODF + 1:OFM$(ODF) = TS$ 'read label
580 INPUT#1,OFL(ODF):ODL = ODL + OFL(ODF)
590 WEND 'end of the loop
595 CLOSE#1 'done with the old header file
600 CLS:LOCATE 2,1:PRINT "Origional Data Base Fields";
602 LOCATE 3,1:PRINT OF$+".HDR";
605 LC=4:MAXLEN = 0
610 LOCATE LC,1
620 FOR I = 1 TO ODF
630 IF OFL(I) > MAXLEN THEN MAXLEN=OFL(I)
635 LOCATE LC+I,1:PRINT OFM$(I);:PRINT,USING" ###";OFL(I)
640 NEXT I
650 IF MAXLEN+3+2 <= 40 THEN NEXTFIELD=40 ELSE NEXTFIELD=0
700 LOCATE 1,1:COLOR 12,0:SOUND 800,4:PRINT"Enter values for the new headers";
703 LOCATE 2,NEXTFIELD:COLOR 15,0:PRINT"New Data Base fields";
705 LOCATE 3,NEXTFIELD:PRINT NF$+".HDR";
710 ATLINE = 1:NDF=0:NEWEND = FALSE
715 CURMAX = 12:COLOR 15,0
720 WHILE NEWEND = FALSE
725 IF ATLINE+LC >24 THEN GOSUB 10000:ATLINE = 1
730 LOCATE ATLINE+LC,NEXTFIELD
740 LINE INPUT;"";TS$:IF TS$="" THEN NEWEND=TRUE:GOTO 750 ELSE NDF=NDF+1:NFM$(NDF) = TS$
741 IF LEN(NFM$(NDF)) > 12 THEN NFM$(NDF)=LEFT$(NFM$(NDF),12):LOCATE ATLINE+LC,NEXTFIELD:PRINT NFM$(NDF)+SPACE$(LEN(TS$)-12);
745 ATLINE = ATLINE + 1
750 WEND:COLOR 7,0
752 DR$="Is this HDR information correct (Y or N)? ":UC=1:CL=0:GOSUB 20000
753 IF DR$="" THEN 752 ELSE IF DR$ = "N" THEN GOSUB 40000:GOTO 710 ELSE IF DR$ <> "Y" THEN 752
759 NDL=0:LOCATE 1,1:PRINT"                                 "
760 LOCATE 1,40:COLOR 12,0:PRINT"Enter the width of each field    ";:COLOR 4,0
765 SOUND 800,5
770 FOR I = 1 TO NDF
780 LOCATE LC+I,NEXTFIELD+CURMAX+1
790 LINE INPUT;"";TS$:NFL(I)=VAL(TS$):NDL=NDL+NFL(I)
792 IF NFL(I) = 0 THEN LOCATE 25,1:PRINT"Spceified field length is not valid..Please reenter";:SOUND 500,9:GOTO 780
795 LOCATE LC+I,NEXTFIELD+CURMAX+1:PRINT,USING"###";NFL(I)
796 LOCATE 25,1:PRINT"                                                    ";
800 NEXT I
802 DR$="Is this field width information correct (Y or N)? ":UC=1:CL=0:GOSUB 20000
803 IF DR$="" THEN 802 ELSE IF DR$ = "N" THEN GOSUB 50000:GOTO 759 ELSE IF DR$ <> "Y" THEN 802
810 COLOR 7,0
900 CLS 'now that the data fields have been defined...we need relationships
910 LOCATE 1,1:PRINT"Define field relationship values";
920 LOCATE 2,1:PRINT"For each field in the new data base indicate the";
930 LOCATE 3,1:PRINT"corresponding old data base field number or 0";
940 LOCATE 4,1
950 FOR I = 1 TO NDF 'output new data fields
960 LOCATE 4+I,1:PRINT NFM$(I);
980 NEXT I
990 FOR I = 1 TO ODF 'output old data base fields
1000 LOCATE 4+I,50:PRINT OFM$(I)
1005 LOCATE 4+I,30:PRINT,USING"###";I;
1010 NEXT I
1015 DIM FR(42) 'set the size of the relationship matrix to the # of data flds
1020 FOR I = 1 TO NDF 'get field relationship value
1030 LOCATE 4+I,25
1040 LINE INPUT;"";TS$:IF TS$ = "" THEN 1030
1050 IF (VAL(TS$) > ODF) OR (VAL(TS$) < 0) THEN LOCATE 25,1:PRINT"Invalid field relationship specified";:SOUND 500,9:GOTO 1030
1060 LOCATE 25,1:PRINT"                                    ";
1070 FR(I) = VAL(TS$) 'set the field relationship matrix value
1080 NEXT I
1082 DR$="Are these field relationships correct (Y or N)? ":CL=0:UC=1:GOSUB 20000
1084 IF DR$="" THEN 1082 ELSE IF DR$="N" THEN GOSUB 60000:GOTO 1020 ELSE IF DR$ <> "Y" THEN 1082
1100 CLS 'now we have all we need to remap the data base
1110 DIM OFILE$(42),NFILE$(42) 'set up to map the data base
1120 CLS:PRINT"Writing new HDR file ";:COLOR 12,0
1130 PRINT NF$+".HDR":COLOR 7,0
1140 OPEN"o",#1,NF$+".HDR"
1150 FOR I = 1 TO NDF 'loop until end of header info
1160 PRINT#1,NFM$(I) 'write out the header name
1170 PRINT#1,NFL(I)  'write out the field lenght
1180 NEXT I
1190 CLOSE#1         'close the new header file
1200 PRINT"New Header file created"
1210 REM open the DTA data sets for processing
1220 OPEN"r",#2,OF$+".DTA",ODL+1
1230 FIELD#2,ODL AS ODF$          'set up a field for direct read
1240 OPEN"r",#3,NF$+".DTA",NDL+1
1250 FIELD#3,NDL AS NDF$          'this will be the outputfield
1260 X = 1 'set initial record number
1265 FEND = FALSE
1270 WHILE FEND = FALSE  'read until \ record found in data base
1280 GET#2,X  'read record from the old data base
1290 IF LEFT$(ODF$,1) = "\" THEN FEND=TRUE:DR$="\":GOTO 1400
1295 'IF LEFT($(ODF$,2)="//" THEN GOTO 1408  check for deleted record
1300 CPOS = 1 'map old data record to array
1310 FOR I = 1 TO ODF
1320 OFILE$(I)=MID$(ODF$,CPOS,OFL(I)):CPOS=CPOS+OFL(I)
1330 NEXT I
1340 FOR J = 1 TO NDF
1350 IF FR(J)=0 THEN NFILE$(J)=SPACE$(NFL(J)):GOTO 1372
1362 IF NFL(J)<=OFL(FR(J)) THEN NFILE$(J)=LEFT$(OFILE$(FR(J)),NFL(J)):GOTO 1372
1364 IF NFL(J)>OFL(FR(J)) THEN NFILE$(J)=OFILE$(FR(J))+SPACE$(NFL(J)-OFL(FR(J)))
1372 NEXT J
1375 DR$=""
1376 FOR K=1 TO NDF:DR$=DR$+LEFT$(NFILE$(K),NFL(K)):NEXT K
1400 LSET NDF$=DR$:PUT#3,X       'write the new record
1401 CLS:LOCATE 1,1:PRINT"Processing record number(",X,")";
1402 LOCATE 2,1:PRINT"New File Record";
1403 LOCATE 2,40:PRINT"Old File Record";
1406 FOR K = 1 TO NDF:LOCATE 3+K,1:PRINT NFILE$(K);:NEXT K
1407 FOR K = 1 TO ODF:LOCATE 3+K,40:PRINT OFILE$(K);:NEXT K
1408 X=X+1
1410 WEND
1420 CLOSE#2:CLOSE#3
1500 CLS 'output final file stats
1510 LOCATE 8,28:PRINT"File conversion complete";
1520 LOCATE 9,28:PRINT"Data Base Statistics are";
1530 LOCATE 11,1 :PRINT"Origional Data Base = ";:LOCATE 11,30:PRINT OF$;
1550 LOCATE 12,1:PRINT"Origional number of fields = ";:LOCATE 12,30:PRINT ODF;
1552 LOCATE 13,1:PRINT"Record Length = ";:LOCATE 13,30:PRINT ODL;
1555 COLOR 15,0
1560 LOCATE 15,1:PRINT"New Data Base = ";:LOCATE 15,30:PRINT NF$;
1570 LOCATE 16,1:PRINT"New number of fields = ";:LOCATE 16,30:PRINT NDF;
1580 LOCATE 17,1:PRINT"New Total Record Length = ";:LOCATE 17,30:PRINT NDL;
1590 LOCATE 20,1:PRINT"Number of Data Records Read = ",X-1;
1600 COLOR 7,0
1610 GOSUB 60990 'go wait for input key to continue
1615 CLS:PRINT"Your new database is built."
1620 PRINT:PRINT"You must remember to sort the database"
1625 PRINT:PRINT"the first time you use it."
1640 END
10000 FOR LP = LC+1 TO 24
10010 LOCATE LP,NEXTFIELD:PRINT SPC(79-NEXTFIELD)
10020 NEXT LP
10030 RETURN
20000 GOSUB 20110
20010 SOUND 200,9
20020 LOCATE 25,1:COLOR 15+CL,0
20030 PRINT DR$;:COLOR 7,0
20040 LINE INPUT;"";DR$
20050 IF LEN(DR$)<1 GOTO 20110
20060 IF UC=0 GOTO 20110
20070 FOR NN = 1 TO LEN(DR$) 'fold to upper case
20080 X=ASC(MID$(DR$,NN,1))
20090 IF X>=97 AND X <= 122 THEN MID$(DR$,NN,1)=CHR$(X-32)
20100 NEXT:UC = 0
20110 LOCATE 25,1:PRINT SPACE$(RC-1);:LOCATE 25,1:RETURN
30000 FOR R = 6 TO 24
30010 FOR C = 9 TO RC-2 STEP 13
30020 LOCATE R,C:PRINT"     ";
30030 NEXT C:NEXT R
30040 RETURN
40000 FOR I = 1 TO NDF 'routine called if new field names incorrect
40010 NFM$(I) = ""
40020 LOCATE LC+I,NEXTFIELD:PRINT SPC(RC-NEXTFIELD);
40030 NEXT I
40040 RETURN
50000 FOR I = 1 TO NDF 'routine to be called if new field width incorrect
50020 NFL(I)=0
50025 LOCATE LC+I,NEXTFIELD+CURMAX+1:PRINT,USING"###";NFL(I);
50030 NEXT I
50040 RETURN
60000 FOR I = 1 TO NDF 'routine to be used if relationship vals incorrect
60010 LOCATE 4+I,25:PRINT SPC(5)
60020 FR(I) = 0
60030 NEXT I
60040 RETURN
60990 REM 'Wait for input key subroutine
60991 LOCATE 25,1:PRINT"Hit any key to continue";
60992 K$=INKEY$:IF K$="" THEN 60992 ELSE RETURN
 for input key subroutine
60991 LOCATE 25,1:PRINT"Hit any key t