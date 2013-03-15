import processing.opengl.*;
float xnoise, xstart, ynoise, ystart,zstart,znoise;

int sideLength = 200;
int spacing = 5;

void setup() {
  size(500,300,OPENGL);
  noStroke();

  xstart = random(10);
  ystart = random(10);
  zstart = random(10);
}

void draw() {
print(int(frameRate) + " fps");

  background(0);
  xstart += 0.01;
  ystart += 0.01;
  zstart += 0.01;
  
  xnoise = xstart;
  ynoise = ystart;
  znoise = zstart;
  
  translate(150,20,-150);
  rotateZ(frameCount * 0.1);
  rotateY(frameCount * 0.1);
  
  
  for(int z = 0; z <= sideLength; z += spacing) {
    znoise += 0.1;
    ynoise = ystart;
    for(int y = 0; y <= height; y+=spacing) {
      ynoise += 0.1;
      xnoise = xstart;
      for (int x = 0; x <= width; x+=spacing) {
        xnoise += 0.1;
        drawPoint(x,y,z,noise(xnoise,ynoise,znoise));
      }
    }
  }
}

void drawPoint(float x, float y, float z,float noiseFactor) {
  pushMatrix();
  translate(x,y,z);
  float grey = 255*noiseFactor;
  fill(grey, 10);
  box(spacing,spacing,spacing);
  popMatrix();
}

