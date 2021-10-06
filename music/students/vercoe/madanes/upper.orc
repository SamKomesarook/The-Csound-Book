sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1
kamp      linen     10000, .1, p3, .2
kfreq     line      p4,p3,(p4+1)
a1        oscil     kamp, cpspch(kfreq), 1
          out       a1
          endin
