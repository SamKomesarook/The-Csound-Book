;************************************************************
; AN ASSORTMENT OF CHAOTIC, FRACTAL AND RELATED INSTRUMENTS
; CODED BY HANS MIKELSON  SEPTEMBER 20, 1997
;************************************************************
; 1. THE LORENZ ATTRACTOR
; 2. THE ROSSLER ATTRACTOR
; 3. PLANET ORBITING IN A BINARY STAR SYSTEM

f1 0 8192 10 1

t 0 400

; ROSSLER ATTRACTOR
;  START  DUR  AMP   FREQ  B  C  PAN
i2  0     1   2000   .04   4  4  1
i2  +     1   <      .06   4  4  <
i2  .     1   <      .08   4  4  <
i2  .     1   <      .10   4  4  <
i2  .     1   <      .12   4  4  <
i2  .     1   <      .14   4  4  <
i2  .     1   <      .16   4  4  <
i2  .     1   5500   .18   4  4  0
;
i2  .     1   2000   .14   4  4  1
i2  .     1   2500   .16   4  4  <
i2  .     1   3000   .18   4  4  <
i2  .     1   3500   .20   4  4  <
i2  .     1   4000   .22   4  4  <
i2  .     1   4500   .24   4  4  <
i2  .     1   5000   .26   4  4  <
i2  .     1   5500   .28   4  4  0
;
i2  .     1   3000   .26   4.0  4    .8
i2  .     1   2800   .30   4.0  4    .1
i2  .     1   2600   .26   3.8  4    .9
i2  .     1   2400   .32   4.0  4    .6
i2  .     1   2200   .26   3.6  4    .2
i2  .     1   2000   .30   4.0  3.8  .8
i2  .     1   1800   .26   3.4  4    .3
i2  .     1   1600   .32   4.0  4    .4
i2  .     1   1400   .26   3.2  4    .9
i2  .     1   1200   .30   4.0  4    .1
;
i2  .     1   3400   .26   3.8  4     1
i2  .     1   3200   .20   3.7  4     <
i2  .     1   3000   .26   3.6  4     <
i2  .     1   2800   .20   3.5  4     <
i2  .     1   2600   .26   3.4  4     0
i2  .     1   2400   .20   3.2  3.8   <
i2  .     1   2000   .26   3.1  3.6   <
i2  .     1   1600   .20   3.0  4     <
i2  .     1   1200   .26   2.9  4     1
i2  .     1   800    .20   3.0  3.9   <
i2  .     1   600    .20   3.0  3.8   <
i2  .     1   400    .20   3.0  3.7   <
i2  .     1   200    .20   3.0  3.6   <
i2  .     1   100    .20   3.0  3.5   .5

; PLANETARY ORBIT IN A BINARY STAR SYSTEM
;  START  DUR  AMP      H  MASS1 MASS2 SEPARATION  PAN
i3  16    16   1000    .2   .5    .6      2        .7
i3  28    48   2500    .15  .4    .34     1.1      .5
i3  52    4    2000    .3   .5    .5      1        .2
i3  +     .    2500    .3   .5    .48     1.2      <
i3  .     .    3000    .3   .5    .46     1.4      <
i3  .     .    3500    .3   .5    .44     1.6      <
i3  .     8    3000    .3   .5    .42     1.8      .8

;  START  DUR AMP  X   Y   Z    S    R   B      H   PAN
i1  80    1.5 500  .6  .6  .6  32   28  2.667  .01   1
i1  +     .   350  .6  .6  .6  30   28  2.667  .01   <
i1  .     .   400  .6  .6  .6  28   28  2.667  .01   <
i1  .     .   250  .6  .6  .6  26   28  2.667  .01   .5
i1  .     .   300  .6  .6  .6  24   28  2.667  .01   <
i1  .     .   150  .6  .6  .6  22   28  2.667  .01   <
i1  .     .   400  .6  .6  .6  20   28  2.667  .01   <
i1  .     .   200  .6  .6  .6  24   28  2.667  .01   .8
;
i1  96    1.5 500  .6  .6  .6  32   28  2.667  .01   .2
i1  +     .   350  .6  .6  .6  30   27  2.667  .01   <
i1  .     .   400  .6  .6  .6  28   26  2.667  .01   <
i1  .     .   250  .6  .6  .6  26   25  2.667  .01   .5
i1  .     .   300  .6  .6  .6  24   24  2.667  .01   <
i1  .     .   150  .6  .6  .6  22   23  2.667  .01   <
i1  .     .   400  .6  .6  .6  20   22  2.667  .01   <
i1  .     .   200  .6  .6  .6  24   21  2.667  .01   .1
;
i2  106   1   2000   .04   4  4   0
i2  +     1   2500   .06   4  4   <
i2  .     1   3000   .08   4  4   <
i2  .     1   3500   .10   4  4   <
i2  .     1   4000   .12   4  4   <
i2  .     1   4500   .14   4  4   <
i2  .     1   5000   .16   4  4   <
i2  .     1   5500   .18   4  4   1
;
i1  114   1.5 500  .6  .6  .6  30   21  2.66  .01   1
i1  +     .   350  .6  .6  .6  30   21  2.64  .01   .6
i1  .     .   400  .6  .6  .6  30   21  2.62  .01   0
i1  .     .   250  .6  .6  .6  30   21  2.60  .01   .8
i1  .     .   300  .6  .6  .6  30   21  2.58  .01   .3
i1  .     .   150  .6  .6  .6  30   21  2.56  .01   .5
i1  .     .   400  .6  .6  .6  30   21  2.54  .01   1
i1  .     .   200  .6  .6  .6  30   21  2.52  .01   .2
;
i2  126   1   2000   .14   4  4   1
i2  +     1   <      .16   4  4   <
i2  .     1   <      .18   4  4   <
i2  .     1   <      .20   4  4   <
i2  .     1   <      .22   4  4   <
i2  .     1   <      .24   4  4   <
i2  .     1   <      .26   4  4   <
i2  .     1   4000   .28   4  4   0
;
i3  130  8   3000  .04  .5  .6   2  .5
i3  +    .   3000  <    .5  .6   2  .5
i3  .    .   3000  <    .5  .6   2  .5
i3  .    .   3000  .16  .5  .6   2  .5
;
i1  150  1   500   .6  .6  .6  30   21  2.52  .002   0
i1  +    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   1200  .6  .6  .6  30   21  2.30  .012   1
;
i1  164  1   800   .6  .6  .6  30   21  2.00  .012   1
i1  +    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .   <     .6  .6  .6  30   21  <     <      <
i1  .    .  2000   .6  .6  .6  30   21  2.30  .002   0