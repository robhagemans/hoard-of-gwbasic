DECLARE SUB Back.Space (Row%, Col%, Num%)
DECLARE SUB BOX.IT (TROW%, LCOL%, BROW%, RCOL%, BOXTYPE%, BOXFG%, BOXBG%, FILLFG%, FILLBG%, FILLCHAR%, SHADOW%, TITLE$, HFG%, HBG%)
DECLARE SUB Cipher (St$, Password$)
DECLARE SUB CipherP (St$, Password$)
DECLARE SUB ClearBuffer (Buff%)
DECLARE SUB ClrKbd ()
DECLARE SUB CLREOL (XPOS%, YPOS%, BGC%)
DECLARE SUB CLRMOL (XPOS%, YPOS%, LENGTH%, BGC%)
DECLARE SUB CLRSOL (XPOS%, YPOS%, BGC%)
DECLARE SUB CLRSCRN (CLR%)
DECLARE SUB DE.LAY (BYVAL Seconds AS INTEGER)
DECLARE SUB DETECT.ANSI ()
DECLARE SUB DIS.PLAY (MSG$, FGC%, BGC%, BLINK%, BELL%, XPOS%, YPOS%, NL%, CENTER%, Caps%, Codes%)
DECLARE SUB ENTER ()
DECLARE SUB ERRORS (ERRNUM%, ERRLINE%)
DECLARE SUB EXIT.DOOR (YN$)
DECLARE SUB INITIALIZE ()
DECLARE SUB IN.PUT (RLEN%, WAITTIME&, IFG%, IBG%, AutoCR%, Text$, TFG%, TBG%, X%, Y%, SHOW%)
DECLARE SUB KEYTIMER (KEYSTART&)
DECLARE SUB LINES (SROW%, SCOL%, LENGTH%, DIR$, ENDS%, MID%, EFG%, EBG%, MFG%, MBG%)
DECLARE SUB MAKE.BLT (HI.SCORE&)
DECLARE SUB MAKE.BLT.CURRENT (HI.SCORE&)
DECLARE SUB MORE ()
DECLARE SUB MUSIC (TUNE$)
DECLARE SUB OUT.PUT (LF%)
DECLARE SUB SEND (FileName$, YN%, CLR%)
DECLARE SUB SENDANSI (FileName$, YN%, Inter%)
DECLARE SUB SHOW.BLT (YN$)

DECLARE FUNCTION CheckShare2% ()
DECLARE FUNCTION DriveSpace& (Drive$)
DECLARE FUNCTION EXISTS% (FileName AS STRING)
DECLARE FUNCTION EXIST2% (FileName$)
DECLARE FUNCTION NameCase2$ (St$)
DECLARE FUNCTION Sec2Time$ (Seconds&)
DECLARE FUNCTION Time2Sec& (TimeSt$)

