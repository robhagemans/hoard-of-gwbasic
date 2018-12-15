20425 REM *********************************************************************
20430 REM ---------------- DISPLAY A MESSAGE IN ANY DIRECTION -----------------
20435 REM
20440 REM This subroutine allows you to display a message printing forward,
20445 REM backward, and at angles in any combination starting at a specified
20450 REM row and column. Messages that would print off of the screen are
20455 REM truncated. 
20460 REM
20465 REM enter with - MSG$="message", to display
20470 REM              ROW and COL=row and column on which to start "message"
20475 REM              DIR$="U","D","L","R","UR","LR","LL","UL"
20480 REM              direction to move toward while displaying message
20485 REM optional -   TEXTFORE,TEXTBACK,DATAFORE,DATABACK,FIELDFORE,FIELDBACK
20490 REM              colors optionally specified for COLOR statements
20495 REM
20500 IF TEXTFORE=0 AND TEXTBACK=0 THEN TEXTFORE=7                 :REM 20500
20505 IF DATAFORE=0 AND DATABACK=0 THEN DATAFORE=15
20510 IF FIELDFORE=0 AND FIELDBACK=0 THEN FIELDBACK=7
20515 COLOR TEXTFORE,TEXTBACK
20525 FOR L=1 TO LEN(MSG$)
20530   IF ROW<1 OR ROW>25 THEN 20800
20535   IF COL<1 OR COL>80 THEN 20800
20540   LOCATE ROW,COL
20555   PRINT MID$(MSG$,L,1);
20650   IF DIR=0 THEN ROW=ROW-1
20660   IF DIR=45 THEN ROW=ROW-1:COL=COL+4
20670   IF DIR=90 THEN COL=COL+1
20680   IF DIR=135 THEN ROW=ROW+1:COL=COL+4
20690   IF DIR=180 THEN ROW=ROW+1
20700   IF DIR=225 THEN ROW=ROW+1:COL=COL-4
20710   IF DIR=270 THEN COL=COL-1
20720   IF DIR=315 THEN ROW=ROW-1:COL=COL-4
20790 NEXT L
20800 RETURN
20805 REM
