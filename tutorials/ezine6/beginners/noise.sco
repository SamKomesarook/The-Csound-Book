; Noise
;   Sta  Dur  Amp
i1  0    3.8  10000         ; White Noise
i2  4    3.8  20000         ; Pink Noise
i3  8    3.8  30000         ; White Noise with filter sweep
i4  12   3.8  30000         ; Pink Noise with filter sweep

;   Sta  Dur  Amp    Fqc
i6  16   1.8  30000  30     ; Sample Hold Noise

;   Sta  Dur  Amp    Alpha
i5  18   1.8  30000  1      ; Cauchy noise with
i5  20   1.8  30000  .1     ; varying alpha
i5  22   1.8  30000  .01

