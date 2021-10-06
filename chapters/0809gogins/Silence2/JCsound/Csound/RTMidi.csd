<CsoundSynthesizer>
<CsOptions>
csound -odevaudio -s -h -+X1 -+K0 -b150 -B150 c:\RTMidi.orc c:\RTMidi.sco
</CsOptions>
<CsInstruments>
sr = 22050
kr = 441
ksmps = 50
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
f0 1000


</CsScore>
</CsoundSynthesizer>
