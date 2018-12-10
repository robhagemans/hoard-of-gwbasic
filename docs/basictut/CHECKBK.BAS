10 ' checkbk.bas
20 ' a simple check book balancing program
30 ' copyright 1987, 1992  s m estvanik
40 '
50 CLS
60 PRINT "Check Book Balancing Program"
70 PRINT
80 INPUT "What is your opening balance";BALANCE
90 PRINT
95 PRINT "Next transaction? (D/eposit, C/heck, Q/uit)"
100 T$=INPUT$(1)
110 IF T$ <> "D" AND T$<> "d" GOTO 210    ' is this a deposit?
120    INPUT "Amount of deposit";DEPOSIT
130    BALANCE = BALANCE + DEPOSIT        ' add to balance
140    PRINT USING "New balance is $#####.##";BALANCE
150       GOTO 90
210 IF T$ <> "C" AND T$<> "c" GOTO 300    ' is this a check?
220    INPUT "Amount of check";CHECK
230    BALANCE = BALANCE - CHECK          ' subtract from balance
240    PRINT USING "New balance is $#####.##";BALANCE
250       GOTO 90
300 IF T$ <> "Q" AND T$<> "q" GOTO 90    ' do they want to quit?
400 PRINT            ' we're done, so show the final balance
410 PRINT USING "Final balance is $#####.##";BALANCE   
430 END

