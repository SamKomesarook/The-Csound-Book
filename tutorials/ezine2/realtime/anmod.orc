;----------------------------------------------
; Real Time Midi Controlled Csound
; by Hans Mikelson  March 1999
; Tested with Maldonado's Csound on a 300 MHz Pentium
; I use the following one line batch file csm.bat:
; csound -+K -+q -b128 -+p4 -+O %1.orc %1.sco
; Called as follows for anmod.orc & anmod.sco:
; csm anmod
;----------------------------------------------
sr=44100
kr=4410
ksmps=10
nchnls=2
gifqc init 440

;-----------------------------------------------------------
; Simple analog saw
;-----------------------------------------------------------
       instr 1

ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc   cpsmidi                            ; Get the note in cps

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope

; Low pass filter frequency
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfco   tablei   kfce*kfcs, 2              ; Change scaling form 0-127 to 20-20000

; Low pass filter resonance
krzs   midictrl 56, 20                    ; Q controller
krez   =        krzs*.01                  ; Adjust 0-127 to 0-1.27

;             Amp Fqc   Wave PW   Sine Delay
asig   vco     1, ifqc, 1,   1,   1,   .1     ; Oscillator 1
aout   moogvcf asig, kfco,   krez               ; Filter 1

       outs    aout*kamp, aout*kamp            ; Output

       endin

;-----------------------------------------------------------
; Chorus sweep saw pad
;-----------------------------------------------------------
       instr 2

iwave  =        1                         ; Sine
ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to Amp
ifqc   cpsmidi                            ; Get the note in cps
irtfq  =        sqrt(ifqc)                ; sqrt(frequency)
iofqc  =        1/ifqc                    ; 1/frequency
ifqcl  =        ifqc*.998                 ; Stereo detuning for left oscillator
ifqcr  =        ifqc*1.002                ; Stereo detuning for right oscillator

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .2,  .2, .2      ; Declick envelope

klfo2  oscil    .2, .5, 1                 ; Low frequency sweep
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfc2   tablei   kfce*kfcs*(1+klfo2), 2    ; Change scaling form 0-127 to 20-20000
kfc3   =        kfce*kfc2*irtfq           ; Sweep frequency and avoid stepping
kfc4   =        (kfc3 <= 10000) ? kfc3 : 10000
kfco   port     kfc4, .01

krzs   midictrl 56                        ; Q controller
krezm  =        krzs*.01                  ; Adjust 0-127 to 0-1.27

kmw    midictrl 1                         ; Modwheel
klfo1  oscil    kmw*.0001, 6, 1
kvbr   =        1+klfo1

asig2  vco     1, ifqcl*kvbr*1.01, 1,    1,   1,   iofqc  ; Oscillator 1

;             Amp Fqc              Wave  PW   Sine Delay
asigl  vco     1, ifqcl*kvbr, 1,    1,   1,   iofqc  ; Oscillator 1
aoutl  moogvcf asigl+asig2, kfco, krezm              ; Filter 1

asigr vco      1,  ifqcr*kvbr, 1,   1,   1,   iofqc ; Oscillator 2
aoutr  moogvcf asigr-asig2, kfco, krezm              ; Filter 2

       outs    aoutl*kamp, aoutr*kamp          ; Output

       endin

;-----------------------------------------------------------
; Pulse width modulation with portamento
;-----------------------------------------------------------
       instr 3

iwave  =        1                         ; Sine
iamp   veloc                              ; Velocity
iamp   =        iamp*200+10000            ; Convert to Amp
ifqco  init     gifqc
ifqc   cpsmidi                            ; Get the note in cps
gifqc  =        ifqc
idfqc  =        abs(ifqco-ifqc)
kfqc   linseg   ifqco, .001*idfqc+.01, ifqc, .1, ifqc ; Linear pitch portamento

