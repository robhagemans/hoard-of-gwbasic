REM --------------------------------------------------------------------------
REM | Qbasic cgi example : Using'POST' method in HTML Form
REM | Author             : Benjimen Chan
REM | Date               : Jan 2001
REM --------------------------------------------------------------------------

PRINT "<HTML>"
PRINT "<head><title>Web Server's Env String</title><head>"

PRINT "<body bgcolor='#C&EAFE' text='#000000'>"

IF ENVIRON$("REQUEST_METHOD") = "GET" THEN
  login$ = ""
  passwd$ = ""

  readin$ = ENVIRON$("QUERY_STRING")
 
  i = LEN(readin$)
  read$ = ""
  numfld = 0
  DIM fldnum$(2)

  FOR x = 1 TO i
    IF MID$(readin$, x, 1) <> "&" THEN
        read$ = read$ + MID$(readin$, x, 1)
    ELSE
        numfld = numfld + 1
        fldnum$(numfld) = read$
        read$ = ""
    END IF
  NEXT

  REM FOR ix = 1 TO numfld
  REM    PRINT fldnum$(ix)
  REM NEXT
 
  FOR count = 1 TO 2
     IF count = 1 THEN
        login$ = MID$(fldnum$(1), 7, LEN(fldnum$(1)) - 6)
     END IF
     IF count = 2 THEN
        passwd$ = MID$(fldnum$(2), 8, LEN(fldnum$(2)) - 7)
     END IF
  NEXT

  PRINT "<font><size='6'><b><i>Qbasic CGI - Get Method</i></b></font>"
  PRINT "<hr>"
  PRINT "<font><size='4'><b>User login : </b></font>" + login$ + "<BR><BR>"
  PRINT "<hr>"
  PRINT "<font><size='4'><b><i>Welcome, " + login$ + ", to world of Qbasic cgi</i></b></font>"
ELSE
  PRINT "<font><size='6'><b>'POST' method only</b></font>"
END IF

PRINT "</body>"
PRINT "</html>"

