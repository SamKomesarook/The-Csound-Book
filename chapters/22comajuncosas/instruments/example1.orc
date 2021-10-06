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

iafno ftgen 3, 0, gisize+1 , 9, 1, 1, 270
loop:
irow = i(krow)
imult tablei irow, 3
iftnum = gifn0+i(krow)
iafno ftgen iftnum, 0, gisize+1 , 11, 30, 1, imult*1.15

krow = krow + 1
if krow >= gisize + 2 goto end
reinit loop

end:
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2; Orbit & waveform generator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inote = cpspch(p4)
iamp  = 10000
ixcenter = p5
iycenter = p6

; set a spiral of kradius and center (p5,p6) to index the surface

kamp linen 1, p3/3, p3, p3/3
kradius oscil .3, .2, 2

kx oscili kradius, inote*.999, 1; sine
ky oscili kradius, inote*1.001, 2, 1/4; cosine

ky = ky+(1-2*kradius)/2+ (iycenter-.5)

; map the orbit through the surface
; table indexes

kfndown  = int(ky*gisize) + gifn0 
kfnup    = int(1+ky*gisize) + gifn0
kndx     = kx; normalized 0 to 1

igoto end

;table read

azdown tableikt kndx,kfndown, 1, ixcenter, 1
azup   tableikt kndx,kfnup,   1, ixcenter, 1


;linear interpolation

ay upsamp frac(ky*gisize)

az = (1-ay)*azdown + ay*azup

;final output & endin
out iamp*az*kamp

end:
endin
