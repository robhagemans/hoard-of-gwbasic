
 ch!ckuaua'z

    #####  #####   ####  ##   # #####    (((()) () ()     ())))) ((()))
   ##    # ##   # ##   # ##   # ##   #   ()     () ()     ()        ()
   ##      ##   # ##   # ##   # ##   #   ())))  () ()     ()))     ()
   ## #### #####  ##   # ##   # #####    ()     () ()     ()      ()
   ##    # ##   # ##   # ##   # ##       ()     () ()     ()     ()
    #####  ##   #  ####   ####  ##       ()     () ((())) ((())) ((()))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  -  -  -  -  -  - (C) 18.04.2000. ch!ckuaua [WackyS8FT]-  -  -  -  -  -  -
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 1. Auhor, info etc...
 2. The GRP file structure
 3. Bye !
 4. Doesen't exist
 5. JMP 6
 6. Visit http://www.wackysoft.cjb.net








 1. Author, info etc...
~~~~~~~~~~~~~~~~~~~~~~~~

  IDEA

   Do you have a game or program with soo many files that it is hard to
  distribute it or is it in such a mess or sumpthin' ? This may be the
  solution to your problems! The idea is to have many files in only one
  file. This is not so hard to make, so I did it.. I got the idea from
  DUKE 3D ;)


  INFO

   This version of GRP (1.00) supports files in only one directory, or
  ROOT. The files are not compressed whatsoever, and you can read them
  freely. This means, if you have a better solution or your files have
  an exact structure, you can read them directly from the GRP file.
   The GRP file is BINARY, or course. If you have a text file or want
  to load a file directly into memory, you'll have to extract it. It
  is a good idea to extract the necessary files at program start, so
  you don't waste that precious time.
   This GRP file type is made and developed in QBasic, but it can be
  also used in other programming languages (look 2. - GRP structure).
  This file should contain a QBasic DEMO program and a GRP file
  constuctor.


  AUTHOR

   Author: Teodor Tomic alias ch!ckuaua / GRiZLy
   e-mail: grizlyY2K@hotmail.com
      URL: http://www.wackysoft.cjb.net

    I made this program on a quickie, in a few hours, I had to make my
   homework (yes, homework, I'm 13)...


     NOTE: This program is FREEWARE EMAILWARE GIVEWARE DUMBWARE WHATEVERWARE
         and that means that you are encouraged to send mail to the author
         and tell your comments about the prog.


  FUTUR3 (if there is any)

   You can do something about the future of this program! Encourage me to
  make version 2 of GRP, wich includes directories and some other thingies...





 2. GRP structure
~~~~~~~~~~~~~~~~~~

 Identification               Position    Description
------------------------------------------------------------------------------
 GRPHeader                    0           The main header, contains ID,
                                          version, number of files

 FileHeader                   14          Contains info about a file - the
                                          File name, length, position in the
                                          GRP and handle. Repeated NumberOfFiles
                                          times.

 ** Files **                  ...         The actual files, they come right
                                          after the File headers. They are
                                          in the order 0..end



 GRPHeader

     ID           4 BYTES          "GRPï"
     Version      INTEGER          GRP Version
     NumDir       LONG             reserved - usually 0
     NumFiles     LONG             Number of files



 FileHeader

     FileName     12 BYTES         File name (XXXXXXX.XXX)
     FilePos      LONG             File position in GRP
     FileLen      LONG             File length
     FileNum      LONG             File handle (number)



  I hope you understand this, it shouldn't be very hard to understand if
 you're a good programmer. If not, you can send me mail and ask about what
 you don't understand. After all, I'm not such a good explainer myself...




 3. Bye!
~~~~~~~~~

  BYE
  QUIT
  EXIT
  END
  end.
  }




 4. Doesen't exist
~~~~~~~~~~~~~~~~~~~

  WARNING: This article doesen't exist and you never saw it. If you do read
           this, it may be fatal for you.




 5. JMP 6
~~~~~~~~~~
    GOTO 6
    GOSUB 6
    JMP 6





 6. Visit http://www.wackysoft.cjb.net
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Visit the WackyS8FT H™ME :

           http://www.wackysoft.cjb.net


  What will you find there ? I don't know yet - I suppose programs and infos
 and such things... I didn't make it on english yet...




----------------------------- FILE ENDS HERE -------------------------------

-------------------------------- CUT HERE ----------------------------------



------------------------- YOU MUST CUT ABOVE !!! ---------------------------
