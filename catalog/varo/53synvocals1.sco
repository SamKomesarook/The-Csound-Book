;============================================================================
; SYNTH VOCALS 1 - ALGORITHM #3
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
 95       0        71     24     19     37     99     99     99     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      0      2

; OPERATOR 2 PARAMETERS
f13     0       32      -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 81       0        25     36     21     37     99     90     80     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      0      2
                                                
; OPERATOR 3 PARAMETERS
f14     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 67       0        64     24     19     37     99     86     86     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      0      2
                                                
; OPERATOR 4 PARAMETERS
f15     0       32      -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 83       0        34     36     21     37     99     99     99     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      0      2
                                               
; OPERATOR 5 PARAMETERS
f16     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 86       0        66     92     22     37     53     61     62     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1      0      0
 
; OPERATOR 6 PARAMETERS
f17     0       32      -2
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
 76       0        64     54     22     37     99     62     62     0
;AMS      FIXED?   FREQ   DET    RSC
 0        0        1.05   0      0
                                                
;====================================================================;
;                       Yamaha DX7 Algorithm 3                       ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t 0.000 90.000
i1.01 0.000 7.421 63 36      0      0      0      0
12    13       14       15    16      17     2      10000
3     8        4        6     10      9      11     6
i1.02 0.008 7.500 66 32
i1.03 0.013 3.885 47 54
i1.04 0.025 3.508 59 26
i1.05 1.917 1.713 71 52
i1.06 3.898 3.565 58 34
i1.07 3.902 3.365 51 52
i1.08 3.919 3.625 70 15
i1.09 5.852 0.994 39 49
i1.10 7.979 1.398 66 29
i1.11 7.992 1.337 63 37
i1.12 7.996 3.502 47 30
i1.13 8.017 1.173 59 33
i1.14 9.915 1.044 75 55
i1.15 10.975 0.306 71 57
i1.16 11.865 3.765 70 38
i1.17 11.877 0.785 39 49
i1.18 11.879 0.758 51 49
i1.19 11.890 3.644 66 41
i1.20 11.902 3.458 63 44
i1.21 11.925 3.529 58 20
i1.22 15.877 3.894 61 38
i1.23 15.879 3.908 68 58
i1.24 15.894 7.531 37 40
i1.25 15.902 7.579 49 31
i1.26 15.913 3.937 64 46
i1.27 17.938 2.056 73 44
i1.28 19.952 3.371 68 54
i1.29 19.975 3.392 61 35
i1.30 19.994 3.333 64 45
i1.31 23.935 3.785 40 72
i1.32 23.938 3.679 52 56
i1.33 23.952 3.206 68 59
i1.34 23.954 3.383 64 54
i1.35 23.965 0.690 71 57
i1.36 24.896 1.348 73 49
i1.37 25.971 1.010 75 64
i1.38 26.979 1.038 76 80
i1.39 27.987 7.392 66 57
i1.40 27.994 7.210 42 58
i1.41 27.994 7.192 54 65
i1.42 28.000 3.925 75 73
i1.43 28.013 3.565 71 75
i1.44 31.915 3.429 73 58
i1.45 31.921 3.423 70 46
i1.46 35.858 3.681 61 25
i1.47 35.860 8.127 63 53
i1.48 35.869 8.144 47 54
i1.49 35.963 3.906 71 9
i1.50 39.956 4.033 66 38
i1.51 39.969 4.042 59 37
f0    45
e
