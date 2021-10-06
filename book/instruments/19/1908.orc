sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr     1908
ax        init      p5                   ; LORENZ ATTRACTOR
ay        init      p6
az        init      p7
as        init      p8
ar        init      p9
ab        init      p10
ah        init      p11
ipanl     init      p12
ipanr     init      1-ipanl

kampenv   linseg    0, .01, p4, p3-.02, p4, .01, 0
axnew     =         ax+ah*as*(ay-ax)
aynew     =         ay+ah*(-ax*az+ar*ax-ay)
aznew     =         az+ah*(ax*ay-ab*az)
ax        =         axnew
ay        =         aynew
az        =         aznew
          outs      ax*kampenv*ipanl,ay*kampenv*ipanr
          endin

