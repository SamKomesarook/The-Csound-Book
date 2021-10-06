sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  1

	instr 1

iatt	=  0.002	; attack time
imaxamp	=  1.333	; max. amplitude at attack end
idec	=  0.005	; decay time
irel	=  0.05		; release time

imaxfrq	=  4		; max freq. / base frequency
ifrqdec	=  0.0025	; freq. decay time

; ------------------------------------------------------------

p3	=  p3+irel
imaxamp	=  sqrt(imaxamp)

icps	=  440.0*exp(log(2.0)*(p4-69.0)/12.0)
kcps	port 1,ifrqdec,imaxfrq
kcps	=  kcps*icps

iamp	=  0.0039+p5*p5/16192
kamp	linseg 0,iatt,imaxamp,idec,1,p3-(iatt+idec+irel),1,irel,0,1,0
kamp	=  iamp*kamp*kamp

a1	oscil3 1,kcps,1,0
a2	phasor kcps, 0.75
a2	butterhp a2, kcps*4.0
kffrq	expon 2093, (60/140)*0.5, 1046.5
a2	butterlp a2, kffrq
a1	=  kamp*(a1+a2*2)*15000

	out a1

	endin


