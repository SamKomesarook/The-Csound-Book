;_____________________________;
;                             ;
;    S         P         A    ;
;         .         .         ;
;                             ;
;    C         E         T    ;
;                             ;
;         .         .         ;
;    I         M         E    ;
;                             ;
;           ORCHESTRA         ;
;        BRIANANAKINCASS      ;
;        aday/kmnth/1999      ;
;_____________________________;
;PERSISTENCE  IN    VARIATIONS;
;PERSPECTIVE  IN  	GRADATIONS;
;_____________________________;
;  http://listen.to/13rian	;
;						;
;  brianakin@earthlink.net	;
;_____________________________;


;____________________________________________________________________
; NOTE ----------------------------------------
; THIS KONTROL RATE = AUDIO RATE HEADER IS NEEDED WHEN USING
; MACINTOSH PERF VERSION 3.56 (10.17.99)
; I THINK THERE IS A LINSEG BUG.
; NORMALLY THIS PIECE WILL RUN
; SUCCESSFULLY WITH THE DEFAULT HEADER:
;sr       =         44100
;kr       =         4410
;ksmps    =         10
;nchnls   =         2
;____________________________________________________________________


sr        =         44100
kr        =         44100
ksmps     =         1
nchnls    =         2


gkloud    init      1
gkaos     init      1
gas		init		0
gaticl    init      0
gatocl    init      0
gaticr    init      0
gatocr    init      0


;____________________________________________________________________
; GKLOUD
; GLOBAL SLOPE
;____________________________________________________________________

          instr     1
idur      =         p3
ival1     =         p4
ival2     =         p5
ival3     =         p6        
ival4     =         p7

 
kslope    linseg    ival1, idur*.3, ival2, idur*.3, ival3, idur*.3, ival4       

gkloud    =         kslope
          endin           
      
;____________________________________________________________________
; GKAOS
; POSITIVE AND RANDOM
;____________________________________________________________________

          instr     2


krndm1    randh     5+gkloud, 1
krndmout  randh     9, abs(krndm1)               
gkaos     =         1+abs(krndmout)
          endin 
          
;____________________________________________________________________
; GAS
; GLOBAL PANNING WAVE
;____________________________________________________________________

          instr     3


idur      =         p3
ival1	=		p4
ival2	=		p5
ival3	=		p6
ival4	=		p7
iuptog    =		p8
idowntog	=		p9
iflat	=		p10


kup		linseg	0, idur*.5, 0.5, idur*.5, 0.5
kdown	linseg	0.5, idur*.3, 0.5, idur*.7, 0
kamp		=		(kup*iuptog) + (kdown*idowntog) + (iflat)
kslope    linseg    ival1, idur*.3, ival2, idur*.3, ival3, idur*.3, ival4
kchunk	randh	kslope*.005, p2*.3
koscil	oscil	kslope*.1, kslope*.05, 1
ars1		oscil	kamp, kslope+koscil+kchunk, 1
gas       =         ars1         
          endin  
                    

;____________________________________________________________________
; GAS 2
; GLOBAL PANNING SLOPE
;____________________________________________________________________

          instr     4
idur      =         p3
ival1	=		p4
ival2	=		p5
ival3	=		p6
ival4	=		p7
krs1		linseg	ival1, idur*.3, ival2, idur*.3, ival3, idur*.3, ival4
gas       =         krs1         
          endin 

;____________________________________________________________________
; GAS	RESET
; GLOBAL PANNING
;____________________________________________________________________

          instr     5         
gas       =         0        
          endin                     
                                  
;____________________________________________________________________
;TIC      
;____________________________________________________________________
          instr     11
ikloud    =         gkloud
ikaos	=		.1 * gkaos
idur      =         p3
iamp      =         ampdb(p4)
ipris     =         .001 * ikloud
ipdur     =         .001 * (7*ikloud)
ipdcy     =         .007 * ikloud
ibw       =         1000
icf       =         2000
ifm       =         4500*p5
ipoltog   =         p6
ipoldiv   =         idur/p7
iprp      =         .5
ipitch    =         110


     
kpop      linseg    0, ipris, 1, ipdur, 1, ipdcy, 0
khum      linseg    0, .02, 1, .8, 1, .18, 0
kbznv	linseg	0, .1, 1, .2, 0 

abrst     rand      iamp*kpop
adly      delay     abrst, .036 * ikloud
apre      comb      abrst, .01 * ikloud, .018 * ikloud
atic      comb      adly * 8, .05 * ikloud, .02 * ikloud
krndm	randh	110, ikloud
asound    buzz      ifm*kbznv, ipitch - (9*gkaos), gkaos, 1
ana		butterbp	asound, 880-krndm, krndm
alow		oscil	ifm*kbznv, ipitch + (9*gkaos), 1
afm		=		alow+ana
abtr      butterbp  atic+apre, icf, ibw
apass     alpass    abtr*ipoltog, 4*idur, ipoldiv
ares1     reson     apass, gkloud*52-gkaos, gkloud+gkaos
ares2     reson     apass, gkloud*48-gkaos, gkloud+gkaos  
ares		=		apass+ares1+ares2
apolly	butterlp	(ares* 0.02)*khum, 100+(4*p2)
kpan		=		iprp+gas	              
aright	=         (abtr+apolly+afm)*kpan  
aleft	=         (abtr+apolly+afm)*(1-kpan)
          outs      aleft, aright

           
          
gaticr    =		aright

gaticl    =         aleft
                 
		endin
;____________________________________________________________________
;TOC      
;____________________________________________________________________
          instr     12
