sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

gklfo     init      0                    
gkpch     init      0                    
gkad      init      0                    
                            
          instr     1807    ; LFO               
gklfo     oscil      p4, p5, 1                   
          endin                          
                            
          instr     1808    ; ADSR              
gkad      linseg    0, p3*p4, 1, p3*p5, p6, p3*p7, 0                     
gkpch     =         cpspch(p8)                   
          endin                          
                            
          instr     1809    ;VCO                 
iamp      =         p4*0.333                     
kpch      =         gkpch*(1+0.04*gklfo)                     
avco1     oscil     iamp, kpch*(1-p5), 2         ; p4=%DETUNE                
avco2     oscil     iamp, kpch, 2                    
avco3     oscil     iamp, kpch*(1+p5), 2                     
avcos     =         avco1+avco2+avco3                    
asig      =         gkad*avcos                   
          out       asig                
          endin
