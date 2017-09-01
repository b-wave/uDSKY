//We always have to include the library
#include "LedControl.h"

/*
 Now we need a LedControl to work with.
 ***** These pin numbers will probably not work with your hardware *****
 pin 12 is connected to the DataIn 
 pin 11 is connected to the CLK 
 pin 10 is connected to LOAD 
 We have only a single MAX72XX.
 */
//LedControl lc=LedControl(12,11,10,1);
/*changed pins for teensey 3.0
 pin 16 is connected to the DataIn 
 pin 17 is connected to the CLK 
 pin 18 is connected to LOAD 
 */
//LedControl lc=LedControl(16, 17, 18, 4);
LedControl lc=LedControl(17, 16, 15, 3);

/* we always wait a bit between updates of the display */
unsigned long delaytime=250;

const int led = LED_BUILTIN;

void setup() {

    pinMode(led, OUTPUT);
  /*
   The MAX72XX is in power-saving mode on startup,
   we have to do a wakeup call
   */
   
   ///////////////////////////
  // LED REG1 setup:
  //////////////////////////  
  lc.shutdown(0,false);
  /* Set the brightness to a medium values */
  lc.setIntensity(0,4);
  /* and clear the display */
  lc.clearDisplay(0);
  
   ///////////////////////////
  // LED REG2 setup:
  //////////////////////////
    lc.shutdown(1,false);
  /* Set the brightness to a medium values */
  lc.setIntensity(1,4);
  /* and clear the display */
  lc.clearDisplay(1);

  ///////////////////////////
  // LED REG3 setup:
  //////////////////////////
    lc.shutdown(2,false);
  /* Set the brightness to a medium values */
  lc.setIntensity(2,4);
  /* and clear the display */
  lc.clearDisplay(2);
}
void FLASH_LED(){
  digitalWrite(led, HIGH);
  delay(100);
  digitalWrite(led, LOW);
  
}
/*
 This method will display the characters for the
 word "Arduino" one after the other on digit 0. 
 */
void HELLO_AGC() {
  lc.setChar(0,4,'H',false);
  delay(delaytime);
  lc.setChar(0,3,'E',false);
  delay(delaytime);
  lc.setChar(0,2,'L',false);
  delay(delaytime);
 lc.setChar(0,1,'L',false);
  delay(delaytime);
 lc.setChar(0,0,'0',false);
  delay(delaytime);

   lc.setChar(1,4,'-',false);
    delay(delaytime);
  lc.setChar(1,3,'a',false);
  delay(delaytime);
    lc.setRow(1,2,B01011110); //B01011110 = 'G'
   delay(delaytime); 
 // lc.setChar(1,1,'C',false); //B01001110 = 'C'
      lc.setRow(1,1,B01001110);
     delay(delaytime); 
   lc.setChar(1,0,'-',false);
    delay(delaytime);

  lc.setChar(2,4,'2',false);
   delay(delaytime);
  lc.setChar(2,3,'0',false);     
   delay(delaytime);
  lc.setChar(2,2,'1',false);
   delay(delaytime);
  lc.setChar(2,1,'6',false);
     delay(delaytime);
    lc.setChar(2,0,'A',false);     
  
  delay(delaytime*5);
  lc.clearDisplay(0);
  delay(delaytime*5);
  lc.clearDisplay(1);
  delay(delaytime*5);
  lc.clearDisplay(2);
    delay(delaytime*5);
}

/*
 This method will display the characters for the
 word "Arduino" one after the other on digit 0. 
 */
void writeArduinoOn7Segment() {

  
  lc.setChar(0,0,'a',false);
  delay(delaytime);
  lc.setRow(0,0,0x05);
  delay(delaytime);
  lc.setChar(0,0,'d',false);
  delay(delaytime);
  lc.setRow(0,0,0x1c);
  delay(delaytime);
  lc.setRow(0,0,B00010000);
  delay(delaytime);
  lc.setRow(0,0,0x15);
  delay(delaytime);
  lc.setRow(0,0,0x1D);
  delay(delaytime);
  lc.clearDisplay(0);
    lc.clearDisplay(1);
  delay(delaytime*2);
  
  lc.setChar(1,0,'a',false);
  delay(delaytime);
    lc.setRow(1,0,B01011110); //B01011110 //= 'G'
   delay(delaytime); 
  lc.setChar(1,0,'c',false);
     delay(delaytime); 
   lc.setChar(1,0,'-',false);
    delay(delaytime);
     lc.clearDisplay(1);   

  delay(delaytime);
  lc.setChar(2,0,'2',false);
   delay(delaytime);
  lc.setChar(2,0,'0',false);     
   delay(delaytime);
  lc.setChar(2,0,'1',false);
   delay(delaytime);
  lc.setChar(2,0,'6',false);     
    delay(delaytime*3);
    lc.clearDisplay(1);
} 


//B01011110 //= 'G'
/*
  This method will scroll all the hexa-decimal
 numbers and letters on the display. You will need at least
 four 7-Segment digits. otherwise it won't really look that good.
 */
