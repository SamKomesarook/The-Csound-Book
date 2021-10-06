;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;jpff@maths.bath.ac.uk
;****++++
;**** Last modified: Fri Feb 26 11:32:25 1999
;****----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	sr	=	44100
	kr	=	441
	ksmps	=	100
	nchnls	=	2

  ga1       init        0
;;; I N S T R U M E N T    1
;;; Write description here
;;; Keywords:

instr 1, 2, 3, 4, 5, 6
;; i1	when	dur	freq	amp	pan
  il        =           p6*p6                ;
  ir        =           1-p6*p6
  ipch      table       p4, 2                   ;convert parameter to cps
  ishft     gauss       ipch/50                 ; Shift by relative amount
                                                ; was gauss 10
  aenv      linseg      1, p3-.05, 1, .05, 0, .01, 0

  ag        wgpluck2    0.3, p5/3, (ipch), 0.3, 0.3
  agleft    repluck     0.35, p5/4, (ipch+ishft), 0.25, 0.25, ag
  agg       butterhp    agleft, 100
  agh       balance     agg, agleft
  all       =           2.95*agh*aenv
            outs        all*il, all*ir
  ga1       =           ga1+all
endin 

instr 7
;; INSTRUMENT 5 from beast
;; White noise at pitch with amplitude modifications
  ipch      table       p4, 2                   ;convert parameter to cps
  kband     line        195.094106, p3, 5
  kenv      linseg      7000, p3-.05, 7000, .05, 0, .01, 0
  a1        rand        kenv
  a2        butterbp    a1, ipch, kband
            outs        a2, a2
;  ga1       =           ga1+a2
endin

instr 8
if p3 < 0.2 goto sil
  ae        expseg     1,p3*0.7,1,p3*0.3,0.01
  a0        =           0
  a1        shaker      p4, 292.987041, 3, 0.99, 100, 0
            outs        ae*a1, a0
  ga1       =           ga1+a1
sil:
            
endin

instr 9
  idur      =           p3
  iamp2     =           p4*.4
  iamp4     =           p4*.15

  a5        randi       p4, 1500
  a5        oscili      a5, 1/idur, 5
  a5        oscili      a5, 4000, 1

  a3        oscili      iamp4, 1/idur, 5
  a3        oscili      a3, 33.1, 3

  a1        oscili      iamp2, 1/idur, 4
  a1        oscili      a1, 324.339228, 1

  all       =           a1+a3+a5
            outs        all, all
  ga1       =           ga1+all
endin

instr 10
if p3 < 0.2 goto sil
  ae        expseg     1,p3*0.7,1,p3*0.3,0.01
  a0        =           0
  a1        shaker      p4, 418.193370, 2, 0.99, 100, 0
            outs        a0, a1*ae
  ga1       =           ga1+a1
sil:
            
endin

instr 11
  p3        =           p3*5
  il        =           p6*p6                ;
  ir        =           1-p6*p6
  p5        =           p5*1.3
  ax,ay,az  lorenz      10, 28, 2.667, 0.01, 0.6, 0.6, 0.6, 1
  ipch      table       p4, 2                   ;convert parameter to cps
  kshft     gauss       ipch/50                 ; Shift by relative amount
  aamp      oscil       p5/1.5, 1/p3, 11
  al        oscil3      1, ipch, 1
  ar        oscil3      1, ipch+kshft, 1
  a2        oscil3      ax, ipch*2, 1
  a3        oscil3      ay, ipch*3, 1
  a5        oscil3      az, ipch*5, 1
  a2        balance     a2, al/9
  a3        balance     a3, al/25
  a5        balance     a5, al/49
  as        =           a2+a3+a5
  at        alpass      as, 0.25, 2
            outs        aamp*il*(at+as+al), aamp*ir*(ar+at+as)
  ga1       = ga1 + as + il + ir
endin

;;; I N S T R U M E N T    99
;;; Write description here
;;; Keywords: Reverberation

instr 99
	;; Description of Arguments: None
  a1        reverb2     0.1*ga1, 1, 0.9
            outs        a1,a1
  ga1       =           0
endin 
