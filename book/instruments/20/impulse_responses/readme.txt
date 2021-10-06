The soundfiles contained here are all impulse responses of various csound ugen�s
and the two example filters in the signal processing chapter. They can be used
with the ugen convolve to experiment with the convolution sum. In most cases the
files are much longer than is necessary for convolution and should be edited
before use. They are all 8192 samples long so that they may be FFT'd to evaluate
the frequency response.

In most cases the one number or two numbers correspond to the divisor of the
sampling rate in the original ugen, e.g., "reson 100 10.aiff" was evaluated for
"ar  reson  asig, sr/100, sr/10".

In my version of csound areson did not work properly. Use the areson�s with care.

The files are:
alpass_0.05_100/sr.aif
areson_100_10.aif
areson_100_100.aif
areson_100_1000.aif
areson_100_20.aif
areson_100_200.aif
areson_100_2000.aif
areson_100_50.aif
areson_100_500.aif
areson_100_5000.aif
atone_100.aif
butterbp_100_10.aif
butterbp_100_100.aif
butterbp_100_1000.aif
butterbp_100_20.aif
butterbp_100_200.aif
butterbp_100_2000.aif
butterbp_100_50.aif
butterbp_100_500.aif
butterbp_100_5000.aif
butterbr_100_10.aif
butterbr_100_100.aif
butterbr_100_1000.aif
butterbr_100_20.aif
butterbr_100_200.aif
butterbr_100_2000.aif
butterbr_100_50.aif
butterbr_100_500.aif
butterbr_100_5000.aif
butterhp_100.aif
butterlp_100.aif
comb_0.05_100/sr.aif
FIR_Example.aif
IIR_Example.aif
reson_100_10.aif
reson_100_100.aif
reson_100_1000.aif
reson_100_20.aif
reson_100_200.aif
reson_100_2000.aif
reson_100_50.aif
reson_100_500.aif
reson_100_5000.aif
reverb_0.05_100/sr.aif
tone_100.aif
