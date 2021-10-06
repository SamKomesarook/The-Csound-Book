sr             =         44100                                             ; AUDIO SAMPLE RATE
kr             =         4410                                              ; CONTROLLOR RATE
ksmps          =         10                                                ; AUDIO SAMPLE RATE/CONTROLLOR RATE
nchnls         =         2                                                 ; THE NUMBER OF CHANNELS

garvbsig       init      0                                                 ; A GLOBAL "A" VARIABLE  ;(IMPORTANT NOTICE)



instr          1                                                           ;POLY RHYTHM

;pitch:                  pch => cps
iPitch1        =         cpspch(p4)
iPitch2        =         cpspch(p4)*2
iPitch3        =         cpspch(p4)*3
iPitch4        =         cpspch(p4)*4
iPitch5        =         cpspch(p4)*5
iPitch6        =         cpspch(p4)*6
iPitch7        =         cpspch(p4)*7
iPitch8        =         cpspch(p4)*8
iPitch9        =         cpspch(p4)*9
iPitch11       =         cpspch(p4)*11
iPitch13       =         cpspch(p4)*13
iPitch15       =         cpspch(p4)*15

;OCTAVE:       CPS => OCT
ioct1          =         octcps(iPitch1)
ioct2          =         octcps(iPitch2)
ioct3          =         octcps(iPitch3)
ioct4          =         octcps(iPitch4)
ioct5          =         octcps(iPitch5)
ioct6          =         octcps(iPitch6)
ioct7          =         octcps(iPitch7)
ioct8          =         octcps(iPitch8)
ioct9          =         octcps(iPitch9)
ioct11         =         octcps(iPitch11)
ioct13         =         octcps(iPitch13)
ioct15         =         octcps(iPitch15)

;DECIBEL
idB            =         ampdb(p5)
irvbgain       =         p6                                                ;REVERB GAIN             ;(IMPORTANT NOTICE)

