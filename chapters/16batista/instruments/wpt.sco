;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=              A Wave-Packet Synthesizer              =;
;=         Coded by Pedro A. G. Batista, 1998          =;
;= (based on M.V.Wickerhauser's work with tonebursts)  =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

;signal table
f8 0 512 -7 0 512 0

;filter sequence table
;            512 256 128 64 32 16 8 4 2
f9 0 16 -2    0   0   1   0  0  0 0 0 0  ; try any seq of 0s and 1s

;initialize filter
;         filter (1-5)
i1 0 0       5                       ; try filters 1 to 5

;* * ToneBurst * *
;  str dur  vecsz wavsz 1pos         ; try any 2<=wavsz<=512 (must be pow'of-2)
i3  0   0    512    4     0          ; try 1pos from 0 to wavsz-1

;* * AntiConvolve * *
;  str dur  vectab vecsz seqtab
i4  0   0     8     512    9   

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; Lets hear it:
;  str dur vectab dynrng  frq0 frq1
i5  0  5     8    30000    1    55   ;you gotta find'em in freq
e
