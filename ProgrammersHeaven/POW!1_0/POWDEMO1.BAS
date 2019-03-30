$string 32
$link "pow.pbl"
$include "pow.inc"


cls:print
print "POW! Library for PowerBASIC 3.0
print "(C) Copyright 1994 by Tim Gerchmez"
print:print "Demo Program #1":print"---------------":print

if sbfmdetect=0 then
	print "Adlib-Compatible Card Required.":end
end if

print "This program demonstrates the SBFMPLAY routine, which plays music contained in"
print "a string (in the foreground).  You create/transpose the music yourself and"
print "enter it directly in the PB3 IDE, without having to worry about drivers or "
print "external files."
print
print "(1)  Aloha Oe      (2)  Born Free     (3)  Brahm's Lullaby    (4)   Edelweiss"
print "(5)  Endless Love  (6)  Greensleeves  (7)  Hey Jude           (8)   If       "
print "(9)  Let it be Me  (10) Memory        (11) Minuet             (12)  Puff"
print "(13) Clowns        (14) Remember      (15) Tonight            (16)  Yesterday"
print:print "Press any key to halt a selection while it's playing."
print:line input "Enter Selection Number [ENTER alone quits]: ";s$
if val(s$)=0 then print:end
if val(s$)<1 or val(s$)>16 then run
on val(s$) gosub aloha,born,lullaby,edel,endless,green,heyjude,ifx,beme,memory,minuet,puff,clowns,remember,tonight,yesterday
run



'Let it be me

beme:

bar1$="p7n7n2w4h3r.a a a h0o6x4c r.o5w2b-w4a g h8r.f g a x4hca r.w2g w4f e hir.d f g x4h3f r.c r.hbr.f h0f e h3x5f r.r.r."
bar2$="hio6r.d d d x9o5hco6c r.o5a r.hir.o6d e d x9o5h3o6c r.o5a r.r.hbb-o6c d x9o5h3o6c r.o5f r.hir.f g a x8h5a r.r.r."
sbfmplay bar1$+bar1$+bar2$+bar1$
return

'Try to Remember
remember:

bar1$="h3n3n8w6a a a a g f hbo4b-b-b-h0b-o5c d "
bar2$="w6h3c r.o4a o5f r.c hbd r.o4b-o5h0g d r."
bar3$="w6o6hcc c c h8c o5b-a hbb-b-b-h0b-a g h3a a a hia g f hbg r.d h0e c r."
bar4$="w6h3a f w4a f hia f a f a f w8h3a f r.r.r."
sbfmplay bar1$+bar2$+bar1$+bar2$+bar3$+bar1$+bar4$
return

'Send in the clowns
clowns:
bar1$="w8n1n8i2o4b-o5c f h3f r.r.r.hir.o4b-o5c f h3f r.r.r."
bar2$="g a f g a a a r.r.r.a a o6c o5c hid r.r.r.r."
bar3$="d f o4b-o5h0c r.r.r.r.d f e h3f r.r.r.r.r."
sbfmplay bar1$+bar2$+bar3$
return

'Memory
memory:

bar1$="v4i1v5i1v6i1v1i2t0s1w6n8h0o6c r.c r.r.r.o5b o6c d c o5a hco6c r.r.c r.r.r."
bar2$="o5b o6c d c o5g h3a r.r.a r.r.r.f g a g f h9e r.r.r.r.r.r."
bar3$="o5e g h8g r.r.d r.e f r.g a r.b hco6c o5b a g r.r.r.r."
bar4$="o5e c h4g r.r.g r.r.r.r.o4a a b o5c h0c r.r.r.r.r."
sbfmplay bar1$+bar2$+bar3$+bar4$
return

'Greensleeves
green:
a$="p6n7d h8f r.g a b-a h0g r.e c d e h8f r.d d c#d h5e r.c#o4a r."
b$=p$+"o5d h8f r.g a b-a h0g r.e c d e h8f e d h5c#o4b o5c#h8d r.r.r.r."
c$="h3o6c r.c c o5b a h0g r.e c d e h8f r.d d c#d h5e r.c#o4a r.r."
d$="o5h3o6c r.c c o5b a h0g r.e c d e h8f e d h5c#o4b o5c#h8d r.r.r.r."
sbfmplay a$+b$+c$+d$
return

