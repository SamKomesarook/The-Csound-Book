#------------------------------------------------------------
# Bouncing ball simulation score generator
# coded by Hans Mikelson May 2000
#------------------------------------------------------------
$ax = -1;                     # Acceleration constant
$h=.0001;                     # time step

open (BOUNCE, ">bounce.sco"); # Create the score file
print BOUNCE ";   Start    Duration   Amplitude   Frequency  Q   Pan\n";

# Generate 10 different balls
for ($j=0; $j<10; $j++)
 {
  print "$j";
  # Each ball has a specific pitch, elasticity and wall location
  $pitch   = 100+rand(100);
  $elast   = .98-rand(.1);
  $wallx   = -1.2+rand(.4);
  $pan     = int(rand(1)*1000)/1000;

  $i = 0;
  $amp = 1; # Amp must be greater than zero to get things started
  $vx = 0; $x = 0; # Velocity and position start at zero

  # It takes a long time to get to stop bouncing! Increase the 800000 if you want to handle longer bounces
  while ($i<800000 && $amp>0)
   {
    $vx = $vx + $h*$ax;  # Update velocity
    $xx = $x  + $h*$vx;  # Update position

    # If the ball will have hit the wall
    if ($xx<$wallx)
     {
      $vx = -$vx*$elast;            # Reverse the velocity and scale by the elasticity
      $x  = $wallx+abs($xx-$wallx); # Find the new position

      # Set up the score based on the bounce
      $sta = int(($i*$h*.1+$j)*1000)/1000;           # Starting time based on $i, $h & $j rounded to 3 sig figs
      $dur = int(abs($vx)*100)/1000;                 # Duration based on velocity
      $fqc = int(($pitch+$vx*$vx*80)*4*1000)/1000;   # Frequency based on ball and modified by energy of impact
      $amp = int((abs($vx)*(1-$elast*.8)*1000))*100; # Amplitude based on velocity and elasticity

      # As long as there is some amplitude generate a sound event
      if ($amp>0)
       {
        print BOUNCE "i1  $sta  $dur  $amp  $fqc  .95  $pan\n";
        print "."; # Just to convince you that the system has not locked up on you!
       }
     }

    # If the ball has not hit the wall yet just update the position
    else
     {
      $x = $x + $h*$vx;
     }
    $i++;  # You don't want the program to run forever do you?
   }
  print "\n";
 }

close (BOUNCE);

