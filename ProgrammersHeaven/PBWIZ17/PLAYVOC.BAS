'   +----------------------------------------------------------------------+
'   |                                                                      |
'   |        PBWiz  Copyright (c) 1991-1993  Thomas G. Hanlin III          |
'   |                                                                      |
'   +----------------------------------------------------------------------+

' This is another simple demo of the PBWiz routines.  It allows you to play
' a digitized sound file (.VOC format) on a SoundBlaster.  The SBSIM driver,
' which is provided with the SoundBlaster, is required.

' Syntax:
'   PLAYVOC vocname[.VOC]

' The file extension is optional.

   DECLARE SUB SBGetActive (INTEGER, INTEGER, INTEGER, INTEGER, INTEGER)
   DECLARE FUNCTION SBInt% ()
   DECLARE SUB SBInitSrcFile (INTEGER, STRING, INTEGER)
   DECLARE SUB SBPlay (INTEGER)
   DECLARE SUB SBStop (INTEGER)

   $LINK "pbwiz.pbl"

   DEFINT A-Z



   '--- Pluck filename from command line.
   File$ = LTRIM$(RTRIM$(UCASE$(COMMAND$)))

   '--- If they didn't enter a filename, let's tell 'em about ourselves.
   IF ((LEN(File$) = 0) OR (INSTR(File$, "/?") > 0)) THEN
      PRINT "PLAYVOC: Digitized Sound Player for PBWiz by Thomas G. Hanlin III"
      PRINT
      PRINT "Syntax:"
      PRINT "  PLAYVOC vocname[.VOC]
      PRINT
      PRINT "The file extension is optional and defaults to .VOC.  This demo plays .VOC"
      PRINT "digitized sound files on a SoundBlaster, using the SBSIM driver."
      END
   END IF

   '--- Add .VOC extension if they didn't provide it.
   IF (INSTR(File$, ".") = 0) THEN File$ = File$ + ".VOC"

   '--- Check the SBSIM interrupt to make sure SBSIM is installed.
   IF (SBInt = 0) THEN
      PRINT "PLAYVOC requires the SBSIM driver to function.  SBSIM is provided with the"
      PRINT "SoundBlaster.  Go to your SoundBlaster directory and type SBSIM to install"
      PRINT "the driver before using PLAYVOC.  You will probably get some extraneous error"
      PRINT "messages from SBSIM-- ignore them.  PLAYVOC will tell you of any problem."
      END
   END IF

   '--- This is the number of the Disk Voice driver used for .VOC playing.
   DriverNr = 2

   '--- Here we initialize Disk Voice handling for our .VOC file.
   SBInitSrcFile DriverNr, File$, ErrCode
   IF ErrCode THEN
      PRINT "Error initializing "; File$; " for input.  Error code ="; ErrCode
      END
   END IF

   '--- This starts the .VOC file playing
   SBPlay DriverNr

   '--- The file plays in the background, so we could do something here.
   '--- In this case, though, we'll just wait for the file to finish.
   '--- We'll exit if <ESC> is pressed, in case they want out.
   DO
      SBGetActive FM, DskVoice, MemVoice, Auxiliary, MIDI
   LOOP UNTIL ((DskVoice = 0) OR (INKEY$ = CHR$(27)))

   '--- When we're done, we shut down the Disk Voice driver.
   SBStop DriverNr
