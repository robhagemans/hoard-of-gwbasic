@echo off
cd \
c:
cd \
cd ebbs
set COMSPEC=c:\command.com
set DSZLOG=C:\EBBS\DSZ.LOG
set DSZOPT=r
set GSZWINDOW=2
cls
echo                          Standby, Now booting EBBS-PC
ebbs-pc %1
cls


