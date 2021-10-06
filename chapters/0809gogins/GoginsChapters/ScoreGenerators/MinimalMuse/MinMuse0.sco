f   1  0 4096 10 1 ; Sine wave.
f   2  0 4096 10 1 .2 .08 .07 ; Flute-like.
f   3  0 4096 10 1 .4 .2 .1 .1 .05
f   4  0 512 7 0 1 0 49 .2 90 .6 40 .99 25 .9 45 .5 50 .25 50 .12 50 .06 50 .02 62 0
f   5  0 512 7 0 1 0 49 .2 100 .6 50 .99 150 .2 162 0
f   6  0 512 7 0 1 0 49 .2 200 .5 100 .2 162 0
f   7  0 512 7 0 1 0 79 .5 60 .5 20 .99 120 .4 140 .6 92 0
f   8  0.0  5 .001  1 ; Eexponential rise
f  12  0 512 9 1 .26 0
f  13  0 512 9 1 .3 0
f  23  0 512 9 1 1 0
f  24  0 512 -7 3000 71 3000 168 2300 100 2100 71 2000 102 2000
f  25  0 512 -7 .025 71 .02 102 .025 71 .05 268 .06
f  26  0 512 -7 .25 71 .25 102 .08 .05 339 .05
f  27  0 512 -7 5 71 2.3 102 1.5 237 2.5 102 2.3
f  28  0 512 -7 5 512 6.5
f  30  0 8192 10 1
f  31  0 2048 19 .5 1 270 1
f  32  0 512 -7 -1 150 .1 110 0 252 0
f  33  0 1024 10 .3 0 0 0 .1 .1 .1 .1 .1 .1
f  34  0  8192  9  1 1 90       ; Cosine for Fitch instruments.
f  41  0 8193 10 1  ; Sine wave.
f  42  0 8193 11 1  ; Cosine wave.
f  43  0 8192 -12 20.0  ; Unscaled ln(I(x)) from 0 to 20.0.
f  44  0 4097 10 1 .25 .1 ; Kelley flute.
f  45  0 2049 7 -1 1800 1 249 -1 ; Kelley string.
f  46  0 2049 7 -1 1024 1 1024 -1 ; Kelley harpsichord.
f  47  0 2049 10 1 0 1 0 1 ; Kelley oboe.
f  48  0  10 3 1 0 .25 .3 .76 ; Nelson Chebyshev.
f  49  0  13 1 1 .9 .8 .7 .6 .5 .4 .3 .2 .1 ; Nelson table lookup.
f  50  0 8193 20 2 1 ; Hanning window.
f  51  0 8193 -10  809 14581 2030 990 522 1545 2030 262 61 45 45 64 465  139 19 75 29 42 39 96 86 75 39 45 ; Horner Erhu
f  52  0 8193 -10 1567 910 870  3119 595 151 45  111 123 31 41 127  148 196 124 142 49 22 22 59 74 37 ; Horner Erhu
f  53  0 8193 -10 2411 1158 352 922 854 70 66 152 83 15 69 69 92 91 60 30  42 78 38 41 59 22 ; Horner Erhu
f  54  0 8193 -10 18607 805 771 832 115 166 115 21 66 22 135 165 18 41 85  27 93 23 8 15 23 7 ; Horner Erhu
f  55  0 8193 7  0 819 1.1 819 1.2 820 1.4 819 1.2 819 1.15 820 0 8200 0 ; Horner Erhu
f  61  0 8193 -10  30 37 282 99 29 327 96 77 102 11 45 7 4 3 1 1; Horner Pipa
f  62  0 8193 -10  324 300 144 160 383 847 1311 1121 885 586 125 174 269  100 428 190 563 294 178 236 169 173 75 57 52 57 131 43 134 77 54 51  60 107 51 274 54 30 23 66 20 12 ; Horner Pipa
f  63  0 8193 -10  79 51 133 10 21 20 7 3 11 4 3 2 1 2 1 2 ; Horner Pipa
f  64  0 8193 -10  475 207 545 323 104 1890 1304 1031 350 269 245 180  200 43 45 14 13 8 13 34 16 28 16 3 3 ; Horner Pipa
f  65  0 8193 -10  8 24 10 14 35 30 19 31 16 16 11 6 2 7 8 9 13 11 3 2 3  1 4 2 2 2 1 2 2 1 3 3 1 4 2 3 1; Horner Pipa
f  66  0  13 1 1 .9 .8 .7 .6 .5 .4 .3 .2 .1 ;gen 13 table lookup (was 31)
f  67  0  13 1 1 .9 .8 .7 .6 .7 .8 .9 1 ;gen 13 table lookup (was 32)
f  77  0 4096 10 .28 1 .74 .66 .78 .48 .05 .33 .12 .08 .01 .54 .19 .08 .05 .16 .01 .11 .3 .02 .2 ; Bergeman f1
f 100  0 2048 -17 0 101 575 102 625 103 675 104 725 105 775 106 825 107 875 108 925 109 975 110 1025 111  1075 112 1125  113 1175  114 ; Steinway octave : tablenumber
f 101  0 2048 -17 0 5.5  575      6 625  6.5 675      7 725  7.5 775      8 825  8.5  875     9 925  9.5  975   10 1025 10.5 1075   11 1125 11.5 1175     12 ; Steinway octave : baseoctave
f 102  0  0 1 "Steinway102.aif" 0 4 0 ;  5.50
f 103  0  0 1 "Steinway103.aif" 0 4 0 ;  6.00
f 104  0  0 1 "Steinway104.aif" 0 4 0 ;  6.50
f 105  0  0 1 "Steinway105.aif" 0 4 0 ;  7.00
f 106  0  0 1 "Steinway106.aif" 0 4 0 ;  7.50
f 107  0  0 1 "Steinway107.aif" 0 4 0 ;  8.00
f 108  0  0 1 "Steinway108.aif" 0 4 0 ;  8.50
f 109  0  0 1 "Steinway109.aif" 0 4 0 ;  9.00
f 110  0  0 1 "Steinway110.aif" 0 4 0 ;  9.50
f 111  0  0 1 "Steinway111.aif" 0 4 0 ; 10.00
f 112  0  0 1 "Steinway112.aif" 0 4 0 ; 10.50
f 113  0  0 1 "Steinway113.aif" 0 4 0 ; 11.00
f 114  0  0 1 "Steinway114.aif" 0 4 0 ; 11.50
f 115  0  0 1 "Steinway115.aif" 0 4 0 ; 12.00