krtfq  =        sqrt(kfqc)                ; sqrt(frequency)
kofqc  =        1/kfqc                    ; 1/frequency
kfqcl  =        kfqc*.999                 ; Stereo detuning for left oscillator
kfqcr  =        kfqc*1.001                ; Stereo detuning for right oscillator

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfc2   =        exp(kfcs*.05)             ; Exponential controller
krzs   midictrl 56, 20                    ; Q controller
krezm  =        krzs*.01                  ; Adjust 0-127 to 0-1.27

kfco   port     kfce*kfc2*krtfq,.01  ; Sweep frequency and avoid stepping

klfo1  oscil    .4, kfqc*.005, 1
kpw    =        1+klfo1

;             Amp Fqc    Wave PW   Sine Delay
asigl  vco     1, kfqcl, 2,   kpw, 1,   .1     ; Oscillator 1
aoutl  moogvcf asigl, kfco, krezm              ; Filter 1

asigr  vco     1,  kfqcr, 2,   kpw, 1,   .1    ; Oscillator 2
aoutr  moogvcf asigr, kfco, krezm              ; Filter 2

       outs    aoutl*kamp, aoutr*kamp          ; Output

       endin

;-----------------------------------------------------------
; Simple analog square with rezzy
;-----------------------------------------------------------
       instr 4

ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc   cpsmidi                            ; Get the note in cps

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope

; Low pass filter frequency
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfco   tablei   kfce*kfcs, 2              ; Change scaling form 0-127 to 20-20000

; Low pass filter resonance
krez   midictrl 56                        ; Q controller

; Mod wheel vibrato
kmw    midictrl 1                         ; Modwheel
klfo1  oscil    kmw*.0002, 6, 1
kvbr   =        1+klfo1

;             Amp   Fqc        Wave PW   Sine Delay
asig   vco    1,    ifqc*kvbr, 2,   1,   1,   .1    ; Oscillator 1
aout   rezzy  asig, kfco,  krez                 ; Filter 1

       outs    aout*kamp, aout*kamp             ; Output

       endin

;-----------------------------------------------------------
; Simple analog saw
;-----------------------------------------------------------
       instr 5

; Get note velocity and pitch
ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc   cpsmidi                            ; Get the note in cps

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope

; Low pass filter frequency
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfco   tablei   kfce*kfcs, 2              ; Change scaling form 0-127 to 20-20000

; Low pass filter resonance
krez   midictrl 56                        ; Q controller

; Mod wheel vibrato
kmw    midictrl 1                         ; Modwheel
klfo1  oscil    kmw*.0002, 6, 1
kvbr   =        1+klfo1

;             Amp   Fqc        Wave PW   Sine Delay
asig   vco    1,    ifqc*kvbr, 1,   1,   1,   .1    ; Oscillator 1
aout   rezzy  asig, kfco,  krez, 1              ; Filter 1

       outs    aout*kamp, aout*kamp             ; Output

       endin

;-----------------------------------------------------------
; Simple analog saw with pareq
;-----------------------------------------------------------
       instr 6

; Get note velocity and pitch
ivel   veloc                              ; Velocity
iamp   tablei   ivel, 3                   ; Convert to amplitude
ifqc   cpsmidi                            ; Get the note in cps

;               Amp   Rise, Dec, AtDec
kamp   linenr   iamp, .05,  .05, .05      ; Declick envelope

; Low pass filter frequency
kfce   expseg   .2, .1, 1, .2, .8, .1, .8 ; Fco envelope
kfcs   midictrl 50, 10                    ; Fco controller
kfco   tablei   kfce*kfcs, 2              ; Change scaling form 0-127 to 20-20000

; Low pass filter resonance
krzs   midictrl 56                        ; Q controller
krez   =        krzs*.1

; Mod wheel vibrato
kmw    midictrl 1                         ; Modwheel
klfo1  oscil    kmw*.0002, 6, 1
kvbr   =        1+klfo1

;             Amp   Fqc        Wave PW   Sine Delay
asig   vco    1,    ifqc*kvbr, 1,   1,   1,   .1    ; Oscillator 1
aout   pareq  asig, kfco, .01, krez, 2              ; High shelf

       outs    aout*kamp*.5, aout*kamp*.5           ; Output

       endin


