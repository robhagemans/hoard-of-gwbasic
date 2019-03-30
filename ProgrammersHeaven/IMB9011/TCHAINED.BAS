'Support module TCHAINED.BAS

'$INCLUDE: 'TCHAINED.BI'

NoShared
ShareBlank

END

SUB NoShared

PRINT "Entering NoShared-----------------------------"
PRINT
PRINT "Blank Common -- X$="; X$, "Y$="; Y$, "Z$="; Z$
PRINT

END SUB

SUB ShareBlank

SHARED X$, Z$

PRINT "Entering ShareBlank --------------------------"
PRINT
PRINT "Blank Common -- X$="; X$, "Y$="; Y$, "Z$="; Z$
PRINT

END SUB

