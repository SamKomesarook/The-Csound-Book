# Hopasong generates a short phrase based on the scales selected and the hopalong algorithm

function hopasong(n, root, chrd, d, hpa, hpb) 

# n is the length of the phrase
# root is the key the phrase is in
# chrd determines the which chord or scale to use
# d is the duration of each note
# hpa is the hopalong constant a
# hpb is the hopalong constant b

 {                                  
  b        =''                      # Initialize b to an empty string
  a        ='c'                     # Initialize a to some dummy note value
  a.dur    = d                      # Adjust duration and length of the note
  a.length = d

  x = 0;                            # Initialize hpx and hpy to zero
  y = 0;

  for (j=0; j<n; j++)
   {
    snx = (x == 0) ? 1 : x/abs(x)    # Determine the sign of X
    xx  = y - snx + sqrt(abs(hpb*x)) # Hopalong the X part and save the new X
    y   = hpa - x                    # Hopalong the Y part
    x   = xx                         # Update X

    a.pitch = ffscal(abs(x)%60, chrd)+60+root # Find the note in the scale
    a.vel      = (abs(y)%4/1+1)*32            # Use Y for the 
    b         = b+a                  # Add the new note to the list of notes
   }
  return (b)
 }


