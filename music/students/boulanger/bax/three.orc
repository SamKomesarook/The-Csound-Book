; THREE
; BY DAVID BAX




sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

gadly     init 	0
gadly2    init 	0
garev     init      0

          instr  1
aw2       linen     p5,.0001,p3,p3
aw1       oscili    aw2,cpspch(p4),1
		outs 	aw1, aw1
gadly 	= 		gadly + aw1
      
		endin

 

	    
          instr  2
aw1       line      .000000001,p3,40
aw2       oscil     10000,aw1,2
aw3       oscil     200,aw1,2
aw6       oscil     aw2,aw3,2
aw5       linen     1,.001,p3,p3 * .1
aw4       =         (aw6) * (aw5)
          outs      aw4, aw4
          endin




          instr  3
aw1       expon     p4,p5,.0001
aw2       rand      aw1
aw4       butterlp  aw2,500
aw3       reverb2   aw4,3,.2
aw6       reverb2   aw4,2.5,.25
aw5       =         (aw4) + (aw6)
aw7 	    	=         aw4 + aw3
          outs      aw5,aw7
          endin





          instr  4
kw3       expon     .1,p3,100
kw1       oscil     kw3,5,2
aw2       pluck     20000,p4,p4*2,1,1
kw2       =         (kw1) + (p4)
aw7       pluck     20000,kw2,p4*2,1,6
aw1       randh     p4/16,6.6666
aw3       =         (aw1) * (aw2)
aw9       line      5000,p3/2,200
aw4       =         (aw3) + (p4)
aw5       oscil     aw9,aw4,2
aw8       =         (aw5) + (aw7)
aw6       =         (aw5) + (aw7)
          outs      aw6,aw8
          endin



          instr  5
aw1       linen     p5,.05,p3,p3 - .05
aw2       oscili    aw1,cpspch(p4),2
aw3       oscili    aw1,cpspch(p4) - 4*(cpspch(p4)/100),2
aw4       =         (aw2) + (aw3)
          outs      aw4,aw4
gadly 	= 		gadly + aw4
          endin
	
          instr  6
aw3       randh     50,3.33333
aw5       randh     1000,6.66666,.2
aw6       =         (aw5) + (70)
aw4       =         (70) + (aw3)
kw1       randi     1000,3.33333
aw2       oscil     3000,aw4,3
aw1       oscil     3000,aw6,1
kw3       =         (200) + (kw1)
aw9       =         (aw2) + (aw1)
kw2       =         abs(kw3)
aenv1     linen     p4, p5, p3, p6
aw7       oscil     aenv1,aw9,2
aw8       butterlp  aw7,kw2
          outs      aw8,aw8
garev     =         garev + aw8   
          endin

          instr  7
aw2	  	linen	100,2.5,1,2.5


aw8       oscil     3 * (p4/100), .5, 4, .25

aenv1     linen     2500,1,p3,1
aenv2     linen     3000,1,p3,1
aw9       oscil     aenv1, .5, 4, .25
aw7       oscil     aenv2 + aw9, p4 + aw8, 3
aw1       butterlp 	aw7, 500
aw4 	    	oscil   	.5, .5, 4
aw3       =   		aw1 * (aw4 + .5)
aw5       =   		aw1 *  (1-(aw4 +.5))

          outs      aw3,aw5
garev     =         garev + (aw1 * .1)
          endin




          instr  8
aw2       linen     p5,.0001,p3,p3
aw1       oscili    aw2,cpspch(p4),1
		outs 	aw1, aw1
gadly2 	= 		gadly2 + aw1

          endin


	    	instr  97
aw3       multitap  gadly2,.3,.7,.6,.5,.9,.3,1.2,.1,1.5,.05,1.8,.01

          outs      aw3,aw3
gadly2	=		0
          endin







          instr 98

aw1       reverb2   garev,3,.5
aw2       reverb2   garev,3,.3
	    	outs      aw1,aw2
garev     =         0	
          endin

	    	instr 99
aw3       multitap  gadly,.3,.7,.6,.5,.9,.3,1.2,.1,1.5,.05,1.8,.01

          outs      aw3,aw3
gadly	=		0
          endin
