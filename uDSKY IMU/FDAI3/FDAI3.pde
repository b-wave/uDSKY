/**
 * Apollo Flight Direction Attitude Indicator 
 * (FDAI) Simulator for sensor display test
 * by Steve Botts
 * 
 * Based on 3D textured sphere by Gillian Ramsay 
 */

int ptsW, ptsH, mx;

PImage img;

int numPointsW;
int numPointsH_2pi; 
int numPointsH;

float[] coorX;
float[] coorY;
float[] coorZ;
float[] multXZ;

void setup() {
  size(360, 360, P3D);
  background(0);
  noStroke();
  img=loadImage("eightball_texture_c_l.png");
  ptsW=130;
  ptsH=130;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);

}
/*
// Use arrow keys to change detail settings
void keyPressed() {
  if (keyCode == ENTER) saveFrame();
  if (keyCode == UP) ptsH++;
  if (keyCode == DOWN) ptsH--;
  if (keyCode == LEFT) ptsW--;
  if (keyCode == RIGHT) ptsW++;
  if (ptsW == 0) ptsW = 1;
  if (ptsH == 0) ptsH = 2;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);

}
*/
void draw() {
  background(0);
  lights();
// directionalLight(255, 255, 255, 0, 1, 0); 
 mx = mouseX-180;
 if (mx<0) mx = mx+360;
 text("AZ = " + mx, 0, 10, 0);
 text("EL = " + (-mouseY/2+90), 0, 25, 0);
  if( abs((-mouseY/2+90))>75) text("CAGE WRN", 0, 40, 0);
 noFill();
/**/

/***********************************
* DRAW  CROSS-HAIRS
***********************************/

stroke(255,0,0); //red
strokeWeight(1.5); 
//stroke(40); //grey
line( 0, height/2, width-40, height/2 ); //Horizontal hold line
//line(  width/2, 0, width/2, height ); //vertical cross line
line(  width/2, height/2, width/2, height ); //vertical hold line

/***********************************
* DRAW PITCH RATE METER
***********************************/

stroke(180); //grey meter bezel
strokeWeight(7); 
fill(255);
rect(width-35, height/3, 25, height/3, 3);
noFill();

strokeWeight(2.5);
stroke(10); //BLACK
//major ticks
for (int i = 10; i < 120; i = i+10) {
line(width-33, height/3+i, width-25, height/3+i);
}
//minor ticks
strokeWeight(2);
for (int i = 5; i < 120; i = i+10) {
line(width-33, height/3+i, width-28, height/3+i);
}
int dy = (pmouseY - mouseY);
//fill(255,0,0); //fill red
stroke(255,0,0); // red
triangle(width-22, height/2+dy, width-14, height/2+6+dy, width-14, height/2-6+dy);
noFill();
noStroke();


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
/*
vertex(width/2-15, height/2);  //+V wing line
vertex(width/2, height/2+15);

vertex(width/2, height/2+15); // -V wing line
vertex(width/2+15, height/2);
*/

vertex(width/2+15, height/2);  //-1/2 Horizontal wing line
vertex(width/2+60, height/2  );

endShape();
arc(width/2, height/2, 30, 30, 0, PI);
noStroke();
/**/

  translate(width/2, height/2, -200);
/* 
//draws a gray faceplate if needed...
  rectMode(RADIUS);  // Set rectMode to CENTER
  fill(80);  // Set fill to gray
  rect(width/65, height/30, 250, 250, 50);
*/


  /*
  camera(width/2+map(mouseX, 0, width, -2*width, 2*width), 
         height/2+map(mouseY, 0, height, -height, height),
         height/2/tan(PI*30.0 / 180.0), 
         width, height/2.0, 0, 
         0, 1, 0);
  */
  
 // rotateX(map(mouseY*4, 0, width, 0, PI));
 // rotateY(map(mouseX*2, 0, height, 0, -PI));
// rotateX(radians(-90));
//  rotateY(radians(0));
 /**/
  rotateX(map(mouseY, 0, width, radians(-90), radians(90)));
  rotateY(map(mouseX, 0, height, 0, radians(360)));
  /**/
  pushMatrix();
  textureSphere(200, 200, 200, img);
  popMatrix();
}

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