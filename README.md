

# uDSKY Physical implementaion of an Apollo AGC DSKY. 

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


# Apollo uDSKY's  Registers Sign Digits

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095621.jpg)


This board will allow a pretty good substitute for the non-existent compatible LED sign digits for an **Apollo DSKY** display.  You will also need the  [**DS_MASK.brd** ](https://oshpark.com/shared_projects/6qTKqnak" Order from OSH Park!") for each display if you want the displays to be more *segment-ty?*   There are also some additional masking and diffusing techniques  that can be done to make these look really good. 

https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095401.jpg

## _NOTES:_
This is intended to be used with a 0.39" 10-pin LED displays such as **LTS-4301G** that were used on the **uDSKY** display. 

The minus **(-)** are controlled by the standard *G - Segment* Pin **1** with 2 LEDs in series.  The **(+)** is a combination of the **"g1"**  and **"g2"** Segs *and* the vertical segments *(some times referred to as **"h"** and **"J"**)* which are connected to the **"DP"** pin **6**.  The **Common** pins are **8** and **3**.  Because both displays are *two* LEDs in series this should simplify non-MUX displays as well.

<https://www.jameco.com/z/LTS-4301G-Lite-On-Electronics-Green-7-Segment-LED-Display_2227911.html>

When selecting the SMT LEDs make sure you get them close to the brightness and color wavelength.  For example , these LED displays have: **569 nm**  (green) with an avg. intensity = **2200 µCD** @ If =10mA.

 I will post some details on how to put these together.  But basically, you need to diffuse the light or the viewing angle gets critical.  I used a simple piece of scotch tape but hot melt glue may also work.  A couple of baffles between the G and the vertical segments are also needed or when only (-) is displayed the other segments are still slightly visible.  I used a couple scrap pieces of black wire insulation wedged between the segments to block this.

The parts placement is pretty simple, The anode of the first LED connects to the respective pin.  The two LED's cathodes and anodes for each segment are connected together. The cathodes of the 2nd LEDs connect to the common pins.  If you forget one LED or get one in backwards... *no light!*  The Eagle Files are at: 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095406.jpg)
 
Use two 0.1" 5-pin headers to hold the two boards together.  Mount the header on *top* of this board (long pins go thru the board)   Then put the mask board on top of the header. The boards are separated by the plastic header. Push the pins flush to the  top **MSK_Brd** *Pins 1, 6, 8, and 3* now have to be soldered on the bottom of this board.  You can solder the mask board's pins all in place if you want to - after you verify everything is working OK of course, there are no electrical connections.
