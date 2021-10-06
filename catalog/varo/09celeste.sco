;============================================================================
; CELESTE - ALGORITHM #7
;============================================================================
; SIMPLE SINE FUNCTION
f01     0       4096     10      1
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
;f08     0       128     6       .001    96      .5      32      1
;f08   0   128   -6    0   64   .0318   0   .0318   64   2.08795
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

; OPERATOR 1 PARAMETERS:    
f12     0       32      -2    
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 99       7        99     33     50     40     99     80     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      +3     3

; OPERATOR 2 PARAMETERS
f13     0       32      -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 93       6        99     61     46     89     99     80     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        1        100    0      4
                                                
; OPERATOR 3 PARAMETERS
f14     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 99       7        99     31     50     38     99     80     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      -4     3
                                                
; OPERATOR 4 PARAMETERS
f15     0       32      -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 75       3        90     57     0      33     82     48     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        5      0      0
                                               
; OPERATOR 5 PARAMETERS
f16     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 55       2        99     64     0      8      82     48     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        7      0      0
 
; OPERATOR 6 PARAMETERS
f17     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 87       1        99     77     55     0      78     78     0      0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        7      0      0
                                                
;====================================================================;
;                       Yamaha DX7 Algorithm 7                       ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t 0.000 150.000
i1.001  0.000 0.500 74 80       0      0      0      0
12      13      14    15      16      17     2      8000
3       8       4     6       10      9      11     7     ;7
i1.001  0.000 0.500 74 80 
i1.002  0.000 0.250 84 80 
i1.003  0.250 0.250 85 80 
i1.004  0.500 0.500 73 80 
i1.005  0.500 0.250 84 80 
i1.006  0.750 0.250 85 80  
i1.007  1.000 0.500 72 80 
i1.008  1.000 0.250 86 80 
i1.009  1.250 0.250 87 80 
i1.010  1.500 0.500 71 80 
i1.011  1.500 0.250 86 80 
i1.012  1.750 0.250 87 80 
i1.013  2.000 0.500 70 80 
i1.014  2.000 0.250 88 80 
i1.015  2.250 0.250 89 80 
i1.016  2.500 0.500 69 80 
i1.017  2.500 0.250 88 80 
i1.018  2.750 0.250 89 80 
i1.019  3.000 0.500 68 80 
i1.020  3.000 0.250 90 80 
i1.021  3.250 0.250 91 80 
i1.022  3.500 0.500 67 80
i1.023  3.500 0.250 90 80 
i1.024  3.750 0.250 91 80 
i1.025  4.000 0.250 92 80
i1.026  4.050 0.500 66 80
i1.027  4.250 0.250 93 80
i1.029  4.500 0.500 65 80
i1.030  4.500 0.250 92 80 
i1.031  4.750 0.250 93 80 
i1.032  5.000 0.500 64 80 
i1.033  5.000 0.250 94 80 
i1.034  5.250 0.250 95 80 
i1.035  5.500 0.500 63 80 
i1.036  5.500 0.250 96 80 
i1.037  5.750 0.250 97 80 
i1.038  6.000 0.500 62 80 
i1.039  6.000 0.500 98 80 
i1.040  7.000 0.500 50 80 
f0             10
e

