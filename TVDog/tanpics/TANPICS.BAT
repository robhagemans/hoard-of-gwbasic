echo off
:main
cls
type tanpics.scr
getkey
if errorlevel 66 goto done
if errorlevel 65 goto tower
if errorlevel 58 goto done
if errorlevel 57 goto devil
if errorlevel 56 goto sonta
if errorlevel 55 goto cyber
if errorlevel 54 goto emper
if errorlevel 53 goto dalek
if errorlevel 52 goto k9
if errorlevel 51 goto ctlrm
if errorlevel 50 goto tards
if errorlevel 49 goto logo
if errorlevel 48 goto done
goto main
:tower
tanload tower
if errorlevel 1 goto done
goto main
:cyber
tanload cyberman
if errorlevel 1 goto done
goto main
:emper
tanload emperor
if errorlevel 1 goto done
goto main
:dalek
tanload dalek
if errorlevel 1 goto done
goto main
:devil
tanload seadevil
if errorlevel 1 goto done
goto main
:sonta
tanload sontaran
if errorlevel 1 goto done
goto main
:k9
tanload k-9
if errorlevel 1 goto done
goto main
:ctlrm
tanload ctrlroom
if errorlevel 1 goto done
goto main
:tards
tanload tardis
if errorlevel 1 goto done
goto main
:logo
tanload logo
if errorlevel 1 goto done
goto main
:done

