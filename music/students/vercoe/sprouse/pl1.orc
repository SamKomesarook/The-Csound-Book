sr             =         44100
kr             =         4410
ksmps          =         10
          
instr          1   					;A SIMPLE AVERAGING INSTRUMENT
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4),0,1
out            a1
endin

instr          4                        ;A SIMPLE AVERAGING WITH A 2X BUFFER SIZE
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4*2),0,1
out            a1
endin

instr          3                        ;A WEIGHTED AVERAGING INSTRUMENT WITH .9,.1 WEIGHTS
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4),0,5,.9,.1
out            a1
endin

instr          2                        ;A FIRST ORDER RECURSIVE FILTER INSTRUMENT
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4),0,6
out            a1
endin

instr          5                        ;A STRETCHED DRUM, ROUGHNESS .02, STRETCH 3
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4),0,4,.02,3
out            a1
endin

instr          6                        ;A SIMPLE DRUM INSTRUMENT WITH ROUGHNESS .05
k1             linen     p5,0,p3,.5
a1             pluck     k1,cpspch(p4),cpspch(p4),0,3,.05
out            a1
endin
