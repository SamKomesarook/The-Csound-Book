sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2                                       

          instr     1
k1        linen     5000, .1, p3, .1
k2        linen     5000, .5, p3, .2 
a1        oscil     k1, cpspch(p5), 1
;a2       oscil     k2,   cpspch(p5 * 1.5), 1
;a2       reverb    a1, .5
;a3       balance   (a2 + a1), a1
kpan      oscil     1, .25, 1
          outs      a1*(1+kpan)/2, a1*(1-((1+kpan)/2)) 

          endin
