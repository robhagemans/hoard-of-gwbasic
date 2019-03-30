100 REM Parallel.bas
110 REM M. Brutman sometime in 2003
120 REM Put port in output mode
130 REM Use to figure out if you have a bi-di parallel port.
140 I = INP(&H37A)
150 OUT &H371, ( I AND &HDF )
160 REM test for presence of port
170 OUT &H378, 174
180 IF INP( &H378) <> 174 THEN PRINT "Parallel port not detected.":END
190 OUT &H378, 67
200 IF INP( &H378) <> 67  THEN PRINT "Parallel port not detected.":END
210 REM Put the port in PS/2 mode (bi-directional)
220 I = INP(&H37A)
230 OUT &H37A, ( I OR  &H20 )
240 OUT &H378, 75
250 IF INP( &H378) <> 75  THEN PRINT "PS/2 bi-directional port detected.":END
260 OUT &H378, 223
270 IF INP( &H378) <> 223 THEN PRINT "PS/2 bi-directional port detected.":END
280 PRINT "You have a standard parallel port."
