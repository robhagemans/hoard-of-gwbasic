21000 REM ===========================
21001 REM Copy the contents of a
21002 REM directory to another
21003 REM directory
21004 REM INPUT - SRCD$ Source dir
21005 REM         DESTD$ Destination
21006 REM ===========================
21010 DIREC$ = SRCD$
21020 GOSUB 15000
21030 FOR ICF = 1 TO LC
21040     FULLFILE$ = SRCD$ + "\" + FL$[ICF]
21050     SHELL "COPY "+FULLFILE$+" "+DESTD$
21060 NEXT ICF
21070 RETURN
