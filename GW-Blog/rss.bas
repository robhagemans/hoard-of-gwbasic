8000 REM ============================
8001 REM Generate RSS file
8002 REM
8003 REM INPUTS - POSTS$ List of post
8005 REM                 files
8006 REM          POSTTIT$ List of
8007 REM                   titles
8008 REM          POSTCNT List length
8009 REM          DESTDIR$ Output dir
8010 REM          LBL$ Label array
8011 REM          REPL$ Replacements
8012 REM          ILBL Label array
8013 REM               length
8014 REM ============================
8020 OPEN DESTDIR$+"\posts.rss" FOR OUTPUT AS #9
8030 PRINT#9, "<?xml version='1.0' encoding='UTF-8' ?>"
8032 PRINT#9, "<rss version='2.0'>"
8034 PRINT#9, "<channel>"
8040 RTITLE$ = "Blog":RDESC$ = "A blog from BASIC":RLINK$ = "http://jeff.rainbow-100.com"
8050 FOR FINDEX = 1 TO ILBL
8060     IF LBL$[FINDEX] = "blog" THEN RTITLE$ = REPL$[FINDEX]
8070     IF LBL$[FINDEX] = "description" THEN RDESC$ = REPL$[FINDEX]
8075     IF LBL$[FINDEX] = "url" THEN RLINK$ = REPL$[FINDEX]
8080 NEXT FINDEX
8085 IF MID$(RLINK$, LEN(RLINK$), 1) <> "/" THEN RLINK$ = RLINK$ + "/"
8090 PRINT#9, "<title>";RTITLE$;"</title>"
8100 PRINT#9, "<description>";RDESC$;"</description>"
8110 PRINT#9, "<link>";RLINK$;"</link>"
8150 FOR FINDEX = 1 TO POSTCNT
8160     PRINT#9, "<item>"
8170     PRINT#9, "<title>";POSTTIT$[FINDEX];"</title>"
8173     POSTROOT$ = LEFT$(POSTS$[FINDEX], 8)
8180     PRINT#9, "<link>";RLINK$;POSTROOT$;".HTM";"</link>"
8190     D$ = POSTROOT$:GOSUB 8400
8200     PRINT#9, "<pubDate>";DFANCY$;"</pubDate>"
8210     PRINT#9, "</item>"
8220 NEXT FINDEX
8230 PRINT#9, "</channel>"
8240 PRINT#9, "</rss>"
8250 CLOSE#9
8260 RETURN

