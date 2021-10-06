sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

               instr     1
kenv1          line      1, .5, 0
asig1          oscil     10000*kenv1, 200, 5 
               outs      asig1, asig1
               endin
     

               instr     5                        ;"RED WHEEL"
idur           =         p3
i1             =         3000      ;xamp
i2             =         50        ;ivoice
i3             =         4         ;iratio -pointer speed
i4             =         1         ;imode    -+forward -backward
i5             =         0         ;ithd     -threshold value
i6             =         1         ;ifn -source ftable
i7             =         1         ;ipshift
i8             =         0         ;igskip
i9             =         0         ;igskip_os
i10            =         1.47      ;ilength
k11            =         .02       ;kgap          -gap in sec
i12            =         5         ;igap_os  -offset %
k13            =         .005      ;kgsize
i14            =         0         ;igsize_os     -offset %
i15            =         50        ;iattack  -attack, % of grain size
i16            =         50        ;idecay        -decay, % of grain size
i17            =         .5        ;iseed
i17a           =         .51
i18            =         1         ;ipitch1
i19            =         2         ;envelope ftable

kenv1          oscil     .004, 1, 5
kenv2          oscil     .004, 1.1, 5
k11a           =         k11+kenv1
k11b           =         k11+kenv2 
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11a,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11b,i12,k13,i14,i15,i16,i17a,i18,i19
aenv1          linseg    0, 5, 1        
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     16                       ;"RED WHEEL"
idur           =         p3
i1             =         1200      ;xamp
i2             =         50        ;ivoice
i3             =         8         ;iratio -pointer speed
i4             =         1         ;imode    -+forward -backward
i5             =         0         ;ithd     -threshold value
i6             =         1         ;ifn -source ftable
i7             =         1         ;ipshift
i8             =         0         ;igskip
i9             =         0         ;igskip_os
i10            =         1.46      ;ilength
k11            =         .002      ;kgap          -gap in sec
i12            =         10        ;igap_os  -offset %
k13            =         .002      ;kgsize
i14            =         0         ;igsize_os     -offset %
i15            =         50        ;iattack  -attack, % of grain size
i16            =         50        ;idecay        -decay, % of grain size
i17            =         .5        ;iseed
i17a           =         .51
i18            =         .5        ;ipitch1
i19            =         2         ;envelope ftable


asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19
aenv1          linseg    1, .25, 1, .1, 0         
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     6         ;LONG NOISE
idur           =         p3
i1             =         4000      ;xamp
i2             =         80        ;ivoice
i3             =         .25       ;iratio -pointer speed
i4             =         1         ;imode    -+forward -backward
i5             =         0         ;ithd     -threshold value
i6             =         1         ;ifn -source ftable
i7             =         1         ;ipshift
i8             =         .146      ;igskip
i9             =         0         ;igskip_os
i10            =         .181      ;ilength
k11            =         .05       ;kgap          -gap in sec
i12            =         100       ;igap_os  -offset %
;k13           =         .03       ;kgsize
i14            =         0         ;igsize_os     -offset %
i15            =         50        ;iattack  -attack, % of grain size
i16            =         50        ;idecay        -decay, % of grain size
i17            =         .5        ;iseed
i17a           =         .63
i18            =         1         ;ipitch1
i19            =         2         ;envelope ftable

k13            linseg    .0001, idur/3, .03, idur*(2/3), .0001

asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19
aenv1          linseg    0,.05, .5, (idur-.05)/2, 1, (idur-.1\05)/2, .5         
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     7              ;EIGHTH NOTE POPS   
idur           =         p3             ;qurter = .428571 eighth = .2142857 sixteenth = .1071428
i1             =         1000           ;xamp
i2             =         50             ;ivoice
i3             =         3              ;iratio -pointer speed
i4             =         1              ;imode    -+forward -backward
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .55            ;igskip
i9             =         0              ;igskip_os
i10            =         .936           ;ilength
k11            =         .2142857       ;kgap          -gap in sec
i12            =         0              ;igap_os  -offset %
k13            =         .002           ;kgsize
i14            =         0              ;igsize_os     -offset %
i15            =         50             ;iattack  -attack, % of grain size
i16            =         50             ;idecay        -decay, % of grain size
i17            =         .5             ;iseed
i18            =         1              ;ipitch1
                                        ;envelope ftable
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18
aenv1          linseg    0, idur, 1          
               outs      asig1*aenv1, asig1*aenv1
               endin
               instr     11             ;EIGHTH NOTE POPS w/o fade in
