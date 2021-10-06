
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
;        kday/imnth/1999      ;
;_____________________________;
;PERSISTENCE   IN   VARIATIONS;
;_____________________________;
;A W O R K I N P R O G R E S S;
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

asig      oscil     1,1,1
kslope    linseg    ival1, idur*.3, ival2, idur*.3, ival3, idur*.3, ival4
          outs      asig, asig
gkloud    =         kslope         
          endin           
      
;____________________________________________________________________
; GKAOS
; POSITIVE AND RANDOM
;____________________________________________________________________

          instr     2

asig      oscil     1,1,1
krndmout  randh     5, 13              
          outs      asig, asig                                                  
gkaos     =         2+abs(krndmout)
          endin          
          
;____________________________________________________________________
; GKLOUD
; RESET
;____________________________________________________________________
          instr     3
gkloud     =         1
          endin          
          
     
          
               
;____________________________________________________________________
;TIC      
;____________________________________________________________________
          instr     11
icloud    =         gkloud
iwide     =         0
ifreq     =         0
idur      =         p3
iamp      =         ampdb(p4)
ipris     =         .001 * icloud
ipdur     =         .001 * (2*icloud)
ipdcy     =         .007 * icloud
ibw       =         1000 + iwide
icf       =         2000 + ifreq
ifm       =         1000*p5
ipoltog   =         p6
ipoldiv   =         idur/p7
iprp      =         p8
ipitch    =         icf * .05
igk		=		p9

     
kpop      linseg    0, ipris, 1, ipdur, 1, ipdcy, 0
khum      linseg    0, .02, 1, idur*.5, 1, idur*.3, 0
abrst     rand      iamp*kpop
adly      delay     abrst, .036 * icloud
apre      comb      abrst, .01 * icloud, .018 * icloud
atic      comb      adly * 8, .05 * icloud, .02 * icloud
krndm	randh	5, 3
ana       foscil    ifm*khum, ipitch + krndm, 1, gkaos*igk, 1, 1
afm		butterlp	ana, icloud*200
abtr      butterbp  atic+apre, icf, ibw
apolly    alpass    abtr*ipoltog, 4*idur, ipoldiv                     
aleft	=         (abtr+apolly+afm)*iprp  
aright	=         (abtr+apolly+afm)*(1-iprp)
          outs      aleft, aright

gaticl    =         aleft
gaticr    =         aright
          endin          

;____________________________________________________________________
;TOC      
;____________________________________________________________________
          instr     12
icloud    =         gkloud
iwide     =         0
ifreq     =         0
idur      =         p3
iamp      =         ampdb(p4)
ipris     =         .001 * icloud
ipdur     =         .001 * (2*icloud)
ipdcy     =         .005 * icloud
ibw       =         750  + iwide
icf       =         2000 + ifreq
ifm       =         1000*p5
ipoltog   =         p6
ipoldiv   =         idur/p7
iprp      =         p8
ipitch    =         icf * .05
igk		=		p9

kpop      linseg    0, ipris, 1, ipdur, 1, ipdcy, 0
khum      linseg    0, .02, 1, idur*.5, 1, idur*.3, 0
abrst     rand      (iamp*kpop)
adly      delay     abrst*2, .036*icloud
adly2     delay     abrst, .036*icloud
apre      comb      abrst, .01*icloud, .018*icloud
atc1      comb      adly*5, .05*icloud, .02*icloud
atc2      comb      adly2*5, .05*icloud, .02*icloud
krndm	randh	5, 3
ana       foscil    ifm*khum, ipitch + krndm, 1, gkaos*igk, 1, 1
afm		butterlp	ana, icloud*200
atoc      =         atc1+atc2
abtr      butterbp  atoc+apre, icf, ibw
apolly    alpass    abtr*ipoltog, 4*idur, ipoldiv 
aleft	=         (abtr+apolly+afm)*iprp  
aright	=         (abtr+apolly+afm)*(1-iprp)
          outs      aleft, aright

gatocl    =         aleft
gatocr    =         aright
          endin
;____________________________________________________________________
;RUMBLE
;____________________________________________________________________

          instr     13
idur      =         p3
iamp      =         ampdb(p4)
ikloud    =         p5
ikaos     =         p6


kenv      linseg    0, idur*.3, 1, idur*.5, 1, idur*.1, 0
kvibe     oscil     1, .05, 1
armbl     buzz      iamp*kenv, (55+kvibe)+gkaos, (gkloud*ikloud)+(gkaos*ikaos), 1       
armbr     buzz      iamp*kenv, (55-kvibe)-gkaos, (gkloud*ikloud)+(gkaos*ikaos), 1       
alow      oscil     iamp*kenv, 55, 1         
          outs      armbl+alow, armbr+alow
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
