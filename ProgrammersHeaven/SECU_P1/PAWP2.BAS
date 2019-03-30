CLS
COLOR 14
PRINT "Password Pak Generator"
PRINT
INPUT "Name:", name$
INPUT "Password:", pass$
INPUT "Date:", ate$
INPUT "Ex. Date:", eate$
INPUT "Print(Y/N)?", p$
IF UCASE$(p$) = "Y" THEN GOTO pri:
END
pri:

PRINT
PRINT
PRINT
PRINT "   Password Pak News"
PRINT
PRINT "  " + name$
PRINT
PRINT "  As from " + ate$ + " your new password will be:"
PRINT
PRINT "          " + pass$
PRINT
PRINT
PRINT "   Expires on   " + eate$







LPRINT
LPRINT
LPRINT
LPRINT "   Password Pak News"
LPRINT
LPRINT "  " + name$
LPRINT
LPRINT "  As from " + ate$ + " your new password will be:"
LPRINT
LPRINT "          " + pass$
LPRINT
LPRINT
LPRINT "   Expires on   " + eate$

