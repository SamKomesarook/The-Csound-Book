sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



gadrysig  init      0    ; INITIALIZE GLOBAL VARIABLE

          instr     2307
idryamt   =         1-p4
iwetamt   =         p4
asndfile  soundin   "speech1.aif", 0
gadrysig  =         gadrysig+asndfile*iwetamt
          outs      asndfile*idryamt, asndfile*idryamt
          endin

          instr     2309
irevtime  =         p4
irolloff  =         p5
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
alfo1     oscili    .02, .342, 1
alfo2     oscili    .02, .337, 1, .33
alfo1     =         alfo1+0.025
alfo2     =         alfo2+0.025
achn1dll  delayr    .05
amvleft   deltapi   alfo1
          delayw    arevleft
achn2dll  delayr    .05
amvright  deltapi   alfo2
          delayw    arevright
amvleft   tone      amvleft, irolloff
amvright  tone      amvright, irolloff
          outs      amvleft/6, amvright/6
gadrysig  =         0
          endin
