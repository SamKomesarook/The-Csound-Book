f1 0 65536 10 1

f10 0 1024 -7 1 1024 1
f11 0 1024 -7 1 224 1 100 0 50 .01 100 -1 200 -1 25 1 275 1.2 50 .01
f12 0 1024 -7 .5 1024 1.5

;   Sta  Dur  Amp  Pan  Skip  Sample
i1  0    2.0  1    .5   0     "limit.wav"
s

; Sample effects
;   Sta  Dur  Amp  Pan  Skip  Sample
i1  0    .2   1    .5   0     "limit.wav"
i1  +    .    .    1    .     "limit.wav"
i1  .    .    .    0    .     "limit.wav"
i1  .    .    .    1    .     "limit.wav"
i1  .    2.0  .    .5   .     "limit.wav"

i1  .    .1   1    .5   .8    "limit.wav"
i1  .    .    .    1    .     "limit.wav"
i1  .    .    .    0    .     "limit.wav"
i1  .    .    .    1    .     "limit.wav"
i1  .    1.2  .    .5   .     "limit.wav"
s

; Simulated echo
;   Sta  Dur  Amp  Pan  Skip  Sample
i1  0    .4   1    .5   1.56  "limit.wav"
i1  +    .    .7   1    .     "limit.wav"
i1  .    .    .5   0    .     "limit.wav"
i1  .    .    .4   1    .     "limit.wav"
i1  .    .    .3   0    .     "limit.wav"
i1  .    .    .2   1    .     "limit.wav"
i1  .    .    .1   0    .     "limit.wav"
s

; Simulated stereo
;   Sta  Dur  Amp  Pan  Skip  Sample
i1  0    2.5  1    1    2.13  "limit.wav"
i1  .01  .    1    0    .     "limit.wav"
s


; Samples using Diskin
; Stereo detune
;   Sta  Dur  Amp  Pan  Skip  Sample       Rate  RtTable
i2  0    2.0  1    1    0     "limit.wav"  0.99  10
i2  0    2.0  1    0    0     "limit.wav"  1.01  10
s

; Pitch change
;   Sta  Dur   Amp  Pan  Skip  Sample       Rate  RtTable
i2  0    3.09  1    .5   0     "limit.wav"  1.5   10
i2  +    3.4   1    .5   2     "limit.wav"  .75   10
s

; Sample warping
;   Sta  Dur   Amp  Pan  Skip  Sample       Rate  RtTable
i2  .5   10    1.5  .5   0     "algcmp.wav"  1     11
s

; Frequency modulation
;   Sta  Dur   Amp  Pan  Skip  Sample       Rate  FMAmt  FMFqc
i3  0    2.35  1    1    2.13  "limit.wav"  1     .4     410
i3  0    2.35  1    0    2.13  "limit.wav"  1     .4     390
s

; Chorus
;   Sta  Dur   Amp  Pan  Skip  Sample       Rate  FMAmt  FMFqc
i3  0    2.35  .7   1    2.13  "limit.wav"  1     .03    4
i3  0    2.35  .7   0    2.13  "limit.wav"  1     .03    4
i3  0    2.35  .7   .5   2.13  "limit.wav"  1     0      1

