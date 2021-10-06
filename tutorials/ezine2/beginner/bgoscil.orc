;---------------------------------------------------------------
; Beginners Oscillator Demo
; by Hans Mikelson March 1999
;---------------------------------------------------------------
sr = 44100  ; Sample rate
kr = 4410   ; Control rate
ksmps = 10  ; Number of samples per control period
nchnls = 2  ; Number of channels

;---------------------------------------------------------------
; Oscil 1
; Stereo detuned oscilators with vibrato
;---------------------------------------------------------------
           instr   1

idur       =       p3                       ; Duration
iamp       =       p4                       ; Amplitude
ifqc       =       cpspch(p5)               ; Convert pitch to frequency
itable     =       p6                       ; Waveform number
ienv       =       p7                       ; Envelope shape number

klfo       oscil   .01, 6, 1                ; Low frequency oscillator for vibrato

asigl      oscil   iamp, ifqc*0.999*(1+klfo), itable ; Left signal
asigr      oscil   iamp, ifqc*1.001*(1+klfo), itable ; Right signal

kenv       oscili  1, 1/idur, ienv          ; Generate the envelope
           outs    asigl*kenv, asigr*kenv   ; Shape the signal with the envelope before output

           endin

;---------------------------------------------------------------
; Sci Fi 1
;---------------------------------------------------------------
           instr   2

idur       =       p3                       ; Duration
iamp       =       p4                       ; Amplitude
ifqc       =       cpspch(p5)               ; Convert pitch to frequency
itable     =       p6                       ; Waveform number
ienv       =       p7                       ; Envelope shape number

klfo       oscil   .5, 3, 2                 ; Low frequency oscillator for frequency sweep

asigl      oscil   iamp, ifqc*0.998*(1+klfo), itable  ; Left audio signal
asigr      oscil   iamp, ifqc*1.002*(1+klfo), itable  ; Right audio signal

kenv       oscili  1, 1/idur, ienv          ; Generate the envelope
           outs    asigl*kenv, asigr*kenv   ; Shape the signal with the envelope before output

           endin

;---------------------------------------------------------------
; Sci Fi 2
;---------------------------------------------------------------
           instr   3

idur       =       p3                       ; Duration
iamp       =       p4                       ; Amplitude
ifqc       =       cpspch(p5)               ; Convert pitch to frequency
itable     =       p6                       ; Waveform number
ienv       =       p7                       ; Envelope shape number

klfo       oscil   .1, 4, 3                 ; Low frequency oscillator for pitch warble

asigl      oscil   iamp, ifqc*0.998*(1+klfo), itable  ; Left audio signal
asigr      oscil   iamp, ifqc*1.002*(1+klfo), itable  ; Right audio signal

kenv       oscili  1, 1/idur, ienv          ; Generate the envelope
           outs    asigl*kenv, asigr*kenv   ; Shape the signal with the envelope before output

           endin

;---------------------------------------------------------------
; Auto Panning
;---------------------------------------------------------------
           instr   4

idur       =       p3                       ; Duration
iamp       =       p4                       ; Amplitude
ifqc       =       cpspch(p5)               ; Convert pitch to frequency
itable     =       p6                       ; Waveform number
ienv       =       p7                       ; Envelope shape number

klfo       oscil   .2, 8, 2                 ; Low frequency oscillator for pitch sweep
klfo2      oscil   .5, 2, 3                 ; Low frequency oscillator for autopanning

asigl      oscil   iamp, ifqc*0.998*(1+klfo), itable  ; Left audio signal
asigr      oscil   iamp, ifqc*1.002*(1+klfo), itable  ; Right audio signal

kenv       oscili  1, 1/idur, ienv          ; Generate the envelope
           outs    asigl*kenv*(klfo2+.4), asigr*kenv*(.4-klfo2)   ; Shape with the envelope and pan

           endin

