;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;
;        Some sort of 'morphing' neural instrument         ;
;                                                          ;
;              Coded by Pedro Batista, 1998                ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;

;The training patterns, and stimulus pattern, respective
;soundin numbers are passed during the instrument call.
;Suply the numbers of the patterns you need, and set NumPat
;acordingly. The remaining (rightmost) patterns are ignored

;The valid range for NumPat is 1 to 4, other values default
;to this range.

;You may change the hidden layer's respective sizes. Valid
;values range from 1 to 32 although that can be changed.

;           NumPat:  1    2    3    4
f1 0 4 -2            4    8   16   24

;This table is used for the moving average
f2 0 128 -7 0 128 0

Example:
Run the instrument for 2 seconds.
Use 4 steps, for an error range of .125
Use three training patterns with soundin numbers 1, 2 & 3.
Stimulate the trained net with soundin.99

;   Str Dur Steps NumPat  Pat1 Pat2 Pat3 Pat4  Stim
i1   0   2    4     3      1    2    3    0     99
e
