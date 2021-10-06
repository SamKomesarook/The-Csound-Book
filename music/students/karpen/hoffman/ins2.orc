sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

ifreq     =         p4

          instr 2
a3        linseg    0, p3*.3, 7000, p3*.5, 600, p3*.1, 100, p3*.1, 0 
a33       expseg    15, p3*.8, 25, p3*.2, 30
a333      linseg    0, p3*.5, 100, p3*.5, 97
a1        fof       a3, a33, a333+p4, 0, 40, .003, .02, .007, 25, 4, 2, p3, 0, 1

          outs      a1*p5, a1*p6

          endin
