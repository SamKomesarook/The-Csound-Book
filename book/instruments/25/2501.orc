sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


          instr     2501    ; HRTFER EXAMPLE ORCHESTRA      
iazstart  =         p4               
iazend    =         p5               
ielstart  =         p6               
ielend    =         p7               
; MOVE THE SOUND HORIZONTALLY FROM IAZSTART TO IAZEND                       
kaz       line      iazstart, p3, iazend                 
; MOVE THE SOUND VERTICALLY FROM IELSTART TO IELEND                     
kel       line      ielstart, p3, ielend                 
asrc      soundin "speech1.aif"                  
aleft, aright       hrtfer  asrc, kaz, kel, "HRTFcompact"                
aleftscale  =       aleft*300           
arightscale =       aright*300               
          outs      aleftscale, arightscale              
          endin
