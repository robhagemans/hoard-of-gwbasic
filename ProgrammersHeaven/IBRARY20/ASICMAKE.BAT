@ECHO OFF
  IF "%1"=="" GOTO Info
  ASICC %1 B/OBJ LIB=IBRARY LNK=D:\COMPILER\ASIC
  GOTO Done
:Info
  ECHO This batch file compiles an ASIC program and links it with IBRARY.
  ECHO If you have not already done so, you must change the LNK= specification
  ECHO (on the third line of this .BAT file) to point to the subdirectory
  ECHO where you keep your LINK.EXE program.  Otherwise, just type:
  ECHO    ASICMAKE progname
  ECHO (where "progname" is the name of the program to compile).
  ECHO.
  ECHO See your ASIC manual for details on using libraries with ASIC and ASICC.
:Done
