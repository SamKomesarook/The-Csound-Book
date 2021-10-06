f1 0 65536 10 1                          ; Sine
f3 0 1024  -7 1 10 1 7 0 990 0 7 1 10 1  ; Pulse: Wider pulses make softer syncs.

; Synth with sync
;   Sta  Dur  Amp   Pitch  SyncFqc
i12 0    .5   30000 6.00   0.666
i12 +    .    .     6.05   .
i12 .    .    .     6.07   .
i12 .    .    .     7.00   .
s

i12 0    .5   30000 7.00   0.666
i12 +    .    .     7.05   .
i12 .    .    .     7.07   .
i12 .    .    .     8.00   .

