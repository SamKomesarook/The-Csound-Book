;-------------------------------------------------
;Centre for Music Technology - Glasgow University
;Software Synthesis and Composition Systems
;Tutor: Dr Miranda
;Student Name: Kenny McAlpine
;Intrument: electro.orc
;-------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
;=================================================
         instr    1
; p4=Fundamental frequency
; p5=Relative amplitude of fundamental
; p6=Relative amplitude of 1st harmonic
; p7=Relative amplitude of 2nd harmonic
; p8=Relative amplitude of 3rd harmonic
; p9=Relative amplitude of 4th harmonic
; p10=Relative amplitude of 5th harmonic
; p11=Relative amplitude of 6th harmonic
; p12=Relative amplitude of 7th harmonic
; p13=Relative amplitude of 8th harmonic
; p14=Relative amplitude of 9th harmonic
;
a1       oscil    1000 * p5, p4, 1
a2       oscil    1000 * p6, p4*2, 1
a3       oscil    1000 * p7, p4*3, 1
a4       oscil    1000 * p8, p4*4, 1
a5       oscil    1000 * p9, p4*5, 1
a6       oscil    1000 * p10, p4*6, 1
a7       oscil    1000 * p11, p4*7, 1
a8       oscil    1000 * p12, p4*8, 1
a9       oscil    1000 * p13, p4*9, 1
a10      oscil    1000 * p14, p4*10, 1
aout     =        a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10
         outs     aout * p15, aout * (1 - p15)
         endin
;=================================================


;=================================================
         instr    2
; p4 = Frequency
; p5 = Embouchure size
; p6 = Feedback scaler 1
; p7 = Feedback scaler 2
; p8 = Amplitude scaler
; p9 = Amplitude of filter control oscillator 1
; p10 = Frequency of filter control oscillator 1
; p11 = Amplitude of filter control oscillator 2
; p12 = Frequency of filter control oscillator 2
; p13 = Pan
;
kcrntflw linseg   0, p3 * 0.05, 1, p3 * 0.9, 1, p3 * 0.05, 0
koutenv  linseg   0, p3 * 0.05, p8, p3 * 0.9, p8, p3 * 0.05, 0
k1       oscil    p9, p10, 1
k2       oscil    p11, p12, 1
abreath  randh    1, sr/2
iperdly  =        1/p4
iembdly  =        iperdly * p5
inoise   =        0.0356
adlysig  delayr   iperdly
asum1    =        kcrntflw + inoise * kcrntflw * abreath
asum2    =        asum1 + p6 * adlysig
aembsig  delay    asum2, iembdly
asum3    =        p7 * adlysig + aembsig - aembsig * aembsig * aembsig
aoutsig  tone     asum3, p4 * 2 
delayw   aoutsig
aout1    reson    aoutsig, k1, k2, 1
aout2    =        koutenv * aout1
         outs     aout2 * p13, aout2 * (1 - p13)
         endin
;=================================================


;=================================================
         instr    3
; p4 = amplitude
; p5 = carrier frequency
; p6 = modulation rate of first modulator
; p7 = deviation of first modulator
; p8 = modulation of second modulator
; p9 = deviation of second modulator
; p10 = detune up
; p11 = detune down
; p12 = pan
; 
kenv     expon    1, p3, 0.001
amod1    oscil    p6, p7, 1
amod2    oscil    p8, p9 + amod1, 1
acar     oscil    kenv * p4, p5 + amod2, 1
atot     =        ((acar * p10) + acar + (acar * p11))/3
         outs     atot*p12, atot * (1 - p12)
         endin
;=================================================


;================================================= 
         instr    4
; p4 = Amplitude
; p5 = Frequency
; p6 = Pan
;
kenv     linseg   0, p3 * 0.05, 1, p3 * 0.9, 1, p3 * 0.05, 0
k1       expseg   800, p3 * 0.05, 900, p3 * 0.45, 400, p3 * 0.5,1200
a1       oscil    p4, p5, 2
aout     reson    a1, k1 * k1 - k1, k1, 1
         outs     kenv * aout * p6, kenv * aout * (1 - p6)
         endin
;=================================================


;================================================= 
         instr    5
; p4 = Ring modulator amplitude
; p5 = Ring modulator frequency
; p6 = Amplitude modulator frequency
; p7 = frequency modulator depth
; p8 = frequency modulator rate
; p9 = carrier amplitude
; p10 = carrier pitch
; p11 = pan
;
kenv     expseg   1, p3, 0.01
kmod1    oscil    p4, p5, 1
kmod2    oscil    kmod1, p6, 1
kmod3    oscil    p7 + kmod2, p8, 1
acar     oscil    p9 * kenv, cpspch(p10) + kmod3, 1
         outs     acar * p11, acar * (1 - p11)
         endin
;=================================================


;=================================================
         instr    6 
; p4 = Pitch
; p5 = Amplitude
; p6 = Vibrato Rate
; p7 = Glide delay time
; p8 = Frequency change
; p9 = Pan
;
aglide   expseg   1, p7, 1, p3 - p7, p8        

