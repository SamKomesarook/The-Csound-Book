;Csound Score Games Pat Pagano 2001

f01 0 16 -2 1 1.0625 1.125 1.16 1.25 1.291 1.33 1.4 1.5 1.53 1.555 1.571 1.714 1.75 1.9285 1.9375 1.96875
f03 0 16 -2 1 1.333 1.5 1.75 ; 1 4 5 m7
f04 0 16 -2 1 1.053 1.0666 1.1111 1.125 1.185 1.2 1.25 1.265 1.3333 1.35 1.406 1.4222 1.5 1.580 1.6 1.666 1.6875 1.7777 1.8 1.875 1.898 ;hindu 22 srtuti #1
f05 0 16 -2 1 1.0760136 1.1274441 1.2131453 1.2711308 1.3677542 1.4331289 1.5016289 1.6157734 1.6930027 1.8217136 1.9087667 ; MOS
f02 0 8193 10 1 ; Sine
;table # start  size    gen fn   C          C#         D          Eb etc.
f 45      0      16      -2       1.000000   1.062500   1.10677   1.11953125
;E            f       f#       G       Ab       A       Bb
1.275   1.3447265   1.416   1.4875   1.59375   1.7   1.7708333
;  B
1.859375
t 0 2

f6 0 2048 7 0   1024   1   0   -1   1024   0;    GEN7 Sawtooth Wave
f7 0 2048 10 1   0    .3    0   .2    0     .14   0   .111;    GEN10 Square Wave
f8 0 2048 10 1   1    1     1   .7    .5    .3    .1;    GEN10 Pulse Wave
f9 0 2048 19 .5  1  270  1;    GEN19 Sigmoid Rise

