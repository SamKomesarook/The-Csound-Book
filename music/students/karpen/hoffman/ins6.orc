sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 6
a3        linseg    0, p3*.3, 900, p3*.6, 200
a33       expseg    701, p3*.8, 705, p3*.2, 700
a333      expseg    760, p3*.45, 780, p3*.55, 860
kenv      expseg    10, p3*.3, 15, p3*.4, 20, p3*.2, 17, p3*.05, 10, p3*.05, .005

k1        linseg    2.7, p3*.2, 8.8, p3*.2, 7.9, p3*.3, 4.4, p3*.2, 1.2, p3*.1, 1.4

a1        fof       a3, a33, a333, k1, 25, .009, .055, .01, 250, 2, 2, p3, 0, 1

          outs      a1*.3*kenv, a1*.3*kenv

          endin
