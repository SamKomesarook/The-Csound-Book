f1 0 65536 10 1
; Section 1 Stereo delay with lp-filtered cross feedback
; Pluck
;   Sta  Dur  Amp    Pitch  OutCh  Pan
i1  0    .2   25000  8.00   1      0
i1  1    .2   25000  8.07   2      1
i1  2    .2   25000  8.03   1      0
i1  3    .2   25000  8.05   2      1

i1  4.00 .25  25000  8.00   1      0
i1  4.25 .    25000  8.07   2      1
i1  4.50 .    20000  8.03   1      0
i1  4.75 .    25000  8.02   2      1
i1  5.00 .    19000  8.00   1      0
i1  5.00 .    19000  8.05   2      1
i1  5.25 .    22000  8.10   2      1
i1  5.50 .    19000  8.00   1      0
i1  5.50 .    19000  8.05   2      1
i1  5.75 .25  22000  8.00   2      1

;    Sta  Dur  Amp  TimL  FdbkL XFdbkL TimR FdbkR XFdbkR InChL  InChR Fco
i16  0    8    1.8  .252  .32   .51    .248 .31   .52    1      2     1000

; Clear Zak
;    Sta  Dur
i99  0    8
s

; Section 2 Stereo delay with hp-filtered feedback
;   Sta  Dur  Amp  OutCh  Pan  Sample       Offset
i3  0    2    1    1      .5   "limit.wav"  0

;    Sta  Dur  Amp  TimL  FdbkL XFdbkL TimR FdbkR XFdbkR InChL  InChR Fco
i17  1.3  5    2    .74   1.0   0      .73  1.0   0      1      1     800

; Clear Zak
;    Sta  Dur
i99  0    5

s

; Section 3 Stereo delay with distortion feedback
;   Sta  Dur  Amp  OutCh  Pan  Sample       Offset
i3  0    2    1    1      .6   "limit.wav"  0
i3  7.3  2.3  1    1      .6   "limit.wav"  2.3

;    Sta  Dur  Amp  TimL  FdbkL XFdbkL TimR FdbkR XFdbkR InChL  InChR Drive
i18  1.3  5.85 2    .74   .32   .31    .73  .31   .32    1      2     2.5
i18  7.3  4    1    .14   .12  -.21    .13  .10  -.23    1      2     2.5

; Clear Zak
;    Sta  Dur
i99  0    11.3

s


