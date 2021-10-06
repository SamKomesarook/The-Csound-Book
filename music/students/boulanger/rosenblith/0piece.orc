sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

garvb	init	0

          instr   102
imod1	  =		p4
imod2     =     p7
indx	  =		p5
ipitch    =		cpspch(p6)
irvbsnd   =		p8
iring	  =		p9   
iringdepth =    p10		;BETWEEN 0-1

k1		  expseg		1, p3/2, 10000, p3/2, 1
k2		  expon		  	imod1, p3, imod2
kring     oscil		iringdepth, iring, 1
a1        foscil     k1, ipitch, 1, k2, indx, 1 
          outs     a1*(kring), a1*(kring/2) 
garvb 	  =		garvb+(a1*irvbsnd)	
          endin


		
		          instr     199
idur      =         p3                       
irvbtim   =         p4
ihiatn    =         p5
ipanfrqst	  =			p6	
ipanfrqend   =      p7
kenv      expseg    .001, .05, 1, idur-.25, 1, .2, .001
arvb      reverb2   garvb*kenv, irvbtim, ihiatn
kpanenv   expon     ipanfrqst, idur, ipanfrqend
kpan	  oscil	    .5, kpanenv, 1     
kpanlfo	  =  		kpan+.5	 
          outs       arvb*kpanlfo, arvb*(1-kpanlfo)
garvb     =         0
          endin


