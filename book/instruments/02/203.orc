

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
          instr     203
kenv      linseg    0, .05, p4, p3-.1, p4*.8, .05, 0   ; ENVELOPE
asig      oscili    kenv, p5, p6
          out       asig
          endin
