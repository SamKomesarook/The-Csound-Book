;FILENAME: FM.SCO
;PURPOSE: TEST NEW FM SYNTHESIS IN JAES SEPT 1988.
;WRITTEN BY:
;    TOM V. J. MAGLIONE
;    29 RICE ROAD
;    WAYLAND, MASSACHUSETTS 01778
;    (508) 655-9120
;WRITTEN ON: WEDNESDAY 26-OCTOBER-1988, 16:32
;
f1 0 8192 -12 8                         ;BESSEL FUNCTION TABLE
f2 0 8192 9   1 1 0                     ;SINE WAVE TABLE
f3 0 8192 9   1 1 90                    ;COSINE WAVE TABLE
;
i1 0  2 0 0 4 1     400  200
i1 2  2 0 0 4 1.25  400  200
i1 4  2 0 0 4 0.8   400  200
;
i2 6  2 0 0 4 1          400  200
i2 8  2 0 0 4 1.25  400  200
i2 10 2 0 0 4 0.8   400  200
;
i3 12 2 0 0 0 0          400  200
i3 14 2 0 0 1 0          400  200
i3 16 2 0 0 2 0          400  200
i3 18 2 0 0 3 0          400  200
i3 20 2 0 0 4 0          400  200
e
