; SCORE
f1 0 8192 10 1

;   Sta  Dur  Amp    Pch
i4  0    2    20000  9.00

;   Sta  Dur  Amp    Pch   OutX  OutY  OutZ  OutW
i5  2    2    2000   9.00  1     2     3     4

; 3 Space Planar Rotation
; 1=X-Y Plane, 2=X-Z Plane, 3=Y-Z Plane
;    Sta  Dur  Fqc  Phase  Plane  InX  InY  InZ  OutX  OutY  OutZ
;i50  0    1.6   1.5  0      2      1    2    3    4     5     6

; 4 Space Planar Rotation
; Plane: 1=X-Y, 2=X-Z, 3=Y-Z, 4=X-W, 5=Y-W, 6=Z-W
;    Sta  Dur  Fqc  Phase  Plane  InX  InY  InZ  InW  OutX  OutY  OutZ  OutW
i51  2    2    1.5  0      1      1    2    3    4    5     6     7     8
i51  2    2    1.2  0      6      5    6    7    8    9     10    11    12
i51  2    2    1.0  0      5      9    10   11   12   13    14    15    16

; Mixer
;    Sta  Dur  Amp  InCh1  InCh2
i100 2    2    1    14     16

; Clear Zak
;     Sta  Dur
i110  2    2
