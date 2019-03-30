DECLARE SUB readinput (BYVAL readlen$)
readin$ = ""

CALL readinput(readlen$)
         
PRINT "<HTML>"
PRINT "<head><title>Web Server's Env String</title><head>"
PRINT "<body>"
I = 1
DO WHILE ENVIRON$(I) <> ""
    PRINT ENVIRON$(I) + "<BR>"
    I = I + 1
LOOP
PRINT "<BR><BR>"
PRINT readlen$

PRINT "</body>"
PRINT "</html>"

SUB readinput (readlen$)
IF ENVIRON$("'REQUEST_METHOD") = "GET" THEN
  readin$ = enivron$("QUERY_STRING")
ELSE
  readin$ = ""
  readlen$ = ENVIRON$("CONTENT_LENGTH")
END SUB

