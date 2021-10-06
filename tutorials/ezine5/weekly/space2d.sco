;----------------------------------------------------------------------------------
; Spatial Audio
; Coded by Hans Mikelson October 1998 updated April 2000
; This spatial audio system included the following features:
;
;  1. Moving sound source with table supplied moving X and Y coordinates
;  2. Volume decreases as 1/r^2
;  3. Filtering of sound due to air absorption
;  4. Doppler effect due to moving sound
;  5. Simplified HRTF for head shadow filtering
;  6. Inter ear time delay
;  7. Speaker cross-talk cancellation based on both inter ear time delay & head shadowing
;----------------------------------------------------------------------------------

f1 0 65536 10 1

f4 0 1024 -7  16000 128 12000 384  3000 128  8000 256 20000 256 16000 ; HRTF Left
f5 0 1024 -7   8000 128  3000 384 12000 128 16000 256 20000 256  8000 ; HRTF Right

;----------------------------------------------------------------------------------
; Spatial Audio
;----------------------------------------------------------------------------------
; X-Y coordinates
f10 0 1024 -7 10 512  -10 512  10         ; X Diamond
f11 0 1024 -7 0  256   10 512 -10 256  0  ; Y Diamond
f12 0 1024 -7 5 512  3.2 512  2.9         ; X Zoom in then pan left
f13 0 1024 -7 5 512  4.2 512  4.0         ; Y Zoom in then pan left
f14 0 1024  9 1 1 0  2  .5  0             ; X Wobbly circle
f15 0 1024  9 1 1 45                      ; Y Wobbly circle

;   Sta   Dur   Amp   Rate  Table  OutKCh
i2  0     16    .5    3     10     1       ; Algcmp L
i2  0     16    .3    3     11     2       ; Algcmp R
i2  0     16    1     1     12     3       ; lim 1/x, x->0  L
i2  0     16    1     1     13     4       ; lim 1/x, x->0  R
i2  0     16    5     4     14     5       ; Helium lim 1/x, x->0 L
i2  0     16    5     4     15     6       ; Helium lim 1/x, x->0 R

; Sample input
;   Sta   Dur   Amp   Rate  InCh          OutACh
i3  0     16    1     1     "algcmp.wav"  1
i3  0     16    1     1     "limit.wav"   2
i3  0     16    1     1.5   "limit.wav"   3

; Spatial sound system
;   Sta   Dur    Amp   EarX  EarY  SrcKX  SrcKY  InACh  HRTFL  HRTFR  RvrbAChL  RvrbAChR
i20 0     16.05  5     3     4     1      2      1      4      5      4         5
i20 0     16.05  .5    3     4     3      4      2      4      5      4         5
i20 0     16.05  .5    3     4     5      6      3      4      5      4         5

;----------------------------------------------------------------------
; Live Large Room Reverb
;----------------------------------------------------------------------
;    Sta   Dur    Amp  InCh  FdBack   Fco1  Fadj  Time1  Time2  Time3  OutACh
i37  0     16.05  1    2     .9       8070  .8    98     184    373    5
i37  0     16.05  1    3     .9       8260  .8    91     182    377    6

;    Sta   Dur    Amp  InACh1  InACh2
i91  0     16.05  .05  5       6

;   Clear ZAK
i99  0   16.05

