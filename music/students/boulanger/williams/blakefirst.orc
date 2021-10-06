sr = 44100
kr = 4410 
ksmps = 10
nchnls = 2
garvbsig init 0


instr 3
			ibalance = p8
			k1 linen p4, p6, p3, p7
		 	a1 oscil k1, p5*.9, 1
            a2 oscil k1, p5, 1
            a3 oscil k1, p5*1.1,1
            a1 = a1+a2+a3
            garvbsig = garvbsig+a1*.1
            outs a1*ibalance, a1*(1-ibalance)
endin

instr 99	
irvbtime	=	p4
asig	reverb	garvbsig, irvbtime	
outs	asig, asig
garvbsig	=	0	
endin



instr 1
			ibalance = p8
			k1 linen p4, p6, p3, p7
			a1 oscil k1, p5*.95, 1
			a2 oscil k1, p5*.9, 1
			a3 oscil k1, p5*1.1, 1
			a4 oscil k1, p5*1.15, 1
			a1 = a1+a2+a3+a4
			garvbsig = garvbsig+a1*.01
			outs a1*ibalance, a1*(1-ibalance)
endin			



