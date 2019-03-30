19000 REM ==============================
19001 REM Build a link
19002 REM
19003 REM INPUT - LINKURL$ - URL
19004 REM         LINKLBL$ - Label
19005 REM OUTPUT - LINKHTML$ - HTML link
19006 REM ==============================
19010 REM Check if the extension of a URL is TXT and change it
19020 EXTI = INSTR(LINKURL$, ".TXT") + INSTR(LINKURL$, ".txt")
19030 IF EXTI <> 0 AND LEN(LINKURL$) - EXTI = 3 THEN LURL$ = LEFT$(LINKURL$, LEN(LINKURL$)-3)+"htm" ELSE LURL$=LINKURL$
19040 LINKHTML$ = "<A HREF='"+LURL$+"'>"+LINKLBL$+"</A>"
19050 RETURN

19100 REM ==============================
19101 REM Build a list of links
19102 REM
19103 REM INPUT - URLS$ List of URLS
19104 REM         LBLS$ List of labels
19105 REM         URLCOUNT Length of
19106 REM                  arrays
19107 REM OUTPUT - HTMLLST$ - List HTML
19108 REM ==============================
19110 HTMLLST$ = "<UL>"
19120 FOR IU = 1 TO URLCOUNT
19130     LINKURL$ = URLS$[IU]
19140     LINKLBL$ = LBLS$[IU]
19150     GOSUB 19000
19160     HTMLLST$ = HTMLLST$+"<LI>"+LINKHTML$+"</LI>"
19170 NEXT IU
19180 HTMLLST$ = HTMLLST$ + "</UL>"
19190 RETURN
