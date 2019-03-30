'Program -- TCOMMON.BAS

'This program test the different
'forms of the COMMON statement

DECLARE SUB SubMod2A ()
DECLARE SUB SubMod2B ()

COMMON X$, y$, z$

COMMON /FirstBlock/ A$
COMMON /SecondBlock/ B$

A$ = "FirstBlock value"
B$ = "SecondBlock value"
X$ = "First Common value"
y$ = "Second Common value"
z$ = "Third Common value"

CLS

CALL SubMod2A

CALL SubMod2B

END

