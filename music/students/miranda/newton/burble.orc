;-------------------------------------------------
;CENTRE FOR MUSIC TECHNOLOGY - GLASGOW UNIVERSITY
;SOFTWARE SYNTHESIS AND COMPOSITION SYSTEMS
;TUTOR: DR MIRANDA
;STUDENT NAME: MARK NEWTON
;INSTRUMENT: BURBLE.ORC
;-------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
;================
        instr   1
                    
k1      init    1                                       ;SET INITIAL VALUES FOR THE CELLS
k2      init    0
k3      init    1
k4      init    1
k5      init    1
k6      init    0
k7      init    0
k8      init    1


k1      =       1-sqrt(abs(k8+k2-1))                    ;DERIVE NEXT VALUES FOR THE CELLS
k2      =       1-sqrt(abs(k1+k3-1))                    ;AT THE K-RATE
k3      =       1-sqrt(abs(k2+k4-1))
k4      =       1-sqrt(abs(k3+k5-1))
k5      =       1-sqrt(abs(k4+k6-1))
k6      =       1-sqrt(abs(k5+k7-1))
k7      =       1-sqrt(abs(k6+k8-1))
k8      =       1-sqrt(abs(k7+k1-1))

aa      foscil  16000*k1,440*(k2+k3+k4),1,0.5*(k1+k2+k3),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ab      foscil  12000*k2,440*(k3+k4+k5),1,0.6*(k2+k3+k4),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ac      foscil  14000*k3,440*(k4+k5+k6),1,0.7*(k3+k4+k5),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ad      foscil  18000*k4,440*(k5+k6+k7),1,0.8*(k4+k5+k6),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ae      foscil  12800*k5,440*(k6+k7+k8),1,0.9*(k5+k6+k7),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
af      foscil  13200*k6,440*(k7+k8+k1),1,1.0*(k6+k7+k8),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ag      foscil  14800*k7,440*(k8+k1+k2),1,1.1*(k7+k8+k1),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1
ah      foscil  15000*k8,440*(k1+k2+k3),1,1.2*(k8+k1+k2),(k1+k2+k3+k4+k5+k6+k7+k8+0.1)/8,1

        out     (aa+ab+ac+ad+ae+af+ag+ah)/8              ;OUTPUT SUM OF ALL FOSCIL GENERATORS

        endin
