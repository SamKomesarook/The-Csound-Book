; SCORE
f1 0 16384 10 1

; LFO Note 0<PWM<1
;   Sta  Dur  Amp  Fqc  Wave  Offset  OutCh
i5  0    12   .8   1    1     .5       1

; Synth Wave 1=Saw, 2=Square/PWM, 3=Tri/Saw-Ramp-Mod
;   Sta  Dur  Amp   Pitch  Fco   Rez  Wave  PulseWCh
i10 0    1    20000 6.00   5000  20   1     1
i10 +    .    .     7.00   .     .    .     .
i10 .    .    .     8.00   .     .    .     .
i10 .    .    .     9.00   .     .    .     .

i10 .    .    .     6.00   .     .    2     .
i10 .    .    .     7.00   .     .    .     .
i10 .    .    .     8.00   .     .    .     .
i10 .    .    .     9.00   .     .    .     .

i10 .    .    .     6.00   .     .    3     .
i10 .    .    .     7.00   .     .    .     .
i10 .    .    .     8.00   .     .    .     .
i10 .    .    .     9.00   .     .    .     .
