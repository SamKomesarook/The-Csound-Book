;STUDY FOR COMPUTER
;©1997 JOHN ENDICOTT

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
                    
garvbsig  init      0


          instr 1
icm       =         p8                            ; C:M RATIO
imod      =         p9                            ; MOD INDEX
ifm       =         p5*icm                        ; MOD FREQ
idfm      =         imod*ifm                      ; DEPTH
                                                  
; ADDITIVE FREQUENCY MODULATOR
     
     
kran      randi     1,.25
amod1     oscil     idfm*kran,p16*ifm,p6
amod2     oscil     idfm,p17*ifm,p6
     
aoutm     =         amod1+amod2
     
; FM CARRIER

kenv      linen     p13*p4,p14*p3,p3,p15*p3
asig      oscil     kenv,p5+aoutm,12
     
     
aout=asig
     
     
; DELAY LINE

adel      delayr    .1*p3
kphs1     phasor    .01
adel1     deltap    kphs1
kphs2     phasor    .01
adel2     deltap    kphs2
kphs3     phasor    .01
adel3     deltap    kphs3
kphs4     phasor    .02
adel4     deltap    kphs4
kphs5     phasor    .02
adel5     deltap    kphs5
kphs6     phasor    .02
adel6     deltap    kphs6
kphs7     phasor    .03
adel7     deltap    kphs7
kphs8     phasor    .03
adel8     deltap    kphs8
kphs9     phasor    .03
adel9     deltap    kphs9
     
     
     
     
delayw    aout
aout1     =         adel1+adel2+adel3+adel4+adel5+adel6+adel7+adel8+adel9 
     
;FILTER BANK

afil1     butterlp  aout1,2000
;afil2     butterbr  afil1,50,10
     
     
     
;NORMALIZE AND STEREO OUTPUT

abal      balance   afil1,asig
     
kpan      line      p7,p3,abs(1-p7)

asigl,asigr,adum1,adum2  pan  abal,kpan,1,2,1,0
     
outs      asigl,asigr
     
;GLOBAL REVERB PATCH

garvbsig  =         aout*p10
          endin
          


instr     2    

kenv      linen     p4,p8*p3,p3,p9*p3
klin      line      p5,p3,p10
     
asig      oscil     kenv,klin,p6
     
;FILTER BANKS
     
acom1     comb      asig,p3,1/50
acmb1     comb      asig,p3,1/60
acob1     comb      asig,p3,1/70
aomb1     comb      asig,p3,1/80
amoc1     comb      asig,p3,1/90
abmc1     comb      asig,p3,1/100
aboc1     comb      asig,p3,1/110
abmo1     comb      asig,p3,1/120
abob1     comb      asig,p3,1/130
aboo1     comb      asig,p3,1/140
aooo1     comb      asig,p3,1/150
accc1     comb      asig,p3,1/160
abbb1     comb      asig,p3,1/170
ammm1     comb      asig,p3,1/180
aoob1     comb      asig,p3,1/190
aoutc1    =         acom1+acmb1+acob1+aomb1+amoc1+abmc1+aboc1+abmo1+abob1+aboo1+aooo1+accc1+abbb1+ammm1+aoob1
     
     
acom2     comb      asig,p3,1/200
acmb2     comb      asig,p3,1/210
acob2     comb      asig,p3,1/220
aomb2     comb      asig,p3,1/230
amoc2     comb      asig,p3,1/240
abmc2     comb      asig,p3,1/250
aboc2     comb      asig,p3,1/260
abmo2     comb      asig,p3,1/270
abob2     comb      asig,p3,1/280
aboo2     comb      asig,p3,1/290
aooo2     comb      asig,p3,1/300
accc2     comb      asig,p3,1/310
abbb2     comb      asig,p3,1/320
ammm2     comb      asig,p3,1/330
aoob2     comb      asig,p3,1/340
aoutc2    =         acom2+acmb2+acob2+aomb2+amoc2+abmc2+aboc2+abmo2+abob2+aboo2+aooo2+accc2+abbb2+ammm2+aoob2
     
     
     
acom3     comb      asig,p3,1/350
acmb3     comb      asig,p3,1/360
acob3     comb      asig,p3,1/370
aomb3     comb      asig,p3,1/380
amoc3     comb      asig,p3,1/390
abmc3     comb      asig,p3,1/400
aboc3     comb      asig,p3,1/410
abmo3     comb      asig,p3,1/420
abob3     comb      asig,p3,1/430
aboo3     comb      asig,p3,1/440
aooo3     comb      asig,p3,1/450
accc3     comb      asig,p3,1/460
abbb3     comb      asig,p3,1/470
ammm3     comb      asig,p3,1/480
aoob3     comb      asig,p3,1/490
aoutc3    =         acom3+acmb3+acob3+aomb3+amoc3+abmc3+aboc3+abmo3+abob3+aboo3+aooo3+accc3+abbb3+ammm3+aoob3

          
     
