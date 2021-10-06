;----------------------------------------------
; Real Time Midi Controlled Csound
; by Hans Mikelson  February 2000
; Tested with Maldonado's Csound on a 300 MHz Pentium
; I use the following one line batch file csm.bat:
; csound -+K2 -+q -b128 -+p4 -+O %1.orc %1.sco
; Called as follows for rtbirds.orc & rtbirds.sco:
; csm rtbirds
;----------------------------------------------
sr       =        44100
kr       =        4410
ksmps    =        10
nchnls   =        2

;-----------------------------------------------------------
; Birdsong instrument
;-----------------------------------------------------------
         instr    1

ivel     veloc                              ; Velocity
iamp     tablei   ivel, 3                   ; Convert to amplitude
ifqc1    cpsmidi                            ; Get the note in cps
ifqc     =        ifqc1*4

;                 Amp   Rise, Dec, AtDec
kamp     linenr   iamp, .05,  .05, .05     ; Declick envelope

imstrt   midictrl 50, 0, 50               ; Mod start
imend    midictrl 56, 0, 50               ; Mod end
imdur    midictrl 52, 0, 2                ; Mod duration
ipan     =        rnd(1)                  ; Random panning
kmdpth   midictrl 21, 0, 1                ; Mod depth

; Ramp from the start rate to the end rate
kmrate   linseg   imstrt, imdur, imend, imdur, imend

kamod    oscil    kmdpth, kmrate, 1 ; Amplitude modulation oscillator
kfmod    oscil    kmdpth, kmrate, 1 ; Frequency modulation oscillator

aout     oscil    1-kamod, (1+kfmod)*ifqc, 1 ; Birdcall sound

         outs     aout*kamp*sqrt(ipan), aout*kamp*sqrt(1-ipan) ; Output

         endin