idur           =         p3             ;qurter = .428571 eighth = .2142857 sixteenth = .1071428
i1             =         800            ;xamp
i2             =         50             ;ivoice
i3             =         3              ;iratio -pointer speed
i4             =         1              ;imode    -+forward -backward
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .55            ;igskip
i9             =         0              ;igskip_os
i10            =         .936           ;ilength
k11            =         .2142857       ;kgap          -gap in sec
i12            =         0              ;igap_os  -offset %
k13            =         .002           ;kgsize
i14            =         0              ;igsize_os     -offset %
i15            =         50             ;iattack  -attack, % of grain size
i16            =         50             ;idecay        -decay, % of grain size
i17            =         .5             ;iseed
i18            =         1              ;ipitch1
                                        ;ENVELOPE FTABLE
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18
aenv1          linseg    1, idur, 1          
               outs      asig1*aenv1, asig1*aenv1
               endin

               instr     13             ;SIXTEENTH NOTE POPS     
idur           =         p3             ;qurter = .428571 eighth = .2142857 sixteenth = .1071428
i1             =         1500           ;xamp
i2             =         50             ;ivoice
i3             =         3              ;iratio -pointer speed
i4a            =         1              ;imode    -+forward -backward
i4b            =         -1
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .55            ;igskip
i9             =         0              ;igskip_os
i10            =         .936           ;ilength
k11            =         .1071428       ;kgap          -gap in sec
i12            =         0              ;igap_os  -offset %
k13            =         .002           ;kgsize
i14            =         0              ;igsize_os     -offset %
i15            =         50             ;iattack  -attack, % of grain size
i16            =         50             ;idecay        -decay, % of grain size
i17            =         .5             ;iseed
i18            =         1              ;ipitch1
                                        ;ENVELOPE FTABLE
     
k13a           line      .002, idur, .01

asig1          granule   i1,i2,i3,i4a,i5,i6,i7,i8,i9,i10,k11,i12,k13a,i14,i15,i16,i17,i18
asig2          granule   i1,i2,i3,i4b,i5,i6,i7,i8,i9,i10,k11,i12,k13a,i14,i15,i16,i17,i18
aenv1          linseg    0, idur, 1          
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     8              ;(I DON'T WANT TO TAKE THE TIME TO FIGURE OUT HOW
               ;                        TO INSERT SILENCE RIGHT NOW)
asig1          oscil     0, 1, 5
               outs      asig1, asig1
               endin

               instr     9              ;PIGGY BASS
idur           =         p3
i1             =         p4             ;xamp
i2             =         10             ;ivoice
i3             =         1              ;iratio -pointer speed
i4             =         -1             ;imode    -+forward -backward
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .714           ;igskip
i9             =         0              ;igskip_os
i10            =         .427           ;ilength
k11            =         .015           ;kgap          -gap in sec
i12            =         0              ;igap_os  -offset %
k13            =         .01            ;kgsize
i14            =         3              ;igsize_os     -offset %
i15            =         10             ;iattack  -attack, % of grain size
i16            =         10             ;idecay        -decay, % of grain size
i17            =         .43            ;iseed
i17a           =         .43
i18            =         p5             ;ipitch1
i19            =         2              ;ENVELOPE FTABLE
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19
aenv1          linseg    1, .2, .1, .2, 0         
               outs      asig1*aenv1, asig1*aenv1
               endin

               instr     17             ;PIGGY LOW BASS w/repeating high "ed"
idur           =         p3
i1             =         1100           ;xamp
i2             =         20             ;ivoice
i3             =         .5             ;iratio -pointer speed
i4             =         1              ;imode    -+forward -backward
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .714           ;igskip
i9             =         0              ;igskip_os
i10            =         .427           ;ilength
k11            =         .002           ;kgap          -gap in sec
i12            =         20             ;igap_os  -offset %
k13            =         .02            ;kgsize
i14            =         3              ;igsize_os     -offset %
i15            =         50             ;iattack  -attack, % of grain size
i16            =         50             ;idecay        -decay, % of grain size
i17            =         .43            ;iseed
i17a           =         .53
i18            =         .2             ;ipitch1
i19            =         2              ;envelope ftable

i3b            =         1
;k11b          =         .002           ;kgap
i12b           =         0              ;igap_os
;k13b          =         .05            ;kgsize
;i14b          =         0              ;kgsize_os
i18b           =         2              ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg    0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin

               instr     22             ;PIGGY LOW BASS w/repeating high "ed"
