;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;
;          A modest denoiser using the FWT           ;
;           Coded by Pedro Batista, 1998             ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;

;initialize filter
;         filter (1-3)
i1 0 0       3


;From here on, ALL instr's must be active
;during the whole performance

;in sound
;  str dur soundin
i2  0  .5    2      ; <--- change soundin.#

;* * ConvolveDecimate * *
;  str dur wavsz
i3  0  .5    2

;* * Denoiser * *
;  str dur sigma
i4  0  .5  18000    ; <--- estimated power

;* * AntiConvolve * *
;  str dur
i5  0  .5

;out sound
;  str dur
i6  0  .5

e
