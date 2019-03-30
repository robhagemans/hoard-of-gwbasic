'Written by Bill Slamer 
 DECLARE SUB Loaddatafields ()
 DECLARE SUB Printrecords ()
 DECLARE SUB Showmenu ()
 DECLARE SUB Loadeditfield ()
 DECLARE SUB Updaterec ()
 DECLARE SUB Editcustomer ()
 DECLARE SUB Openfiles ()
 DECLARE SUB Sortindex ()
 DECLARE SUB Showcustomers ()
 DECLARE SUB Deleterecord ()
 DECLARE SUB Checkfordups ()
 DEFINT A-Z
'$INCLUDE: 'ArrowKey.Inc'
 COLOR 15, 1: CLS
DIM SHARED N$(500), N(500), Fielddesc$(10), Fieldlen(10), Deleted(50)
DIM SHARED Editfield$(10), Menu$(10)
DIM SHARED Mrow, Currec, Y$, Deleted
DIM SHARED Maxrows, Row, Currtop, Extnd, Arraylocation
 CLS
 TYPE Customerrecord
 Company   AS STRING * 30
 Contact   AS STRING * 30
 Address1  AS STRING * 30
 Address2  AS STRING * 30
 City      AS STRING * 15
 State     AS STRING * 2
 Zip       AS STRING * 10
 Phone     AS STRING * 13
 Fax       AS STRING * 13
 Date      AS STRING * 10
 END TYPE
 DIM SHARED Custrec AS Customerrecord
'*** load Menu Selections
DATA View all customers, Edit a customer record
DATA Add a customer record,Print all customer records,Quit
 FOR X = 1 TO 5
   READ Menu$(X)
   Menu$(X) = LEFT$("     " + Menu$(X) + SPACE$(50), 50)
 NEXT
'*** load Array With Record Fields
 FOR X = 1 TO 10: READ Fielddesc$(X), Fieldlen(X): NEXT
DATA Company,30,Contact,30,Address1,30,Address2,30,City,15,State,2
DATA Zip,10,Phone,14,Fax,14,Date,10
 Openfiles  'open Any Files That Need To Be Opened
 Sortindex  'sort Index
 Showmenu  'display Menu

SUB Checkfordups
SHARED Dup, N$(), Maxrows, Editfield$()
 FOR X = 1 TO Maxrows
   IF Editfield$(1) = N$(X) THEN
     BEEP: Dup = 1
     COLOR 15, 4: LOCATE 16, 16
     PRINT "The field COMPANY is a DUPLICATE, press any key";
     Z$ = INPUT$(1)
     COLOR 15, 1: LOCATE 16, 16
     PRINT SPACE$(55);
     EXIT FOR
   END IF
 NEXT
END SUB

SUB Deleterecord
SHARED Maxrows, Currec, N(), N$(), Deleted(), Deleted, Editfield$(), D$
 COLOR 15, 4
 LOCATE 16, 14: PRINT "Are you sure you want to delete this record (Y or N)";
 D$ = INPUT$(1): D$ = UCASE$(D$)
 COLOR 15, 1
 IF D$ = "N" THEN
   LOCATE 16, 14: PRINT SPACE$(55);
   EXIT SUB
 END IF
 FOR X = 1 TO Maxrows
   IF N$(X) = Editfield$(1) THEN EXIT FOR
 NEXT
 FOR Y = X TO Maxrows
   N$(Y) = N$(Y + 1)
   N(Y) = N(Y + 1)
 NEXT
 Maxrows = Maxrows - 1
 Loaddatafields
 Custrec.Company = "DELETED"
 PUT #1, Currec, Custrec
 Deleted = Deleted + 1
 Deleted(Deleted) = Currec
END SUB

