f1 0 256 10 1                                          ; SINUSOID
; f2 0 8193 9 0.25 1 0                                 ; FIRST QUADRANT OF A SINUSOID
f3 0 1024 10 1 0 2.1 0 1 0 1.3 0 0.5                   ; ONE TIMBRE
f4 0 1024 10 1 0.5 0.25 0.125 0.0625 0.03125           ; ANOTHER

t 0 60 70 200

; FIRST ILLUSION -- SEPARATE STIMULI TO RIGHT AND LEFT EARS
i1 0 1 0 880 5000 1 0
i1 2
i1 4
i1 6
i1 8
i1 10
i1 1 1 0 440 5000 -1 0
i1 3
i1 5
i1 7
i1 9
i1 11
i1 1 1 0 440 5000 1 0
i1 3
i1 5
i1 7
i1 9
i1 11
i1 0 1 0 880 5000 -1 0
i1 2
i1 4
i1 6
i1 8
i1 10

; SECOND ILLUSION -- SIMILAR, BUT FORMING SCALES
i1 15 1 0 9.00 5000 1 1
i1 + . . 8.02
i1 + . . 8.09
i1 + . . 8.05
i1
i1 + . . 8.09
i1 + . . 8.02
i1 + . . 9.00
i1 15 1 0 8.00 5000 -1 1
i1 + . . 8.11
i1 + . . 8.04
i1 + . . 8.07
i1
i1 + . . 8.04
i1 + . . 8.11
i1 + . . 8.00

; THIRD ILLUSION -- ACTUALLY RAISING THE NOTES APPEARS TO LOWER THEM
i1 25 6 0 100 500 0 0
i1 . . . 220 2500
i1 . . . 484 4000
i1 . . . 1064.8 .
i1 . . . 2342.56 2500
i1 . . . 5153.632 500
i1 31 . . 200 .
i1 . . . 440 2500
i1 . . . 968 4000
i1 . . . 2129.6 .
i1 . . . 4685.12 2500
i1 . . . 10307.264 500

; FOURTH ILLUSION -- DESCENDING SHEPARD TONE
i2 40 8 0 0 5000
i2 41
i2 42
i2 43
i2 44
i2 45
i2 46
i2 47
i2 48
i2 49
i2 50
i2 51
i2 52
i2 53
i2 54
i2 55
i2 56
i2 57

; FIFTH ILLUSION -- CHANGES IN TIMBRE
; FIRST, THE ENTIRE LINE IN ONE TIMBRE
i3 70 1 3 8.00 5000
i3 + . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . . . 8.00
i3 . . . 8.04
i3 . . . 8.07
i3 . 3 . 9.00

; NOW WITH TWO DISTINCT TIMBRES, WE WILL HEAR DESCENDING LINES
i3 100 1 3 8.00
i3 + . 4 8.04
i3 . . 3 8.07
i3 . . 4 8.00
i3 . . 3 8.04
i3 . . 4 8.07
i3 . . 3 8.00
i3 . . 4 8.04
i3 . . 3 8.07
i3 . . 4 8.00
i3 . . 3 8.04
i3 . . 4 8.07
i3 . . 3 8.00
i3 . . 4 8.04
i3 . . 3 8.07
i3 . . 4 8.00
i3 . . 3 8.04
i3 . . 4 8.07
i3 . . 3 8.00
i3 . . 4 8.04
i3 . . 3 8.07
i3 . . 4 8.00
i3 . . 3 8.04
i3 . . 4 8.07
i3 . 3 3 8.00
i3 124 3 4 8.00

; THAT'S ALL, FOLKS!
e
