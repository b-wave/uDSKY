/**
 * Apollo4 
 * by Steve Botts
 * 
 * 3D model used for visulization 
 * of INS roll , pitch and yaw angles. 
 * Command Module is a compound closed cylinder
 * Service Module is a closed Cylinder
 * Nozzel is a compound open cylinder (with no top or bottom)
 * mouse controls ROLL and YAW angle only to inspect model
 */
/**
 * Apollo Spacecraft. 
 * asm texture = asm01,jpg
 * . 
 */
 
int tubeRes = 100;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];
PImage SMimg;
PImage CMimg;
float dz =0;
float ZZ=0;
void setup() {
  size(720, 640, P3D);
  SMimg = loadImage("asm02.png");
  CMimg = loadImage("CM2d.JPG");
  
  float angle = 360.0 / tubeRes;
  for (int i = 0; i < tubeRes; ++i) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  noStroke();
  println(SMimg.width);
  println(SMimg.height);
}

void draw() {
  background(0);
  fill(0, 255, 0); //green numbers
  
 text("YAW = " + (mouseX), 0, 10, 0);
 text("ROLL = " + (mouseY), 0, 25, 0);
 text("DZ = " + dz, 0, 35, 0);
 //DSKY Display
 text("DSKY:", width-60, 10, 0);
 text("        00", width-60, 20, 0);  //prog 00
 text("16    65", width-60, 30, 0); // V16 N65
 text("=====", width-60, 40, 0);
 
 if (hour()<10) {
  text("+0000"+ hour(), width-60, 50, 0);  
 } else
 text("+000"+ hour(),width-60, 50, 0);
 
  if (minute()<10) {
  text("+0000"+ minute(), width-60, 60, 0);  
 } else
 text("+000"+ minute(), width-60, 60, 0);
 
  if (second()<10) {
  text("+0"+ second()+"000", width-60, 70, 0);  
 } else 
 text("+"+ second()+"000", width-60, 70, 0); 
 
 // text("+"+ second()+ "0"+ millis(), width-60, 60, 0);

 lights();
 directionalLight(255, 255, 255, 0, -1, 0);

  translate(width / 2, height / 2);

  rotateX(map(mouseY*1.5, 0, width, 0, PI));
  rotateZ(map(mouseX*1.5+dz, 0, height, 0, -PI));
 ZZ +=dz;
 //  rotateZ(map(mouseX*1.5+ZZ, 0, height, 0, -PI));
  rotateY(map(ZZ, 0, width, 0, PI));
  
  translate(0, -50, 0);
  
   //red z axis antenna
   stroke(255,0,0);
  strokeWeight(4);
  line(0,0,-103,0,0,103); 
  
  //blue y axis antenna
  stroke(0,0,255);
  strokeWeight(4);
  line(0,-135,0,0,0,0); 
  
  
    //green x axis antenna
   stroke(0,255,0);
  strokeWeight(4);
  line(103,0,0,-103,0,0); 

  translate(0, 50, 0);
  /*
  APOLLO SPACECRAFT MODEL
  */
 //Aft HIGH GAIN  antenna's mast
   stroke(155,155,155);
   strokeWeight(6);
   line(70,50,120,0,50,0); //Draw antenna mast

  //Draw Service Module (SM) 
   noStroke();  //draw solid shapes...
   //fill(205, 205, 205); //Aluminum Grey
   fill(66, 66, 66); //Aluminum Grey
      
   translate(0, -150, 0);
   
      drawTube(99.9,99.9, 200, 200); // Draw the service module (SM)
         translate(0, 100, 0);
         
      drawASM();  //wrap the details on the Service Module
 /****************************************************************** 
//Draw Command Module (CM) 
*******************************************************************/

   fill(188,188,188);  //bright color
   translate(0, -199, 0); 
   drawCylinder(21*1.5, 66*1.5, 70*1.5, 180); // Draw the command module (CM)
   
   translate(0, 65*1.5, 0);
   drawACM();
   translate(0, -65*1.5, 0); 
   
    translate(0, -7, 0);  
  //fill(220, 220, 220); //grey color
    fill(255, 215, 0); // gold color
    drawTube(15, 15, 8, 100);//draw LM docking tunnel
    fill(255, 0, 0); // red color 
      drawTube(16, 16, 2, 100);//draw LM docking target
      drawTube(14, 14, 1, 100);      
    translate(0, -8, 0); 
       fill(222, 222, 222); //grey color 
//    noFill();
//    stroke(255, 210, 0);
//    drawTube(3, 8, 16, 6); //draw LM docking probe  
    drawTube(0, 10, 20, 20); //draw LM docking probe  
    translate(0, 10, 0);  
//    noStroke(); 


//Draw Service Propulsion System (SPS) Main Engine 
    translate(0, 300, 0); //Move AFT
    fill(220, 220, 212); //grey color 
    drawCap(100,0,24);
    
 //SPS engine heatshield   
    fill(180, 180, 180);
//  fill(255, 215, 0); // gold color looks like foil?
    drawCylinder(69*1.2, 52*1.2, 33*1.2, 9); // Draw the SPS engine's heatshield
    translate(0, 35, 0);
    
//SPS Nozzle       
  fill(62, 50, 50);
    
    drawTube(20, 40, 60, 13); // Draw the upper SPS engine's nozzle
    translate(0, 60, 0); //Move AFT     
  
    fill(72, 70, 80);
    drawTube(40, 60, 60, 13); // Draw the lower SPS engine's nozzle
    
//High gain antenna
   fill(255, 215, 0); // gold color 
   translate(67, -85, 115);
   drawTube(3, 24, 9, 8); //draw HIGH GAIN antenna dish
     //HIGH GAIN Antenna's feedhorn
    stroke(255, 215, 0); //Gold 
    strokeWeight(2);
    line(0,-10,0,0,24,0);  //Draw antenna feedhorn 

}

