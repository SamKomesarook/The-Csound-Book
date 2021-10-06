;----------------------------------------------
; Real Time Midi Controlled Csound
; by Hans Mikelson  July 1999
; Tested with Maldonado's Csound on a 300 MHz Pentium
; I use the following one line batch file csm.bat:
; csound -+K -+q -b128 -+p4 -+O %1.orc %1.sco
; Called as follows for fofrt.orc & fofrt.sco:
; csm anmod
;----------------------------------------------
sr=44100
kr=4410
ksmps=10
nchnls=2
gifqc init 440
gasigl init 0
gasigr init 0

;-----------------------------------------------------------
; Simple fof sound
;-----------------------------------------------------------
       instr 1

ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc   cpsmidi                            ; Get the note in cps

;           Amp   Rise, Dec, AtDec
kamp linenr iamp, .05,  .05, .05       ; Declick envelope
kven linseg 0, .2, 0, .1, .02, .1, .02 ; Vibrato ramp
kvbr oscil  kven, 6, 1                 ; Vibrato LFO

kfqcl =      (kvbr+1)*ifqc             ; Calculate vibrato

; Generate three different formants
;          Amp  Fund   Form  Oct Band Rise  Dur1  Dec   OvrLps  FnA FnB Dur2
a1l  fof   .16, kfqcl, 564,  0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1
a2l  fof   .08, kfqcl, 1156, 0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1
a3l  fof   .06, kfqcl, 2552, 0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1

aoutl butterlp  a1l+a2l+a3l, 5000            ; Lowpass filter

     outs  aoutl*kamp, aoutl*kamp            ; Output

     endin

