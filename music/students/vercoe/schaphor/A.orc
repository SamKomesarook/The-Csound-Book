sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

               instr     1
kamp           linseg    2000, 36, 2000, 70, 0 
kwidth         linseg    0, 2.25, 10, 2.25, 0, 2.25, 0, 2.25, 0, 2.25, 10, 2.25, 0, 2.25, 0, 2.25, 10, 2.25, 0, 2.25, 10, 2.25, 0, 2.25, 10, 2.25, 0, 2.25, 0, 2.25, 0, 2.25, 0, 70, 0  
kvib           oscil     kwidth, 4, 1
a1             oscil     kamp, 440+kvib, 1
a2             tone      a1, 440
               out       a1
               endin