;1-NOTE PER SECOND (F.M. 1:1 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger1      oscil     1,                       1,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato1      oscil     0.0417*kTrigger1,        8,                                 1              ;VIBRATO  DEPTH & RATE
knote1         oscil     idB,                     1,                                 73             ;LINEAR TRANSFER FUNCTION
kBalance1      oscil     1,                       1/2,                               77             ;PANNING TRANSFER FUNCTION
aModul1        oscil     idB*kTrigger1,           cpsoct(ioct1+kVibrato1),           1              ;RATIO-1 MODULATOR
aCarrier1      oscil     knote1,                  cpsoct(ioct1+kVibrato1)+aModul1,   1              ;RATIO-1 CARRIER
audio1L        =         aCarrier1*kBalance1
audio1R        =         aCarrier1*(1-kBalance1)

;2-NOTE PER SECOND (F.M. 1:3 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger2      oscil     1,                       2,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato2      oscil     0.0417*kTrigger2,        7,                                 1              ;VIBRATO DEPTH & RATE
knote2         oscil     idB,                     2,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder2        linseg    0,   p3*0.125,           0,   0,        1,   p3*0.875,      1              ;RHYTHM-START CONTROL
kBalance2      oscil     1,                       1,                                 77             ;PANNING TRANSFER FUNCTION
aModul2        oscil     idB*kTrigger2,           cpsoct(ioct3+kVibrato2),           1              ;RATIO-3 MODULATOR
aCarrier2      oscil     knote2*kOrder2,          (cpsoct(ioct1+kVibrato2)+aModul2)*3,1             ;RATIO-1 CARRIER
audio2L        =         aCarrier2*kBalance2
audio2R        =         aCarrier2*(1-kBalance2)

;3-NOTE PER SECOND (F.M. 1:5 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger3      oscil     1,                       3,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato3      oscil     0.0417*kTrigger3,        6,                                 1              ;VIBRATO DEPTH & RATE
knote3         oscil     idB,                     3,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder3        linseg    0,   p3*0.25,            0,   0,        1,   p3*0.75,       1              ;RHYTHM-START CONTROL
kBalance3      oscil     1,                       1.5,                               77             ;PANNING TRANSFER FUNCTION
aModul3        oscil     idB*kTrigger3,           cpsoct(ioct5+kVibrato3),           1              ;RATIO-5 MODULATOR
aCarrier3      oscil     knote3*kOrder3,          (cpsoct(ioct1+kVibrato3)+aModul3)*5,1             ;RATIO-1 CARRIER
audio3L        =         aCarrier3*kBalance3
audio3R        =         aCarrier3*(1-kBalance3)

;4-NOTE PER SECOND (1:7 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger4      oscil     1,                       4,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato4      oscil     0.0417*kTrigger4,        5,                                 1              ;VIBRATO DEPTH & RATE
knote4         oscil     idB,                     4,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder4        linseg    0,   p3*0.375,           0,   0,        1,   p3*0.625,      1              ;RHYTHM-START CONTROL
kBalance4      oscil     1,                       2,                                 77             ;PANNING TRANSFER FUNCTION
aModul4        oscil     idB*kTrigger4,           cpsoct(ioct7+kVibrato4),           1              ;RATIO-7 MODULATOR
aCarrier4      oscil     knote4*kOrder4,          (cpsoct(ioct1+kVibrato4)+aModul4)*7,1             ;RATIO-1 CARRIER
audio4L        =         aCarrier4*kBalance4
audio4R        =         aCarrier4*(1-kBalance4)

;5-NOTE PER SECOND (1:9 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger5      oscil     1,                       5,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato5      oscil     0.0417*kTrigger5,        4,                                 1              ;VIBRATO DEPTH & RATE
knote5         oscil     idB,                     5,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder5        linseg    0,   p3*0.5,             0,   0,        1,   p3*0.5,        1              ;RHYTHM-START CONTROL
kBalance5      oscil     1,                       2.5,                               77             ;PANNING TRANSFER FUNCTION
aModul5        oscil     idB*kTrigger5,           cpsoct(ioct9+kVibrato5),           1              ;RATIO-9 MODULATOR
aCarrier5      oscil     knote5*kOrder5,          (cpsoct(ioct1+kVibrato5)+aModul5)*9,1             ;RATIO-1 CARRIER
audio5L        =         aCarrier5*kBalance5
audio5R        =         aCarrier5*(1-kBalance5)

;6-NOTE PER SECOND (1:11 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger6      oscil     1,                       6,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato6      oscil     0.0417*kTrigger6,        3,                                 1              ;VIBRATO DEPTH & RATE
knote6         oscil     idB,                     6,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder6        linseg    0,   p3*0.625,           0,   0,        1,   p3*0.375,      1              ;RHYTHM-START CONTROL
kBalance6      oscil     1,                       3,                                 77             ;PANNING TRANSFER FUNCTION
aModul6        oscil     idB*kTrigger6,           cpsoct(ioct11+kVibrato6),          1              ;RATIO-11 MODULATOR
aCarrier6      oscil     knote6*kOrder6,          (cpsoct(ioct1+kVibrato6)+aModul6)*11,1            ;RATIO-1 CARRIER
audio6L        =         aCarrier6*kBalance6
audio6R        =         aCarrier6*(1-kBalance6)

;7-NOTE PER SECOND (1:13 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger7      oscil     1,                       7,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato7      oscil     0.0417*kTrigger7,        2,                                 1              ;VIBRATO DEPTH & RATE
knote7         oscil     idB,                     7,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder7        linseg    0,   p3*0.75,            0,   0,        1,   p3*0.25,       1              ;RHYTHM-START CONTROL
kBalance7      oscil     1,                       3.5,                               77             ;PANNING TRANSFER FUNCTION
aModul7        oscil     idB*kTrigger7,           cpsoct(ioct13+kVibrato7),          1              ;RATIO-13 MODULATOR
aCarrier7      oscil     knote7*kOrder7,          (cpsoct(ioct1+kVibrato7)+aModul7)*13,1            ;RATIO-1 CARRIER
audio7L        =         aCarrier7*kBalance7
audio7R        =         aCarrier7*(1-kBalance7)

;8-NOTE PER SECOND (1:15 RATIO)
;NAMME         KIND      BIAS                     RATE                               FUNCTION TABLE
kTrigger8      oscil     1,                       8,                                 57             ;EXPONENTIAL TRANSFER FUNCTION
kVibrato8      oscil     0.0417*kTrigger8,        1,                                 1              ;VIBRATO DEPTH & RATE
knote8         oscil     idB,                     8,                                 73             ;LINEAR TRANSFER FUNCTION
kOrder8        linseg    0,   p3*0.875,           0,   0,        1,   p3*0.125,      1              ;RHYTHM-START CONTROL
kBalance8      oscil     1,                       4,                                 77             ;PANNING TRANSFER FUNCTION
aModul8        oscil     idB*kTrigger8,           cpsoct(ioct15+kVibrato8),          1              ;RATIO-15 MODULATOR
aCarrier8      oscil     knote8*kOrder8,          (cpsoct(ioct1+kVibrato8)+aModul8)*15,1            ;RATIO-1 CARRIER
audio8L        =         aCarrier8*kBalance8
audio8R        =         aCarrier8*(1-kBalance8)

;FINAL MIX
aMixL          =         audio1L+audio2L+audio3L+audio4L+audio5L+audio6L+audio7L+audio8L
aMixR          =         audio1R+audio2R+audio3R+audio4R+audio5R+audio6R+audio7R+audio8R

outs           aMixL,    aMixR
garvbsig       =         garvbsig+(aMixL+aMixR)*irvbgain                                            ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 1 - POLY RHYTHM



instr          2                                  ;CLASSIC A. M. BELL (1:1.414213562 RATIO)


iModulate      =         cpspch(p4)*1.414213562
iSubcarrier    =         cpspch(p4)*2.014233086
iCarrier       =         cpspch(p4)
idB            =         ampdb(p5)
iPanning       =         p6
;REVERBERATION GAIN
irvbgain       =         p7                                                               ;REVERB GAIN

kModualEG      line      idB,                     P3,            idB*0
kCarrierEG     expon     idB,                     p3,            idB*0.0001
kPanning       line      iPanning,                p3,            1-iPanning

aSubcarrier    oscil     kModualEG,                    iSubcarrier,   1
aModulate      oscil     kModualEG+aSubcarrier,   iModulate,          1
aCarrier       oscil     kCarrierEG+aModulate,    iCarrier,      1

               outs      aCarrier*kPanning,  aCarrier*(1-kPanning)
garvbsig       =         garvbsig+aCarrier*irvbgain                                       ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 2 - CLASSIC A. M. BELL



instr          3                                                                          ;RANDOM RING MODULATION


iBasicHz       =         cpspch(p4)
idB            =         ampdb(p5)
;REVERBERATION GAIN
irvbgain       =         p6                                                               ;REVERB GAIN

kAccelerator   expseg    1,             p3/2,     2,             p3/2,     1
kEG2           linseg    idB*0,         p3/4,     idB*0.75, p3/4,     idB*0.25, p3/4,     idB*1,    p3/4,     idB*0
kEG1           expseg    idB*0.0001,    p3*0.2,   idB,      p3*0.5,   idB,      p3*0.3,   idB*0.0001
kPanning       linseg    0.5,      p3/3,     0.8,      p3/3,     0.2,      p3/3,     0.5
kRandom1       randi     abs(iBasicHz),      p3*kAccelerator,              iBasicHz/1.414213562
kRandom2       randi     abs(iBasicHz),      p3*kAccelerator*1.25,         iBasicHz/2

aModulator2    oscil     kEG2,               kRandom1+iBasicHz*1.414213562/5,   1
aModulator1    oscil     kEG2+aModulator2,   kRandom2+iBasicHz/5,                    1
aCarrier       oscil     kEG1+aModulator1,   iBasicHz,                               2

               outs      aCarrier*kPanning,            aModulator1*(1-kPanning)
garvbsig       =         garvbsig+aCarrier*irvbgain                                       ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 3 - RANDOM RING MODULATION



instr          4                                                                          ;SINE SIREN


iBottomHz      =         cpspch(p4)
idB            =         ampdb(p5)
;REVERBERATION GAIN
irvbgain       =         p6                                                               ;REVERB GAIN

kPumping       linen     idB,      0.25,               p3,       0.5
kRate          expseg    0.01,          p3/3,               4,        p3/3,          4,        p3/3,          0.0001
kLFO           oscil     2,             kRate,              1
kPanning       oscil     1,             1/2,           79

aSine          oscil     kPumping, iBottomHz*kLFO,     1

               outs      aSine*kPanning,          aSine*(1-kPanning)
garvbsig       =         garvbsig+aSine*irvbgain                                          ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 4 - SINE SIREN



instr          5                                                                          ;SAW SIREN


iBottomHz      =         cpspch(p4)*1.498307077
idB            =         ampdb(p5)
;REVERBERATION GAIN
irvbgain       =         p6                                                               ;REVERB GAIN

kPumping       linen     idB,      0.25,               p3,       0.5
kRate          expseg    0.01,          p3/3,               8,        p3/3,          4,        p3/3,          0.0001
kLFO           oscil     1,             kRate,              81
kPanning       oscil     1,             1,                  73

aSaw           oscil     kPumping, iBottomHz*kLFO,     3

               outs      aSaw*kPanning,      aSaw*(1-kPanning)
garvbsig       =         garvbsig+aSaw*irvbgain                                           ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 5 - SAW SIREN



instr          6                                                                          ;SQUARE SIREN


iBottomHz      =         cpspch(p4)*1.68179283
idB            =         ampdb(p5)
;REVERBERATION GAIN
irvbgain       =         p6                                                               ;REVERB GAIN

kPumping       linen     idB,      0.25,               p3,       0.5
kRate          expseg    0.01,          p3/3,               16,       p3/3,          4,        p3/3,          0.0001
kLFO           oscil     1,             kRate,              70
kPanning       oscil     1,             1,                  77

aSquare        oscil     kPumping, iBottomHz*kLFO,     4

               outs      aSquare*kPanning,   aSquare*(1-kPanning)
garvbsig       =         garvbsig+aSquare*irvbgain                                        ;(IMPORTANT NOTICE)
endin
;END OF INSTRUMENT 6 - SQUARE SIREN



instr          7                                                                          ;F.M. NON-INTEGRAL RATIO



iModulator     =         cpspch(p4)*29.9894
iCarrier       =         cpspch(p4)*1.71
iMdB           =         ampdb(100)
iCdB           =         ampdb(p5)
iPanning       =         p6
iCommand       =         p7
;REVERBERATION GAIN
irvbgain       =         p8                                                               ;REVERB GAIN

if   (iCommand == 1)     kgoto tone
if   (iCommand == 2)     kgoto random
if   (iCommand == 3)     kgoto ascending
if   (iCommand == 4)     kgoto descending
if   (iCommand == 5)     kgoto envelope



tone:               kPanning       =         iPanning
                    kMamp          =         iMdB
                    kCamp          =         iCdB
                    kMHz           =         iModulator
                    kCHz           =         iCarrier

                    kgoto          output


random:             kPanning       linseg    1,   p3/3,          0.25,     p3/3,          0.75,     p3/3,          0
                    kMHz           =         iModulator
                    kCHz           =         iCarrier
                    kMamp          linseg    iMdB*1,   p3/4,          iMdB*0.75,     p3/4,          iMdB*0.9, p3/4,          iMdB*0.75,     p3/4,          iMdB*1
                    kCamp          =         iCdB

                    kgoto          output


ascending:          kPanning       line      0,                       p3,  1
                    kMHz           expon     iModulator/2,       p3,  iModulator
                    kCHz           line      iCarrier/2,              p3,  iCarrier
                    kMamp          =         iMdB
                    kCamp          =         iCdB

                    kgoto          output


descending:         kPanning       line      1,             p3,  0
                    kMHz           expon     iModulator,    p3,  iModulator/2
                    kCHz           line      iCarrier, p3,  iCarrier/2
                    kMamp          =         iMdB
                    kCamp          =         iCdB

                    kgoto          output


envelope:      kPanning            linseg    0.5, p3/3,          0,   p3/3,     1,   p3/3,     0.5
                    kMHz           expseg    iModulator/2,       p3*0.4,        iModulator,    p3*0.6,        iModulator/2
                    kCHz           linseg    iCarrier/2,              p3*0.25,  iCarrier, p3*0.75,  iCarrier/2
                    kMamp          linseg    iMdB*1,   p3/2,          iMdB*0.95,     p3/2,          iMdB*1
                    kCamp          =         iCdB

                    kgoto          output


output:             aModulator     oscil     kMamp,    kMHz,                    1
                    aCarrier       oscil     kCamp,    kCHz+aModulator,    1

                    outs           aCarrier*kPanning,       aCarrier*(1-kPanning)

garvbsig            =              garvbsig+aCarrier*irvbgain                        ;(IMPORTANT NOTICE)
endin



instr               8


ihz1                =              1/p6
ihz2                =              1/p7
ihz3                =              1/p8
ihz4                =              1/p9
ihz5                =              1/p10
ihz6                =              1/p11

a1                  soundin        p12
asig                =              a1*p4
alp1                alpass         asig,p5,ihz1
alp2                alpass         alp1,     (p5*0.909),    ihz2
alp3                alpass         alp2,     (p5*0.877),    ihz3
alp4                alpass         alp3,     (p5*0.768),    ihz4
alp5                alpass         alp4,     (p5*0.643),    ihz5
alp6                alpass         alp5,     (p5*0.531),    ihz6
aenv                linen          alp6,     0.003,p3, 0.1

                    outs           a1*0.25,  aenv*0.75
endin


instr               13

irvbtime            =              p4 

aEffect             reverb         garvbsig, irvbtime

;OUT COMMAND -
                    outs           aEffect,  aEffect

garvbsig            =              0                                  ;(IMPORTANT NOTICE)
endin  
