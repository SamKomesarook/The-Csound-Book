sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

        instr 304
iamp    =       p4
ifrq    =       cpspch(p5)
ivibfrq =       p6
ivibamt =       p7
kv      linseg  0, 0.5, 0, 1, 1, p3-0.5, 1
a1      fmbell  iamp, ifrq, 1, 1.2, kv*ivibamt, ivibfrq, 1,1,1,1,1
        out     a1
        endin       
            
        instr 305
iamp    =       p4
ifrq    =       cpspch(p5)
ivibfrq =       p6
ivibamt =       p7
kv      linseg  0, 0.5, 0, 1, 1, p3-0.5, 1
a1      fmrhode iamp, ifrq, 1, 1.2, kv*ivibamt, ivibfrq, 1,1,1,1,1
        out     a1
        endin       
