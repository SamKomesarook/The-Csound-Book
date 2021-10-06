sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 2

;---------------------------------------------------------------
; VCO with Sync
;---------------------------------------------------------------
           instr   12

idur       =       p3           ; Duration
iamp       =       p4           ; Amplitude
ifqc       =       cpspch(p5)   ; Frequency
ifqc2      =       ifqc*p6      ; Frequency of pseudo synched oscillator wrt base frequency

kamp       linseg  0, .002, iamp, idur-.004, iamp, .002, 0   ; Amp envelope

asaw2      init    0

apulse1    buzz    1, ifqc,  sr/4/ifqc, 1   ; Band-limited impulse train, sr/2 sounds bad
apulse2    buzz    1, ifqc2, sr/4/ifqc2, 1  ; so use sr/4. (sr/8 isn't very good either)
                                            ; Seems to leave some wierd sr/4 residue though.

aamp1      oscili  1, ifqc,  3     ; Turn on the gate in sync with the impulses
aamp2      oscili  1, ifqc2, 3
agat2      =       aamp2*(1-aamp1) ; Gate opens for aamp2 but not when aamp1 is open.

; The following big equation is just to prevent two impulses from being added
; at the same time which makes for a big spike in the signal. (1-ifqc/sr) is a
; leaky integrator with the amount of leakage based on ifqc/sr.
; Either apulse1 or apulse2 can reset the signal but they must reset it based on
; the current size of the signal otherwise it is just like adding the signals.

asaw2      =      (apulse1 + apulse2*agat2)*(1-asaw2) + (1-ifqc/sr)*asaw2

aout       =      -asaw2 ; It looks better upside down.
kout       =      aout+1

; The above operations make a curve in what should have been a straight line.
; this fixes it. sqrt was too much.

aout       =       (aout+1)^.7 - .8

           outs    aout*kamp, aout*kamp

           endin

