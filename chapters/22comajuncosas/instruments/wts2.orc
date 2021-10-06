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
if krow >= gisize + 2 goto end
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

; map the orbit through the surface
; table indexes

kfnup     = int(1+ky*gisize) + gifn0
kfndown   = int(ky*gisize)   + gifn0
kndxleft  = int(kx*gisize)
kndxright = int(1+kx*gisize)

;igoto end; I needed it before, don´t know why !

;table read

azuplf   tablera kfnup,   kndxleft,  0
azdownlf tablera kfndown, kndxleft,  0
azuprg   tablera kfnup,   kndxright, 0
azdownrg tablera kfndown, kndxright, 0

;2D linear interpolation

ax upsamp frac(kx*gisize)
ay upsamp frac(ky*gisize)

az = (1-ax)*ay*azuplf+(1-ax)*(1-ay)*azdownlf+ax*ay*azuprg+ax*(1-ay)*azdownrg

;final output & endin

out 2*iamp*az

end:
endin
