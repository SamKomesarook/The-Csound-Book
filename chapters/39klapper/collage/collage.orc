;Magdalena Klapper, "Collage" - orchestra file

;  instruments:
; - instr   1 - noise generator
; - instr   2 - reads sound files and makes sound constructions,
; - instr  21 - reads sound files
; - instr  22 - as abowe with exp envelope
; - instr 100 - reverb
; - instr 101 - comb
; - instr 102 - delay
; - instr   3 - guitar
; - instr   4 - fof (balls)  

sr = 30000;
kr = 3000;
ksmps = 10;
nchnls = 2;
gaout100 init 0 ;effekt 100   reverb
gaout101 init 0 ;effekt 101  comb 
gaout102 init 0 ;effekt 102 delay

; -------- instrument 1 :
;p1 - instr number
;p2 - start time
;p3 - duration
;p4 - width of noise band	 
;p5 - amplitude (vibrato)
;p6 - time of amplitude rise (vibrato)
;p7 - time of amplitude decay (vibrato)
;p8 - value of vibrato frequency at the beginning, if equol 0 -no vibrato
;p9 - middle value of vibrato frequncy
;p10 - value of vibrqto frequency at the end
;p11 - time of first vibrato frequency change
;p12 - value of filtr central frequency at the beginning
;p13 - middle value of filtr central frequency
;p14 - value of filtr central frequency at the end
;p15 - time of filst changa of filtr central frequency
;p16 - bandwidth at the baginning
;p17 - middle bandwidth
;p18 - bandwidth at the end
;p19 - time of first bandwidth change
;p20 - balance 1 ( 1 - 0 )
;p21 - balance 2 ( 1 - 0 )
;p22 - time of sound moveing ( from balance 1 to balance 2 )
;p23 - log.value, if 1 - global reverb
;p24 - log.value, if 1 - global comb
;p25 - log.value, if 1 - global delay
;p26 - vibrato function nr


instr 1

iwhite = p4
ivamp = p5
ivadel = p6
ivarel = p7
ivf1 = p8
ivf2 = p9
ivf3 = p10
ivt1 = p11
ivt2 = p3 - ivt1
iffsr1 = p12
iffsr2 = p13
iffsr3 = p14
iffts1 = p15
iffts2 = p3 - iffts1
ifpasm1 = p16
ifpasm2 = p17
ifpasm3 = p18
ifpt1 = p19
ifpt2 = p3 - ifpt1
ibal1 = p20
ibal2 = p21
ibdur = p22
ifnr  = p26
kvamp    linen    ivamp, ivadel, p3, ivarel
kvfrq    linseg   ivf1, ivt1, ivf2, ivt2, ivf3
aampv    oscil    kvamp, kvfrq, ifnr
aszum    rand     iwhite
kffsr    linseg   iffsr1, iffts1, iffsr2, iffts2, iffsr3
kfpasm   linseg   ifpasm1, ifpt1, ifpasm2, ifpt2, ifpasm3 
afszum   reson    aszum, kffsr, kfpasm
aout = (ivf1 == 0 ? afszum * kvamp : afszum * aampv)
kbalance line     ibal1, ibdur, ibal2
         outs     aout * kbalance, aout * (1 - kbalance)
   if (p23 != 1)  goto bezefekt100
