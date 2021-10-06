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
iafno ftgen iftnum, 0, gisize , 3, 0, 1, 0, 1; y=x

krow = krow + 1
if krow >= gisize + 2 goto end; 2 extra tables...
reinit loop

end:
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2; Orbit & waveform generator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inote = p4
iamp  = 20000

; set a circular orbit to index the surface

kx oscili .5, inote, 1; sine
ky oscili .5, inote, 1, 1/4; cosine

; notice the orbit is centered at (.5,.5)
; also, the final amplitude must be multiplied by 2

; map the orbit through the surface
; table indexes

kfn   = int(ky*gisize)   + gifn0
kndx  = int(kx*gisize)

;igoto end

;table read

az tablera kfn, kndx,  0

;final output & endin

out 2*iamp*az

end:
endin
