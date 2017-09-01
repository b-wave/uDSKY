#include <Key.h>
#include <Keypad.h>

/* This program is the DSKY for AGC4
//1. reads seral lines into buffer
//2. parses Verb, Noun, Prog, R1, r2, r3
//3. put parsed values into DSKY Displays
//4. Caution and Warning Lights. 
//5. Flash C & W Lamps
//6. Flash N V Displays
//7. SET/RESET COMP ACTY Lamp
//8. Keypad as keyboard 
    *CAUTION* writes to open screen on PC!!
    *NOTE*: Set TOOLS>USB Type>Serial+Keyboard,,,

*/

#include <string>
#include "LedControl.h"

// Create an IntervalTimer object 
IntervalTimer DSKYTimer;

//DSKY 
const byte ROWS = 3; //3 rows
const byte COLS = 7; //seven columns
char keys[ROWS][COLS] = {
  {'*','0','1','2','3','K','R'},
  {'N','-','4','5','6','P','E'},
  {'V','+','7','8','9','C','#'},
  };
byte rowPins[ROWS] = {21, 22, 23}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {0, 1, 3, 4, 8, 9, 10}; //connect to the column pinouts of the keypad
  
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

/* 
 * This is in Global maybe dsky.h
 */
static char Verb[3];
static char Noun[3];
static char Prog[3];
static char R[3][6];
static char W[6];
static char C[6];


/*
Pins for teensey 3.0 on miniDSKY
 pin 17 is connected to the DataIn 
 pin 16 is connected to the CLK 
 pin 15 is connected to LOAD
 miniDSKY has 3  MAX72XX.
 */

LedControl dsky=LedControl(17, 16, 15, 3);

/* we always wait a bit between updates of the display */
unsigned long delaytime=250;
const int led = LED_BUILTIN;

int readline(int readch, char *buffer, int len)
{
  static int pos = 0;
  int rpos;

  if (readch > 0) {
    switch (readch) {
      case '\n': // Ignore new-lines
        break;
   
      case '\r': // Return on CR
        rpos = pos;
        pos = 0;  // Reset position index ready for next time
        return rpos;
      default:
        if (pos < len-1) {
          buffer[pos++] = readch;
          buffer[pos] = 0;
        }
    }
  }
  // No end of line has been found, so return -1.
  return -1;
}

void clearall(){
      dsky.clearDisplay(0);
      dsky.clearDisplay(1);
      dsky.clearDisplay(2); 
}

void ClearDisp() {
      for(int i=0;i<2;i++) {
        Verb[i]=' ';
        Noun[i]=' ';
        Prog[i]=' ';
      }
    for(int i=0;i<6;i++) {
     
    R[0][i]=' '; 
    R[1][i]=' '; 
    R[2][i]=' '; 
     }
}

void DSKY_VN(bool Blinking){
  
   dsky.setChar(2,7,Prog[0],false);
   dsky.setChar(2,6,Prog[1],false);

if(Verb[2]=='*'){
if(Blinking){
  dsky.setChar(0,7,Verb[0],false);
  dsky.setChar(0,6,Verb[1],false);
   }
else{
   dsky.setChar(0,7,' ',false);
   dsky.setChar(0,6,' ',false);
   }
}
else{
   dsky.setChar(0,7,Verb[0],false);
   dsky.setChar(0,6,Verb[1],false);

}

if(Noun[2]=='*'){
if(Blinking){
  dsky.setChar(1,7,Noun[0],false);
   dsky.setChar(1,6,Noun[1],false); 
   }
else{
   dsky.setChar(1,7,' ',false);
   dsky.setChar(1,6,' ',false);
   }
}
else{
   dsky.setChar(1,7,Noun[0],false);
   dsky.setChar(1,6,Noun[1],false);

}

}

