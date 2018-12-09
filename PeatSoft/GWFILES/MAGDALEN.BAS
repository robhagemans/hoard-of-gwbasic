2 CLS:ZA$="From 'The Little Notebook for"
3 ZB$="Anna Magdalena Bach'"
4 ZC$="by J. S. Bach"
6 LOCATE 10,40-LEN(ZA$)/2:PRINT ZA$
7 LOCATE 11,40-LEN(ZB$)/2:PRINT ZB$
8 LOCATE 12,40-LEN(ZC$)/2:PRINT ZC$
10 A$="o3D..o2GABo3CD..o2Gp8Gp8"
20 B$="o3E..CDEF#G..o2Gp8Gp8"
30 C$="o3C..DCo2BAB..o3Co2BAGF#..GABGBA...p4"
35 C1$="o3C..DCo2BAB..o3Co2BAGF#..GABGA....p4"
40 D$="o3C..DCo2BAB..o3Co2BAGA..BAGF#G....p4"
50 E$="mlo3B..GABGA..DEF#DG..EF#GDC#..o2Bo3C#o2Ap8ABo3C#DEF#G..F#..E..F#..o2A..o3C#..D....p4mn"
60 F$="D..o2GF#Gp8o3E..o2GF#Gp8o3D..C..o2B..AGF#GAp8DEF#GABo3C..o2B..A..Bo3Do2G..F#..G....p4"
70 G$="o3A...p8GF#EDp64A...p8GF#EDp64"
80 H$="o2F#GA..G..F#..E..A..F#..D.."
90 I$="o2F#GA..G..F#..E..A..D..p4"
100 J$="o3C#DEp8C#DEp8A..Ep8Ep8E..A..Ep8A..Ep8DC#o2BAB..Ep8"
110 K$="o3E..D#p9o2E..l10o3D....l8C#..o3A..G#..E..D#p9o2E..l10o3D....l8C#..A..G#..ED#C#D#ED#C#D#E.p16mno2G#..A..o3D..C#DE..o2A..D..C#DE..o1A..p4"
120 L$="o2F#GA..G..F#..p2E..A..o3D.."
130 PLAY"mbmnt195l8"
140 PLAY G$:PLAY H$
150 PLAY G$:PLAY I$
160 PLAY G$:PLAY H$
170 PLAY G$:PLAY I$
180 PLAY J$:PLAY K$
190 PLAY G$:PLAY H$
200 PLAY G$:PLAY L$
205 PLAY "p1p1p1"
210 PLAY"mbmnt150l8"
220 PLAY A$:PLAY B$:PLAY C1$
230 PLAY A$:PLAY B$:PLAY D$
250 PLAY A$:PLAY B$:PLAY C$
260 PLAY A$:PLAY B$:PLAY D$
270 PLAY E$:PLAY F$
280 PLAY A$:PLAY B$:PLAY C1$
290 PLAY A$:PLAY B$:MID$(D$,LEN(D$)-1,2)=". ":PLAY D$
