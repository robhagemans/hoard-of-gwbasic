'*** Program FILELOCK.BAS ***************************************

TYPE InvoiceHdr
	InvoiceNbr AS LONG
	AcctNbr AS STRING * 6
	Terms AS STRING * 20
	InvoiceTotal AS CURRENCY
END TYPE

DECLARE SUB ChangeRecord (e AS InvoiceHdr)
DECLARE SUB GetData (e AS InvoiceHdr)
DECLARE SUB AddRecord (e AS InvoiceHdr)

DIM InvoiceHdrRec AS InvoiceHdr
DIM LastRecord, RecNo AS LONG
ON ERROR GOTO ErrorHandler
OPEN "INVHDR.DAT" FOR RANDOM SHARED AS #1 LEN = LEN(InvoiceHdrRec)

DO
 CLS
 PRINT "(A)dd a record, (C)hange a record, or (Q)uit ";
 Choice$ = INPUT$(1)
 Choice$ = UCASE$(Choice$)
 PRINT Choice$
 LastRecord = LOF(1) / LEN(InvoiceHdrRec)
 SELECT CASE Choice$
	 CASE "A"
		CALL AddRecord(InvoiceHdrRec)
		PUT 1, LastRecord + 1, InvoiceHdrRec
	 CASE "C"
		PRINT "Enter the number of the record to update (1 to";
		PRINT LastRecord; ")"
		DO
		 INPUT "Record Number "; RecNo
		LOOP UNTIL RecNo > 0 AND RecNo <= LastRecord
TryLock:
		LOCK 1, RecNo
		GET 1, RecNo, InvoiceHdrRec
		CALL ChangeRecord(InvoiceHdrRec)
		PUT 1, RecNo, InvoiceHdrRec
		UNLOCK 1, RecNo
	 CASE "Q"
 END SELECT
EndLoop:
LOOP UNTIL Choice$ = "Q"

CLOSE #1

ErrorHandler:
SELECT CASE ERR
 CASE 70
	LOCATE 22, 10: PRINT "Record"; RecNo; "is currently in use"
	LOCATE 23, 10: PRINT "Would you like to try again (Y/N)"
	Try$ = INPUT$(1)
	Try$ = UCASE$(Try$)
	LOCATE 22, 10: PRINT SPACE$(60)
	LOCATE 22, 10: PRINT SPACE$(60)
	IF Try$ = "Y" THEN CLS : RESUME TryLock ELSE RESUME EndLoop
END SELECT

SUB AddRecord (NewRecord AS InvoiceHdr)
	CALL GetData(NewRecord)
END SUB

SUB ChangeRecord (ChgRecord AS InvoiceHdr)
 PRINT "Old Record"
 PRINT USING "Invoice Number: ##########            ";_
                                 ChgRecord.InvoiceNbr
 PRINT USING "Account Number: \                    \";_
                                 ChgRecord.AcctNbr
 PRINT USING "Terms:          \                    \";_
                                 ChgRecord.Terms
 PRINT USING "Invoice Total   $$,#####.##           ";_
                                 ChgRecord.InvoiceTotal
 PRINT
 PRINT "Enter New Data:"
 CALL GetData(ChgRecord)
END SUB

SUB GetData (e AS InvoiceHdr)
	INPUT "Invoice Number "; e.InvoiceNbr
	INPUT "Account Number "; e.AcctNbr
	INPUT "Terms          "; e.Terms
	INPUT "Invoice Total  "; e.InvoiceTotal
END SUB

