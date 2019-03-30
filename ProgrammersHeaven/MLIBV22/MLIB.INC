DEFINT A-Z          '*** Mouse routine include file. ***

'Mouse routines in assembly.
DECLARE SUB InitPointer (MouseExist%)                           
DECLARE SUB ShowPointer                                         
DECLARE SUB HidePointer                                          
DECLARE SUB ChangePointer (NewShape$, HotX%, HotY%)             
DECLARE SUB SetPointer (X%, Y%)                                 

DECLARE SUB SetHLimitM (X%, Y%)                                 
DECLARE SUB SetVLimitM (X%, Y%)                                 
DECLARE SUB SetBoundM (x1%, y1%, x2%, y2%)                      

DECLARE SUB GetButtonM (ButtonNum%, X%, Y%)                     
DECLARE SUB GetPressM (ButtonNum%, Stat%, Count%, X%, Y%)       
DECLARE SUB GetReleaseM (ButnNum%, Stat%, Count%, X%, Y%)       

DECLARE SUB GetSpeedM (H%, V%, D%)                              
DECLARE SUB SetSpeedM (H%, V%, D%)                              
DECLARE SUB GetMotionM (X%, Y%)                                 

DECLARE FUNCTION GetSizeM%                                      
DECLARE SUB SaveStateM (SaveBuff$, ErrNum%)                     
DECLARE SUB RestoreStateM (SaveBuff$, ErrNum%)                  
DECLARE FUNCTION ShowPtrM% (Buffer$)                            

DECLARE SUB DClicM (ButN%, XPos%, YPos%, Dble%)                 
DECLARE SUB DClicRate (Rate%)                                   
DECLARE SUB DClicBut (DCBut%)                                   
DECLARE SUB DClicOn                                             
DECLARE SUB DClicOff                                            
                                                                
DECLARE FUNCTION InWinM (BYVAL x1%, BYVAL y1%, BYVAL x2%, BYVAL y2%)

DECLARE SUB ARROW0                                              
DECLARE SUB HANDV0                                              
DECLARE SUB HOURGLASS0                                          
DECLARE SUB PEN0                                                
DECLARE SUB MAGNIFYGLASS0                                       
DECLARE SUB PAINTCUP0                                           
DECLARE SUB MOUSE0                                              
DECLARE SUB WATCH0                                              
DECLARE SUB ARROW1                                              

TYPE MOUSEtype              ': Each record is 80 bytes.
      DLT    AS INTEGER     ': 2  bytes for editor use.
      HTX    AS INTEGER     ': 2  bytes for hotspot  X.
      HTY    AS INTEGER     ': 2  bytes for hotspot  Y.
      FRM    AS STRING * 10 ' bytes for solid or transparent format.
      DAT    AS STRING * 64 ' bytes for shape data.
END TYPE

