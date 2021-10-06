sr = 44100
kr = 441
ksmps = 100
nchnls = 2


instr    1 ; Random Just Intonation Pitches

ilevl    = p4*100                       ; Output level
iocts    = p5                 ; Octa
irate    = 1                          ; Random rate
aamp linseg 0,.2,1,p3-.4,1,.2,0
kjust    init 1                           ; Initialize just intonation ratio
krand    randh  6, irate, rnd(1)          ; Generate random levels +/11
krand    = krand +6                     ; Offset to +12
kjust    table krand, 45                  ; Read just intonation ratio from table 45
aosc     oscil  ilevl/5, iocts*kjust,8     ; Generate tone
outs      aosc*aamp,aosc*aamp                            ; Output

endin

