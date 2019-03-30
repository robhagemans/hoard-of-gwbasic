ECHO Edit this batch file to remove the /EX switch if you are using PKLITE
ECHO or LZEXE this file.  You will have to modify the paths if necessary
ECHO to point to the correct places  (PDS and up!).
PAUSE
C:\QB\BC BROWSER /O/AH;
C:\QB\LINK /EX /PACKC:64000 /FARC /NOE BROWSER+C:\QB\NOCOM,,,C:\QB\BCOM45+SUPERHEX;