i1      0.1038      1.0000      27.69      30.00
i1      8.8101      1.0000      25.35      30.00
i1      9.8364      1.0000      22.05      30.00
i1     1.2202      1.0000      62.86      30.00
i1      0.1153      1.0000      44.82      33.67
i1      8.8101      1.0000      25.35      33.67
i1      9.8364      1.0000      21.44      33.67
i1     1.0126      1.0148     160.01      33.67
i1      0.1153      1.0000      44.82      37.80
i1      8.8101      1.0000      25.35      37.80
i1      9.8364      2.1910      21.44      37.80
i1      0.1153      1.0000      44.82      42.43
i1      9.2252      1.0000      22.10      42.43
i1     10.4591      1.1993     116.11      42.43
i1      0.1268      1.0000      60.19      47.62
i1      8.8101      1.0000      34.37      47.62
i1      9.8364      1.6721      53.76      47.62
i1      0.1268      1.0000      60.19      53.45
i1      8.8101      1.0000      43.07      53.45
i1      9.8364      1.6721      82.44      53.45
i1      0.1268      1.0000      60.19      60.00
i1      6.7921      1.0000      32.67      60.00
i1      8.8101      1.0000     109.45      60.00
i1      9.8364      1.2685     142.81      60.00
i1      0.1384      1.0000      66.59      67.35
i1      6.7921      1.0000      32.67      67.35
i1      8.8101      1.0000     109.45      67.35
i1      9.8364      1.2685     142.81      67.35
i1      0.1384      1.0000      66.59      75.60
i1      6.7805      1.0000      32.22      75.60
i1      8.8101      1.0000     109.45      75.60
i1      9.8364      1.0724     142.81      75.60
i1      0.1384      1.0000      66.59      84.85
i1      6.7690      1.0000      31.40      84.85
i1      8.8101      1.0000     109.45      84.85
i1      9.8364      1.0000     142.81      84.85
i1      0.1499      1.0000      62.67      95.24
i1      6.7575      1.0000      29.99      95.24
i1      8.8101      1.0000      81.49      95.24
i1      9.8364      1.0000      78.16      95.24
i1      0.1499      1.0000      62.67     106.91
i1      6.7459      1.0000      34.46     106.91
i1      8.8101      1.0000      26.54     106.91
i1      9.8364      1.0000      78.16     106.91
i1      0.1499      1.0000      62.67     120.00
i1      6.7459      1.0000      34.46     120.00
i1      8.8101      1.0000     105.45     120.00
i1      9.8364      1.0000      69.36     120.00
i1      0.1614      1.0000      51.51     134.70
i1      6.7344      1.0000      38.67     134.70
i1      8.8101      1.0000     105.45     134.70
i1      9.8364      1.0000      69.36     134.70
i1      0.1614      1.0000      51.51     151.19
i1      6.7229      1.0000      41.49     151.19
i1      8.8101      1.0000     105.45     151.19
i1      0.1614      1.0000      51.51     169.71
i1      6.7113      1.0000      42.66     169.71
i1      9.2137      1.0000      55.53     169.71
i1      0.1730      1.0000      38.54     190.49
i1      6.6998      1.0000      42.08     190.49
i1      9.2137      1.0000     109.25     190.49
i1      0.1730      1.0000      38.54     213.82
i1      6.6883      1.0000      40.34     213.82
i1      9.2137      1.0000     109.25     213.82
i1      0.1730      1.0000      38.54     240.00
i1      6.6767      1.0000      38.12     240.00
i1      9.2137      1.0000     109.25     240.00
i1      0.1845      1.0000      30.40     269.39
i1      6.6652      1.0000      34.79     269.39
i1      9.2137      1.0000      76.46     269.39
i1      0.1845      1.0000      30.40     302.38
i1      6.6537      1.0000      33.24     302.38
i1      9.2137      1.0000      76.46     302.38
i1      0.1845      1.0000      30.40     339.41
i1      2.0641      1.0000      72.56     339.41
i1      6.6537      1.0000      33.24     339.41
i1      9.2137      1.0000      24.01     339.41
i1      0.1960      1.0000      29.52     380.98
i1      2.0641      1.0000      72.56     380.98
i1      5.2122      1.0000      11.63     380.98
i1      6.6422      1.0000      11.64     380.98
i1      8.8216      1.0000      25.12     380.98
i1      0.1960      1.0000      29.52     427.63
i1      2.0641      1.0000      72.56     427.63
i1      5.2122      1.0000      11.63     427.63
i1      6.6422      1.0000      35.18     427.63
i1      8.8216      1.0000      25.12     427.63
i1      0.1960      1.0000      29.23     480.00
i1      1.7413      1.0000      60.90     480.00
i1      5.2122      1.0000      11.63     480.00
i1      6.6422      1.0000      35.18     480.00
i1      8.8216      1.0000      25.12     480.00
i1      0.2076      1.0000      42.71     538.78
i1      1.7297      1.0000      52.69     538.78
i1      5.2122      1.0000      11.63     538.78
i1      6.6306      1.0000      14.80     538.78
i1      8.8216      1.0000      25.12     538.78
i1      0.2076      1.0000      41.86     604.76
i1      1.7297      1.0000      52.69     604.76
i1      5.2238      1.0000      15.39     604.76
i1      6.6306      1.0000      34.76     604.76
i1      8.8331      1.0000      25.28     604.76
i1      0.2076      1.0000      30.08     678.82
i1      1.7182      1.0000      49.41     678.82
i1      5.2007      1.0000      71.33     678.82
i1      6.6306      1.0000      34.76     678.82
i1      8.8331      1.0000      25.28     678.82
i1      0.2191      1.0000      41.43     761.95
i1      1.7067      1.0000      50.04     761.95
i1      5.2007      1.0000      71.33     761.95
i1      6.6191      1.0000      14.27     761.95
i1      8.8331      1.0000      25.28     761.95
i1      0.2191      1.0000      41.43     855.26
i1      1.6951      1.0000      36.06     855.26
i1      5.1892      1.0000      61.08     855.26
i1      6.6191      1.0000      35.94     855.26
i1      8.8216      1.0000      25.96     855.26
i1      0.2191      1.0000      41.43     960.00
i1      1.6836      1.0000      10.58     960.00
i1      5.1892      1.0000      61.08     960.00
i1      6.6191      1.0000      35.94     960.00
i1      8.8216      1.0000      25.96     960.00
i1      0.2306      1.0000      60.95    1077.56
i1      1.6836      1.0000      52.28    1077.56
i1      5.1776      1.0000      55.27    1077.56
i1      6.6191      1.0000      35.94    1077.56
i1      8.8216      1.0000      39.74    1077.56
i1      0.2306      1.0000      60.95    1209.52
i1      1.6836      1.0000      52.28    1209.52
i1      5.1776      1.0000      55.27    1209.52
i1      6.6076      1.0000      37.84    1209.52
i1      8.8216      1.0000      39.74    1209.52
i1      0.2306      1.0000      60.95    1357.65
i1      1.6721      1.0000      48.38    1357.65
i1      5.1200      1.0000      13.86    1357.65
i1      6.6076      1.0000      37.84    1357.65
i1      8.8216      1.0000      39.74    1357.65
i1      0.2422      1.0000      66.03    1523.91
i1      1.6605      1.0000      50.19    1523.91
i1      5.1200      1.0000      22.96    1523.91
i1      6.6076      1.0000      37.84    1523.91
i1      8.8216      1.0000      48.03    1523.91
i1      0.2422      1.0000      66.03    1710.53
i1      1.6605      1.0000      50.19    1710.53
i1      5.1085      1.0000      36.40    1710.53
i1      6.6076      1.0000      37.84    1710.53
i1      8.8216      1.0000      48.03    1710.53
i1      0.2422      1.0000      66.03    1920.00
i1      1.6490      1.0000      50.77    1920.00
i1      5.1085      1.0000      36.40    1920.00
i1      6.5960      1.0000      37.36    1920.00
i1      8.8216      1.0000     111.61    1920.00
i1      0.2537      1.0000      62.52    2155.13
i1      1.6375      1.0000      49.34    2155.13
i1      5.0969      1.0000      48.27    2155.13
i1      6.5960      1.0000      37.36    2155.13
i1      8.8216      1.0000     111.61    2155.13
i1      0.2537      1.0000      62.52    2419.05
i1      1.6259      1.0000      48.68    2419.05
i1      5.0854      1.0000      53.86    2419.05
i1      6.5960      1.0000      37.36    2419.05
i1      8.8216      1.0000     111.61    2419.05
i1      0.2537      1.0000      62.52    2715.29
i1      1.6144      1.0000      57.10    2715.29
i1      5.0854      1.0000      53.86    2715.29
i1      6.5845      1.0000      36.45    2715.29
i1      8.8216      1.0000      82.22    2715.29
i1      0.2652      1.0000      59.51    3047.81
i1      1.6029      1.0000      36.12    3047.81
i1      5.0739      1.0000      54.23    3047.81
i1      6.5845      1.0000      36.45    3047.81
i1      8.8216      1.0000      82.22    3047.81
i1      0.2652      1.0000      59.51    3421.05
i1      1.5913      1.0000      10.69    3421.05
i1      5.0623      1.0000      45.11    3421.05
i1      6.5845      1.0000      36.45    3421.05
i1      8.8216      1.0000      76.78    3421.05
i1      0.2652      1.0000      59.51    3840.00
i1      1.5913      1.0000      63.06    3840.00
i1      5.0623      1.0000      50.46    3840.00
i1      6.5730      1.0000      35.80    3840.00
i1      8.8216      1.0000      21.08    3840.00
i1      0.2768      1.0000      55.64    4310.25
i1      1.5798      1.0000      26.95    4310.25
i1      5.0508      1.0000      44.55    4310.25
i1      6.5730      1.0000      35.80    4310.25
i1      7.5993      1.0000      22.51    4310.25
i1      8.8216      1.0000      21.08    4310.25
i1      0.2768      1.0000      55.64    4838.10
i1      1.5798      1.0000      59.38    4838.10
i1      5.0508      1.0000      44.55    4838.10
i1      6.5614      1.0000      35.80    4838.10
i1      7.5993      1.0000      22.51    4838.10
i1      8.8216      1.0000      21.16    4838.10
i1      0.2768      1.0000      55.64    5430.58
i1      1.5683      1.0000      14.63    5430.58
i1      5.0393      1.0000      40.63    5430.58
i1      6.5614      1.0000      35.80    5430.58
i1      7.6108      1.0000      20.95    5430.58
i1      8.8216      1.0000     108.12    5430.58
i1      0.4959      1.0000      72.05    6095.62
i1      1.6490      1.0000      52.26    6095.62
i1      5.0277      1.0000      15.54    6095.62
i1      6.5614      1.0000      35.80    6095.62
i1      7.6339      1.0000      22.60    6095.62
i1      8.8216      1.0000     108.12    6095.62
i1      0.4959      1.0000      72.05    6842.10
i1      1.6375      1.0000      60.28    6842.10
i1      5.0277      1.0000      34.37    6842.10
i1      6.5499      1.0000      33.87    6842.10
i1      7.6569      1.0000      22.60    6842.10
i1      8.8216      1.0000     108.12    6842.10
e







