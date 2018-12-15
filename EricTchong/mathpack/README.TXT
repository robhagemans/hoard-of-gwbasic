Hello Roy;

Although unfamiliar with Applesoft Basic, I managed to convert these programs
to GW-BASIC. A close look at the printouts of these mathematical programs and
due to well documented listings it was not that difficult. As today LPRINT
won't work without special programs, I included the option to save all results
to ASCII diskfiles, which you can edit and print with your wordprocessor.

59!=                                   1
                                      386
                                     83118
                                    5456898
                                   357379390
                                  19720389406
                                 3459028767726
                                874325408212949
                               40160000000000000

The first program factoril.bas will display factorials in a triangle.
Examples:  7 12 18 32 59 81 105 132 228 265 284 304 367 389 435 483 508
           697 726 944
A factorial can only be displayed in a triangle, if the total digits of the
factorial a perfect square is. 944!= 2401 digits. Square root of 2401 = 49. So
944! will fit in a triangle. I have limited factoril.bas though to 508!= 1156
digits, as factorial 508 will fit nice in a 25x80 characters DOS screen. But
you can edit the bas listing and see for yourself that the factorials 697, 726
and 977 are real triangles.

With the second program factoria.bas you can explore the above examples and see
the total digits of the factorial. You can then take the square root of these 
factorials and find out that they will fit in a triangle. In factoria.bas you
may generate factorials from 1 to 508. Compiled with PowerBasic it just take a
few seconds to get 508!= .

The third program factsrch.bas will search all factorials from 1 to 1000 which
it's total digits a perfect square is. It is with this program that I found the
above examples 7 12 18 .. 944. Anyone who may improve the speed of this program
is cordially invited to do so. Please send me your improved program.

Finally it was an inmense pleasure to convert the last program fracdeci.bas
for this first New Year 2006 issue. A fraction to decimals converter which also
will display the total decimals generated, when the decimals are >6. Here are
some examples to wet your appetite.
1/3 = .(3)      22/5 =  4.4      1/7 = .(142857)      3/8 = .375
45/56 = .803(571428)
 9 decimals
11/59 = .(1864406779661016949152542372881355932203389830508474576271)
 58 decimals
As always included are source, txt, dat, and doc files to study these 4
programs closely. Enjoy and may our world benefit from these GW-BASIC programs.
Bye
Eric