SUB Editcustomer
SHARED Maxrows, Currec, N(), N$(), Deleted(), Deleted, D$, Dup
 COLOR 15, 1: CLS
 LOCATE 1, 60: PRINT "] Insert OFF ["
 FOR X = 1 TO 10
   COLOR 15, 1: LOCATE X + 4, 11: PRINT Fielddesc$(X)
   IF Mrow = 3 THEN
     Editfield$(X) = SPACE$(Fieldlen(X))
   END IF
   IF Mrow = 3 THEN Editfield$(10) = DATE$
   COLOR , 0: LOCATE X + 4, 21: PRINT Editfield$(X)
 NEXT
 IF Mrow = 2 THEN
   LOCATE 18, 13: PRINT CHR$(24) + CHR$(25) + " " + CHR$(26) + CHR$(27) + " <Alt U>pdate  <ESC> quit  <Ins>  <Alt D>elete"
 ELSE
   LOCATE 18, 20: PRINT CHR$(24) + CHR$(25) + " " + CHR$(26) + CHR$(27) + " <Alt S>ave  <ESC> quit  <Ins>"
 END IF

 Row = 1: Col = 1: Nooffields = 10
 DO
   COLOR 0, 7: LOCATE Row + 4, Col + 20
   PRINT MID$(Editfield$(Row), Col, 1)
   X$ = "": WHILE X$ = "": X$ = INKEY$: WEND: X$ = UCASE$(X$)
   COLOR 15, 0: LOCATE Row + 4, Col + 20
   PRINT MID$(Editfield$(Row), Col, 1)
   SELECT CASE X$
     CASE CHR$(0) + CHR$(32)
       Deleterecord
       IF D$ = "Y" THEN
         EXIT SUB
       END IF
     CASE ESC$
       COLOR 15, 1: CLS
       EXIT SUB
     CASE CHR$(0) + CHR$(22)  'alt U (update Record)
'*** everything Entered Is Stored In Editfield$() array.
       IF Mrow = 2 THEN    'make Sure Programe Is In Edit Mode
       COLOR 15, 1: CLS  'before Allowing Update.
       Loaddatafields
       Updaterec
       EXIT SUB
     END IF
   CASE CHR$(0) + CHR$(31)  'alt S (save New Record)
'*** everything Entered Is Stored In Editfield$() array.
     IF Mrow = 3 THEN     'make Sure Program Is In Add Mode
     Checkfordups
     IF Dup = 0 THEN
       COLOR 15, 1: CLS   'before Allowing Save.
       Loaddatafields
       Maxrows = Maxrows + 1
       IF Deleted > 0 THEN
         Currec = Deleted(Deleted)
         Deleted = Deleted - 1
         N(Maxrows) = Currec
       ELSE
         Currec = Maxrows + Deleted
         N(Maxrows) = Maxrows
       END IF
       N$(Maxrows) = Custrec.Company
       Updaterec
       Sortindex
       EXIT SUB
     ELSE
       Dup = 0
     END IF
   END IF
 CASE UpArrow$
   Col = 1: Row = Row - 1: IF Row < 1 THEN Row = Nooffields
 CASE DnArrow$, Enter$
   Col = 1: Row = Row + 1: IF Row > Nooffields THEN Row = 1
 CASE LArrow$
   Col = Col - 1: IF Col < 1 THEN Col = Fieldlen(Row)
 CASE RArrow$
   Col = Col + 1: IF Col > Fieldlen(Row) THEN Col = 1
 CASE PgUp$
   Col = 1: Row = 1
 CASE PgDn$
   Col = 1: Row = Nooffields
 CASE Ins$
   COLOR , 1
   IF Inc = 1 THEN
     Inc = 0: LOCATE 1, 60: PRINT "] Insert OFF ["
   ELSE
     Inc = 1: LOCATE 1, 60: PRINT "] Insert ON  ["
   END IF
   COLOR , 0
 CASE Del$
   F$ = MID$(Editfield$(Row), Col + 1, Fieldlen(Row))
   F1$ = LEFT$(Editfield$(Row), Col - 1) + F$ + " "
   Editfield$(Row) = F1$
   LOCATE Row + 4, 21: PRINT Editfield$(Row)
 CASE HomeK$
   Col = 1: IF Row = 5 OR Row = 6 THEN Col = 2
 CASE EndK$
   Col = Fieldlen(Row)
 CASE BS$
   IF Col > 1 THEN
     F$ = MID$(Editfield$(Row), Col, Fieldlen(Row))
     F1$ = LEFT$(Editfield$(Row), Col - 2) + F$ + " "
     Editfield$(Row) = F1$
     Col = Col - 1: IF Col < 1 THEN Col = 1
     LOCATE Row + 4, 21: PRINT Editfield$(Row)
   END IF
 CASE IS > CHR$(31), IS < CHR$(126)
   IF Inc = 1 THEN
     F$ = MID$(Editfield$(Row), Col, Fieldlen(Row))
     F1$ = LEFT$(LEFT$(Editfield$(Row), Col - 1) + X$ + F$, Fieldlen(Row))
     Editfield$(Row) = F1$
     Col = Col + 1: IF Col > Fieldlen(Row) THEN Col = 1
     LOCATE Row + 4, 21: PRINT Editfield$(Row)
   ELSE
     MID$(Editfield$(Row), Col) = X$
     LOCATE Row + 4, 21: PRINT Editfield$(Row)
     Col = Col + 1: IF Col > Fieldlen(Row) THEN Col = 1
   END IF
 END SELECT
 LOOP
