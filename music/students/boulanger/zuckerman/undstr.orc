sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

instr 1		;stretch snd to roughly 30s
iamp = p4
ibeg = p5
iend = p6
ipitch = p7
kenv  linen  iamp, .001, p3, .001
ktimpt line  ibeg, p3, iend
apv  pvoc  ktimpt, ipitch, "underbit dup.pv"
out apv*kenv
endin