'Minuet
minuet:
bar1$="t3o4w4h0g r.c d e f h0g r.c r.c r.h3a r.f g a b h0o5c r.o4c r.c r."
bar2$="h4f r.g f e d h0e r.f e d c ":bar3$="o3b r.o4c d e c h4d r.r.r.r."
bar4$="h4d r.e d c o3b o4h0c r.r.r.r."
sbfmplay bar1$+bar2$+bar3$+bar1$+bar2$+bar4$
return

'Ahoha Oe
Aloha:
bar1$="n7t0i1p5w6g h3a r.o6c r.f r.r.o5a h0g r.o6c r.e r.r.c "
bar2$="o5h4b r2a b o6c d d f f o5h0o6e r.c r.o5g r.r."
bar3$="o5h4b r.o6c r.e d o5b g h0o6c r.r.r."
sbfmplay bar1$+bar2$+bar1$+bar3$
return

'Puff the Magic Dragon
puff:
bar1$="n8s0t3h3w7f r3w4f w7f f hce r.c r.hid r.f f h3c r.r.c "
bar2$="o4hib-b-o5c o4b-h3a o5c f w4f f "
bar3$="w7h4f d e f h0g r.r.r."
bar4$="w7h4d f h0e g h3f r.r.r."
sbfmplay bar1$+bar2$+bar3$+bar1$+bar2$+bar4$
return


'We've got tonight
tonight:
bar1$="p6s1n8o5b a g h4d r.rh1.r.r.b a g h0d d r.r.h1r.r."
bar2$="b o6d o5b h4o6d r.rh0.r.r.e d c o5h4o6d r.r.o5h1o6r.r."
bar3$="o5b o6d o5b h4o6d r.r.o5w2b a g w5r.r.h0r.r.b a g h4g r.r.r.r.r."
sbfmplay bar1$+bar2$+bar1$+bar3$
return

'Born free
born:
bar1$="p4w7n3n8t2h0o5c r.r.o4g r.r.h3r.r.g a g f h0e r.r.c r.r.h3r.r.g a g f h9b r.r.g r.e "
bar2$="h4f r.f f e d h0e r.r.r.r.r.r.r.r."
bar3$="h4g r.g g a g h4b r.r.r.r.r.r.r.r."
bar4$="o5h8d r.r.o4a r.r.r.r.a b a g hce r.r.o5c r.r.r.r.c d o4a o5c h3d r.c d r.c h1d r.c d r.c h4d r.r.r.r.r.r.r.r."
bar5$="h8o5c r.r.c r.r.o4h0o5c r.r.r.r.r.r.r.r."
sbfmplay bar1$+bar2$+bar1$+bar3$+bar4$+bar1$+bar5$
return

'Edelweiss
edel:
bar1$="i1n1h0e r.g h4o6d r.r.o5h0o6c r.o5g h3f r.r.h0e r."
bar2$="e hce f g h8a r.r.h4g r.r."
bar3$="g h4g a b h0o6c r.r.o5h0o6c r.r."
bar4$="o5h4o6d o5g g b a g h0e r.g o6c r.r.o5h3a r.o6c o5h1o6d r.c o5h4b r.r.g r.r."
bar5$="h0e r.g hbo6d r.r.o5h3o6c r.o5g haf r.r.h0e r."
sbfmplay bar1$+bar2$+bar1$+bar3$+bar4$+bar5$+bar3$
return

heyjude:
bar1$="t1i1v6i2v1n5n9p6o6w5r.c r.o5h3a r.r.r.r.a o6c d o5h0g r.r.r.r."
bar2$="g a hbb-r.o6f r.o5h0o6r.f e c o5h3o6d w3c o5b-w5a r.r.r.r."
bar3$="o6c o5hio6d d r.d w3g f r.w5e w3f d r.w5o5h3o6c r.r.r."
bar4$="o5f g a h0o6d c r.r.c o5b-a r.r.h3e f r.r.r."
bar5$="r.r.o5f h3o6f e-d c c o5b-hio6d r.f d r.f r.o5hbb-o6r."
bar6$="o6f r.d c o5b-h0o6c r.r.d c r.o5b-r.h3a g f r.r.r.r."
bar7$="o5f o6c d o5h3o6e-r.e-r.e f o5h0o6g r.g r.r.r.r.r.r."
ba$=bar1$+bar2$+bar3$+bar4$:bb$=bar5$+bar6$
sbfmplay ba$+ba$+bb$+bb$+bar7$+ba$+"r.r.r.r."
return

