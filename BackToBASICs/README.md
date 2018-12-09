
Back to BASICs, by Leon Peyre
==================================================

http://peyre.x10.mx/index.htm

A page about GWBASIC Games & Other Programs
-------------------------------------------

Below is a collection of
games and other programs written in BASICA that also run on GWBASIC. 
Some are programs I wrote myself; a whole bunch are [type-in
programs](http://en.wikipedia.org/wiki/Type-in_program) from David Ahl's
Basic Computer Games series of books, and a few are from other sources. 
Enjoy!

As far as I know, there are no copyright issues involved with using any
of these programs.  Of course mine are available to any and all, free of
charge.  Just don't try to take credit for them. ;-)  Several from the
Basic Computer Games series do have some modifications, as the books
themselves suggested people do.  Some of the changes I made were to
correct typos and grammatical errors (e.g., to change "You have been
over run" to "You have been overrun" in line 1960 of Dukedom).  Many of
them won't accept "y" or "n" as an answer, and instead require you to
type "YES" or "NO"; I thought that was stupid and made them accept "y"
for Yes and assume a No if you hit Enter without typing a response.  And
I typed some in mixed case instead of the all-uppercase of the first two
books.  I also seem to recall adding a few changes to make some of them
more realistic and/or less predictable.


Programs I Created
------------------

 **Manor** (1986) - This is probably my magnum opus of BASIC
 programs.  It's a land-management game, inspired by
 [Dukedom](http://www.atariarchives.org/bigcomputergames/showpage.php?pag
 e=11)
 but supposed to be much more historically accurate.  Looking back on it
 I realize I got some things wrong and should have done some more serious
 research on medieval England--but all things considered, I think I did
 fairly well.  You play the role of an earl in 14th-century England,
 surrounded by fiefs of varying power.  Each of your neighbors holds a
 different rank of nobility, with corresponding size and power: the baron
 is the smallest and weakest, the viscount's less so, the earl is about
 your strength, the marquis is stronger, and the duke is biggest and
 baddest of them all.  The game has a rating system that I never did
 succeed in tweaking to my satisfaction--but it does work, and one of the
 things I really liked was that you get more points for taking land from
 a stronger rival.  Also keep in mind that when you take land from an
 opponent, it makes them a bit more likely to take up arms against you in
 the future (in proportion to the amount of land taken).  Likewise when
 someone's taken land from you, they're more tempted to come back later
 for seconds.  Oh, and you will eventually die of old age, so no
 immortality in this game.

 I should offer some pointers on playing the game.  At 12
 acres/person, a group (Peasants, Serfs, Nobles) achieves some real
 self-sufficiency.  They can plant plenty of grain for themselves, and
 leave enough fallow for their land to improve slowly.  Too little land
 (under 8/person or so, I think) and in an effort to feed their families,
 they will leave too little fallow, and the land's fertility
 deteriorates.  Unfortunately you can't always achieve this throughout
 your manor without conquest or massive population depletion, and if you
 do manage it, your population tends to increase due to the availability
 of food, so ample land is a temporary thing.  If you can gather at least
 100 or so acres in your
 *[demesne](http://en.wikipedia.org/wiki/Demesne)* (personal estate), you
 can support yourself without taxing your Peasants or Nobles at all,
 which makes them happy and improves their health, all things being
 equal.  (This is one of the few areas where the game isn't very well
 balanced; I probably should have corrected this oversight.)  If you get
 a message saying that a group is malnourished but you aren't offered the
 chance to feed them (and you have grain available), that means the
 malnourishment is minimal.  If either the Peasants or Serfs decide to
 rise up against you, the other group will rise up as well, even if it's
 quite happy.  The Nobles will band together to protect you, though,
 unless they're very upset with you.  When you're about to go to war, if
 the Nobles complain there aren't enough Peasants, they *will* fight less
 well (this makes it less effective to just knight all your Peasants). 
 If you're invaded, you're asked whether to retreat to the castle. 
 Holing up in the castle improves the chances of winning, but reduces the
 amount of your opponent's land you can take if you win.  Also, should
 you incur debts, you *will* pay interest on them.

 One issue you're likely to run into if you play for a while is
 that the game seems to hang sometimes right after a war.  It probably
 hasn't, in fact.  Following a war, the game updates the map to reflect
 the change in land ownership (X conquered *N* acres from Y).  It uses, I
 think, a fairly inefficient method--selecting a square at random,
 checking to see if that square is on the border between the two manors,
 and if so, changing its ownership.  This was a simple way to ensure that
 it would work anywhere on the map, even if the borders got pretty
 distorted, and it avoided making changes starting from the top right or
 some other recognizable pattern.  The trouble is that it can sometimes
 take a while to find a square that's along the border.  It also happens
 in rare cases that two formerly neighboring manors have lost their
 common border, so it won't be able to find qualifying squares in any
 case.  Similarly, there's a rare bug that I never did track down, where
 one manor will attack another that it never has bordered: the Baron (on
 the left) attacking the Earl (on the right), for instance.  To make sure
 the game does move on at some point, I added a timer that will
 eventually make it stop looking for squares and proceed with the game;
 it times out after a minute or two, I think.  (Unfortunately I think
 there are also some rare instances where this part of the game really
 does hang, but I've never been able to verify it.)

 **Manor Intro** - Gives
 instructions for playing Manor, complete with music ("*[Twa
 Corbies](http://www.contemplator.com/child/twacorbies.html)*").

**Quadrant**
 (1984) - An old-style [text Star Trek
 game](http://en.wikipedia.org/wiki/Star_Trek_%28text_game%29): destroy
 all the Klingons before they take over the Federation.  This game was
 heavily influenced by [Video Trek 88](index.html#VidTrek), [Super Star
 Trek](http://www.atariarchives.org/basicgames/showpage.php?page=157),
 [Apple Trek](http://apple2history.org/history/ah14.html#08),
 and--especially for things like the menu
 options--[Seabattle](http://www.atariarchives.org/morebasicgames/showpage.php?page=143),
 oddly enough.  When asked for number of Starbases and Klingons, hit
 Enter for a random number.  Coordinates in the game are given as y,x
 rather than x,y (a misunderstanding on my part when I first wrote the
 game--when I realized I had them backward, it would have been a real
 pain to correct it).  Your Warp and Impulse engines can each be used to
 travel either within or between quadrants--it's just that Warp is
 awkward within quadrants, and Impulse is very slow between them.  Higher
 speeds use more power but take less time.  Higher shield strengths give
 you better protection but consume much more power.  Also, the Klingons
 are somewhat more powerful than they tended to be in other [text-based
 Trek games](http://en.wikipedia.org/wiki/Star_Trek_%28text_game%29); in
 particular, they also fire torpedoes (something Quadrant shares with
 [Apple Trek](index.html#AppleTrek)).

 **Struggle for the Continent** (1991) - A Risk-like game for 2 or
 more players.  This is meant to simulate World War I, more or less. 
 Different countries' armies have different combat strengths; the
 strongest are German and Swiss, the weakest Russian.  Also, each country
 has a maximum number of troops that it can mobilize--once you've reached
 your max, you'd better hope your opponent is almost out or that your
 allies still have some left.  Of course, there's always the possibility
 of drawing neutrals into the war.  The map is based on the 1914 borders,
 and on the battle lines that were drawn as troops advanced and
 retreated.  Unfortunately the graphics available in GWBASIC are crude,
 so the map can be very difficult to make out.  To help with that, I've
 included a scanned copy of the map I used when I originally designed
 this as a board game.  Also, the directions that the arrow keys move you
 don't *always* seem to make sense: there were times when, say, there
 were four places you could go to the north, and there are only three
 keys at the top of the keypad, so I had to make do.  So you may find
 there are times when pushing the right arrow actually moves you
 northeast, and so forth.

**An Aspect of Statistics** (ca. 1987-88) - I took a semester of
 statistics in college--the only math class I've actively enjoyed,
 largely because it felt like something I could really *use*.  And indeed
 I did: I used it to write this program.  You input binomial data (x,y)
 and it will tell you the mean, median, standard deviation, the formula
 for the best-fitting line, and will even draw a crude scatter diagram
 showing the best-fitting line.  For those not familiar with statistics,
 the best-fitting line gives you some predictive power; assuming your
 data forms something like a line, you can use this equation to get an
 idea what to expect y to be, given x.  For instance, you could chart gas
 prices over time and use the best-fitting line to estimate what the
 price will be a year from now.  In grad school, one of my more
 self-absorbed professors ([not to mention any
 names](http://www.polsci.ucsb.edu/content/view/137/195/)) wrote in his
 comments on one of my papers, "Learn some statistics!"--which was
 ironic, considering the scatter diagrams in my paper had been generated
 by this statistics program *I wrote*.  Harrumph.

 **Flashcards** (1991) - As the name suggests, a program that
 does flash cards.  It lets you enter questions and answers, and save
 them to disk, then use the program to quiz yourself.  This helped get me
 through some of my college finals.

 **Trek**
 (mid-1980s) - An adaptation of FASA's [Star Trek III Starship Combat
 Role Playing Game](http://en.wikipedia.org/wiki/Star_Trek_RPG_(FASA)),
 but done on a square instead of a hex grid.  This is a turn-based
 ship-to-ship combat sim.  FASA's system allows any number of ships to
 interact, though to make it (much) simpler to program, my implementation
 is limited to one-on-one combat.  Every three turns you allocate your
 available power to movement, weapons, and shields (Press \\\* to set a
 shield to full power).  Different ships have more or less efficient
 shields and movement ratios, more or less accurate beam weapons, and
 more or less accurate and powerful torpedoes.  You can fly Federation,
 Klingon, Romulan, Gorn, Orion, and even Tholian ships.  You can also
 input your own vessel.  This was a big hit on my dorm floor in 1988,
 'till the guys found better games to play--like [Macintosh
 Risk](http://6-bleen-7.livejournal.com/107770.html).
       The Tholian ship was my invention; I created it based on what
 little was known about Tholians back then.  I originally called its beam
 weapon the "Easer", which was supposed to mean an energy beam comparable
 to phasers, but I should have thought of a less dopey name for it.  In
 April 2009, I stumbled on an unofficial (but apparently well-developed)
 site, [Star Trek Starship Tactical Combat
 Simulator](http://www.tacticalstarshipcombat.com/FASA/STSTCS%20Home%20Pa
 ge.htm),
 dedicated to maintaining and expanding the old FASA game.  I see the
 folks there have given the Tholians' beam weapon a name: **Phaser**. 
 Unexciting, I suppose, but that's as close to official as I've seen
 anywhere on the Web, so I've updated this game to reflect the new name.

**Farkle**
 (1997) - This is an implentation of an old dice game that we used to
 play with my grandfather, Olley Cote, at least as far back as the
 1970s.  (It's apparently [an old folk
 game](http://en.wikipedia.org/wiki/Farkle) which has since been marketed
 commercially.)  This was a family favorite for years, then after his
 death people stopped playing it, and I later had to reconstruct the
 rules from memory.  Here are the basics: you roll six dice and look for
 ones that are worth points.  A 1 is worth 100; a 5 is worth 50; a
 combination of three is worth a hundred times the number: so three fours
 are worth 400 points, etc.  Three ones, however, are worth 1000, and a
 roll of 12345 is worth 1500 points.  You set aside the dice you want to
 keep and can roll again to collect more points--of course, if at any
 time your roll isn't worth anything, you've "farkled" and get nothing. 
 Also, you have to pull out at least one die per roll, so you can never
 roll more than five times per turn.  The goal is to be the first to
 reach 5000 points, and you need 500 points in one hand in order to get
 on the board.  Until you get on the board, your scores don't count; so
 even if you roll 450, you get nothing for that turn if you're not on the
 board yet.  I've always felt that was excessive--when I'm playing the
 game in real life I tend to ignore the requirement to get on the board. 
 Unfortunately though, I didn't write that option into the game and now
 it's more trouble than it's worth to go back and add it.

Programs From Other Sources
----------------------------

 **Elements** - Periodic Table of the Elements (by a
 friend in high school, Rodney Elin).  He wrote it for the [Apple
 II+](http://en.wikipedia.org/wiki/Apple_ii), which had a
 40-character display, so his table was displayed sideways.  Adapting
 it to the [IBM PC](http://en.wikipedia.org/wiki/IBM_PC), which had
 an 80-character display, I was able to put it right-side up.  It's
 quite a bit out of date: we're up to 118 elements, and all those
 through 111 have names now.  Also when I wrote this, the names of
 elements 104 and 105 weren't yet firmly established; the US and USSR
 each had a different preferred name for each, and I chose the Soviet
 name for 104 and the American one for 105.  Looks now like they're
 both wrong.  A good source for more information on the current
 Periodic Table is [WebElements](http://www.webelements.com/).  Also
 (and embarrassingly now), the comments for each element is taken
 from an old old Star Trek fan book, possibly [The Star Fleet Medical
 Reference
 Manual](http://www.amazon.com/Star-Trek-Medical-Reference-Manual/dp/
 B0006WND8S).

 **Launch** (ca. 1984-85) - Design a rocket and launch it
 into orbit.  I typed this in from a computer magazine that a friend
 lent me.  Strangely, but probably for simplicity, it doesn't have
 you actually establish an orbit, which would require getting enough
 horizontal speed to balance the pull of gravity.  Instead it just
 assumes that once you reach 400 miles up (about twice the height of
 the ISS today), you're in orbit.  The physics in the game are
 algebra-based (physics is usually calculus-based), but didn't
 work--possibly it was written for a different dialect of BASIC, or
 maybe I goofed big-time when typing them in.  However, as it
 happened, in Fall 1987 I took a course in introductory algebra-based
 physics, and used what I learned to rewrite the calculations, so the
 game works now.  But if you're interested in doing more than just
 launching a rocket, you might want to check out [Buzz Aldrin's Race
 Into Space](http://peyre.x10.mx/BARIS/index.htm).

**The Devil's Dungeon** (mid 1980s) - Typed in from a copy
 of [Stimulating
 Simulations](http://books.google.com/books?id=H7yqUDsDixAC&pg=PA63&l
 pg=PA63&dq=%22the+devil%27s+dungeon%22+book+BASIC+-filmed+-eamon&source=
 bl&ots=1nvF_miW-4&sig=kLT9gHBzrhFTeAyQeGPuA5xkbzM&hl=en&sa=X&ei=8o4oT7im
 L4qsiQKIwNXIAQ&ved=0CEEQ6AEwBg#v=onepage&q=%22the%20devil%27s%20dungeon%
 22%20book%20BASIC%20-filmed%20-eamon&f=false)
 by C.W. Engel).  The book came in different flavors for different
 types of computers; the one I used was for the Apple, which seems a
 little hard to find today.  Here's a link to [the Commodore 64
 version](http://www.scribd.com/doc/76811987/Stimulating-Simulations-
 for-the-Commodore-64)
 and one to a text copy of [the Vic
 version](http://dogandpanda.com/production/stimulating%20simulations
 %20for%20the%20vic.htm)
 (remember the Vic20?), or you can download a PDF of [the Atari
 version](http://peyre.x10.mx/GWBASIC/Books/Stimulating_Simulations_A
 tari.pdf)
 directly from here.

According to the game intro:

_For many years now you have heard rumors
 of large quantities of
gold hidden in a maze of
 caves whose connecting
passageways lead deep beneath the earth of an oc
casionally active volcano.  The stories tell of
monsters and demons who
roam through the caves,
poisonous gas, tremors from the volcano, and one
 man who returned from these perils alive and named the caves The Devil's Dungeon._

_After much searching, you have located the wealthy, solitary man
 who survived a journey
through the dungeon; and
 he has agreed to see you.  Although now very old and in poor health, he
 tells you everything he
 can remember about the
dungeon._

Briefly, you have two attributes, speed and strength.  You
 need both to defeat monsters, or just speed to run from them. 
 Whenever to move from room to room, you lose 1 point of speed and
 strength per dungeon level (2 of each at level 2, etc.).  You'll
 gain experience with time, which you can trade for speed and
 strength in room \\\#1 at any dungeon level.  Also in room \\\#1 you
 can escape the dungeon.  Many rooms have dropoffs which you can take
 to the next level down, and you can use the magic wand you carry to
 create dropoffs.  Poisonous gas will sap your strength, while demons
 will reduce your speed and steal some of your gold.  It's
 recommended to map the dungeon level you're on, though tremors can
 block passageways and open others.  Read the game's entry in the
 book (in the Atari version, p. 89-91, or 99-101 in the PDF) for
 details.
  
From the Basic Computer Games Series
------------------------------------

  ***[Basic Computer Games](http://www.atariarchives.org/basicgames/)***
 (1978) 

 **Civil War** (1968) - A US Civil War simulator.  Pretty standard fare
 for back then--all you hardcore tactical gamers, don't get excited.  You
 select a battle to fight, and choose one of four very basic strategies
 for a battle. Then you dedicate resources to it, and hope you made the right
 decisions.  For one or two players (single-player always plays the
 Confederacy).

 **Fur Trader** - The book says it best: "You are the leader of a
 French fur trading expedition in 1776 leaving the Ontario area to sell
 furs and get supplies for the next year.  You have a choice of three
 forts at which you may trade.  The cost of supplies and the amount you
 receive for your furs will depend upon the fort you choose.  You also
 specify what types of furs that you want to trade."  It's a very simple
 simulation: basically you choose the fort you want to choose at, the
 numbers of different types of pelts, and the game rolls dice to
 determine what happens; there isn't much skill or planning involved.

 An interesting bit of historical accuracy to this is that the
 Iroquois were traditionally the implacable enemies of the French,
 from the [early days of
 Québec](http://en.wikipedia.org/wiki/New_France)--since the French
 had sided with their arch-enemy, the Huron.  You can certainly see
 why a French trading party would be in peril crossing
 Iroquois country.

**Lunar** - One of three lunar landing simulators featured in
 the book.

 **Poker** - Play draw poker against the computer.  To fold, bet 0.  To check, bet .5.

 **Stock Market** - Play the stock market.  Enter a positive
 number to buy, a negative number to sell, or 0 to do no trading.

 **[Super Star Trek](SUPER.zip)** (1972-3) - This is a classic
 [old-school Star Trek
 game](http://en.wikipedia.org/wiki/Star_Trek_%28text_game%29).  The
 original Star Trek games involved an 8x8 galaxy grid; the object of the
 game is to destroy all the Klingon Battle Cruisers before they overrun
 the Federation.  This type of game first appeared in the late '60s on
 university mainframes.  Some of the really early ones didn't even
 display on a screen--the computer printed it out on paper!  A vestige of
 that is the line in the introduction that tells you to turn on the TTY
 ([Teletype machine](http://en.wikipedia.org/wiki/Teletypewriter)).  Note
 that commands have to be typed in ALL CAPS.  The symbols in the game
 are:
 `<*>` The Enterprise   `+K+` Klingon Ship   `>!<` Starbase   `*` Star  
   ([Wikipedia article](http://en.wikipedia.org/wiki/Super_Star_Trek))

 **Super Star Trek Intro** - Gives instructions for
 playing Super Star Trek.

  ***[More Basic Computer
 Games](http://www.atariarchives.org/morebasicgames/)*** (1979) 

 **Man-Eating Rabbit** - Of course I *had* to try this one
 out.  It's apparently a Monty Python reference (remember the Cave of
 Caerbannog?)--though I never made the connection.  Thanks
 Christopher for pointing it out!

 _In this game you are in a pit with a man-eating rabbit.  The cent
 er of the pit, appropriately enough, is at 0,0 and it has a radius of 10
 .  On each move, you can move in any one of eight different angles, 0, 4
 5, 90, 135, etc.  Unlike you, the rabbit can take more than one hop on a
move.  The object of the game is to avoid the rabbit for ten moves.  If
you do this successfully you'll be released and set free.  We're not sure what race of people on what planet dreamed up this diabolical sport,
 but we've found that it's extremely difficult to get away from the rabbi
 t in more than about one out of ten games.  You may, therefore, want to
 improve the odds somewhat by limiting the number of moves the rabbit can
make on each turn to one or two._


 **Pinball**) - A text-based pinball game.  Why not?

 **Seabattle** - An excellent old-style game, on a par
 with Super Star Trek.  You pilot a submarine in an area filled with
 enemy ships and sea monsters.  Destroy all the enemy ships without
 being sunk by a ship, eaten by a sea monster, or running into a
 mine.  You can destroy ships with torpedoes, Polaris missiles, or by
 sabotage (sending scuba divers to attach explosives to the ships'
 hulls).  Sea monsters are harmed only by missiles.  I eventually got
 good at the game and found it too easy, so I added a Skill Level
 that increases or decreases the number of enemy ships.  Decimals
 (e.g., .5, .8, 1.2, 1.5, etc.) are fine.  To play the game as
 originally written, use Skill Level 1.  The symbols are:\
 `(X)` You   `\S/` Enemy Ship   `-\#-` Sea Monster   `\$` Mine   `\*`
 Land   `!H!` Your Headquarters   `·` Sonar malfunction, or waves if
 above 50'

 **Twonky** (1977) - "The
 computer will set up a 15x15 playing field in which you are randomly
 located.  Also inside the field is an objective square, 30 blocked
 squares (walls), 22 relocation squares, and 1 super special new maze
 square, and, of course, the Twonky (which is no relation to a
 creme-filled cupcake).  To win a game, you must reach the objective
 square before the Twonky gets you, by moving one square at a time,
 forward, backward, right or left.  Unfortunately, you are hindered
 by several things:
 - RELOCATION squares, when moved on, cause you to be randomly
 transported to another position in the maze.
 WALLS; you can't move into these squares, and lose your turn when
 you hit one.
 - SUPER-MAZE SQUARE; essentially an instant loss, since when you move
 here a completely new maze is set up.
 - TWONKY; after every move, the Twonky moves toward you.  (He is
 impervious to all traps, even walls.)  When he gets too close to you
 (2 or fewer squares), you lose.  However, you are equipped with a
 de-materializing ray gun.  You have the option of using this on your
 turn.  If you hit the Twonky he de-materializes and then
 re-materializes on a different square of the maze to resume his
 quest after you....  When shooting at the Twonky, you do *not* have
 a shot if the distance he is from you is not an integer."


 **Wumpus** (1972) - Written by a guy who tired of the
 standard 10x10 grid that other games of the time were based on.  Get
 the Wumpus before it gets you, in a cave shaped like a squashed
 dodecahedron filled with pits and bats, armed with a crooked arrow
 that can turn corners.  This one has become a classic and seems to
 have a bit of a cult following.  ([Wikipedia
 article](http://en.wikipedia.org/wiki/Hunt_the_Wumpus))\

  ***[Big Computer
 Games](http://www.atariarchives.org/bigcomputergames/)*** (1984) 

 **Dukedom** (1974-1980) - A much more involved
 land-management simulation than Hammurabi, set in a fantasy medieval
 kingdom.  You're one of a number of Dukes under the High King.  The
 goal is to survive whatever life throws at you, and eventually
 defeat the High King and take his throne.  Measurements are in
 metric, which feels incongruous for a medieval game, but
 realistically, modern English measurements aren't really period
 either.  When you decide how much to feed your people, 14HL per
 person will adequately feed everyone; 13HL will cause some hunger
 and weaken your people, and 12HL or below will cause some
 starvation.  (Numbers of 100 or above are assumed to mean total
 grain to the people instead of per person.)  Leave some land
 unplanted to let it recover its fertility.  The High King will try
 to antagonize you into fighting if you conquer a rival dukedom. 
 Always try to hire lots of mercenaries for war.  The manual has a
 Historical Waiver blurb, which actually misses most of the game's
 historical inaccuracies--there were so many that I chose to write my
 own medieval land-management game (see [Manor](index.html#Manor)
 above).  It's also too easy once you figure out the key to winning
 the game; still, it can be fun to play now and then.

 **Star Merchant** (1981) - It's the 29th century, and
 mankind has spread to nine other solar systems.  Travel from star to
 star, buying and selling goods to turn a profit.  Your operating
 costs include crew salary; as you become more successful your crew
 will go on strike and you have to negotiate a new, higher, pay
 rate.  I've found the game is fun and playable for a long time with
 luck and skill, but crew payment demands will eventually put you out
 of business, since your cargo capacities, and the prices of goods,
 are limited.  Oddly, the book says that the game was recently
 changed to add a two-player option.  It also says that there are
 pirates in interstellar space that can "exploit a loophole in the
 law of relativity", slipping onboard and stealing all your cargo in
 the blink of an eye--and that before leaving starport you'll be
 asked if you want to buy piracy insurance.  Neither the pirates nor
 multiplayer occurs in this game, so I imagine what was published in
 the book was the pre-update version.  Personally I'm glad--I like
 the game without the space pirates.

 **Monster Combat** (1981) - "a game in which you wander
 around a forest and encounter various monsters.  Your objective is
 to win as much treasure from each encounter as possible and, of
 course, not get killed in the process."  You're placed randomly in a
 forest ten squares in size, each square split into 10x10.  Symbols
 are:
   `T` Tree   `-` Path   `I` Wall   `\^` Inn   `M` Enchanted Castle   `0` You

 Enchanted castles "usually contain items of great value".  Inns
 allow you to recover your strength; of course, you have to pay to
 stay at an inn.  The monsters you can encounter, in order of
 difficulty, are: Goblin, Minotaur, Cyclops, Zombie, Giant, Harpy,
 Griffin, Chimera, Dragon, Wyvern, Basilisk.

 **Presidential Campaign** (1980) - Run for President! 
 Why not?  I don't mind being hated by half the country and never
 being able to take a pee again without the Secret Service watching.
 ;-)  You've won your party's primary at the start of the game.  The
 country is divided into six regions: New England, the upper midwest
 & middle Atlantic states, the South, the Great Plains states, the
 Southwest, and the northwest & west-coast states.  You make a few
 choices about issues etc. and decide where to campaign and how to
 distribute your war chest.  At the end, you watch as the Electoral
 College votes are cast.  I updated the game to reflect the
 distribution of electoral votes in 2000; if you want to play the
 game using the 1990 census, [use this
 version](http://peyre.x10.mx/GWBASIC/PRES90.ZIP).

  ***[Basic Computer Adventures](http://www.atariarchives.org/bca/)***
 (1986)

 It seems that David Ahl published another book, this one in the year I
 graduated from high school (and mostly stopped programming in BASIC),
 and I never learned about it until March 2011.  This book is available
 [online](http://www.atariarchives.org/bca/) along with copies of the
 games themselves already typed in. 

 The games in this book are as follows:
 - Marco Polo
 - Westward Ho! (a version of Oregon Trail)
 - The Longest Automobile Race
 - The Orient Express
 - Amelia Earhart's Around-the-World Flight
 - Tour de France
 - Appalachian Trail
 - Subway Scavenger
 - Hong Kong Hustle
 - Voyage to Neptune


 Unfortunately the entry on Earhart tells a fictional story of her
 disappearance.  Purported explanations have been many, of course, and at
 least this one doesn't involve [alien
 abduction](http://en.wikipedia.org/wiki/The_37%27s).  Still, the book
 recounts speculation that she and her navigator were captured by the
 Japanese and died in a prison camp.  The story is far-fetched
 (especially since no records of it turned up after WWII), and as it
 happens, [current
 research](http://photoblog.msnbc.msn.com/_news/2010/12/18/5674445-holida
 y-calendar-amelia-earharts-final-resting-place)
 suggests they landed on the atoll of
 [Nikumaroro](http://en.wikipedia.org/wiki/Nikumaroro) (Gardner Island)
 and died there of dehydration, poison shellfish, starvation, or possibly
 exposure.  My only real issue with this book is that it tells the story
 as if it were an established historical fact, rather than one of several
 possibilities.

-----


**Video Trek 88** (1982) - An [old-style Star Trek
game](http://en.wikipedia.org/wiki/Star_Trek_%28text_game%29) by
Windmill Software.  All the commands are single-character and the game
runs largely in real time, making it one of the fasted-paced of this
type of game.  I got this for Christmas one year (1982 or 83), and spent
many hours playing it.  It was an impressive game back then, especially
considering it ran on machines (like ours) that didn't have graphics
cards and could only handle text.  It was advanced for its time, and
made the most of what you could do with text graphics.  Inside the
linked zip file is a guide to help you get started playing it.
**Note:** The copy available on this site is modified to run in
GWBASIC.  It also includes a number of spelling/grammar corrections; for
instance, the original game misspelled Tholian as "Tholean".
