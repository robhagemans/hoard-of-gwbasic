10 REM  PRTCOPYS.BAS  written by Greg C. Hvazda
20 INPUT"Enter name of file to print : ",A$
30 INPUT"Enter number of copies : ",A
40 PRINT"Print "A" copie(s) of "A$" ? Y/N/<Esc>" : B$ = INPUT$(1)
50 IF B$ = "n" OR B$ = "N" THEN 20 ELSE 60
60 IF B$ = "y" OR B$ = "Y" THEN GOTO 100 ELSE 70
70 IF B$ = CHR$(27) THEN 90 ELSE 80
80 GOTO 40 : END
90 SYSTEM : END
100 FOR X = 1 TO A
110   PRT$ = "type "+A$+" > prn"
120   SHELL PRT$
130 NEXT X
140 GOTO 40
150 END