idur           =         p3
i1             =         1300           ;xamp
i2             =         20             ;ivoice
i3             =         .5             ;iratio -pointer speed
i4             =         1              ;imode    -+forward -backward
i5             =         0              ;ithd     -threshold value
i6             =         4              ;ifn -source ftable
i7             =         1              ;ipshift
i8             =         .714           ;igskip
i9             =         0              ;igskip_os
i10            =         .427           ;ilength
k11            =         .002           ;kgap          -gap in sec
i12            =         20             ;igap_os  -offset %
k13            =         .02            ;kgsize
i14            =         3              ;igsize_os     -offset %
i15            =         50             ;iattack  -attack, % of grain size
i16            =         50             ;idecay        -decay, % of grain size
i17            =         .43            ;iseed
i17a           =         .53
i18            =         .2             ;ipitch1
i19            =         2              ;envelope ftable

i3b            =         1
;k11b          =         .002           ;kgap
i12b           =         0              ;igap_os
;k13b          =         .05            ;kgsize
;i14b          =         0              ;kgsize_os
i18b           =         2              ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg    0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin


               instr     10                  ;LONG NOISE PANS RIGHT TO LEFT
idur           =         p3
i1             =         3500                ;xamp
i2             =         80                  ;ivoice
i3             =         .25                 ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         1                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .160                ;igskip
i9             =         0                   ;igskip_os
i10            =         .181                ;ilength
k11            =         .05                 ;kgap          -gap in sec
i12            =         100                 ;igap_os  -offset %
;k13           =         .03                 ;kgsize
i14            =         0                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .5                  ;iseed
i17a           =         .5
i18            =         1                   ;ipitch1
i19            =         2                   ;envelope ftable

k13            linseg    .0001, idur, .03  
k13a           linseg    .03, idur, .0001

asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13a,i14,i15,i16,i17a,i18,i19
aenv1          linseg    0, idur/2, 1, idur/2, .25          
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     12                  ;HIGH PTICHED ATTACK
idur           =         p3
i1             =         2000                ;xamp
i2             =         80                  ;ivoice
i3             =         2                   ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         4                   ;ipshift
i8             =         1.11                ;igskip 
i9             =         0                   ;igskip_os
i10            =         .37                 ;ilength
k11            =         .05                 ;kgap          -gap in sec
i12            =         50                  ;igap_os  -offset %
k13            =         .03                 ;kgsize
i14            =         0                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .47                 ;iseed
i17a           =         .32
i18            =         1.3                 ;ipitch1 
i19            =         5.89
i20            =         3.65
i21            =         4.2
;ENVELOPE FTABLE

k11a           expseg    .001, idur, .1

asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11a,i12,k13,i14,i15,i16,i17,i18,i19,i20,i21
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11a,i12,k13,i14,i15,i16,i17a,i18,i19,i20,i21
aenv1          linseg    1, .1, .5,idur-.1, 0     
               outs      asig1*aenv1, asig2*aenv1
               endin

               instr     14                  ;HIGH PTICHED ATTACK
idur           =         p3
i1             =         2000                ;xamp
i2             =         80                  ;ivoice
i3             =         2                   ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         4                   ;ipshift
i8             =         1.11                ;igskip 
i9             =         0                   ;igskip_os
i10            =         .37                 ;ilength
k11            =         .05                 ;kgap          -gap in sec
i12            =         50                  ;igap_os  -offset %
k13            =         .03                 ;kgsize
i14            =         0                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .47                 ;iseed
i17a           =         .32
i18            =         1.3                 ;ipitch1 
i19            =         5.89
i20            =         3.65
i21            =         4.2
;ENVELOPE FTABLE

k11a           expseg    .001, idur, .1

asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11a,i12,k13,i14,i15,i16,i17,i18,i19,i20,i21
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11a,i12,k13,i14,i15,i16,i17a,i18,i19,i20,i21
aenv1          linseg    1, .1, .5,idur-.1, 0     
               outs      asig1*aenv1, asig2*aenv1
               endin

     

               instr     19                  ;REPEATING HIGH "ED"
idur           =         p3

i2             =         20                  ;ivoice
i3             =         .75                 ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .714                ;igskip
i9             =         0                   ;igskip_os
i10            =         .427                ;ilength
;k11           =         .002                ;kgap          -gap in sec
i12            =         50                  ;igap_os  -offset %
;k13           =         .02                 ;kgsize
k14            =         100                 ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .43                 ;iseed
i17a           =         .53
i18            =         1.5                 ;ipitch1
i19            =         2                   ;envelope ftable

k13            line      .1, idur, .02

k11            linseg    0, .5, 0, 3, .02
;k14           linseg    0, 25, 0, 3, 100 

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1          granule   3000+kenv3,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,k14,i15,i16,i17,i18,i19
asig2          granule   3000+kenv3,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,k14,i15,i16,i17a,i18,i19

