sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


gadrysig  init  0

          instr     2307
idryamt   =         1-p4
iwetamt   =         p4
asndfile  soundin   "speech1.aif", 0
gadrysig  =         gadrysig+asndfile*iwetamt
          outs      asndfile*idryamt, asndfile*idryamt
          endin

          instr     2316
iorig     =         .05
irev      =         1.-iorig
igain     =         1.0
ilpgain   =         1.5
icgain    =         .1
ialpgain  =         0.1
ispeed1   =         p4
ispeed2   =         p5
ispeed3   =         p6
ispeed4   =         p7
icf1      =         p8
icf2      =         p9
icf3      =         p10
icf4      =         p11
ifac      =         2
ibw1      =         icf1/ifac
ibw2      =         icf2/ifac
ibw3      =         icf3/ifac
ibw4      =         icf4/ifac
; CYCLIC AMPLITUDE ENVELOPES
aenv1     oscil     igain, ispeed1, 1
aenv2     oscil     igain, ispeed2, 2
aenv3     oscil     igain, ispeed3, 3
aenv4     oscil     igain, ispeed4, 4
; BREAK INTO BANDS
ares1     reson     gadrysig, icf1, ibw1, 1
ares2     reson     gadrysig, icf2, ibw2, 1
ares3     reson     gadrysig, icf3, ibw3, 1
ares4     reson     gadrysig, icf4, ibw4, 1
; SUM THE ENVELOPED BANDS
asum      =         (ares1*aenv1)+(ares2*aenv2)+(ares3*aenv3)+(ares4*aenv4)
; LOWPASS AND COMB SEQUENCE
alp       tone      asum, 1000
adright   delay     alp, .178
adleft    delay     alp, .215
asumr     =         asum+(adright*ilpgain)
asuml     =         asum+(adleft*ilpgain)
acr1      comb      asumr, 2, .063
acr2      comb      acr1+asumr,. 5, .026
acl1      comb      asuml, 2, .059
acl2      comb      acl1+asuml, .5, .031
acsumr    =         asumr+(acr2*icgain)
acsuml    =         asuml+(acl2*icgain)
; ALLPASS COMB SEQUENCE
alpo      alpass    asum, 3, 085
alpol     comb      alpo, 2.8, .526
alpor     comb      alpo, 2.8, .746
alol      tone      alpol, 500
alor      tone      alpor, 500
alold     delay     alol, .095
alord     delay     alor, .11
; SUM REVERBERATION COMPONENTS
arevl     =         (alpol*ialpgain)+acsuml+alold
arevr     =         (alpor*ialpgain)+acsumr+alord
aorig     =         gadrysig*iorig
; MIX BACK ORIGINAL SIGNAL
          outs      (arevl*irev)+aorig,(arevr*irev)+aorig
gadrysig  =         0
          endin
