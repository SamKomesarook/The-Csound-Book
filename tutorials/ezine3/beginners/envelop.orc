;---------------------------------------------------------
; Simple Envelopes
; Coded by Hans Mikelson June 25, 1999
;---------------------------------------------------------

sr     =      44100              ; Sample rate
kr     =      4410               ; Control rate
ksmps  =      10                 ; Sample in each control period
nchnls =      2                  ; Number of output channels

;---------------------------------------------------------
; Amplitude envelope example
;---------------------------------------------------------
       instr  1

idur   =      p3               ; Duration
iamp   =      p4               ; Amplitude
ifqc   =      cpspch(p5)       ; Convert pitch to frequency
itable =      p6               ; Waveform table
iatt   =      p7               ; Attack time
idec   =      p8               ; Decay time
isus   =      p9               ; Sustain level
irel   =      p10              ; Release time

; The following code defines the amplitude envelope
aenv   linseg 0, iatt, 1, idec, isus, idur-iatt-idec-irel, isus, irel, 0

asig   oscil  aenv*iamp, ifqc, itable ; Generate the audio signal

       outs   asig, asig         ; Output the result

       endin

;---------------------------------------------------------
; Amplitude envelope example
;---------------------------------------------------------
         instr  2

idur     =      p3               ; Duration
iamp     =      p4               ; Amplitude
ifqc     =      cpspch(p5)       ; Convert pitch to frequency
itable   =      p6               ; Waveform table
iattack  =      p7               ; Attack time
idecay   =      p8               ; Decay time
isustain =      p9               ; Sustain level
irelease =      p10              ; Release time

p3       =      p3 + irelease    ; The p3 time is extended by the release time so that the release will
                                 ; take place after the note has ended.

; The following code defines the amplitude envelope
aenv     linseg 0, iattack, iamp, idecay, isustain*iamp, idur-iattack-idecay, isustain*iamp, irelease, 0
adeclick linseg 0, .002, 1, idur-.004, 1, .002, 0

asig   oscil    aenv, ifqc, itable ; Generate the audio signal

       outs     asig*adeclick, asig*adeclick  ; Output the result

       endin

;---------------------------------------------------------
; Pitch envelope example
;---------------------------------------------------------
         instr  3

idur     =      p3               ; Duration
iamp     =      p4               ; Amplitude
ifqc     =      cpspch(p5)       ; Convert pitch to frequency
itable   =      p6               ; Waveform table

; The following code defines the amplitude envelope
adeclick linseg 0, .002, 1, idur-.004, 1, .002, 0

afqc   expseg   100, .1, ifqc, idur-.2, ifqc, .1, 200

asig   oscil    iamp, afqc, itable ; Generate the audio signal

       outs     asig*adeclick, asig*adeclick  ; Output the result

       endin

;---------------------------------------------------------
; Fco envelope example
;---------------------------------------------------------
         instr  4

idur     =      p3               ; Duration
iamp     =      p4               ; Amplitude
ifqc     =      cpspch(p5)       ; Convert pitch to frequency
itable   =      p6               ; Waveform table

; The following code defines the amplitude envelope
adeclick linseg 0, .002, 1, idur-.004, 1, .002, 0

kfco   expseg   400, .1, 2000, .2, 1500, idur-.4, 1000, .1, 400 ; Filter cut off frequency

asig   oscil    iamp, ifqc, itable ; Generate the audio signal
aflt   rezzy    asig, kfco, 10

       outs     aflt*adeclick, aflt*adeclick  ; Output the result

       endin
