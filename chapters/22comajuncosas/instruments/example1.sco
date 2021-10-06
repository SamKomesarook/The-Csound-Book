f1 0 8193 10 1; a sine wave from -1 to 1 for table index
f2 0 8193 19 1 1 0 1; a sine wave from 0 to 1 for table number
i1 0 1
s

; As you cannot index tables outside the (normalized) range 0 to 1
; and the max. radius of the orbit is .3 (see the orc)
; DON´T set p6 (the y coordinate) bigger than .7 or smaller than .3 !
; With the x there´s not this problem as 
; the tableikt opcode is set to wrap mode 
; (which is consistent with the periodic nature of GEN11)
i2 0 2 5.07 .5 .5
i2 2 4 6.01 .5 .5
f0 2
s
i2 0   25 6.00 .5  .5
i2 1.5 25 5.00 .45 .48
i2 2.4 25 6.00 .63 .6
i2 3.3 25 5.00 .21 .59
i2 4.8 25 6.00 .12 .64
i2 5   25 6.00 .94 .4

e