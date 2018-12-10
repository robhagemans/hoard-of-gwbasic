10 ' seqfile.bas   sample sequential file  
20 OPEN "test.dat" FOR OUTPUT AS #1        
30 FOR I = 1 TO 3                          
40 PRINT "Entry";I                         
50 INPUT "Name ";NAM$                      
60 INPUT "City";CITY$                      
70 INPUT "Age";AGE                         
80 INPUT "Phone";PHONE$                    
90 WRITE #1, NAM$                          
100 WRITE #1, CITY$                        
110 WRITE #1, AGE                          
120 WRITE #1, PHONE$                       
130 NEXT                                   
140 CLS                                    
150 CLOSE #1                               
160 OPEN "test.dat" FOR INPUT AS #1        
170 FOR I = 1 TO 3                         
180 INPUT #1,NAM$                          
190 INPUT #1,CITY$                         
200 INPUT #1,AGE                           
210 INPUT #1,PHONE$                        
220 PRINT I;NAM$;" ";CITY$;AGE;PHONE$      
230 NEXT                                   
