sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1801      
kfr       linseg    p5, p3*.1, p6, p3*.9, p6           ;p5 = FREQ OF LAST NOTE
asig      oscil     p4, kfr, 1                         ;p6 = FREQ FOR THIS NOTE
          out       asig 
          endin
