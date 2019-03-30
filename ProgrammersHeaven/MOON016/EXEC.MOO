begin def

  strsegsize 128   ' We don't need much string memory for this example.

begin code

' *************************************
' Demo of shell command
' Format of exec function:
' var% = exec ("program","parameters")
' *************************************

print "Performing shell ... type EXIT to return.\n"

result% = exec("C:\\COMMAND.COM","")  ' note the double \\ so that it is not
                                      ' mistaken for an escape sequence.

print "\nBack from shell! Errorlevel returned = " + result% + "\n"
