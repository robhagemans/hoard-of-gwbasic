1000 ' Numeric Editing routines for PC Basic-Basica
1010 ' Michael Krieger, June 1983
1020 '
1030 ' The purpose of these three subroutines is to perform numeric editing
1040 ' especially for DATE and TIME fields, which CAN NOT be edited
1050 ' with "PRINT USING".  They are just string manipulation routines
1060 ' which run very fast, and will take your number and return a nice
1070 ' edited string of a FIXED LENGTH for you to use to make output
1080 ' more legible.
1090 '
1100 ' *** FIELD NAMES USED BY THESE ROUTINES
1105 '     NAME    SET BY       DESCRIPTION
1106 '
1110 '     A2      user         Field to be edited
1120 '     ISIG    user         Number of significant places desired
1130 '                          (left of decimal point)
1140 '     IDEC    user         No. of Decimal positions desired in result
1150 '                          (to RIGHT of decimal point)
1160 '     DLM$    user         DELIMITER desired ("/", ":", "-", etc)
1180 '     LPAD$   user         Left Pad Character (" ","0","$", etc.)
1190 '     O$      routine      THE EDITED STRING !!
1200 '
1210 '
1220 ' The length of the returned string will be the total of ISIG plus
1230 ' IDEC plus 1 for decimal point, plus 1 for trailing minus sign, which
1240 ' will be added if the field is negative.
1250 '
1260 ' ** TO USE THE ROUTINES **
1270 ' 1. first, if the number is to be rounded off, store your field into
1280 '    A2 and GOSUB 1670 (or whatever you renumber it to)
1290 '
1300 ' 2. Next, set ISIG, IDEC, DLM$, and LPAD$ to the values you want.
1310 '    for a normal DATE field, this would be:
1320 '    ISIG=6:IDEC=0:DLM$="/":LPAD$=" "
1330 ' 3. GOSUB to the JUSTIFICATION routine with GOSUB 1730.
1340 ' 4. To complete the DATE/TIME edit, GOSUB 1600 to insert the delimiter
1350 '    characters.
1360 '
1370 '  ***** END OF NARRATIVE==== BEGIN SUBROUTINE CODE==
1380 '  You may delete all lines up to here before using the code.
1390 '  HAPPY EDITING!!!!!
1600 ' ************* NUMERIC EDITING SUBROUTINE FOR DATE & TIME
1610 '
1620 B$=O$ ' SET UP THE WORK STRING
1630 O$=LEFT$(B$,2)+DLM$+MID$(B$,3,2):IF LEN(B$) > 5 THEN O$=O$+DLM$+MID$(B$,5,2) ' COMPLETE FOR DATE
1650 RETURN
1660 '
1670 ' ********* R O U N D O F F     S U B R O U T I N E *****************
1680 IRFCT=1:IF IDEC <=0 THEN RETURN ' NO ROUNDOFF FOR INTEGERS
1690 FOR IWXI=1 TO IDEC: IRFCT=IRFCT * 10: NEXT
1700 A2=INT((A2+ (.5*(1/IRFCT)))*IRFCT)/IRFCT : RETURN
1710 '
1720 '
1730 ' *********** NUMERIC LEFT & RIGHT JUSTIFICATION ********************
1735 '
1740 ID=1:IS1=0:ID1=0:B2$="":INEG=0:IF A2<=0 THEN INEG=-1:A2=ABS(A2) ' SET PARMS & SIGN
1750 B$=STR$(A2):B$=RIGHT$(B$,(LEN(B$)-1)) ' STRIP THE FIRST BLANK.
1760 FOR IWX1=1 TO LEN(B$): IF MID$(B$,IWX1,1)="." THEN ID=3 ' DEC POINT FOUND
1770 ON ID GOTO 1780,1790,1800
1780 IS1=IS1+1:GOTO 1810
1790 ID1=ID1+1:GOTO 1810
1800 ID=2
1810 NEXT
1830 IWX1=1:IWX2=2:IF IS1>=ISIG THEN 1870 ' PAD LEFT
1840 FOR IWX1=1 TO ISIG-IS1:B2$=B2$+LPAD$:IWX2=IWX2+1:NEXT ' BEGIN STRING WITH THE PADS.
1850 IF LPAD$<>"$" OR IWX2<2 THEN 1870 ' BYPASS DOLLAR SIGN BLANKOUT.
1860 FOR IWX1=1 TO IWX2-1:MID$(B2$,IWX1,1)=" ":NEXT ' BLANK OUT THE $ IN STRING
1870 B2$=B2$+B$: IF ID1>=IDEC THEN 1900 ' DECIMAL PLACES NEED PADDING ?
1880 IF ID1=0 THEN B2$=B2$+"." ' ADD THE DEC POINT
1890 FOR IWX1=LEN(B2$)+1 TO LEN(B2$)+(IDEC-ID1):B2$=B2$+"0":NEXT
1900 IF NEG THEN B2$=B2$+"-" ELSE B2$=B2$+" " ' TRAIL A BLANK OR A MINUS SIGN.
1910 O$=B2$: RETURN '       END OF *** JUSTIFY *** ROUTINE
1920 ' ********************** END OF EDITING ROUTINES ******************
1930 '  If you have any questions or are confused,
1940 '  leave EMAIL for me, Michael Krieger at 74065,1344
1950 '  or call at (212) 741 2828  or (516) 883 7016
