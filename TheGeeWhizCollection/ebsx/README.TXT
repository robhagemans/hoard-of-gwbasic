      --------------------------------------------------------------------
    << EBS: Edit BSAVE Screens (SCREEN 0 text screens for BLOAD in BASIC) >>
      --------------------------------------------------------------------

     Hardware notes:

     EBS is designed to work with any color monitor.

     EBS will work on any disk configuration.  To use on a hard disk,
       set up a path and copy all of the files on the distribution disk
       into that path, according to regular DOS operating procedures.
       To use EBS on a rubber disk, copy all of the files on the
       distribution disk onto one that has been formatted as a system
       disk.

     EBS itself needs little memory: only about 80kb of RAM.


     Software notes:

     DOS 3.2 or later is expected.  Nothing about EBS is "peculiar" --
       it was designed so that it can be used in any DOS machine, and
       only conventional programming techniques were used throughout.

     EBS needs no CONFIG.SYS or special drivers.

     EBS is simply an <.EXE> file; it can be invoked by other programs,
       or from within BAT files.  EBS does depend on its own mask files
       (EBS.MF?) being in the same path as EBS.EXE.


     File notes:

     EBS generates two types of files:  MASK files and an EBS.DIR file.
       MASK files are your own "screen images".  The EBS.DIR file is a
       work file that EBS uses to hold a list of your MASK file names.

     EBS permits any file naming convention tolerable to DOS.  It is
       suggested that an extension such as <.MSK> be used, or something
       similar, to help you distinguish among various files.  No safety
       checks are made by EBS.  You can "load" anything as a MASK file.
       No damage is likely, but garbage behold.  It is also possible to
       clobber data files with EBS.  Caveat.  You name files to be saved.
       Note:  If your name exactly matches an existing file it will be
       overwritten if it is not protected in some manner.


     Operation Notes:

     To start EBS simply type EBS and hit <Enter>.

     EBS starts up in "menu mode".  The menu is really a list of F-key
       (function key) assignments.  Each of the F-keys 2-10 display help
       pages that describe how to use EBS; <F1> can be used anytime to
       get back to the menu.  Interestingly enough, all of the screens
       that EBS displays were, in fact, designed using EBS itself.


     Technical Notes:

     EBS was developed and written in GW-BASIC.  For better speed on
       antique PCs, EBS was compiled with QB 2.0.  The GWB version
       works perfectly well, however, and can be easily modified to
       suit your own ideas about how it should work.  EBS runs
       entirely in text mode, i.e., SCREEN 0, WIDTH 80.

     The screen image files that EBS generates are done with BSAVE, with
       DEF SEG=&HB800.  Only one line needs to be changed to make it
       work equally well on monochrome monitors.  See the source code.
       A REM line near the beginning shows what is needed for mono.

     Only one line needs to be changed to be able to compile the source
     program with QB 2.0.  Delete line 1020 or make it a REM, first.

     The offset that EBS uses in conjuction with BSAVE is a function of
       which screen lines (1-25) are to be captured.  The length value
       used with BSAVE is a function of how many lines are to be saved.

     To use BLOAD, in BASIC, to blast a mask on the screen, use the
       following command sequence:

       100 DEF SEG=&HB800           'use &HB000 for mono-monitors
       110 BLOAD "filespec",I       'blast the mask
       120 DEF SEG                  'restore default segment address

     In line 110 above, the I-argument is not needed IF the BLOAD image
       is being loaded on the same type monitor as the original BSAVE
       was done on, and you want the image in the same place.
         
     Opportunity:  Suppose you created a 4-line "mask" on lines 1-4.
       And you now want to load those four lines on lines 21-25.  The
       I-value to use would be 3200 (20*160) because each text line
       consists of 160 bytes.
         
     The I-value must be given in the event you are switching monitors;
       that is, if a BSAVE was done on a color monitor but the BLOAD is
       being done on a mono-monitor.  Or vice versa.

                         
     Source Notes:

     EBS was originally a PC shareware product developed by

         Thomas C McIntire, 635 Kendrick Road, Milner, GA 30257

       which is who you should write to about specific issues that
       concern the way EBS works (or doesn't).  Although he is
       retired now, Tom enjoys exchanging E-mail with serious
       students of the GW-BASIC programming language.

         Tom's E-mail address is:  whizware@bellsouth.net
