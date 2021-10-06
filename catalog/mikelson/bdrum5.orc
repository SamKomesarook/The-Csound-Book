;---------------------------------------------------------
; KICK DRUM
; CODED BY HANS MIKELSON AUGUST 25, 1999
;---------------------------------------------------------
sr        =              44100                         ; SAMPLE RATE
kr        =              44100                         ; KONTROL RATE
ksmps     =              1                             ; SAMPLES/KONTROL PERIOD
nchnls    =              2                             ; NORMAL STEREO
          zakinit        50,50                         ; MAY NEED THIS LATER


;---------------------------------------------------------
; KICK DRUM 2
;---------------------------------------------------------
          instr          11

idur      =              p3                  ; DURATION
iamp      =              p4                  ; AMPLITUDE
iacc      =              p5                  ; ACCENT
irez      =              p6                  ; RESONANCE
iod       =              p7                  ; OVERDRIVE
ilowf     =              p8                  ; LOW FREQUENCY
     
kfenv     linseg         1000*iacc,  .02, 180, .04, 120, idur-.06, ilowf   ; FREQ ENVELOPE
kaenv     expseg         .1, .001, 1, .02, 1, .04, .7, idur-.062, .7       ; AMP ENVELOPE
kdclck    linseg         0, .002, 1, idur-.042, 1, .04, 0                  ; DECLICK
asig      rand           2                                                 ; RANDOM NUMBER

aflt      rezzy          asig, kfenv, irez*40                              ; FILTER

aout1     =              aflt*kaenv*3*iod/iacc                             ; SCALE THE SOUND

krms      rms            aout1, 1000                                       ; LIMITER, GET RMS
klim      table3         krms*.5, 5, 1                                     ; GET LIMITING VALUE
aout      =              aout1*klim*iamp*kdclck/sqrt(iod)*1.3              ; SCALE AGAIN AND OUPUT
     
          outs           aout, aout                                        ; OUTPUT THE SOUND

          endin