DECLARE SUB BigPrint (St$, PixelCh$, BYVAL Row%, BYVAL Column%, BYVAL Attr%)
DECLARE SUB CalcAttr (BYVAL Fore%, BYVAL Back%, Attr%)
DECLARE SUB CalcDate (StartDate$, Days&, Direction%, NewDate$, ErrCode%)
DECLARE SUB CDROM (FirstDrive$, Drives%)
DECLARE SUB CheckDate (MonthNr%, DayNr%, YearNr%, ErrCode%)
DECLARE SUB CheckShare (ShareActive%)
DECLARE SUB DateA2R (MonthNr%, DayNr%, YearNr%, RelDate&)
DECLARE SUB DateN2S (MonthNr%, Day%, Year%, DateSt$)
DECLARE SUB DateR2A (MonthNr%, DayNr%, YearNr%, RelDate&)
DECLARE SUB DateS2N (MonthNr%, Day%, Year%, DateSt$)
DECLARE SUB DelFile (FileName$, ErrCode%)
DECLARE SUB DrvType (Drive$, Removeable%, Remote%, ErrCode%)
DECLARE SUB Elapsed (TimeStart$, TimeStop$, ElapsedT$)
DECLARE SUB EMSBuffer (Bytes%)
DECLARE SUB EMSClose (BYVAL ArrayHandle%)
DECLARE SUB EMSGet (BYVAL ArrayHandle%, ElementNr&, Value AS ANY)
DECLARE SUB EMSOpen (Elements&, ElementType%, ArrayHandle%, ErrCode%)
DECLARE SUB EMSPut (BYVAL ArrayHandle%, ElementNr&, Value AS ANY)
DECLARE SUB EMSRest (ArrayState$)
DECLARE SUB EMSSave (ArrayState$)
DECLARE SUB EnhKbd (BYVAL Enable%)
DECLARE SUB EuropeDate (DateSt$, FormatSt$, Result$, ErrCode%)
DECLARE SUB FindFirstF (FileName$, Attr%, ErrCode%)
DECLARE SUB FindNextF (ErrCode%)
DECLARE SUB FormatDate (DateSt$, FormatSt$, Result$, ErrCode%)
DECLARE SUB Get4DosV (MajorV%, MinorV%)
DECLARE SUB GetAttrF (Attr%)
DECLARE SUB GetDateF (MonthNr%, Day%, Year%)
DECLARE SUB GetDOSv (MajorVersion%, MinorVersion%)
DECLARE SUB GetDrv (Drive$)
DECLARE SUB GetDView (MajorV%, MinorV%)
DECLARE SUB GetExecPath (HomePath$, PathLen%)
DECLARE SUB GetKbd (INSERT%, Caps%, Num%, ScrollLock%)
DECLARE SUB GetKbd1 (LShift%, RShift%, Control%, Alt%)
DECLARE SUB GetLIMHandles (Handles%)
DECLARE SUB GetLIMm (TotalPages%, FreePages%)
DECLARE SUB GetLIMv (MajorVersionNum%, MinorVersionNum%)
DECLARE SUB GetNameF (FileName$, namelen%)
DECLARE SUB GetSizeFL (FileSize&)
DECLARE SUB GetSub (SubDir$, SubDirLen%)
DECLARE SUB GetSub1 (Drive$, SubDir$, SubDirLen%, ErrCode%)
DECLARE SUB GetTimeF (Hour%, Minute%, Second%)
DECLARE SUB GetTView (Installed%)
DECLARE SUB GetTVScreen (DSeg%, DOfs%)
DECLARE SUB KbdType (EnhancedKbd%)
DECLARE SUB LClose (BYVAL EMSHandle%)
DECLARE SUB LGet (BYVAL EMSHandle%, BYVAL DSeg%, BYVAL DOfs%, BYVAL WORDS%)
DECLARE SUB LOpen (BYVAL WORDS%, EMSHandle%, ErrCode%)
DECLARE SUB LPut (BYVAL EMSHandle%, BYVAL DSeg%, BYVAL DOfs%, BYVAL WORDS%)
DECLARE SUB LRotate (St$)
DECLARE SUB Namecase (St$)
DECLARE SUB Processor (CPU%)
DECLARE SUB Retries (BYVAL Tries%, BYVAL RetryPauseLen%)
DECLARE SUB Reverse (St$)
DECLARE SUB RInstr (MainSt$, SubSt$, Posn%)
DECLARE SUB SetError (BYVAL ErrorLevel%)
DECLARE SUB SetKbd (BYVAL INSERT%, BYVAL Caps%, BYVAL Num%, BYVAL ScrollLock%)
DECLARE SUB SubExist (SubDir$, IsThere%)
DECLARE SUB TInstr (St$, BYVAL ChrType%, Place%)
DECLARE SUB UnCalcAttr (FG%, BG%, BYVAL Attr%)
DECLARE SUB UpdTVScreen (DSeg%, DOfs%)
DECLARE SUB WinCheck (MajorV%, MinorV%)

'NOTE: The following variables are not universally available.
'      Check DFRAME.DOC for variables available to each BBS system's file.

COMMON SHARED Active.Menu%              '0=Main,1=Msg,2=File,3=Sysop (WC 3.0+)
COMMON SHARED Alias$                    'Caller's alias/handle
COMMON SHARED AllowedBytes&             'Allowed BYTES from the PCB PWRD file.
COMMON SHARED AlreadyConnected$         '"TRUE" or "FALSE"
COMMON SHARED AnsiOn$                   '"TRUE" or "FALSE"
COMMON SHARED AnsiSupport$              'Caller supports ANSI but in NG mode
COMMON SHARED Auto.Recycle%             '0 = Return control to programmer on
                                        'carrier loss. 1 = Automatic recyle
                                        'and return to BBS (Default).
