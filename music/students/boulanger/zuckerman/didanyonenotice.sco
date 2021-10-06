f1  0  4096  10  1
f2  0  4096  7  0  2048  1  2048  0
f3  0  4096  7  1  2048  0  2048  1
f4  0  4096  5  .001  2048  1  2048  .001
f5  0  4096  5  1  2048  .001  2048  1
f6  0  2048  7  0  2048  1																;right to left
f7  0  2048  7  1  2048  0																;left ot right
f8  0  2048  8  0.001  487  1  98  1  773  0.4  385  0.05  305  .001   101 0.000000		;conv fade
f9  0  2048  5  .001 2044 1  1 .001 3  .001														
; Mikelson's Heavy Distortion Transfer Function:
f10 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
f11  0  1024  5  .001  51  1  736  1  237  .001											;tidal fade


;ins  srt  dur   amp atk  rel  pt1 time1 pt2 time2 pt3   pt4  freq nh func bw   rate  pfunc rvbt lpt  rvb (tidal)
i1    0   17.5    40  .5    4   55    4   659  4   1568  3951  55  50  1   150   1    4    3.5  .25  .12	
i1    1   16.5    40  .5    4   82    4   784  4   1976  5274  82  50  1   150   1    5    3.5  .25  .12
i1    2   15.5    40  .5    4   98    4   988  4   2637  6272  98  50  1   150   .5   4    3.5  .25  .12

i1    12    16    35   1    1.5 55    3   659  5  1480   3951  55  50  1   150   1    5    3.5  .25  .12
i1    13    15    35   1    1.5 82    3   740  5  1976   5274  82  50  1   150   .5   4    3.5  .25  .12
i1    14    14    35   1    1.5 92    3   988  5  1976   5274  92  50  1   150   1    5    3.5  .25  .12

i1    24    17    39   2     5  44    4   659  4   1568  4186  44  50  1    150  .5   3    3.0  .25  .12 
i1    25    16    39   2     5  82    4   698  4   2093  5588  82  50  1    150  1    2    3.0  .25  .1
i1    26    15    39   2     5  98    4   1047 4   2093  6272  98  50  1    150  1    3    3.0  .25  .1

i1    42    32    40   3     3  55    5   494  3   1047  3951  55  50  1    150  1    4    .5  .25  .12     
i1    43    31    40   3     3  62    5   523  3   1319  3520  62  50  1    150  1    5    .5  .25  .12
i1    44    30    40   3     3  65    5   784  3   1760  4186  65  50  1    150  .5   4    .5  .25  .12

i1    70    16    37   1     1  55    3   659  5   1480  3951  55  50  1    150  1   5     .5  .25  .12
i1    71    15    37   1     1  82    3   740  5  1976   5274  82  50  1   150   .5   4    .5  .25  .12
i1    72    14    37   1     1  92    3   988  5  1976   5274  92  50  1   150   1    5    .5  .25  .12

i1    86    16    40   3     3  55    5   494  3   1047  3951  55  50  1    150  1    4    .5  .25  .12
i1    85    15    40   3     3  62    5   523  3   1319  3520  62  50  1    150  1    5    .5  .25  .12
i1    84    14    40   3     3  65    5   784  3   1760  4186  65  50  1    150  .5   4    .5  .25  .12

i1    102     38    40  3    2   55    4   659  4   1568  3951  55  50  1   150  .25   2   .5  .25  .12

i1    130     16    40  .5    2   55    4   659  4   1568  3951  55  50  1   150   1    4   3  .25  .12
i1    131     15    40  .5    2   82    4   784  4   1976  5274  82  50  1   150   1    5   3  .25  .12
i1    132     14    40  .5    2   98    4   988  4   2637  6272  98  50  1   150   .5   4   3  .25  .12

i1    146    16    35   1    1.5 55    3   659  5  1480   3951  55  50  1   150   1    5    3  .25  .12
i1    147    15    35   1    1.5 82    3   740  5  1976   5274  82  50  1   150   .5   4    3  .25  .12
i1    148    14    35   1    1.5 92    3   988  5  1976   5274  92  50  1   150   1    5    3  .25  .12

i1    162    16    38   2     4  44    4   659  4   1568  4186  44  50  1    150  .5   3    3  .25  .12
i1    163    15    38   2     4  82    4   698  4   2093  5588  82  50  1    150  1    2    3  .25  .1
i1    164    14    38   2     4  98    4   1047 4   2093  6272  98  50  1    150  1    3    3  .25  .1

i1    180    32    39   3     3  55    5   494  3   1047  3951  55  50  1    150  1    4    .5  .25  .12
i1    181    31    39   3     3  62    5   523  3   1319  3520  62  50  1    150  1    5    .5  .25  .12
i1    182    30    39   3     3  65    5   784  3   1760  4186  65  50  1    150  .5   4    .5  .25  .12

i1    212    16    38   1     1  55    3   659  5   1480  3951  55  50  1   150   1    5    .5  .25  .12
i1    211    15    38   1     1  82    3   740  5  1976   5274  82  50  1   150   .5   4    .5  .25  .12
i1    210    14    38   1     1  92    3   988  5  1976   5274  92  50  1   150   1    5    .5  .25  .12

;ins  srt     dur   amp  pt1 time1 pt2 time2 pt3  pt4  freq nh func bw   rate  pfunc rvbt lpt  rvb (tidal 2)
i2    228    57.5    39  55    5   494  3   1047  3951  55  50  1   150   1     4    .5  .25  .12
i2    229    56.5    39  62    5   523  3   1319  3520  62  50  1   150   1     5    .5  .25  .12
i2    230    55.5    39  65    5   784  3   1760  4186  65  50  1   150   .5    4    .5  .25  .12




