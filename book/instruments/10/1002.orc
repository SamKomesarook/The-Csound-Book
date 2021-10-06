; ************************************************************************
; Resonant Low-Pass Filter Instruments
;*************************************************************************
; 1. Table Based Rezzy Synth
; 2. Table Based PWM Rezzy Synth
; 3. Table Based Rezzy Synth with distortion
; 4. Noise Based Rezzy Synth
; 5. Buzz  Based Rezzy Synth
; 6. FM Based Rezzy Synth
; 7. 4 Pole Rezzy
; 8. 6 Pole Formant Filter
; 9. Mandelbrot's Snowflake Waveform with 4 Pole Filter
;10. Flowsnake Waveform with 4 Pole Filter
;*************************************************************************

sr     =        44100
kr     =        4410
ksmps  =        10
nchnls =        1

;******************************************************************
        instr   1005    ; TABLE BASED REZZY SYNTH

idur   =        p3
iamp   =        p4
ifqc   =        cpspch(p5)
irez   =        p7
itabl1 =        p8

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.02, 1, .01, 0

; FREQUENCY SWEEP
kfco    linseg  .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; OSCILLATOR
axn     oscil   iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;*************************************************************
        instr 1006  ; TABLE BASED PWM REZZY SYNTH

idur   =        p3
iamp   =        p4
ifqc   =        cpspch(p5)
irez   =        p7
itabl1 =        p8

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.02, 1, .01, 0

; FREQUENCY SWEEP
kfco    linseg  .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; PWM OSCILLATOR
ksine   oscil   1.5,        ifqc/440,     1
ksquare oscil   ifqc*ksine, ifqc,         2
axn     oscil   iamp,       ifqc+ksquare, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;******************************************************************
        instr 1007   ; TABLE BASED REZZY SYNTH WITH DISTORTION

idur   =        p3
iamp   =        p4
ifqc   =        cpspch(p5)
irez   =        p7
itabl1 =        p8

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.02, 1, .01, 0

; FREQUENCY SWEEP
kfco linseg     p6, .5*p3, .2*p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; OSCILLATOR
axn     oscil   iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)

atemp   tone    axn, kfco
aclip1  =       (ayn-atemp)/100000
aclip   tablei  aclip1, 7, 1, .5
aout    =       aclip*20000+atemp

aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
        out     kaenv*aout

        endin

;************************************************
        instr 1008   ; NOISE BASED REZZY SYNTH

iamp    =       p4
irez    =       p6

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.02, 1, .01, 0

; FREQUENCY SWEEP
kfco    linseg  .1*p5, .5*p3, p5, .5*p3, .1*p5

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; NOISE SOURCE
axn     rand    iamp

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;************************************************
        instr   1009  ; BUZZ BASED REZZY SYNTH

idur   =        p3
iamp   =        p4
ifqc   =        cpspch(p5)
irez   =        p7
itabl1 =        p8

; Amplitude envelope
kaenv  linseg   0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
kfco    linseg  .1*p6, .5*p3, p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; BUZZ SOURCE
;               PITCH,  AMP, #PARTIALS, FUNCTION
axn    buzz     iamp, ifqc,  itabl1,      1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

        instr   1010   ; FM BASED REZZY SYNTH

idur    =       p3
iamp    =       p4
ifqc    =       cpspch(p5)
irez    =       p7
itabl1  =       p8

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.03, 1, .01, 0, .01, 0
kfmenv linseg   .2, .2*p3, 2, .6*p3, .5, .2*p3, .2

; FREQUENCY SWEEP
kfco    linseg  .1*p6, .5*p3, p6, .5*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez/sqrt(kfco)-1
ka2     =       1000/kfco

; INITIALIZE Yn-1 & Yn-2 TO ZERO
aynm1   init    0
aynm2   init    0

; OSCILLATOR
axn     foscil  iamp, ifqc, p9, p10, kfmenv, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn     =       ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
aynm2   =       aynm1
aynm1   =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;******************************************************************
        instr   1011   ; 4 POLE FILTER

idur    =       p3
iamp    =       p4
ifqc    =       cpspch(p5)
irez1   =       p7
irez2   =       p9
itabl1  =       p10

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1   linseg  .1*p6, .3*p3, p6, .7*p3, .1*p6
kfco2   linseg  .1*p8, .3*p3, p8, .7*p3, .1*p8

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez1/sqrt(kfco1)-1
ka2     =       1000/kfco1
kb1     =       100/irez2/sqrt(kfco2)-1
kb2     =       1000/kfco2

; INITIALIZE Yn-1 to Yn-4 TO ZERO
ayn1m1  init    0
ayn1m2  init    0
ayn2m1  init    0
ayn2m2  init    0