gaout100 = aout
bezefekt100:
   if (p24 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101:
   if (p25 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 2 :
;p4 - repeating time at the beginning NOTICE! P4-P9 CONECTED WITH P3 
;p5 - max value of factor 1 increase
;p6 - factor 1
;p7 - factor 2
;p8 - pitch of reading sound file
;p9 - factor of pitch change
;p10 - balance ( 1 - 0 )
;p11 - factor of balance change
;p12 - amplitude 
;p13 - factor of amplitude change
;p14 - number of table with sound file
;p15 - log.v., if 1 - g. reverb
;p16 - log.v., if 1 - g. comb
;p17 - log.v., if 1 - g. delay


instr 2

itime = p4
igranica = p5
ind = 0
itczyn1 = p6
itczyn2 = p7
ifreq = p8
ifczyn1 = p9
ibalance = p10
ibczyn = p11
iamp =p12
iaczyn1 = p13
reset:   timout   0, p3/itime, contin
	 reinit   reset
contin:  ind = ind + 1
itime = (ind <= igranica ? itime * itczyn1 : itime * itczyn2)
ifreq = ifreq * ifczyn1
aout     loscil   iamp, ifreq, p14
iamp = iamp * iaczyn1
ibalance = (ibalance * ibczyn == 1 ? ibalance * ibczyn : frac (ibalance * ibczyn))
         rireturn
         outs     aout * ibalance, aout * (1 - ibalance)
   if (p15 != 1)  goto bezefekt100
gaout100 = aout 
bezefekt100:
   if (p16 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101:
   if (p17 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 21:
;p4 - amplitude 
;p5 - frequency at the beginning
;p6 - middle frequency
;p7 - frequency at the end
;p8 - time of first frequency charge (value 1 - 0 )
;p9 - balance
;p10 - number of function ( sound file
;p11 - log.v., if 1 - g. reverb
;p12 - log.v., if 1 - g. comb
;p13 - log.v., if 1 - g. delay


instr 21

ibalance = p9 
iamp = p4
ifcz1 = p5
ifcz2 = p6
ifcz3 = p7
ift1 = p3 * p8     
ift2 = p3 - ift1
kfreq    linseg   ifcz1, ift1, ifcz2, ift2, ifcz3
aout     loscil   iamp, kfreq, p10 
         outs     aout * ibalance, aout * (1 - ibalance)
   if (p11 != 1)  goto bezefekt100
gaout100 = aout
bezefekt100:
   if (p12 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101: 
   if (p13 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 22:
; as instr 21, but exp amplitude envelope


instr 22

ibalance = p9
iamp = p4
ifcz1 = p5
ifcz2 = p6
ifcz3 = p7
ift1 = p3 * p8     
ift2 = p3 - ift1
kamp     expon    .001, p3, iamp
kfreq    linseg   ifcz1, ift1, ifcz2, ift2, ifcz3
aout     loscil   kamp, kfreq, p10 ;
         outs     aout * ibalance, aout * ( 1 - ibalance ) ;
   if (p11 != 1)  goto bezefekt100
gaout100 = aout
bezefekt100:
   if (p12 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101:
   if (p13 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 3:
;p4  amplitude
;p5  frequency
;p6  function number 
;p7  method number ( 1, 2, 3, 4, 5, 6 )
;p8  first value of frequency change
;p9  second value of frequency change
;p10 time of first frequency change
;p11 rise
;p12 decay
;p13 vibrato function number
;p14 vibrato frequency at the beginning
;p15 first value of vibrato frequency change
;p16 second value of vibrato frequency change
;p17 time of first frequency vibrato change
;p18 amplitude of vibrato
;p19 rise of vibrato
;p20 decay of vibrato
;p21 balance
;p25 pluck factor 1 ,depends on the method
;p26 pluck factor 2
;p22 log.v., if 1 - g. reverb
;p23 log.v., if 1 - g. comb
;p24 log.v., if 1 - g. delay


instr 3

iamp = ampdb(p4)
ifreq = p5
ifnr = p6 
imeth = p7
iv1 = p8
iv2 = p9
it1 = p10
it2 = p3 - p10
idur = p3
idel = p11
irel = p12
iparm1 = p25
iparm2 = p26
ivfnr = p13
ivfreq = p14
ivv1 = p15
ivv2 = p16
ivt1 = p17
ivt2 = p3 - p17 
ivamp = p18
ivdel = p19
ivrel = p20
ibalance = p21
ivsus = p3 - (ivdel + ivrel)
kfreq    linseg   ifreq, it1, iv1, it2, iv2
kamp     linen    iamp, idel, idur, irel
kvfreq   linseg   ivfreq, ivt1, ivv1, ivt2, ivv2
kvampl   linseg   0, ivdel, ivamp, ivsus, ivamp, ivrel, 0
kvibr    oscil    kvampl, kvfreq, ivfnr
   if (imeth > 1) goto parametr1
aout1    pluck    kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth
aout2    pluck    kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth
         goto dalej
parametr1:
   if (imeth > 3) goto parametr2
aout1    pluck    kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth, iparm1
aout2    pluck    kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth, iparm1
         goto dalej
parametr2:
aout1    pluck    kamp, kfreq+kvibr, ifreq*.9, ifnr, imeth, iparm1, iparm2
aout2    pluck    kamp, kfreq+kvibr, ifreq*1.1, ifnr, imeth, iparm1, iparm2
dalej:
aout =  aout1 + aout2
         outs     aout * ibalance, aout * ( 1 - ibalance )
   if (p22 != 1)  goto bezefekt100
gaout100 = aout
bezefekt100:
   if (p23 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101:
   if (p24 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 4:
;p4 - balance at the beginning
;p5 - time of first amplitude change
;p6 - time of second amplitude change
;p7 - amplitude value at the beginning
;p8 - middle amplitude value
;p9 - amplitude at the end
;p10 - time of first frequency change ( exp envelope )
;p11 - time of second frequency change
;p12 - frequency value at the beginning
;p13 - middle frequency value
;p14 - frequency value at the end
;p15 - first function number
;p16 - second function number
;p17 - formant frequency
;p18 - log.v., if 1 - g. reverb
;p19 - log.v., if 1 - g. comb
;p20 - log.v., if 1 - g. delay
;p21 - balance


instr 4

ibalance1 = p4
iarel = p5
iadel = p6
iaw1 = ampdb(p7)
iaw2 = ampdb(p8)
iaw3 = ampdb(p9)
ifrel = p10
ifdel = p11
ifw1 = p12
ifw2 = p13
ifw3 = p14
inr1 = p15
inr2 = p16
iff  = p17
ibalance2 = p21
a3       expseg   ifw1, ifrel, ifw2, ifdel, ifw3
a2       linseg   iaw1, iarel, iaw2, iadel, iaw3
aout     fof      a2, a3, iff, 0, 40, .003, .02, .007,  5, inr1, inr2, p3
abalance line     ibalance1, p3, ibalance2
         outs     aout*abalance, aout*(1-abalance)
   if (p18 != 1)  goto bezefekt100
gaout100 = aout
bezefekt100:
   if (p19 != 1)  goto bezefekt101
gaout101 = aout
bezefekt101:
   if (p20 != 1)  goto bezefekt102
gaout102 = aout
bezefekt102:

endin
;---------------------------------------

; -------- instrument 100 :
;p4 - reverb time
;p5 - reverb ampliyude
;p6 - reverb rise
;p7 - reverb decay


instr 100

irvczas = p4
iamp = p5
idur = p3
idel = p6
irel = p7
kramp    linen    iamp, idel, idur, irel
arout = gaout100 * kramp
aout     reverb   arout, irvczas
         outs     aout * .5, aout * .5
gaout100 = 0

endin
;---------------------------------------

; -------- instrument 101:
;p4 - comb time 
;p5 - comb amplitude
;p6 - comb rise 
;p7 - comb decay
;p8 - repeating frequency


instr 101

icmbczas = p4
iamp = p5
idur = p3
idel = p6
irel = p7  
igest = p8

kcamp    linen    iamp, idel, idur, irel
acout = gaout101 * kcamp
aout     comb     acout, icmbczas, igest
         outs     aout*.5, aout*.5
gaout101 = 0

endin
;---------------------------------------

; -------- instr 102:
;p4 - time of silgle repeat
;p5 - amplitude
;p6 - delay rise
;p7 - delay decay


instr 102

idczas = p4
iamp = p5
idur = p3 
idel = p6
irel = p7
kdamp    linen    iamp, idel, idur, irel
adout = gaout102 * kdamp
aout     delay    adout, idczas
         outs     aout*.5, aout*.5
gaout102 = 0

endin  
;-------------------------------------------------

