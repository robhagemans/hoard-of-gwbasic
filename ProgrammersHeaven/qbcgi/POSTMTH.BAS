REM --------------------------------------------------------------------------
REM | Qbasic cgi example : Using'POST' method in HTML Form
REM | Author             : Benjimen Chan
REM | Date               : Jan 2001
REM --------------------------------------------------------------------------

DECLARE SUB readinput (login AS STRING, Passwd AS STRING)
login$ = ""
Passwd$ = ""

PRINT "<HTML>"
PRINT "<head><title>Qbasic CGI</title><head>"

PRINT "<body bgcolor='#C&EAFE' text='#000000'>"
CALL readinput(login$, Passwd$)
PRINT "</body>"
PRINT "</html>"

SUB readinput (login AS STRING, Passwd AS STRING)
IF ENVIRON$("REQUEST_METHOD") = "POST" THEN
  login$ = ENVIRON$("FORM_LOGIN")
 
  PRINT "<font><size='6'><b><i>Qbasic CGI - POST Method</i></b></font>"
  PRINT "<hr>"
  PRINT "<font><size='4'><b>User login : </b></font>" + login$ + "<BR><BR>"
  PRINT "<hr>"
  PRINT "<font><size='4'><b><i>Welcome, " + login$ + ", to world of Qbasic cgi</i></b></font>" + Passwd$
ELSE
  PRINT "<font><size='6'><b>'POST' method only</b></font>"
END IF

END SUB

