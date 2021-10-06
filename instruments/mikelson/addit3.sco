; Sine Wave
f1 0 16384 10 1

; Saw Wave 1/n series
f2 0 16384 10 1 .5 .33 .25 .2  .167

; Square Wave 1/n odd series
f3 0 16384 10 1 0  .5  0   .3333 0  .25 0 .2 0 .166667 0 .14286 0 .125 0 .1111 0 .1
f5 0 1024  -7 .5 512 .5 0 -.5 512 -.5

; Triangle Wave 1/n^2 odd series
f4 0 16384 10 1 0  .1111  0  .04  0  .0204 0 .012346 0 .008264 0 .005917

; Notice the clicking sounds in the last two notes which are absent in the first two
;   Sta  Dur  Amp   Freq   Wave  LFOFqc LFOWav
i20 0.0  1   10000  8.02   2     8      3
i20 +    1   10000  7.02   2     8      3
i20 .    1   10000  8.04   2     8      5
i20 .    1   10000  7.04   2     8      5

i21 4.0  .5  10000  8.00   2     8      3
i21 +    .   10000  7.00   2     8      3
i21 .    .   10000  8.06   2     8      3
i21 .    .   10000  7.06   2     8      3

