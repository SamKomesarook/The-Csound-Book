;----------------------------------------------
; Real Time Midi Controlled Csound
; by Hans Mikelson  March 1999
; Tested with Maldonado's Csound on a 300 MHz Pentium
; I use the following one line batch file csm.bat:
; csound -+K2 -+q -b128 -+p4 -+O %1.orc %1.sco
; Called as follows for rterrain.orc & rterrain.sco:
; csm anmod
;----------------------------------------------
sr=44100
kr=4410
ksmps=10
nchnls=2

;-----------------------------------------------------------
; Terrain instrument
;-----------------------------------------------------------
       instr 1

ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc1  cpsmidi                            ; Get the note in cps
ifqc   =        ifqc1*.25                 ; Lower it 2 octaves
ipetl  init     1.30                      ; Number of petals on
ipetr  init     1.32                      ; the rose curve

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope

; Low pass filter frequency
kfce   mxadsr   .02, .1, .5, .2           ; Accent envelope
kfco   =        (.2+kfce)*ivel*.05         ; Add an offset and scale

arosl  oscil kfco, ipetl*ifqc, 1          ; Rose Curve
axl    oscil arosl, ifqc, 1               ; Convert from polar to
ayl    oscil arosl, ifqc, 1, .25          ; rectangular coordinates

azl    =     sin(sqrt(axl*axl+ayl*ayl))   ; Compute a bumpy 3D surface
aoutl  =     azl*azl-.5                   ; Remove some DC offset

arosr  oscil kfco, ipetr*ifqc, 1          ; Rose Curve
axr    oscil arosr, ifqc, 1               ; Convert from polar to
ayr    oscil arosr, ifqc, 1, .25          ; rectangular coordinates

azr    =     sin(sqrt(axr*axr+ayr*ayr))   ; Compute a bumpy 3D surface
aoutr  =     azr*azr-.5                   ; Remove some DC offset

       outs    aoutl*kamp, aoutr*kamp     ; Output

       endin




