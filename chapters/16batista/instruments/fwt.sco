;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=           A Wavelet Transform Instrument            =;
;=         Coded by Pedro A. G. Batista, 1998          =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

;signal table
f10 0 512 -7 0 512 0

;initialize filter
;         filter (1-3)
i1 0 0       1

;in sound
;        vectab   soundin.#
i2 0 .5    10         1

;* * ConvolveDecimate * *
;  str dur  vectab vecsz wavsz
i3  0   .5    10    512    2

;* * AntiConvolve * *
;  str dur  vectab vecsz
i5  0   .5    10    512

;out sound
;       vectab
i6 0 .5   10

e
