;-----------------------------------------------------
; Pitch Shifter Time Stretcher
; Coded by Hans Mikelson
;-----------------------------------------------------
f1 0 65536 9 1 1 270               ; Sinusoid with 270 degree phase shift
f2 0 262144 -1 "limit.wav" 0 0 0   ; 204164 samples
f3 0 65536 20 2                    ; Hanning window

;     Sta  Dur  Amp  PShift TStretch WindowTime Table Smooth OvrLap
i11   0    2.3  1    .6     1        .1         2     2      1
i.    +    .    1    .8     1        .          2     .      .
i.    .    .    1    1.0    1        .          2     .      .
i.    .    .    1    1.2    1        .          2     .      .
i.    .    .    1    1.4    1        .          2     .      .
i.    .    .    1    2.0    1        .          2     .      .
s

;     Sta  Dur  Amp  PShift TStretch WindowTime Table Smooth OvrLap
i11   0    1.2  1    1      .5       .1         2     2      1
i.    +    2.3  1    1      1        .          2     .      .
i.    .    4.6  1    1      2        .          2     .      .
i.    .    4.6  1    2      2        .          2     .      .
i.    .    1.2  1    .5     .5       .          2     .      .

