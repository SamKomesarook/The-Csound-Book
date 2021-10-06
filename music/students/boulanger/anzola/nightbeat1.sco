f1 0 8192 10 1
f2 0 128 5 1 128 8   ;for veloc to non-linear amp
f3 0 2048 7 1 2048 0
f4 0 1024   8 -.8 42 -.78  400 -.7 140 .7  400 .78 42 .8 ; Distortion Table for RezzyFilter
f5 0 262144 -1 "NightBeat.aif" 0 4 0

t 0 175

f0 70 ; to stop compilation


;Instr 2 SampleDrum NightBeat

;              dur
i2   14        .5
i2   14.5 1
i2   15.5 .5
i2   16        14
i2   30        .5
i2   30.5 1
i2   31.5 .5 
i2   32        14
i2   46        .5
i2   46.5 .5
i2   47        .5
i2   47.5 .25
i2   47.75     .25
i2   48        16

e