; OSCILLATOR
axn     oscil   iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn1    =       ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

ayn1m2  =       ayn1m1
ayn1m1  =       ayn1

ayn     =       ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

ayn2m2  =       ayn2m1
ayn2m1  =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;******************************************************************
        instr   1012   ; 6 POLE FORMANT FILTER

idur    =       p3
iamp    =       p4
ifqc    =       cpspch(p5)
irez1   =       p7
irez2   =       p9
irez3   =       p11
itabl1  =       p12

; AMPLITUDE ENVELOPE
kaenv   linseg  0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1   linseg  .1*p6,  .5*p3, p6,  .5*p3, .1*p6
kfco2   linseg  .1*p8,  .2*p3, p8,  .8*p3, .1*p8
kfco3   linseg  .1*p10, .8*p3, p10, .2*p3, .1*p10

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez1/sqrt(kfco1)-1
ka2     =       1000/kfco1
kb1     =       100/irez2/sqrt(kfco2)-1
kb2     =       1000/kfco2
kc1     =       100/irez3/sqrt(kfco3)-1
kc2     =       1000/kfco3

; INITIALIZE Yn-1 to Yn-2 TO ZERO
ayn1m1  init    0
ayn1m2  init    0
ayn2m1  init    0
ayn2m2  init    0
ayn3m1  init    0
ayn3m2  init    0

; OSCILLATOR
axn     oscil   iamp, ifqc, itabl1

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn1    =       ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

ayn1m2  =       ayn1m1
ayn1m1  =       ayn1

ayn2    =       ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

ayn2m2  =       ayn2m1
ayn2m1  =       ayn2

ayn     =       ((kc1+2*kc2)*ayn3m1-kc2*ayn3m2+ayn2)/(1+kc1+kc2)

ayn3m2  =       ayn3m1
ayn3m1  =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;******************************************************************
        instr   1013   ; MANDELBROT'S SNOWFLAKE 4 POLE FILTER

idur    =       p3
iamp    =       p4
ifqc    =       cpspch(p5)
irez1   =       p7
irez2   =       p7
iamp2   =       p8
iamp3   =       p9

; AMPLITUDE ENVELOPE
kaenv  linseg   0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfcoe   expseg  .1*p6, .1*p3, p6, .9*p3, .01*p6
kfcoo   oscil   1,6,1

kfco1   =       kfcoe+(kfcoo+1)*kfcoe*.6
kfco2   =       kfco1

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez1/sqrt(kfco1)-1
ka2     =       1000/kfco1
kb1     =       100/irez2/sqrt(kfco2)-1
kb2     =       1000/kfco2

; INITIALIZE Yn-1 to Yn-4 TO ZERO
ayn1m1  init    0
ayn1m2  init    0
ayn2m1  init    0
ayn2m2  init    0

; OSCILLATOR
ax1     oscil   iamp,  ifqc, 6
ax2     oscil   iamp2, ifqc*4, 6
ax3     oscil   iamp3, ifqc/4, 6
axn     =       ax1 + ax2 + ax3

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn1    =       ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

ayn1m2  =       ayn1m1
ayn1m1  =       ayn1

ayn     =       ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

ayn2m2  =       ayn2m1
ayn2m1  =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin

;******************************************************************
        instr   1014  ; FLOWSNAKE 4 POLE FILTER

idur    =       p3
iamp    =       p4
ifqc    =       cpspch(p5)
irez1   =       p7
irez2   =       p7
iamp2   =       p8
iamp3   =       p9

; AMPLITUDE ENVELOPE
kaenv   linseg  0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; FREQUENCY SWEEP
kfco1   linseg  .1*p6, .1*p3, p6, .9*p3, .1*p6
kfco2   linseg  .1*p6, .1*p3, p6, .9*p3, .1*p6

; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1     =       100/irez1/sqrt(kfco1)-1
ka2     =       1000/kfco1
kb1     =       100/irez2/sqrt(kfco2)-1
kb2     =       1000/kfco2

; INITIALIZE Yn-1 to Yn-4 TO ZERO
ayn1m1  init    0
ayn1m2  init    0
ayn2m1  init    0
ayn2m2  init    0

; OSCILLATOR
ax1     oscil   iamp,  ifqc, 4
ax2     oscil   iamp2, ifqc*2, 4
ax3     oscil   iamp3, ifqc/2, 4
axn     =       ax1 + ax2 + ax3

; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn1    =       ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

ayn1m2  =       ayn1m1
ayn1m1  =       ayn1

ayn     =       ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

ayn2m2  =       ayn2m1
ayn2m1  =       ayn

; AMP ENVELOPE AND OUTPUT
aout    =       ayn * kaenv
        out     aout

        endin
