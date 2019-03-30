' Program Summary:
' This program demonstrates the use of the cursor keys in Quick or Q Basic.
' It is thuroghly commented, and no operations are squished togeather with
' colons to make it look smaller, and therefore harder to read.
' Use freely in other programs etc.
' Programmed by Robert King.
'
' Set the default (first) option.
optn = 1
' Draw the starting screen
CLS
LOCATE 1, 1
'
' Color 0, 15 sets up the colour for the preset option.
'
COLOR 0, 15
PRINT "Option 1"
' Use normal colours.
COLOR 3, 0
PRINT "Option 2"
PRINT "Option 3"
PRINT "Option 4"
PRINT "Exit...."
'
' Wait for a key to be pressed...
' In an input feed loop like this, you can put mouse checking in too, so that
' your user has a choice between the mouse and the keyboard for selecting
' buttons and menus.
'
10 a$ = INKEY$
'
' The RIGHT$(a$,1) gets the low byte of the key pressed.  If set, the key is a
' cursor key, otherwise it is just a normal capital H, P, K, or M.
' That is how to differentiate between the normal keys and cursor keys.
'
IF RIGHT$(a$, 1) = "H" THEN GOSUB up   ' Up key
IF RIGHT$(a$, 1) = "P" THEN GOSUB down ' Down key
'
'
' We are only concerned with the UP/DOWN keys, but these are the L/R codes
'
'
'IF RIGHT$(a$, 1) = "M" THEN GOSUB left' Left cursor key
'IF RIGHT$(a$, 1) = "K" THEN GOSUB right' Right cursor key
'
' Go and take action according to which option is selected.
'
IF a$ = CHR$(13) THEN GOSUB go
LOCATE 10, 1
'
' Show what option is currently selected.  The option in the menu is in
' reversed video too.
'
PRINT "Hilighted Option:"; optn

GOTO 10
'
' When the person pushes the up arrow key:
'
up:
        ' Another good trick is to set the option for the second highest
        ' number, and then call the down sub to set the bottom option
        ' instead. Here we will just go back to the input loop.
        '
        IF optn = 1 THEN RETURN
        '
        ' Decrement the value accordingly
        '
        optn = optn - 1
        '
        ' Draw option 1 as selected, and reset all the others.
        '
        IF optn = 1 THEN
                LOCATE 1, 1
                COLOR 0, 15
                PRINT "Option 1"
                '
                ' Begin resetting all the others
                '
                COLOR 3, 0
                LOCATE 2, 1
                PRINT "Option 2"
                LOCATE 3, 1
                PRINT "Option 3"
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                PRINT "Exit...."
                '
                ' Make SURE the option number is set, and go back to where
                ' we came from.
                '
                optn = 1
                RETURN
        END IF
        '
        ' Selects option 2, this is the same deal for the others here and in
        ' the down section.
        '
        IF optn = 2 THEN
                LOCATE 2, 1
                COLOR 0, 15
                PRINT "Option 2"
                COLOR 3, 0
                LOCATE 1, 1
                PRINT "Option 1"
                LOCATE 3, 1
                PRINT "Option 3"
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 2
                RETURN
        END IF
        IF optn = 3 THEN
                LOCATE 2, 1
                COLOR 3, 0
                PRINT "Option 2"
                LOCATE 1, 1
                PRINT "Option 1"
                COLOR 0, 15
                LOCATE 3, 1
                PRINT "Option 3"
                COLOR 3, 0
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 3
                RETURN
        END IF
        IF optn = 4 THEN
                LOCATE 2, 1
                COLOR 3, 0
                PRINT "Option 2"
                LOCATE 1, 1
                PRINT "Option 1"
                LOCATE 3, 1
                PRINT "Option 3"
                COLOR 0, 15
                LOCATE 4, 1
                PRINT "Option 4"
                COLOR 3, 0
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 4
                RETURN
        END IF
        '
        ' There is no programming to take care of option 5, as it can only 
        ' be selected with the down arrow key.
        '
        RETURN
down:
        IF optn = 5 THEN RETURN
        optn = optn + 1
        ' Draw Option 2
        IF optn = 2 THEN
                LOCATE 2, 1
                COLOR 0, 15
                PRINT "Option 2"
                COLOR 3, 0
                LOCATE 1, 1
                PRINT "Option 1"
                LOCATE 3, 1
                PRINT "Option 3"
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 2
                RETURN
        END IF
        IF optn = 3 THEN
                LOCATE 2, 1
                COLOR 3, 0
                PRINT "Option 2"
                LOCATE 1, 1
                PRINT "Option 1"
                COLOR 0, 15
                LOCATE 3, 1
                PRINT "Option 3"
                COLOR 3, 0
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 3
                RETURN
        END IF
        IF optn = 4 THEN
                LOCATE 2, 1
                COLOR 3, 0
                PRINT "Option 2"
                LOCATE 1, 1
                PRINT "Option 1"
                LOCATE 3, 1
                PRINT "Option 3"
                COLOR 0, 15
                LOCATE 4, 1
                PRINT "Option 4"
                COLOR 3, 0
                LOCATE 5, 1
                PRINT "Exit...."
                optn = 4
                RETURN
        END IF
        IF optn = 5 THEN
                LOCATE 2, 1
                COLOR 3, 0
                PRINT "Option 2"
                LOCATE 1, 1
                PRINT "Option 1"
                LOCATE 3, 1
                PRINT "Option 3"
                LOCATE 4, 1
                PRINT "Option 4"
                LOCATE 5, 1
                COLOR 0, 15
                PRINT "Exit...."
                COLOR 3, 0
                optn = 5
                RETURN
        '
        ' There is no programming here to take care of selecting option 1 as
        ' it can only be selected with the up arrow key.  This saves on two
        ' chunks of code. (For the first and last options)
        '
        END IF
        RETURN
go:
'  
' Take any appropriate action based on which option is selected.
' If the option is one of the dummy options, the option number indicator at
' the top (The "Option: X"), is changed so that the colour is the number of
' the option.  EX. If someone pressed enter on #4, that would display in
' colour 4 etc.
'   
        '
        ' The first four are dummy options that show how to tell which has had
        ' the enter key pressed while selected.
        '
        IF optn = 1 THEN
                LOCATE 10, 8
                COLOR 1
                PRINT "1"
                RETURN
        END IF
        IF optn = 2 THEN
                LOCATE 10, 8
                COLOR 2
                PRINT "2"
                RETURN
        END IF
        IF optn = 3 THEN
                LOCATE 10, 8
                COLOR 3
                PRINT "3"
                RETURN
        END IF
        IF optn = 4 THEN
                LOCATE 10, 8
                COLOR 4
                PRINT "4"
                RETURN
        END IF
        '
        ' This is the only option that is not a dummy.
        '
        IF optn = 5 THEN
                LOCATE 10, 1
                COLOR 5
                PRINT "Option: 5"
                END
                RETURN
        END IF
RETURN




