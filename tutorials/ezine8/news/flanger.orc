;---------------------------------------------------------------
; Flanger
; by Hans Mikelson June 2000
;---------------------------------------------------------------
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

;---------------------------------------------------------------
; Simple Flanger 1
;---------------------------------------------------------------
           instr   10

idur     =       p3
iamp     =       p4
idpth    =       p5
irate    =       p6
ifdbk    =       p7
ioffst   =       .1

adel2    init    0

kdclk    linseg  0, .002, 1, idur-.004, 1, .002, 0

asig     rand    iamp

alfo1    oscil   idpth, irate, 1
alfo2    oscil   idpth, irate*.5, 1, .5

adel1    vdelay3 asig, alfo1+idpth+ioffst, (idpth+ioffst)*2
adel2    vdelay3 adel1-adel2*ifdbk, alfo2+idpth+ioffst, (idpth+ioffst)*2

aout     =       adel2

         outs    kdclk*aout, kdclk*aout

        endin

;---------------------------------------------------------------
; Simple Flanger 2
;---------------------------------------------------------------
           instr   11

idur     =       p3
iamp     =       p4
idpth    =       p5
irate    =       p6
ifdbk    =       p7
ioffst   =       .1

adel2    init    0

kdclk    linseg  0, .002, 1, idur-.004, 1, .002, 0

asig     rand    iamp

alfo1    oscil   idpth, irate, 1

adel1    delay   asig, (idpth+ioffst)/1000
adel2    vdelay3 adel1+adel2*ifdbk, alfo1+idpth+ioffst, (idpth+ioffst)*2

aout     =       adel2

         outs    kdclk*aout, kdclk*aout

        endin

;---------------------------------------------------------------
; Simple Flanger 3
;---------------------------------------------------------------
         instr   12

idur     =       p3             ; Duration
iamp     =       p4             ; Amplitude
idpth    =       p5             ; Depth
irate    =       p6             ; Rate
ifdbk    =       p7             ; Feedback
iphas    =       p8             ; L-R Phase difference
imin     =       .1             ; Minimum delay time

ioffst   =       imin + idpth   ; Offset

aoutl    init    0              ; Need to initialize these
aoutr    init    0              ; for the feedback path.

kdclk    linseg  0, .002, 1, idur-.004, 1, .002, 0 ; Declick

asig     rand    iamp           ; Just a simple random number

alfol    oscil   idpth, irate, 1        ; Left LFO
alfor    oscil   idpth, irate, 1, iphas ; Right LFO

adel     delay   asig, ioffst/1000      ; Delay the original signal

adell    vdelay3 asig+aoutl*ifdbk, alfol+ioffst, ioffst*2 ; Delay left
adelr    vdelay3 asig+aoutr*ifdbk, alfor+ioffst, ioffst*2 ; Delay right

aoutl    =       adel + adell
aoutr    =       adel + adelr

         outs    kdclk*adell*.5, kdclk*adelr*.5 ; Generate the sound

         endin


