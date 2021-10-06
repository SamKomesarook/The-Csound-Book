;---------------------------------------------------------
; 3 Drums
; Coded by Hans Mikelson October 9, 1999
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        44100                      ; Kontrol rate
ksmps   =        1                          ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Formant pop
;---------------------------------------------------------
       instr     10

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
ifqc   =         cpspch(p5)
ipanl  =         sqrt(p6)      ; Pan left
ipanr  =         sqrt(1-p6)    ; Pan right
if1    =         p7*ifqc       ; Formant fqc 1
ia1    =         p8            ; Formant amp 1
iwdth  =         p9*.1         ; Band width

adclck linseg    0, .002, 1, idur-.004, 1, .002, 0 ; Declick envelope
kamp   linseg    0, .001, 1, .002, 0, idur-.003, 0

arnd   rand      kamp*6/iwdth                      ; Genrate impulse
asig   butterbp  arnd, ifqc, ifqc*iwdth            ; Band pass filter
asig1  butterbp  arnd, if1,  if1*iwdth             ; Band pass filter

aout   =         (asig+asig1*ia1)*iamp*adclck      ; Apply amp envelope and declick

       outs      aout*ipanl, aout*ipanr            ; Output the sound

       endin

;---------------------------------------------------------
; Kick Drum
;---------------------------------------------------------
       instr     11

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
iacc   =         p5            ; Accent
irez   =         p6            ; Resonance
iod    =         p7            ; Overdrive
ilowf  =         p8            ; Low Frequency

kfenv  linseg    1000*iacc,  .02, 180, .04, 120, idur-.06, ilowf ; Freq Envelope
kaenv  expseg    .1, .001, 1, .02, 1, .04, .7, idur-.062, .7  ; Amp Envelope
kdclck linseg    0, .002, 1, idur-.042, 1, .04, 0             ; Declick
asig   rand      2                                            ; Random number

aflt   rezzy     asig, kfenv, irez*40         ; Filter

aout1  =         aflt*kaenv*3*iod/iacc        ; Scale the sound

krms   rms       aout1, 1000                  ; Limiter, get rms
klim   table3    krms*.5, 5, 1                ; Get limiting value
aout   =         aout1*klim*iamp*kdclck/sqrt(iod)*1.3   ; Scale again and ouput

       outs      aout, aout                   ; Output the sound

       endin

;---------------------------------------------------------
; FM Tom-Tom
;---------------------------------------------------------
       instr     12

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
ifqc   =         cpspch(p5)    ; Convert pitch to frequency
irez   =         p6            ; Resonance or Q
ifco   =         p7            ; Cut off frequency
ihit   =         p8            ; Noise duration
ihamp  =         p9            ; Noise amplitude
ipanl  =         sqrt(p10)     ; Pan left
ipanr  =         sqrt(1-p10)   ; Pan right

afqc1  linseg    1+iamp/30000, ihit*.5*idur, 1, .1, 1 ; Pitch bend
afqc   =         afqc1*afqc1                       ; Pitch bend squared
adclck linseg    0, .002, 1, idur-.004, 1, .002, 0 ; Declick envelope
aamp1  expseg    .01, .001, 1, idur-.001, .04      ; Tone envelope
aamp2  expseg    .01, .001, 1, idur*ihit-.001, .01 ; Noise envelope

arnd1  rand      ihamp                          ; Genrate noise
arnd   rezzy     arnd1, ifco, irez, 1           ; High pass mode
asig   oscil     1, afqc*ifqc*(1+arnd*aamp2), 1 ; Frequency modulation with noise

aout   =         asig*iamp*aamp1*adclck         ; Apply amp envelope and declick

       outs      aout*ipanl, aout*ipanr         ; Output the sound

       endin


