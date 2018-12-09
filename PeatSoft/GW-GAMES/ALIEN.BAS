1 COMMON A$(), D$(), I$(), A$, JAMAL, A, B, X(), JU$
5 ON ERROR GOTO 9900
100 'ADVENTUREII
101 NOTHING$ = "  You don't see anything of interest..."
102 REM  $STATIC
103 ERASED = 1
104 SCREEN 0, 0, 0: WIDTH 80
110 CLEAR : CLS : KEY ON: ON ERROR GOTO 9900
115 CLS : INPUT "Play in 80 or 40 columns: "; COLMN
116 IF COLMN <> 40 AND COLMN <> 80 THEN INPUT "Enter 80 or 40: "; COLMN: GOTO 116 ELSE GOTO 119
119 INPUT "Please enter Your Name. (The default is Alex Fernandez) - ", A$:         IF A$ = "" THEN A$ = "Alex Fernandez"
120 DIM A$(25, 11), D$(25, 11), X(50), I$(5, 16), JU$(12)
125 'DIM PRICE(16), ITEM$(16)
130 W$ = "Weather looks as good as it could be."
140 A = 22: B = 10: P = 3: L = 2: K = 4: K1 = 9: C = 0: R = 0: MONEY = 50
150 'STRING ASSIGNMENTS
155 D$ = "  You are on a vast plain that extends  in all directions. Mountains lie low on the horizen to the south..."
160 FOR X = 0 TO 11
170 A$(1, X) = D$
180 NEXT X
184 FOR X = 3 TO 6
186 D$(1, X) = "  Impassable cliffs"
188 NEXT X
189 OPENTHEDOOR$ = "You need to open the door first."
190 A$(2, 1) = "  You are beside a huge spike of rock   that sticks up out of the plain. It is  impossible to climb. Mountains visible  to the east and south..."
193 A$(1, 0) = "  It looks to Me like You are lost! You wander around for a time and eventually You fall down, dying from lack of liq-  uid...too bad!"
200 A$(2, 2) = "  Huge cliffs dominate the scenery: the only entrance to the mountains appears  to be a steep path up between two sheer rock faces (heading south)."
210 A$(3, 1) = "  Huge cliffs dominate the scenery: the only entrance to the mountains appears  to be a steep path up between two sheer rock faces (heading east)..."
220 A$(3, 2) = "  You are on a steep slope. Before you  lies a skeleton in a tattered uniform.  It is reclining against a vertical      wedge of rock. Above you and to the     east is what looks like a flat ridge..."
230 D$(3, 2) = "  There is a regulation blaster next    to the corpse of the unfortunate UGF    trooper. The blaster looks like it's in fairly decent shape...good for one shot at least!"
240 A$(3, 3) = "  You are on top of a ridge. East of    you is a gully and a cave. In all the   other directions except west are steep  drop-offs..."
245 A$(3, 4) = "  You are in a narrow gully. The only   way to go is east or west..."
250 A$(3, 5) = "  Immediately south of you is the en-   trance to the cave. To the east there   is another ridge..."
260 D$(3, 5) = "  That cave looks dark!"
270 FOR X = 7 TO 10
280 A$(2, X) = D$
290 NEXT X
300 A$(3, 6) = "  You are on a large ridge overlooking  the plain. Strange tracks of a slimy    substance criss-cross on the smooth     rock  in front of you. A large cluster  of vegetation lies to the east..."
310 A$(3, 7) = "  You are in a forest of dead tree-like plants. Several dried branches lie on   the ground. Exit is towards the east,   west, or north..."
320 D$(3, 7) = "You know- I'll bet that stuff would     burn..."
330 A$(3, 8) = "  You are on the side of a rather large mountain. To the east is a sheer face   of rock with something shiny reflecting light at its base. The plains lie to    the north..."
340 A$(3, 9) = "  Immediately to the south is a steel   door with a rusty plate embedded in it. The plate has an inscription which      reads 'UGF MET STATION'..."
350 D$(3, 9) = "The door is jammed shut. You'll have to think of something-bud.  "
360 A$(3, 10) = "  You are out on a ridge. The plains    lie to the north"
370 A$(4, 5) = "  Ugh! its dark in here..."
380 A$(5, 3) = "  AAHHHHHH! You impaled Yourself on a    stalactite! too bad!"
390 A$(5, 4) = "  You can hear water dripping..."
395 A$(5, 5) = "  Its pretty awful in this cave..."
400 A$(6, 4) = "  Ahhhh...Some stairs. They seem to     be in decent shape"
405 A$(7, 4) = "  GAAAH! A giant spider-like creature   explodes from the depths of the cave    and wraps itself around you! It bites!  You are spider lunch...too bad."
410 A$(6, 5) = "  A door is before you. It has been     knocked off its frame and you can pass  without trouble (if you are considering it)"
420 A$(6, 6) = "  You are standing in a wide passage.   You look up...and a small, jellylike    blob falls on your shoulder. You see    the roof-moving? Aghh! More blobs are   falling! Suddenly you are covered with  the things! They start eating...too bad
423 A$(7, 3) = "  The path gets narrow. You accident-  ally touch the water of the lake. The   surface boils and a monster rises out   of the black water.You are grabbed and  pulled under... too bad."
424 A$(7, 5) = "  You are on a narrow path in an un-    derground canyon. Other paths lead out  at random intervals"
425 A$(8, 5) = "  You are in a cavern filled with crys- tal spires and delicate arches of glass and emerald quartz. The roof is far     above you..."
426 A$(9, 5) = "  You are in a room filled with bub-    bling pools of sulfur. Wisps of steam   float upwards. Exits in all directions. "
428 A$(8, 7) = "  You are on a three-way metal catwalk  over a dark river. The roof of the cave is suddenly very low... "
429 A$(11, 5) = "  A creature that looks like a cross    between a boa constrictor and a barra-  cuda slithers out of a crevice and      sinks its teeth in your leg! too bad!"
430 A$(6, 7) = "  There is a sharp crackle and you fade into the 'wall'. It is actually a force field..."
432 D$(6, 7) = "So thats the way out..."
435 A$(5, 6) = "  Yaaaaaahhhhh! You fell down a pit     that was hewn into the floor...too bad!"
436 A$(7, 7) = "  You are in a metal corridor with      branches that lead east and west. The   corridor itself runs north-south..."
437 A$(7, 6) = "  A bed of green vegetation surrounds   you. You are suddenly jerked off your   feet by a long tendril. More follow.    You are slowly but surely trussed up    by the vegetable tentacles. too bad..."
440 A$(4, 9) = "  You are in a brightly lit metal room. On the floor is a dead man in a red un- iform. His arm is outstretched towards  a door. The door is open and leads to a hall going south..."
450 D$(4, 9) = "The fellow has his hand wrapped around  a mean looking knife...."
460 A$(5, 9) = "  You are in a metal corridor going     east-west. The steel plates that com-   prise the floor are covered with a      strange slimy substance..."
470 D$(5, 9) = "The slimy stuff looks like a slug trail Fancy that!"
475 A$(5, 10) = "  You are in a musty corridor.  The il- lumination is dim and erratic. An odd   smell is in the air."
476 D$(5, 10) = "  The slime trails are still here!"
480 A$(5, 11) = "  You come to an open door and go into  a large cavern cut out of the rock. A   huge slug-like creature covers almost   all of one wall and it turns its eye-   stalks to regard you..."
485 D$(5, 11) = "On the wall is a small panel with a     red light and a black switch. A plate   above the light reads 'BULKHEAD DOOR    RELEASE: WEST CORRIDOR'"
490 A$(5, 8) = "  You are in a small room with a desk   and computer console. The computer      screen is shattered and blackened. A    corridor leads east and a closed door   is in the south wall..."
500 D$(5, 8) = "The door is a good ole fashioned one    with a knob!"
510 A$(6, 8) = "  You are in a large room filled with   tables. A sign above the large open     double doors reads 'MESS HALL'. The     doors lead south and north..."
515 D$(6, 8) = "The wall to the west is sort of shim-   mering-as if it were not very           substantial..."
520 A$(7, 8) ="  Thunk! A crude spear crashes into     your chest. You look up and see a small biped alien with three mouths jumping   up and down in ecstasy over his catch.  too bad!"
530 A$(8, 8) = "  You are in a vast circular room. You  look over and see an alien that looks   like a giant louse. It is crabbing over towards your side of the room..."
540 D$(8, 8) = "  He is really ugly!"
550 A$(9, 8) = "  You are in a hydroponics garden gone  wild. Mutated vegetables and fruits are in abundance. Huge vines circle around  the metal roof struts.  A door is to    the south"
560 D$(9, 8) = "  The north-south doors are open."
570 A$(10, 8) = "  You are in a cathedral-like room. Odd bits of equipment are bolted to the     floor at even intervals. A skeleton is  bent over one piece of machinery that   looks like a control panel of some      kind."
580 D$(10, 8) = "A small LED screen has the message:     'STATION INTEGRITY RUPTURED. SHUTTLE ON STANDBY. PRIORITY ONE SECURITY MEASURES IN EFFECT. SECURITY CODE FOR NOW IS      ALPHA-123 '"
590 A$(8, 9) = "  You are in the bunkroom. Two skel-    etons lie on bare slats. A dead slug-   alien is draped over the far wall. The  passages out lead east."
600 D$(8, 9) = "These guys didn't put up much of a      fight..."
610 A$(8, 10) = "  You are in a room filled with comp-   uters and arrays of instruments. All    the screens are dead except one, which  is flickering dully. Exit to the south  and north..."
620 D$(8, 10) = "The screen has a short message printed  out on it:   'ESCAPE CRAFT IS READY FOR IMMEDIATE LAUNCH ON PAD 2A'..."
630 A$(9, 4) = "  AAAAHHHHHHHH! You fall into a pool of green muck! Its like quick sand! You are pulled down... too bad."
640 A$(10, 4) = "  You are walking among hundreds of     fungus plants that line the walls, the  ceiling, and the floor of this cave     passage. "
650 A$(11, 4) = "  This seems to be an abandoned mining  facility from the MET station. Mounds   of a yellowish ore crowd the floor.     Rusting machinery lies at the back of   the cavern. "
660 A$(12, 4) = "  There is a metal pathway on the       ground. It is running east-west. A      little passage runs north-south..."
670 A$(12, 3) = "  A bat creature drops from the roof    and lands on your head. That is it for  you, fella! too bad..."
680 A$(13, 4) = "  You wander into the deepest end of    the cave. A strange giddiness overcomes you and you fall to the cold stone      floor. Some kind of gas! too bad..."
690 A$(12, 5) = "  A human skeleton lies on the ground   along with several alien ones. Gargan-  tuan claw tracks lead south..."
700 A$(13, 5) = "  Gott in himmel! A real dragon! the    huge alien reptile is lying supine over against a boulder. It spies You! It     takes an interest in you and fights You with a tongue of flame! You hit the     dragon and escape too good!"
706 A$(10, 5) = "  You are in a cavern full of stone     slabs and boulders. Tall blocks of rock stand over you. A strange smell, some-  what like the scent of fresh mushrooms  is assailing your nose."
710 A$(9, 7) = "  An alien vaguely resembling a star-   fish slides langorously across the      floor towards you. It raises two feel-  ers and then flashes into motion like   greased purple lightning! You are a     dinner for it! too bad"
720 A$(12, 6) = "  It is completely black here. You are  feeling your way along..."
730 A$(12, 7) = "  AGGGHH! A pair of eyes appears in     blackness. You hear a hissssssssss and  then you feel a light touch on your     arm. Must I tell the rest...  too bad."
740 A$(11, 6) = "  You are in a small cavern filled with man-made crates. Bright illumination    comes from four panels in the roof. The crates are all stamped 'UGF MET STATION 22: MACHINE PARTS'..."
750 A$(11, 7) = "  You are in a softly-lit tunnel that   runs east-west. There are rails of some kind on the ground. The whole place     smells faintly of oil."
760 A$(11, 8) = "  You are in a softly-lit tunnel that   runs east-west. There are rails of some kind on the ground. A platform with a   sign saying 'HYDROPONICS SECTION'lies   on the north side of the rails. A door  opens north from there."
770 A$(11, 10) = "  You are in a softly-lit tunnel that   runs east-west. There are rails of some kind on the ground. A platform with a   sign saying 'CONTROL SECTION'lies on    the north side of the rails. A door     opens north from there."
780 A$(11, 9) = "  You are in a softly-lit tunnel that   runs east-west. A large wheeled vehicle lies on its side. Slime tracks cover it and its immediate vicinity. There are   rails on the ground and under the wreck of the vehicle..."
790 A$(9, 10) = "  You are in a north-south corridor     that is well lit and clean. No evidence of disorder here..."
796 D$(9, 10) = "You see a sign on a wall saying 'MET    STATION RAIL TRANSPORT: THIS WAY' with  an arrow pointing south."
800 A$(10, 10) = "  You are in a north-south corridor     that is well lit and clean. A large     open door lies to the south..."
810 A$(11, 11) = "  You are in an east-west tunnel. A     large vehicle is parked before you.     The door in the side of it is open. A   pulsing hum comes from it even though   the windows and ports are dark..."
811 D$(11, 11) = "If you want to clamber aboard  simply   say 'ENTER TRAM'"
812 A$(14, 5) = "You are suddenly in Jamal's House"
813 A$(14, 6) = "You in a hallway, their are stairs      to the south. "
814 A$(15, 6) = "  You are near the front door.          To the south is a kitchen, to the east  is an exit.                             North is a set of stiars."
815 A$(15, 7) = "  You are outside, on stairs of the     house.  You can only go East or West. "
816 A$(16, 8) = "  You continue down the sidewalk.       To the left of You is some garbage.     in one of the cans is an                Exit Mouse.  "
817 A$(16, 9) = "  OOPS!  You get runned over by a       car after walking into the street.      Now You can see why You shouldn't       stand in the middle of the street.      too bad.... "
818 A$(15, 8) = "  You are now on the sidewalk of a      street. "
819 A$(16, 6) = "  You are in the kitchen.  You see      a refrigirator.  "
820 D$(16, 8) = "  Their is an Exit Mouse in one of      the cans if You care to take it. "
821 A$(17, 8) = "  You are now at North-West corner      of an intersection.                     You can go in all directions,           if the traffic light permits...."
822 A$(18, 8) = "  You are now at South-West corner      of an intersection.                     You can go in all directions,           if the traffic light permits...."
823 A$(17, 9) = "  You are now at North-East corner      of an intersection.                     You can go in all directions,           if the traffic light permits...."
824 A$(18, 9) = "  You are now at South-East corner      of an intersection.                     You can go in all directions,           if the traffic light permits...."
825 D$(18, 6) = "  A game of some sort seems to be       near a pile of debris ready to be       picked up by the Sunday garbage         pickup.  On the box it reads 'JUMANJI'"
826 A$(18, 6) ="  The drumming sound and music gets     louder, it seems to be coming from      the garbage ready to be picked up       on Sunday.  You also see a broken       Sony TV with the back removed.          You can't take the TV, but look around.
827 A$(18, 7) = "  You are walking up an east-west       street.  You hear a drumming sound to   the west."
828 A$(18, 5) = "  You are on an east-west street.       You see a building to the south with    a door open and hear plain regular      instrumental music."
829 A$(19, 5) = "  You are walking a north-south hall.   The music slightly gets louder."
830 A$(20, 5) = "  You are at the end of the hall,       Their is a door with handles, You can   open this by hand, no Blaster is        Required.  "
831 A$(21, 5) = "  You are now in an East-West hall      North of You is a door all You have     is push.  South of You is an open door, You hear mellodies of samiliar Songs,   like Twinkle Twinkle Little Star."
832 D$(21, 5) = "  Instrumental Music is playing from    Flutes, Clarinents, Saxophones,         Trumpets, Trombones, Tubos, and more..."
833 A$(21, 4) = "  You are continuing down the hall,     You can only go east or west..."
834 A$(21, 3) = "  You are at the end of the hall,       their is an open door to the north,the  music is coming from the south.         Their is another door to the south      which seems to be another entrance      to the music room."
835 A$(20, 3) = "  Now You are in a room and You see     a music teacher who calls Himself Mr Wheel.er.  He seems to notice You and      tells You to get You instrunment.       I think You should hide Your blaster."
836 A$(22, 3) = "  You are in the west side of the       of the music room.  The people are      still playing music with there          instrunments.  They do not seem to      notice You at all."
837 A$(22, 4) = "  You are still in the music room.      Just don't disturb the students         playing the melodies.  A conductor is   conducting the music.  Look around      somthing may be lying around."
838 A$(22, 5) = "  You entered the music room.  And You  indeed see people  playing musical      instrunments."
839 A$(21, 6) = "  You are in still in the hall,         nothing special is here."
840 A$(21, 7) = "  You're at the east end of the hall    Their is a door to the east that        leads to a north-south street,          just push it open."
841 A$(21, 8) = "  You are on the north-south street.    Their are some stores around.           Right now, a building that reads        " + CHR$(34) + "Music Classes" + CHR$(34) + " above the door is       to the west of You."
842 A$(20, 8) = "  You are still on the north-south      street.  You see a dark alley           to the west."
843 A$(20, 7) = "  A black power ranger emerges from     big garbage dump, He looks at You       with a fury.  He seems ready to         fight You..."
844 D$(20, 7) = "  You are fighting with a               black power ranger."
846 A$(22, 8) = "  You are at the end of the block       on the north-south street. to the west  of You is a grocery store.  South of    You seems to be a dead-end.  If You     want to enter the store,                type 'GO STORE'."
847 A$(22, 7) = "  You entered a store which sells       odd and ends:  Tapes, Games, Cards,     Snacks, Cosmetics, it's a Drug Store..  "
848 D$(22, 7) = "  If You want to leave, go east or      enter 'LEAVE STORE' or 'EXIT STORE'  "
850 EXITMOUSE$ = "  You continue sotuh down the street    their is some yucky garbage ready       to be taken away."
851 JUMANJI$ = "  You continue walking one the          east-west street, You see a lot of      junk thrown away: toys, old             Christmas trees, totally broken         TV's and VCR's they look like they're   from Sony."
852 A$(25, 9) = "  You are at the entrance of a Casino.  "
853 A$(25, 10) = "  You are inside the Casino now, it    seems to be very busy, their are slots,  blackjack, poker, roulette and more."
854 A$(25, 8) = "  You are a North-South street and      at the entrance to a Department store."
855 A$(24, 8) = "  You are a North-South street.         To the east is an empty field.          To the North is a dead end."
856 A$(24, 7) = "  You are on an empty field,  To the    east is a small building with a door.   To the south is a brick wall."
857 D$(24, 6) = "  It's looks dark in here. On the floor is a Key"
858 A$(23, 7) = "  You are still on the field but to the North of You is what seems to be the    side entrance of a store.  The door is   open. "
859 A$(24, 6) = "  You are in a room, with two doors.    One to the south is locked, the one to  the east is wide open."
860 A$(24, 5) = "  You are in another room.  The room    has a locked safe."
861 A$(22, 10) = "  You are in Your house.  Go find your  friend Jamal jenkins and He'll give You money He needs to Buy Windows 95."
862 OPENSAFE$ = "The Safe is Open, in it is a Hammer,    $250, and a VIRTUALIZER.  You take all  Three items.":
863 A$(22, 9) = "  You are outside on the street.        Across the street to Your west is a     store that sells toy and gadgets."
864 A$(21, 9) = "  You are at the entrance of a          bodega where You can buy groceries to   Your east."
865 A$(20, 9) = "  You are on a east side of a           north-south street.  "
866 A$(25, 1) = "  You are in a big room with the        escape ship.  You see two corridors:    One to the north and one to the east."
867 A$(24, 1) = "  You are in a north-south corridor.    The corrodor itself seems endless."
868 A$(23, 1) = "  You are in a north-south corridor.    East of You is a door which seems       unlocked.  Could this be the entrance   to Jason David Frank's Room?"
869 A$(23, 2) = "  Well, it's not Jason David Frank's    room, but their seems to be boxes of    things stored away.  You see another    door to the east. "
870 D$(23, 2) = "  Look, ammunition for Your Blaster,    You'll need it for Your final battle    with Jason David Frank."
871 A$(23, 3) = "  Shump.  The door closes behind You as You enter a big room.   It seems to be  empty.  To the far east and south of    the room is two doors"
872 A$(23, 4) = "  You are at the east side of the       room.  Click.. You accidentally step    on a trigger tile that causes the door  to the far west to open.  Their is a    door immediately to the east of You     but it's jammed shut."
873 A$(24, 4) = "  Their is a door to the east of You    again but this time it's it's open."
874 A$(25, 2) = "  You are in and East-West corridor.    You can see a door at the end of the    corridor.  Brace Yourself, it might be  Jason David Frank's room."
875 A$(25, 3) = "  You are in an east-west corridor.     The door at the end the corridor seems  to be a crack open.  Beyond it You can  see only darkness.  Proceed with        caution if You're going east!  The      corridor also branches north."
876 A$(25, 4) = "  Immediately to the east is a door     that is seen slightly open You can see  only darkness ahead, thas has to be     Jason David Frank's Room!  Get Ready!   If You're ready, simple go east."
877 D$(25, 4) = "  That room sure is creepy, make sure   You have Your blaster ready before      entering..  Good Luck  :-)"
878 A$(25, 5) = "  You enter the room and the instant    You entire self is in, a metal door     closes behind You!  After a minute of   complete silence, the lights of the     room go on, and their He is,            Jason David Frank Himself..."
900 JU$(2) = "  The juamnji game gives You a message, 'Be careful, danger lurks  everywhere."
901 JU$(3) = "  The Jumanji game reveals to You       a security code to some es cape shuttle,the exact message is, 'The security     code to the escape shuttle is IBM.      Take a tram to get there.'"
902 JU$(4) = "  The game says their is a secret       cave to the north of the house where,   You started.  It also warns You their   is a dragon guarding the way.  Be       careful...More dangers and traps lurk   beyond the cave!"
905 JU$(7) ="  A message from the game warns         You that some white falcon zord will    take You.  The prediction instantly     becomes true and You are nabbed by the  zord and it takes You to                Zordon's Command Center. too bad..."
906 JU$(9) = "  After Your marker moves, You just     get a message saying,                   'Zordon is Evil!'"
907 JU$(12) = "  You get an instant message saying,    'Zordon is Evil,He has a Command Center.You shouldn't think to even enter.'"
908 JU$(8) = "  Jumanji tells You about villans:      Lordzedd, Rita Repulsa, Ninjor, Goldar, Master Belch, Jason David Frank,        Grimlord, and Giygas.  But the instant  You read the message the Goldar appears and takes You away to Lordzedd, too bad."
909 JU$(11) = "  A message on the board says,          'A severs thunderstorm will be coming.' Look out, buddy!"
940 COLOR 9, 1: GOSUB 12000
970 INPUT "DO YOU WISH TO LOAD A SAVED GAME"; GAME$
980 IF LEFT$(GAME$, 1) = "Y" OR LEFT$(GAME$, 1) = "y" THEN GOTO 9500:  ELSE COLOR 7, 0, 0
990 CLS
1000 'Program Body
1001 COLOR 7, 0, 0: KEY ON
1002 X$ = "too bad": IF INSTR(A$(A, B), X$) > 0 THEN PRINT A$(A, B): GOTO 8000
1003 IF I$(3, 2) = "BLASTER" THEN P = A: L = B
1004 IF A > 3 THEN GOSUB 6100
1006 IF I$(4, 9) = "KNIFE" THEN K = A: K1 = B
1010 PRINT : PRINT A$(A, B)
1011 IF A = 25 AND B = 5 THEN GOTO 7450'Battle with Jason David Frank
1012 IF A = 14 AND B = 5 THEN 6451
1013 IF C > 1 THEN C = A: R = B + 1
1014 IF MMPR$ = "" AND A = 20 AND B = 7 THEN GOTO 6338
1015 IF A = 5 AND B = 11 THEN GOTO 6300
1016 IF C > 1 AND A = 6 AND B = 7 THEN C = 0: R = 900: A$(A, B) = "": PRINT : PRINT "The slug-creature shorts itself out in  the force field! Black smoke is evey-   where! The slug stops moving and        settles to the ground...": W$ = ""
1017 IF CTS = 111 THEN A$(8, 8) = "  You are in a vast circular room. A    blasted alien lies on the floor before  you. Openings lead  in all directions.": D$(8, 8) = "Yechhh! What-a-mess!"
1018 IF R = 900 THEN D$(7, 7) = "Can't go north. The corpse of the slug  is in the way...": A$(6, 8) = ""
1019 IF A = 22 AND B = 7 THEN GOSUB 4500
1020 PRINT : PRINT W$
1030 PRINT : INPUT "Well"; Q$
1031 IF LEFT$(Q$,3) = "sit" THEN IF Q$ = "sit" THEN PRINT "Where?" : GOTO 1030  ELSE PRINT "You can't sit on a ";RIGHT$(Q$,LEN(Q$)-4);" because I don't know what You are talking about.":GOTO 1030
1032 FOR CAP = 1 TO LEN(Q$)
1033 IF ASC(MID$(Q$, CAP, 1)) < 123 AND ASC(MID$(Q$, CAP, 1)) > 96 THEN MID$(Q$, CAP, 1) = CHR$(ASC(MID$(Q$, CAP, 1)) - 32)
1034 NEXT
1035 IF A = 8 AND B = 8 THEN VVV = 1: IF CTS = 0 THEN GOTO 6400
1036 LT = LT + 1: IF LT > 6 THEN LT = 1
1037 IF LEFT$(Q$,3) = "SIT" THEN IF Q$ = "SIT" THEN PRINT "Where?" ELSE PRINT "You can't sit on a ";RIGHT$(Q$,LEN(Q$)-4);" because I don't know what You are talking about.":GOTO 1030
1038 IF Q$ = "OUT" THEN PRINT "You have to go out the same way You came in.":GOTO 1030
1040 GOSUB 5000
1500 GOTO 1000
4500 '  In the store....
4505 W$ = "It's 75 degrees in here because the     air conditioning is on."
4511 RESTORE 4515
4515 DATA  TAPE RECORDER,26,PACK OF BUBBLE GUM,.5,OTHELLO GAME,7.5,BOX OF PRINGLES,1.09,DECK OF CARDS,2.59,3D PUZZLE,24,ACTION FIGURE,7,WRIST COMMUNICATOR,50,BOX OF CHOCOLATES,10,TOOTHBRUSH,3,WINDOWS 95,75,VIRTUALIZER,69.99
4520 DATA  BETA VIDEOCASSTTE,2,CREETING CARD,1.99,TOY SLINKY,1.99,                   VHS VIDEOCASSETTE,2.5
4523 'IF ERASED = 0 THEN 4525
4524 DIM ITEM$(20),PRICE(20):
4525 FOR I = 1 TO 16
4530 READ ITEM$(I), PRICE(I)
4535 NEXT I
4540 WIDTH 80
4545 PRINT : PRINT "You enter a store that sells odd and    ends like snacks, games,                greeting cards, medicine, toys...       it is a store, like K-mart or Caldor,   but it's smaller and sell mostly Toys   and small Electronics."
4550 PRINT : PRINT "In a store You can buy anything         listed on the menu of the next screen   if You have enough money.  Anything     You buy will be added to You inventory, which can up to 20 items."
4555 PRINT : PRINT "The command for buying somthing is      BUY ITEM.    After You type this,       command the money the automatically     deducted.  If You wish to exit this     store is EXIT store or any 'EAST'       command."
4560 PRINT : PRINT "Press any key to continue...  ": WHILE INKEY$ = "": WEND
4565 CLS
4570 PRINT : PRINT "SOUTH, BROOKLYN STORE    ":
4575 PRINT : PRINT "ITEMS MENU": PRINT "------------------"
4580 PRINT
4585 PRINT USING "& $##.##"; "1.  Tape Recorder.      - "; 26; "     9.  Box of Chocolates   - "; 10
4590 PRINT USING "& $##.##"; "2.  Pack Of Bubble Gum  - "; .5; "     10. Toothbrush          - "; 3
4595 PRINT USING "& $##.##"; "3.  Game of 'Othello'   - "; 7.5; "     11. Windows 95 software - "; 75
4600 PRINT USING "& $##.##"; "4.  Box of Pringles     - "; 1.09; "     12. Virtualizer         - "; 69.99
4605 PRINT USING "& $##.##"; "5.  Deck of Cards       - "; 2.59; "     13. Beta VideoCassette  - "; 2
4610 PRINT USING "& $##.##"; "6.  Puzz 3D Puzzlie     - "; 24; "     14. Greeting Card       - "; 1.99
4615 PRINT USING "& $##.##"; "7.  Action Figure       - "; 7; "     15. Toy Slinky          - "; 1.99
4620 PRINT USING "& $##.##"; "8.  Wrist Communcator   - "; 50; "     16. VHS Videocassette   - "; 2.5
4625 PRINT
4630 PRINT USING "You have $###.##. "; MONEY
4635 INPUT "Well"; Q$
4640 FOR CAP = 1 TO LEN(Q$):
4645 IF ASC(MID$(Q$, CAP, 1)) < 123 AND ASC(MID$(Q$, CAP, 1)) > 96 THEN MID$(Q$, CAP, 1) = CHR$(ASC(MID$(Q$, CAP, 1)) - 32)
4650 NEXT
4653 FOR IT = 1 TO 16: IF INSTR(Q$, ITEM$(IT)) THEN ITEM = IT: GOTO 4677 ELSE
4654 NEXT IT
4655 IF (LEFT$(Q$, 3) = "BUY") AND MONEY > 0 THEN 4675 ELSE IF MONEY = 0 THEN PRINT "You don't have any money, so You can't buy anything."
4660 IF Q$ = "LIST" OR Q$ = "LIST ITEMS" THEN 4585
4665 IF Q$ = "E" OR Q$ = "GO EAST" OR Q$ = "RUN EAST" OR Q$ = "WALK EAST" OR Q$ = "EXIT STORE" OR Q$ = "LEAVE STORE" THEN B = B + 1: GOTO 4698
4666 IF Q$ = "S" OR Q$ = "GO SOUTH" OR Q$ = "RUN SOUTH" OR Q$ = "WALK SOUTH" THEN A = A + 1: GOTO 4698
4670 PRINT : PRINT D$(A, B): PRINT : PRINT W$: PRINT : GOTO 4635
4675 INPUT "Enter Item Number to Buy - ", ITEM
4677 IF JAMAL = 1 AND NOT (ITEM = 11) THEN PRINT "I think You should buy Jamal Windows 95.": GOTO 4635
4680 IF MONEY < PRICE(ITEM) THEN PRINT "You don't have enough money to buy that.": GOTO 4635 ELSE PRINT "The "; ITEM$(ITEM); " has been added to Your inventory.": I$(5, ITEM) = ITEM$(ITEM): MONEY = MONEY - PRICE(ITEM)
4684 IF I$(5, 11) = "WINDOWS 95" THEN JAMAL = 0
4685 PRINT "To Exit the store, Type EXIT STORE, or Go East."
4690 PRINT "To List the items again, type LIST, or LIST ITEMS."
4695 GOTO 4625
4698 IF COLMN = 40 THEN WIDTH 40:
4699 GOTO 1000
4700 T = T + 1
4710 IF T < 11 THEN W$ = "It's warm outside...About 90 degrees."
4720 IF T > 11 THEN W$ = "Looks like a storm is brewing...     "
4730 IF T > 14 THEN W$ = "Weather is starting to look bad!"
4740 IF T > 16 THEN W$ = "CRASH! A Storm is upon you!"
4750 IF T > 20 THEN W$ = "It's raining very bad, but look         behind You, Jamal is their."
4761 IF T = 25 THEN JAMAL = 1
4765 W$ = "Your friend Jamal is leaving,but he     gives You $75 to go buy Microsoft       Windows 95 for His Computer.  It's at   a local store arund Here.  If You       get Him Windows 95, he'll show You      a secret cave.": MONEY = MONEY + 75
4766 IF T > 25 THEN W$ = "The storm is going away.          "
4767 IF T > 28 THEN W$ = "It's cool now...About 65 degrees,       and the sun is going down. "
4768 IF T > 35 THEN W$ = "It's night time now...                  Temperature is 60 degrees."
4769 IF T > 45 THEN W$ = "The sun is rising in the east.    "
4770 RETURN
4800 ' Play Jumanji
4802 IF INSTR(Q$, "JUMANJI") > 0 AND LEN(I$(3, 5)) = 0 THEN PRINT "You don't have the Jumanji Game.": GOTO 4899
4803 IF (Q$ = "PLAY JUMANJI" OR Q$ = "JUMANJI" OR Q$ = "USE JUMANJI" OR Q$ = "PLAY GAME" OR Q$ = "USE GAME" OR Q$ = "GAME") AND NOT (I$(3, 5) = "JUMANJI GAME") THEN PRINT "You don't have the Jumanji Game.": GOTO 4899
4810 RANDOMIZE TIMER
4813 DI1 = INT(RND * 6) + 1
4815 DI2 = INT(RND * 6) + 1
4817 ROLL = DI1 + DI2
4820 PRINT "You Play Jumanji and roll the dice."
4821 PRINT
4825 PRINT "You roll a"; DI1; "and a"; DI2
4826 IF DI1 + DI2 = 12 THEN PRINT "Alright!  Box Cars!"
4830 PRINT
4835 PRINT "Your Marker Moves...."
4837 IF ROLL = 7 AND NOT ((A = 18 OR A = 17) OR (B < 10 AND B > 6)) THEN PRINT "but nothing strange happens..": GOTO 4899
4838 IF ROLL = 11 THEN T = 12
4840 IF JU$(ROLL) = "" THEN PRINT "but nothing strange happens." ELSE PRINT JU$(ROLL)
4850 IF INSTR(JU$(ROLL), "too bad") > 0 THEN GOTO 8000
4899 RETURN
5000 'CHECKERS AND ADDERS
5002 SCORE = SCORE + 1
5005 X$ = "too bad": IF INSTR(A$(A, B), X$) > 0 THEN GOTO 8000
5050 IF Q$ = "L" OR Q$ = "LOOK" THEN PRINT D$(A, B): IF D$(A, B) = "" THEN PRINT "  You see nothing special...": GOTO 1030
5053 IF Q$ = "CLS" OR Q$ = "CLEAR SCREEN" OR Q$ = "HOME" THEN CLS
5060 IF Q$ = "I" OR Q$ = "INVENTORY" THEN GOTO 5600
5061 IF Q$ = "M" OR Q$ = "MONEY" THEN PRINT : PRINT USING "You have $$####.##."; MONEY: GOTO 1030
5064 IF Q$ = "SCORE" OR Q$ = "TELL SCORE" THEN PRINT "YOU'VE LASTED "; SCORE; " MOVES"
5065 IF Q$ = "HELP" THEN GOSUB 12000: GOTO 1000
5066 IF Q$ = "FILE" OR Q$ = "SAVE GAME" GOTO 9000
5070 IF A > 3 THEN W$ = ""
5073 IF R > 200 THEN A$(6, 7) = ""
5075 IF C > 1 THEN W$ = "The creature is slithering behind you!"
5077 IF PR > 0 THEN PR = PR + 1
5080 IF A < 4 THEN GOSUB 5700
5085 IF A = 4 AND B = 9 THEN A39$ = "NO"
5086 IF A39$ = "NO" THEN A$(3, 9) = ""
5089 IF Q$ = "TROOPER TRANSFORM" THEN Q$ = "VIRTUALIZER"
5090 P$ = "GET": IF INSTR(Q$, P$) > 0 THEN GOTO 5800
5091 P$ = "GRAB": IF INSTR(Q$, P$) > 0 THEN GOTO 5800
5092 P$ = "PLAY": IF INSTR(Q$, P$) > 0 THEN GOTO 5800
5093 P$ = "TRUMPET": IF INSTR(Q$, P$) > 0 THEN GOTO 5800
5094 P$ = "TAKE": IF INSTR(Q$, P$) > 0 THEN GOTO 5800
5095 P$ = "JUMANJI": IF INSTR(Q$, P$) > 0 THEN GOSUB 4800
5096 P$ = "UNLOCK": IF INSTR(Q$, P$) > 0 THEN 5809
5097 P$ = "SAFE": IF INSTR(Q$, P$) > 0 THEN 5809
5098 P$ = "USE": IF INSTR(Q$, P$) > 0 THEN 5809
5099 P$ = "VIRTUALIZE": IF INSTR(Q$, P$) > 0 THEN 5810
5100 P$ = "RETROFORM": IF INSTR(Q$, P$) > 0 THEN 5810
5115 X1$ = "DROP": IF INSTR(Q$, X1$) > 0 THEN 6200
5120 METALDOOR$ = "Sorry. A metal door anchored in the     ceiling is down in your path. This one  looks blaster-proof: it is very thick   and heavy..."
5340 IF A = 5 AND B = 9 THEN IZ = 1: IF CRQ = 0 THEN IZ = 0: IF Q$ = "W" OR Q$ = "WEST" OR Q$ = "GO WEST" THEN PRINT : PRINT METALDOOR$: PRINT : GOTO 1030
5345 IF (A = 18) AND (B = 9 OR B = 8) AND (Q$ = "S" OR INSTR(Q$, "SOUTH") > 1) THEN PRINT "  Sorry, their is a road block in the     way.  You'll have think on some other way": GOTO 1030
5349 IF (A = 22 AND B = 4) OR (A = 21 AND B = 7) THEN IZ = 1: IF (Q$ = "N" OR Q$ = "RUN NORTH" OR Q$ = "GO NORTH" OR Q$ = "WALK NORTH") OR (Q$ = "S" OR Q$ = "RUN SOUTH" OR Q$ = "GO SOUTH" OR Q$ = "WALK SOUTH") THEN GOTO 5500
5350 IF A = 3 AND B = 9 THEN GOSUB 5900
5351 IF A = 23 AND B = 1 THEN IZ = 1: IF Q$ = "OPEN DOOR" OR Q$ = "GO DOOR" OR Q$ = "PULL HANDLE" THEN B = B + 1: PRINT : PRINT "You are through..." ELSE IF (Q$ = "E" OR INSTR(Q$, "EAST")) THEN PRINT OPENTHEDOOR$: GOTO 1030
5352 IF (A = 5 AND B = 8) OR (A = 21 AND B = 4) THEN IZ = 1: IF Q$ = "S" OR Q$ = "RUN SOUTH" OR Q$ = "GO SOUTH" OR Q$ = "WALK SOUTH" THEN GOTO 5500
5353 IF A = 20 AND B = 5 THEN IZ = 1: IF Q$ = "OPEN DOOR" OR Q$ = "GO DOOR" OR Q$ = "PULL HANDLE" THEN A = A + 1: PRINT : PRINT "You are through..." ELSE IF (Q$ = "S" OR Q$ = "GO SOUTH" OR Q$ = "RUN SOUTH") THEN PRINT OPENTHEDOOR$: GOTO 1030
5354 IF A = 5 AND B = 8 THEN IZ = 1: IF Q$ = "OPEN DOOR" OR Q$ = "GO DOOR" OR Q$ = "TURN KNOB" THEN A = A + 1: PRINT : PRINT "You are through..."
5355 IF (Q$ = "GO STORE" OR Q$ = "GO WEST" OR Q$ = "W" OR Q$ = "RUN WEST" OR Q$ = "WALK WEST") AND B = 8 AND (A = 22 OR A = 19) THEN IF T > 35 AND T < 45 THEN PRINT "Sorry, the store is closed..  ": GOTO 1030:  ELSE Q$ = "W"
5356 IF A = 11 AND B = 11 THEN NNN = 1: IF Q$ = "ENTER TRAM" THEN GOTO 6500 ELSE IF Q$ = "E" OR Q$ = "EAST" OR Q$ = "GO EAST" THEN 8500
5357 V1$ = "BLAST": IF INSTR(Q$, V1$) > 0 THEN BLS = BLS + 1: IF BLS > LIMIT THEN 5950 ELSE 6000
5358 V1$ = "SHOOT": IF INSTR(Q$, V1$) > 0 THEN BLS = BLS + 1: IF BLS > LIMIT THEN 5950 ELSE 6000
5359 IF A = 17 AND B = 9 AND (Q$ = "N" OR Q$ = "RUN NORTH" OR Q$ = "GO NORTH" OR Q$ = "WALK NORTH") THEN PRINT "Sorry, some power rangers are their,     waiting to get You.": GOTO 1030
5369 IF Q$ = "N" OR Q$ = "GO NORTH" OR Q$ = "RUN NORTH" OR Q$ = "WALK NORTH" THEN A = A - 1: IF A$(A, B) = "" OR A$(A, B) = " " THEN A = A + 1: GOTO 5500
5370 IF Q$ = "S" OR Q$ = "GO SOUTH" OR Q$ = "RUN SOUTH" OR Q$ = "WALK SOUTH" THEN A = A + 1: IF A > 25 THEN A = A - 1: GOTO 5500 ELSE IF A$(A, B) = "" OR A$(A, B) = " " THEN A = A - 1: GOTO 5500
5380 IF Q$ = "W" OR Q$ = "GO WEST" OR Q$ = "RUN WEST" OR Q$ = "WALK WEST" THEN B = B - 1: IF A$(A, B) = "" OR A$(A, B) = " " THEN B = B + 1: GOTO 5500
5390 IF Q$ = "E" OR Q$ = "GO EAST" OR Q$ = "RUN EAST" OR Q$ = "WALK EAST" THEN B = B + 1: IF B > 11 THEN B = B - 1: GOTO 5500 ELSE IF A$(A, B) = "" OR A$(A, B) = " " THEN B = B - 1: GOTO 5500
5400 IF LEFT$(Q$,2) = "GO" AND MID$(Q$,3,1) = " " THEN PRINT "You can't go that way (";RIGHT$(Q$,LEN(Q$)-3);").":GOTO 1030 ELSE IF LEFT$(Q$,2) = "GO" THEN PRINT "Go where? ":GOTO 1030
5401 RETURN
5500 IF LEFT$(Q$,2) = "GO" THEN PRINT "You can't go that way. (";RIGHT$(Q$,LEN(Q$)-3));")":GOTO 1030
5501 PRINT "You can't go that way."
5510 GOTO 1030
5600 Z = 0: FOR I = 1 TO 5
5610 FOR X = 1 TO 16
5620 IF I$(I, X) = "" OR I$(I, X) = " " THEN GOTO 5640
5630 PRINT I$(I, X)
5631 Z = Z + 1
5640 NEXT X, I
5650 IF Z = 0 THEN PRINT : PRINT "You're not carrying anything!"
5660 IF Z > 0 THEN PRINT : PRINT "You're carrying "; Z; " item(s)"
5670 GOTO 1030
5700 T = T + 1 - 1
5710 IF T < 11 THEN W$ = "Weather looks as good as it could be."
5720 IF T > 11 THEN W$ = "Looka like a storm is brewing...     "
5730 IF T > 14 THEN W$ = "Weather is starting to look bad!"
5740 IF T > 16 THEN W$ = "CRASH! A Storm is upon you!"
5750 IF T > 19 THEN W$ = "The winds are howling!"
5760 IF T > 22 THEN PRINT : PRINT "You are swept away into the swirling ": PRINT "storm winds! Tough luck, bud!": PRINT : GOTO 8000
5780 RETURN
5800 IF Q$ = "GET BLASTER" OR Q$ = "GRAB BLASTER" THEN IZ = 1: IF P = A AND L = B THEN I$(3, 2) = "BLASTER": D$(A, B) = "": PRINT "GOT IT": E$ = "BLASTER": D$(3, 2) = "  You don't see anything of interest...": GOTO 1030
5801 IF Q$ = "PLAY TRUMPET" OR Q$ = "TRUMPET" OR Q$ = "USE TRUMPET" THEN IF I$(3, 3) = "" THEN PRINT "You don't have the trumpet." ELSE INPUT "Enter note sequence to play - ", NOTE$: PLAY NOTE$: GOTO 1030
5802 IF Q$ = "GET TRUMPET" OR Q$ = "GRAB TRUMPET" THEN IZ = 1: I$(3, 3) = "TRUMPET": D$(A, B) = "": PRINT "GOT IT": E$ = "TRUMPET": D$(3, 3) = "  You don't see anything of interest...": GOTO 1030
5803 IF Q$ = "GET EXIT MOUSE" OR Q$ = "GRAB EXIT MOUSE" THEN IZ = 1: IF A = 16 AND B = 8 THEN I$(3, 4) = "EXIT MOUSE": D$(A, B) = "": PRINT "GOT IT"; LT: E$ = "EXIT MOUSE": D$(16, 8) = NOTHING$: A$(16, 8) = EXITMOUSE$: GOTO 1000:
5804 IF INSTR(Q$, "JUMANJI") OR INSTR(Q$, "GAME") AND I$(3, 5) = "JUMANJI GAME" THEN GOSUB 4800: RETURN
5805 IF Q$ = "GET KNIFE" OR Q$ = "GRAB KNIFE" THEN IZ = 1: IF K = A AND K1 = B THEN I$(4, 9) = "KNIFE": D$(A, B) = "": PRINT "GOT IT": D$(4, 9) = "  You see nothing special...": GOTO 1000
5806 IF Q$ = "GET JUMANJI" OR Q$ = "GRAB JUMANJI" THEN IZ = 1: IF A = 18 AND B = 6 THEN I$(3, 5) = "JUMANJI GAME": D$(A, B) = "": PRINT "GOT IT": E$ = "JUMANJI GAME": D$(18, 6) = "  You don't see anything of interest...": A$(18, 6) = JUMANJI$: GOTO  _
5807 IF Q$ = "GET GAME" OR Q$ = "GRAB GAME" THEN IZ = 1: IF A = 18 AND B = 6 THEN I$(3, 5) = "JUMANJI GAME": D$(A, B) = "": PRINT "GOT IT": E$ = "JUMANJI GAME": D$(18, 6) = "  You don't see anything of interest...": A$(18, 6) = JUMANJI$: GOTO 1000
5808 IF Q$ = "GET KEY" OR Q$ = "GRAB KEY" THEN IZ = 1: IF A = 24 AND B = 6 THEN I$(3, 8) = "KEY": D$(A, B) = "": PRINT "GOT IT": E$ = "KEY": D$(24, 6) = "  You don't see anything of interest...": A$(24, 6) = "You're in a dark room": GOTO 1000
5809 IF (A = 24 AND B = 5) AND Q$ = "OPEN SAFE" THEN IF I$(3, 8) = "KEY" THEN PRINT OPENSAFE$: I$(5, 12) = "VIRTUALIZER": I$(3, 9) = "HAMMER": MONEY = MONEY + 250: GOTO 1000:  ELSE PRINT "It's locked!": GOTO 1000
5810 IF (INSTR(Q$, "VIRTUALIZE") OR I$(3, 9) = "VIRTUALIZER") AND (I$(5, 12) = "VIRTUALIZER") THEN PRINT "Wow, "; A$; "!": PRINT "You're a VR Trooper!": PRINT "Enter RETROFORM to return You to Your   nornal self. ":  VRT = 1: GOTO 1000
5811 IF Q$ = "RETROFORM" THEN IF VRT = 1 THEN PRINT A$; " has returned to ":         PRINT "His or Her normal Self.": VRT = 0: GOTO 1000 ELSE PRINT "You need to be a VR Trooper first."
5882 PRINT"You can't see that here." : GOTO 1030
5885 PRINT : PRINT "It's either not here or You are being": PRINT "rediculous again..."
5890 GOTO 1030
5900 IF I$(3, 2) = "BLASTER" THEN 5904 ELSE 5930
5904 IF Q$ = "BLAST DOOR" OR Q$ = "SHOOT DOOR" OR Q$ = "ZAP DOOR" THEN GOTO 5950
5905 CC$ = " "
5910 IF Q$ = "BLAST IT" OR Q$ = "BLAST" OR Q$ = "SHOOT IT" OR Q$ = "SHOOT" THEN PRINT : INPUT "What is your target"; CC$
5920 V1$ = "DOOR": IF INSTR(CC$, V1$) > 0 OR INSTR(CC$, "door") THEN GOTO 5950
5930 IF Q$ = "W" OR Q$ = "WEST" THEN B = B + 1: GOTO 1000
5940 IF Q$ = "N" OR Q$ = "NORTH" THEN A = A - 1: GOTO 1000
5943 IF Q$ = "E" OR Q$ = "EAST " THEN B = B + 1: GOTO 1000
5945 IF Q$ = "S" OR Q$ = "SOUTH" THEN GOTO 5500
5946 PRINT "  I really don't know what you mean..."
5947 GOTO 1000
5950 IF BLS > LIMIT THEN PRINT "Nothing happens...": GOTO 1030
5955 A = A + 1: PRINT : PRINT "ZZRAPPP!! The door blows apart!": A$(3, 9) = ""
5956 STU$ = "  You stumble through the blasted ruin  of the door, the white flash of the     shot temporarily affecting sight"
5957 STU$ = STU$ + " and    reflex. Behind you the remains of the   door and about 900 tons of rock fall    over the entrance. You are sealed in!"
5960 PRINT : PRINT STU$
5970 PRINT "The blast set off a rockslide!"
5980 BLS = BLS + 1
5990 GOTO 1000
6000 'SHOOT ROUTINE
6010 IF I$(3, 2) = "BLASTER" THEN 6015 ELSE PRINT "You don't have it!": GOTO 1000
6015 IF BLS > LIMIT THEN GOTO 5950
6020 PRINT : PRINT "ZRAPPP!": PRINT : PRINT "You turkey, you really made a mess!": PRINT "smoke is everywhere..."
6030 D$(A, B) = "  There is a blaster crater here. Dust  and debris cover everything."
6040 BLS = BLS + 1
6098 RETURN
6100 IF A = 4 AND B = 9 THEN W$ = "There is a lot of dust in the air..."
6110 IF A >= 4 AND B < 8 THEN W$ = "The air is damp and stuffy in here. "
6111 IF A >= 14 THEN W$ = "The air is warm in here."
6120 IF A >= 4 AND B < 8 AND A < 14 THEN D$(A, B) = "Danger is everywhere...watch out"
6121 IF A = 14 AND B = 5 THEN D$(A, B) = "You see a Computer on the desk."
6122 IF A > 14 AND (B > 6 AND B < 10) THEN GOSUB 4700'W$="t's warm..About 90 degees."
6123 IF PR = 6 THEN PRINT : PRINT "The power ranger just vanished.": W$ = "": GOTO 6198
6124 IF PR > 1 AND PR < 6 THEN W$ = "The power ranger in behind You!"
6198 RETURN
6200 V$ = "You see a knife.": VV$ = "You see a blaster."
6202 IF I$(4, 9) = "KNIFE" THEN IZ = 1: V1$ = "KNIFE": IF INSTR(Q$, V1$) > 0 THEN I$(4, 9) = "": D$(K, K1) = D$(K, K1) + V$: GOTO 6290
6205 IF I$(3, 2) = "BLASTER" THEN IZ = 2: V1$ = "BLASTER": IF INSTR(Q$, V1$) > 0 THEN I$(3, 2) = "": D$(P, L) = D$(P, L) + VV$: GOTO 6290
6288 GOTO 1030
6290 PRINT "OK, I got rid of it.."
6298 GOTO 1030
6300 REM   Fight with a slug creature.
6302 PRINT : INPUT "Whaddya gonna do?!"; F$
6304 FOR CAP = 1 TO LEN(F$)
6306 IF ASC(MID$(F$, CAP, 1)) < 123 AND ASC(MID$(F$, CAP, 1)) > 96 THEN MID$(F$, CAP, 1) = CHR$(ASC(MID$(F$, CAP, 1)) - 32)
6308 NEXT
6310 IF INSTR(F$, "SWITCH") > 0 OR F$ = "PRESS BUTTON" THEN CRQ = 111: PRINT : PRINT "Panel light changes to green and the ": PRINT "door down the west corridor lifts up    into the ": PRINT "roof with a grinding   roar...": GOTO 6320
6312 IF F$ = "W" OR F$ = "RUN WEST" OR F$ = "GO WEST" OR F$ = "WEST" THEN C = A: R = B: W$ = "The creature is following you!": B = B - 1: GOTO 1000
6314 IF F$ = "BLAST IT" OR F$ = "BLAST CREATURE" OR F$ = "SHOOT IT" OR F$ = "SHOOT SLUG" OR F$ = "BLAST SLUG" THEN PRINT : PRINT "ZRAPPPP!": PRINT : PRINT "The bolt of energy hits the creature": PRINT "and it absorbs the shot and grows!": BLS=BLS+1
6316 IF F$ = "KNIFE IT" OR F$ = "STAB IT" OR F$ = "STAB CREATURE" OR F$ = "STAB SLUG" THEN PRINT : PRINT "AGHHHH! It grabs at your arm with a     pseudopod and your knife melts into     the glistening flesh!": I$(4, 9) = "": GOTO 6320
6318 IF F$ = "L" OR F$ = "LOOK" THEN PRINT : PRINT D$(A, B): GOTO 6302
6320 IF UUU = 1 THEN GOTO 6326
6322 PRINT : PRINT " The creature extends itself and moves  towards you!": UUU = 1
6324 GOTO 6302
6326 IF A = 5 AND B = 9 THEN IZ = 0: IF C > 1 THEN PRINT "A door is blocking your way! You turn   around and...."
6328 PRINT : A$(A, B) = "YAAAAAAAAAAAAAH!    The slug creature   engulfs you with a sudden motion sup-   rising for such bulk. You die a very    slow and slimy death. too bad!"
6330 GOTO 1000
6332 '
6334 '
6336 '
6338 REM   Fight with the power ranger.
6340 PRINT : INPUT "Whaddya gonna do?!"; F$
6342 FOR CAP = 1 TO LEN(F$)
6344 IF ASC(MID$(F$, CAP, 1)) < 123 AND ASC(MID$(F$, CAP, 1)) > 96 THEN MID$(F$, CAP, 1) = CHR$(ASC(MID$(F$, CAP, 1)) - 32)
6346 NEXT
6348 IF I$(3, 2) = "" AND (F$ = "BLAST IT" OR F$ = "BLAST POWER RANGER" OR F$ = "SHOOT IT" OR F$ = "SHOOT POWER RANGER") THEN PRINT "Sorry, no Blaster.": GOTO 6358
6350 IF (F$ = "KNIFE IT" OR F$ = "STAB IT" OR F$ = "STAB POWER RANGER" OR F$ = "STAB POWER RANGER") AND I$(4, 9) = "" THEN PRINT "Sorry, bud, You don't have the Knife.": GOTO 6360
6352 IF (F$ = "TRUMPET" OR F$ = "PLAY TRUMPET") AND I$(3, 3) = "" THEN PRINT "Sorry, but You don't have the trumpet.": GOTO 6362
6354 IF F$ = "E" OR F$ = "RUN EAST" OR F$ = "GO EAST" OR F$ = "EAST" THEN C = A: R = B: W$ = "The power ranger is following You!": B = B + 1: PR = 1: GOTO 1000
6356 IF F$ = "BLAST IT" OR F$ = "BLAST POWER RANGER" OR F$ = "SHOOT IT" OR F$ = "SHOOT POWER RANGER" THEN PRINT : PRINT "ZRAPPPP!": PRINT : PRINT "The beam of Your Blaster hits the   ": PRINT "power ranger and He dies.": BLS = BLS + 1: GOTO 6374
6358 IF F$ = "KNIFE IT" OR F$ = "STAB IT" OR F$ = "STAB POWER RANGER" OR F$ = "KNIFE POWER RANGER" THEN PRINT : PRINT "You take out Your knife and stab the    power ranger hard.  He dies instantly": GOTO 6374
6360 IF F$ = "TRUMPET" OR F$ = "PLAY TRUMPET" THEN PRINT "You play a tune on the trumpet, and     the power ranger falls asleep.": A$(A, B) = "You are in a dark alley, their is       sleeping power ranger.": MMPR$ = "SLEEPING": GOTO 1000
6362 IF F$ = "L" OR F$ = "LOOK" THEN PRINT : PRINT D$(A, B): GOTO 6302
6364 IF TUU = 1 THEN GOTO 6370
6366 PRINT : PRINT " The power ranger comes closer towards You!": TUU = 1
6368 GOTO 6340
6370 PRINT
6372 PRINT : A$(A, B) = "  OH NO! The power ranger grabs You.    He and You are teleported to Zordon's   Command Center. You are before Zordon,  He is going to do somthing really bad   to You...too bad!": GOTO 1000
6374 PRINT : A$(20, 7) = "  You are in a dark alley,             before lies a dead power ranger.": MMPR$ = "DEAD"
6376 GOTO 1000
6378 '
6380 '
6382 '
6400 IF Q$ = "L" OR Q$ = "LOOK" THEN PRINT D$(A, B): GOTO 1000
6405 IF Q$ = "SHOOT IT" OR Q$ = "BLAST IT" OR Q$ = "BLAST CREATURE" OR Q$ = "SHOOT CREATURE" OR Q$ = "SHOOT LOUSE" OR Q$ = "BLAST LOUSE" OR Q$ = "SHOOT ALIEN" OR Q$ = "BLAST ALIEN" THEN IZ = 1 ELSE 6450: BLS = BLS + 1: IF BLS > LIMIT GOTO 5950
6406 IF I$(3, 2) = "BLASTER" THEN 6410 ELSE PRINT "You don't have it!": GOTO 1000
6410 CTS = 111
6420 PRINT : PRINT "ZRRAAAP!": PRINT : PRINT " The alien recieves a blaster bolt in   its midsection. It keels over in front  of you."
6430 GOTO 1017
6450 PRINT : PRINT "The louse-alien climbs up your leg as   you try to flee. It latches on to you  and that is it, boyo. too ba.": GOTO 5000
6451 REM  Give Jamal Jenkins Windows 95.
6452 IF JAMAL = 2 THEN 1030 ELSE PRINT "Jamal is in His room and He asks You     for Windows 95. "
6453 INPUT "Do You have it? [Y/n] ", JM$
6454 IF JM$ = "Y" OR JM$ = "y" THEN IF I$(5, 11) = "WINDOWS 95" THEN I$(5, 11) = "": JAMAL = 2: PRINT "You may pass, "; A$; ".  Their is a Cave to the North.": A$(14, 5) = A$(14, 5) + "  Their is a secret Cave to the north": GOTO 1000 ELSE 6456
6456 PRINT "'Oh You don't have it.  Please go get it for Me,' Says Jamal.": B = 6: GOTO 1000
6500 CLS : COLOR 10
6510 KEY OFF: LOCATE 25, 1: PRINT "press space bar to continue..."
6515 PRINT : PRINT "You climb up and into the tram. The     the interior is dark but the instant    you are completely inside it lights up. The door hisses shut behind you."
6520 PRINT : PRINT "You walk down a deserted aisle. The     rows of seats are empty except for the  dust on them and an occasional small    alien being that has settled down."
6530 PRINT : PRINT "You reach the control cabin. A computer terminal and a seat await you. The ter- minal screen switches on as you sit.    Bright green letters flow onto it..."
6535 PRINT : PRINT : PRINT : PRINT
6540 X$ = INKEY$: IF X$ = " " THEN 6560
6550 GOTO 6540
6560 CLS
6570 PRINT : PRINT "MET STATION 22": PRINT "RAIL TRANSPORT SYSTEM": PRINT : PRINT "CAR 4"
6580 PRINT : PRINT "ROUTE SYSTEM": PRINT "---------------------------------------"
6590 PRINT : PRINT : PRINT 1; " SUPPLY STATION": PRINT 2; " HYDROPONICS SECTION": PRINT 3; " CONTROL SECTION"
6600 PRINT 4; " PAD 1A": PRINT 5; " PAD 1B": PRINT 6; " PAD 2A": PRINT 7; " PAD 2B": PRINT 8; " WAREHOUSE": PRINT 9; " DEPARTMENT STORE": PRINT 10; " CASINO"
6610 PRINT : INPUT "DESTINATION "; DD
6620 IF DD = 1 THEN B = 7: GOTO 6700
6630 IF DD = 2 THEN B = 8: GOTO 6700
6640 IF DD = 3 THEN B = 10: GOTO 6700
6650 IF DD = 6 THEN GOTO 7000
6660 IF DD = 8 THEN PRINT "SORRY-THERE WAS A TUNNEL COLLAPSE THERE.": GOTO 6610
6661 IF DD = 9 THEN PRINT "THE DEPARTMENT STORE IS CLOSED.": GOTO 6610
6662 IF DD = 10 THEN A = 25: B = 9: GOTO 6700
6670 GOTO 6800
6700 COLOR 9: CLS : PRINT "The tram drops you off and swishes away on the second pair of rails...": PRINT : GOTO 1000
6800 CLS : PRINT " You are outside an empty spacecraft    launch pad. You can see a black pit and a support gantry. Huge doors above the  pit are closed. The tram won't let you  off here because there is no spacecraft to board..."
6840 FOR I = 1 TO 4000: NEXT I
6850 GOTO 6580
7000 'THE END OF IT ALL.......
7010 COLOR 9: CLS
7020 PRINT "The tram leaves you at the entrance to  pad 2A. A gleaming white shuttle with a delta wing is in a vertical position    before you."
7030 PRINT : PRINT "The shuttles from all the other pads    left with the survivors of MET station  22. Unfortunately the shuttles took off in a Plains Storm. The wreckage is on   the plain somewhere...."
7040 PRINT : PRINT "A flashing forcefield stops You from    advancing on the escape ship. Each time You try to push through a synthesized   voice keeps asking for a 'SECURITY CODE'...."
7050 PRINT : INPUT "What are you going to tell it"; SEC$
7051 FOR CAP = 1 TO LEN(SEC$)
7052 IF ASC(MID$(SEC$, CAP, 1)) < 123 AND ASC(MID$(SEC$, CAP, 1)) > 96 THEN MID$(SEC$, CAP, 1) = CHR$(ASC(MID$(SEC$, CAP, 1)) - 32)
7053 NEXT
7060 IF SEC$ = "L" OR SEC$ = "LOOK" THEN PRINT "The code is back near the hydroponics   section in the MET Station. You missed  it if you don't know it. Its on a CRT   somewhere...(Use the Look function)": PRINT : GOTO 7200
7080 IF SEC$ = "GO TRAM" OR SEC$ = "ENTER TRAM" OR SEC$ = "GO BACK" THEN GOTO 6560
7090 IF SEC$ = "ALPHA 123" OR SEC$ = "ALPHA-123" OR SEC$ = "A 123" OR SEC$ = "PLANETEER" OR SEC$ = "IBM" OR SEC$ = "COMPUTER" THEN GOTO 7400
7095 INCORRECT.PASSWORD$ = "Not until You cough up the security     code, bud. And yes- it does exist. And  No- it is not hard to find.             Near the hydroponics...":
7100 IF SEC$ = "GO SHIP" OR SEC$ = "GO SHUTTLE" OR SEC$ = "BOARD SHIP" OR SEC$ = "ENTER SHIP" OR SEC$ = "ENTER SHUTTLE" THEN PRINT INCORRECT.PASSWORD$
7110 PRINT : PRINT "You must have the security code to go   anywhere except back to the tram...": PRINT
7200 GOTO 7050
7400 PRINT "  You finally are on the escape ship.   You hear a voice:"
7401 PRINT "  'Well, "; A$; ", "
7402 PRINT "You have finally made it aboard         My ship.  Heh, heh, heh, heh, heh...'"
7403 PRINT "That voice sounds familiar....          It's Jason David Frank!  It was a trap!"
7404 PRINT "Suddenly His face flashes up on the     Computer screen and He says,"
7405 PRINT "'I programmed this ship to take You     to My domain.  Their I will finish You  off once and for all!'"
7406 PRINT "The ship hovers over Your house and     takes You to Jason David Frank's        domain.... "
7407 PRINT : PRINT "Press any key to continue...": WHILE INKEY$ = "": WEND
7408 CLS
7409 A = 25: B = 1
7410 PRINT "  The ship lands in a big room of       some sort of building with halls going  to the north and east.  The ship's      door closes behind You as You exit it."
7415 PRINT
7420 PRINT "This is it.  Jason David Frank is       waiting for You at the end of one of    the two corridors.  He's tough.         Good luck, "; A$; "!"
7422 GOTO 1000
7450 '
7451 '
7452 PLAYER = 8: JDF = 8
7453 REM   The final battle with Jason David Frank.
7454 PRINT : INPUT "Whaddya gonna do?!"; F$
7455 FOR CAP = 1 TO LEN(F$)
7456 IF ASC(MID$(F$, CAP, 1)) < 123 AND ASC(MID$(F$, CAP, 1)) > 96 THEN MID$(F$, CAP, 1) = CHR$(ASC(MID$(F$, CAP, 1)) - 32)
7457 NEXT CAP: HIT$ = "You Hit Him!": MISS$ = "but You miss..": IF PLAYER = 0 THEN 7699: IF JDF = 0 THEN 7799
7458 IF I$(3, 2) = "" AND (INSTR(F$, "BLAST") OR INSTR(F$, "SHOOT")) THEN PRINT "Sorry, no Blaster..": GOTO 7463
7459 IF INSTR(F$, "BLAST") OR INSTR(F$, "SHOOT") THEN BLS = BLS + 1: HIT = RND: IF RND > .5 THEN PRINT "ZAP!  " + HIT$: JDF = JDF - 1: GOTO 7463 ELSE PRINT "Missed!": GOTO 7463
7460 IF INSTR(F$, "JUMANJI") OR INSTR(F$, "GAME") THEN GOSUB 4800: GOTO 7463
7461 IF I$(3, 3) = "" AND INSTR(F$, "TRUMPET") > 0 THEN PRINT "Sorry, but You are not carrying         the Trumpet.": GOTO 7463 ELSE IF I$(3, 3) = "TRUMPET" THEN PRINT "The Sounds of the Trumpet can't hurt    Jason David Frank...": GOTO 7463
7462 IF I$(5, 11) = "" AND INSTR(F$, "VIRTUALIZE") OR INSTR(F$, "TROOPER TRANSFORM") THEN PRINT "You not carrying the Virtualizer!": GOTO 7454 ELSE IF I$(5, 11) = "VIRTUALIZER" THEN PRINT "Now Your a VR Trooper!":    GOTO 7463
7463 IF INSTR(F$, "KNIFE") > 0 OR INSTR(F$, "STAB") > 0 THEN IF I$(4, 9) = "KNIFE" THEN PRINT "  You pull out Your knife and try to    stab Jason David Frank, ": STAB = RND: IF STAB > .5 THEN PRINT HIT$ ELSE PRINT MISS$: GOTO 7466
7464 IF I$(4, 9) = "" AND (INSTR(F$, "KNIFE") > 0 OR INSTR(F$, "STAB") > 0) THEN PRINT "Sorry, You don't have the Knife."
7465 IF INSTR(F$, "HAMMER") THEN PRINT "You Can't Use...."
7466 REM  'Jason David Frank's Attack.
7467 ATTACK = INT(RND * 2): IF ATTACK = 1 THEN GOTO 7480
7468 PRINT "  Jason David Frank Karate Kicks You    And, He "; : KICK = RND: IF KICK > .5 THEN PRINT "Hits You. ": PLAYER = PLAYER - 1: GOTO 7454 ELSE PRINT "misses..": GOTO 7454
7479 IF INSTR(F$, "JUMANJI") OR INSTR(F$, "GAME") THEN GOSUB 4800: GOTO 7463
7480 PRINT "  Jason David Frank attempts to strike  You with His sword.  And He "; : SWORD = RND: IF SWORD > .5 THEN PRINT "Hits You. ": PLAYER = PLAYER - 1:   GOTO 7454 ELSE PRINT "Misses You.": GOTO 7454
7499 'ADSF
7699 PRINT "  You got Beat, Bud.  Jason David Frank jumps up in ecstacy over His triumph,   Jason David Frank takes You aboard His  falcon zord and to Zordon's             Command Center, and that's it.. too bad": GOTO 8000
7799 PRINT "  You hit Jason David Frank for the     last time, He fall dead, suddenly a     time bomb is set, just as You try to    make Your escape out, The Planeteers    come to the rescue in their Geocruiser. 'Let's Go, "; A$; "!'"
8000 'you is dead
8005 BEE = BEE
8010 PRINT : PRINT "You is dead, buddy.  Watch out next ": PRINT "time or you'll continue to meet this": PRINT "grisly fate!"
8020  PRINT : PRINT : INPUT "start again (Y or N)"; X$:                               IF LEFT$(X$, 1) = "Y" OR LEFT$(X$, 1) = "y" THEN GOTO 970 ELSE PRINT "Thank You for playing ADVENTURE 2000."
8030 END
8500 PRINT "You can't go any farther into the tun-  nel than this. It is not lit and bes-   ides, there are all kinds of wonder-    ful creatures just waiting for you to   try something...": GOTO 1030
9000 'FILE
9002 ON ERROR GOTO 9900
9010 COLOR 9, 1: CLS : PRINT : PRINT : PRINT "SAVE GAME": PRINT "_______________________________________"
9020 PRINT : PRINT : PRINT "Use Your first name for a filename-": PRINT "that way many people can have files and": PRINT "easily rememger where they are...": PRINT
9030 INPUT "Your first name"; NME$
9040 PRINT : PRINT "Is '"; NME$; "' right"; : INPUT C$
9045 IF C$ = "Y" OR C$ = "YES" THEN 9050 ELSE 9030
9050 DDD$ = ".DAT": NME$ = NME$ + DDD$
9055 OPEN "O", 1, NME$
9080 FOR H = 1 TO 20
9090 FOR H1 = 0 TO 11
9100 PRINT #1, D$(H, H1); ",";
9110 NEXT H1, H
9113 FOR H = 1 TO 5
9114 FOR H1 = 0 TO 16
9115 PRINT #1, I$(H, H1); ",";
9116 NEXT H1, H
9120 PRINT #1, A39$
9125 PRINT #1, A, B
9127 PRINT #1, P, L
9128 IF W$ <> "" THEN PRINT #1, T; W$
9129 IF W$ = "" THEN PRINT #1, T; W$; ","
9130 PRINT #1, BLS, SCORE, K, K1
9133 PRINT #1, C, R, S, S1, CRQ, CTS, MONEY, JAMAL
9140 CLOSE #1
9155 PRINT : PRINT "All right. Your game is saved.": INPUT "Want to keep playing (Y or N)"; Z$
9156 IF Z$ = "Y" THEN COLOR 9: GOTO 1000
9157 BEEP: END
9500 'LOAD GAME
9510 COLOR 0, 1: CLS : PRINT : PRINT : PRINT "LOAD GAME": PRINT "_______________________________________"
9520 PRINT : PRINT : PRINT "For filename, enter your first name and I'll try and find your game...": PRINT : PRINT
9530 INPUT "first name, please"; DAT$
9540 PRINT : PRINT "Is '"; DAT$; "' right"; : INPUT C$
9545 IF LEFT$(C$, 1) = "Y" OR LEFT$(C$, 1) = "y" THEN 9550 ELSE 9530
9550 DAT$ = DAT$ + ".dat"
9552 ON ERROR GOTO 9900
9555 OPEN "I", 1, DAT$
9580 FOR H = 1 TO 20
9590 FOR H1 = 0 TO 11
9600 INPUT #1, D$(H, H1)
9610 NEXT H1, H
9612 FOR H = 1 TO 5
9613 FOR H1 = 0 TO 16
9614 INPUT #1, I$(H, H1)
9615 NEXT H1, H
9616 INPUT #1, A39$
9620 INPUT #1, A, B
9623 INPUT #1, P, L
9625 INPUT #1, T, W$
9630 INPUT #1, BLS, SCORE, K, K1
9633 INPUT #1, C, R, S, S1, CRQ, CTS, MONEY, JAMAL
9640 CLOSE #1
9755 PRINT : PRINT "Ok. Your game is loaded in.": INPUT "Type 'Y' to start...        "; Z$
9756 COLOR 9
9760 IF Z$ = "Y" OR Z$ = "y" THEN GOTO 1000 ELSE INPUT "Type 'Y' to start...", Z$:   GOTO 9760
9900 IF ERL = 5801 AND ERR = 5 THEN PRINT "Illegal function call in line 5801 of module ALIEN    at address 5532:3AB4": PRINT : PRINT "Press any key to return to the Game": WHILE INKEY$ = "": WEND: NOTE$ = "": RESUME
9901 IF NOT (ERR = 53 OR ERR = 7) THEN ON ERROR GOTO 0
9903 IF ERR = 7 THEN RESUME 1000
9905 PRINT : PRINT : PRINT : PRINT "You made a mistake somewhere...": PRINT "I'll return you to your game and you": PRINT "can start again with whatever you were  doing-": FOR YYY = 1 TO 2000: NEXT YYY
9910 CLOSE : RESUME 1000
11000 FOR I = 1 TO 10: FOR I1 = 1 TO 11: PRINT I, I1: PRINT D$(I, I1), I$(I, I1): NEXT I1, I
11010 PRINT A39$; "  DETERMINES A$(3,9)"
11030 PRINT "a"; A, "b"; B
11040 PRINT "p"; P, "L"; L
11050 PRINT "T"; T; " OF INTEREST:"; W$
11060 PRINT "k"; K, "k1"; K1
11070 PRINT "bls"; BLS, "score"; SCORE
11080 PRINT "c  "; C, "r    "; R
11095 PRINT "s  "; S, "s1   "; S1
11100 GOTO 11100
12000 '**ADVENTURE help***
12010 '**ADVENTURE 2000***
12040 KEY OFF: WIDTH COLMN: COLOR 9, 1: CLS
12050 LOCATE 25, 1: PRINT "press space bar to continue...": LOCATE 2, 1
12070 'BACKROUND
12080 PRINT "Welcome to ADVENTURE...": PRINT : PRINT "This is a type of game that has its": PRINT "roots in ths fantasy roll-playing   "
12090 PRINT "of 'D&D'(Dungeons and dragons). But": PRINT "the computer versions are really quite "
12100 PRINT "different.": PRINT : PRINT
12110 PRINT "In this game you will assume the roll": PRINT "of a character faced with a series of"
12120 PRINT "situations requiring decisions and": PRINT "quick, intelligent reactions. The": PRINT "computer gives you descriptions of"
12130 PRINT "various places, objects, and events.": PRINT "You react to the stimulus and tell ": PRINT "the computer what you want to do."
12140 PRINT : PRINT : PRINT "This game will require you to think a   little bit..."
12150 PRINT
12160 X$ = INPUT$(1): IF X$ = " " THEN 12180
12170 GOTO 12160
12180 CLS : LOCATE 25, 1: PRINT "press space bar to continue..."
12190 LOCATE 3, 1
12200 PRINT "One letter commands:": PRINT : PRINT "N for 'walk north'": PRINT "E for 'walk east'": PRINT "W for 'walk west'": PRINT "S for 'walk south'"
12210 PRINT "I for 'inventory'": PRINT "L for 'look'": PRINT : PRINT "one word commands:"
12220 PRINT "west, inventory, south, east, north ": PRINT "help, quit, look, shoot, blast, etc.": PRINT : PRINT
12230 PRINT "The computer will understand many words": PRINT "so don't hesitate to tell it what": PRINT "you want it to do in two-word commands, such as:"
12240 PRINT "get <item>, go door, open door,         walk <north | south | east | west>,     if such things or items exist, You can  take them."
12241 PRINT "Press space bar to continue": WHILE INPUT$(1) <> " ": WEND
12242 CLS : PRINT "SOME ITEMS:"
12243 PRINT : PRINT "BLASTER  - Blasts doors,                that cannot open.  "
12244 PRINT : PRINT "TRUMPET  - Play a tune on the trumpet,  using the PLAY command."
12245 PRINT : PRINT "EXIT MOUSE - Exits from the cave,       back to Jamal's room where              You enter."
12246 PRINT : PRINT "KNIFE - Stabs enemies."
12247 PRINT : PRINT "VIRTUALIZER - Turns You into a          VR Trooper until You You                enter the command RETROFORM."
12248 PRINT : PRINT "JUMANJI GAME - Plays the Game JUMANJI   after You find it. Unlike the game In   the Movie or Book, this game gave You   a tip if You are lost.  However,        somthing bad COULD happen,              be careful."
12250 PRINT "Press any key to continue...": WHILE INKEY$ = "": WEND
12280 CLS : RETURN
