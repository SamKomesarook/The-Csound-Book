
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2004
iharm     =         int(44100/(p4>p5 ? p4:p5)/2)-1     ; MAX HARM W/O ALIAS
a1        linseg    0, 0.05, 30000, p3-0.1, 30000, 0.05, 0, 1, 0
afreq     expon     p4, p3, p5
a2        buzz      1, afreq, iharm, 1, -1
          out       a1*a2
          endin
