# uDSKY PROJECT
## A Physical implementaion of an Apollo AGC DSKY. 
*...with USB 2.0 Connectivity for PC simulators*

This assembly and firmware has sucessfully been used to control both
John Pultorak's Block1 Simulator vers 1.16 in C++ and Ronald Burkey's
Block 2 AGC simulators on <http://www.ibiblio.org/apollo/> 
Further, the Simulation runs great on Raspberry Pi.  I will fork the 
files needed for both simulators. The Teensy 3.2 used in this has a plug in
board that contains a Real time clock and 9 DOF navigation sensors.

Why did I do this?  Ultimately, it is a clock. I intend to have a standalone
version to do navigation demonstation experiments and become a "moon clock" to track
the current position, phase, and distance to the moon - *...in real time!*

What it is not... A 1:1 scale model of a DSKY.  How I arrived at the scaling was 
I took the best head-on photo of a DSKY I could find and scaled it to match the 
smallest descrete LED 7-segment green *-ish* displays i could find.

It turned out that at that scale, the Keys were  ~.75" on center, which was nice
and almost exactly 0.75" Square. The front panel was about 7.0" x 6.5" so about, but
not exactly, half the size of a real DSKY. The wholw thing sandwiches nicely together
using plexiglas plates and hardware spacers, which I will provide laser cut patterns for.
The whole assembly is remarkably sturdy ane even kind of hefty too.  The keys and circuit 
boards were attached by small torx head "thread rolling" screws for plastic.  I think 
the ones i got were about 2 AWG, and 1/8" long.  I got them on e-bay and i don't have
the link, there were 100's of them in a box for a few dollars. They should be easy to
find.  I'll update a link when i find a good supplier again. 

There are two other circuit boards I am developing.  The INDICATOR boards for the LEDs
since I used perf boards for this prototype.  The POWER REGULATOR board for stand alone
operation on 12V dc, and illuminating and controlling the VERB, NOUN, and PROG illumination
and the keyboard backlighting. These will be controlled the same as the other LEDs
but thru an isolator to control 12V to theses diodes. I also have an idea to use LEDs
amd some clear plexiglas to simulate the long EL strips between the three registers - 
but this is still in the *idea phase*. 

The prototype shown here has hand cut plastics so it looks, well it really is, 
a little sloppy.  I used this matte black plastic i got from TAP Plastics so it would 
hold paint a little better than glossy plastic. I have not painted anything yet so 
it looks a little daek side, even *darth-DSKY* right now. 
![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_135148.jpg)
Running the LED Test program 1 

The circuit boards are mostly attached to a 1/8" plexiglas rear plate.  The Teensey is
mounted on female pin headers on the main display board.  The Teensy actully slips thru
a recetangular hole in the rear mounting plate. The displays are multiplexed 
with the DP segments from the first two controllong the LED INDICATORS. The lamps 
are separated with a matrix of opaque lattius.  I made the prototype with popcicle
sticks, which turned out to be a litle short.  I have the plans for laser cut version
that will be better.

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161008_122015.jpg)
Indicator Holders

As you can see there is still some leakage between wells of the Indicator lamps but 
this is quite usable. 
![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_135230.jpg)
Every Other INDIC Is On.

ISEG G and one DP are used in the first display for each of the three registors
to provide the segments for the SIGN digit.  Since there is no known compatable 
SIGN LED Display - i put an array of SMT LEDs on the circuit board to represent this 
digit.   
![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_140523.jpg)
All Displays are ON!

It worked OK, but later i relized that if the displays were behind a cardstock
printout, behind the smoked grey plexiglas they look a lot like the original DSKY EL 
displays.  But the LEDs were too far from the card stock to be seen.  I then developed a 
pair of circuit boards, one to hold the LEDs and the other provides a light mask. This
brings the sign digit near to the display.  As you can see with the card stock the 
uDSKY is very simular to the DSKY as you cant really see the digits until they are
 illuminated. 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20161217_134940.jpg)
With power off 



# Apollo uDSKY's  Keys 
The Keys are Cherry MX series. These have a real nice clicky feel and best of all
they can support custom keycaps and can be illuminated! 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20160903_105214.jpg)
The key caps are from:  <http://xkeys.com/accessories/Keycaps.php> 

