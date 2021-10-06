;---------------------------------------------------------
; Runge-Kutta Mass Spring Stimulated by an oscillator
; Coded by Hans Mikelson April, 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        44100                      ; Kontrol rate
ksmps   =        1                          ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Mass Spring with Oscil (RK)
;---------------------------------------------------------
       instr     4

idur   =         p3            ; Duration
iamp   =         p4*4          ; Amplitude
iks    =         p5            ; Spring/Mass constant
idmp   =         p6            ; Damping factor
ih     =         p7            ; Diff eq step size
ipanl  =         sqrt(p8)      ; Pan left
ipanr  =         sqrt(1-p8)    ; Pan right
ifqc   =         cpspch(p9)    ; Pitch to frequency

axs    init      0             ; Mass spring starts at zero
avxs   init      0             ; Not moving either

kdclck linseg    0, .02, 1, idur-.04, 1, .02, 0 ; Declick envelope

;arnd   rand      2, .5, 1          ; Generate noise
asin    oscil     1, ifqc, 1        ; Sine wave

;aaxs   =         -iks*axs+asin     ; Update acceleration (Euler's)
; R-K Acceleration
aak1   =         ih*(-iks*axs+asin)
aak2   =         ih*(-iks*(axs+.5*aak1)+asin)
aak3   =         ih*(-iks*(axs+.5*aak2)+asin)
aak4   =         ih*(-iks*(axs+aak3)+asin)
aaxs   =         (aak1+2*aak2+2*aak3+aak4)/6

;avxs   =         idmp*avxs+aaxs*ih       ; Update velocity (Euler's)
; R-K Velocity
avk1   =         ih*aaxs
avk2   =         ih*(aaxs+.5*avk1)
avk3   =         ih*(aaxs+.5*avk2)
avk4   =         ih*(aaxs+avk3)
avxs   =         idmp*avxs+(avk1+2*avk2+2*avk3+avk4)/6

axs    =         axs+avxs                ; Update X location

aout   =         axs*iamp*kdclck*10     ; Apply amp envelope and declick

       outs      aout*ipanl, aout*ipanr  ; Output the sound

       endin