yesterday:
bar0$="w6p5t3v4i1v5i1v6i1v1n3n8"
bar1$="o4h3g w4f w6f r.r.r.r.h5r.r.a b o5w4c#w6d e f h8e r.d d r.r.r."
bar2$="hir.r.d d h0c o4b-a g h3b-r.a a r.g r.h8f r.a r.h4g r.d r.hif r.h3a a r.r.r.r."
bar3$="t3o4h5a r.r.r.a r.r.r.o5h8d r.e r.hif r.e d h0e r.r."
bar4$="d w4c w6d r.w5r.w6o4h3a r.r.r.r.r.r."
bar5$="d c r.e r.h3f r.c r.o4b-r.a r."
bar6$="h8f r.a r.h4g r.d r.hif r.h3a a r.r.r.r.r.r."
sbfmplay bar0$+bar1$+bar2$+bar1$+bar2$+bar3$+bar4$+bar3$+bar5$+bar1$+bar2$+bar6$
return

lullaby:
bar1$="t3i1p6n0o5b b h4o6d r.r.r.o5b b h4o6d r.r.r."
bar2$="o5b o6d o5h4o6g r.f#r.e r.o5h1o6e r.d r."
bar3$="o5a b h1o6c r.o5a r.a b h1o6c r.r.r.o5a o6c f#e d r.f#r.o5h4o6g r.r.r."
bar4$="o5g g h0o6g r.r.r.e c o5h4o6d r.r.r.o5b g h1o6c r.d r.e r.o5h4o6d r.r.r."
bar5$="o5g g h0o6g r.r.r.e c o5h4o6d r.r.r.o5b g h1o6c r.o5b r.a r.h4g r.r.r.r.r."
sbfmplay bar1$+bar2$+bar3$+bar4$+bar5$
return

ifx:
bar0$="t1n1n8p9"
bar1$="w3b o6c w5o5h4o6v2o4G v1o6d d d d o5h1o6v2o4F#v1o6d c o5b r.o6w2c w5o5h8v2o4F v1o6d d c o5b h0v2o4E v1o5g r.r."
bar2$="g h7v2o4D#v1o6c c o5b g v2o4D v1o5h4d r.r.d v2o4D#v1o5h7e-e-g o6d v2o4F#v1o5h1a r.r."
bar3$="q2v1g v2o4E v1o5h9b r.r.o6e v2o4D#v1o6f#r.r.g v2o4D v1o5h4b b a g q2h0q2a r.r.o6e v2o5F v1h8o6d r.r.o5a v2o5E v1o5h2g#r.r.o6d v2o5C v1o5hco6c r.r.o5g v2o5D v1o5h1f#r.r."
bar4$="q2v1g v2o4E v1o5h9b r.r.o6e v2o4D#v1o6f#r.r.g v2o4D v1o5h4b b a g q2h0q2a r.r.o6e v2o5F v1h8o6d r.r.o5a v2o4E v1o5h2g#r.r.o6d o5hco6q2c r.d r.o5h1o6e r.f#r.o5h4o6g r.r.o5h0o6r.r.r.o5h7o6r.r.r.o5h4o6r.r.r.r.r.r."
sbfmplay bar0$+bar1$+bar2$+bar1$+bar2$+bar3$+bar1$+bar2$+bar1$+bar2$+bar4$
return

endless:
bar0$="t1p7n5n9"
bar1$="h0e r.e r.r.r."
bar2$="e f g h3g r.w3f e w5g f r.h4r.r.d d d r."
bar3$="h0d e r.e r.r.r."
bar4$="h0d g r.e r.r.r."
bar5$="h0g r.f r.e.r.r."
bar6$="c h3a r.r.r.h4r.b o6c d o5h0g r.r.h4g o6d o5hco6d c r.o5b r.o6c o5h3a r.r.r.b o6c o5h4o6d c o5b a h0g r.r.r.r."
bar7$="c o6c o5h3a r.r.r.h4r.b b o6c d r.o5h0o6d e w3e d c w5o5hco6r.r.r.d c o5b h3b a r.r.a o6c o5h4b r.r.o6c o5h8o6c r.r.r.o5h3o6c r.c r.o5a r.h0c r.r.r.r.r.r."
sbfmplay bar0$+bar1$+bar2$+bar3$+bar5$+bar2$+bar4$+bar6$+bar7$
return
