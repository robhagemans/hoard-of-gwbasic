10 'julian.bas                                                 
20 DIM DAYS(12)                                                
30 DATA 31,28,31, 30,31,30, 31,31,30, 31,30,31                 
40 FOR I = 1 TO 12 : READ DAYS(I) : NEXT                       
50 INPUT "Start month";M                                       
60 INPUT "Start day";D                                         
70 GOSUB 200                                                   
80 E1 = ELAPSED                                                
90 INPUT "End month";M                                         
100 INPUT "End day";D                                          
110 GOSUB 200                                                  
120 DATE.DIF = ELAPSED - E1                                    
130 PRINT                                                      
140 PRINT "difference =";DATE.DIF                              
150 END                                                        
200 '===================== calc elapsed time in days           
210 ELAPSED = D                                                
220 FOR I = 1 TO M - 1                                         
230 ELAPSED = ELAPSED + DAYS(I)                                
240 NEXT                                                       
250 PRINT ELAPSED;"days elapsed. ";365-ELAPSED; "days to go"   
260 RETURN                                                     

