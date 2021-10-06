;------------------------------------------------------------
; Analog sounding filters
; coded by Hans Mikelson May 2000
;------------------------------------------------------------
sr     =     44100    ; Sample rate
kr     =     4410     ; Kontrol rate
ksmps  =     10       ; Samples per control period
nchnls =     2        ; Normal stereo
       zakinit 50, 50 ; Initialize zak

;------------------------------------------------------------
; Envelope (Knob twisting simulation)
;------------------------------------------------------------
       instr  1

idur   =      p3         ; Duration
iamp   =      p4         ; Amplitude
ilps   =      p5         ; Loops
iofst  =      p6         ; Offset
itabl  =      p7         ; Table
ioutch =      p8         ; Output channel

kout   oscili iamp, ilps/idur, itabl  ; Create the envelope
       zkw    kout+iofst, ioutch      ; Send out to the zak channel

      endin

;------------------------------------------------------------
; Analog sounding filter?
;------------------------------------------------------------
      instr  14

idur  =      p3         ; Duration
iamp  =      p4         ; Amplitude
ifqc  =      cpspch(p5) ; Pitch
ipanl =      sqrt(p6)   ; Pan left
ipanr =      sqrt(1-p6) ; Pan right
iq    =      p7         ; Q
iq2   =      1-p7       ; BW
iq3   =      iq*iq
iinfq =      p8         ; Input Fco
iotf  =      p9         ; Overtone frequency table
iota  =      p10        ; Overtone amplitude table
iotbw =      p11        ; Overtone bandwidth table
iwave =      p12        ; Waveform

; Declick and cut-off frequency envelopes
kdclk  linseg 0, .002, 1, idur-.004, 1, .002, 0
kfcoe  linseg .5, .1*idur, 1, .2*idur, .7, .6*idur, .6, .1*idur, .5

; Get the frequency sweep from the zak channel
kfcoi  zkr    iinfq

iotf1  table  0, iotf    ; Get main filter frequency
iotf2  table  1, iotf    ; Get overtone 1 frequency
iotf3  table  2, iotf    ; Get overtone 2 frequency
iotf4  table  3, iotf    ; Get overtone 3 frequency

iota1  table  1, iota    ; Get main filter amplitude
iota2  table  1, iota    ; Get overtone 1 amplitude
iota3  table  2, iota    ; Get overtone 2 amplitude
iota4  table  3, iota    ; Get overtone 3 amplitude

iotb1  table  1, iotbw   ; Get main filter bandwidth
iotb2  table  1, iotbw   ; Get overtone 1 bandwidth
iotb3  table  2, iotbw   ; Get overtone 2 bandwidth
iotb4  table  3, iotbw   ; Get overtone 3 bandwidth

; Adjust the cut-off based on the sweep and the envelope
kfco1  =       kfcoe*iotf1*kfcoi
kfco2  =       kfcoe*iotf2*kfcoi
kfco3  =       kfcoe*iotf3*kfcoi
kfco4  =       kfcoe*iotf4*kfcoi

; Generate stereo detuned analog waveforms
asql   vco     1, ifqc*1.005, iwave, 1, 1, 1
asqr   vco     1, ifqc*0.995, iwave, 1, 1, 1

aflt1l moogvcf asql, kfco1, iq  ; Basic filter is done with moogvcf
aflt1r moogvcf asqr, kfco1, iq

if (kfco2>sr/2) kgoto next3     ; If it is greater than Nyquist branch around
  aflt2l butbp   asql*iq3, kfco2, kfco2^iq2*iotb2 ; Bandpass for each side
  aflt2r butbp   asqr*iq3, kfco2, kfco2^iq2*iotb2 ; Use q3 to fade out as q->0
  aflt2l butlp   aflt2l, kfco2                    ; This is probably overkill
  aflt2r butlp   aflt2r, kfco2                    ; but I am using it to take out
  aoutl  =       aflt1l*iota1+aflt2l*iota2        ; some the highs when the bw is large.
  aoutr  =       aflt1r*iota1+aflt2r*iota2        ; Add it on to the current signal

; The same thing for the next overtone
if (kfco3>sr/2) kgoto next3
  aflt3l butbp   asql*iq3, kfco3, kfco3^iq2*iotb3
  aflt3r butbp   asqr*iq3, kfco3, kfco3^iq2*iotb3
  aflt3l butlp   aflt3l, kfco3
  aflt3r butlp   aflt3r, kfco3
  aoutl  =       aoutl+aflt3l*iota3
  aoutr  =       aoutr+aflt3r*iota3

; And finally the last overtone
if (kfco4>sr/2) kgoto next3
  aflt4l butbp   asql*iq3, kfco4, kfco4^iq2*iotb4
  aflt4r butbp   asqr*iq3, kfco4, kfco4^iq2*iotb4
  aflt4l butlp   aflt4l, kfco4
  aflt4r butlp   aflt4r, kfco4
  aoutl  =       aoutl+aflt4l*iota4
  aoutr  =       aoutr+aflt4r*iota4

next3:

aoutl =      aoutl*kdclk*iamp           ; That's all folks
aoutr =      aoutr*kdclk*iamp           ; Declick and pan.
      outs   aoutl*ipanl, aoutr*ipanr

      endin

