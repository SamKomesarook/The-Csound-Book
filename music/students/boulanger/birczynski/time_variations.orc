; -------------------------------------------------------------------------------------------------------------
; DANIEL BIRCZYNSKI                            daniel@orangewaves.com          www.orangewaves.com            -
;                                                                                                             -
;"TIME VARIATIONS" for Csound and Female Voice         voice - Magdalena Birczynska                           -
;                                                                                                             -
; This piece is dedicated to Wojtek Szawul, a good friend of mine who recently past away.                     -
; He was a good man, very open and friendly person and we all miss him a lot.                                 -
;                                                                                                             -
; April 16th 2002                                                                                             -
;                                                                                                             -
; ORCHESTRA FILE FOR GENERATING STEREO OUTPUT USING TWO GRANULE OPCODES                                       -
; Based on chapter 13 by Allan S. C. Lee (from The Csound Book) - Granular Synthesis in Csound                -
; -------------------------------------------------------------------------------------------------------------

; Don't forget to copy the samples to your Csound Samples Folder!

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2
        
ga1     init    0
ga2     init    0     

        instr   1
kmod    linseg  1, p3, p26
k1      linseg  0, 0.1*p3, 1, 0.8*p3, 1, 0.1*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20+0.17,p21,p22,p23,p24,p25
        outs    a1,a2
        endin

        instr   2
kmod    linseg  1, p3, p26
k1      linseg  0, 0.2*p3, 1, 0.2*p3, 1, 0.6*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21*.5,p22*1.01,p23*1.8,p24*.99,p25
        outs    a1,a2
        ga1 = ga1+a1
        ga2 = ga2+a2
        endin
        
        instr   3
kmod    linseg  1, p3, p26
k1      linseg  0, 0.6*p3, 1, 0.2*p3, 1, 0.2*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21*.5,p22*1.01,p23*1.8,p24*.99,p25
        outs    a1,a2
        ga1 = ga1+a1
        ga2 = ga2+a2
        endin 
               
        instr   4
kmod    linseg  1, p3, p26
k1      linseg  0, 0.4*p3, 1, 0.2*p3, 1, 0.4*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21*.5,p22*1.01,p23*1.8,p24*.99,p25
        outs    a1,a2
        ga1 = ga1+a1
        ga2 = ga2+a2
        endin
     
        instr   5
kmod    linseg  1, p3, p26
k1      linseg  0, 0.1*p3, 1, 0.8*p3, 1, 0.1*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20+0.17,p21,p22,p23,p24,p25
        outs    a1,a2
        ga1 = ga1+a1
        ga2 = ga2+a2
        endin        
        
        instr   6
kmod    linseg  1, p3, p26
k1      linseg  0, 0.6*p3, 1, 0.1*p3, 1, 0.3*p3, 0
a1      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20,p21,p22,p23,p24,p25
a2      granule p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16*kmod,p17,p18,p19,p20+0.17,p21,p22,p23,p24,p25
        outs    a1,a2
        ga1 = ga1+a1
        ga2 = ga2+a2
        endin
        
; Voice line #1
        
        instr    7
        idur =   p3
        iamp =   p4
a1 a2   soundin  "voiceone.aif", 0, 0
kamp    linen     iamp, .001, idur, .001        
        outs      a1*kamp, a2*kamp
        endin

; Voice line #2
          
        instr    8
        idur =   p3
        iamp =   p4
a1 a2   soundin  "voicetwo.aif", 0, 0
kamp    linen     iamp, .001, idur, .001        
        outs      a1*kamp, a2*kamp
        endin

;stereo reverb
        
        instr    98
a3      reverb   ga1,  1
        outs1    a3*.1
        ga1= 0
        endin
        
        instr    99
a4      reverb   ga2,  1
        outs2    a4*.1
        ga2= 0
        endin