i 1 0 2.48958 5 60 0
i 1 0.0920699 2.48958 5.6087 60 0
i 1 0.18414 2.48958 9.86957 60 0
i 1 0.27621 0.5 12 60 0
i 1 0.322245 0.5 10.1739 60 0
i 1 0.36828 2.48958 8.34783 60 0
i 1 0.460349 2.48958 9.26087 60 0
i 1 0.644489 2.48958 8.65217 60 0
i 1 0.736559 2.48958 11.3913 60 0
i 1 0.828629 2.48958 10.4783 60 0
i 1 0.920699 2.48958 9.56522 60 0
i 1 1.01277 2.48958 8.65217 60 0
i 1 1.10484 2.48958 8.65217 60 0
i 1 1.19691 2.48958 5 60 0
i 1 1.38105 2.48958 5 60 0
i 1 1.47312 2.48958 5 60 0
i 1 1.56519 2.48958 5.6087 60 0
i 1 1.65726 2.48958 9.86957 60 0
i 1 1.74933 0.5 12 60 0
i 1 1.79536 0.5 10.1739 60 0
i 1 1.8414 2.48958 8.34783 60 0
i 1 1.93347 2.48958 9.26087 60 0
i 1 2.11761 2.48958 8.65217 60 0
i 1 2.20968 2.48958 11.3913 60 0
i 1 2.30175 2.48958 10.4783 60 0
i 1 2.39382 2.48958 9.56522 60 0
i 1 2.48589 2.48958 8.65217 60 0
i 1 2.57796 2.48958 8.65217 60 0
i 1 2.67003 2.48958 5 60 0
i 1 2.85417 2.48958 5 60 0
i 1 2.94624 2.48958 5 60 0
i 1 3.03831 2.48958 5.6087 60 0
i 1 3.13038 2.48958 9.86957 60 0
i 1 3.22245 0.5 12 60 0
i 1 3.26848 0.5 10.1739 60 0
i 1 3.31452 2.48958 8.34783 60 0
i 1 3.40659 2.48958 9.26087 60 0
i 1 3.59073 2.48958 8.65217 60 0
i 1 3.6828 2.48958 11.3913 60 0
i 1 3.77487 2.48958 10.4783 60 0
i 1 3.86694 2.48958 9.56522 60 0
i 1 3.95901 2.48958 8.65217 60 0
i 1 4.05108 2.48958 8.65217 60 0
i 1 4.14315 2.48958 5 60 0
i 1 4.32728 2.48958 5 60 0
i 1 4.41935 2.48958 5 60 0
i 1 4.51142 2.48958 5.6087 60 0
i 1 4.60349 2.48958 9.86957 60 0
i 1 4.69556 0.5 12 60 0
i 1 4.7416 0.5 10.1739 60 0
i 1 4.78763 2.48958 8.34783 60 0
i 1 4.8797 2.48958 9.26087 60 0
i 1 5.06384 2.48958 8.65217 60 0
i 1 5.15591 2.48958 11.3913 60 0
i 1 5.24798 2.48958 10.4783 60 0
i 1 5.34005 2.48958 9.56522 60 0
i 1 5.43212 2.48958 8.65217 60 0
i 1 5.52419 2.48958 8.65217 60 0
i 1 5.61626 2.48958 5 60 0
i 1 5.8004 2.48958 5 60 0
i 1 5.89247 2.48958 5 60 0
i 1 5.98454 2.48958 5.6087 60 0
i 1 6.07661 2.48958 9.86957 60 0
i 1 6.16868 0.5 12 60 0
i 1 6.21472 0.5 10.1739 60 0
i 1 6.26075 2.48958 8.34783 60 0
i 1 6.35282 2.48958 9.26087 60 0
i 1 6.53696 2.48958 8.65217 60 0
i 1 6.62903 2.48958 11.3913 60 0
i 1 6.7211 2.48958 10.4783 60 0
i 1 6.81317 2.48958 9.56522 60 0
i 1 6.90524 2.48958 8.65217 60 0
i 1 6.99731 2.48958 8.65217 60 0
i 1 7.08938 2.48958 5 60 0
i 1 7.27352 2.48958 5 60 0
i 1 7.36559 2.48958 5 60 0
i 1 7.45766 2.48958 5.6087 60 0
i 1 7.54973 2.48958 9.86957 60 0
i 1 7.6418 0.5 12 60 0
i 1 7.68784 0.5 10.1739 60 0
i 1 7.73387 2.48958 8.34783 60 0
i 1 7.82594 2.48958 9.26087 60 0
i 1 8.01008 2.48958 8.65217 60 0
i 1 8.10215 2.48958 11.3913 60 0
i 1 8.19422 2.48958 10.4783 60 0
i 1 8.28629 2.48958 9.56522 60 0
i 1 8.37836 2.48958 8.65217 60 0
i 1 8.47043 2.48958 8.65217 60 0
i 1 8.5625 2.48958 5 60 0
i 1 8.74664 2.48958 5 60 0
i 1 8.83871 2.48958 5 60 0
i 1 8.93078 2.48958 5.6087 60 0
i 1 9.02285 2.48958 9.86957 60 0
i 1 9.11492 0.5 12 60 0
i 1 9.16095 0.5 10.1739 60 0
i 1 9.20699 2.48958 8.34783 60 0
i 1 9.29906 2.48958 9.26087 60 0
i 1 9.4832 2.48958 8.65217 60 0
i 1 9.57527 2.48958 11.3913 60 0
i 1 9.66734 2.48958 10.4783 60 0
i 1 9.75941 2.48958 9.56522 60 0
i 1 9.85148 2.48958 8.65217 60 0
i 1 9.94355 2.48958 8.65217 60 0
i 1 10.0356 2.48958 5 60 0
i 1 10.2198 2.48958 5 60 0
i 1 10.3118 2.48958 5 60 0
i 1 10.4039 2.48958 5.6087 60 0
i 1 10.496 2.48958 9.86957 60 0
i 1 10.588 0.5 12 60 0
i 1 10.6341 0.5 10.1739 60 0
i 1 10.6801 2.48958 8.34783 60 0
i 1 10.7722 2.48958 9.26087 60 0
i 1 10.9563 2.48958 8.65217 60 0
i 1 11.0484 2.48958 11.3913 60 0
i 1 11.1405 2.48958 10.4783 60 0
i 1 11.2325 2.48958 9.56522 60 0
i 1 11.3246 2.48958 8.65217 60 0
i 1 11.4167 2.48958 8.65217 60 0
i 1 11.5087 2.48958 5 60 0
i 1 11.6929 2.48958 5 60 0
i 1 11.7849 2.48958 5 60 0
i 1 11.877 2.48958 5.6087 60 0
i 1 11.9691 2.48958 9.86957 60 0
i 1 12.0612 0.5 12 60 0
i 1 12.1072 0.5 10.1739 60 0
i 1 12.1532 2.48958 8.34783 60 0
i 1 12.2453 2.48958 9.26087 60 0
i 1 12.4294 2.48958 8.65217 60 0
i 1 12.5215 2.48958 11.3913 60 0
i 1 12.6136 2.48958 10.4783 60 0
i 1 12.7056 2.48958 9.56522 60 0
i 1 12.7977 2.48958 8.65217 60 0
i 1 12.8898 2.48958 8.65217 60 0
i 1 12.9819 2.48958 5 60 0
i 1 13.166 2.48958 5 60 0
i 1 13.2581 2.48958 5 60 0
i 1 13.3501 2.48958 5.6087 60 0
i 1 13.4422 2.48958 9.86957 60 0
i 1 13.5343 0.5 12 60 0
i 1 13.5803 0.5 10.1739 60 0
i 1 13.6263 2.48958 8.34783 60 0
i 1 13.7184 2.48958 9.26087 60 0
i 1 13.9026 2.48958 8.65217 60 0
i 1 13.9946 2.48958 11.3913 60 0
i 1 14.0867 2.48958 10.4783 60 0
i 1 14.1788 2.48958 9.56522 60 0
i 1 14.2708 2.48958 8.65217 60 0
i 1 14.3629 2.48958 8.65217 60 0
i 1 14.455 2.48958 5 60 0
i 1 14.6391 2.48958 5 60 0
i 1 14.7312 2.48958 5 60 0
i 1 14.8233 2.48958 5.6087 60 0
i 1 14.9153 2.48958 9.86957 60 0
i 1 15.0074 0.5 12 60 0
i 1 15.0534 0.5 10.1739 60 0
i 1 15.0995 2.48958 8.34783 60 0
i 1 15.1915 2.48958 9.26087 60 0
i 1 15.3757 2.48958 8.65217 60 0
i 1 15.4677 2.48958 11.3913 60 0
i 1 15.5598 2.48958 10.4783 60 0
i 1 15.6519 2.48958 9.56522 60 0
i 1 15.744 2.48958 8.65217 60 0
i 1 15.836 2.48958 8.65217 60 0
i 1 15.9281 2.48958 5 60 0
i 1 16.1122 2.48958 5 60 0
i 1 16.2043 2.48958 5 60 0
i 1 16.2964 2.48958 5.6087 60 0
i 1 16.3884 2.48958 9.86957 60 0
i 1 16.4805 0.5 12 60 0
i 1 16.5265 0.5 10.1739 60 0
i 1 16.5726 2.48958 8.34783 60 0
i 1 16.6647 2.48958 9.26087 60 0
i 1 16.8488 2.48958 8.65217 60 0
i 1 16.9409 2.48958 11.3913 60 0
i 1 17.0329 2.48958 10.4783 60 0
i 1 17.125 2.48958 9.56522 60 0
i 1 17.2171 2.48958 8.65217 60 0
i 1 17.3091 2.48958 8.65217 60 0
i 1 17.4012 2.48958 5 60 0
i 1 17.5853 2.48958 5 60 0
i 1 17.6774 2.48958 5 60 0
i 1 17.7695 2.48958 5.6087 60 0
i 1 17.8616 2.48958 9.86957 60 0
i 1 17.9536 0.5 12 60 0
i 1 17.9997 0.5 10.1739 60 0
i 1 18.0457 2.48958 8.34783 60 0
i 1 18.1378 2.48958 9.26087 60 0
i 1 18.3219 2.48958 8.65217 60 0
i 1 18.414 2.48958 11.3913 60 0
i 1 18.506 2.48958 10.4783 60 0
i 1 18.5981 2.48958 9.56522 60 0
i 1 18.6902 2.48958 8.65217 60 0
i 1 18.7823 2.48958 8.65217 60 0
i 1 18.8743 2.48958 5 60 0
i 1 19.0585 2.48958 5 60 0
i 1 19.1505 2.48958 5 60 0
i 1 19.2426 2.48958 5.6087 60 0
i 1 19.3347 2.48958 9.86957 60 0
i 1 19.4267 0.5 12 60 0
i 1 19.4728 0.5 10.1739 60 0
i 1 19.5188 2.48958 8.34783 60 0
i 1 19.6109 2.48958 9.26087 60 0
i 1 19.795 2.48958 8.65217 60 0
i 1 19.8871 2.48958 11.3913 60 0
i 1 19.9792 2.48958 10.4783 60 0
i 1 20.0712 2.48958 9.56522 60 0
i 1 20.1633 2.48958 8.65217 60 0
i 1 20.2554 2.48958 8.65217 60 0
i 1 20.3474 2.48958 5 60 0
i 1 20.5316 2.48958 5 60 0
i 1 20.6237 2.48958 5 60 0
i 1 20.7157 2.48958 5.6087 60 0
i 1 20.8078 2.48958 9.86957 60 0
i 1 20.8999 0.5 12 60 0
i 1 20.9459 0.5 10.1739 60 0
i 1 20.9919 2.48958 8.34783 60 0
i 1 21.084 2.48958 9.26087 60 0
i 1 21.2681 2.48958 8.65217 60 0
i 1 21.3602 2.48958 11.3913 60 0
i 1 21.4523 2.48958 10.4783 60 0
i 1 21.5444 2.48958 9.56522 60 0
i 1 21.6364 2.48958 8.65217 60 0
i 1 21.7285 2.48958 8.65217 60 0
i 1 21.8206 2.48958 5 60 0
i 1 22.0047 2.48958 5 60 0
i 1 22.0968 2.48958 5 60 0
i 1 22.1888 2.48958 5.6087 60 0
i 1 22.2809 2.48958 9.86957 60 0
i 1 22.373 0.5 12 60 0
i 1 22.419 0.5 10.1739 60 0
i 1 22.4651 2.48958 8.34783 60 0
i 1 22.5571 2.48958 9.26087 60 0
i 1 22.7413 2.48958 8.65217 60 0
i 1 22.8333 2.48958 11.3913 60 0
i 1 22.9254 2.48958 10.4783 60 0
i 1 23.0175 2.48958 9.56522 60 0
i 1 23.1095 2.48958 8.65217 60 0
i 1 23.2016 2.48958 8.65217 60 0
i 1 23.2937 2.48958 5 60 0
i 1 23.4778 2.48958 5 60 0
i 1 23.5699 2.48958 5 60 0
i 1 23.662 2.48958 5.6087 60 0
i 1 23.754 2.48958 9.86957 60 0
i 1 23.8461 0.5 12 60 0
i 1 23.8921 0.5 10.1739 60 0
i 1 23.9382 2.48958 8.34783 60 0
i 1 24.0302 2.48958 9.26087 60 0
i 1 24.2144 2.48958 8.65217 60 0
i 1 24.3065 2.48958 11.3913 60 0
i 1 24.3985 2.48958 10.4783 60 0
i 1 24.4906 2.48958 9.56522 60 0
i 1 24.5827 2.48958 8.65217 60 0
i 1 24.6747 2.48958 8.65217 60 0
i 1 24.7668 2.48958 5 60 0
i 1 24.9509 2.48958 5 60 0
i 1 25.043 2.48958 5 60 0
i 1 25.1351 2.48958 5.6087 60 0
i 1 25.2272 2.48958 9.86957 60 0
i 1 25.3192 0.5 12 60 0
i 1 25.3653 0.5 10.1739 60 0
i 1 25.4113 2.48958 8.34783 60 0
i 1 25.5034 2.48958 9.26087 60 0
i 1 25.6875 2.48958 8.65217 60 0
i 1 25.7796 2.48958 11.3913 60 0
i 1 25.8716 2.48958 10.4783 60 0
i 1 25.9637 2.48958 9.56522 60 0
i 1 26.0558 2.48958 8.65217 60 0
i 1 26.1478 2.48958 8.65217 60 0
i 1 26.2399 2.48958 5 60 0
i 1 26.4241 2.48958 5 60 0
i 1 26.5161 2.48958 5 60 0
i 1 26.6082 2.48958 5.6087 60 0
i 1 26.7003 2.48958 9.86957 60 0
i 1 26.7923 0.5 12 60 0
i 1 26.8384 0.5 10.1739 60 0
i 1 26.8844 2.48958 8.34783 60 0
i 1 26.9765 2.48958 9.26087 60 0
i 1 27.1606 2.48958 8.65217 60 0
i 1 27.2527 2.48958 11.3913 60 0
i 1 27.3448 2.48958 10.4783 60 0
i 1 27.4368 2.48958 9.56522 60 0
i 1 27.5289 2.48958 8.65217 60 0
i 1 27.621 2.48958 8.65217 60 0
i 1 27.713 2.48958 5 60 0
i 1 27.8972 2.48958 5 60 0
i 1 27.9892 2.48958 5 60 0
i 1 28.0813 2.48958 5.6087 60 0
i 1 28.1734 2.48958 9.86957 60 0
i 1 28.2655 0.5 12 60 0
i 1 28.3115 0.5 10.1739 60 0
i 1 28.3575 2.48958 8.34783 60 0
i 1 28.4496 2.48958 9.26087 60 0
i 1 28.6337 2.48958 8.65217 60 0
i 1 28.7258 2.48958 11.3913 60 0
i 1 28.8179 2.48958 10.4783 60 0
i 1 28.9099 2.48958 9.56522 60 0
i 1 29.002 2.48958 8.65217 60 0
i 1 29.0941 2.48958 8.65217 60 0
i 1 29.1862 2.48958 5 60 0
i 1 29.3703 2.48958 5 60 0
i 1 29.4624 2.48958 5 60 0
i 1 29.5544 2.48958 5.6087 60 0
i 1 29.6465 2.48958 9.86957 60 0
i 1 29.7386 0.5 12 60 0
i 1 29.7846 0.5 10.1739 60 0
i 1 29.8306 2.48958 8.34783 60 0
i 1 29.9227 2.48958 9.26087 60 0
i 1 30.1069 2.48958 8.65217 60 0
i 1 30.1989 2.48958 11.3913 60 0
i 1 30.291 2.48958 10.4783 60 0
i 1 30.3831 2.48958 9.56522 60 0
i 1 30.4751 2.48958 8.65217 60 0
i 1 30.5672 2.48958 8.65217 60 0
i 1 30.6593 2.48958 5 60 0
i 1 30.8434 2.48958 5 60 0
i 1 30.9355 2.48958 5 60 0
i 1 31.0276 2.48958 5.6087 60 0
i 1 31.1196 2.48958 9.86957 60 0
i 1 31.2117 0.5 12 60 0
i 1 31.2577 0.5 10.1739 60 0
i 1 31.3038 2.48958 8.34783 60 0
i 1 31.3958 2.48958 9.26087 60 0
i 1 31.58 2.48958 8.65217 60 0
i 1 31.672 2.48958 11.3913 60 0
i 1 31.7641 2.48958 10.4783 60 0
i 1 31.8562 2.48958 9.56522 60 0
i 1 31.9483 2.48958 8.65217 60 0
i 1 32.0403 2.48958 8.65217 60 0
i 1 32.1324 2.48958 5 60 0
i 1 32.3165 2.48958 5 60 0
i 1 0 2.48958 5 60 0
i 1 0.0920699 2.48958 5.6087 60 0
i 1 0.18414 2.48958 9.86957 60 0
i 1 0.27621 0.5 12 60 0
i 1 0.322245 0.5 10.1739 60 0
i 1 0.36828 2.48958 8.34783 60 0
i 1 0.460349 2.48958 9.26087 60 0
i 1 0.644489 2.48958 8.65217 60 0
i 1 0.736559 2.48958 11.3913 60 0
i 1 0.828629 2.48958 10.4783 60 0
i 1 0.920699 2.48958 9.56522 60 0
i 1 1.01277 2.48958 8.65217 60 0
i 1 1.10484 2.48958 8.65217 60 0
i 1 1.19691 2.48958 5 60 0
i 1 1.38105 2.48958 5 60 0
i 1 1.56519 2.48958 5 60 0
i 1 1.65726 2.48958 5.6087 60 0
i 1 1.74933 2.48958 9.86957 60 0
i 1 1.8414 0.5 12 60 0
i 1 1.88743 0.5 10.1739 60 0
i 1 1.93347 2.48958 8.34783 60 0
i 1 2.02554 2.48958 9.26087 60 0
i 1 2.20968 2.48958 8.65217 60 0
i 1 2.30175 2.48958 11.3913 60 0
i 1 2.39382 2.48958 10.4783 60 0
i 1 2.48589 2.48958 9.56522 60 0
i 1 2.57796 2.48958 8.65217 60 0
i 1 2.67003 2.48958 8.65217 60 0
i 1 2.7621 2.48958 5 60 0
i 1 2.94624 2.48958 5 60 0
i 1 3.13038 2.48958 5 60 0
i 1 3.22245 2.48958 5.6087 60 0
i 1 3.31452 2.48958 9.86957 60 0
i 1 3.40659 0.5 12 60 0
i 1 3.45262 0.5 10.1739 60 0
i 1 3.49866 2.48958 8.34783 60 0
i 1 3.59073 2.48958 9.26087 60 0
i 1 3.77487 2.48958 8.65217 60 0
i 1 3.86694 2.48958 11.3913 60 0
i 1 3.95901 2.48958 10.4783 60 0
i 1 4.05108 2.48958 9.56522 60 0
i 1 4.14315 2.48958 8.65217 60 0
i 1 4.23522 2.48958 8.65217 60 0
i 1 4.32728 2.48958 5 60 0
i 1 4.51142 2.48958 5 60 0
i 1 4.69556 2.48958 5 60 0
i 1 4.78763 2.48958 5.6087 60 0
i 1 4.8797 2.48958 9.86957 60 0
i 1 4.97177 0.5 12 60 0
i 1 5.01781 0.5 10.1739 60 0
i 1 5.06384 2.48958 8.34783 60 0
i 1 5.15591 2.48958 9.26087 60 0
i 1 5.34005 2.48958 8.65217 60 0
i 1 5.43212 2.48958 11.3913 60 0
i 1 5.52419 2.48958 10.4783 60 0
i 1 5.61626 2.48958 9.56522 60 0
i 1 5.70833 2.48958 8.65217 60 0
i 1 5.8004 2.48958 8.65217 60 0
i 1 5.89247 2.48958 5 60 0
i 1 6.07661 2.48958 5 60 0
i 1 6.26075 2.48958 5 60 0
i 1 6.35282 2.48958 5.6087 60 0
i 1 6.44489 2.48958 9.86957 60 0
i 1 6.53696 0.5 12 60 0
i 1 6.583 0.5 10.1739 60 0
i 1 6.62903 2.48958 8.34783 60 0
i 1 6.7211 2.48958 9.26087 60 0
i 1 6.90524 2.48958 8.65217 60 0
i 1 6.99731 2.48958 11.3913 60 0
i 1 7.08938 2.48958 10.4783 60 0
i 1 7.18145 2.48958 9.56522 60 0
i 1 7.27352 2.48958 8.65217 60 0
i 1 7.36559 2.48958 8.65217 60 0
i 1 7.45766 2.48958 5 60 0
i 1 7.6418 2.48958 5 60 0
i 1 7.82594 2.48958 5 60 0
i 1 7.91801 2.48958 5.6087 60 0
i 1 8.01008 2.48958 9.86957 60 0
i 1 8.10215 0.5 12 60 0
i 1 8.14819 0.5 10.1739 60 0
i 1 8.19422 2.48958 8.34783 60 0
i 1 8.28629 2.48958 9.26087 60 0
i 1 8.47043 2.48958 8.65217 60 0
i 1 8.5625 2.48958 11.3913 60 0
i 1 8.65457 2.48958 10.4783 60 0
i 1 8.74664 2.48958 9.56522 60 0
i 1 8.83871 2.48958 8.65217 60 0
i 1 8.93078 2.48958 8.65217 60 0
i 1 9.02285 2.48958 5 60 0
i 1 9.20699 2.48958 5 60 0
i 1 9.39113 2.48958 5 60 0
i 1 9.4832 2.48958 5.6087 60 0
i 1 9.57527 2.48958 9.86957 60 0
i 1 9.66734 0.5 12 60 0
i 1 9.71337 0.5 10.1739 60 0
i 1 9.75941 2.48958 8.34783 60 0
i 1 9.85148 2.48958 9.26087 60 0
i 1 10.0356 2.48958 8.65217 60 0
i 1 10.1277 2.48958 11.3913 60 0
i 1 10.2198 2.48958 10.4783 60 0
i 1 10.3118 2.48958 9.56522 60 0
i 1 10.4039 2.48958 8.65217 60 0
i 1 10.496 2.48958 8.65217 60 0
i 1 10.588 2.48958 5 60 0
i 1 10.7722 2.48958 5 60 0
i 1 10.9563 2.48958 5 60 0
i 1 11.0484 2.48958 5.6087 60 0
i 1 11.1405 2.48958 9.86957 60 0
i 1 11.2325 0.5 12 60 0
i 1 11.2786 0.5 10.1739 60 0
i 1 11.3246 2.48958 8.34783 60 0
i 1 11.4167 2.48958 9.26087 60 0
i 1 11.6008 2.48958 8.65217 60 0
i 1 11.6929 2.48958 11.3913 60 0
i 1 11.7849 2.48958 10.4783 60 0
i 1 11.877 2.48958 9.56522 60 0
i 1 11.9691 2.48958 8.65217 60 0
i 1 12.0612 2.48958 8.65217 60 0
i 1 12.1532 2.48958 5 60 0
i 1 12.3374 2.48958 5 60 0
i 1 12.5215 2.48958 5 60 0
i 1 12.6136 2.48958 5.6087 60 0
i 1 12.7056 2.48958 9.86957 60 0
i 1 12.7977 0.5 12 60 0
i 1 12.8438 0.5 10.1739 60 0
i 1 12.8898 2.48958 8.34783 60 0
i 1 12.9819 2.48958 9.26087 60 0
i 1 13.166 2.48958 8.65217 60 0
i 1 13.2581 2.48958 11.3913 60 0
i 1 13.3501 2.48958 10.4783 60 0
i 1 13.4422 2.48958 9.56522 60 0
i 1 13.5343 2.48958 8.65217 60 0
i 1 13.6263 2.48958 8.65217 60 0
i 1 13.7184 2.48958 5 60 0
i 1 13.9026 2.48958 5 60 0
i 1 14.0867 2.48958 5 60 0
i 1 14.1788 2.48958 5.6087 60 0
i 1 14.2708 2.48958 9.86957 60 0
i 1 14.3629 0.5 12 60 0
i 1 14.4089 0.5 10.1739 60 0
i 1 14.455 2.48958 8.34783 60 0
i 1 14.547 2.48958 9.26087 60 0
i 1 14.7312 2.48958 8.65217 60 0
i 1 14.8233 2.48958 11.3913 60 0
i 1 14.9153 2.48958 10.4783 60 0
i 1 15.0074 2.48958 9.56522 60 0
i 1 15.0995 2.48958 8.65217 60 0
i 1 15.1915 2.48958 8.65217 60 0
i 1 15.2836 2.48958 5 60 0
i 1 15.4677 2.48958 5 60 0
i 1 15.6519 2.48958 5 60 0
i 1 15.744 2.48958 5.6087 60 0
i 1 15.836 2.48958 9.86957 60 0
i 1 15.9281 0.5 12 60 0
i 1 15.9741 0.5 10.1739 60 0
i 1 16.0202 2.48958 8.34783 60 0
i 1 16.1122 2.48958 9.26087 60 0
i 1 16.2964 2.48958 8.65217 60 0
i 1 16.3884 2.48958 11.3913 60 0
i 1 16.4805 2.48958 10.4783 60 0
i 1 16.5726 2.48958 9.56522 60 0
i 1 16.6647 2.48958 8.65217 60 0
i 1 16.7567 2.48958 8.65217 60 0
i 1 16.8488 2.48958 5 60 0
i 1 17.0329 2.48958 5 60 0
i 1 17.2171 2.48958 5 60 0
i 1 17.3091 2.48958 5.6087 60 0
i 1 17.4012 2.48958 9.86957 60 0
i 1 17.4933 0.5 12 60 0
i 1 17.5393 0.5 10.1739 60 0
i 1 17.5853 2.48958 8.34783 60 0
i 1 17.6774 2.48958 9.26087 60 0
i 1 17.8616 2.48958 8.65217 60 0
i 1 17.9536 2.48958 11.3913 60 0
i 1 18.0457 2.48958 10.4783 60 0
i 1 18.1378 2.48958 9.56522 60 0
i 1 18.2298 2.48958 8.65217 60 0
i 1 18.3219 2.48958 8.65217 60 0
i 1 18.414 2.48958 5 60 0
i 1 18.5981 2.48958 5 60 0
i 1 18.7823 2.48958 5 60 0
i 1 18.8743 2.48958 5.6087 60 0
i 1 18.9664 2.48958 9.86957 60 0
i 1 19.0585 0.5 12 60 0
i 1 19.1045 0.5 10.1739 60 0
i 1 19.1505 2.48958 8.34783 60 0
i 1 19.2426 2.48958 9.26087 60 0
i 1 19.4267 2.48958 8.65217 60 0
i 1 19.5188 2.48958 11.3913 60 0
i 1 19.6109 2.48958 10.4783 60 0
i 1 19.703 2.48958 9.56522 60 0
i 1 19.795 2.48958 8.65217 60 0
i 1 19.8871 2.48958 8.65217 60 0
i 1 19.9792 2.48958 5 60 0
i 1 20.1633 2.48958 5 60 0
i 1 20.3474 2.48958 5 60 0
i 1 20.4395 2.48958 5.6087 60 0
i 1 20.5316 2.48958 9.86957 60 0
i 1 20.6237 0.5 12 60 0
i 1 20.6697 0.5 10.1739 60 0
i 1 20.7157 2.48958 8.34783 60 0
i 1 20.8078 2.48958 9.26087 60 0
i 1 20.9919 2.48958 8.65217 60 0
i 1 21.084 2.48958 11.3913 60 0
i 1 21.1761 2.48958 10.4783 60 0
i 1 21.2681 2.48958 9.56522 60 0
i 1 21.3602 2.48958 8.65217 60 0
i 1 21.4523 2.48958 8.65217 60 0
i 1 21.5444 2.48958 5 60 0
i 1 21.7285 2.48958 5 60 0
i 1 21.9126 2.48958 5 60 0
i 1 22.0047 2.48958 5.6087 60 0
i 1 22.0968 2.48958 9.86957 60 0
i 1 22.1888 0.5 12 60 0
i 1 22.2349 0.5 10.1739 60 0
i 1 22.2809 2.48958 8.34783 60 0
i 1 22.373 2.48958 9.26087 60 0
i 1 22.5571 2.48958 8.65217 60 0
i 1 22.6492 2.48958 11.3913 60 0
i 1 22.7413 2.48958 10.4783 60 0
i 1 22.8333 2.48958 9.56522 60 0
i 1 22.9254 2.48958 8.65217 60 0
i 1 23.0175 2.48958 8.65217 60 0
i 1 23.1095 2.48958 5 60 0
i 1 23.2937 2.48958 5 60 0
i 1 23.4778 2.48958 5 60 0
i 1 23.5699 2.48958 5.6087 60 0
i 1 23.662 2.48958 9.86957 60 0
i 1 23.754 0.5 12 60 0
i 1 23.8001 0.5 10.1739 60 0
i 1 23.8461 2.48958 8.34783 60 0
i 1 23.9382 2.48958 9.26087 60 0
i 1 24.1223 2.48958 8.65217 60 0
i 1 24.2144 2.48958 11.3913 60 0
i 1 24.3065 2.48958 10.4783 60 0
i 1 24.3985 2.48958 9.56522 60 0
i 1 24.4906 2.48958 8.65217 60 0
i 1 24.5827 2.48958 8.65217 60 0
i 1 24.6747 2.48958 5 60 0
i 1 24.8589 2.48958 5 60 0
i 1 25.043 2.48958 5 60 0
i 1 25.1351 2.48958 5.6087 60 0
i 1 25.2272 2.48958 9.86957 60 0
i 1 25.3192 0.5 12 60 0
i 1 25.3653 0.5 10.1739 60 0
i 1 25.4113 2.48958 8.34783 60 0
i 1 25.5034 2.48958 9.26087 60 0
i 1 25.6875 2.48958 8.65217 60 0
i 1 25.7796 2.48958 11.3913 60 0
i 1 25.8716 2.48958 10.4783 60 0
i 1 25.9637 2.48958 9.56522 60 0
i 1 26.0558 2.48958 8.65217 60 0
i 1 26.1478 2.48958 8.65217 60 0
i 1 26.2399 2.48958 5 60 0
i 1 26.4241 2.48958 5 60 0
i 1 26.6082 2.48958 5 60 0
i 1 26.7003 2.48958 5.6087 60 0
i 1 26.7923 2.48958 9.86957 60 0
i 1 26.8844 0.5 12 60 0
i 1 26.9304 0.5 10.1739 60 0
i 1 26.9765 2.48958 8.34783 60 0
i 1 27.0685 2.48958 9.26087 60 0
i 1 27.2527 2.48958 8.65217 60 0
i 1 27.3448 2.48958 11.3913 60 0
i 1 27.4368 2.48958 10.4783 60 0
i 1 27.5289 2.48958 9.56522 60 0
i 1 27.621 2.48958 8.65217 60 0
i 1 27.713 2.48958 8.65217 60 0
i 1 27.8051 2.48958 5 60 0
i 1 27.9892 2.48958 5 60 0
i 1 28.1734 2.48958 5 60 0
i 1 28.2655 2.48958 5.6087 60 0
i 1 28.3575 2.48958 9.86957 60 0
i 1 28.4496 0.5 12 60 0
i 1 28.4956 0.5 10.1739 60 0
i 1 28.5417 2.48958 8.34783 60 0
i 1 28.6337 2.48958 9.26087 60 0
i 1 28.8179 2.48958 8.65217 60 0
i 1 28.9099 2.48958 11.3913 60 0
i 1 29.002 2.48958 10.4783 60 0
i 1 29.0941 2.48958 9.56522 60 0
i 1 29.1862 2.48958 8.65217 60 0
i 1 29.2782 2.48958 8.65217 60 0
i 1 29.3703 2.48958 5 60 0
i 1 29.5544 2.48958 5 60 0
i 1 29.7386 2.48958 5 60 0
i 1 29.8306 2.48958 5.6087 60 0
i 1 29.9227 2.48958 9.86957 60 0
i 1 30.0148 0.5 12 60 0
i 1 30.0608 0.5 10.1739 60 0
i 1 30.1069 2.48958 8.34783 60 0
i 1 30.1989 2.48958 9.26087 60 0
i 1 30.3831 2.48958 8.65217 60 0
i 1 30.4751 2.48958 11.3913 60 0
i 1 30.5672 2.48958 10.4783 60 0
i 1 30.6593 2.48958 9.56522 60 0
i 1 30.7513 2.48958 8.65217 60 0
i 1 30.8434 2.48958 8.65217 60 0
i 1 30.9355 2.48958 5 60 0
i 1 31.1196 2.48958 5 60 0
i 1 31.3038 2.48958 5 60 0
i 1 31.3958 2.48958 5.6087 60 0
i 1 31.4879 2.48958 9.86957 60 0
i 1 31.58 0.5 12 60 0
i 1 31.626 0.5 10.1739 60 0
i 1 31.672 2.48958 8.34783 60 0
i 1 31.7641 2.48958 9.26087 60 0
i 1 31.9483 2.48958 8.65217 60 0
i 1 32.0403 2.48958 11.3913 60 0
i 1 32.1324 2.48958 10.4783 60 0
i 1 32.2245 2.48958 9.56522 60 0
i 1 32.3165 2.48958 8.65217 60 0
i 1 32.4086 2.48958 8.65217 60 0
i 1 32.5007 2.48958 5 60 0
i 1 32.6848 2.48958 5 60 0
i 1 32.869 2.48958 5 60 0
i 1 32.961 2.48958 5.6087 60 0
i 1 33.0531 2.48958 9.86957 60 0
i 1 33.1452 0.5 12 60 0
i 1 33.1912 0.5 10.1739 60 0
i 1 33.2372 2.48958 8.34783 60 0
i 1 33.3293 2.48958 9.26087 60 0
i 1 33.5134 2.48958 8.65217 60 0
i 1 33.6055 2.48958 11.3913 60 0
i 1 33.6976 2.48958 10.4783 60 0
i 1 33.7897 2.48958 9.56522 60 0
i 1 33.8817 2.48958 8.65217 60 0
i 1 33.9738 2.48958 8.65217 60 0
i 1 34.0659 2.48958 5 60 0
i 1 34.25 2.48958 5 60 0
