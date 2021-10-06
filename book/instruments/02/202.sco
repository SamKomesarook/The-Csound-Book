;8192 POINT SINE
f   02  0   8192    10  1
;SQUARE WAVE � ODD HARMONICS (THROUGH 17TH) AT A STRENGTH OF 1/HARMONIC#
f   03  0   513 10  1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588
;SAWTOOTH WAVE � ALL HARMONICS (THROUGH 13TH) AT A STRENGTH OF 1/HARMONIC#
f   04  0   513 10  1 .5 .333 .25 .2 .166 .143 .125 .111 .1 .0909 .0833 .077
;PULSE (TRUMPET?)
f   05  0   513 10  .8 .9 .95 .96 1 .91 .8 .75 .6 .42 .5 .4 .33 .28 .2 .15     
;COSINE WAVE (SINE WAVE WITH INITIAL PHASE OF 90 DEGREES):
f   06  0   8192    9   1 1 90
;TRIANGLE WAVE (ODD HARMONICS AT A STRENGTH OF 1/HARMONIC 
;NUMBER WITH INVERTED PHASE FOR EVERY OTHER HARMONIC):
f   07  0   513 9   1 1 0 3 .333 180 5 .2 0 7 .143 180 9 .111 0
;HALF OF A SINE:
f   08  0   513 9   .5 1 0
;A QUASI-GAUSIAN ENVELOPE
f   09  0   1024    -19 1 .5 270 .5
;CYCLE OFFSET CANCELLATION
f   10  0   8192    9   .75 1   0   2.25    1   0       
;CYCLE OFFSET CANCELLATION
f   11  0   8192    9   1.66    1   0   3.33    1   0
;INVERSE PHASE CANCELLATION
f   12  0   8192    9   1.25    1   0   4.25    1   180 
;ENHARMONIC PARTIALS # 21, 22, 25, 27, 31, 33, 35
f   13  0   8192    9   21 1 0 22 1 0 25 1 0 27 1 0 31 1 0 33 1 0 34 1 0 35 1 0 
;PULSE-TRAIN
f   14  0   4096    11  10  1 .9
;SAWTOOTH
f   15  0   512     7   1 512 -1
;SQUARE             
f   16  0   1024    7   1 512 1 0 -1 512 -1
;FOR WAVESHAPING        
f   17  0   512     7   -1 100 -1 312 1 100 1
;A SINGLE IMPULSE   
f   18  0   128     7   1 1 1 0 0
;AN EXPONENTIAL ENVELOPE FUNCTION
f   19  0   1024    5   .001 100 1 824 .75 100 .001             
;QUASI-GUASSIAN
f   20  0   513     8   0 150 0.5 50 1 113 1 50 0.5 150 0
;STRETCHED COSINE
f   21  0   2048    8   1 750 0 550 -1 400 0 348 1
;SMOOTH
f   22  0   8193    6   0 2048 .5 2048 1 2048 0 2049 -1
;POINTS OF INFLECTION ARE NOT BETWEEN ODD ORDINATE VALUES
f   23  0   8193    6   0 2048 1 2048 -1 2048 1 2049 0
;SUCCESSIVE MAXIMA
f   24  0   1024    6   0 256 .25 256 .5 256 .75 256 1
;POLYNOMIAL FUNCTION
f   25  0   1025    3   -1 1 5 2 4 1 3 1 2 1
;WAVESHAPING FUNCTION
f   26  0   1025    7   -1 256 -1 513 1 256 1   
;AMP NORMALIZING FUNCTION
f   27  0   513     4   26 1



i 202   00  1 20000 440 02
i .     02  . .     .   03
i .     04  . .     .   04
i .     06  . .     .   05
i .     08  . .     .   06
i .     10  . .     .   07
i .     12  . .     .   08
i .     14  . .     .   09
i .     16  . .     .   10
i .     18  . .     .   11
i .     20  . .     .   12
i .     22  . .     .   13
i .     24  . .     .   14
i .     26  . .     .   15
i .     28  . .     .   16
