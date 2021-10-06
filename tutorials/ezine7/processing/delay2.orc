;------------------------------------------------------------------------------
; A Variety of Delay Examples
; Coded by Hans Mikelson Februrary 2000
;------------------------------------------------------------------------------
sr      =       44100    ; Sample rate
kr      =       4410
ksmps   =       10
nchnls  =       2
        zakinit 50, 50

;------------------------------------------------------------------------------
; Plucked instrument
;------------------------------------------------------------------------------
        instr   1

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
ifqc    =       cpspch(p5)                         ; Pitch
ioutch  =       p6                                 ; Output channel
ipanl   =       sqrt(p7)                           ; Pan left
ipanr   =       sqrt(1-p7)                         ; Pan right

aamp    linseg  0, .002, 1, idur-.004, 1, .002, 0  ; Declick envelope

asig    pluck   iamp, ifqc, ifqc, 0, 1             ; Generate a plucked tone

aout    =       asig*aamp
        outs    aout*ipanl, aout*ipanr             ; Output stereo
        zawm    aout, ioutch                       ; Mix to the Zak channel

        endin

;------------------------------------------------------------------------------
; Plucked instrument with stereo delay
;------------------------------------------------------------------------------
        instr   2

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
ifqc    =       cpspch(p5)                         ; Pitch
ioutch  =       p6                                 ; Output channel
istdel  =       p7                                 ; Stereo delay

aamp    linseg  0, .002, 1, idur-.004, 1, .002, 0  ; Declick envelope

asig    pluck   iamp, ifqc, ifqc, 0, 1             ; Generate a plucked tone

aout    =       asig*aamp
adel    delay   aout, istdel                       ; Delay 30 msec.
        outs    aout, adel*aamp                    ; Output stereo

        endin

;------------------------------------------------------------------------------
; Sample instrument
;------------------------------------------------------------------------------
        instr   3

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
ioutch  =       p5                                 ; Output channel
ipanl   =       sqrt(p6)                           ; Pan left
ipanr   =       sqrt(1-p6)                         ; Pan right
ioffs   =       p8                                 ; Sample offset

; Declick envelope
kamp    linseg  0, .002, 1, idur-.006, 1, .002, 0, .002, 0

asig    diskin  p7, 1, ioffs                       ; Read sample

aout    =       asig*kamp
        outs    aout*ipanl, aout*ipanr             ; Output stereo
        zawm    aout, ioutch                       ; Mix to the Zak channel

        endin

;------------------------------------------------------------------------------
; Simple delay
;------------------------------------------------------------------------------
        instr   10

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itime   =       p5                                 ; Delay time
iinch   =       p6                                 ; Input channel

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asig    zar     iinch                              ; Read from the zak channel
adel    delay   asig, itime                        ; Delay the signal
        outs    adel*aamp, adel*aamp               ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Simple Delay with feedback
;------------------------------------------------------------------------------
        instr   11

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itime   =       p5                                 ; Delay time
ifdbk   =       p6                                 ; Feedback amount
iinch   =       p7                                 ; Input channel
adel    init    0                                  ; Initialize adel to zero

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asig    zar     iinch                              ; Read from the zak channel
adel    delay   asig + adel*ifdbk, itime           ; Delay the signal
        outs    adel*aamp, adel*aamp               ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Multitap delay
;------------------------------------------------------------------------------
        instr   13

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itime   =       p5                                 ; Delay time
iinch   =       p6                                 ; Input channel
itabt   =       p7                                 ; Deltap time table
itabv   =       p8                                 ; Deltap volume table

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asig    zar     iinch                              ; Read from the zak channel

atmp    delayr  itime                              ; Read the delay line

it0     table   0, itabt                           ; Delay time 0
it1     table   1, itabt                           ; Delay time 1
it2     table   2, itabt                           ; Delay time 2
it3     table   3, itabt                           ; Delay time 3
it4     table   4, itabt                           ; Delay time 4
it5     table   5, itabt                           ; Delay time 5
it6     table   6, itabt                           ; Delay time 6
it7     table   7, itabt                           ; Delay time 7

iv0     table   0, itabv                           ; Delay 0 volume
iv1     table   1, itabv                           ; Delay 1 volume
iv2     table   2, itabv                           ; Delay 2 volume
iv3     table   3, itabv                           ; Delay 3 volume
iv4     table   4, itabv                           ; Delay 4 volume
iv5     table   5, itabv                           ; Delay 5 volume
iv6     table   6, itabv                           ; Delay 6 volume
iv7     table   7, itabv                           ; Delay 7 volume

