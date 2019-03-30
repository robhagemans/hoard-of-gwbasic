@ECHO OFF
CLS
ECHO ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
ECHO              CREATE LIBRARIES =WITHOUT= MOUSE FUNCTIONS
ECHO ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
ECHO This batch file will create a library (LITE.LIB) and QuickLibrary
ECHO (LITE.QLB) that is compatible with Microsoft(R) QuickBASIC 4.5 ONLY.
ECHO For a Microsoft(R) BASIC PDS 7.1 compatible version, please call us.
ECHO ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
PAUSE
IF EXIST LITE.LIB DEL LITE.LIB
LIB LITE +WINDOW.LIB+NOMOUSE.LIB+DRIVER.LIB;
IF NOT EXIST LITE.LIB GOTO LIBFAILED
IF EXIST LITE.QLB DEL LITE.QLB
SET LINK=/SE:192
LINK /Q /NOE +LITE.LIB,,,BQLB45;
IF NOT EXIST LITE.QLB GOTO LINKFAILED
:SUCCESS
CLS
ECHO ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
ECHO                            CONGRATULATIONS!
ECHO ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
ECHO You now have a library (LITE.LIB) and QuickLibrary (LITE.QLB) that is
ECHO compatible with Microsoft(R) QuickBASIC 4.5.
ECHO ÿ
ECHO To make use of this library, you must load BASIC EXACTLY as follows:
ECHO ÿ
ECHO         QB /AH /L LITE.QLB
ECHO ÿ
ECHO ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
GOTO BYE

:LIBFAILED
ECHO ÿ
ECHO ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
ECHO             ERROR: LIB.EXE FAILED WHILE CREATING "LITE.LIB"
ECHO ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
ECHO For some reason, the library manager (LIB.EXE) could not build the
ECHO library.  It is possible that it could not find the files it needed to
ECHO build the library.  Please make sure that the following files are in
ECHO the same directory as this batch file: NOMOUSE.LIB, DRIVER.LIB, and
ECHO WINDOW.LIB.
ECHO ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
GOTO BYE

:LINKFAILED
ECHO ÿ
ECHO ฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
ECHO            ERROR: LINK.EXE FAILED WHILE CREATING "LITE.QLB"
ECHO ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
ECHO For some reason, the linker (LINK.EXE) could not build the Quick
ECHO Library.  If the error deals with the "/Q" option, then you are using
ECHO the WRONG version of link.  Both DOS and BASIC come with their own
ECHO version of LINK.EXE.  YOU MUST USE THE VERSION THAT CAME WITH BASIC.
ECHO ออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
GOTO BYE

:BYE
