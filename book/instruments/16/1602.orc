sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



          instr     1602
k1        gauss     p5
k2        gauss     p6
a1        oscili    p4/2, 333, 1
a2        oscili    p4/2, 333+k1, 1
a3        oscili    p4/2, 333+k2, 1
          outs      a1+a2, a1+a3
          endin
