;JULIE FRIEDMAN MS107CSOUND BERKLEE COLLEGE OF MUSIC

;THE HEARTBEAT

sr = 44100
kr = 4410
ksmps = 10
nchnls = 2


instr 1			;CRACKLE
;p4=amp
;p5=freq
;p6=attack time
;p7=release time
kpan oscil 1,(p3*5),1
k1 linen p4, p6, p3, p7
a1 oscil k1, p5, 11
a2 fof	a1,p5+a1, a1*(p4/50), k1, 200, .003, .017, .005, 20, 1,2, p5
arev reverb2	a2, 5, 1
outs ((arev+a2)*.2)*kpan,((arev+a2)*.2)*(1-kpan)

endin


instr 2			;HEARTBEAT
idur = p3
iamp = p4/2
ifq  = 4
if1  = 12
if2  = 13
a2  oscili  iamp, 1/idur, 72
a2  oscili  a2, ifq, if2   
a1  oscili  iamp, 1/idur, 71
a1  oscili  a1, ifq, if1          
outs (a1+a2) * 4.5, (a1+a2) * 4.5
endin

instr 3			;SUPER CHORUSING
iamp=ampdb(p4)
irise=p5 
idur=p3
idec=p6
inote=cpspch(p7)
k1  linen     iamp, irise, idur, idec
k2 	line 10000, idur, 0
k3 	oscil  1, 	2,	1
k4 	oscil  .5, 2, 1
a1 	oscil  k1, (inote-1)+k3, 2
a2 	oscil  k1, (inote+1)+k4, 9
a3 	oscil  k1, (inote-.5), 9
a4 	oscil  k1, (inote+.5), 2
a5 	oscil  k1, (inote-2)+k4, 2
a6 	oscil  k1, (inote+2)+k3, 9
a7 	oscil  k1, (inote-1.5)+k3, 9
a8 	oscil  k1, (inote+1.5)+k3, 2
a9 		oscil  k1, (inote-.25), 2
a10 	oscil  k1, (inote+.25), 9
a11 	oscil  k1, (inote-.8)+k4, 9
a12 	oscil  k1, (inote+.8)+k4, 2
ar1 areson a1,k2, 10, 1
ar2 areson a2,(k2*k3), 20, 1
ar3 areson a3,k2, 30, 1
ar4 areson a4,k2, 40, 1
ar5 areson a5,k2, 50, 1
ar6 areson a6,k2, 60, 1
ar7 areson a7,k2, 70, 1
ar8 areson a8,k2, 80, 1
ar9  areson a9,k2, 50, 1
ar10 areson a10,k2, 60, 1
ar11 areson a11,k2, 70, 1
ar12 areson a12,k2, 80, 1
asig1=(ar1+ar4+ar6+ar8+ar9)/5.5
asig2=(ar2+ar3+ar5+ar7+ar10)/5.5
asig3=(ar11+ar12)/2

outs  (asig1+asig3)/2, (asig2+asig3)/2

endin 

instr 4			;PANNING PLUCK
idur=p3
iplk=p7
iam=ampdb(p4)
inote=cpspch(p5)
kpick=p6
k1   linen    ( iam/2), (idur*.2), idur,( idur*.8)
a2 oscil k1, inote+2, 1
ar1    repluck   iplk, iam, inote+1, kpick, .5, a2
a4 oscil k1, inote-2, 1
ar3    repluck   iplk, iam, inote-1, kpick, .5, a4
asig1=(ar1+ar3)/2
arev	reverb2 asig1, 1.5, 1
afin=(asig1+(arev*.6))/1.6
outs	afin*p8, afin*(1-p8)
endin 


