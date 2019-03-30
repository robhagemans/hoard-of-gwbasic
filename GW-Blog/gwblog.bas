10 REM ========================
11 REM The path to the blog
12 REM should be stored in
13 REM SITEDIR$.  This string
14 REM is auto-assigned by the
15 REM calling batch file
16 REM GO.BAT
17 REM ========================
20 REM
30 IF RIGHT$(SITEDIR$,1) = "\" THEN SITEDIR$ = LEFT$(SITEDIR$, LEN(SITEDIR$)-1)
500 REM =======================
501 REM Startup Code
502 REM =======================
509 REM Retrieve the current directory and configure subs
510 IF LEN(SITEDIR$) = 0 THEN GOSUB 15500 ELSE CURDIR$ = SITEDIR$
520 PAGEDIR$ = CURDIR$ + "\PAGES"
530 POSTDIR$ = CURDIR$ + "\POSTS"
540 STATICDIR$ = CURDIR$ + "\STATIC"
550 HDRFILE$ = CURDIR$ + "\POSTHDR.HTM"
560 FTRFILE$ = CURDIR$ + "\POSTFTR.HTM"
570 DESTDIR$ = CURDIR$ + "\BUILD"
700 REM =======================
701 REM Disk scanning
702 REM =======================

710 REM Scan pages first
720 DIREC$ = PAGEDIR$ + "\*.TXT"
730 GOSUB 15000
735 DIREC$ = PAGEDIR$
740 GOSUB 16000
750 DIM PAGES$[LC],PAGETIT$[LC]
760 PAGECNT=LC
770 FOR I=1 TO LC:PAGES$[I] = SFL$[I]:PAGETIT$[I] = TIT$[I]:NEXT I 

780 REM Scan posts
790 DIREC$ = POSTDIR$ + "\*.TXT"
800 GOSUB 15000
805 DIREC$ = POSTDIR$
810 GOSUB 16000
820 DIM POSTS$[LC],POSTTIT$[LC]
830 POSTCNT=LC
840 FOR I=1 TO LC:POSTS$[I] = SFL$[I]:POSTTIT$[I] = TIT$[I]:NEXT I 

850 PRINT "Processing";PAGECNT;" pages and";POSTCNT;" posts..."

900 REM =======================
901 REM Prepare template data
902 REM =======================
905 ILBL = 8:GOSUB 24000
910 DIM LBL$[ILBL+CFGCNT], REPL$[ILBL+CFGCNT]
915 LBL$[1] = "title":REPL$[1] = "Blog!"
920 LBL$[2] = "next":REPL$[2] = ""
925 LBL$[3] = "previous":REPL$[3] = ""
930 LINKURL$ = POSTS$[POSTCNT]:LINKLBL$="Latest Post":GOSUB 19000
935 LBL$[4] = "latest":REPL$[4] = LINKHTML$
940 URLCOUNT = PAGECNT:DIM URLS$[URLCOUNT], LBLS$[URLCOUNT]
945 FOR I = 1 TO URLCOUNT:URLS$[I] = PAGES$[I]:LBLS$[I] = PAGETIT$[I]:NEXT I
950 GOSUB 19100
955 ERASE URLS$, LBLS$
960 LBL$[5] = "pages":REPL$[5] = HTMLLST$
965 LBL$[6] = "date":REPL$[6] = ""
970 LBL$[7] = "postlist":REPL$[7] = "<a href='allposts.htm'>All Posts</a>"
975 LBL$[8] = "rss":REPL$[8] = "<a href='posts.rss'>RSS Feed</a>"
980 GOSUB 24100
990 ILBL = ILBL + CFGCNT

1000 REM ======================
1001 REM Process pages
1000 REM ======================
1120 FOR FINDEX = 1 TO PAGECNT
1125     PRINT "Processing ";PAGES$[FINDEX];"..."
1130     TFILE$ = PAGEDIR$ + "\" + PAGES$[FINDEX]
1135     PTITL$ = PAGETIT$[FINDEX]
1140     OUTFILE$ = DESTDIR$ + "\" + LEFT$(PAGES$[FINDEX], LEN(PAGES$[FINDEX])-3) + "HTM"
1150     GOSUB 6000
1160 NEXT FINDEX
1200 REM ======================
1201 REM Process posts
1202 REM ======================
1205 ERASE SFL$,TIT$
1210 DIM SFL$[POSTCNT], TIT$[POSTCNT]
1215 FOR I = 1 TO POSTCNT:SFL$[I] = POSTS$[I]:TIT$[I] = POSTTIT$[I]:NEXT I
1217 LC = POSTCNT
1220 FOR FINDEX = 1 TO POSTCNT
1225     PRINT "Processing ";POSTS$[FINDEX];"..."
1230     DIREC$ = POSTDIR$
1240     OUTFILE$ = DESTDIR$ + "\" + LEFT$(POSTS$[FINDEX], LEN(POSTS$[FINDEX])-3) + "HTM"
1250     GOSUB 5000
1260 NEXT FINDEX
1300 REM ======================
1301 REM Deploy static files
1302 REM ======================
1305 PRINT "Deploying static files..."
1310 SRCD$ = STATICDIR$
1320 DESTD$ = DESTDIR$ + "\STATIC"
1330 SHELL "MKDIR "+DESTD$
1340 GOSUB 21000
1400 REM ======================
1401 REM Index page
1402 REM ======================
1410 SRCD$ = DESTDIR$ + "\" + LEFT$(POSTS$[POSTCNT], LEN(POSTS$[POSTCNT])-3) + "HTM"
1420 DESTD$ = DESTDIR$ + "\INDEX.HTM"
1430 PRINT "Creating index.htm from latest post..."
1440 SHELL "COPY "+SRCD$+" "+DESTD$
1500 REM ======================
1501 REM List of all posts
1502 REM ======================
1505 PRINT "Generating a list of posts..."
1510 PTITL$ = "All Posts"
1520 TFILE$ = "allposts.tmp"
1530 OPEN TFILE$ FOR OUTPUT AS #9
1540 PRINT#9, "h1. List of All Posts"
1545 PRINT#9, ""
1550 FOR FINDEX = POSTCNT TO 1 STEP -1
1560     DT$ = LEFT$(POSTS$[FINDEX],4) + "-" + MID$(POSTS$[FINDEX],5,2) + "-" + MID$(POSTS$[FINDEX],7,2)
1570     LBL$ = POSTTIT$[FINDEX] + " (" + DT$ + ")"
1580     PRINT#9, "* ";CHR$(34);LBL$;CHR$(34);":";LEFT$(POSTS$[FINDEX], 8);".htm  "
1590 NEXT FINDEX
1600 PRINT#9, ""
1605 CLOSE#9
1610 OUTFILE$ = DESTDIR$ + "\ALLPOSTS.HTM"
1620 GOSUB 6000
1630 SHELL "DEL "+TFILE$
1700 PRINT "Creating an RSS feed..."
1710 GOSUB 8000
1990 PRINT "Site Generation Complete."
1998 SYSTEM
1999 END
