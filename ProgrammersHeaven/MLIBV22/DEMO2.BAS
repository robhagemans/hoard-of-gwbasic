DEFINT A-Z
'******************************** DEMO2.BAS *********************************
'*                                                                          *
'*     : Demo on how to use the function; ShowPtrM%.                        *
'*     :                                                                    *
'* NOTE: In order for this demo to run you must start the QB editor         *
'*     : along with the library MLIBN.QLB  (ie., QB/L MLIBN).               *
'*     :                                                                    *
'*     : IF YOU ARE NOT USING QuickBASIC 4.0- 4.5 SEE PAGE 2 OF THE MANUAL  *
'*     : BEFORE TRYING TO RUN THIS DEMO!                                    *
'*     :                                                                    *
'*                                                                          *
'****************************************************************************
'                                                '
'$INCLUDE: 'mlib.inc'                            '
                                                 '
DECLARE SUB GetInput (NumCalls%)                 '
DECLARE SUB KP ()                                '
DECLARE SUB M1 ()                                '
DECLARE SUB M2 (X%)                              '
DECLARE SUB MP ()                                '
                                                 '
SCREEN 0: CLS                                    '
                                                 '
CALL InitPointer(X%)                             'Must initialize the mouse.
                                                 '
M1                                               'Message 1.
                                                 '
CALL ShowPointer                                 '
                                                 '
GetInput NumCalls%                               '
                                                 '
FOR z = 1 TO NumCalls%                           'Hide X number of times.
   CALL HidePointer                              '
NEXT                                             '
                                                 '
M2 (NumCalls%)                                   'Message 2.
MP                                               'Check mem.
                                                 '
BSize% = GetSizeM%                               'Get mouse state size, in
                                                 'bytes.
Buffer$ = SPACE$(BSize% * 2)                     'Build buffer for asm proc.
                                                 '
ErrNm% = ShowPtrM%(Buffer$)                      'Do it.
                                                 '
MP                                               'Print mem used.
                                                 '
Buffer$ = ""                                     'Release mem.
                                                 '
IF ErrNm% THEN                                   'Unable to complete task.
                                                 '
   PRINT "ERROR! Unable to complete task..."     'Insufficient buffer size.
   BEEP                                          '
                                                 '
ELSE                                             'Job done.
                                                 '
   PRINT "Pointer is now visible again..."       '
                                                 '
END IF                                           '
                                                 '
KP                                               'Pause for a key press.
CALL HidePointer: CLS : END                      'We are done.

DEFSNG A-Z
'
'*******************************
'
'Number of calls to HidePointer.
'
'*******************************
'
SUB GetInput (NumCalls%)

IP:

INPUT "Hide the pointer how many times [1 to 100]"; NumCalls%: CLS
IF NumCalls% < 1 OR NumCalls% > 100 THEN PRINT "Redo..": GOTO IP

END SUB

SUB KP

VIEW PRINT

LOCATE 24

HidePointer
PRINT "Press a key to continue..."
ShowPointer

Hld$ = INPUT$(1)

CLS

END SUB

SUB M1

PRINT "                Demo on how to use the function ShowPtrM%."
PRINT "                =================================================="
PRINT
PRINT "                First we must initialize the mouse and show the"
PRINT "                mouse pointer. Then we will call HidePointer a"
PRINT "                few times (pretending our program lost track of"
PRINT "                how many times we hid the pointer)."
PRINT
PRINT "                Next we will call ShowPtrM%, this will restore"
PRINT "                the mouse pointer on the screen."
PRINT
PRINT "                --------------------------------------------------"
PRINT
PRINT "                DECLARE FUNCTION ShowPtrM%(Buffer$)"
PRINT "                Syntax: ErrNum% = ShowPtrM%(Buffer$)"
PRINT
PRINT "                ErrNum% returns a -1, if unsuccessful."
PRINT "                See the manual for more information."
PRINT
PRINT "                --------------------------------------------------"
PRINT "                                               Assembler function."

KP

PRINT

END SUB

SUB M2 (X%)

PRINT
PRINT "       ------------------------------------------------------------"
PRINT
PRINT "       Mouse Driver keeps count by:"
PRINT
PRINT "        - Each call to HidePointer, will increment count by one"
PRINT
PRINT "        - Each call to ShowPointer, will decrement count by one."
PRINT
PRINT "        - Pointer is visible only when the count equals zero."
PRINT
PRINT "       What ShowPtrM% does:"
PRINT
PRINT "        - Check count value and reset it to zero."
PRINT
PRINT "       ------------------------------------------------------------"
PRINT
PRINT "       Now that we have called HidePointer "; X%; " times, the next job"
PRINT "       is tell ShowPtrM% to restore the pointer on the screen."


KP

END SUB

DEFINT A-Z
SUB MP STATIC

IF NOT X THEN
   MEM1& = FRE(-1)
   X = -1
ELSE
   MEM2& = FRE(-1)
   MEM3& = MEM1& - MEM2&
   PRINT "Amount of memory used: "; MEM3&; " bytes."
   X = 0
END IF

END SUB

