sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



          instr     1705    
iamp1     =         p4                  ; INITIALIZATION BLOCK:
iamp2     =         p4*1.5              ; FINE AMP ADJUSTMENTS
iamp3     =         p4*.5   
idur1     =         p3*p9               ; PORTION OF p3 FOR PT 1
idur2     =         p3*p10              ; PORTION OF p3 FOR PT 2
idur3     =         p3-idur2-idur1      ; THE REST TO PART 3
icps1a    =         cpspch(p5)  
icps1b    =         icps1a*2     
icps3     =         cpspch(p6)  
iwave1    =         1                   ; OSC WAVESHAPE FOR PT 1
iwave3    =         2                   ; OSC WAVESHAPE FOR PT 3
ihamm     =         3                   ; HAMMING FUNC FOR LFO
ipanfn    =         p14                 ; PAN CONTROL FUNC (0-1)
iseed1    =         p7   
iseed2    =         p8   
imindur   =         p11                 ; MIN NOTE LEN FOR PART2
imaxnum   =         p12                 ; MAX GAP FACTOR (>= 1)
ioctrng   =         p13                 ; RANDOM PITCH RANGE
itime     =         0                   ; TIME COUNTER FOR PT 2
ilast     =         0                   ; LAST NOTE FLAG FOR PT 2
kpan      oscil1i   0, 1, p3, ipanfn    ; OVERALL PAN CONTROL FOR...
kleft     =         sqrt(kpan)          ; ... PHRASE
kright    =         sqrt(1-kpan)     
part1:                                  ; CRESCENDO TO PART 2
          timout    idur1, p3, part2    ; WAIT idur1 SECONDS
kenv1     expseg    1, idur1, iamp1, 1, i amp1
klfo1     oscil     1, 7, ihamm 
kgate     randi     .5, 5               ; OUTPUT BETWEEN +/- .5
kgate     =         .5+kgate            ; OFFSET TO BETWEEN 0 - 1
asiga     oscili    kgate, icps1a, iwave1
asigb     oscili    1-kgate, icps1b, iwave1
asig1     =         (asiga+asigb)*kenv1*klfo1   
          outs      asig1*kleft, asig1*kright
          kgoto     end 
part2:                                  ; RANDOM SERIES OF POPS
          timout    idur2, p3, part3    ; WAIT FOR idur2 SECONDS
krndur    rand      .5, iseed1          ; OUTPUT BETWEEN +/- .5
krndhz    rand      .5, iseed2          ; COMPUTE NEXT DURATION
reset:                                  ; BETWEEN 0 AND imaxnum
irndur    =         (.5+i(krndur))*imaxnum   ; MAKE DUR = imindur*N ...
idur      =         imindur+imindur*int(irndur+.5)
          if        (itime+idur<idur2) igoto choose ; ... UNTIL LAST NOTE, CHOOSE
ilast     =         1                   ; LAST NOTE - SET FLAG
idur      =         idur2-itime         ; TRIM DURATION TO FIT
ipitch    =         octpch(p6)          ; USE PART 3 PITCH, SO...
          igoto     continue            ; SKIP RANDOM SELECTION
choose:                                 ; SELECT A RANDOM PITCH
irndoct   =         i(krndhz)*ioctrng   ; BETWEEN +/- ioctrng/2
ipitch    =         octpch(p5)+irndoct  ; AROUND PITCH OF PART 1
continue:
itime     =         itime+idur          ; KEEP TRACK OF TIME
icf       =         cpsoct(ipitch)/2    ; FILTER SETTINGS
ibwmin    =         icf/20  
ibwvar    =         icf*4   
kenv2     expseg    .01, .005, 1, idur-.005, .001
          timout    0, idur, skip       ; SKIP FOR idur SECONDS
          reinit    reset               ; THEN REINIT FROM RESET
skip:
anoise    rand      iamp2
apitch    oscili    iamp2/2, cpsoct(ipitch+kenv2*.25), iwave1
afilt1    butterbp  anoise+apitch, icf, ibwmin+kenv2*ibwvar
afilt2    butterbp  afilt1, icf, ibwmin+kenv2*ibwvar
          rireturn                      ; END REINIT PASS HERE
asig2     =         afilt2*kenv2        ; APPLY AMP ENVELOPE
          outs      asig2*kleft, asig2*kright
          if        (ilast!=1) kgoto end; GOTO END TIL LAST NOTE
part3:              ;diminuendo and ritard.
kenv3     line      1, idur3, 0         ; LINEAR DECAY FOR AMP
klfohz    expon     20, idur3, 1        ; EXP DECAY FOR LFO RATE
klfo3     oscil     1, klfohz, ihamm    ; HAMMING WINDOW FOR LFO
asig3     oscili    kenv3*iamp3, icps3, iwave3
          outs      asig3*kleft*klfo3, asig3*kright*(1-klfo3)
end:
          endin
