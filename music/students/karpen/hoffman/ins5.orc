sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

ifreq     =         p4

          instr 5
a3        linseg    0, p3*.3, 7000, p3*.7, 600 
a33       expseg    661, p3*.8, 665, p3*.2, 660
a333      linseg    20, p3*.5, 820, p3*.5, 20

k1        linseg    10, p3*.5, 8, p3*.5, 0

a1        fof       a3, a33, a333, k1, 40, .003, .02, .007, 25, 4, 2, p3, 0, 1

          outs      a1*.5, a1*.5

          endin
