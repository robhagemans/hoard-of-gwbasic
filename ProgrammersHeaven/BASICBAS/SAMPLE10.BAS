

 rem
 rem Here is another program which is fairly standard in it's
 rem use of the Basic language, but which uses some of the advanced
 rem Directory commands of BasicBasic.
 rem

  rem windows size 10,5,70,14

 REM THIS PROGRAM ALLOWS THE USER TO SEARCH A DISK LOOKING FOR
 REM A GIVEN FILE NAME.  IT WILL SEARCH ALL FILES BELOW THE USER
 REM ENTERED PATHNAME

 REM THIS PROGRAM CAN BE EASILY MODIFIED TO SEARCH ALL FILES FOR
 REM A PARTICULAR SEQUENCE OF BYTES


     COLOR 7,1
     cls

 rem
 rem Initialize some variables
 rem
     maxlevel=20
     direc=0
     dim direc(maxlevel)
     dim direcname$(maxlevel)
     dlevel=0
     numfiles=0
     numfound=0

 rem
 rem get starting directory to search
 rem and string to search for
 rem

 getinput:

    LOCATE 5,34
    COLOR 1,7
    PRINT "FIND FILE";
    COLOR 7,1
    locate 8,15
    print "Enter file name to search for:";
    locate 7,15
    input "Enter Starting Path: ";firstlevel$
    if firstlevel$="" then stop
    if len(firstlevel$)=1 then
      firstlevel$=firstlevel$+":\"
    end if
    if right$(firstlevel$,1)<>"\" then
        firstlevel$=firstlevel$+"\"
    end if
    locate 8,15
    input "Enter file name to search for: ";st$
    ST$=UCASE$(ST$)
    sd$=firstlevel$

 rem
 rem here is where we would check to make sure input strings are OK
 rem



newdirectory:

 rem
 rem Look for first file in new directory
 rem 

  sd$=firstlevel$
  for i=1 to dlevel
     sd$=sd$+direcname$(i)+"\"
  next i
  ffname$ = DIR$(sd$+"*.*")

 rem
 rem Now search each regular file in this directory (there may be none)
 rem

nextfile:
  IF ffname$ <> "" THEN
   numfiles=numfiles+1
   locate 10,15
   print ffname$;"           ";
   if ffname$=st$ then
    numfound=numfound+1
    locate 12,15
    print "Found in directory: ";sD$;
    locate 13,15
    print "Press any key to continue search";
250 if inkey$="" then goto 250
    locate 13,15
    print "                                ";
   end if

   rem
   rem If we wanted to look for text in file open it here and search
   rem

    if inkey$<>"" then stop
    ffname$ = DIR$
    GOTO nextfile
  END IF






rem
rem out of files at this level, look for next subdirectory at this level
rem

lookforsub:

     if direc(dlevel)=0 then

	rem
	rem Look for first sub directory from this level
	rem

	 sd$=firstlevel$
	 for i=1 to dlevel
	    sd$=sd$+direcname$(i)+"\"
	 next i
	 direc(dlevel)=1
	 ffname$ = DIR$(sd$+"*.*",5)
	 if ffname$="." then
	   ffname$ = DIR$
	 end if
	 if ffname$=".." then
	   ffname$=dir$
	 end if

     else

	rem
	rem Look for next sub directory from this level
	rem
	 sd$=firstlevel$
	 for i=1 to dlevel
	    sd$=sd$+direcname$(i)+"\"
	 next i
	 direc(dlevel)=direc(dlevel)+1
	 ffname$=dir$(sd$+"*.*",5)
	 if ffname$="." then
	   ffname$=dir$
	 end if
	 if ffname$=".." then
	   ffname$=dir$
	 end if
	 for i=2 to direc(dlevel)
	   ffname$=dir$
	 next i
     end if

     if ffname$="" then
    
	rem
	rem come here if no more sub directories at this level
	rem
	direc(dlevel)=0
	direcname$(dlevel)=""
	dlevel=dlevel-1
	if dlevel>=0 then goto lookforsub

	rem
	rem come here if no more directories at all
	rem
	    beep
	    beep
	    locate 12,15
	    print "Search Completed .  ";numfiles;" files searched ";numfound;" found.";
400         if inkey$="" then goto 400
	    stop


     else

	rem
	rem come here if have another sub-directory at this level
	rem
	dlevel=dlevel+1
	direcname$(dlevel)=ffname$
	goto newdirectory

     end if

