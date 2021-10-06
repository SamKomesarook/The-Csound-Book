##############################################################################
# This program created by Hans Mikelson February 1998
# 
# This program generates a POV file so that 3D graphs can be
# rendered using the POV ray tracing package.  The surface is mapped
# as a sphere for each data point sampled.  This was configured for
# use on a Win95 computer.  Some changes may need to be made for use on
# other systems.  This program assumes that POVRay has been installed
# and that there is a path to it.
##############################################################################

# Define files for the template (header/footer), the data and the POV file.
$povfile="plotter.pov";
$numxvals=400;
$numyvals=100;
$scale   =.01;
$radius  = $scale;

# open the POV file.
open (POV, ">$povfile");

# Print the header
print POV "#version 3.0\n";
print POV "global_settings { assumed_gamma 2.2 }\n\n";
print POV "#include \"colors.inc\"\n";
print POV "#include \"shapes.inc\"\n";
print POV "#include \"textures.inc\"\n";
print POV "#include \"glass.inc\"\n";
print POV "#include \"stones.inc\"\n\n";
print POV "#include \"metals.inc\"\n\n";
print POV "camera {\n";
print POV "  location <0, .5,  -1>\n";
print POV "  look_at  <0.0, 0.0,  0.0>}\n\n";
print POV "// Light sources\n";
print POV "light_source {<-30, 21,  40> color White}\n";
print POV "light_source {< 31, -22, -40> color White}\n";
print POV "light_source {< 2,  30,  3> color White}\n\n";

#print POV "  sphere { 0, 4 pigment { color rgbt <1, 1, 1, 1> }\n";
#print POV "    halo { emitting spherical_mapping linear\n";
#print POV "    turbulence 2.5 color_map { [ 0 color rgbt <1, 0, 0,  1> ]\n";
#print POV "    [ 1 color rgbt <1, 1, 0, -1> ] } samples 20} hollow }\n\n";

# Print the data.
for ($i=0;$i<$numxvals;$i++)
 {
  for ($j=0;$j<$numyvals;$j++)
   {
    $xval=($i-$numxvals/2+.0001)*$scale/4;
    $yval=($j-$numyvals/2+.0003)*$scale;
#    $zval=sin(sqrt($xval*$xval+$yval*$yval))*sin(sqrt($xval*$xval+$yval*$yval));
    if ($xval!=0)
     {
      if ((1-$xval*$xval)*(1-$yval+cos(1/$xval))>0)
       {
        $zval=sqrt((1-$xval*$xval)*(1-$yval+cos(1/$xval)))/8;
#    $zval=$xval-$xval*$xval*$xval/12-.25*$yval*$yval+.5;
#    $zval=($xval-$xval*$xval*$xval/12-.25*$yval*$yval+.5);
#   z=sqrt(x^4+y^4-x^2-y^2-x^2Y^2+1)
#    $zval=sqrt($xval*$xval*$xval*$xval+$yval*$yval*$yval*$yval-$xval*$xval-$yval*$yval-$xval*$xval*$yval*$yval+1);
#    $colr=1-1/(1+sqrt($zval*$zval));
#    $colg=1-1/(1+exp($zval));
#    $colb=1/(1+exp($zval*4));
#    Gray Blue
    $colr=1-1/(1+sqrt(abs($xval*8)));
    $colg=1-1/(1+$zval*$xval*4);
    $colb=1/(1+$zval*8);
#    sin^2(x^2+y^2)
#    $colr=$zval;
#    $colg=$zval*$zval;
#    $colb=1-$zval;
    print POV "sphere { <$xval, $zval, $yval>, $radius\n";
#    print POV "   texture {T_Grnt25}\n";
#    print POV "   texture {T_Silver_3C}\n";
#    print POV "    texture { pigment {color Blue}}\n";
    print POV "    texture { pigment {color rgb <$colr, $colg, $colb>}}\n";
    print POV "    finish {caustics 1.0 phong 1 phong_size 300 reflection 0.15}\n";
    print POV "}\n\n";
       }
     }

   }
 }

close(POV);

# Call POV to render the graph
# chop($DLINES[0]);
# @SIZE=split("=",$DLINES[0]);
# $height=$SIZE[1]*3;
# $width=$SIZE[1]*4;
# $tempv=`povray +Iplotter.pov +Oplotter.tga +P +GA +H480 +W640`;

# End of script

