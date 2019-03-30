@echo off
echo 
echo Backing up EBBS-PC main files ...
echo 
del c:\ebbs\*.zip
pkzip -pra -ex ebbsback c:\ebbs\*.*
rem pkzip -pra -ex bcback c:\bbschess\*.*
del a:ebbs*.zip
rem del a:bcb*.zip
copy c:\ebbs\*.zip a:
del c:\ebbs\*.zip
echo 
c:
cd \ebbs
echo 
echo EBBS Backup complete!
rem EBBS

