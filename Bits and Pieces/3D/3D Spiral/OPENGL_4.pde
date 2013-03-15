import processing.opengl.*;

int radius = 100;

void setup() {
  size(500,300,OPENGL);
  background(255);
  frameRate(24);
  stroke(0);
}

void draw() {
  background(255);
  frame.setTitle(int(frameRate) + " fps");

  translate(width/2, height/2,0);
  rotateY(frameCount * 0.03);
  rotateX(frameCount * 0.04);
  rotateZ(frameCount * 0.03);
  
  float s = 0;
  float t = 0;
  float lastX = 0;
  float lastY = 0;
  float lastZ = 0;
  while (t <180) {
   s += 1;
   t += 1;
   float radianS = radians(s);
   float radianT = radians(t);
   
   float thisX = 0 + (radius * cos(radianS) * sin(radianT));
   float thisY = 0 + (radius * sin(radianS) * sin(radianT));
   float thisZ = 0 + (radius * cos(radianT));
   
   if (lastX != 0)
   {
     line(thisX,thisY,thisZ,lastX,lastY,lastZ);
   }
   lastX = thisX;
   lastY = thisY;
   lastZ = thisZ;
  }
}
