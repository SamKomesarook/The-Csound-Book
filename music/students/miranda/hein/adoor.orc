;-------------------------------------------------
; CENTRE FOR MUSIC TECHNOLOGY - GLASGOW UNIVERSITY
; SOFTWARE SYNTHESIS AND COMPOSITION SYSTEMS
; TUTOR: DR MIRANDA
; STUDENT NAME: SUSANNE HEIN
; INSTRUMENT: ADOOR.ORC
;-------------------------------------------------
; HUMAN VOICE SOUND WITH GBUZZED PITCH

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
                    
garvbsig  init      0    
     
          instr 1
                                                     ; JITTER
k1        linseg    0,p3*0.1,0,p3*0.4,0.4,p3*0.5,0
a1        gbuzz     200,p4,15,1,k1,3
krnd1     randi     0.02,0.05
krnd2     randi     0.02,0.111
krnd3     randi     0.02,1.219
ksum      =         krnd1+krnd2+krnd3
kfnd      =         p4*k1+(p4*ksum)
                                                     ; VIBRATO
kaw       rand      0.03
kawt      =         abs(kaw)+.03
kvib      oscil     (kfnd*kawt),5.2,1
kfund     =         kvib+kfnd
                                                     ; VOICING SOURCE
knh       =         int(11025/p4)
apulsev   buzz      ampdb(p7),kfund,knh,1
apulseqv  buzz      ampdb(p8),kfund,knh,1
alpfgv    reson     apulsev,0,p5*1.414,1
alpfgqv   reson     apulseqv,0,p5*1.414,1
alpfqs    reson     alpfgqv,0,p6*1.414,1
anv       balance   alpfgv,apulsev
aqsv      balance   alpfqs,apulseqv
avoicing  =         anv+aqsv
                                                     ; NOISE SOURCE
arnd      rand      1
amodf     oscil      0.5,kfund,2
afric     =         (0.5*arnd)+amodf
kah       =         ampdb(40)/2
amodh     oscil     kah,kfund,2
aspir     =         (kah*arnd)+amodh
                                                     ; SERIAL FILTERS
abrfzc    =         avoicing+aspir
abpf1c    reson     abrfzc,622.5,80,1
abpf2c    reson     abpf1c,1028,90,1
abpf3c    reson     abpf2c,2900,120,1
abpf4c    reson     abpf3c,3900,130,1
abpf5c    =         abpf4c

acascout  balance   abpf5c,avoicing+aspir
                                                     ; PARALLEL FILTERS
abpf2p    reson     afric*ampdb(-6),1028,90,1
abpf3p    reson     afric*ampdb(-32),2900,120,1
abpf4p    reson     afric*ampdb(-20),3900,130,1
abpf5p    reson     afric*ampdb(-50),4950,140,1
abypass   =         afric*ampdb(0)
aparout   =         abpf2p+abpf3p+abpf4p+abpf5p+abypass
                    
                                                     ; ENVELOPE
                                                     
kenv      linseg    0,0.05*p3,1,0.01*p3,0.9,0.79*p3,0.85,0.15*p3,0
atot      =         (acascout+aparout)*kenv
aout      =         (atot*a1)/200
          out       aout
garvbsig  =         garvbsig+aout*p9
          endin

;================

          instr 2
asig      reverb    garvbsig, 5
          out       asig
garvbsig  =         0
          endin
