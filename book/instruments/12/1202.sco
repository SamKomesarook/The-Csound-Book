f 1 0   2048    10  1   ;SIMPLE SINE WAVE               
;   ST  DUR AMP PCH CFAC    MFAC    INDEX   RISE    DEC
i 1202  0   1   20000   8.09    1   1   5   .05 .01
;   AFACT   REL XFAC1   XRIS    XDEC    XFAC2   XREL    DETUNE  
    1   .2  0   .1  .5  .25 .25 0   
i 1202  2   .   .   .   3   1   2   .   .
    .   .   .   .   .01 1   .25     
i 1202  4   .   .   6.09    5   1   1.5     
                                    
i 1202  6   .   .   8.09    3   2   4   .   .
    .   .   .5  .   .   1           
;THREE NOTES SLIGHTLY DETUNED AND SLIGHTLY STAGGERED ENTRANCES                                  
i 1202  8   6   10000   6.00    1   1.4 10  3   1.9
    .7  1   0   3   1.9 .25 1       
i 1202  8.005   .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   1   
i 1202  8.012   .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   -1  
