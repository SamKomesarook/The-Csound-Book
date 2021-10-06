sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

garvb	init	0


;  Instrument 102 is an FM instrument using the opcode "foscil".
;  The EG "expon" is responsible for sweeping across modulating frequencies.
;  It is also ring modulated with an "oscil", which is panned slightly to the left.



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
kring     oscil	    	iringdepth, iring, 1
a1        foscil        k1, ipitch, 1, k2, indx, 1 
          outs          a1*(kring), a1*(kring/2) 
garvb 	  =		        garvb+(a1*irvbsnd)	
          endin



; Instrument 199 is a reverb instrument using the "reverb2" opcode.
; It cycles back and forth across the stereo field at a changing frequency
; This frequency is controlled by an "expon" and biased such that it is unipolar.
; An "expseg" helps prevent pops by starting and ending the sound at amplitude zero.
		
		          instr     199

idur         =         p3                       
irvbtim      =         p4
ihiatn       =         p5
ipanfrqst	 =		   p6	
ipanfrqend   =         p7

kenv      expseg      .001, .05, 1, idur-.25, 1, .2, .001
arvb      reverb2     garvb*kenv, irvbtim, ihiatn
kpanenv   expon       ipanfrqst, idur, ipanfrqend
kpan	  oscil	      .5, kpanenv, 1     
kpanlfo	  =  		  kpan+.5	 
          outs        arvb*kpanlfo, arvb*(1-kpanlfo)
garvb     =           0
          endin


; Instrument is similar to 102 except that the ringmodulation randomly changes loudness
; at a rate of 4 times per second on the left and 6 times per second on the right.  The opcode
; "randh" is used to accomplish this task.


          instr   1022

imod1	   =		p4
imod2      =        p7
indx	   =		p5
ipitch     =		cpspch(p6)
irvbsnd    =		p8
iring	   =		p9   
iringdepth =        p10		;BETWEEN 0-1

k1		  expseg		1, p3/2, 10000, p3/2, 1
k2		  expon		  	imod1, p3, imod2
kring     oscil		    iringdepth, iring, 1
a1        foscil        k1, ipitch, 1, k2, indx, 1 
k3        randh		    1, 4
k4		  randh         1, 6	  
          outs          a1*(kring*k3)*150, a1*(kring*k4)*150
garvb 	  =		        garvb+(a1*irvbsnd)	
          endin


; Instrument 1033 is a random noise generator (rand) which is filtered through
; a bandpass filter (reson).  A similar technique is used to controll the stereo position
; of this Instrument as in Inst 1022.  Randh opcodes randomly choose values for the output
; of each side at 10 and 15 times per second respectively.

           instr  1033
           
icutoff  =   p4
ibw		 =   p5
irvbsnd  =   p6

k3        expseg    .01, p3/3, 10000, p3/3, 10000, p3/3, .01                 
a1		  rand      k3
a2		  reson  	a1, icutoff, ibw
k1		  randh	    1, 10
k2        randh     1, 15
		  outs      (a2*(abs(k1)))/6.66, (a2*(abs(k2)))/6.66
garvb     =         garvb+(a2*irvbsnd)
		  endin		
	    
      		     
; Instrument 1999 is similar to 199, except that it is ballenced for 1022 and 1033.     
		
		          instr     1999

idur         =         p3                       
irvbtim      =         p4
ihiatn       =         p5
ipanfrqst	 =	       p6	
ipanfrqend   =         p7

kenv      expseg    .001, .05, 1, idur-.25, 1, .2, .001
arvb      reverb2   garvb*kenv, irvbtim, ihiatn
kpanenv   expon     ipanfrqst, idur, ipanfrqend
kpan	  oscil	    .5, kpanenv, 1     
kpanlfo	  =  		kpan+.5	 
          outs      (arvb*kpanlfo)*1.5, (arvb*(1-kpanlfo))*1.5
garvb     =         0
          endin


; Instrument 10222 employs the same technique of random stereo placement,
; but now the rate at which the change of each sides output is controlled
; by a "line" envelope.  "iringraters" and "iringratere" refer to the starting
; and ending frequencies of the random changes of the right side.  "iringratels" and 
; "iringratele" refer to the starting and ending frequencies of random changes of the 
; left side.  

          instr   10222

imod1	    =		p4
imod2       =       p7
indx	    =		p5
ipitch      =		cpspch(p6)
irvbsnd     =		p8
iring	    =		p9   
iringraters =       p10		
iringratere =       p11
iringratels =       p12
iringratele =       p13


k1	      expseg		1, p3/2, 10000, p3/2, 1
k2	      expon		  	imod1, p3, imod2
kring     oscil	    	.015, iring, 1
a1        foscil        k1, ipitch, 1, k2, indx, 1 
kratel    line          iringratels, p3, iringratele
krater    line          iringraters, p3, iringratere
k3        randh		    1, kratel
k4		  randh         1, krater	  
          outs          a1*(kring*k3)*150, a1*(kring*k4)*150
garvb 	  =		        garvb+(a1*irvbsnd)	
          endin


; Instrument 10333 is similar to 1033, but it is ballenced for 10222.

           instr  10333
           
icutoff     =   p4
ibw		    =   p5
irvbsnd     =   p6

k3          expseg    .01, p3/3, 10000, p3/3, 10000, p3/3, .01                 
a1	    	rand      k3
a2		    reson	  a1, icutoff, ibw
k1		    randh	  1, 10
k2          randh     1, 15
		    outs      (a2*(abs(k1)))/6.66, (a2*(abs(k2)))/6.66
garvb       =         garvb+(a2*irvbsnd)
		    endin		
	    
      		     
      
; Instrument 19999 is similar to 1999, but it is ballenced for 10222 and 10333.

		
		          instr     19999

idur          =         p3                       
irvbtim       =         p4
ihiatn        =         p5
ipanfrqst	  =			p6	
ipanfrqend    =         p7

kenv          expseg    .001, .05, 1, idur-.25, 1, .2, .001
arvb          reverb2   garvb*kenv, irvbtim, ihiatn
kpanenv       expon     ipanfrqst, idur, ipanfrqend
kpan	      oscil	    .5, kpanenv, 1     
kpanlfo	      =  		kpan+.5	 
              outs      (arvb*kpanlfo)*1.5, (arvb*(1-kpanlfo))*1.5
garvb         =         0
              endin


