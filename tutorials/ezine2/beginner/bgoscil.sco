;-------------------------------------------------------------------------
; Beginners Oscillator Demo
; by Hans Mikelson March 1999
;-------------------------------------------------------------------------
f1 0 16384 10 1                                    ; Sine wave
f2 0 16384 10 1 .5 .333333 .25 .2 .166667 .142857 .125 .111111 .1 .090909 .083333 .076923 ; Bandlimited sawtooth wave
f3 0 16384 10 1 0  .333333 0   .2 0       .142857 0    .111111 0  .090909 0       .076923 ; Bandlimited square wave
f4 0 16384 7  1 16385 -1                           ; Arithmetic sawtooth wave
f5 0 16384 7  1 8192   1 0 -1 8192 -1              ; Arithmetic square wave
f6 0 1025  7  0 128 1 128 .8 256 .6 256 .6 257 0   ; ADSR type envelope
f7 0 1025  7  0 13 1 1000 1 12 0                   ; Simple envelope

; Detuned band-limited oscilators with vibrato
;    Sta  Dur  Amp    Pitch  Table  Env
i1   0    .5   20000  8.00   1      6
i1   +    .5   .      8.03   1      .
i1   .    .5   .      8.05   1      .
i1   .    .5   .      8.00   1      .
i1   .    .5   .      7.00   2      .
i1   .    .5   .      8.00   2      .
i1   .    1    .      7.07   2      .
i1   .    .5   .      7.00   3      .
i1   .    .5   .      8.03   3      .
i1   .    .5   .      8.05   3      .
i1   .    .5   .      8.00   3      .
i1   .    .5   .      7.00   2      .
i1   .    .5   .      7.07   2      .
i1   .    1    .      7.00   2      .

; Algebraic saw and square waves
;    Sta  Dur  Amp    Pitch  Table  Env
i1   9    1    .      7.00   4      .
i1   +    .    .      8.00   4      .
i1   .    .    .      7.00   5      .
i1   .    .    .      8.00   5      .

; Sci Fi sound
;    Sta  Dur  Amp    Pitch  Table  Env
i2  14    2    20000  8.00   2      7
i3  16    2    20000  7.07   3      7

; Panning sound effect
i4  18    2    20000  7.07   2      7

