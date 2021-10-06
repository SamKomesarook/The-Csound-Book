sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr 705       
idur    =       abs(p3)             ; MAIN INIT BLOCK
ipch1   =       cpspch(p6)  
ipch2   =       cpspch(p5)  
kpch    =       ipch2   
iport   =       0.02                ; TIGHT PITCH
iatt    =       0.02                ; AND AMPLITUDE RAMPS
idec    =       p10                 ; GET DECAY FROM SCORE
irise   =       idur*p9             ; SET SWELL PEAK POSITION
                                    ; ... (ifall SET LATER)
idovib  =       1                   ; ASSUME WE USE VIBRATO
icut    =       (p5 > 9.01 ? 4000 : 2500)   ; TRIM HIGHEST PARTIALS
                                    ; ASSUME THIS IS A TIED NOTE
iamp    =       p4                  ; TIED NOTE STARTS AT SCORE AMP
i1      =       -1                  ; PHASE FOR TIED NOTE
i2      =       -1                  ; PHASE FOR VIBRATO
        ir      tival               ; TIED NOTE?    ;CONDITIONAL INIT BLOCK
        tigoto  tie 
i1      =       0                   ; FIRST NOTE, RESET PHASE
i2      =       0.25                ; COSINE PHASE FOR VIBRATO
iamp    =       0                   ; SET START AMP
iatt    =       0.08                ; STRETCH ATTACK IF FIRST NOTE
tie:            
iadjust =       iatt+idec           ; LONG NOTE, WE'RE SAFE
        if      idur >= iadjust igoto doamp ; ADJUST RAMP DURATIONS FOR
iatt    =       (idur/2)-0.005      ; ... SHORT NOTES, 10msec LIMIT
idec    =       iatt                ; CAN'T HAVE ZERO TIMESPAN
iadjust =       idur-0.01           ; (ENSURE ilen != 0 FOR LINSEG)
idovib  =       0                   ; NO VIBRATO ON SHORT NOTES
iport   =       0.005               ; EVEN TIGHTER PITCH RAMP
doamp:          
ilen    =       idur-iadjust        ; MAKE AMPLITUDE RAMP
amp     linseg  iamp, iatt, p4, ilen, p4, idec, p7
                                    ; ADD CHIFF ON FIRST NOTE
        if      ir == 1 goto pitch  ; NO CHIFF ON TIED NOTES
ichiff  =       p4/10               ; MATCH CHIFF TO VOLUME OF NOTE
                                    ; BALANCE CHIFFS WITH REGISTER
ifac1   =       (p5 > 9.01 ? 3.0 : 1.)  ; (AVOID DIVISION AT AUDIO...
ifac2   =       (p5 > 9.01 ? 0.1 : 0.2) ; ...RATES)
aramp   linseg  0, 0.005, ichiff, 0.02, ichiff*0.5, 0.05, 0, 0, 0
anoise  rand    aramp   
achiff1 reson   anoise, 3000, 500, 1, 1 ; 2 FILTERS FOR FIXED hf CHIFF,
achiff2 reson   anoise, 6000, 1000, 1, 1 ; ... WITH RESCALING
achiff3 reson   anoise,ipch2*2, 20, 0, 1 ; ONE FILTER FOR PITCHED CHIFF,
achiff  =       (achiff1+achiff2)*ifac1+(achiff3*ifac2)
pitch:                              ; MAKE PITCH RAMP
        if      ir == 0 || p6 == p5 kgoto expr  ; SKIP ptchramp GEN IF 1st NOTE OR TIE
kpramp  linseg  ipch1, iport, ipch2, idur-iport, ipch2
kpch    =       kpramp  
expr:                               ; MAKE EXPRESSION ENVELOPE
; p8 SETS PEAK OF EXPRESSION POINT, p9 MOVES IT IF p9==0 (ILLEGAL FOR LINSEG)
irise   =       (p9>0.?irise:iatt)  ; SET MAXIMUM ACCENT SHAPE
ifall   =       idur-irise  
; MAKE SURE A NEG p8 DOES NOT TAKE AMP BELOW ZERO
p8      =       ((p8+p4)>0.?p8:-p4) 
aslur   linseg  0, irise, p8, ifall, 0  ; MAKE VIBRATO
        if      idovib == 0 goto play   ; SKIP VIBRATO IF SHORT NOTE
avib    oscili  0.5, 4.5, 2, 0.25   ; MED SPEED, ASSUME SINE f2
avib    =       avib+0.5    
aslur   =       aslur*avib  
play:                               ; MAKE THE NOTE
aamp    =       amp+aslur   
aflute  oscili  aamp, kpch, 1, i1   ; TRIM PARTIALS OF HIGH
asig    butterlp aflute, icut, 1    ; ... NOTES, NO REINIT
        out     asig+achiff*0.25    ; FINAL SCALING OF CHIFF
        endin       
