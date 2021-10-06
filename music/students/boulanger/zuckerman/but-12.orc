;========================================================;
;   Example Orchestra for pitchshifting SOUNDIN files    ;
;========================================================;

    sr       =  44100
    kr       =  4410
    ksmps    =  10

;===========================================;
;        Pitch Changing Instrument          ;
;                                           ;
;       p4 = Soundin #  p5 = desired pitch  ;
;       p6 = old pitch  p7 = original sr    ;
;===========================================;

instr   2
       icpsnew =       cpspch(p5)
       icpsold =       cpspch(p6)
       ioldsr  =       p7
       incr    =       ioldsr/sr * icpsnew/icpsold
       kenv  linseg  0, .001, 1, 1.059, 1, .001, 0, p3-(.001+1.059+.001), 0
       kphase  init    0                       ;initialize phase
       aphase  interp  kphase                  ;convert to arate
       asig    tablei  aphase,1                ;resample the sound
       kphase  =       kphase+incr*ksmps       ;update for next k
               out     asig*kenv
endin
