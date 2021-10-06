

;    ELECTRONIC BUBBLES  (SPRING 1998)
;
;    COMPOSED BY  JACOB JOAQUIN
;    E-MAIL jake.ke@ix.netcom.com




sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

ga100     init      0


          instr 1
idur      =         p3
igain     =         p4
ipan      =         (p5 + 100)/200
ibw       =         p6
ibubble   =         p7
iseed     =         p8
iattack   =         p9
idecay    =         p10

ires1     =         925
ires2     =         950
ires3     =         975

kenv1     line      0, idur, 10000

arand1    randh     10000, ibubble, iseed
aosc1     oscil     10000, arand1, 1
kgain     linseg    .1, iattack, igain, idur-(iattack+idecay), igain, idecay, .1

asig1     reson     aosc1, ires1, ibw
asig2     reson     aosc1, ires2, ibw
asig3     reson     aosc1, ires3, ibw

again1    gain      asig1, kgain
again2    gain      asig2, kgain
again3    gain      asig3, kgain
     
amix      =         again1+again2+again3
alpf1     butterlp  amix, 5000 
alpf1     butterlp  amix, 5000

aleft     =         alpf1 * (1-ipan)
aright    =         alpf1 * ipan
          outs      aleft, aright
ga100     =         ga100 + alpf1
          endin


          instr 2
idur      =         p3
iamp      =         p4
iattack   =         p5
idecay    =         idur - iattack

kenv1     expseg    .1, iattack, iamp, idecay, .1
aosc1     oscil     kenv1, 440, 2

kenv2     line      500, idur, 1250
kenv3     expon     .5, idur, .05
ares      reson     aosc1, kenv2, kenv2 * kenv3, 1
ares      reson     ares, kenv2, kenv2 * .5, 1

ares      balance   ares, aosc1

          outs      ares, ares
          endin


          instr  100
idur      =         p3

asig      =         ga100

kfn       oscil1i   0, 1, idur, 100
kfn       =         kfn * .1

kfn2      oscil1i   0, 1, idur, 101
kfn3      oscil1i   0, 1, idur, 102

arev      reverb    asig * kfn, kfn2
arev2     reverb2   asig * kfn, kfn3, .5

          outs      arev, arev2
ga100     =         100
          endin