They are not .75" x .75 which would be ideal but they have a little curve on the bottom
which makes the laser printed labels a little tricky to line up. But it works fairly well.
You will need 19 caps (4 orders will get you 20). I got both the clear and green. I thnk the black ones
will be opaque so they can't be illuminated. 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20160903_105235.jpg)
Keys with relegendable keycaps for cherry mx switches

The Keys are simply mounted on a *slightly* modifued SF MX breakout board. You can order them 
and (BOB-13773) they will work fine: https://www.sparkfun.com/products/13773 The next version I make 
may contain all 19 keys in one board.  The 1 pins are all connected for ROWS and the 2 pins are for columns.
Check out the Teensey code for the pattern and hookup. 
<https://github.com/b-wave/uDSKY/tree/master/DSKY%20Arduino%20Files>

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20160903_111600.jpg)
SF Breakout connections.

The X/Y row - column pattern is fairly self-explanitory.  The final assembly feels like holding some chain-mail armor. 
The only difficulties were to use small wire "U" shapes instead of straight from pin to pin. This makes the 
spacing of the keys line up to the holes on the base plate a little eaiser.  The second is the two columns 
on the ends don't precicely line up anyway on one side, it helps to rotate those two keys 90deg. 
*see on the right hand side of bottom view:*

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/Files/20160903_165413.jpg)
Matrix of Keys

# Apollo uDSKY's  Registers Sign Digits
I developed a little circuit board *set* that will give a sign digit for each register.  There are actully two other ways to 
get the sign digits. First, simply put in another 7-segment display. The G segment will be (-) and the DP will represent (+) 
...*blank is octal as usual*  Second, the board has pad for SMT LEDs that form the signs.  G and DP illumiate the pairs of
LEDs but this arrangement has the distance problem, but you can still use the mask board to make the displays look better.

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095621.jpg)


This board will allow a pretty good substitute for the non-existent compatible LED sign digits for an **Apollo DSKY** display.  You will also need the  [**DS_MASK.brd** ](https://oshpark.com/shared_projects/6qTKqnak" Order from OSH Park!") for each display if you want the displays to be more *segment-ty?*   There are also some additional masking and diffusing techniques  that can be done to make these look really good. 

https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095401.jpg

## _NOTES:_
This is intended to be used with a 0.39" 10-pin LED displays such as **LTS-4301G** that were used on the **uDSKY** display. 

The minus **(-)** are controlled by the standard *G - Segment* Pin **1** with 2 LEDs in series.  The **(+)** is a combination of the **"g1"**  and **"g2"** Segs *and* the vertical segments *(some times referred to as **"h"** and **"J"**)* which are connected to the **"DP"** pin **6**.  The **Common** pins are **8** and **3**.  Because both displays are *two* LEDs in series this should simplify non-MUX displays as well.

<https://www.jameco.com/z/LTS-4301G-Lite-On-Electronics-Green-7-Segment-LED-Display_2227911.html>

When selecting the SMT LEDs make sure you get them close to the brightness and color wavelength.  For example , these LED displays have: **569 nm**  (green) with an avg. intensity = **2200 µCD** @ If =10mA.

 I will post some details on how to put these together.  But basically, you need to diffuse the light or the viewing angle gets critical.  I used a simple piece of scotch tape but hot melt glue may also work.  

The parts placement is pretty simple, The anode of the first LED connects to the respective pin.  The two LED's cathodes and anodes for each segment are connected together. The cathodes of the 2nd LEDs connect to the common pins.  If you forget one LED or get one in backwards... *no light!*  The Eagle Files are at: 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095406.jpg)
Plus Display

A couple of baffles between the G and the vertical segments are also needed or when only (-) is displayed the other segments are still slightly visible.  I used a couple scrap pieces of black wire insulation wedged between the segments to block this.

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/DS_PLUS%20Files/20170219_095505.jpg)
Light Baffels 

![uDSKY](https://github.com/b-wave/uDSKY/blob/master/uDSKY%20Hardware/DSKY_DISP/DS_PLUS%20Files/20170219_095401.jpg)
Minus Display

Use two 0.1" 5-pin headers to hold the two boards together.  Mount the header on *top* of this board (long pins go thru the board)   Then put the mask board on top of the header. The boards are separated by the plastic header. Push the pins flush to the  top **MSK_Brd** *Pins 1, 6, 8, and 3* now have to be soldered on the bottom of this board.  You can solder the mask board's pins all in place if you want to - after you verify everything is working OK of course, there are no electrical connections.