END SUB

SUB Loaddatafields
SHARED Editfield$()
 Custrec.Company = Editfield$(1)
 Custrec.Contact = Editfield$(2)
 Custrec.Address1 = Editfield$(3)
 Custrec.Address2 = Editfield$(4)
 Custrec.City = Editfield$(5)
 Custrec.State = Editfield$(6)
 Custrec.Zip = Editfield$(7)
 Custrec.Phone = Editfield$(8)
 Custrec.Fax = Editfield$(9)
 Custrec.Date = Editfield$(10)
END SUB

SUB Loadeditfield
SHARED Maxrows, Currec, N(), N$()
 Currec = N(Row + Extnd)
 Arraylocation = Row + Extnd
 GET #1, Currec, Custrec
 Editfield$(1) = Custrec.Company
 Editfield$(2) = Custrec.Contact
 Editfield$(3) = Custrec.Address1
 Editfield$(4) = Custrec.Address2
 Editfield$(5) = Custrec.City
 Editfield$(6) = Custrec.State
 Editfield$(7) = Custrec.Zip
 Editfield$(8) = Custrec.Phone
 Editfield$(9) = Custrec.Fax
 Editfield$(10) = Custrec.Date
END SUB

SUB Openfiles
SHARED Maxrows, Currec, N(), N$(), Deleted(), Deleted
 OPEN "test.txt" FOR RANDOM AS 1 LEN = LEN(Custrec)
 FOR X = 1 TO LOF(1) / LEN(Custrec)
   GET #1, X, Custrec
   IF LEFT$(Custrec.Company, 7) = "DELETED" THEN
     Deleted = Deleted + 1
     Deleted(Deleted) = X
   ELSE
     Maxrows = Maxrows + 1
     N$(Maxrows) = Custrec.Company
     N(Maxrows) = X
   END IF
 NEXT
END SUB

SUB Printrecords
SHARED Maxrows, Currec, N(), N$()
 COLOR 31, 1
 LOCATE 12, 25: PRINT "Printing Records"
 F$ = "\                          \  \                          \  \                            \  \                   \  \\ \            \"
 LPRINT CHR$(15);
 WIDTH "lpt1:", 132
 FOR X = 1 TO LOF(1) / LEN(Custrec)
   GET #1, X, Custrec
   LPRINT USING F$; Custrec.Company; Custrec.Contact; Custrec.Address1; Custrec.City; Custrec.State; Custrec.Phone;
 NEXT
 COLOR 15, 1
END SUB

