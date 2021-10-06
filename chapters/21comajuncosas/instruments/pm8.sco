f1 0 1025 7 -1 1024 1; for a linear mass distribution
;f1 0 256 7 -1 1024 21 1; random values...

f2 0 256 11 50; initial pulse to excite the string

;         k  damping
; for lower damping values the instruments gets crazy (?) 
i2 0 .01
i1 .02 2 .4  1000
s
i2 0 .01
i1 .02 2 .3  300
s
i2 0 .01
i1 .02 15 .5  100
s
i2 0 .01
i1 .02 10 .6  200
e