COMMON SHARED Banked.Time%              'WildCat! v3.0+
COMMON SHARED BaudConn$                 'Connect rate of caller or "LOCAL"
COMMON SHARED BaudOpen$                 'Port opening BPS
COMMON SHARED BaudRate$                 'Baud and parity for DORINFO
COMMON SHARED BBSColor%                 'BBS default color code (1-15)
COMMON SHARED BBSDir$                   'Spitfire's home directory
COMMON SHARED BBSSys$                   'Name of the BBS
COMMON SHARED BBSName$                  'DORINFO
COMMON SHARED BirthDate$                'Caller's date of birth
COMMON SHARED BltPath$                  'Path of the high score bulletin.
COMMON SHARED CallAlarm%                'Caller alarm status.     -1=ON, 0=OFF
COMMON SHARED CallersLoc$               'Location of CALLERSx log
COMMON SHARED ChatStatus$               'Chat mode status. "U" or "A"
COMMON SHARED Check4RIP%                '0=No check for RIPscrip, non-zero=yes
COMMON SHARED City$                     'Caller's city and state
COMMON SHARED CNAMESLoc$                'Location of CNAMES
COMMON SHARED Command.Line$             'Y or N, WildCat! v3.0+
COMMON SHARED Comport%                  'COM port number
COMMON SHARED ConfReg$                  'Conference registration
COMMON SHARED Console$                  '"LOCAL" or "REMOTE"
COMMON SHARED Daily.Bytes.Alwd&         'Daily download max. K limit
COMMON SHARED DailyDnldBytes&           'Bytes downloaded so far today.
COMMON SHARED DataBits$                 '7 OR 8
COMMON SHARED DeleteFlag%               '1 = delete this record, 0 = keep
COMMON SHARED Display%                  'Local display status.    -1=ON, 0=OFF
COMMON SHARED DLPerDay&                 'Number of downloads allowed per day
COMMON SHARED DLToday&                  'Number of downloads made today
COMMON SHARED Door.DL&                  'WildCat 3.0+ # files DL'ed in door
COMMON SHARED Door.KB&                  'WildCat 3.0+ Total K DL'ed in door
COMMON SHARED Door.Logoff$              'WildCat 3.0+ Y or N if user logged
                                        'off from within the door
COMMON SHARED DoorNumber$               '
COMMON SHARED Doors.Opened%             'Number of Doors he has opened
COMMON SHARED DorInfo13th$              '13th line for RBBS DORINFO
COMMON SHARED Downloads&                'Number of downloads made
COMMON SHARED ECC%                      'Error corrected connect.  1=YES, 0=NO
COMMON SHARED EnterDoor$                'Time caller entered the door
COMMON SHARED Event$                    'Event time (hh:mm)
COMMON SHARED ExeName$                  'Name of .EXE (Programmer supplied)
COMMON SHARED ExitFrom$                 'Conference exited BBS from
COMMON SHARED Expert$                   'Expert mode - "Y" or "N"
COMMON SHARED Expire$                   'Caller's expiration date
COMMON SHARED ExpiredLevel&             'Expired Security level
COMMON SHARED ExtraTime&                'Number of seconds gained since logon
COMMON SHARED First$                    'Caller's first name
COMMON SHARED Fossil%                   '0 = No Fossil driver, 1 = yes
COMMON SHARED FrontEnd$                 '"TRUE" or "FALSE" if booted from a
                                        'front end program.
COMMON SHARED Graphics%                 'Graphics mode status.    -1=ON, 0=OFF
COMMON SHARED Hi.Ascii%                 '1 = Allow IN.PUT to accept ASCII
                                        'values 128 - 255. Default = 0
COMMON SHARED HPhone$                   'Caller's home phone number
COMMON SHARED IRQ%                      'For use with non-standard IRQ's
                                        '(other than IRQ3 or IRQ4)
COMMON SHARED Language$                 'PCBoard language extension
COMMON SHARED LastConf%                 'Conference number last in.
COMMON SHARED LastFArea$                'Last file area
COMMON SHARED LastMConf$                'Last message conference
COMMON SHARED LastMsg$                  'Last message read
COMMON SHARED LastOn$                   'Date caller last logged on (MM-DD-YY)
COMMON SHARED LastOnDate$               'Date and time of last call
COMMON SHARED LastScan$                 'Date of last directory/new files scan
COMMON SHARED LastTimeOn$               'Last time caller was on
COMMON SHARED Level&                    'Caller's security level
COMMON SHARED LocalUsr%                 '-1 = LOCAL mode, 0 = Online
COMMON SHARED LogonHrs$                 'Time caller logged on in HH:MM format
COMMON SHARED LogonMins%                'Time caller logged on in minutes
COMMON SHARED LogonSecs&                'Number of seconds since midnight
                                        'when caller logged on to the BBS.
COMMON SHARED LogonTimeDate$            'Date and time of this call
COMMON SHARED MaxBaud$                  'Maximum baud of the system
COMMON SHARED Max.Files%                'Maximum daily files available
COMMON SHARED MinsCredit%               'Time credits in minutes
COMMON SHARED MNP$                      '"MNP/ARQ Connection" or
                                        '"Normal Connection"
COMMON SHARED Mode%                     '0 = Non-color, -1 = color is on
COMMON SHARED Msgs.Left%                'Total messages left
COMMON SHARED Msgs.Read%                'Total messages read
COMMON SHARED Name$                     'Caller's full name
COMMON SHARED Network%                  '1 = BBS is networked, 0 = no network
COMMON SHARED Network$                  'DORINFO network type
COMMON SHARED NoCarrier%                '0 = Carrier present, 1 = No carrier
COMMON SHARED NodeNum%                  'Node number
COMMON SHARED NoDTELock$                '"TRUE" or "FALSE" if configured for
                                        'software data flow control.