kenv8          linseg    1, idur/6, .25, idur/6, 1, idur/6, .25, idur/6, 1, idur/6, .25, idur/6, 1
kenv7          linseg    .25, idur/6, 1, idur/6, .25, idur/6, 1, idur/6, .25, idur/6, 1, idur/6, .25

kenv6          linseg    0, idur/2, 1, idur/2, .5

aenv1          linseg    0, .03, 1, 1, 0
a1             =         asig1
a2             =         asig2
               outs      a1*kenv6*kenv7, a2*kenv6*kenv8
               endin

               instr     20                  ;FOGHORN
idur           =         p3
i1             =         1200                ;xamp
i2             =         80                  ;ivoice
i3             =         20                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         4                   ;ipshift
i8             =         1.176               ;igskip
i9             =         0                   ;igskip_os
i10            =         .2                  ;ilength (.93)
k11            =         .05                 ;kgap          -gap in sec
i12            =         50                  ;igap_os  -offset %
k13            =         .1                  ;kgsize
i14            =         20                  ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .47                 ;iseed
i17a           =         .32
i18            =         1.1                 ;ipitch1
i19            =         1
i20            =         .9
i21            =         1

i18b           =         .5
i19b           =         .5
i20b           =         .5
i21b           =         .5
;ENVELOPE FTABLE


asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19,i20,i21
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19,i20,i21
asig3          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18b,i19b,i20b,i21b
asig4          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18b,i19b,i20b,i21b

kenv1          line      1, idur, 0
kenv2          line      0, idur, 1

a1             =         asig1*kenv1
a2             =         asig2*kenv1
a3             =         asig3*kenv2
a4             =         asig4*kenv2
          
aenv1          linseg    0, .1, 1, idur-.2, .5, .1, 0  
               outs      (a3+a1)*aenv1,( a4+a2)*aenv1
               endin

               instr     21                  ;END FOGHORN
idur           =         p3
i1             =         8000                ;xamp
i2             =         20                  ;ivoice
i3             =         20                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         4                   ;ipshift
i8             =         1.176               ;igskip
i9             =         0                   ;igskip_os
i10            =         .093                ;ilength
k11            =         .05                 ;kgap          -gap in sec
i12            =         50                  ;igap_os  -offset %
k13            =         .2                  ;kgsize
i14            =         50                  ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .47                 ;iseed
i17a           =         .32
i18            =         1.1                 ;ipitch1
i19            =         1
i20            =         .9
i21            =         1

i18b           =         .5
i19b           =         .5
i20b           =         .5
i21b           =         .5

i18c           =         .25
i19c           =         .25
i20c           =         .25
i21c           =         .25

;ENVELOPE FTABLE

asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19,i20,i21
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19,i20,i21
asig3          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18b,i19b,i20b,i21b
asig4          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18b,i19b,i20b,i21b
asig5          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18c,i19c,i20c,i21c
asig6          granule   i1+1000,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18c,i19c,i20c,i21c

kenv1          linseg    1, idur/3, 0, idur/3, 0, idur/3, 0
kenv2          linseg    0, idur/3, 1, idur/3, 0, idur/3, 0
kenv3          linseg    0, idur/3, 0, idur/3, 1, idur/3, 1

a1             =         asig1*kenv1
a2             =         asig2*kenv1
a3             =         asig3*kenv2
a4             =         asig4*kenv2
a5             =         asig5*kenv3
a6             =         asig6*kenv3

kenv1          linseg    .25, 1, 1, idur-6, 1, 5, 0
               outs      (a5+a3+a1)*kenv1, (a6+a4+a2)*kenv1
               endin

               instr     23                  ;SAYS "RED WHEEL"
idur           =         p3
iamp           =         12000
idens          =         50
itrans         =         1
ispd           =         p4
koct           =         0
kband          =         0
kris           =         .02
kdur           =         .04
kdec           =         .02
iolaps         =         20
ifna           =         1
ifnb           =         2
itotdur        =         idur
iphs           =         0
itmode         =         1

i1             =         sr/ftlen(ifna) 
aspd2          phasor    i1*ispd
asig1          fog  iamp,idens,itrans,aspd2,koct,kband,kris,kdur,kdec,iolaps,ifna,ifnb,itotdur,iphs,itmode
               outs      asig1, asig1
               endin
     
               instr     24                  ;PIGGY LOW BASS w/repeating high "ed"
