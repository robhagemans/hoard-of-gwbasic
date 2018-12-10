10  ' totals.bas                                   
20  ' do cross totals on an array                  
30  DIM X(5,5)                                     
40  X(0,0) = 0                   ' grand totals    
50  FOR I = 1 TO 5                                 
60  X(I,0) = 0                                     
70     FOR J = 1 TO 5                              
80     X(I,J) = RND(1)*10                          
90     X(I,0) = X(I,0) + X(I,J)  ' line totals     
100    X(0,J) = X(0,J) + X(I,J)  ' column totals   
110    X(0,0) = X(0,0) + X(I,J)  ' grand total     
120    NEXT                                        
130 NEXT                                           
140 FOR I = 5 TO 0 STEP -1                         
150    IF I = 0 THEN PRINT "  "   ' extra space    
160    FOR J = 5 TO 0 STEP - 1                     
170    IF J = 0 THEN PRINT "  ";  ' extra row      
180    PRINT USING " ###.## ";X(I,J);              
190    NEXT                                        
200    PRINT                                       
210 NEXT                                           

