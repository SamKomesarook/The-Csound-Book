sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

               instr     1
kenv           linen     p6, 0.04, p3, 0.02
if             p8 == 0   goto hertz
asig           oscil     kenv, cpspch(p5), 1
               goto      skiphertz
hertz:
asig      	oscil     kenv, p5, 1
skiphertz:
if             p7 == -1  goto left
if             p7 == 1   goto right
; a1, a2, a3, a4    pan asig, 0.5, 0.5, 2, 1
;              outq      a1, a2, a3, a4
               outq      asig
               goto      end
left:
; a1, a2, a3, a4    pan asig, 0, 0.5, 2, 1
               outq1     asig
               goto      end
right:
; a1, a2, a3, a4    pan asig, 1, 0.5, 2, 1
               outq2     asig
end:
;    		outq      a1, a2, a3, a4
     		endin

               instr     2
     kfall1    line      octcps(12800), 8, octcps(100)
     kfall2    =         cpsoct(kfall1)
     kenv      linseg    0.01, 2, p6, 4, p6, 1.5, 0.1, 0.5, 0.01
     asig      oscil     kenv, kfall2, 1
; a1, a2, a3, a4         pan asig, 0.5, 0.5, 2, 1
;              outq      a1, a2, a3, a4
               outq      asig
               endin

               instr     3
     kenv      linen     p6, 0.0005 * p4 * p4 * p4, p3, 0.02
     kvib      oscil     3 * p4 - 10, cpspch(p5) / (50 * p4), 1
     asig      oscil     kenv, cpspch(p5) + kvib, p4
     		outq1     asig
     		outq2     asig
     		endin
