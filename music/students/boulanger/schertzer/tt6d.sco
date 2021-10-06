                                    ; tt6d.sco

   f1   0 2048  10  1                                                       ; Sine
   f2   0 2048  10  1  .5 .3 .25 .2 .167 .14 .125 .111                      ; Sawtooth
   f3   0 2048  10  1  0  .3    0   .2  0  .14  0   .111                    ; Square
   f4   0 2048  10  1  1  1   1 .7 .5 .3 .1                                 ; Pulse
   f5   0 2048  10  1  0  .111  0  .04  0  .02  0  .012                     ; triangle
   f6   0  128 -17  0  1  12  2  24  3  36  4  48  5  60  6  72  7  84  8   ; step function
   f7   0 2049  11  4
   f8   0 2049  11  4 11
   f9   0 2049 -11  7  3  .5                                                ; band limited pulse
   f10  0 1024   9  1  3  0  3  1  0  9  .3333  180                         ; sq wave combines 1, 3, 9
   f11  0 1024  19  5  1  270  1                                            ; rising sigmoid 0-2

; ins   strt    dur amp frq     atk rel vbrt  vbdpt vibdl   waveform
;========================================================================
   i6   0       9   85  6.00    5   5   .079    .5  .1  1
   i6   9       6   75  5.00    5   5   .079    .5  .1  11
   i6   9       6   75  5.00    5   5   .079    .5  .1  10
   i6   13      6   75  6.08    5   5   .079    .5  .1  5
   i6   18      6   69  5.00    5   5   .079    .5  .1  6
   i6   23      14  75  5.00    5   5   .079    .5  .1  9
   i6   29      5   75  5.00    5   5   .079    .5  .1  8

   i6   33      3   75  6.00    5   .7  .079    .5  .1  1
   i6   33      3   75  6.00    5   .7  .079    .5  .1  11
   i6   33      3   70  5.60    5   .7  .079    .5  .1  10
   i6   36      3   75  6.02    5   .7  .079    .5  .1  2
   i6   36      3   75  6.02    5   .7  .079    .5  .1  11
   i6   36      3   70  5.62    5   .7  .079    .5  .1  10

   i6   39      2   75  6.00    5   .7  .079    .5  .1  1
   i6   39      2   75  6.00    5   .7  .079    .5  .1  11  
   i6   39      2   70  5.60    5   .7  .079    .5  .1  10
   i6   41      3   75  6.05    5   .7  .079    .5  .1  3
   i6   41      3   75  6.05    5   .7  .079    .5  .1  11
   i6   41      3   70  5.65    5   .7  .079    .5  .1  10
   i6   44      5   75  6.04    5   .7  .079    .5  .1  4
   i6   44      5   75  6.04    5   .7  .079    .5  .1  11
   i6   44      5   70  5.64    5   .7  .079    .5  .1  10

   i6   49      2   75  6.00    5   .7  .079    .5  .1  1
   i6   49      2   75  6.00    5   .7  .079    .5  .1  11
   i6   49      2   70  5.60    5   .7  .079    .5  .1  10
   i6   51      2   75  6.02    5   .7  .079    .5  .1  2
   i6   51      2   75  6.02    5   .7  .079    .5  .1  11
   i6   51      2   70  5.62    5   .7  .079    .5  .1  10
   i6   53      2   75  6.00    5   .7  .079    .5  .1  1
   i6   53      2   75  6.00    5   .7  .079    .5  .1  11
   i6   53      2   70  5.60    5   .7  .079    .5  .1  10

   i6   55      2   75  6.07    5   .7  .079    .5  .1  5
   i6   55      2   75  6.07    5   .7  .079    .5  .1  11
   i6   55      2   70  5.67    5   .7  .079    .5  .1  10
   i6   57      3   75  6.05    5   .7  .079    .5  .1  5
   i6   57      3   75  6.05    5   .7  .079    .5  .1  11
   i6   57      3   70  5.65    5   .7  .079    .5  .1  10

   i6   60      3   75  6.00    5   .7  .079    .5  .1  1
   i6   60      3   75  6.00    5   .7  .079    .5  .1  11
   i6   60      3   70  5.60    5   .7  .079    .5  .1  10 
   i6   63      2   75  6.12    5   .7  .079    .5  .1  2
   i6   63      2   75  6.12    5   .7  .079    .5  .1  11
   i6   63      2   70  5.72    5   .7  .079    .5  .1  10
   i6   65      2   75  6.09    5   .7  .079    .5  .1  3
   i6   65      2   75  6.09    5   .7  .079    .5  .1  11
   i6   65      2   70  5.69    5   .7  .079    .5  .1  10
   i6   67      2   75  6.05    5   .7  .079    .5  .1  5
   i6   67      2   75  6.05    5   .7  .079    .5  .1  11
   i6   67      2   70  5.65    5   .7  .079    .5  .1  10
   i6   69      2   75  6.04    5   .7  .079    .5  .1  4
   i6   69      2   75  6.04    5   .7  .079    .5  .1  11
   i6   69      2   70  5.64    5   .7  .079    .5  .1  10
                     


   i6   71      4   75  6.02    5   .7  .079    .5  .1  2
   i6   71      4   75  6.02    5   .7  .079    .5  .1  11
   i6   71      4   70  5.62    5   .7  .079    .5  .1  10
   i6   75      3   75  6.10    5   .7  .079    .5  .1  4
   i6   75      3   75  6.10    5   .7  .079    .5  .1  11
   i6   75      3   70  5.70    5   .7  .079    .5  .1  10
   i6   78      2   75  6.09    5   .7  .079    .5  .1  2
   i6   78      2   75  6.09    5   .7  .079    .5  .1  11
   i6   78      2   70  5.69    5   .7  .079    .5  .1  10
   i6   80      2   75  6.05    5   .7  .079    .5  .1  5
   i6   80      2   75  6.05    5   .7  .079    .5  .1  11
   i6   80      2   70  5.65    5   .7  .079    .5  .1  10
   i6   82      3   75  6.07    5   .7  .079    .5  .1  5
   i6   82      3   75  6.07    5   .7  .079    .5  .1  11
   i6   82      3   70  5.67    5   .7  .079    .5  .1  10
   i6   85      3   75  6.05    5   .7  .079    .5  .1  5
   i6   85      10  75  6.05    5   .7  .079    .5  .1  11
   i6   85      3   70  5.65    5   .7  .079    .5  .1  10

   i6   88      6   75  5.00    5   5   .079    .5  .1  8
   i6   94      15  66  5.00    5   5   .079    .5  .1  6
   i6   108     8   80  5.00    5   5   .079    .5  .1  11
   i6   108     8   80  5.00    5   5   .079    .5  .1  10
   
e
