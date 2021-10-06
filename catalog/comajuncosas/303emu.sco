f1 0 8192 10 1                                                                       ; sine wave
f3  0 8193   8  0 512 1 1024 1 512 .5 2048 .2 4096  0                      ; accent curve

f4  0  16  -2  12 24 12 14 15 12 0 12 12 24 12 14 15 6 13 16               ; sequencer (pitches are 6.00 + p/100)
f5  0  32  -2   0  1  0  0  0  0 0  0  0  1  0  1  1 1  0  0 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1; accent sequence
f6  0  16  -2   2     1  1  2    1  1  1  2     1  1 3       1 4 0 0 0     ; fill with zeroes till next power of 2

; F6 = DURATIONS OF EVENTS, 1 = NOTE PER NOTE, 2 = TWO TIED NOTES, ETC. .
; NOTE: F4-F5-F6 DON´T NEED TO BE SYNCRONIZED... LIKE HERE (16-32-21)

f7  0  8  -2   10 0 12 0 7 10 12 7                                              ; sequencer (pitches are 6.00 + p/100)
f8  0  16  -2   1 0  0 0 0  0  0 0 0 0 0 0 0 0 0 0                              ; accent sequence
f9  0  2  -2   16 0                                                                  ; fill with zeroes till next power of 2

f10  0  8  -2   0 12 0 0 12 0 0 12                                              ; sequencer (pitches are 6.00 + p/100)
f11  0  8  -2   1  1 1 1  1 1 1  1                                              ; accent sequence
f12  0  8  -2   1  1 1 1  1 1 1  1                                              ; fill with zeroes till next power of 2

; feedback adjusting curve
f20 0 8193 -25 0 4 8192 1

; tuning curve
f21 0 8193 -27 0 -1 2048 -.22 4096 .4 6144 .83 7168 .92 8192 1


;------------------------KNOB POSITION : INITIAL AND FINAL VALUES FROM 0 TO 1-------------------------------------
;          cutoff freq   resonance envelope mod.  decay       accent     bpm  transpose ft seq   ft acc     ft dur   maxamp
;          0   -   1     0 ~ <1         ~ .1 - 1  0 - 1       0 - 1   40-300  (octaves)(pitches)(accents)(durations)
;         start    end   st  end          st   end          st  end     st  end

i1   0 20        .1     .3        .2  .2        .01  .1         .02 .1      0   0      120     2         7        8       9         7000
i1   0 20  0      .6        .5  .7        .01  .1         1   1       1   1      120     0         4        5       6         6000
i1  20 40  .2     1         .5  .9        .1   .1         .5  1       .5  1      120     2         7        8       9         4000
i1  40 20       .5     1         .8  .95       1    .9         1   .1      .5  1      120     0         4        5       6         3000
i1  30 30       .8     1         .5  .5        .7   .7         .6  .9      0   0      120     0        10       11      12        20000

;------------------------------------------END OF SCORE----------------------------------------------------------
e

;those settings work better for the "soft" filter envelope option

;------------------------KNOB POSITION : INITIAL AND FINAL VALUES FROM 0 TO 1--------------------------------------------
;          cutoff freq   resonance envelope mod.  decay       accent     bpm  transpose ft seq   ft acc     ft dur   maxamp
;          0   -   1     0 ~ <1         ~ .1 - 1  0 - 1       0 - 1   40-300  (octaves)(pitches)(accents)(durations)
;         start    end   st  end          st   end          st  end     st  end

i1   0 20        .1     .3        .2  .2        .1   .4         .05 .8      0   0      120     2         7        8       9         5000
i1   0 20  0      .6        .5  .98       .1   .4         1   1       1   1      120     0         4        5       6        10000
i1  20 40  .2     1         .5  .98       .1   .1         .5  1       .5  1      120     2         7        8       9         4000
i1  40 20       .5     1         .8  .99       1    .9         1   .1      .5  1      120     0         4        5       6         3000
i1  30 30       .8     1         .5  .5        .7   .7         .6  .9      0   0      120     0        10       11      12        20000

;------------------------------------------END OF SCORE------------------------------------------------------------------
e
