import processing.serial.*;
Serial myPort;

float yaw = 0.0;
float pitch = 0.0;
float roll = 0.0;

int ptsW, ptsH, mx;

PImage img;

int numPointsW;
int numPointsH_2pi; 
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;
void setup()
{
  size(360, 360, P3D);
  background(0);
  noStroke();
 // img=loadImage("eightball_texture_c_l.png"); //
 img=loadImage("fadi_texture_sb.png");//need to fix background on 300 and 330
  ptsW=130;
  ptsH=130;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);

  // if you have only ONE serial port active
  //myPort = new Serial(this, Serial.list()[0], 9600); // if you have only ONE serial port active

  // if you know the serial port name
  //myPort = new Serial(this, "COM5:", 9600);        // Windows "COM#:"
  myPort = new Serial(this, "\\\\.\\COM10",9600); // Windows, COM10 or higher
  //myPort = new Serial(this, "/dev/ttyACM0", 9600);   // Linux "/dev/ttyACM#"
  //myPort = new Serial(this, "/dev/cu.usbmodem1217321", 9600);  // Mac "/dev/cu.usbmodem######"

  textSize(12); // set text size
 // textMode(SHAPE); // set text mode to shape
   textMode(MODEL); // set text mode to shape
}

void draw()
{
//  serialEvent();  // read and parse incoming serial message
  background(5); // set background to white
  lights();
fill(0,255,0);


 text("Yaw= "+ round(yaw), 0, 10, 0);
 text("Pitch = " + round(pitch), 0, 25, 0);
 text("Roll = " + round(roll), 0, 40, 0); 
  if( abs(pitch)>70) {
  fill(255,0,0);  
    text("CAGE WRN", 250, 25, 0);
   
  }
 fill(255);  
 noFill();
/***********************************
* DRAW  CROSS-HAIRS
***********************************/

stroke(255,0,0); //red
strokeWeight(1.5); 
//stroke(40); //grey
line( 0, height/2, width, height/2 ); //Horizontal hold line
//line(  width/2, 0, width/2, height ); //vertical cross line
line(  width/2, height/2, width/2, height ); //vertical hold line

/***********************************
* DRAW flying wing horiz. indicator
***********************************/
stroke(0,255,0); //make it green
strokeWeight(5); 
strokeCap(ROUND);
noFill();
beginShape(LINES);  

vertex(width/2-60, height/2);  //+1/2 Horizontal wing line
vertex(width/2-15, height/2 );


vertex(width/2+15, height/2);  //-1/2 Horizontal wing line
vertex(width/2+60, height/2  );

endShape();
arc(width/2, height/2, 30, 30, 0, PI);
noStroke();
/**/


  serialEvent();  // read and parse incoming serial message

noStroke();
/**/
  translate(width/2, height/2, -200); // set position to CENTER and back a bit

  pushMatrix(); // begin object

  float c1 = cos(radians(roll));
  float s1 = sin(radians(roll));
  float c2 = cos(radians(-pitch));
  float s2 = sin(radians(-pitch));
  float c3 = cos(radians(yaw));
  float s3 = sin(radians(yaw));
  applyMatrix( c2*c3, s1*s3+c1*c3*s2, c3*s1*s2-c1*s3, 0,
               -s2, c1*c2, c2*s1, 0,
               c2*s3, c1*s2*s3-c3*s1, c1*c3+s1*s2*s3, 0,
               0, 0, 0, 1);

  //drawPropShield();
 // drawApollo();
  textureSphere(200, 200, 200, img);
  popMatrix(); // end of object

  // Print values to console
  print(roll);
  print("\t");
  print(-pitch);
  print("\t");
  print(yaw);
   if( abs(pitch)>75) {
     print("\t");
     print("CAGE WARNING!");
   }
  println();
  

}

void serialEvent()
{
  int newLine = 13; // new line character in ASCII
  String message;
  do {
    message = myPort.readStringUntil(newLine); // read from port until new line
    if (message != null) {
      String[] list = split(trim(message), " ");
      if (list.length >= 4 && list[0].equals("Orientation:")) {
        yaw = float(list[1]); // convert to float yaw
        pitch = float(list[2]); // convert to float pitch
        roll = float(list[3]); // convert to float roll
      }
    }
  } while (message != null);
}

/******************************************/
void initializeSphere(int numPtsW, int numPtsH_2pi) {

  // The number of points around the width and height
  numPointsW=numPtsW+1;
  numPointsH_2pi=numPtsH_2pi;  // How many actual pts around the sphere (not just from top to bottom)
  numPointsH=ceil((float)numPointsH_2pi/2)+1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)

  coorX=new float[numPointsW];   // All the x-coor in a horizontal circle radius 1
  coorY=new float[numPointsH];   // All the y-coor in a vertical circle radius 1
  coorZ=new float[numPointsW];   // All the z-coor in a horizontal circle radius 1
  multXZ=new float[numPointsH];  // The radius of each horizontal circle (that you will multiply with coorX and coorZ)

  for (int i=0; i<numPointsW ;i++) {  // For all the points around the width
    float thetaW=i*2*PI/(numPointsW-1);
    coorX[i]=sin(thetaW);
    coorZ[i]=cos(thetaW);
  }
  
  for (int i=0; i<numPointsH; i++) {  // For all points from top to bottom
    if (int(numPointsH_2pi/2) != (float)numPointsH_2pi/2 && i==numPointsH-1) {  // If the numPointsH_2pi is odd and it is at the last pt
      float thetaH=(i-1)*2*PI/(numPointsH_2pi);
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=0;
    } 
    else {
      //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
      float thetaH=i*2*PI/(numPointsH_2pi);

      //PI+ below makes the top always the point instead of the bottom.
      coorY[i]=cos(PI+thetaH); 
      multXZ[i]=sin(thetaH);
    }
  }
}

void textureSphere(float rx, float ry, float rz, PImage t) { 
  // These are so we can map certain parts of the image on to the shape 
  float changeU=t.width/(float)(numPointsW-1); 
  float changeV=t.height/(float)(numPointsH-1); 
  float u=0;  // Width variable for the texture
  float v=0;  // Height variable for the texture

  beginShape(TRIANGLE_STRIP);
  texture(t);
  for (int i=0; i<(numPointsH-1); i++) {  // For all the rings but top and bottom
    // Goes into the array here instead of loop to save time
    float coory=coorY[i];
    float cooryPlus=coorY[i+1];

    float multxz=multXZ[i];
    float multxzPlus=multXZ[i+1];

    for (int j=0; j<numPointsW; j++) { // For all the pts in the ring
      normal(-coorX[j]*multxz, -coory, -coorZ[j]*multxz);
      vertex(coorX[j]*multxz*rx, coory*ry, coorZ[j]*multxz*rz, u, v);
      normal(-coorX[j]*multxzPlus, -cooryPlus, -coorZ[j]*multxzPlus);
      vertex(coorX[j]*multxzPlus*rx, cooryPlus*ry, coorZ[j]*multxzPlus*rz, u, v+changeV);
      u+=changeU;
    }
    v+=changeV;
    u=0;
  }
  endShape();
}