;-----------------
; CARRIER 1
;-----------------
k1       line     0, p3, 5
k2       oscil    k1, p6, 1
k3       linseg   0, p3 * 0.7, p7, p3 * 0.3, 0
a1       oscil    k3, (cpspch(p4) + k2) * aglide, 1

;-----------------
; CARRIER 2
;-----------------
k4       linseg   0, p3 * 0.6, 6, p3 * 0.4, 0
k5       oscil    k4, p6 * 0.9, 1, 1.4
k6       linseg   0, p3 * 0.9, p5, p3 * 0.1, 0
a2       oscil    k6, ((cpspch(p4) + 0.009) + k5) * aglide, 3, 0.2

;-----------------
; CARRIER 3
;-----------------
k7       linseg   9, p3 * 0.7, 1, p3 * 0.3, 1
k8       oscil    k7, p6 * 1.2, 1, 0.7
k9       linen    p5, p3 * 0.5, p3, p3 * 0.333
a3       oscil    k9, ((cpspch(p4) + 0.007) + k8) * aglide, 4, 0.3

;-----------------
; CARRIER 4
;-----------------
k10      expseg   1, p3 * 0.99, 3.1, p3 * 0.01, 3.1
k11      oscil    k10, p6 * 0.97, 1, 0.6
k12      expseg   0.001, p3 * 0.8, p5, p3 * 0.2, 0.001
a4       oscil    k12,((cpspch(p4) + 0.005) + k11) * aglide, 5, 0.5

;-----------------
; CARRIER 5
;-----------------
k13      expseg   1, p3 * 0.4, 3, p3 * 0.6, 0.02
k14      oscil    k13, p6 * 0.99, 1, 0.4
k15      expseg   0.001, p3 *0.5, p5, p3 *0.1, p5 *0.6, p3 *0.2, p5 *0.97, p3 *0.2, 0.001
a5       oscil    k15, ((cpspch(p4) + 0.003) + k14) * aglide, 6, 0.8

;-----------------
; CARRIER 6
;-----------------
k16      expseg   4, p3 * 0.91, 1, p3 * 0.09, 1
k17      oscil    k16, p6 * 1.4, 1, 0.2
k18      expseg   0.001, p3 *0.6, p5, p3 *0.2, p5 *0.8, p3 *0.1, p5 *0.98, p3 *0.1, 0.001
a6       oscil    k18, ((cpspch(p4) + 0.001) + k17) * aglide, 7, 1.3
         outs     p9 * (a1 + a2 + a3 + a4 + a5 + a6) / 2, (1 - p9) * (a1 + a2 + a3 + a4 + a5 + a6) / 2
         endin
;=================================================


;================================================= 
         instr    7 
; p4 = modulator 1 amplitude
; p5 = modulator 1 frequency
; p6 = modulator 2 frequency
; p7 = carrier frequency
; p8 = pan
;
kenv     expseg   0.01, p3 * 0.5 , 1, p3 * 0.5, 0.01
amod1    oscil    kenv * p4, p5, 1
amod2    oscil    kenv * amod1, p6, 1
acar     oscil    kenv * amod2, p7, 1
         outs     acar * p8, acar * (1 - p8)
         endin
;=================================================


;=================================================
         instr    8
; p4 - Pitch
; p5 - Amplitude
; p6 - Pan
; 
kenv     expon    1, p3, 0.001
aout     oscili   kenv * p5, cpspch(p4), 4
         outs     aout * p6, aout * (1 - p6)
         endin
;=================================================


;================================================= 
         instr    9 
; p4 - Pitch
; p5 - Amplitude
; p6 - Pan
; 
kenv     expseg   0.001, p3 * 0.05 , 1, p3 * 0.9, 1, p3 * 0.05, 0.001
aout     oscili   kenv * p5, cpspch(p4), 5
         outs     aout * p6, aout * (1 - p6)
         endin
;=================================================


;================================================= 
         instr    10 
