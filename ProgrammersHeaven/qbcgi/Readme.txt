Qbasic CGI - Jan 2001
----------------------------------------------------------------------------------------

Intro
-----
I was toying with the ideal of using QBASIC for cgi programing and these are examples
of how basic can be used as a cgi language.  I've yet to get deeper, but looks like it
there is a whole new possiblities.  The only thing is, they run only on Win95/Win98/WinNT
servers.

Concept
---------
The whole approach builds around the idea of reading input from the environment variables.
Perl uses $ENV and in Qbasic/basic, we can use ENVIRON$ for the purpose. Both 'POST' and 'GET'
method in a HTML form is supported.


File List
---------
Sources  : - ENVLIST.BAS  (source code for env listing cgi)
             POSTMTH.BAS  (sources code for post method cgi)
	     GETMTH.BAS   (sources code for get method cgi)

HTML     : - POSTMTH.HTM  (html form for post method example)
             GETMTH.HTM   (html form for get method example)

Compiled : - ENVLIST.EXE  (cgi to list the Web Server's env)
	     POSTMTH.EXE  (post method cgi)
             GETMTH.EXE   (get method cgi)
	     BRUN45.EXE   (quickbasic 45 runtime)	

These programs are written in QuickBasic 45.  The runtime executable is needed if these files
are not compiled as stand alone application.  


Requirements
-------------
1.  A Win95/Win98/WinNt Web Server - I'm using Xitami WebServer for Windows.
                                     you can download a copy for free at the following site:
					
				     http://www.imatx.com

2.  QuickBasic 4.x compiler - for compiling.


Execution
---------
1.  Copy/upload the two html in webpages directory files into the webpage directory.
2.  copy/upload all the executables in cgi-bin directory into the cgi-bin directory of
    the web server.
3.  Access the html files via a Web Browser.


Have fun.
---------------------------------------------------------------------------------------
Benjimen Chan SW
Singapore
benjess@mbox2.singnet.com.sg