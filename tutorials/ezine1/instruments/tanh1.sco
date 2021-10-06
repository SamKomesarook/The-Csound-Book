;------------------------------------------------------------------------------
; Modified Hyperbolic Tangent Distortion
; Coded by Hans Mikelson December 1998
;------------------------------------------------------------------------------
; Pluck
;    Sta  Dur  Amp    Pitch  Table  OutCh
i1   0    1    15000  7.00   0      1
i1   0    1    15000  7.07   0      1
i1   1    1    15000  8.00   0      1
i1   1    .25  15000  7.05   0      1
i1   +    .25  15000  7.07   0      1
i1   .    .25  15000  7.10   0      1
i1   .    .25  15000  8.00   0      1
i1   2    1    15000  6.00   0      1
i1   2    1    15000  7.00   0      1

; Distortion
;    Sta  Dur  Overdrive  Gain  Shape1  Shape2  Rect  InCh  OutCh  Output
i11  0    3    2          .5    .2      0       0     1     2      1

; Pluck
;    Sta  Dur  Amp    Pitch  Table  OutCh
i1   3    1    15000  7.00   0      1
i1   3    1    15000  7.07   0      1
i1   4    1    15000  8.00   0      1
i1   4    .25  15000  7.05   0      1
i1   +    .25  15000  7.07   0      1
i1   .    .25  15000  7.10   0      1
i1   .    .25  15000  8.00   0      1
i1   5    1    15000  6.00   0      1
i1   5    1    15000  7.00   0      1

; Distortion
;    Sta  Dur  Overdrive  Gain  Shape1  Shape2  Rect  InCh  OutCh  Output
i11  3    3    .5         1     0       0       0     1     2      1

; Pluck
;    Sta  Dur  Amp    Pitch  Table  OutCh
i1   6    1    15000  7.00   0      1
i1   6    1    15000  7.07   0      1
i1   7    1    15000  8.00   0      1
i1   7    .25  15000  7.05   0      1
i1   +    .25  15000  7.07   0      1
i1   .    .25  15000  7.10   0      1
i1   .    .25  15000  8.00   0      1
i1   8    1    15000  6.00   0      1
i1   8    1    15000  7.00   0      1

; Distortion
;    Sta  Dur  Overdrive  Gain  Shape1  Shape2  Rect  InCh  OutCh  Output
i11  6    3    4          .5    0       .2      .5    1     2      1

; Zak Clear
i99  0    9