;convolved chord (A, G, B)
;ins  srt   dur    amp   atk  rel  amp1(A)  amp2(G)  amp3(B)  bal
i3    40.5   29.5   .3    6    4    .54     .24      .04      .5 
i3    83     22     .3    8    2    .54     .24      .04      .5 
i3   101     19     .3    3    10   .54     .24      .04      .5 
i3   181     19     .3    8    4    .54     .24      .04      .5     
i3   212     31     .3    8    4    .54     .24      .04      .5	 
i3   239     31     .3    8    4    .54     .24      .04      .5
    
    
;convolved chord (A, G, F#)
;ins  srt   dur    amp   atk  rel  amp1(A)  amp2(G)  amp3(F#)  bal  
i4    67    19      .3     6   3.8   .54      .24      .06     .5   
i4    196   17      .3     6   3.8   .54      .24      .06     .5   
    
    
;  final convolved chord (A,G,B) 
;ins  srt   dur    amp1(A)  amp2(G)  amp3(B)  bal  rezgain
i5   265   27     .54     .24      .04      .5   .5




;		     freq balance  amp trim1 trim2(VOX-ohohoh)
i6  38    15    3    .5    1.2   .3    .3
i6  68    15    3    .5    1.2   .3    .3
i6  178   15    3    .5    1.2   .3    .3
i6  209.5 15.5  3    .5    1.2   .3    .3


;             freq  bal    amp trim1 trim2(VOX-'ohwhere')
i7  53   15    3    .5     .7   .3    .3   
i7  84   15    3    .5     .7   .3    .3
i7  195  15    3    .5     .7   .3    .3
i7  226  15    3    .5     .7   .3    .3




;            iamp  atk  rel  cf1 dur1 cf2  dur2 cf3   cf4   rvb   bal (climbing explosion)  
i8  102.5   4  15  2    8   50   4   1000   2  1500   2000   .4     1
i8  118.5   4  15  2    8   50   4   1000   2  1500   2500   .4    0 

i8  130.5  7   15  2   .05  50   4   1000   2  1500   2500   0     1
i8  138.5  7   15  2   .05  50   4   1000   2  2000   3000   .4    1
i8  146.5  7   15  2   .05  50   4   1200   2  1500   2500   0     0
i8  154.5  7   15  2   .05  50   4   1000   2  1500   3000   .4    0
i8  162.5  7   15  2   .05  50   4   1000   2  1500   2500   0     1
i8  170.5  7   15  2   .05  50   4   1000   2  2000   3000   .4    0    
i8  180.5  7   15  2   .05  50   4   1200   2  1500   2500   0     0 
i8  188.5  22  15  2   .05  50   4   1000   2  1500   3000   .4    1


;            amp  cf1  dur1  cf2  dur2 cf3  cf4   bal (fire)  
i9  138   40  4    50   .1   30   .8   55    75   .5




;           pt1  tim1 pt2 tim2 pt3 pt4 amp atk  panfn	(moving bass)
i10  130  8  82  .05  82  .5   44  28  6    1 	 2
i10  146  8  82  .05  82  .5   44  28  6    1    3
i10  162  8  82  .05  82  .5   44  28  6    1    2


; 			 pt1  tm1 pt2  tm2  pt3 pt4 amp atk 	(stationary bass)
i11  102  2  587  .05  55  .5   44  37  5.3  .01
i11  118  2  587  .05  55  .5   44  37  5.3  .01

i11  180  64 587  .05  55  .5   44  37  4.3  .01




;             freq  bal  amp trim1 trim2 (moVOX-'sss')
i12  130  15   3    .5   .35  .2    .2
i12  146  15   3    .5   .35  .2    .2
i12  162  15   3    .5   .35  .2    .2
i12  244  10   3    .5   .35  .2    .2


;             freq  bal  amp vbtim1 vbtim2 trim1 trim2 (moVOX-'excuseme)
i13  132   15  3    .5   .7    6      6     .25   .25
i13  147.5 15  3    .5   .7    6      6     .25   .25
i13  162.5 10  3    .5   .7    5      5     .25   .25
i13  244   5   3    .5   .9    5      5     .25   .25


;              freq  bal amp vbtim1 vbtim2 trim1 trim2 (moVOX-'while')
i14  170   8    3    .5  .6    6      6     .3    .3
i14  252   5    3    .5  .9    5      5     .3    .3


;              freq  bal amp vbtim1 vbtim2 trim1 trim2 (moVOX-'I')
i15  173   10  3    .5   .7    6      6     .3    .3
i15  255   5   3    .5   .9    5      5     .3    .3


;              freq  bal amp vbtim1 vbtim2 trim1 trim2 (moVOX-'dissa2')
i16  260  15  3     .5    .9   5      5     .1    .1


;              freq  bal amp  vbtim1 vbtim2 trim1 (moVOX-'pear')
i17  266  15   3     .5   1.4   10     10    .2    



;GLOBAL instrs:
;              time (verb-on i8)
i99  102.5  16    8
i99  118.5  12   10
i99  130.5  84.5  4


;            time (verb 2 - on i1)
i100  0  283.5  2


;Moore's  rvb (on i104)
;               amp  ;pan  wet  time
i102  138  42   1      .5   .3   2


; Mikelson Tube Amp (on i9)
;    Sta     Dur  PreGain PostGain  DutyOffset  SlopeShift  rvb  balance
i104  138    40   6.2       .5         1           0        .2	   .5


; Global Resonant Filter
; 				  gain   cf1   cf2   bal
i105  265  27     .1    1000  3500  .5  
e