<CsoundSynthesizer>
;<CsOptions>

;</CsOptions>
<CsInstruments>
sr             =              44100
kr             =              441
ksmps          =              100
nchnls         =              1

instr 1
     ; START I13 AFTER .5 SEC (NOT)
               schedule       13, .5, 2.33, 550, 0
endin

instr 2
     ; START I3 AFTER 1 SEC 
     ;   SINCE THIS DOESN'T WORK, IT STARTS AFTER 4.0 INSTEAD OF 5.0 SECS
     ; IT SHOULD BE TURNED OFF AFTER 2.33 SECS, BUT HANGS UNTIL NEXT SCORE EVENT
               schedwhen      1, 13, 1, 2.33, 440
endin

instr 13
     ; ITIME IS ACTUAL START TIME, P2 IS THE INTENDED, 
     ; AND P4=P3, P5=P4 IF STARTED BY SCHEDWHEN
               itime          times     
               print          itime, p2, p3, p4, p5

     ; SINCE P4 WON'T ALWAYS BE CORRECT, WE SET A START PITCH HERE
     kpitch    line           440, p3, p4
     ; NOW WE'RE NAUGHTY TO RUB IN THE POINT: THIS LINSEG CONTINUES BEYOND P3
     ; - BUT THE ERROR SHOWS EVEN IF YOU REMOVE THE LAST ", .5, 20000" ARGS
     kamp      linseg         25000, p3-.1, 25000, .1, 0, .5, 20000
     ar        oscili         kamp, kpitch, 1
               out            ar
endin

</CsInstruments>
<CsScore>
f1 0 4096 10 1

i1 0 3.5
i2 4 6
f0 10

e

</CsScore>
</CsoundSynthesizer>
