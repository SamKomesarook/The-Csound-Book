<CsoundSynthesizer>
<CsOptions>
csound -odevaudio -s -h -Fc:\Bach.mid -+X1 -b150 -B150 c:\Bach.orc c:\Bach.sco
</CsOptions>
<CsInstruments>
sr = 22050
kr = 147
ksmps = 150
nchnls = 2


garvbsigl init 0  
garvbsigr init 0


instr 1; pluckmidi.orc


iamp     ampmidi  32000, 6
inote    octmidi
icps     cpsmidi
ilfodel  = .2
ilfodepth = .005
ilfofunc = 1
ilfofreq = 2.000


kamp  linseg   0,.01,1,.5,1,4,0,.01,0   
kamp2 linenr   kamp*iamp, .01, .333, .05


timout 0, ilfodel, output
   klfoctl linenr 1,.05,.5,.01
   krndz randi .005,15
   klfo oscil klfoctl*ilfodepth+krndz,ilfofreq*klfoctl,ilfofunc
output:


   asig1 pluck kamp2, cpsoct(inote + klfo), icps, 0, 1
   asig2 pluck kamp2, cpsoct(inote + klfo - .0008), icps, 0, 1
   asig3 pluck kamp2, cpsoct(inote + klfo + .0008), icps, 0, 1
   
   asig4 pluck    kamp2, icps*3, icps*3, 0, 2,2
   
   aflt1 reson asig1 + asig2 + asig3, 110, 80
   aflt2 reson asig1 + asig2 + asig3, 220, 100
   aflt3 reson asig1 + asig2 + asig3, 440, 80


   amixl balance .5*aflt1 + aflt2 + 1.5*aflt3 + asig1 + asig2 + .5*asig4, asig1 
   amixr balance .5*aflt1 + aflt2 + 1.5*aflt3 + asig1 + asig3 + .5*asig4, asig1
   
      
   outs  amixl,amixr
endin




</CsInstruments>
<CsScore>
f1 0 1024 10 1                                                                                   ; Sine
f2 0 1024 10 1 .5 .3 .25 .2 .167 .14 .125 .111          ; Sawtooth
f3 0 1024 10 1 0  .3 0 .2 0 .14 0 .111                  ; Square
f4 0 1024 10 1 1 1 1 .7 .5 .3 .1                        ; Pulse
f5 0 1024 10 1 0 .111 0 .04 0 .02 0 .012                ; Triangle 
f6 0 128 5 1 128 8                                      ; for veloc to non-linear amp
f0 2000




</CsScore>
<CsMidifile>
<Size>
1621
</Size>
MThd      àMTrk  ? ÿfinal ÿT`     ÿX ÿQ
6 Cd >d :d 7dpC@p:@ 7@ Cd ?d :d 0dp>@ ?@ 0@ >d 2dpC@ :@ >@ 2@ Cd <d 9d 3dp9@ 7dpC@ <@ 3@ 7@ Bd >d 9d 2d`B@ >@ 9@ 2@ >d 9d 6d 0d`>@ 9@ 6@ 0@ Cd >d 7d .dp>@ @dpC@ 7@ .@ @@ Ed Bd <d -d`E@ B@ <@ -@ Fd Cd >d +d`F@ C@ >@ +@ Fd Cd >d 7d`F@ C@ >@ 7@ Hd Ed ?d 6d`H@ E@ ?@ 6@ Fd Cd >d 7d`F@ C@ >@ 7@ Ed Bd >d 2dHE@ B@ >@ 2@XEd Bd >d 2d`E@ B@ >@ 2@ Fd Cd >d 7d`F@ C@ >@ 7@ Hd Ed ?d <d`H@ E@ ?@ <@ Jd Fd Ad :dpJ@ A@ Hd ?dpF@ :@ H@ ?@ Fd Ad >d 8dp>@ <dpF@ A@ 8@ <@ Kd Cd :d 7dpC@ EdpK@ :@ 7@ E@ Kd Fd :d 6dp:@ <dpK@ F@ 6@ <@ Jd Fd >d 5dp>@ :dpJ@ F@ 5@ :@ Id Fd Cd 4dpI@ HdpF@ C@ 4@ H@ Hd Fd Ad 5d`F@ EdpA@ ?dpH@ 5@ E@ ?@ Fd Ad >d .dHF@ A@ >@ .@XFd Cd >d +dpC@ AdpF@ >@ +@ A@ Ed ?d <d 0dp?@ >dpE@ <@ 0@ >@ Cd @d :d 1d`C@ @@ :@ 1@ Ad >d 9d 2d`A@ >@ 9@ >d 9d 5dp2@ >@ ?d 0dp9@ 5@ ?@ 0@ Ad >d :d .dp>@ .@ ?d 0dpA@ :@ ?@ 0@ Ad Ad :d 2dp2@ .dpA@ A@ :@ .@ Cd Ad :d 3dpA@ ?dpC@ :@ 3@ ?@ Ad ?d 9d 5dp?@ >dpA@ 9@ 5@ >@ ?d >d :d 7dp>@ <dx<@ :dx:@ 7@ :@ <d 9d 5d`?@ <@ 9@ 5@ >d :d :d 5dH>@ :@ :@ 5@XJd Fd Ad :d`J@ F@ A@ :@ Hd Ed ?d 6d`H@ E@ ?@ Fd Cd >dp6@ F@ Ed 7dpC@ >@ E@ 7@ Ed Cd @d 1d`C@ @@ 1@ Bd >d 2dp>@ <dpE@ B@ 2@ <@ Cd >d ;d +d C@ >@ ;@ +@ ÿ/ </CsMidifile>
</CsoundSynthesizer>
