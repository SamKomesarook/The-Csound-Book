sr = 44100
kr = 44100
;sr = 11025
;kr = 11025
ksmps = 1
zakinit 1,2050;you will need 1 za location and 3*ginum_ham zk locations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ****** THERE IS LIFE IN THE ZAK SPACE ******
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a Cellular Automata Orchestra
; coded by Josep M Comajuncosas / oct-nov.´98
; FULL COMMENTED CODE in instr 1 to 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 1; instr´s 1&2&3? ; a k=4/r=1 one-dimensional C.A. driving
; a bank of oscillators

; number of cells in a row (matches the number of oscillators in instr 8)
p3 = 1/kr
ginum_harm = p4; number of oscillators and cells. Must be a power of 2.
gkzoff0 init ginum_harm;first row
gkzoff1 init 2*ginum_harm;second row

iftn1	ftgen	2,0,ginum_harm+1, -3, 0, ginum_harm, 0, 1
	
kzkndx init 0

; init cell states (for this automata, only values 0 to 3)
init_cells:
kcell_state table kzkndx,p5,0;don´t use tablei !
;we need integer values for this automata

zkw kcell_state,kzkndx+(gkzoff0)

; init oscilator phases
kphase table kzkndx,p6,0
zkw abs(kphase),kzkndx; quick mapping from (-1,1) to (0,1)

kzkndx = kzkndx + 1
if kzkndx < ginum_harm kgoto init_cells

turnoff; quit after cell initialisation
endin

instr 2
; evaluate the automata
; every icell_period seconds
kzkndx init 0
icell_period = p4; time delay beetween automata states
; induces a strong component to the mix.
;gktimer phasor 1/icell_period; necessary to interpolate bt. cells

reset: 
timout 0,icell_period,end

loop2:            	
;cell to evaluate
kprev_state zkr kzkndx+gkzoff0

; neighbour´s states
; (with wraparound for periodic contorn conditions)
; (I add ginum_harm to avoid negative indexes when dealing with cells on the left)
;kprev_state_left  zkr gkzoff0+ginum_harm*frac((ginum_harm+kzkndx-1)/ginum_harm)
;kprev_state_right zkr gkzoff0+ginum_harm*frac((ginum_harm+kzkndx+1)/ginum_harm)
kleft  table ginum_harm+kzkndx-1,2,0,0,1
kright table ginum_harm+kzkndx+1,2,0,0,1
kprev_state_left  zkr kleft +gkzoff0
kprev_state_right zkr kright+gkzoff0


;add all the cell states
ksum = kprev_state + kprev_state_left + kprev_state_right


;table lookup for transition rule
knext_state table ksum,p5,0

;write next cell states to zk space (the other row)
zkw knext_state, kzkndx + gkzoff1
kzkndx = kzkndx + 1
if kzkndx < ginum_harm goto loop2
kzkndx = 0

; swap row pointers for the next pass
; prev values -> row to fill (zkw doesn´t mix)
; next values -> actual values
;gkzoff0 = (gkzoff0 == ginum_harm? 2*ginum_harm:ginum_harm)
;gkzoff1 = (gkzoff1 == ginum_harm? 2*ginum_harm:ginum_harm)
; a better way to do it
ktemp   = gkzoff0
gkzoff0 = gkzoff1
gkzoff1 = ktemp

;reinit timout statement
reinit reset
end:

endin


instr 3; instr´s 1&2&3 ; a k=4/r=1 one-dimensional C.A. driving
; the amplitude tracks of a bank of oscillators
kzkndx init 0

imap_mode = p6
imin_freq = p5; lowest freq. in the oscillator bank
istr =  p7; stretcht factor for frequencies
imax_amp = p4;maximum expected output amplitude
; amplitude also depends on cell values! (here max. = 9)
;kphasor phasor imin_freq


;set oscillator bank parameters from automata cell states
osc_bank:
kindex zkr kzkndx
aosc tablei kindex,1,1,0,1; wraparound for phases > 1

;frequency mapping : choose one of these...
if imap_mode == 1 goto additive
if imap_mode == 2 goto geometric
if imap_mode == 3 goto exponential

additive:
kfactor = (kzkndx+1)*istr
; if istr = 1 you have an harmonic series
; near 1 gives a chorus effect
goto next

geometric:
kfactor pow kzkndx+1,istr
; if istr = 1 you also have an harmonic series
goto next

