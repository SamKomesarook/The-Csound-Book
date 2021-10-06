sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

ifreq     =         p4

          instr 1
a3        linseg    0, p3*.3, 2000, p3*.2, 2500, p3*.5, 6000 
a33       expseg    668, p3*.8, 672, p3*.2, 667
a333      linseg    20, p3*.2, p6, p3*.8, 20

a1        fof       a3*p7, a33, a333, 0, 0, .1, .12, .009, 100, 4, 2, p3, 0, 1

          outs      a1*.05, a1*.05

          endin