SUB Showcustomers
SHARED Maxrows, Currec, N(), N$()
 COLOR 15, 1: CLS
 COLOR 15, 2
 LOCATE 4, 3: PRINT CHR$(201) + STRING$(72, CHR$(205)) + CHR$(187)
 FOR X = 1 TO 8
   LOCATE X + 4, 3: PRINT CHR$(186) + SPACE$(72) + CHR$(186)
 NEXT
 LOCATE 12, 3: PRINT CHR$(200) + STRING$(72, CHR$(205)) + CHR$(188)
 LOCATE 6, 10: PRINT "The text in the box below will show the"
 LOCATE 7, 10: PRINT "customers you have.  You can scroll through"
 LOCATE 8, 10: PRINT "them by using the ARROW keys."
 IF Mrow = 2 THEN
   LOCATE 10, 10: PRINT "<RETURN> selects record for editing."
 END IF
 COLOR , 4
 LOCATE 14, 3: PRINT CHR$(201) + STRING$(72, CHR$(205)) + CHR$(187)
 FOR X = 1 TO 10
   LOCATE X + 14, 3: PRINT CHR$(186) + SPACE$(72) + CHR$(186);
 NEXT
 LOCATE 24, 3: PRINT CHR$(200) + STRING$(72, CHR$(205)) + CHR$(188);
 FOR X = 1 TO 9
   COLOR 15, 4: LOCATE X + 14, 5: PRINT LEFT$(N$(X) + SPACE$(70), 70);
 NEXT
 COLOR 15, 3
 LOCATE 24, 30: PRINT CHR$(24) + CHR$(25) + "      <RETURN> menu";
 COLOR 15, 1
 Row = 1: Extnd = 0: Currtop = 1
 DO
   COLOR 0, 7: LOCATE Row + 14, 5
   PRINT LEFT$(N$(Row + Extnd) + SPACE$(70), 70);
   Y$ = "": WHILE Y$ = "": Y$ = INKEY$: WEND: Y$ = UCASE$(Y$)
   COLOR 15, 4: LOCATE Row + 14, 5
   PRINT LEFT$(N$(Row + Extnd) + SPACE$(70), 70);
   SELECT CASE Y$
     CASE ESC$
       COLOR 15, 1
       CLS
       EXIT SUB
     CASE Enter$
       COLOR 15, 1
       IF Mrow = 2 THEN Loadeditfield
       CLS : EXIT SUB
     CASE PgUp$
       FOR Y = 1 TO 8
         IF Row - 1 >= 1 THEN
           Row = Row - 1
         ELSE
           IF Row = 1 AND Extnd > 0 THEN
             Currtop = Currtop - 1
             Extnd = Extnd - 1
             GOSUB SCROLLONELINEDOWN
           END IF
         END IF
       NEXT
     CASE UpArrow$
       IF Row - 1 >= 1 THEN
         Row = Row - 1
       ELSE
         IF Row = 1 AND Extnd > 0 THEN
           Currtop = Currtop - 1
           Extnd = Extnd - 1
           GOSUB SCROLLONELINEDOWN
         END IF
       END IF
     CASE PgDn$
       FOR Y = 1 TO 8
         IF Row + 1 + Extnd <= Maxrows THEN
           Row = Row + 1
           IF Row > 9 THEN
             Currtop = Currtop + 1
             Row = 9: Extnd = Extnd + 1
             GOSUB SCROLLONELINEUP
           END IF
         END IF
       NEXT
     CASE DnArrow$
       IF Row + 1 + Extnd <= Maxrows THEN
         Row = Row + 1
         IF Row > 9 THEN
           Currtop = Currtop + 1
           Row = 9: Extnd = Extnd + 1
           GOSUB SCROLLONELINEUP
         END IF
       END IF
   END SELECT
 LOOP
 EXIT SUB
SCROLLONELINEUP:
 Srow = 15
 FOR X = Currtop TO Currtop + 7
   LOCATE Srow, 5: PRINT LEFT$(N$(X) + SPACE$(70), 70)
   Srow = Srow + 1
 NEXT
 RETURN