at0     deltap  it0                                ; Delay tap 0
at1     deltap  it1                                ; Delay tap 1
at2     deltap  it2                                ; Delay tap 2
at3     deltap  it3                                ; Delay tap 3
at4     deltap  it4                                ; Delay tap 4
at5     deltap  it5                                ; Delay tap 5
at6     deltap  it6                                ; Delay tap 6
at7     deltap  it7                                ; Delay tap 7

        delayw  asig*aamp                          ; Write to the delay line

; Add up the delays and scale by the volumes
adel    =       at0*iv0+at1*iv1+at2*iv2+at3*iv3+at4*iv4+at5*iv5+at6*iv6+at7*iv7

        outs    adel*aamp, adel*aamp               ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Stereo delay with feedback
;------------------------------------------------------------------------------
        instr   14

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
itimr   =       p7                                 ; Right delay time
ifdbkr  =       p8                                 ; Right feedback
inchl   =       p9                                 ; Left input
inchr   =       p10                                ; Right input

adell   init    0                                  ; Initialize adel to zero
adelr   init    0                                  ; Initialize adel to zero

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

adell   delay   asigl + adell*ifdbkl, itiml        ; Delay the signal
adelr   delay   asigr + adelr*ifdbkr, itimr        ; Delay the signal

        outs    adell*aamp, adelr*aamp             ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback
;------------------------------------------------------------------------------
        instr   15

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback 
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input

adell   init    0                                  ; Initialize adel to zero
adelr   init    0                                  ; Initialize adel to zero

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

asavl   =       adell                              ; Save the left delay for cross feedback
adell   delay   asigl + adell*ifdbkl + adelr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr + adelr*ifdbkr + asavl*ixfbr, itimr  ; Delay the signal

        outs    adell*aamp, adelr*aamp             ; Output the delayed signal

        endin


;------------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback & lp-filter
;------------------------------------------------------------------------------
        instr   16

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input
ifco    =       p13                                ; Filter cut off

afltl   init    0                                  ; Initialize adel to zero
afltr   init    0                                  ; Initialize adel to zero

kamp    linseg  0, .002, iamp, idur-.006, iamp, .002, 0, .002, 0  ; Declick envelope

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

adell   delay   asigl + afltl*ifdbkl + afltr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr + afltr*ifdbkr + afltl*ixfbr, itimr  ; Delay the signal

afltl   butterlp adell, ifco
afltr   butterlp adelr, ifco

        outs    afltl*kamp, afltr*kamp             ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback & hp-filter
;------------------------------------------------------------------------------
        instr   17

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input
ifco    =       p13                                ; Filter cut off

afltl   init    0                                  ; Initialize adel to zero
afltr   init    0                                  ; Initialize adel to zero

kampin  linseg  0, .002, 1, idur-.002, 1           ; Declick in
kampout linseg  iamp, idur-.004, iamp, .002, 0, .002, 0  ; Declick out

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

adell   delay   asigl*kampin + afltl*ifdbkl + afltr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr*kampin + afltr*ifdbkr + afltl*ixfbr, itimr  ; Delay the signal

afltl   butterhp adell, ifco
afltr   butterhp adelr, ifco

        outs    afltl*kampout, afltr*kampout             ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback & distortion
;------------------------------------------------------------------------------
        instr   18

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input
iodrv   =       p13                                ; Filter cut off

adstl   init    0                                  ; Initialize adel to zero
adstr   init    0                                  ; Initialize adel to zero

kampin  linseg  0, .002, 1, idur-.002, 1           ; Declick in
kampout linseg  iamp, idur-.004, iamp, .002, 0, .002, 0  ; Declick out

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

adell   delay   asigl*kampin + adstl*ifdbkl + adstr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr*kampin + adstr*ifdbkr + adstl*ixfbr, itimr  ; Delay the signal

adstl   distort1 adell, iodrv, .25
adstr   distort1 adelr, iodrv, .25

        outs    adstl*kampout, adstr*kampout       ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Clear Zak
;------------------------------------------------------------------------------
         instr   99
         zacl    0, 50                             ; Clear the audio channels
         zkcl    0, 50                             ; Clear the control channels
         endin
