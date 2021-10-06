sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2
gatenor        init      0
gasoprano      init      0
gareverb       init      0

instr          19                  ; PULSE WAVE SOURCE FOR TENOR VOICES.
                                   ; OCTAVE LOWER THAN SOPRANO.

idur           =         p3
iamp           =         p4
ifreq          =         p5 * .5

iharms         =         (sr*.4) / ifreq

asig           gbuzz     1, ifreq, iharms, 1, .9, 2
kenv           linseg    0, .1, iamp, idur -.2, iamp, .1, 0
aout           =         kenv * asig
gatenor        =         gatenor + aout
     
endin

instr          20                  ; PULSE WAVE SOURCE FOR SOPRANO VOICES.

idur           =         p3
iamp           =         p4
ifreq          =         p5

iharms         =         (sr*.4) / ifreq

asig           gbuzz     1, ifreq, iharms, 1, .8, 2
kenv           linseg    0, .1, iamp, idur -.2, iamp, .1, 0
aout           =         kenv * asig
gasoprano      =         gasoprano + aout


endin


instr          21                  ; GLOBAL ANIMATOR/FORMANTS FOR SOPRANO

idur           =         p3
ivib1          =         p4
ivib2          =         p5
ivibtime       =         p6

kvib           linseg    ivib1, ivibtime, ivib1, idur, ivib2
; FOUR INDEPENDENT LFOS FOR VIBRATO, BASED ON ARP OMNI 
; PHASER SECTION. 
ktime1         oscili    .0012 * kvib, 4, 1
ktime2         oscili    .0009 * kvib, 5, 1
ktime3         oscili    .00087 * kvib, 6.3, 1
ktime4         oscili    .0011 * kvib, 4.4, 1

; EACH LFO MODULATES A SEPERATE DELTAPI DELAY LINE.
adummy         delayr    .015
asig1          deltapi   ktime1 + .009
asig2          deltapi   ktime2 + .009
asig3          deltapi   ktime3 + .009
asig4          deltapi   ktime4 + .009
               delayw    gasoprano

; THE FOUR DELAY LINES ARE SUMMED TOGETHER.
aout           =         (asig1 + asig2 + asig3 + asig4) * .25

; BANDPASS FILTERS, SET TO PRODUCE FORMANTS FOR
; THE SOPRANO "AH" SOUND.
afilt1         reson     aout, 800, 80, 1
afilt2         resonz    aout, 1150, 90, 1
afilt3         resonz    aout, 2900, 120, 1
afilt4         resonz    aout, 3900, 130, 1
afilt5         resonz    aout, 4950, 140, 1

; OUTPUTS OF FILTERS SCALED TO CORRESPOND TO RELATIVE
; AMPLITUDES OF FORMANTS IN VOCAL SOUND.
aout2          =         (afilt1 + .5 * afilt2 + 0.1 * afilt3 + 0.3 * afilt4 + .05 * afilt5)

; PART OF OUTPUT SENT TO REVERB.
gareverb       =         gareverb + .47 * aout2

               outs      aout2, aout2

gasoprano      =         0

endin

instr          22                       ; GLOBAL ANIMATOR/FORMANTS FOR TENOR

idur           =         p3
ivib1          =         p4
ivib2          =         p5
ivibtime       =         p6

kvib           linseg    ivib1, ivibtime, ivib1, idur, ivib2
; FOUR INDEPENDENT LFOS FOR VIBRATO, BASED ON ARP OMNI 
; PHASER SECTION. 
ktime1         oscili    .0012 * kvib, 4.2, 1
ktime2         oscili    .0009 * kvib, 5.3, 1
ktime3         oscili    .00087 * kvib, 6.1, 1
ktime4         oscili    .0011 * kvib, 3.9, 1

; EACH LFO MODULATES A SEPERATE DELTAPI DELAY LINE.
adummy         delayr    .015
asig1          deltapi   ktime1 + .009
asig2          deltapi   ktime2 + .009
asig3          deltapi   ktime3 + .009
asig4          deltapi   ktime4 + .009
               delayw    gatenor
     
; THE FOUR DELAY LINES ARE SUMMED TOGETHER.
aout           =         (asig1 + asig2 + asig3 + asig4) * .25

; BANDPASS FILTERS, SET TO PRODUCE FORMANTS FOR
; THE SOPRANO "AH" SOUND.
afilt1         reson     aout, 650, 80, 1
afilt2         resonz    aout, 1080, 90, 1
afilt3         resonz    aout, 2650, 120, 1
afilt4         resonz    aout, 2900, 130, 1
afilt5         resonz    aout, 3250, 140, 1
aout2          =         (afilt1 + .5 * afilt2 + 0.44 * afilt3 + 0.4 * afilt4 + 0.1 * afilt5)

; OUTPUTS OF FILTERS SCALED TO CORRESPOND TO RELATIVE
; AMPLITUDES OF FORMANTS IN VOCAL SOUND.
gareverb       =         gareverb + .47 * aout2

; PART OF OUTPUT SENT TO REVERB.
               outs      aout2, aout2

gatenor        =         0

endin

instr          99             ; FEEDBACK DELAY NETWORK REVERB, BASED ON WORK
                              ; OF STAUTNER & PUCKETTE.

afilt1         init      0
afilt2         init      0
afilt3         init      0
afilt4         init      0

igain          =         p4 * 0.70710678117       ; GAIN OF REVERB
ipitchmod      =         p5                       ; AMOUNT OF RANDOM PITCH MOD, BETWEEN 0 AND 1
idelaytime     =         p6                       ; CONTROLS OVERALL LENGTH OF DELAY LINES
ifilt          =         p7                       ; CONTROLS CUTOFF OF LOWPASS FILTERS AT OUTPUTS OF DELAY LINES
ifreq          =         p8                       ; CONTROLS FREQUENCY OF RANDOM NOISE

kgain          linseg    .94, 66, .94, 2, 1, p3 - 68, 1
k1             randi     .001, 3.1 * ifreq, .06
k2             randi     .0011, 3.5 * ifreq, .9
k3             randi     .0017, 1.11 * ifreq, .7
k4             randi     .0006, 3.973 * ifreq, .3

atap           multitap  gareverb, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

adum1          delayr    0.072 
adel1          deltapi   0.0663 * idelaytime + k1 * ipitchmod
               delayw    gareverb + afilt2 + afilt3

adum2          delayr    0.082 
adel2          deltapi   0.0753 * idelaytime + k2 * ipitchmod
               delayw    gareverb - afilt1 - afilt4

adum3          delayr    0.095
adel3          deltapi   0.0882 * idelaytime + k3 * ipitchmod
               delayw    gareverb + afilt1 - afilt4

adum4          delayr    0.11
adel4          deltapi   0.0971 * idelaytime + k4 * ipitchmod
               delayw    gareverb + afilt2 - afilt3

afilt1         tone      adel1 * igain, ifilt
afilt2         tone      adel2 * igain, ifilt
afilt3         tone      adel3 * igain, ifilt
afilt4         tone      adel4 * igain, ifilt

               outs      afilt1 + afilt4 + atap, afilt2 + afilt3 + atap

gareverb       =         0

endin
