
//WARNING not working
void setup() {
   Serial.begin(9600);
}

void loop() {
  // Assumes a string in from the serial port like so:
  // s ledNumber, brightness \n
  // for example: "s5,200\n":

  static char PNumber[2];
  static char Verb[2];
  static char Noun[2];
    static char R1[6];
 
  if (Serial.find("p")) {
    Serial.readBytes(PNumber, 2) ; // parses Prog
      // print the results back to the sender:
  }

  if (Serial.find("v")) {
    Serial.readBytes(Verb, 2) ; // parses Verb 
  }
    if (Serial.find("n")) {
    Serial.readBytes(Noun, 2) ; // parses Noun 
  }
    if (Serial.find("r")) {
    Serial.readBytes(R1, 6) ; // parses R1 
  }
    Serial.print("V: " ); 
    Serial.print(Verb ); 
    Serial.print(" N: " ); 
    Serial.print(Noun ); 
    Serial.print(" P: " );
    Serial.println(PNumber);
    Serial.print(" R1: " );
    Serial.println(R1);
}
