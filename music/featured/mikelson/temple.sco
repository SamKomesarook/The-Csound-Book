;---------------------------------------------------------------------------------
; TEMPLES OF TYRIA
;---------------------------------------------------------------------------------
f1 0 16384 10 1                                   ; SINE

;---------------------------------------------------------------------------------
; PART 1 DEEP DRONE
;---------------------------------------------------------------------------------
f10 0 1024 -7 500 256 2000 256 500 512 1000       ; FCO DEEP DRONE
f11 0 1024 -7 6 1024 6                            ; REZ DEEP DRONE
f12 0 1024  7 .1 512 .05 512 .1                   ; ENVFCO
f13 0 1024  7 1  1024 1                           ; ENVREZ
f14 0 1024  7 0  64   1 256 .9 640 .8  64 0       ; AMP

; LFO
;  Sta  Dur   Amp  Fqc  Wave  LFOCh
i1 0.0  41.6  0.5  .5   1     2                   ; LOW FQC

; ENVELOPE
;  Sta  Dur   Amp  Shape  OutKCh
i2 0.0  41.6  1    12     3
i2 0.0  41.6  1    13     4

; PWM
;   Sta   Dur  Amp    Pitch  AmpEnv  FcoEnv  RezEnv  FcoCh  RezCh  LFOCh  Pan
i10  0.0  4.8  5000   6.00   14      10      11      3      4      2      .7
i10  0.8  4.8  6000   5.00   .       .       .       3      4      2      .5
i10  3.2  4.8  8000   6.00   .       .       .       3      4      2      .3
i10  4.8  3.2  9000   5.00   .       .       .       3      4      2      .5
;
i10  6.4  4.8  10000  6.00   .       .       .       3      4      2      .7
i10  8.8  4.8  12000  5.00   .       .       .       3      4      2      .5
i10 11.2  4.8  13000  6.00   .       .       .       3      4      2      .3
i10 12.8  3.2  14000  5.00   .       .       .       3      4      2      .5
;
i10 14.4  4.8  10000  6.00   .       .       .       3      4      2      .7
i10 16.8  4.8  12000  5.00   .       .       .       3      4      2      .5
i10 19.2  4.8  13000  6.00   .       .       .       3      4      2      .3
i10 20.8  4.8  14000  5.00   .       .       .       3      4      2      .5
;
i10 22.4  4.8   8000  6.00   .       .       .       3      4      2      .7
i10 24.8  4.8  10000  5.00   .       .       .       3      4      2      .5
i10 27.2  4.8   9000  6.00   .       .       .       3      4      2      .3
i10 28.8  3.2  10000  5.00   .       .       .       3      4      2      .5
;
i10 30.4  4.8  8000   6.00   .       .       .       3      4      2      .7
i10 32.8  4.8  7000   5.00   .       .       .       3      4      2      .5
i10 35.2  4.8  6000   6.00   .       .       .       3      4      2      .3
i10 36.8  4.8  5000   5.00   .       .       .       3      4      2      .5

;---------------------------------------------------------------------------------
; PART 2 BLEEP BEATS
;---------------------------------------------------------------------------------
f20 0 1024 -7 20 256 80 256 40 256 200 256 30     ; FCO BLEEP BEAT
f21 0 1024 -7 10 1024 10                          ; REZ BLEEP BEAT
f22 0 1024  7 .1 512  1  512 .1                   ; ENVFCO
f23 0 1024  7 1  1024 1                           ; ENVREZ
f24 0 1024  7 0 128   1 256 .7 512 .4 128 0       ; AMP

; ENVELOPE
;  Sta  Dur  Amp  Shape  OutKCh
i2 3.2  6.4  1    22     5
i2 +    6.4  .    .      .
i2 .    6.4  .    .      .
i2 .    6.4  .    .      .
;
i2 3.2  6.4  1    23     6
i2 +    6.4  .    .      .
i2 .    6.4  .    .      .
i2 .    6.4  .    .      .

; SAWTOOTH
;   Sta Dur  Amp    Pitch  AmpEnv  FcoEnv  RezEnv  FcoCh  RezCh  Pan  OutCh1  OutCh2
i12 3.2 0.2  2000   8.00   24      20      21      5      6       .0  1       2
i12 +   0.2  <      8.03   .       .       .       .      .       .1  .       .
i12 .   0.2  <      8.05   .       .       .       .      .       .2  .       .
i12 .   0.2  <      8.07   .       .       .       .      .       .3  .       .
;                                                                 
i12 .   0.2  <      8.00   .       .       .       .      .       .4  .       .
i12 .   0.2  <      8.03   .       .       .       .      .       .5  .       .
i12 .   0.2  <      8.05   .       .       .       .      .       .6  .       .
i12 .   0.2  5000   8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .9  .       .
i12 .   0.2  .      8.05   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .9  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .1  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .2  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .3  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .6  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .4  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .5  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .4  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .6  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .3  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .2  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .1  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .9  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .0  .       .
i12 .   0.2  .      8.03   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.05   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .1  .       .
;                                                                 
i12 .   0.2  .      8.00   .       .       .       .      .       .4  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .5  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .6  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .9  .       .
i12 .   0.2  .      8.05   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .9  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .1  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .2  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .3  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .6  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .4  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .5  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .4  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .6  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .3  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .7  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .2  .       .
i12 .   0.2  .      8.03   .       .       .       .      .       .8  .       .
i12 .   0.2  .      8.05   .       .       .       .      .       .1  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .9  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .0  .       .
i12 .   0.2  .      8.03   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.05   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .1  .       .
;
i12 .   0.2  .      8.00   .       .       .       .      .       .0  .       .
i12 .   0.2  .      8.03   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.05   .       .       .       .      .      1.0  .       .
i12 .   0.2  .      8.07   .       .       .       .      .       .1  .       .

