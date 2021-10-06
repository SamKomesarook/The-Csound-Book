f1 0 8192 10 1

; Section 1 Simple delay
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .25  15000  8.00   1      .5
i1  +    .25  .      8.07   .      .
i1  .    .5   .      8.04   .      .

i1  .    .25  .      8.05   .      .
i1  .    .25  .      8.07   .      .
i1  .    .5   .      8.00   .      .

; Simple delay
;    Sta  Dur  Amp  Time  InCh
i10  0    3    .5   .5    1

; Clear Zak
;    Sta  Dur
i99  0    3
s

; Section 2 Slap back echo
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .25  15000  8.00   1      .5
i1  +    .25  .      8.07   .      .
i1  .    .5   .      8.04   .      .

i1  .    .25  .      8.05   .      .
i1  .    .25  .      8.08   .      .
i1  .    .5   .      8.00   .      .

; Simple delay
;    Sta  Dur  Amp  Time  InCh
i10  0    3    .9   .1    1

; Clear Zak
;    Sta  Dur
i99  0    3
s

; Section 3 Delay with feedback

; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .25  15000  8.00   1      .5
i1  +    .25  .      8.07   .      .
i1  .    .5   .      8.04   .      .

i1  .    .25  .      8.05   .      .
i1  .    .25  .      8.10   .      .
i1  .    .5   .      8.00   .      .


;    Sta  Dur  Amp  Time  Fdbk  InCh
i11  0    4    .5   .5    .5    1

; Clear Zak
;    Sta  Dur
i99  0    4
s

; Section 4 Delay used for stereo doubling
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Delay
i2  0    .25  15000  8.04   1      .030
i2  +    .25  .      8.05   .      .
i2  .    .25  .      8.07   .      .
i2  .    .25  .      8.08   .      .100
i2  .    .25  .      8.07   .      .
i2  .    .5   .      9.00   .      .
s

; Section 5 Multitap delay
f2 0 8 -8 .2 3 .6  5  1
f3 0 8 -8 1  2 .4  6  .1

; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .25  15000  8.00   1      .5
i1  1    .25  .      8.07   .      .
i1  2    .5   .      8.04   .      .

; Multitap delay
;    Sta  Dur  Amp  MaxTime  InCh  TapTimTab  TapVolTab
i13  0    4    1    2        1     2          3

; Clear Zak
;    Sta  Dur
i99  0    4
s

; Section 6 Stereo delay with feedback
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .25  15000  8.00   1      1
i1  +    .25  .      8.07   .      .
i1  .    .5   .      8.04   .      .

i1  0    .25  15000  8.05   2      0
i1  +    .25  .      8.08   .      .
i1  .    .5   .      8.00   .      .


;    Sta  Dur  Amp  TimL  FdbkL TimR FdbkR  InChL  InChR
i14  0    4    .8   .5    .5    .8   .4     1      2

; Clear Zak
;    Sta  Dur
i99  0    4
s

; Section 7 Stereo delay with cross feedback
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .2   15000  8.00   1      0
i1  1    .2   15000  8.07   2      1
i1  2    .2   15000  8.03   2      1
i1  3    .2   15000  8.05   2      1

;    Sta  Dur  Amp  TimL  FdbkL XFdbkL TimR FdbkR XFdbkR InChL  InChR
i15  0    6    .8   .2    0     .8     .2   0     .8     1      2

; Clear Zak
;    Sta  Dur
i99  0    6


