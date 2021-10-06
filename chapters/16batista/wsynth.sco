;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=              A Wave-Packet Synthesizer              =;
;=         Coded by Pedro A. G. Batista, 1998          =;
;= (based on M.V.Wickerhauser's work with tonebursts)  =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

;signal table
f10 0 8192 -7 0 8192 0

;filter control
;   str  dur  filter (1-5)
i1   0    0     1
i1   1    0     5
i1   3    0     3
i1   4    0     5
i1   5    0     1
i1   6    0     5
i1   7    0     1

;filter sequence table
;        4096 2048 1024 512 256 128 64 32 16 8 4 2
i2 0 2    0    1    0    0   0   0  0  0  0  0 0 0
i2 + 2    0    0    0    0   0   0  0  1  1  1 1 1
i2 + 1    0    0    1    0   0   0  1  0  1  0 1 0
i2 + 1    1    1    0    0   0   0  0  0  0  0 1 1
i2 + 2    0    0    0    0   0   0  0  0  0  1 1 1

;* * ToneBurst * *
;  str dur  vectab vecsz wavsz 1pos
i3  0   8     10    8192   2     0

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; Play the table...
;  str  dur vectab dynrng frq0 frq1
i5  0   1.8  10     30000  44   22
i5  2   1.8  10     30000   8   16
i5  4    .8  10     30000  10    6
i5  5    .8  10     30000   2    8
i5  6    .8  10     30000  11   22
i5  7   1.3  10     30000  33    1
e