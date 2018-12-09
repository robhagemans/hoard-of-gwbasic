    
     GeeWhiz:  Language information system for GW-BASIC programmers
   

     System notes:

     GeeWhiz will work in nearly any DOS compatible environment.  No
     wizard is needed to install it.  Simply COPY all of the G*.*
     files into a common path (or Windows folder).  Disk space needed
     is only about .5 meg--a little over 500,000 bytes.

     The default logic built into GeeWhiz expects all of its parts to
     be stored in a path (or folder) called \GW.  This can be changed,
     of course.  GW.BAT as delivered:

        \GW\GeeWhiz \GW

     If you prefer a path called Help, perhaps, modify GW.BAT thus:

        \Help\GeeWhiz \Help

     Even the batch file name can be different.  Like maybe, GO.BAT,
     or G.BAT.  Or, while in the correct path, simply type GeeWhiz.

     GeeWhiz.EXE needs little memory--only about 60kb of RAM.  And
     it operates in text mode on any type of monitor.  GeeWhiz looks
     best in color.  But, to run in monochrome mode, include /M as a
     command line switch.  GeeWhiz works with or without a Mouse.
     Some folks like rodents, gee whiz.

     GeeWhiz is able to output text pages to a printer (to LPT1:).
     To redirect output to LPT2, if preferred, include a command line
     switch like /P=LPT2: (the trailing colon is needed for printer
     designations).  As an alternative, output can be routed to a
     file.  Like:  /P=geewhiz.txt  (Successive pages will be appended
     to this same file, i.e., it is never deleted by GeeWhiz.)

     DOS 3.0 or later is needed.  Nothing about GeeWhiz is peculiar.
     It employs conventional DOS programming techniques throughout.
     Although the GW-BASIC definitions are specific to version 3.23
     of the interpreter, much of the information is applicable to
     earlier versions as well.

     Operation Notes:

     Type GW and hit <Enter> to start GeeWhiz.EXE from a batch file
     called GW.  In Windows, set up a shortcut to do the same thing,
     then set the properties to use a FULL SCREEN.

     An especially handy way to use GeeWhiz is to SHELL to it while
     running GW-BASIC.EXE.  Even nicer:  Assign a call string to a
     function key so you'll have a hot key for getting help with
     minimal brain strain.  (See F-keys while running GeeWhiz for
     more specific help on how to do this.)

     From there on, the <Esc> key will, at any point, exit GeeWhiz.
