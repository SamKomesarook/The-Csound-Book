;---------------------------------------------------------------------------
; PITCH SHIFTER
;---------------------------------------------------------------------------
i 3002  0.0  .8  16000  7.00   0     1    1
i 3002  0.8  .4  16000  7.00   0     1    1
i 3002  1.2  .8  16000  7.00   0     1    1

; SAW WAVE
f 9 0 1024 7 1 1024 0

; PITCH SHIFTER NEWFQC=SHIFT*FQC
;      STA  DUR  SHIFT  TABLE  INCH  OUTCH
i 3022 0.0  .8   .995   9      1     2       ; STEREO DETUNE
i 3022 0.8  .4   1.5    9      1     2       ; UP A FIFTH
i 3022 1.2  .8   .5     9      1     2       ; DOWN AN OCTAVE

; MIXER
;      STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i 3099 0   2.0  1    1     1    2    1     0    6    0     1    7    0     0

