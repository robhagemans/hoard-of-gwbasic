'Module level code for the support module MODULE2.BAS

COMMON A$, B$, C$
COMMON /FirstBlock/ O$
COMMON /SecondBlock/ N$

SUB SubMod2A

SHARED O$, N$


PRINT "Entering SubMod2A"
PRINT "  with SHARED O$, N$"

PRINT "A$="; A$, "B$="; B$, "C$="; C$
PRINT "N$="; N$, "O$="; O$

PRINT "Leaving SubMod2A"
PRINT

END SUB

SUB SubMod2B

SHARED A$, B$, C$

PRINT "Entering SubMod2B"
PRINT "  with SHARED A$, B$, C$"
PRINT
PRINT "A$="; A$, "B$="; B$, "C$="; C$
PRINT "N$="; N$, "O$="; O$

PRINT "Leaving SubMod2B"
PRINT

END SUB

