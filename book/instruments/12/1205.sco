;==========================================================;
;TEST SCORE FOR DX7 ALG 16 ORC 
;(IMITATES THE �PLUK16.1� VOICE...SORT OF)
;==========================================================;
f 1 0   512 10  1                   
;OPERATOR OUTPUT LEVEL TO AMP SCALE FUNCTION
;(DATA FROM CHOWNING/BRISTOW)
f 2 0   128 7   0   10  .003    10  .013    
    10  .031    10  .079    10  .188    10  .446    
    5   .690    5   1.068   5   1.639   5   2.512   
    5   3.894   5   6.029   5   9.263   4   13.119  
    29  13.119                          
; RATE SCALING FUNCTION
f 3 0   128 7   0   128 1           
; EG RATE RISE FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99 ;
 ; (DATA FROM OPCODE)
f 4 0   128 -7  38  5   22.8    5   12  5
    7.5 5   4.8 5   2.7 5   1.8 5   1.3
    8   .737    3   .615    3   .505    3   .409    3 
    .321    6   .080    6   .055    2   .032    3   .024
    3   .018    3   .014    3   .011    3   .008    3 
    .008    3   .007    3   .005    3   .003    32  .003
; EG RATE RISE PERCENTAGE FUNCTION
f 5 0   128 -7  .00001  31  .00001  4   .02 5
    .06 10  .14 10  .24 10  .35 10  .50
    10  .70 5   .86 4   1.0 29  1.0 
; EG RATE DECAY FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99
f 6 0   128 -7  318 4   181 5   115 5
    63  5   39.7    5   20  5   11.2    5   7 
    8   5.66    3   3.98    6   1.99    3   1.34    3 
    .99 3   .71 5   .41 3   .15 3   .081
    3   .068    3   .047    3   .037    3   .025    3
    .02 3   .013    3   .008    36  .008        
; EG RATE DECAY PERCENTAGE FUNCTION
f 7 0   128 -7  .00001  10  .25 10  .35 10
    .43 10  .52 10  .59 10  .70 10  .77
    10  .84 10  .92 9   1.0 29  1.0 
;EG LEVEL TO PEAK DEVIATION MAPPING FUNCTION
;(INDEX IN RADIANS/2PI)
f 8 0   128 -7  0   10  .000477 10  .002    
    10  .00493  10  .01257  10  .02992  10  .07098  
    5   .10981  5   .16997  5   .260855 5   .39979  
    5   .61974  5   .95954  5   1.47425 4   2.08795 
    29  2.08795                         
; VELOCITY TO AMP FACTOR MAPPING FUNCTION (ROUGH GUESS)
f 9 0   129 9   .25 1   0           
; VELOCITY SENSITIVITY SCALING FUNCTION (SEEMS LINEAR)
f 10    0   8   -7  0   8   1           
; FEEDBACK SCALING FUNCTION (SEEMS LINEAR)
f 11    0   8   -7  0   8   7           
; OPERATOR 1 PARAMS:    OUTLVL  KEYVEL  EGR1    EGR2    EGR3    EGR4
f 12    0   32  -2  99  1   99  33  14  38
;                       EGL1    EGL2    EGL3    EGL4
                        99  80  0   0
;                       AMS FIXED?  FREQ    DET
                        0   1   1   0
;                       RSS         
                        2           
; OPERATOR 2 PARAMETERS
f 13    0   32  -2  67  6   75  45  36  19
                        99  87  0   0
                        0   0   11.22   -2
                        2           
; OPERATOR 3 PARAMETERS
f 14    0   32  -2  99  7   99  30  34  46
                        99  80  0   0 
                        0   0   .5  0
                        0           
; OPERATOR 4 PARAMETERS
f 15    0   32  -2  78  7   90  67  21  82
                        99  85  0   0
                        0   0   7   0
                        0           
; OPERATOR 5 PARAMETERS
f 16    0   32  -2  99  4   99  64  0   8
                        85  48  0   0
                        0   0   3   0
                        0           
; OPERATOR 6 PARAMETERS
f 17    0   32  -2  99 1    99  82  75  0   
                        99  87  0   0
                        0   1   2570    0
                        0           
;==========================================================;
; YAMAHA DX7 ALGORITHM 16
; P2 = START    P3 = DUR    P4 = PCH    P5 = VEL
; P6 = PANFAC   P7 = VIBDEL P8 = VIBWTH P9 = LFOHZ
; P10 = OP1FN   P11 = OP2FN P12 = OP3FN P13 = OP4FN
; P14 = OP5FN   P15 = OP6FN P16 = AMPFN P17 = PKAMP
; P18 = RSFN    P19 = DEVFN P20 = ERISFN    P21 = EDECFN
; P22 = VSFN    P23 = VELFN P24 = FEEDFN    P25 = FEEDBK
;==========================================================;
i 1205  0   .49 6.00    107 0   0   0   0   
    12  13  14  15  16  17  2   20000   
    3   8   4   6   10  9   11  7   
i 1205  1.00    .54 6.07    107 1               
i 1205  2.00    .16 6.08    85  .1              
i 1205  2.49    .20 7.03    100 .9              
i 1205  3.01    .20 7.04    84  .2              
i 1205  3.50    .18 7.11    100 .8              
i 1205  4.01    .15 8.00    85  .3              
i 1205  4.24    .13 8.07    79  .7              
i 1205  4.50    .07 8.08    82  .4              
i 1205  4.72    .09 9.03    100 .6              
;DELAYED VIBRATO ON LAST NOTE
i 1205  4.98    .16 9.00    110 .5  1   .05 7   
f0  9               ;ALLOW FOR THE FINAL DECAY
