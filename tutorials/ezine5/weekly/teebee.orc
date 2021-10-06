;------------------------------------------------------------
; Not another TB sim...
; coded by Hans Mikelson May 2000
;------------------------------------------------------------
sr     =     44100    ; Sample rate
kr     =     44100    ; Kontrol rate
ksmps  =     1        ; Samples per control period
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
; Teebee Filter
;------------------------------------------------------------
      instr    15

idur  =        p3         ; Duration
iamp  =        p4         ; Amplitude
ifqc  =        cpspch(p5) ; Pitch
ipanl =        sqrt(p6)   ; Pan left
ipanr =        sqrt(1-p6) ; Pan right
iq    =        p7         ; Q
iinfq =        p8         ; Input Fco
ipbnd =        p9         ; Pitch Bend

asqr   init    0
axs    init    0             ; Mass spring starts at zero
avxs   init    0             ; Not moving either

kpbnd  oscil   1, 1/idur, ipbnd

kdclk  linseg  0, .02, 1, idur-.04, 1, .02, 0
kamp   linseg  0, .1*idur, 1, .8*idur, .8, .1*idur, 0
kfco   linseg  4800, .2, 2800, .2, 2800

apls1  buzz    1, ifqc*kpbnd,  sr/2/ifqc/kpbnd, 1     ; Band-limited impulse train
apls2  vdelay  apls1, 500/ifqc/kpbnd, 1000

aflt1 moogvcf  apls1, kfco, .85
aflt2 moogvcf  apls2, kfco, .1

asqr   =       asqr*.9 + aflt1 - aflt2

iks    =       5000                     ; Spring/Mass constant
idmp   =       .98                      ; Damping factor
ih     =       .001                     ; Diff eq step size

ax3    =       iks*axs

aaxs   =       -ax3*ax3*ax3+(apls1-apls2)*10 ; Update acceleration
avxs   =       idmp*avxs+aaxs*ih        ; Update velocity
axs    =       axs+avxs*ih              ; Update X location


aoutl =        (asqr+axs*2000)*kdclk*kamp*iamp/(ifqc^.3)*7
aoutr =        aoutl
      outs     aoutl*ipanl, aoutr*ipanr

      endin
