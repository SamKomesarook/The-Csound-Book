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
iringraters =    p10		
iringratere =    p11
iringratels =   p12
iringratele =   p13


k1		  expseg		1, p3/2, 10000, p3/2, 1
k2		  expon		  	imod1, p3, imod2
kring     oscil		.015, iring, 1
a1        foscil     k1, ipitch, 1, k2, indx, 1 
kratel    line  iringratels, p3, iringratele
krater    line  iringraters, p3, iringratere
k3        randh		1, kratel
k4		  randh     1, krater	  
          outs     a1*(kring*k3)*10, a1*(kring*k4)*10
garvb 	  =		garvb+(a1*irvbsnd)	
          endin


           instr  103
           
icutoff  =   p4
ibw		 =   p5
irvbsnd  =   p6

k3        expseg   .01, p3/3, 10000, p3/3, 10000, p3/3, .01                 
a1		rand     k3
a2		reson	a1, icutoff, ibw
k1		randh	  1, 10
k2      randh     1, 15
		outs  (a2*(abs(k1)))/100, (a2*(abs(k2)))/100
garvb   =     garvb+(a2*irvbsnd)
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
          outs       (arvb*kpanlfo)/10, (arvb*(1-kpanlfo))/10
garvb     =         0
          endin