void DSKY_R(bool Blink){
//show R1, R2, and R3

    for (int i = 0; i < 3; ++i)
    {
bool dp = false;

          for (int j = 0; j < 6; ++j) {

           dp = false;
        if (i == 1) {
          if (W[j] == '1') dp = true;
          if (W[j] == '*') dp = Blink; 
          if (W[j] == '+') dp = Blink;       
   
        }
        if (i == 2) {    
          if (C[j] == '1') dp = true;
          if (C[j] == '*') dp = Blink; 
          if (C[j] == '+') dp = Blink; 
        }
            
          dsky.setChar(i,j,R[i][5-j],dp);

          } //All 5 digits & Sign

    } //All 3 REG done
}
void setup()
{
  DSKYTimer.begin(blinkLED, 100000);  // blinkLED to run every 0.1 seconds

  pinMode(led, OUTPUT);
  Serial.begin(9600);
    /*
   The MAX72XX is in power-saving mode on startup,
   we have to do a wakeup call
   */
   
   ///////////////////////////
  // LED REG1 setup:
  //////////////////////////  
  dsky.shutdown(0,false);
  /* Set the brightness to a medium values */
  dsky.setIntensity(0,4);
  /* and clear the display */
  dsky.clearDisplay(0);
  
   ///////////////////////////
  // LED REG2 setup:
  //////////////////////////
  dsky.shutdown(1,false);
  /* Set the brightness to a medium values */
  dsky.setIntensity(1,4);
  /* and clear the display */
  dsky.clearDisplay(1);

  ///////////////////////////
  // LED REG3 setup:
  //////////////////////////
  dsky.shutdown(2,false);
  /* Set the brightness to a medium values */
  dsky.setIntensity(2,4);
  /* and clear the display */
  dsky.clearDisplay(2);

  
  ClearDisp();  
  
 
}
// The interrupt will blink the LED, and keep
// track of how many times it has blinked.
volatile bool ledState = false;
volatile unsigned long blinkCount = 0; // use volatile for shared variables



void blinkLED(void) {
/*  
  if (ledState == LOW) {
    ledState = HIGH;
    blinkCount = blinkCount + 1;  // increase when LED turns on
  } else {
    ledState = LOW;
  }
  digitalWrite(led, ledState);
*/

 blinkCount = blinkCount + 1;  // increase when LED turns on

 if (blinkCount < 4)  {   
 ledState = false;
 }
 
 else {
   ledState = true;
   if (blinkCount > 9) blinkCount = 0;
  }
//  digitalWrite(led, ledState);
}

  



