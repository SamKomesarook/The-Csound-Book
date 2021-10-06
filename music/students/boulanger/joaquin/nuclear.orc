
;    NUCLEAR ENERGY - OUR "MISUNDERSTOOD" FRIEND     (MAY 6, 1998)
;
;    COMPOSED BY  JACOB JOAQUIN
;    e-mail jake.ke@ix.netcom.com





sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

gidrum    =         .4
ga100     init      0
ga101     init      0
ga102     init      0
ga103     init      0


          instr 1
idur      =         p3
ipch      =         p4
iamp      =         p5
ifn       =         p6
ipat      =         p7
iacc      =         p8
ienv      =         p9
ifilter   =         p10
ipan      =         p11
iwet      =         p12

it        =         16 / idur

kosc      oscil1    0, 1, idur, ipat
kosc      =         cpspch((ipch-2) + .24 + (kosc * .01))

kosc2     oscil1    0, 1, idur, iacc
kosc2     =         iamp * (kosc2)

kosc3     oscil     1, it, ienv

aosc      oscil     kosc2, kosc, ifn, -1
aosc2     oscil     kosc2, kosc * .004, ifn, -1
aosc3     oscil     kosc2, kosc * .996, ifn, -1

asig      =         (aosc+aosc2+aosc3)*.333*kosc3

kosc5     oscil     .9, it, ifilter
kosc5     =         kosc5 + .1

asig      butterlp  asig * kosc5,  5000

knin      oscil1    0, 1, idur, ipan
aleft     =         asig * (sqrt(1 - knin))
aright    =         asig * (sqrt(knin))
          outs      aleft, aright
ga100     =         (ga100 + asig) * iwet
          endin


          instr 2
idur      =         p3
ipch      =         cpspch(p4)
iamp      =         p5
ipan      =         p6

kenv      linseg    1, .01, iamp, idur - .01 , 1
aosc      oscil     kenv, 440, 4

kenv      expon     2, idur, .01
aosc2     butterbp  aosc, ipch, ipch * kenv
aosc2     butterbp  aosc2, ipch, ipch * kenv

aosc      balance   aosc2, aosc
aosc      =         aosc * .5

aleft     =         aosc * (sqrt(1-ipan))
aright    =         aosc * (sqrt(ipan))
          outs      aleft, aright
ga101     =         ga101 + aosc
          endin


          instr 3
idur      =         p3
ipch      =         cpspch(p4)
iamp      =         p5
ipan      =         p6

kenv      linseg    0, .01, iamp, idur - .02, iamp * .5, .01, 0

kenv2     expon     19, idur, 1
kenv2     =         kenv2 - 1

afm       foscil    kenv, ipch, 1, .5, kenv2, 1

aleft     =         afm * (sqrt(1-ipan))
aright    =         afm * (sqrt(ipan))
          outs      aleft, aright
ga102     =         ga102 + afm
          endin


          instr 4
idur      =         p3
ipch      =         cpspch(p4)
ipch2     =         cpspch(p5)
iamp      =         p6
iamp2     =         p7
ires      =         p8

ifn       =         4

kenv2     expon     ipch, idur, ipch2
kenv3     line      iamp, idur, iamp2

aosc      oscil     kenv3, 440, ifn
abp       butterbp  aosc, kenv2, kenv2 * ires
abp       butterbp  abp, kenv2, kenv2 * ires

aosc      balance   abp, aosc

kenv      linseg    0, idur * .125, 1, idur * .875, 0
aosc      =         aosc * kenv

          outs      aosc, aosc
          endin


          instr 5
idur      =         p3
ipch      =         cpspch(p4)
ipch2     =         cpspch(p5)
iamp      =         p6 + 1
iamp2     =         p7 + 1
iport     =         p8
     
kenv      expseg    ipch2, iport, ipch, idur - iport, ipch
kenv2     expseg    iamp, idur * .25, iamp2, idur * .75, iamp2
kenv2     =         kenv2 - 1

kosc      oscil     .5, 6, 1, -1
kosc      =         kosc + .5

afm       foscili   kenv2, kenv, 1, .5, 2 + kosc, 1, -1
afm2      foscili   kenv2, kenv * .004, 1, .5, 2 + kosc, 1, -1
afm3      foscili   kenv2, kenv * .996, 1, .5, 2 + kosc, 1, -1

amix      =         (afm + afm2 + afm3) * .333
ga103     =         ga103 + amix
          endin


          instr 6
isnd      =         p4
ilvl      =         p5

asig      soundin   isnd
asig      =         asig * ilvl * gidrum
          outs      asig, asig
          endin


          instr  100
idur      =         p3
iwet      =         p4
idecay1   =         p5
idecay2   =         p6

asig      =         ga100 * iwet

aleft     reverb2   asig, idecay1, .5
aright    reverb    asig, idecay2

          outs      aleft, aright
ga100     =         0
          endin


          instr  101
idur      =         p3
iwet      =         p4
idecay1   =         p5
idecay2   =         p6
idelay    =         p7

asig      =         ga101 * iwet

aleft     reverb2   asig, idecay1, .5
aright    reverb    asig, idecay2

aright    delay     aright, idelay

          outs      aleft, aright
ga101     =         0
          endin


          instr  102
idur      =         p3
iwet      =         p4
idecay    =         p5
idecay2   =         p6
idelay    =         p7
idelay2   =         p8

asig      =         ga102 * iwet

aleft     reverb    asig, idecay
aright    reverb2   asig, idecay2, .5

aleft     delay     aleft, idelay
aright    delay     aright, idelay2

          outs      aleft, aright
ga102     =         0
          endin


          instr 103
asig      =         ga103
asig2     delay     asig, .05

          outs      asig, asig2
ga103     =         0
          endin