exponential:
kfactor pow istr, kzkndx
; if istr =  1.059463094359 you have a 12ET -dodecaphonic- mapping)
; if istr =  1.029302236643 you have a 24ET -quarter tone- mapping)
; if istr =  1.122462048309 you have a  6ET - whole tone - mapping)
; 	in general:1/nth(6,12,24,...) root of x(=2 octave, =2/3 fifth...)
;	to divide x into n equal parts
goto next

next:
kphase = kfactor * imin_freq/kr
;kphase = (kzkndx+1)*imin_freq/kr;kindex + istr*(1/istr+kzkndx-1)*imin_freq/kr
;zkwm frac(kphase),kzkndx; never clear this as phases are always adding
; this caused a crash when the phase whas too big
; to fix it I got the frational part fist, and added it manually without zkwm
kprev_phase zkr kzkndx
zkw frac(kphase+kprev_phase),kzkndx
; with this fix you can run your CA forever ;-)

; interpolate amplitude from prev. and next cell states
; doesn´t work very well
kprev_state zkr kzkndx+gkzoff0
;knext_state zkr kzkndx+gkzoff1
kweigth = kprev_state*kprev_state;*kprev_state;*(1-gktimer) + knext_state*gktimer

; mix each phase value
; (balanced with the current cell state) to the pool:
zawm aosc*kweigth,0

kzkndx = kzkndx + 1

if kzkndx < ginum_harm goto osc_bank
kzkndx = 0

out:
aout zar 0
out aout*imax_amp/(9*ginum_harm)
zacl 0,0

endin


instr 4; instr´s 4&5&6? ; a k=float/r=1 one-dimensional C.A. driving
; a bank of oscillators

p3 = 1/kr
ginum_harm = p4
gkzoff0 init ginum_harm
gkzoff1 init 2*ginum_harm

iftn1	ftgen	2,0,ginum_harm+1, -3, 0, ginum_harm, 0, 1
	
kzkndx init 0

init_cells:
kcell_state table kzkndx/ginum_harm,p5,1
zkw kcell_state,kzkndx+(gkzoff0)

kphase tablei kzkndx/ginum_harm,p6,1

kzkndx = kzkndx + 1
if kzkndx < ginum_harm kgoto init_cells

turnoff
endin

instr 5
kzkndx init 0
icell_period = p4; time delay beetween automata states
;gktimer phasor 1/icell_period; necessary to interpolate bt. cells

reset: 
timout 0,icell_period,end

loop2:            	
kprev_state zkr kzkndx+gkzoff0

kleft  table ginum_harm+kzkndx-1,2,0,0,1
kright table ginum_harm+kzkndx+1,2,0,0,1
kprev_state_left  zkr kleft +gkzoff0
kprev_state_right zkr kright+gkzoff0

ksum = kprev_state + kprev_state_left + kprev_state_right
knext_state tablei ksum/3,p5,1

zkw knext_state, kzkndx + gkzoff1
kzkndx = kzkndx + 1
if kzkndx < ginum_harm goto loop2
kzkndx = 0

ktemp   = gkzoff0
gkzoff0 = gkzoff1
gkzoff1 = ktemp

reinit reset
end:

endin


instr 6
kzkndx init 0

imap_mode = p6
imin_freq = p5
istr =  p7
imax_amp = p4
;kphasor phasor imin_freq

osc_bank:
kindex zkr kzkndx
aosc tablei kindex,1,1,0,1

if imap_mode == 1 goto additive
if imap_mode == 2 goto geometric
if imap_mode == 3 goto exponential

additive:
kfactor = (kzkndx+1)*istr
goto next

geometric:
kfactor pow kzkndx+1,istr
goto next

exponential:
kfactor pow istr, kzkndx
goto next

next:
kphase = kfactor * imin_freq/kr
kprev_phase zkr kzkndx
zkw frac(kphase+kprev_phase),kzkndx

; interpolate amplitude from prev. and next cell states
; doesn´t work very well
kprev_state zkr kzkndx+gkzoff0
;knext_state zkr kzkndx+gkzoff1
kweigth = kprev_state*kprev_state;*kprev_state;*(1-gktimer) + knext_state*gktimer

zawm aosc*kweigth,0

kzkndx = kzkndx + 1

if kzkndx < ginum_harm goto osc_bank
kzkndx = 0

out:
aout zar 0
out aout*imax_amp/(3*ginum_harm)
zacl 0,0

endin

