void loop(){

static int indx;
static char buffer[80];

 // digitalWrite(led, ledState);
//Display on LEDs...
 delay(10);
  noInterrupts();

 DSKY_VN(ledState);  
 DSKY_R(ledState);

  interrupts();
  
   
char key = keypad.getKey();
  if (key) {


 //This is debug output of DSKY Keys:   
    Serial.println(key);
    
  //this lets the DSKY Keys control if using com porton PC   
  //if (key== 'E') Keyboard.print(key); //E does not  <enter>
   // else 
    
    Keyboard.print(key);
   
  }

  //Cebug shows status of the various displays sent
  if (readline(Serial.read(), buffer, 80) > 0) {
    Serial.print("You entered: >");
    Serial.print(buffer);
    Serial.println("<");


  /********PARSE AGC Commands*************
   * 
   * parse the serial stream state machine..
   *   v10f/n (1 =MSB 0 =LSB f = '*' = Flash) 
   *   n10f/n
   *   p10/n
   *  Rxs/n x= (1 -> 3)s= + - or Blank)
   *  Wnx/n  (n = LED# (1 -> 5)  x = 1(on) 0(0ff) *(Flash)
   *  Cnx/n  (n = LED# (1 -> 5)  x = 1(on) 0(0ff) *(Flash)
   ***************************************/

 switch(buffer[0])
    {
      case 'A':
      case 'a':
      if (buffer[1]=='0') digitalWrite(led, LOW);
      if (buffer[1]=='1') digitalWrite(led, HIGH);
      
      break;
      
      case 'V':
      case 'v':
      Verb[2] = buffer[3];   //Flash it = '*'
      Verb[1] = buffer[2];  //LSB
      Verb[0] = buffer[1];  //MSB
      break;
      
      case 'N':
      case 'n':
      Noun[2] = buffer[3];     
      Noun[1] = buffer[2];
      Noun[0] = buffer[1];
      break;
      
      case 'P':
      case 'p':
      Prog[1] = buffer[2];
      Prog[0] = buffer[1];
      break;
    /////////////////////////////////////////////  
   /*WARNING (Yellow) ndicators:
     W1 = TEMP
     W2 = GYMBAL LOCK
     W3 = PROG
     W4 = RESTART
     W5 = TRACKER
    */
      case 'W':  
      case 'w':
 //     case 'K':     //this is for DSKY K key tocontrol Warnings
         indx=6;
          if(buffer[1]=='1') indx=0;
          if(buffer[1]=='2') indx=1;
          if(buffer[1]=='3') indx=2;
          if(buffer[1]=='4') indx=3;
          if(buffer[1]=='5') indx=4;
          
        W[indx] = buffer[2];
          break;
          
    /////////////////////////////////////////////  
   /*CAUTION Indicators:
     C1 = UPLINK ACTY
     C2 = NO ATT
     C3 = STBY
     C4 = KEY REL
     C5 = OPR ERR
    */
      case 'C':              
      case 'c':
          indx=6;
          if(buffer[1]=='1') indx=0;
          if(buffer[1]=='2') indx=1;
          if(buffer[1]=='3') indx=2;
          if(buffer[1]=='4') indx=3;
          if(buffer[1]=='5') indx=4;
        C[indx] = buffer[2];
          break; 

//REGISTERS (R1, R2 , or R3)
      case 'r':
      case 'R':
          for(int i = 0; i <6; ++i){
          if(buffer[1]=='1') indx=0;
          if(buffer[1]=='2') indx=1;
          if(buffer[1]=='3') indx=2;

          R[indx][i] = buffer[i+2]; 
 
          }

      break;

        
    
    } 
/*
  //outputs for debug on serial...
 //Display on LEDs...

   dsky.setChar(0,7,Verb[0],false);
   dsky.setChar(0,6,Verb[1],false); 

   dsky.setChar(1,7,Noun[0],false);
   dsky.setChar(1,6,Noun[1],false); 

   dsky.setChar(2,7,Prog[0],false);
   dsky.setChar(2,6,Prog[1],false);

   //show R1, R2, and R3
    for (int i = 0; i < 3; ++i)
    {
//bool dp =false;
          for (int j = 0; j < 6; ++j) {
// set LEDs for positive sign ( SEG G + dp)case:
           if( R[i][5-j] == '+') {
                      dsky.setChar(i,j,'-',true);
                      break;
           }
          dsky.setChar(i,j,R[i][5-j],false);

          }

    } 
 */   
  //Show master mode Program PROG
     Serial.print("P: [");
     Serial.print(Prog[0]);
     Serial.print("] [");  

     Serial.print(Prog[1]);
     Serial.println("]  ");  
 //Show Verb    
    Serial.print("V: [");
    Serial.print(Verb[0]);
    Serial.print("] [");
    Serial.print(Verb[1]); 
    Serial.print("]  "); 
 //Show Noun   
    Serial.print("N: [");
    Serial.print(Noun[0]);
    Serial.print("] [");
    Serial.print(Noun[1]);
    Serial.println("]  "); 

//show R1, R2, and R3
    for (int i = 0; i < 3; ++i)
    {
          Serial.print("R[");
          Serial.print(i+1);
          Serial.print("]= ");      
          for (int j = 0; j < 6; ++j) {
            Serial.print("[");
            Serial.print(R[i][j]);

            Serial.print("] ");
          }
            Serial.println(" "); 
    } 
//Print LEDs
          Serial.print("W = ");
          for (int i = 0; i < 5; ++i) {
            Serial.print(i+1);
            Serial.print("[");
            Serial.print(W[i]);
            Serial.print("] ");  
          }
            Serial.println(" "); 
 
           Serial.print("C = ");
          for (int i = 0; i < 5; ++i) {
            Serial.print(i+1);
            Serial.print("[");
            Serial.print(C[i]);
            Serial.print("] ");  
          }
            Serial.println(" ");  


 //Display on LEDs...

/*
//show R1, R2, and R3
    for (int i = 0; i < 3; ++i)
    {
bool dp = false;

          for (int j = 0; j < 6; ++j) {

           dp = false;
        if (i == 1) {
          if (W[j] == '1') dp = true;
          if (W[j] == '*') dp = ledState; 
   
        }
        if (i == 2) {    
          if (C[j] == '1') dp = true;
          if (C[j] == '*') dp = ledState; 
    
        }
            
          dsky.setChar(i,j,R[i][5-j],dp);

          } //All 5 digits & Sign

    } //All 3 REG done
*/
    }    

  }