acom4     comb      asig,p3,1/500
acmb4     comb      asig,p3,1/510
acob4     comb      asig,p3,1/520
aomb4     comb      asig,p3,1/530
amoc4     comb      asig,p3,1/540
abmc4     comb      asig,p3,1/550
aboc4     comb      asig,p3,1/560
abmo4     comb      asig,p3,1/570
abob4     comb      asig,p3,1/580
aboo4     comb      asig,p3,1/590
aooo4     comb      asig,p3,1/600
accc4     comb      asig,p3,1/610
abbb4     comb      asig,p3,1/620
ammm4     comb      asig,p3,1/630
aoob4     comb      asig,p3,1/640
aoutc4    =         acom4+acmb4+acob4+aomb4+amoc4+abmc4+aboc4+abmo4+abob4+aboo4+aooo4+accc4+abbb4+ammm4+aoob4
     
          
     
acom5     comb      asig,p3,1/650
acmb5     comb      asig,p3,1/660
acob5     comb      asig,p3,1/670
aomb5     comb      asig,p3,1/680
amoc5     comb      asig,p3,1/690
abmc5     comb      asig,p3,1/700
aboc5     comb      asig,p3,1/710
abmo5     comb      asig,p3,1/720
abob5     comb      asig,p3,1/730
aboo5     comb      asig,p3,1/740
aooo5     comb      asig,p3,1/750
accc5     comb      asig,p3,1/760
abbb5     comb      asig,p3,1/770
ammm5     comb      asig,p3,1/780
aoob5     comb      asig,p3,1/790
aoutc5    =         acom5+acmb5+acob5+aomb5+amoc5+abmc5+aboc5+abmo5+abob5+aboo5+aooo5+accc5+abbb5+ammm5+aoob5
     
     
acom6     comb      asig,p3,1/800
acmb6     comb      asig,p3,1/810
acob6     comb      asig,p3,1/820
aomb6     comb      asig,p3,1/830
amoc6     comb      asig,p3,1/840
abmc6     comb      asig,p3,1/850
aboc6     comb      asig,p3,1/860
abmo6     comb      asig,p3,1/870
abob6     comb      asig,p3,1/880
aboo6     comb      asig,p3,1/890
aooo6     comb      asig,p3,1/900
accc6     comb      asig,p3,1/910
abbb6     comb      asig,p3,1/920
ammm6     comb      asig,p3,1/930
aoob6     comb      asig,p3,1/940
aoutc6    =         acom6+acmb6+acob6+aomb6+amoc6+abmc6+aboc6+abmo6+abob6+aboo6+aooo6+accc6+abbb6+ammm6+aoob6
     
     
acom7     comb      asig,p3,1/950
acmb7     comb      asig,p3,1/960
acob7     comb      asig,p3,1/970
aomb7     comb      asig,p3,1/980
amoc7     comb      asig,p3,1/990
abmc7     comb      asig,p3,1/1000
aboc7     comb      asig,p3,1/1110
abmo7     comb      asig,p3,1/1120
abob7     comb      asig,p3,1/1130
aboo7     comb      asig,p3,1/1140
aooo7     comb      asig,p3,1/1150
accc7     comb      asig,p3,1/1160
abbb7     comb      asig,p3,1/1170
ammm7     comb      asig,p3,1/1180
aoob7     comb      asig,p3,1/1190
aoutc7    =         acom7+acmb7+acob7+aomb7+amoc7+abmc7+aboc7+abmo7+abob7+aboo7+aooo7+accc7+abbb7+ammm1+aoob7
     
     
acom8     comb      asig,p3,1/1200
acmb8     comb      asig,p3,1/1210
acob8     comb      asig,p3,1/1220
aomb8     comb      asig,p3,1/1230
amoc8     comb      asig,p3,1/1240
abmc8     comb      asig,p3,1/1250
aboc8     comb      asig,p3,1/1260
abmo8     comb      asig,p3,1/1270
abob8     comb      asig,p3,1/1280
aboo8     comb      asig,p3,1/1290
aooo8     comb      asig,p3,1/1300
accc8     comb      asig,p3,1/1310
abbb8     comb      asig,p3,1/1320
ammm8     comb      asig,p3,1/1330
aoob8     comb      asig,p3,1/1340
aoutc8    =         acom8+acmb8+acob8+aomb8+amoc8+abmc8+aboc8+abmo8+abob8+aboo8+aooo8+accc8+abbb8+ammm8+aoob8
     
     
acom9     comb      asig,p3,1/1350
acmb9     comb      asig,p3,1/1360
acob9     comb      asig,p3,1/1370
aomb9     comb      asig,p3,1/1380
amoc9     comb      asig,p3,1/1390
abmc9     comb      asig,p3,1/1400
aboc9     comb      asig,p3,1/1410
abmo9     comb      asig,p3,1/1420
abob9     comb      asig,p3,1/1430
aboo9     comb      asig,p3,1/1440
aooo9     comb      asig,p3,1/1450
accc9     comb      asig,p3,1/1460
abbb9     comb      asig,p3,1/1470
ammm9     comb      asig,p3,1/1480
aoob9     comb      asig,p3,1/1490
aoutc9    =         acom9+acmb9+acob9+aomb9+amoc9+abmc9+aboc9+abmo9+abob9+aboo9+aooo9+accc9+abbb9+ammm9+aoob9
     
     
acom10    comb      asig,p3,1/1500
acmb10    comb      asig,p3,1/1510
acob10    comb      asig,p3,1/1520
aomb10    comb      asig,p3,1/1530
amoc10    comb      asig,p3,1/1540
abmc10    comb      asig,p3,1/1550
aboc10    comb      asig,p3,1/1560
abmo10    comb      asig,p3,1/1570
abob10    comb      asig,p3,1/1580
aboo10    comb      asig,p3,1/1590
aooo10    comb      asig,p3,1/1600
accc10    comb      asig,p3,1/1610
abbb10    comb      asig,p3,1/1620
ammm10    comb      asig,p3,1/1630
aoob10    comb      asig,p3,1/1640
aoutc10   =         acom10+acmb10+acob10+aomb10+amoc10+abmc10+aboc10+abmo10+abob10+aboo10+aooo10+accc10+abbb10+ammm10+aoob10
     
