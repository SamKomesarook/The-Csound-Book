; sine wave for the oscillator bank
;f1 0  32768 10 1
; might be any other waveform of course
;f2 0  32768 10 5 2 1 0 1

; note for 41 CA transition tables :
; max value = 3+3+3=9 -> fill 10 table locations
; with values 0 to 1. Skip normalisation (p4 negative)
; for float1 CA tables use any ftable of any size BUT normalized in (0,1)
; last 6 zeroes not actually used
; but you must fill the table up to the next pow. of 2

;f5 0 16 -2 0 0 2 0 3 2 1 2 3 2 0 0 0 0 0 0
;f6 0 32 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;f7 0 32 20 6


;i1&i4:initialiser 
;p3 = dur(0)
;p4 = number of cells/oscillators
;p5 = cell init table
;p6 = phase init table

;i2&i5:automata
;p4 = time period for next iteration 
;p5 = transition rule table

;i3&i6:additive synth
;p4 = maximum allowed amplitude
;p5 = lowest frequency
;p6 = freq. mapping mode
;     (1:additive, 2:geometric, 3:exponential)
;     more info in the orchestra code
;p7 = strecht factor

;41 CA examples.
;i1 0 0 32 6 7
;i2 0 200 .1 5
;i3 0 200 10000 100 2 1.3
s
;image 1
;f5 0 16 -2 0 0 2 0 1 2 1 3 0 3 0 0 0 0 0 0
;f6 0 32 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;f7 0 32 20 6

;i1 0 0 32 6 7
;i2 0 200 .1 5
;i3 0 200 10000 100 1 1
s
;image 2
;f5 0 16 -2 1 1 1 3 1 1 0 3 0 1 0 0 0 0 0 0
;f6 0 32 -2 0 0 0 1 2 0 0 0 1 0 0 0 0 0 0 2 2 0 0 3 0 3 3 0 0 3 0 0 0 0 0 0
;f7 0 32 20 6

;i1 0 0 32 6 7
;i2 0 200 .1 5
;i3 0 200 10000 100 1 .3
s
;"flying transients"
f1 0 32768 10 2 1 3
f5 0 16 -2 0 2 0 1 2 0 0 3 3 1 0 0 0 0 0 0
f6 0 128 -2 0 3 0 0 0 2 2 0 1 0 0 2 1 0 0 3 2 0 2 0 0 1 1 0 0 1 0 0 3 0 0 1 0 0 2 0 0 3 0 1 2 1 0 3 1 0 0 1 0 0 3 0 0 0 2 2 0 1 0 0 2 1 0 0 3 1 2 0 3 3 0 1 0 1 0 1 2 0 3 2 1 2 1 0 0 0 0 0 2 3 1 0 0 0 1 0 1 0 0 1 1 0 0 2 0 0 3 1 0 2 0 1 0 2 0 1 2 0 0 1 2 1 0 1 2 0 0 1
f7 0 128 20 6

i1 0 0 128 6 7
i2 0 5 .08 5
i3 0 5 100000 110 3 1.029302236643
s
;"cellular vox"
;f1 0 32768 10 1
;f5 0 16 -2 0 1 0 0 1 0 2 3 0 2 0 0 0 0 0 0
;f6 0 32 -2 0 1 0 0 0 0 0 1 0 2 0 1 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 2 0 0 0 1
;f7 0 32 20 6

;i1 0 0 32 6 7
;i2 0 10 .15 5
;i3 0 10 50000 80 1 1
s
;"metallic cloud"
;f1 0 32768 10 1
;f5 0 16 -2 0 1 1 2 3 1 0 2 3 1 0 0 0 0 0 0
;f6 0 64 -2 0 1 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;f7 0 64 20 6

;i1 0 0 64 6 7
;i2 0 6 .05 5
;i3 0 6 50000 40 2 1.21
e
;float1 CA examples.
; All the tables should be normalized in (0,1), NOT in (-1,1)
;otherwise compensate for the offset in the orchestra

f5 0 256 7 0 128 1 128 0
f6 0 32 2 0 0 0 0 0 0 2 0 0 0 0 1 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
f7 0 32 20 6
i4 0 0 32 6 7
i5 0 200 .05 5
i6 0 200 10000 100 1 1.3
e
e