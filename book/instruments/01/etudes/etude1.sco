; Function 1 uses the GEN10 subroutine to compute a sine wave
; Function 2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
; Function 3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope
; Function 4 uses the GEN01 subroutine to read in an AIF audio file

f 1  0 4096 10   1    
f 2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f 3  0 4097 20   2  1
f 4  0 0    1   "sing.aif" 0 4 0


;inst	start	duration
i 101		0		3
i 102		4		3
i 103  		8       3
i 104    	12      3
i 105     	16      3
i 106     	20      2.3



