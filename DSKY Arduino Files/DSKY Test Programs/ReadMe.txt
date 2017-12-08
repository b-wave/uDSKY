Various test programs useful when constructing the miniDSKY (uDSKY) hardware.
TEST1 – Basic display test for all digits and segments
TEST2 – Basic control of displays thru debug or serial port
TEST3 – Pretty much fully working test program:
1. reads seral lines into buffer
2. parses Verb, Noun, Prog, R1, r2, r3
3. put parsed values into DSKY Displays
4. Caution (WHITE) and Warning (YELLOW) Lights control. 
5. Flash C & W Lamps
6. Flash N V Displays
7. SET/RESET COMP ACTY Lamp
8. Keypad can be as keyboard: 
    *CAUTION* writes to open screen on PC!!
    *NOTE*: Set TOOLS>USB Type>Serial+Keyboard,,

DSKYAGC4 -  This sketch was written originally to control the AGC4 software.  The software was basically the same as the original, because the Teensey looks just like a keyboard.  The output was sent on a serial port to control the displays.  These are a standard 9600 baud USB serial port. Match the port to the software. 
For writing to Verb, Noun or Prog displays: (Vxx,  Nxx, or Pxx) (it is not case sensitive) appending with a “*” causes these displays to flash at the 3:1 duty cycle.  Leaving blanks (like V<enter>) will clear the display.
   *   v10[*]/n (1 =MSB 0 =LSB '*' = Flash) 
	Example: V12<Enter> writes VERB = 12
   *   n10[*]/n
	Example: N32*<Enter> makes NOUN = 34 Flashing

PROG or Major mode, (Pxx)
   *   p10/n
p10[*]/n (1 =MSB 0 =LSB '*' = Flash) 

	Example: P00<Enter> writes PROG = 00

Registers 1, 2, or 3 ( 5 digits each Plus sign)  
   *  Rxs/n x= (1 -> 3) s= +/ - or Blank
	Example: R1+12345 <CR> Writes +12345 into R1

LED Indicators:
   *  Wnx/n[*]  (n = LED# (1 -> 5)  x = 1(on) 0(0ff) *(Flash) (Yellow LEDs)
	Example: W11<CR> Turns on TEMP Yellow lamp
   *  Cnx/n[*]  (n = LED# (1 -> 5)  x = 1(on) 0(0ff) *(Flash) (White LEDs)
	Example: C4*<CR> Flashes on KEY REL White lamp

This sketch will also work with a modified DKSY2 software on AGC SIM. 