/******************************************************
*  Shape Drawing functions
******************************************************/

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  beginShape(QUAD_STRIP);
    texture(SMimg);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();
  
  // If it is not a cone, draw the circular top cap
  if (topRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);
    
    // Center point
    vertex(0, 0, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }

  // If it is not a cone, draw the circular bottom cap
  if (bottomRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, tall, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  
  }
  
  }
  
  //draw nozzle does not have endcaps!
void drawTube(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape(); 
}
void drawASM(){
 beginShape(QUAD_STRIP);
  texture(SMimg);
  for (int i = 0; i < tubeRes; ++i) {
    float x = tubeX[i] * 100;
    float z = tubeY[i] * 100;
    float u = SMimg.width / tubeRes * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, SMimg.height);
  }
  endShape(); 
}
void drawACM(){
  // Draw CM Exterior details
  
  beginShape(QUAD_STRIP);
  texture(CMimg);
  for (int i = 0; i < tubeRes; ++i) {
    float x = tubeX[i] * 100;
    float z = tubeY[i] * 100;
    float u = CMimg.width / tubeRes * i;
    vertex(x, 0, z, u, 0);
    vertex(x*.30, -100, z*.30, u, CMimg.height);
  }
  endShape();
}



 




void drawCap( float bottomRadius, float tall, int sides) {
      float angle = 0;
  float angleIncrement = TWO_PI / sides;
  angle = 0;
    beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, tall, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();

  
  // Print values to console
    print("Roll=" + hex(mouseX) +dz);

    print(" Yaw=" + hex(mouseY));
    println(" Pitch=" + hex(0));

}
void keyPressed()
{ 
    if (key == 'a')     dz +=.1;
    if (key == 'd')     dz -=.1;
    if (key == 'A')     dz +=1;
    if (key == 'D')     dz -=1;
        if ((key == 's' ) || (key == 'S'))     dz =0;

}
/*
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println("Wheel= " + e);

*/