aout      =         aoutc1+aoutc2+aoutc3+aoutc4+aoutc5+aoutc6+aoutc7+aoutc8+aoutc9+aoutc10
afilx     butterlp  aout,p11
     
;STEREO OUTPUT

abal      balance   afilx,asig

kpan      line      p7,p3,abs(1-p7)

asigl,asigr,adum1,adum2  pan  abal,kpan,1,2,1,0

outs      asigl,asigr

garvbsig  =         abal*1
          endin
     

instr     3
     
;CARRIERS

kllin     linseg    0,.5*p3,10,.5*p3,0
     
     
atble     oscil     kllin,10,p6
     
     
     
ksig1     linen     p4,p9*p3,p3,p10*p3
asgl1     oscil     ksig1,(p5/1*p11)+atble,p6

ksig2     linen     p4,p9*p3,p3,p10*p3
asgl2     oscil     ksig2,(p5/1.11*p11)+atble,p6


ksig3     linen     p4,p9*p3,p3,p10*p3
asgl3     oscil     .01*ksig3,(p5/1.12*p11)+atble,p6

ksig4     linen     p4,p9*p3,p3,p10*p3
asgl4     oscil     ksig4,(p5/1.13*p11)+atble,p6
     
     
ksig5     linen     p4,p9*p3,p3,p10*p3
asgl5     oscil     .01*ksig5,(p5/1.14*p11)+atble,p6

ksig6     linen     p4,p9*p3,p3,p10*p3
asgl6     oscil     ksig6,(p5/1.15*p11)+atble,p6


ksig7     linen     p4,p9*p3,p3,p10*p3
asgl7     oscil     .01*ksig7,(p5/1.16*p11)+atble,p6

ksig8     linen     p4,p9*p3,p3,p10*p3
asgl8     oscil     ksig8,(p5/1.17*p11)+atble,p6


ksig9     linen     p4,p9*p3,p3,p10*p3
asgl9     oscil     .01*ksig9,(p5/1.18*p11)+atble,p6

ksig10    linen     p4,p9*p3,p3,p10*p3
asgl10    oscil     ksig10,(p5/1.19*p11)+atble,p6
     
aout      =         asgl1+asgl2+asgl3+asgl4+asgl5+asgl6+asgl7+asgl8+asgl9+asgl10
     
afil      tone      aout,p12
     
abal      balance   afil,asgl1
     
     
kpan      line      p7,p3,abs(1-p7)

asigl,asigr,adum1,adum2   pan   abal,kpan,1,2,1,0
     
          outs      asigl,asigr

;GLOBAL REVERB PATCH

garvbsig  =         aout*p8
          endin


instr 99

;GLOBAL REVERB INSTRUMENT

arvb      reverb    garvbsig,p4
          outs      arvb,arvb
gareverb  =         0
          endin