idur           =         p3
i1             =         1300                ;xamp
i2             =         20                  ;ivoice
i3             =         .5                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .714                ;igskip
i9             =         0                   ;igskip_os
i10            =         .427                ;ilength
k11            =         .002                ;kgap          -gap in sec
i12            =         20                  ;igap_os  -offset %
k13            =         .02                 ;kgsize
i14            =         3                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .43                 ;iseed
i17a           =         .53
i18            =         .2                  ;ipitch1
i19            =         2                   ;envelope ftable

i3b            =         1
;k11b          =         .002                ;kgap
i12b           =         0                   ;igap_os
;k13b          =         .05                 ;kgsize
;i14b          =         0                   ;kgsize_os
i18b           =         2                   ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg     0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin


               instr     25                  ;PIGGY LOW BASS W/REPEATING HIGH "ED"
idur           =         p3
i1             =         1300                ;xamp
i2             =         20                  ;ivoice
i3             =         .5                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .714                ;igskip
i9             =         0                   ;igskip_os
i10            =         .427                ;ilength
k11            =         .002                ;kgap          -gap in sec
i12            =         20                  ;igap_os  -offset %
k13            =         .02                 ;kgsize
i14            =         3                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .43                 ;iseed
i17a           =         .53
i18            =         .2                  ;ipitch1
i19            =         2                   ;envelope ftable
          
i3b            =         1
;k11b          =         .002                ;kgap
i12b           =         0                   ;igap_os
;k13b          =         .05                 ;kgsize
;i14b          =         0                   ;kgsize_os
i18b           =         2                   ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg    0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin


               instr     26                  ;PIGGY LOW BASS W/REPEATING HIGH "ED"
idur           =         p3
i1             =         1300                ;xamp
i2             =         20                  ;ivoice
i3             =         .5                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .714                ;igskip
i9             =         0                   ;igskip_os
i10            =         .427                ;ilength
k11            =         .002                ;kgap          -gap in sec
i12            =         20                  ;igap_os  -offset %
k13            =         .02                 ;kgsize
i14            =         3                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .43                 ;iseed
i17a           =         .53
i18            =         .2                  ;ipitch1
i19            =         2                   ;envelope ftable

i3b            =         1
;k11b          =         .002                ;kgap
i12b           =         0                   ;igap_os
;k13b          =         .05                 ;kgsize
;i14b          =         0                   ;kgsize_os
i18b           =         2                   ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg    0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin


               instr     27                  ;PIGGY LOW BASS w/repeating high "ed"
idur           =         p3
i1             =         1300                ;xamp
i2             =         20                  ;ivoice
i3             =         .5                  ;iratio -pointer speed
i4             =         1                   ;imode    -+forward -backward
i5             =         0                   ;ithd     -threshold value
i6             =         4                   ;ifn -source ftable
i7             =         1                   ;ipshift
i8             =         .714                ;igskip
i9             =         0                   ;igskip_os
i10            =         .427                ;ilength
k11            =         .002                ;kgap          -gap in sec
i12            =         20                  ;igap_os  -offset %
k13            =         .02                 ;kgsize
i14            =         3                   ;igsize_os     -offset %
i15            =         50                  ;iattack  -attack, % of grain size
i16            =         50                  ;idecay        -decay, % of grain size
i17            =         .43                 ;iseed
i17a           =         .53
i18            =         .2                  ;ipitch1
i19            =         2                   ;envelope ftable

i3b            =         1
;k11b          =         .002                ;kgap
i12b           =         0                   ;igap_os
;k13b          =         .05                 ;kgsize
;i14b          =         0                   ;kgsize_os
i18b           =         2                   ;ipitch1

k13b           line      .06, idur, .02

k11b           linseg    0, .5, 0, 3, .02
k14b           linseg     0, .5, 0, 3, 100
     
asig1          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17,i18,i19
asig2          granule   i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,k11,i12,k13,i14,i15,i16,i17a,i18,i19

aenv2          linseg    0, 1, 1

kenv4          line      80, idur, 3
kenv3          oscil     800, kenv4, 5

asig1b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17,i18b,i19
asig2b         granule   1000+kenv3,i2,i3b,i4,i5,i6,i7,i8,i9,i10,k11b,i12b,k13b,k14b,i15,i16,i17a,i18b,i19

kenv5          line      1, idur, 0

kenv6          linseg    1, idur/4, .25, idur/4, 1, idur/4, .25
kenv7          linseg    .25, idur/4, 1, idur/4, .25, idur/4, 1

aenv1          linseg    0, .03, 1, 1, 0
a1             =         aenv1*asig1+aenv2*asig1b
a2             =         aenv1*asig2+aenv2*asig2b
               outs      a1*kenv5*kenv6, a2*kenv5*kenv7
               endin