void scrollDigits() {
    for(int i=0;i<16;i++) {  
      
    lc.setDigit(0,0,i,true);
    lc.setDigit(0,1,i+1,false);
    lc.setDigit(0,2,i+2,true);
    lc.setDigit(0,3,i+3,false);
    lc.setDigit(0,4,i+4,true);
    lc.setDigit(0,5,i+5,false);
    lc.setDigit(0,6,i+6,false);
    lc.setDigit(0,7,i+7,false);
    
    lc.setDigit(1,0,i,true);
    lc.setDigit(1,1,i+1,false);
    lc.setDigit(1,2,i+2,true);
    lc.setDigit(1,3,i+3,false);
    lc.setDigit(1,4,i+4,true);
    lc.setDigit(1,5,i+5,false);
    lc.setDigit(1,6,i+6,false);
    lc.setDigit(1,7,i+7,false);

    lc.setDigit(2,0,i,false);
    lc.setDigit(2,1,i+1,true);
    lc.setDigit(2,2,i+2,false);
    lc.setDigit(2,3,i+3,true);
    lc.setDigit(2,4,i+4,false);
    lc.setDigit(2,5,i+5,false);
    lc.setDigit(2,6,i+6,false);
    lc.setDigit(2,7,i+7,false);         
    delay(delaytime);
  }
 //   lc.clearDisplay(0);
 //   lc.clearDisplay(1);
 //   lc.clearDisplay(2);
  delay(delaytime);
}
void AllDigits() {
    for(int i=0;i<16;i++) {
  
          
    lc.setDigit(0,7,i,false); 
    lc.setDigit(0,6,i,false); 
    lc.setDigit(0,5,i,false);          
    lc.setDigit(0,4,i,false);  
    lc.setDigit(0,3,i,false);
    lc.setDigit(0,2,i,false);
    lc.setDigit(0,1,i,false);
    lc.setDigit(0,0,i,false);

    lc.setDigit(1,7,i,false);
    lc.setDigit(1,6,i,false);
    lc.setDigit(1,5,i,false);       
    lc.setDigit(1,4,i,false);
    lc.setDigit(1,3,i,true);
    lc.setDigit(1,2,i,false);
    lc.setDigit(1,1,i,true);
    lc.setDigit(1,0,i,false);

    lc.setDigit(2,7,i,false);
    lc.setDigit(2,6,i,false);
    lc.setDigit(2,5,i,false);       
    lc.setDigit(2,4,i,true);
    lc.setDigit(2,3,i,false);
    lc.setDigit(2,2,i,true);
    lc.setDigit(2,1,i,false);
    lc.setDigit(2,0,i,true);
    delay(delaytime);
  }
  lc.clearDisplay(0);
    lc.clearDisplay(1);
      lc.clearDisplay(2); 
  delay(delaytime);
}

void AllBalls() {
  for(int n=0;n<6;n++){
    for(int i=0;i<8;i++) {
     
    lc.setDigit(0,i,8,true); 
    lc.setDigit(1,i,8,true);
    lc.setDigit(2,i,8,true);
     }
       digitalWrite(led, LOW);
      delay(delaytime*3);
   
      lc.clearDisplay(0);
      lc.clearDisplay(1);
      lc.clearDisplay(2); 
        digitalWrite(led, HIGH);
        delay(delaytime);
   
  }
}

  void setLEDs() {
    
    for(int i=0;i<5;i++) {

      lc.setDigit(2,i,2,true); 
       lc.setDigit(2,7,2,true); 
       lc.setDigit(2,6,i,true); 
        
       lc.setChar(1,7,'C',false);
       lc.setDigit(1,6,i+1,false); 
        
      delay(delaytime*4);   
    }

        for(int i=0;i<5;i++) {

       lc.setDigit(1,i,1,true);
       lc.setDigit(2,7,1,true); 
       lc.setDigit(2,6,i,true);
       
       lc.setChar(1,7,'A',false);
       lc.setDigit(1,6,i+1,false);
         
      delay(delaytime*4);   
    }

          for(int i=0;i<2;i++) {

       lc.setDigit(0,i,0,true);
       lc.setDigit(2,7,0,true); 
       lc.setDigit(2,6,i,true); 

       lc.setChar(1,7,'A',false);
       lc.setDigit(1,6,i+6,false);
       
      delay(delaytime*4);   
    }
    
      lc.clearDisplay(0);
      lc.clearDisplay(1);
      lc.clearDisplay(2);  
      delay(delaytime*5);   
  }


void loop() { 
   FLASH_LED();
  HELLO_AGC();
//  writeArduinoOn7Segment();
  FLASH_LED();
  delay(delaytime);
//  delay(delaytime);
  FLASH_LED();
  scrollDigits();
     
  AllDigits();
    delay(delaytime);
    
  setLEDs();
      delay(delaytime);  
  AllBalls();
    delay(delaytime);
}