;---------------------------------------------------------------------------------
; PART 3 GLIMMER GLAMMER
;---------------------------------------------------------------------------------
f30 0 1024 -7 20 256 80 256 40 256 200 256 30 ; FCO BLEEP BEAT
f31 0 1024 -7 10 1024 10                      ; REZ BLEEP BEAT
f32 0 1024  7 .5 512 1 512 .5                 ; ENVFCO
f33 0 1024  7 1  1024 1                       ; ENVREZ
f34 0 1024  7 0  64   1 256 .9 640 .8  64 0   ; AMP

; ENVELOPE
;  Sta   Dur  Amp  Shape  OutKCh
i2 9.6   4.8  1    32     7
i2 9.6   4.8  1    33     8

; SAWTOOTH TWO OSCILLATOR
;   Sta  Dur  Amp    Pitch  FRatio  ARatio  AmpEnv  FcoEnv  RezEnv  FcoCh  RezCh  Pan  OutCh1  OutCh2
i13 9.6  0.1  5000   10.00  1.5     1       34      30      31      7      8      1    1       2
i13 +    0.1  .       9.07  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.06  .       .       .       .       .       .      .      0    .       .
;
i13 .    0.1  .      10.03  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.05  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      0    .       .
;
i13 11.6 0.1  7000   10.00  1.5     .       .       .       .       .      .      1    .       .
i13 +    0.1  .       9.07  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.06  .       .       .       .       .       .      .      0    .       .
;
i13 .    0.1  .      10.03  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.05  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      0    .       .
;
i13 13.6 0.1  10000  10.00  1.5     .       .       .       .       .      .      1    .       .
i13 +    0.1  .       9.03  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.07  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.10  .       .       .       .       .       .      .      0    .       .
;
i13 .    0.1  .      10.03  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.06  .       .       .       .       .       .      .      0    .       .
i13 .    0.1  .       9.05  .       .       .       .       .       .      .      1    .       .
i13 .    0.1  .       9.07  .       .       .       .       .       .      .      0    .       .


;---------------------------------------------------------------------------------
; PART 4 FANFARE
;---------------------------------------------------------------------------------
f40 0 1024  7 1   1024   1                           ; KNOBFCO
f41 0 1024  7 1   1024   1                           ; KNOBREZ
f42 0 1024 -7 300 64    350  256 250 704 300         ; ENVFCO
f43 0 1024 -7 4   1024   2.5                         ; ENVREZ
f44 0 1024  7 0   32     1    256 .8  672 .7  64  0  ; AMP
f45 0 1024  7 0   32     1    512 .8  256 .7  256 0  ; AMP

; ENVELOPE
;  Sta    Dur  Amp  Shape  OutKCh
i2 16.0  26.4  1.0  40     9
i2 16.0  26.4  1.0  41     10

; SAWTOOTH
;   Sta  Dur  Amp    Pitch  FRatio  ARatio  AmpEnv  FcoEnv  RezEnv  FcoCh  RezCh  Pan  OutCh1  OutCh2
i13 16.0 0.4  20000  8.00   1.001   1       44      42      43      9      10     0.2  1       2
i13 +    3.2  25000  8.07   .       .       44      42      43      9      10     0.2  1       2
i13 19.2 0.4  25000  8.00   .       .       44      42      43      9      10     0.8  1       2
i13 +    0.4  30000  8.08   .       .       44      42      43      9      10     0.8  1       2
i13 .    2.4  25000  8.07   .       .       44      42      43      9      10     0.8  1       2
i13 .    0.4  20000  8.00   .       .       44      42      43      9      10     0.2  1       2
i13 .    3.2  25000  8.07   .       .       44      42      43      9      10     0.2  1       2
;
i13 29.2 0.4  20000  8.00   1.001   1       44      42      43      9      10     0.2  1       2
i13 +    3.2  25000  8.07   .       .       44      42      43      9      10     0.2  1       2
i13 .    0.2  25000  9.00   .       .       45      42      43      9      10     0.8  1       2
i13 .    0.2  30000  8.10   .       .       45      42      43      9      10     0.8  1       2
i13 .    2.4  25000  8.08   .       .       44      42      43      9      10     0.8  1       2
i13 .    0.4  20000  8.00   .       .       44      42      43      9      10     0.2  1       2
i13 .    3.2  25000  8.07   .       .       44      42      43      9      10     0.2  1       2
;
; DELAY
;    Sta  Dur  Amp  DTime  Fco    FeedBk  XFeedBk  InChL  InChR
i30  0.0  42.4 .7   .8     5000   0.2     0.6      1      2