SCROLLONELINEDOWN:
 Srow = 22
 FOR X = Currtop + 7 TO Currtop STEP -1
   LOCATE Srow, 5: PRINT LEFT$(N$(X) + SPACE$(70), 70);
   Srow = Srow - 1
 NEXT
 RETURN
END SUB

SUB Showmenu
'*** make Menu Box
MAKEMENU:
 DO
   CLS
   COLOR 15, 4
   LOCATE 4, 15: PRINT CHR$(201) + STRING$(50, CHR$(205)) + CHR$(187)
   LOCATE 4, 30: PRINT "[ Ziggy's Main Menu ]"
   FOR X = 1 TO 8
     LOCATE X + 4, 15: PRINT CHR$(186) + SPACE$(50) + CHR$(186)
   NEXT

'*** print Menu Selections
   LOCATE 12, 15: PRINT CHR$(200) + STRING$(50, CHR$(205)) + CHR$(188)
   FOR X = 1 TO 5: LOCATE X + 5, 16: PRINT Menu$(X): NEXT

   Mrow = 1: Noofselections = 5
   DO
     COLOR 0, 7: LOCATE Mrow + 5, 16: PRINT Menu$(Mrow)
     X$ = "": WHILE X$ = "": X$ = INKEY$: WEND: X$ = UCASE$(X$)
     COLOR 15, 4: LOCATE Mrow + 5, 16: PRINT Menu$(Mrow)
     SELECT CASE X$
       CASE ESC$
         COLOR 7, 0
         CLS : END
       CASE Enter$
         SELECT CASE Mrow
           CASE 1  'view All Customers
             CLS
             Showcustomers
             EXIT DO
           CASE 2  'edit A Customer Record
             CLS
             Showcustomers
             IF Y$ <> ESC$ THEN
               Editcustomer
             END IF
             EXIT DO
           CASE 3  'add A Customer Record
             CLS
             Editcustomer
             EXIT DO
           CASE 4  'print All Customer Records
             CLS
             Printrecords
             EXIT DO
           CASE 5  'quit
             COLOR 7, 0
             CLOSE : CLS : END
         END SELECT
       CASE UpArrow$
         Mrow = Mrow - 1
         IF Mrow < 1 THEN Mrow = Noofselections
       CASE DnArrow$
         Mrow = Mrow + 1
         IF Mrow > Noofselections THEN Mrow = 1
     END SELECT
   LOOP
 LOOP
END SUB

SUB Sortindex
SHARED Maxrows, Currec, N(), N$()
 IF Maxrows < 1 THEN EXIT SUB
 Maxarray% = Maxrows
 REDIM Stackl%(Maxarray%), Stackr%(Maxarray%)
 Sx% = 1: Stackl%(1) = 1: Stackr%(1) = Maxarray%
 WHILE Sx% <> 0
   Lx% = Stackl%(Sx%): Rx% = Stackr%(Sx%): Sx% = Sx% - 1
   WHILE Lx% < Rx%
     Ix% = Lx%: Jx% = Rx%: X$ = N$((Lx% + Rx%) \ 2)
     WHILE Ix% <= Jx%
       WHILE N$(Ix%) < X$: Ix% = Ix% + 1: WEND
       WHILE N$(Jx%) > X$: Jx% = Jx% - 1: WEND
       X0% = 0
       WHILE (Ix% <= Jx% AND X0% = 0)
         X0% = 1: SWAP N$(Ix%), N$(Jx%)
         SWAP N(Ix%), N(Jx%)
         Ix% = Ix% + 1: Jx% = Jx% - 1
       WEND
     WEND
     X0% = 0
     WHILE (Ix% <= Rx% AND X0% = 0)
       X0% = 1: Sx% = Sx% + 1
       Stackl%(Sx%) = Ix%: Stackr%(Sx%) = Rx%
     WEND
     Rx% = Jx%
   WEND
 WEND
 ERASE Stackl%, Stackr%
END SUB

SUB Updaterec
SHARED Maxrows, Currec, N(), N$()
 PUT #1, Currec, Custrec
END SUB

