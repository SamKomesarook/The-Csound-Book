;---------------------------------------------------------
; Mass Spring Model
; Coded by Hans Mikelson April, 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        44100                      ; Kontrol rate
ksmps   =        1                          ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Mass Spring with Noise
;---------------------------------------------------------
       instr     1

idur   =         p3            ; Duration
iamp   =         p4            ; Amplitude
iks    =         p5            ; Spring/Mass constant
idmp   =         p6            ; Damping factor
ih     =         p7            ; Diff eq step size

axs    init      0             ; Mass spring starts at zero
avxs   init      0             ; Not moving either

kdclck linseg    0, .02, 1, idur-.04, 1, .02, 0 ; Declick envelope

arnd   rand      2, .5, 1          ; Generate noise

aaxs   =         -iks*axs+(arnd-1) ; Update acceleration
avxs   =         idmp*avxs+aaxs*ih       ; Update velocity
axs    =         axs+avxs*ih             ; Update X location

aout   =         axs*iamp*kdclck*10      ; Apply amp envelope and declick

       outs      aout, aout              ; Output the sound

       endin