ikloud    =         gkloud
ikaos	=		.1 * gkaos

idur      =         p3
iamp      =         ampdb(p4)
ipris     =         .001 * ikloud
ipdur     =         .001 * (7*ikloud)
ipdcy     =         .005 * ikloud
ibw       =         750
icf       =         2000
ifm       =         4500*p5
ipoltog   =         p6
ipoldiv   =         idur/p7
iprp      =         .5
ipitch    =         110


kpop      linseg    0, ipris, 1, ipdur, 1, ipdcy, 0
khum      linseg    0, .02, 1, .9, 1, .008, 0
kbznv	linseg	0, .1, 1, .2, 0 

abrst     rand      (iamp*kpop)
adly      delay     abrst*2, .036*ikloud
adly2     delay     abrst, .036*ikloud
apre      comb      abrst, .01*ikloud, .018*ikloud
atc1      comb      adly*5, .05*ikloud, .02*ikloud
atc2      comb      adly2*5, .05*ikloud, .02*ikloud
krndm	randh	110, ikloud
asound    buzz      ifm*kbznv, ipitch + (9*gkaos), gkaos, 1
ana		butterbp	asound, 880+krndm, krndm
alow		oscil	ifm*kbznv, ipitch - (9*gkaos), 1
afm		=		alow+ana
atoc      =         atc1+atc2
abtr      butterbp  atoc+apre, icf, ibw
apass     alpass    abtr*ipoltog, 4*idur, ipoldiv
ares1     reson     apass, gkloud*50+gkaos, gkloud+gkaos
ares2     reson     apass, gkloud*46+gkaos, gkloud+gkaos  
ares		=		apass+ares1+ares2
apolly	butterlp	(ares* 0.02)*khum, 100+(4*p2)	 
kpan		=		iprp+gas	              
aright	=         (abtr+apolly+afm)*(1-kpan)  
aleft	=         (abtr+apolly+afm)*kpan
          outs      aleft, aright

          
         
gatocr    =         aright

gatocl    =         aleft          
 		endin         
;____________________________________________________________________
;STEREOVERB
;____________________________________________________________________
          instr     98                            

irevfactor     =    p4                       
ilowpass   =        9000
ioutputscale =      p5
ioutputscale2=      p5*.3

idel1     =         1237.000/sr
idel2     =         1381.000/sr
idel3     =         1607.000/sr
idel4     =         1777.000/sr
idel5     =         1949.000/sr
idel6     =         2063.000/sr
idel7     =         307.000/sr
idel8     =         97.000/sr
idel9     =         71.000/sr
idel10    =         53.000/sr
idel11    =         47.000/sr
idel12    =         37.000/sr
idel13    =         31.000/sr

icsc1     =         .822 * irevfactor
icsc2     =         .802 * irevfactor
icsc3     =         .773 * irevfactor
icsc4     =         .753 * irevfactor
icsc5     =         .753 * irevfactor
icsc6     =         .753 * irevfactor

icsc7     =         .7 * irevfactor
asig      =         gaticl+gatocl                      
acomb1    comb      asig, icsc1, idel1
acomb2    comb      asig, icsc2, idel2
acomb3    comb      asig, icsc3, idel3
acomb4    comb      asig, icsc4, idel4
acomb5    comb      asig, icsc5, idel5
acomb6    comb      asig, icsc6, idel6

acomball  =         acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6

allp1     alpass    acomball, icsc7, idel7
allp2     alpass    allp1, icsc7, idel8
allp3     alpass    allp2, icsc7, idel9
alow      tone      allp3, ilowpass
allp4     alpass    alow, icsc7, idel10
allp5     alpass    allp4, icsc7, idel12
arevout   =         allp5 * ioutputscale
asplit    =         allp5 * ioutputscale2


          outs      asplit, arevout


     
gaticl    =         0
gatocl    =         0

          endin

          instr     99                            
                                   
irevfactor =        p4
ilowpass   =        9000
ioutputscale =      p5
ioutputscale2=      p5*.3
idel1     =         1237.000/sr
idel2     =         1381.000/sr
idel3     =         1607.000/sr
idel4     =         1777.000/sr
idel5     =         1949.000/sr
idel6     =         2063.000/sr
idel7     =         307.000/sr
idel8     =         97.000/sr
idel9     =         71.000/sr
idel10    =         53.000/sr
idel11    =         47.000/sr
idel12    =         37.000/sr
idel13    =         31.000/sr

icsc1     =         .822 * irevfactor
icsc2     =         .802 * irevfactor
icsc3     =         .773 * irevfactor
icsc4     =         .753 * irevfactor
icsc5     =         .753 * irevfactor
icsc6     =         .753 * irevfactor

icsc7     =         .7 * irevfactor
asig      =         gaticr+gatocr                      
acomb1    comb      asig, icsc1, idel1
acomb2    comb      asig, icsc2, idel2
acomb3    comb      asig, icsc3, idel3
acomb4    comb      asig, icsc4, idel4
acomb5    comb      asig, icsc5, idel5
acomb6    comb      asig, icsc6, idel6

acomball  =         acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6

allp1     alpass    acomball, icsc7, idel7
allp2     alpass    allp1, icsc7, idel8
allp3     alpass    allp2, icsc7, idel9
alow      tone      allp3, ilowpass
allp4     alpass    alow, icsc7, idel10
allp5     alpass    allp4, icsc7, idel12
arevout   =         allp5 * ioutputscale
asplit    =         allp5 * ioutputscale2
     


          outs      arevout, asplit


     
gaticr    =         0
gatocr    =         0

          endin          
