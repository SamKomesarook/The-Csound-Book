;1105.SCO   NOISE AND TRAIN OF PULSES GENERATORS
;             (C) RAJMIL FISCHMAN, 1997
;------------------------------------------------
;SINEWAVE
f1 0 8192 10 1
;NOISE WITH RAND
;------------------------------------------
;            p3   p4    p5     p6     p7      
;INSTR START DUR  AMP   UNUSED ATTACK DECAY      
;------------------------------------------
i 1105     0     2    9000  0      .1     .1
s
;TRAIN OF PULSES WITH BUZZ
;------------------------------------------
;            p3   p4    p5     p6     p7      
;INSTR START DUR  AMP   FREQ   ATTACK DECAY      
;------------------------------------------
i 1106     1.5   2    30000 75     .1     .1 
