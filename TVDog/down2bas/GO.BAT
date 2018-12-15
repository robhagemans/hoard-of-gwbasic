echo off
echo Loading BASIC ... One Moment Please
if exist basica.com goto one
if exist basic.exe goto two
if exist gwbasic.exe goto three
echo ษออออออออออออออออออออออออออออออออออออออออออป
echo บ    Unable to Locate BASIC -- Transfer    บ
echo บ   Copy of BASICA, BASIC, or GWBASIC to   บ
echo บ This Disk or Sub-Directory and Try Again บ
echo ศออออออออออออออออออออออออออออออออออออออออออผ
goto quit 
:one
basica welcome
goto quit
:two
basic welcome
goto quit
:three
gwbasic welcome
:quit
cls
