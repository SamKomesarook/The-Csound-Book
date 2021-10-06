sr = 44100
kr = 44100
ksmps = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1; Surface generator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p3 = .01
gisize = 256;number and size of the tables
gifn0 = 301
krow init 0

; fill isize tables of size isize to create the surface
loop:
iftnum = gifn0+i(krow)
iafno ftgen iftnum, 0, gisize+1 , 9, 1, 1, 90*iftnum/gisize

krow = krow + 1
if krow >= gisize + 2 goto end
reinit loop

end:
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2; Orbit & waveform generator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inote = p4
iamp  = 20000

; set a spiral of kradius to index the surface

kradius linseg .05, p3/2, .5, p3/2, .05
kx oscili kradius, inote, 1; sine
ky oscili kradius, inote, 2, 1/4; cosine

; map the orbit through the surface
; table indexes

kfndown  = int(ky*gisize) + gifn0
kfnup    = int(1+ky*gisize) + gifn0
kndx     = kx; normalized 0 to 1

igoto end

;table read

azdown tableikt kndx,kfndown, 1, .5, 1
azup   tableikt kndx,kfnup,   1, .5, 1


;linear interpolation

ay upsamp frac(ky*gisize)
az = (1-ay)*azdown + ay*azup

;final output & endin
;out iamp*az
out iamp*azdown

end:
endin
