ECHO OFF
ECHO GW-Blog by Jeff Armstrong

IF NOT EXIST %1\POSTHDR.HTM GOTO NOLABEL
ECHO 1 SITEDIR$="%1" >> LOC.BAS

ECHO --
ECHO Creating the main BASIC program
COPY LOC.BAS+GWBLOG.BAS+RSS.BAS+DATE.BAS+POST.BAS+TXTILE.BAS+TMPLATE.BAS BLOG.TMP
COPY BLOG.TMP+FILES.BAS+TSORT.BAS+LINK.BAS+COPY.BAS+CONFIG.BAS BLOG.BAS
DEL BLOG.TMP
ECHO --
ECHO Launching GW-Blog
GWBASIC BLOG.BAS
ECHO --
ECHO Performing cleanup
DEL LOC.BAS
DEL BLOG.BAS

GOTO DONE

:NOLABEL
ECHO Usage: GO.BAT [absolute path to blog files]
ECHO --
ECHO Blog directory should contain:
ECHO     PAGES\      - Static pages for the blog
ECHO     POSTS\      - Date-encoded posts for the blog
ECHO     POSTHDR.HTM - HTML header with template tags
ECHO     POSTFTR.HTM - HTML footer with template tags
ECHO --
:DONE
