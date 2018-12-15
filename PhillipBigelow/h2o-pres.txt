1 REM H2O-pres.bas
5 CLS:PRINT "          OCEAN WATER PRESSURE VS DEPTH CALCULATOR"
6 PRINT "                    by Phillip K. Bigelow":PRINT:PRINT:PRINT
7 PRINT "                          MENU"
8 PRINT "     d = do a calculation    f = read footnotes    x = exit"
9 A$=INPUT$(1)
10 IF A$="d" THEN 14
11 IF A$="f" THEN 200
12 IF A$="x" THEN 400
13 GOTO 5
14 PRINT:INPUT "What is the depth (in feet)";X#
15 IF X#<1640# THEN 100
16 IF X#>14763.6# THEN 150
20 LET Y#=(.4510144#*X#)-15.92334#
31 PRINT:PRINT:PRINT "Pressure at";X#;"feet depth is";Y#;"lbs/square inch"
40 PRINT:PRINT:PRINT "Do you want to do another calculation? (y/n)":Q$=INPUT$(1)
50 IF Q$="y" THEN 5
51 IF Q$="n" THEN 400
52 GOTO 40
100 LET Y#=.4462288#*X#
110 GOTO 31
150 LET Y#=(.4610768#*X#)-177.2783#
160 GOTO 31
190 REM Copyright Hell Creek Life, 2009 Phillip Bigelow
200 CLS:PRINT "                  FOOTNOTES":PRINT
201 PRINT "This calculator gives extremely good results which are very close to published"
205 PRINT "values.  However, all water pressure calculations are only approximations,"
210 PRINT "because pressure also depends on temperature and salinity, which vary"
220 PRINT "both geographically and with depth. It also depends on latitude."
221 PRINT:PRINT "My calculator is based on regression equations. The data points that I"
222 PRINT "used to create the equations came from `Standard Ocean' pressure data at"
223 PRINT "various depths, which were found in the Handbook of Chemistry and Physics."
224 PRINT "If you are using this calculator for fresh water, then your results will"
225 PRINT "be a little high.":PRINT
227 PRINT "For salt water, error will usually be much less than +/- 0.2% of published"
228 PRINT "Handbook values (averaging +/- 0.07%)."
229 PRINT
230 PRINT "Bear in mind that there are no oceans on earth that"
231 PRINT "are deeper than 36,200 feet.  Therefore, this calculator has not been"
232 PRINT "checked for accuracy for depths deeper than 36,200 feet.":PRINT:INPUT "Press ENTER (or RETURN) key to return to Main Menu",B$
233 GOTO 5
400 SYSTEM
