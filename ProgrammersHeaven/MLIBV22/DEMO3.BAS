DEFINT A-Z
'******************************** DEMO3.BAS *********************************
'*                                                                          *
'*       Demo on how to use : GetSizeM%                                     *
'*                          : SaveStateM                                    *
'*                          : RestoreStateM                                 *
'*                                                                          *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0 - 4.5 SEE PAGE 2 OF THE MANUAL *
'*     : BEFORE TRYING TO RUN THIS DEMO!                                    *
'*                                                                          *
'****************************************************************************
'                                                '
'$INCLUDE: 'mlib.inc'                            '
                                                 '
DECLARE SUB PrintMsg ()                          '
DECLARE SUB ChangeState ()                       '
                                                 '
SCREEN 0: CLS                                    '
                                                 '
CALL InitPointer(X%)                             'Must initialize the mouse.
                                                 '
CALL ShowPointer                                 '
                                                 '
CALL PrintMsg

BSize% = GetSizeM%                               'Get mouse state size, in
                                                 'bytes.
Buffer$ = SPACE$(BSize%)                         'Buffer to hold environment.
                                                 '
CALL SaveStateM(Buffer$, SaveErr%)               'Save the mouse environment.
                                                 '
IF NOT SaveErr% THEN                             '
   CALL HidePointer                              '
   CALL ChangeState                              '
   SCREEN 0                                      '
END IF                                           'NOTE! If Buffer$ is changed
                                                 'in any way now that it holds
                                                 'the mouse environment, you
                                                 'will effectivly lock up
                                                 'your system.
                                                 '
CALL RestoreStateM(Buffer$, RestoreErr%)         'Restore mouse environment
                                                 'to it's original state prior
CALL HidePointer                                 'to calling ChangeState.
                                                 
PRINT "Size of the mouse environment: "; BSize%; " bytes."

IF SaveErr% THEN
   PRINT "Error in saving the mouse environment."
ELSE
   PRINT "Mouse environment was successfully saved."
END IF

IF RestoreErr% THEN
   PRINT "Error in restoring the mouse environment."
ELSE
   PRINT "Mouse environment was successfully restored."
   PRINT "Pointer should be in the same position"
   PRINT "as it was before we changed screen modes."
END IF

CALL ShowPointer: a$ = INPUT$(1): CALL HidePointer

END

SUB ChangeState

SCREEN 9
PRINT "Initializing the mouse..."

CALL InitPointer(X%)
LOCATE 1, 1
PRINT "What we have done here is change to a graphics mode and initialized the"
PRINT "mouse (which will alter the mouse state). Now we could use this instance"
PRINT "of the mouse to do what ever we liked. After we are done in here we will"
PRINT "restore the mouse state back to its original settings (SCREEN 0)."
PRINT
PRINT "Press a key to return..."

CALL ShowPointer

DO: LOOP UNTIL LEN(INKEY$)

CALL HidePointer

END SUB

SUB PrintMsg

PRINT "This example demonstrates how to save and restore the mouse environment."
PRINT
PRINT "First move the pointer to a position you will remember. After a key has"
PRINT "been pressed, we will save the mouse driver's environment and call a"
PRINT "subroutine that will alter the state of the mouse."
PRINT
PRINT "Remember the pointer position."           '
PRINT "Press a key to continue.": a$ = INPUT$(1) '

END SUB

