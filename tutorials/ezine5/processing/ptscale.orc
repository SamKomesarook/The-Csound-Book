;---------------------------------------------------------------
; Pitch Shifter Time Stretcher
; by Hans Mikelson March 2000
;---------------------------------------------------------------
sr     =        44100    ; Sample rate
kr     =        4410     ; Control rate
ksmps  =        10       ; Samples per control period
nchnls =        2        ; 2 Channel stereo

;---------------------------------------------------------------
; Pitch and Time Scaling
;---------------------------------------------------------------
       instr    11

idur   =        p3       ; Duration
iamp   =        p4       ; Amplitude
ipshft =        p5       ; Pitch scaling factor
itstr  =        p6       ; Time scaling factor
iaph   =        p7*sr    ; Amplitude of the phasor in seconds converted to samples
itab   =        p8       ; Sample
ismth  =        p9       ; Smoothing factor

ipval  =        (ipshft-1)                ; Setup for pitch shifting
ifph   =        sr/iaph*((itstr-1)/itstr + ipval) ; Frequency for phasor

aphas1 phasor   ifph                      ; Phasor 1
aphas2 phasor   ifph, .5                  ; Phasor 2 shifted by 180 degrees
apos   linseg   0, idur, idur/itstr*sr    ; Scan this many samples of the table.

kdclk1 oscil    1, ifph, 1                ; Declick envelope matches phasor frequency
kdclk2 oscil    1, ifph, 1, .5            ; Another one shifted by 180 degrees

kdclk1 =        (tanh(kdclk1*ismth)+1)*.5 ; Flatten the sine waves and offset
kdclk2 =        (tanh(kdclk2*ismth)+1)*.5 ; Same for other stream


ashft1 table3   iaph*aphas1+apos, itab    ; Scan the table with cubic interpolation
ashft2 table3   iaph*aphas2+apos, itab    ; second stream

aout   =        ashft1*kdclk1 + ashft2*kdclk2 ; Combine the two streams with declicking

       outs     aout*iamp, aout*iamp      ; Output the result

       endin

