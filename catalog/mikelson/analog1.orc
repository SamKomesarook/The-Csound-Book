;---------------------------------------------------------------
; A set of analog modeling instruments using resonant low-pass
; filter by Hans Mikelson November 1998
;---------------------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          zakinit   50, 50

;---------------------------------------------------------------
; LFO
;---------------------------------------------------------------
          instr   5

idur      =         p3
iamp      =         p4
ifqc      =         p5
iwave     =         p6
ioffset   =         p7
ioutch    =         p8

ksig      oscil     iamp, ifqc, iwave
kout      =         ksig*.5+ioffset
          zkw       kout, ioutch

          endin

;---------------------------------------------------------------
; MOOG VCO WITH MIKLESON FILTER
;---------------------------------------------------------------
          instr   10
     
idur      =         p3                       ; DURATION
iamp      =         p4                       ; AMPLITUDE
ifqc      =         cpspch(p5)               ; FREQUENCY
irtfqc    =         sqrt(ifqc)               ; SQUARE ROOT OF FREQUENCY
ifco      =         p6*ifqc/500              ; FILTER CUT OFF (HIGHER FREQUENCIES GET A HIGHER CUT OFF)
krez      init      p7                       ; RESONANCE DOES NOT CHANGE IN THIS INSTRUMENT
iwave     =         p8                       ; SELECTED WAVE FORM 1=SAW, 2=SQUARE/PWM, 3=TRI/SAW-RAMP-MOD
ipwch     =         p9                       ; PWM SRM MODULATION CHANNEL
ileak     =         (iwave==2 ? .999 : (iwave==3 ? .995 : .999)) ; LEAKY INTEGRATION VALUE

kpw       zkr      ipwch                     ; READ THE ZAK MODULATION CHANNEL
kpwn      =        kpw-.5                    ; GET A PULSE WIDTH THAT GOES FROM -.5 TO .5

kfco      expseg    100+.01*ifco, .2*idur, ifco+100, .5*idur, ifco*.1+100, .3*idur, .001*ifco+100 ; FILTER ENVELOPE

apulse1   buzz      1, ifqc, sr/2/ifqc, 1    ; BAND-LIMITED IMPULSE TRAIN
apulse2   vdelay    apulse1, 1000/ifqc*kpw, 1000/ifqc ; DELAY THE IMPULSE TRAIN BY LAMBDA/PW.

asaw      biquad    apulse1, 1, 0, 0, 1, -ileak, 0 ; BIQUAD IS USED TO DO A LEAKY INTEGRATOR FOR SAW WAVE
apdiff    =         apulse1-apulse2          ; PULSE DIFFERENCE IS NEEDED FOR SQUARE WAVE
asqr1     biquad    apdiff,  1, 0, 0, 1, -ileak, 0 ; BIQUAD USED FOR LEAKY INTEGRATOR OF PULSE DIFFERENCE
asqr      =         asqr1+kpwn               ; ADJUSTMENT TO REMOVE DC COMPONENT
atri1     biquad    asqr1,   1, 0, 0, 1, -ileak, 0 ; TRIANGLE WAVE, MANY ADJUSTMENTS ARE NECESSARY TO CONTERACT AMPLITUDE
atri      =         (atri1*irtfqc/(kpw*(1-kpw))/3000+5*kpwn/irtfqc)*(1-kpwn*kpwn*20/irtfqc)/sr*44100 ; AND DC VARIATIONS

asig      =         (iwave==2 ? asqr : (iwave==3 ? atri : asaw)) ; SELECT YOUR WAVEFORM HERE

; aout    rezzy     asig, kfco, krez         ; APPLY THE FILTER

          outs      asig*iamp, asig*iamp     ; STEREO OUPUT AND AMPLIFICATION
          endin
