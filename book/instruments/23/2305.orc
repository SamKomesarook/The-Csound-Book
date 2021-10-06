sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

gadrysig  init      0    ; INITIALIZE GLOBAL VARIABLE



          instr     2303
iwetamt   =         p4
idryamt   =         1-p4
kenv      linseg    19000, .1, 1000, p3-.1, 0
anoise    randi     kenv, sr/2, .5
gadrysig  =         gadrysig + anoise*iwetamt
          outs      anoise*idryamt,anoise*idryamt
          endin

          instr     2305
irevtime  =         p4
adelayline delayr   0.2
amtap1    deltap    0.0430
amtap2    deltap    0.0320
amtap3    deltap    0.1458
amtap4    deltap    0.1423
amtap5    deltap    0.0103
amtap6    deltap    0.0239
amtap7    deltap    0.0446
amtap8    deltap    0.1035
amtap9    deltap    0.1067
amtap10   deltap    0.0087
amtap11   deltap    0.0837
amtap12   deltap    0.1676
          delayw    gadrysig
adiffleft =         amtap1+amtap2+amtap3+amtap4+amtap5+amtap6
adiffright =        amtap7+amtap8+amtap9+amtap10+amtap11+amtap12
arevleft  reverb    adiffleft,irevtime
arevright reverb    adiffright,irevtime
          outs      arevleft/6, arevright/6
gadrysig  =         0
          endin
