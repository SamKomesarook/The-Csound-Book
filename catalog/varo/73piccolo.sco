;============================================================================
; PICCOLO - ALGORITHM #5
;============================================================================
; SIMPLE SINE FUNCTION
f01     0       8192     10      1
; OPERATOR OUTPUT LEVEL TO AMP SCALE FUNCTION (DATA FROM CHOWNING/BRISTOW)
f02     0       128     7       0       10      .003    10      .013
        10      .031    10      .079    10      .188    10      .446
        5       .690    5       1.068   5       1.639   5       2.512
        5       3.894   5       6.029   5       9.263   4       13.119
        29      13.119
; RATE SCALING FUNCTION
f03     0       128     7       0       128     1
; EG RATE RISE FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99 (DATA FROM OPCODE)
f04     0       128     -7      38      5       22.8    5       12      5
        7.5     5       4.8     5       2.7     5       1.8     5       1.3
        8       .737    3       .615    3       .505    3       .409    3       
        .321    6       .080    6       .055    2       .032    3       .024
        3       .018    3       .014    3       .011    3       .008    3       
        .008    3       .007    3       .005    3       .003    32      .003
; EG RATE RISE PERCENTAGE FUNCTION
f05     0       128     -7      .00001  31      .00001  4       .02     5
        .06     10      .14     10      .24     10      .35     10      .50
        10      .70     5       .86     4       1.0     29      1.0
; EG RATE DECAY FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99
f06     0       128     -7      318     4       181     5       115     5
        63      5       39.7    5       20      5       11.2    5       7       
        8       5.66    3       3.98    6       1.99    3       1.34    3       
        .99     3       .71     5       .41     3       .15     3       .081
        3       .068    3       .047    3       .037    3       .025    3
        .02     3       .013    3       .008    36      .008
; EG RATE DECAY PERCENTAGE FUNCTION
f07     0       128     -7      .00001  10      .25     10      .35     10
        .43     10      .52     10      .59     10      .70     10      .77
        10      .84     10      .92     9       1.0     29      1.0
; EG LEVEL TO AMP FACTOR MAPPING FUNCTION (INDEX IN RADIANS = INDEX / 2PI)
;f08     0       128     6      .001    96      .5      32      1
;f08   0   128   -6    0   64   .0318   0       .0318   64      2.08795
f08     0       128     -7      0       10      .000477 10      .002
        10      .00493  10      .01257  10      .02992  10      .07098
        5       .10981  5       .16997  5       .260855 5       .39979
        5       .61974  5       .95954  5       1.47425 4       2.08795
        29      2.08795
; VELOCITY TO AMP FACTOR MAPPING FUNCTION (ROUGH GUESS)
f09     0       129     9       .25     1       0
; VELOCITY SENSITIVITY SCALING FUNCTION
f10     0       8       -7      0       8       1
; FEEDBACK SCALING FUNCTION
f11     0       8       -6      0       8       6            
;============================================================================
; OPERATOR 1 PARAMETERS:    
f12     0       32      -2    
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 99       7        39     62     52     63     99     98     97     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        3.96   +6     3

; OPERATOR 2 PARAMETERS
f13     0       32      -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 75       0        79     60     57     .3     63     99     99     0
;AMS      FIXED?   FREQ   DET    RSC
 2        0        4      -1     0
                                                
; OPERATOR 3 PARAMETERS
f14     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 99       0        61     62     52     63     99     98     97     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        4      -5     3
                                                
; OPERATOR 4 PARAMETERS
f15     0       32      -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 67       0        59     60     57     33     63     99     99     0
;AMS      FIXED?   FREQ   DET    RSC
 3        0        4      +6     0
                                               
; OPERATOR 5 PARAMETERS
f16     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 99       0        55     62     52     63     99     98     97     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        3.99   -3     3
 
; OPERATOR 6 PARAMETERS
f17     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 57       0        79     60     57     33     63     99     99     0
;AMS      FIXED?   FREQ   DET    RSC
 3        0        8      +4     0
                                                
;====================================================================;
;                       Yamaha DX7 Algorithm 5                       ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t 0.000 120.000
i1.00  0.000 0.333 67 64      0      0      0      0
12    13       14       15    16      17     2      15000
3     8        4        6     10      9      11     7
i1.01  0.000 7.000 60 64
i1.02  0.333 0.333 72 64
i1.03  0.666 0.333 76 64
i1.04  1.000 2.000 74 64
i1.05  3.000 1.000 77 64
i1.06  4.000 0.333 76 64
i1.07  4.333 0.333 77 64
i1.08  4.666 2.334 79 64
i1.09  8.000 0.333 67 64
i1.10  8.000 8.000 60 64
i1.11  8.333 0.333 72 64
i1.12  8.666 0.333 76 64
i1.13  9.000 2.000 74 64
i1.14  11.000 1.000 77 64
i1.15  12.000 0.333 76 64
i1.16  12.333 0.333 72 64
i1.17  12.666 0.333 67 64
i1.18  13.000 2.000 65 64
i1.19  15.000 0.750 65 64
i1.20  15.750 0.250 72 64
i1.21  16.000 2.000 60 64
i1.22  16.000 2.000 64 64
i1.23  16.000 2.000 72 64
f0    19
e
