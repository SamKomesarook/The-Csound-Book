;---------------------------------------------------------------------------
; MIKELSON'S MULTI-FX SYSTEM
;---------------------------------------------------------------------------
; 3002. PLUCK
; 3013. TUBE AMP DISTORTION
; 3017. TALK BOX
; 3099. MIX
;---------------------------------------------------------------------------
sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2
;---------------------------------------------------------------------------
        zakinit 30, 30
;---------------------------------------------------------------------------
; SOUND SOURCE
;---------------------------------------------------------------------------
; PLUCK PHYSICAL MODEL
;---------------------------------------------------------------------------
        instr   3002
iamp    =       p4                  ; AMPLITUDE
ifqc    =       cpspch(p5)          ; CONVERT TO FREQUENCY
itab1   =       p6                  ; INITIAL TABLE
imeth   =       p7                  ; DECAY METHOD
ioutch  =       p8                  ; OUTPUT CHANNEL
kamp    linseg  0, .002, iamp, p3-.004, iamp, .002, 0  ; DECLICK
aplk    pluck   kamp, ifqc, ifqc, itab1, imeth         ; PLUCK WAVEGUIDE MODEL
        zawm    aplk, ioutch                           ; WRITE TO OUTPUT
gifqc   =       ifqc
        endin
;---------------------------------------------------------------------------
; Distortion
;---------------------------------------------------------------------------
        instr   3013
igaini  =       p4                  ; PRE GAIN
igainf  =       p5                  ; POST GAIN
iduty   =       p6                  ; DUTY CYCLE OFFSET
islope  =       p7                  ; SLOPE OFFSET
izin    =       p8                  ; INPUT CHANNEL
izout   =       p9                  ; OUTPUT CHANNEL
asign   init    0                   ; DELAYED SIGNAL
kamp    linseg  0, .002, 1, p3-.004, 1, .002, 0   ; DECLICK
asig    zar     izin                ; READ INPUT CHANNEL
aold    =       asign               ; SAVE THE LAST SIGNAL
asign   =       igaini*asig/60000   ; NORMALIZE THE SIGNAL
aclip   tablei  asign,5,1,.5        ; READ THE WAVESHAPING TABLE
aclip   =       igainf*aclip*15000  ; RE-AMPLIFY THE SIGNAL
atemp   delayr  .1                  ; AMPLITUDE AND SLOPE BASED DELAY
aout    deltapi (2-iduty*asign)/1500 + islope*(asign-aold)/300
        delayw  aclip
        zaw     aout, izout         ; WRITE TO OUTPUT CHANNEL
        endin
;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
        instr   3017
idur    =       p3                  ; DURATION
ixtab   =       p4                  ; INDEX TABLE
ifrmtab =       p5                  ; FORMANT TABLE
iamptab =       p6                  ; FORMANT AMPLITUDE TABLE
izin    =       p7                  ; INPUT CHANNEL
izout   =       p8                  ; OUTPUT CHANNEL
iptime  =       idur/128            ; TIME TO SLIDE HALF WAY TO NEXT FORMANT SET
kdeclick linseg 1, p3-.002, 1, .002, 0  ; DECLICK
kformi  oscil   1, 1/idur, ixtab    ; READ THE FORMANT INDEX TABLE
kform1  table   3*kformi,   ifrmtab ; READ THE FIRST FORMANT FREQUENCY
kdb1    table   3*kformi, ifrmtab   ; READ THE FIRST FORMANT dB's
kamp1   =       dbamp(60+kdb1)/200  ; CONVERT FROM DECIBELS TO AMPLITUDE
kform2  table   3*kformi+1, ifrmtab ; READ THE SECOND FORMANT FREQUENCY
kdb2    table   3*kformi+1, ifrmtab ; READ THE SECOND FORMANT dB's
kamp2   =       dbamp(60+kdb2)/200  ; CONVERT dB TO AMP
kform3  table   3*kformi+2, ifrmtab ; READ THE THIRD FORMANT FREQUENCY
kdb3    table   3*kformi+2, ifrmtab ; READ THE THIRD FORMNAT dB's
kamp3   =       dbamp(60+kdb3)/200  ; CONVERT dB TO AMP
kfrm1p  port    kform1, iptime, 300 ; PORTAMENTO TO THE NEXT FORMANT
kamp1p  port    kamp1,  iptime, .15 ; PORTAMENTO TO THE NEXT AMPLITUDE
kfrm2p  port    kform2, iptime, 2000    ; REPEAT FOR SECOND
kamp2p  port    kamp2,  iptime, .15
kfrm3p  port    kform3, iptime, 4000    ; AND AGAIN FOR THE THIRD
kamp3p  port    kamp3,  iptime, .15
asig    zar     izin                ; OUTPUT CHANNEL
aform1  reson   asig, kfrm1p, kfrm1p/8  ; COMPUTE THE THREE RESONANCES
aform2  reson   asig, kfrm2p, kfrm2p/8
aform3  reson   asig, kfrm3p, kfrm3p/8
abal1   balance aform1, asig            ; ADJUST THE LEVELS
abal2   balance aform2, asig
abal3   balance aform3, asig
aout    =       abal1*kamp1p+abal2*kamp2p+abal3*kamp3p  ; SCALE AND SUM
        zaw     aout*kdeclick, izout    ; WRITE TO THE OUTPUT CHANNEL
        endin
;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
        instr   3099    
asig1   zar     p4                  ; p4 = ch1 IN
igl1    init    p5*p6               ; p5 = ch1 GAIN
igr1    init    p5*(1-p6)           ; p6 = ch1 PAN
asig2   zar     p7                  ; p7 = ch2 IN
igl2    init    p8*p9               ; p8 = ch2 GAIN
igr2    init    p8*(1-p9)           ; p9 = ch2 PAN
asig3   zar     p10                 ; p10 = ch3 IN
igl3    init    p11*p12             ; p11 = ch3 GAIN
igr3    init    p11*(1-p12)         ; p12 = ch3 PAN
asig4   zar     p13                 ; p13 = ch4 IN
igl4    init    p14*p15             ; p14 = ch4 GAIN
igr4    init    p14*(1-p15)         ; p15 = ch4 PAN
asigl   =       asig1*igl1+asig2*igl2+asig3*igl3+asig4*igl4 
asigr   =       asig1*igr1+asig2*igr2+asig3*igr3+asig4*igr4 
        outs    asigl, asigr    
        zacl    0, 30   
        endin
