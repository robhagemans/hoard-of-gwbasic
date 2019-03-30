' COLOUR.MOO

' Demonstrates direct screen write (and colour) function

' If you have QuickBASIC, PDS, or VB/DOS, compile the source below
' and compare size / speed.


$outstream _tty_str_direct

for b% = 0 to 7
  colour ?, b%
  for f% = 0 to 15
    colour f%
    print "þ"
  next
  colour ?, 0                 ' "?" means don't change current colour
  print "\n"                  ' LF/CR
next

end


' This is the equivalent QuickBASIC/PDS/VBDOS source:

' FOR b% = 0 TO 7
'   FOR f% = 0 TO 15
'     COLOR f%, b%
'     PRINT "þ";
'   NEXT
'   COLOR 7, 0
'   PRINT
' NEXT
