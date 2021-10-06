;-----------------------------------------------------
; Reverb
; Coded by Hans Mikelson
; July 6, 1999
;-----------------------------------------------------
f1 0 65536 10 1

;-----------------------------------------------------
;a0 0 1
; Small Dead Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .4   10    .41   1     2     .62  2000    0
i50  0    1    .4   11    .42   1     3     .63  2000    0

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    2      3     4
s

;-----------------------------------------------------
;a0 0 1
; Medium Dead Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .7   12    .41   1     2     .32  4000    0
i50  0    1    .4   33    .55   2     3     .53  2000    1
i50  0    1    .4   31    .54   2     4     .53  2000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    3      4     4
s

;-----------------------------------------------------
;a0 0 1
; Large Dead Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .3   12    .41   1     2     .82  6000    0
i50  0    1    .5   33    .35   2     3     .43  5000    1
i50  0    1    .8   53    .65   3     4     .23  2000    1
i50  0    1    .8   51    .64   3     5     .23  2000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    4      5     4
s

;-----------------------------------------------------
;a0 0 1
; Small Live Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .4   9.5   .81   1     2     1.1  15000   0
i50  0    1    .4   9.7   .85   2     3     1.2  15000   1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    2      3     2
s

;-----------------------------------------------------
;a0 0 1
; Medium Live Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .4   12    .81   1     2     .92  15000    0
i50  0    1    .4   33    .85   2     3     .93  8000    1
i50  0    1    .4   31    .84   2     4     .93  8000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    2      2     1.5
i90  0    1    3      4     2.0
s

;-----------------------------------------------------
;a0 0 1
; Large Live Room
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    1    .4   12    .51   1     2     .92  15000   0
i50  0    1    .5   33    .75   2     3     .83  10000   1
i50  0    1    .7   53    .85   3     4     .63  5000    1
i50  0    1    .7   51    .84   3     5     .63  5000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    1    3      3     2
i90  0    1    4      5     2
s

;-----------------------------------------------------
;a0 0 2
; Small Bright Hall Reverb
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc  PreFco  SigAmp
i50  0    2    .5   8     .61   1     2     .8  17000   0
i50  0    2    .6   25    .72   2     3     .8  10000   1
i50  0    2    .7   40    .82   3     4     .7  8000    1
i51  0    2    .8   83    1.0   4     5     .6  4000    1
i51  0    2    .8   87    1.0   4     6     .6  4000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    2    2      2     1.0
i90  0    2    3      3     1.5
i90  0    2    5      6     1.0
s

;-----------------------------------------------------
;a0 0 2
; Small Dark Hall Reverb
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc  PreFco  SigAmp
i50  0    2    .5   8     .71   1     2     .8  15000   0
i50  0    2    .6   25    .82   2     3     .6  8000    1
i50  0    2    .7   40    .92   3     4     .4  6000    1
i51  0    2    .8   83    1.0   4     5     .3  3000    1
i51  0    2    .8   87    1.0   4     6     .3  3000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    2    2      2     1.0
i90  0    2    3      3     1.2
i90  0    2    5      6     1.8
s

;-----------------------------------------------------
;a0 0 2
; Small Hall Reverb Darker Still
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc  PreFco  SigAmp
i50  0    2    .5   8     .51   1     2     .6  12000   0
i50  0    2    .6   25    .62   2     3     .4  8000    1
i50  0    2    .7   40    .82   3     4     .3  3000    1
i51  0    2    .8   83    1.0   4     5     .2  2000    1
i51  0    2    .8   87    1.0   4     6     .2  2000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    2    2      2     0.5
i90  0    2    3      3     1.0
i90  0    2    5      6     2.5
s

;-----------------------------------------------------
;a0 0 3
; Large Hall Reverb
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc  PreFco  SigAmp
i50  0    3    .5   8     .61   1     2     .9  17000   0
i50  0    3    .7   25    .72   2     3     .8  10000   1
i50  0    3    .8   60    .82   3     4     .7  8000    1
i51  0    3    1    133   1.0   4     5     .6  4000    1
i51  0    3    1    137   1.0   4     6     .6  4000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    3    3      3     1
i90  0    3    4      4     1.5
i90  0    3    5      6     1
s

;-----------------------------------------------------
;a0 0 6
; Large Tunnel Reverb
;    Sta  Dur   Amp    OutCh  OutAmp
i10  0    .005  30000  1      1

;    Sta  Dur  Amp  Time  Dens  InCh  OutCh Fc   PreFco  SigAmp
i50  0    6    .1   8.5   .71   1     2     1.2  8000    0
i50  0    6    .4   25    .82   2     3     .83  6000    1
i50  0    6    .7   80    .98   3     4     .73  3000    1
i51  0    6    .8   153   1.2   4     5     .52  1000    1
i51  0    6    .8   157   1.2   4     6     .52  1000    1

;    Sta  Dur  InCh1  InCh2 Amp
i90  0    6    3      3     8
i90  0    6    4      4     8.5
i90  0    6    5      6     8