; p4 = Fundamental frequency
; p5 = Vibrato rate
; p6 = Amplitude of normal voicing
; p7 = Amplitude of quasi-sinusoidal voicing
; p8 = LPF's cut-off frequency in Hz
; p9 = LPF's cut-off frequency in Hz
; p10 = Amplitude of aspiration signal.
; p11 = Nasal BPF's passband centre frequency in Hz.
; p12 = Nasal BPF's bandwidth in Hz.
; p13 = Anti-resonator's passband centre frequency in Hz.
; p14 = Anti-resonator's bandwidth in Hz.
; p15 = Filter 1's passband centre frequency in Hz.
; p16 = Filter 1's bandwidth in Hz.
; p17 = Filter 2's passband centre frequency in Hz.
; p18 = Filter 2's bandwidth in Hz.
; p19 = Filter 3's passband centre frequency in Hz.
; p20 = Filter 3's bandwidth in Hz.
; p21 = Filter 4's passband centre frequency in Hz.
; p22 = Filter 4's bandwidth in Hz.
; p23 = Filter 5's passband centre frequency in Hz.
; p24 = Filter 5's bandwidth in Hz.
; p25 = 2nd formant's amplitude.
; p26 = 3rd formant's amplitude.
; p27 = 4th formant's amplitude.
; p28 = 5th formant's amplitude.
; p29 = Bypass amplitude.
; p30 = Start amplitude [0,1]
; p31 = Attack time
; p32 = Decay amplitude [0,1]
; p33 = Decay time
; p34 = Sustain amplitude [0,1]
; p35 = Sustain time
; p36 = Release amplitude [0,1]
; p37 = Release time
; p38 = Final amplitude [0,1]
; p39 = On (1) means amplitude modulation of fricative noise.
; p40 = On (1) means amplitude modulation of aspiration noise.
; p41 = On (1) means side-branch nasal resonators.
; p42 = On (1) means sex of the voice is male.
; p43 = Pitch envelope scaling factor 1
; p44 = Duration 1
; p45 = Pitch envelope scaling factor 2
; p46 = Duration 2
; p47 = Pitch envelope scaling factor 3
; p48 = Duration 3
; p49 = Pitch envelope scaling factor 4
; p50 = Duration 4
; p51 = Pitch envelope scaling factor 5
; p52 = Duration 5
; p53 = Pitch envelope scaling factor 6
; p54 = Duration 6
; p55 = Pitch envelope scaling factor 7
; p56 = Duration 7
; p57 = Pitch envelope scaling factor 8
; p58 = Duration 8
; p59 = Pitch envelope scaling factor 9
; p60 = Pan
;
;--------------
; JITTER
;--------------
krnd1    randi    0.02, 0.05
krnd2    randi    0.02, 0.111
krnd3    randi    0.02, 0.111
ksum     =        krnd1 + krnd2 + krnd3
kfnd     =        p4 + (p4 * ksum)

;---------------
; VIBRATO
;---------------
kptchenv expseg   p43, p3*p44, p45, p3*p46, p47, p3*p48, p49, p3*p50, p51, p3*p52, p53, p3 * p54, p55, p3 * p56, p57, p3 * p58, p59
kaw      rand     0.03
kaw      =        abs (kaw) + 0.03
kvib     oscil    (kfnd * kaw * 0.85), p5, 1
kfund    =        kvib + kfnd * kptchenv

;---------------
; VOICING SOURCE
;---------------
knh      =        int(8000/p4)
apulsev  buzz     p6, kfund, knh, 1
apulseqv buzz     p7, kfund, knh, 1
alpfgv   reson    apulsev, 0, p8*1.414, 1
alpfgqv  reson    apulseqv, 0, p8*1.414, 1
alpfqs   reson    alpfgqv, 0, p9*1.414, 1
anv      balance  alpfgv, apulsev
aqsv     balance  alpfqs, apulseqv
avoicing =        anv + aqsv

;--------------
; NOISE SOURCE
;--------------
arnd     rand     1
if       p39 = 0  goto     nomodfric
amodf    oscil    0.5, kfund, 1
afric    =        (0.5 * arnd) + amodf
goto     aspir
nomodfric:
afric    =        arnd
aspir:
p10      =        p10/2
if       p40 = 0  goto     nomodaspir
amodh    oscil    p10, kfund, 1
aspir    =        (p10 * arnd) + amodh
goto     transfunc
nomodaspir:
aspir    =        p10 * arnd * 2
transfunc:

;---------------
; SERIAL FILTERS
;---------------
abrfzc   =        avoicing + aspir
if       p41 = 0  goto     allpole
abpfnc   reson    avoicing + aspir, p11, p12, 1
abrfzc   areson   abpfnc, p13, p14, 1
allpole:
abpf1c   reson    abrfzc, p15, p16, 1
abpf2c   reson    abpf1c, p17, p18, 1
abpf3c   reson    abpf2c, p19, p20, 1
abpf4c   reson    abpf3c, p21, p22, 1
if       p42 = 1  goto     male
abpf5c   =        abpf4c
goto     balancing
male:
abpf5c   reson    abpf4c, p23, p24, 1
balancing:
acascout balance  abpf5c, avoicing + aspir

;-----------------
; PARALLEL FILTERS
;-----------------
abpf2p   reson    afric * p25, p17, p18, 1
abpf3p   reson    afric * p26, p19, p20, 1
abpf4p   reson    afric * p27, p21, p22, 1
abpf5p   reson    afric * p28, p23, p24, 1
abypass  =        afric * p29
aparout  =        abpf2p + abpf3p + abpf4p + abpf5p + abypass


;-----------------
; ENVELOPE
;-----------------
kenv     linseg   p30, p3 * p31, p32, p3 * p33, p34, p3 * p35, p36, p3 * p37, p38

;-----------------
; OUTPUT
;-----------------
aout     =        (acascout + aparout) * kenv
         outs     aout * p60, aout * (1 - p60)
         endin
;=================================================
