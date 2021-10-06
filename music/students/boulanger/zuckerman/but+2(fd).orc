sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

instr 1		;pitch shift "but-12.snd" in frequency domain using pvoc
iamp = p4
ibeg = p5
iend = p6
ipitch = p7
kenv  linen  iamp, .001, p3, .001
ktimpt  line  ibeg, p3, iend
apv  pvoc  ktimpt, ipitch, "but-12.pv"
out apv*kenv
endin   
