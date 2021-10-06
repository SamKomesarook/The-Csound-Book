;------------------------------------------------------------
; Bouncing ball simulation
; coded by Hans Mikelson May 2000
;------------------------------------------------------------
sr     =     44100   ; Sample rate
kr     =     4410    ; Kontrol rate
ksmps  =     10      ; Samples per control period
nchnls =     2       ; Normal stereo

;------------------------------------------------------------
; Boing-boing-boing
;------------------------------------------------------------
      instr  1

idur  =      p3         ; Duration
iamp  =      p4         ; Amplitude
ifqc  =      p5         ; Frequency
iq    =      p6         ; Resonance
ipanl =      sqrt(p7)   ; Pan left
ipanr =      sqrt(1-p7) ; Pan right

kamp  expseg .0001, .002, 1, idur*.1, .0001, idur*.9, .0001 ; Impulse
kdclk linseg 0, .002, 1, idur-.004, 1, .002, 0              ; Declick
kfqc  expseg ifqc, idur, ifqc*(1/(1+iamp/1000))             ; Boing

ar1   rand     kamp                              ; Generate a noise pulse
aflt  moogvcf  ar1*10, kfqc, iq                  ; Filter it

      outs     aflt*iamp*kdclk*ipanl, aflt*iamp*kdclk*ipanr  ; Scale and output

      endin

