# uDSKY
Physical implementaion of an Apollo AGC DSKY. 

The prptotype shown here has hand cut plastics so it looks
a little sloppy.  I used this matte black plastic so it would 
hold paint a little better than glossy plastic.
![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_135148.jpg)
Running the LED Test program 1 

The circuit boards are mostly attached to a rear plate.  The Teensey is
mounted on female pins on the main display board.  The Teensy actully slips thru
a recetangular hole in the rear mounting plate. The displays are multiplexed 
with the DP segments from the first two controllong the LED INDICATORS.  The 
SEG G and one DP are used in the first display for each of teh three registors
to provide the segments for the SIGN digit.  Since there is no known compatable 
SIGN LED Display - i put an array of SMT LEDs on the circuit board to represent this 
digit.  It worked OK, but later i relized that if the displays were behind a cardstock
printout, behind the smoked grey plexiglas they look a lot like the original DSKY EL 
displays.  But the LEDs were too far from the card stock to be seen.  I then developed a 
pair of circuit boards, one to hold the LEDs and the other provides a light mask. This
brings the sign digit near to the display.  As you can see with the card stock the 
uDSKY is very simular to the DSKY as you cant really see the digits until they are
illuminated. 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_134940.jpg)
With power off 

The Keys are Cherry MX series. These have a real nice clicky feel and best of all
they can support custom keycaps and can be illuminated! 