COMMON SHARED No.Status%                '0 = Show Status lines, 1 = Don't
COMMON SHARED Owner$                    'DoorFrame registered owners name.
COMMON SHARED PageBell%                 'Page bell status.        -1=ON, 0=OFF
COMMON SHARED PageLen%                  'Caller's page length
COMMON SHARED Param$                    'Configuration filename
COMMON SHARED Parity%                   'Parity (word length?) (7 or 8)
COMMON SHARED Password$                 'Password of caller
COMMON SHARED PathGen$                  'Path to the GEN directory
                                        'Path to Allfiles.dat DIR for WC 3.0+
COMMON SHARED PathMain$                 'Path to the MAIN directory
                                        'Path to BBS dir. for WC 3.0+
COMMON SHARED PCBDat$                   'Location of PCBOARD.DAT
COMMON SHARED PCB.Version%              'PCBoard version number (i.e. 1450)
COMMON SHARED Printer%                  'Printer status.          -1=ON, 0=OFF
COMMON SHARED ProgName$                 'Name of DOOR (Programmer supplied)
COMMON SHARED Protocol$                 'Caller's default protocol (Z, X, etc)
COMMON SHARED Response$                 'Returned after a CALL to IN.PUT
COMMON SHARED Rip%                      '0=no RIPscrip detected, 1=yes
COMMON SHARED Rip$                      'Contains RIPscrip ver. # (if active)
COMMON SHARED RTS$                      ' Y = RTS/CTS, N = No RTS/CTS (TriBBS)
COMMON SHARED Sec.Level.Name$           'WildCat! v3.0+
COMMON SHARED Seconds&                  'Number of seconds since midnight
                                        'when caller entered the door.
COMMON SHARED Serial$
COMMON SHARED SysLoc$
COMMON SHARED Sysop%                    '1 = SYSOP is using DOOR, 0 otherwise
COMMON SHARED SysOpFirst$               'Sysop's first name
COMMON SHARED SysOpFlag$                '" ", "N"=Sysop Next, "X"=Exit to DOS
COMMON SHARED SysopKeys%                'Sysop keys 0=arrows, 1=alternate set
COMMON SHARED SysOpLast$                'Sysop's last name
COMMON SHARED SysOpName$                'Sysop's first and last names
COMMON SHARED SysOpNext$                '"TRUE" or "FALSE"
COMMON SHARED System.File%              '1 = PCBOARD.SYS     2 = USERS.SYS
                                        '3 = DOOR.SYS        4 = CALLINFO.BBS
                                        '5 = Not Used        6 = DORINFOx.DEF
                                        '7 = SFDOORS.DAT     8 = USERINFO.DAT
                                        '9 = GTUSER.BBS     10 = TRIBBS.SYS
COMMON SHARED TimeAdjust%               'Use to adjust the callers time
                                        'remaining online (in minutes).
COMMON SHARED TimeAlwd%                 'Minutes caller is allowed
COMMON SHARED TimeLastCall$             'Time of last call (hh:mm)
COMMON SHARED TimeLeft%                 'Time caller has left in minutes
COMMON SHARED TimeNow%                  'Current time in minutes
COMMON SHARED TimeOff$                  'Time caller exited the door
COMMON SHARED TimeOut%                  'Keyboard timeout in secs. default=300
COMMON SHARED TimesOn%                  'Number of times on system
COMMON SHARED TimeUsed%                 'Time used so far today in minutes
COMMON SHARED Total.Bytes.Alwd&         'Max. bytes allowed
COMMON SHARED Total.Bytes.Today&        'Daily download K total
COMMON SHARED Total.KB.Dl&              'Total K bytes downloaded
COMMON SHARED Total.KB.Ul&              'Total K bytes uploaded
COMMON SHARED TotDnldBytes&             'Total number of BYTES downloaded
COMMON SHARED TotUpldBytes&             'Total number of BYTES uploaded
COMMON SHARED Uploads&                  'Number of uploads made
COMMON SHARED UserComment$              'User maintained comment
COMMON SHARED UserNum%                  'Record number of caller
COMMON SHARED UserNetLoc$               'Location of PCBoard USERNET.DAT
COMMON SHARED UsersLoc$                 'Location of PCBOARD USERS file
COMMON SHARED Version$                  'DOOR version # (Programmer supplied)
COMMON SHARED WPhone$                   'Caller's work phone number

CONST BLACK = 0, BLUE = 1, GREEN = 2, CYAN = 3, RED = 4, MAGENTA = 5
CONST YELLOW = 6, WHITE = 7, GRAY = 8, LBLUE = 9, LGREEN = 10, LCYAN = 11
CONST LRED = 12, LMAGENTA = 13, LYELLOW = 14, LWHITE = 15


