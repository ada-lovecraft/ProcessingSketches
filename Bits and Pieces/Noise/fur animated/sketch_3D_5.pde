

float xstart, xnoise,ystart,ynoise;
float xStartNoise, yStartNoise;

void setup() {

  size(400,400);
  smooth();
  background(0);
  frameRate(24);
  xStartNoise = random(20);
  yStartNoise = random(20);
  xstart = random(10);
  ystart = random(10);
}

void draw() {
 background(0);
 xStartNoise += 0.01;
 yStartNoise += 0.01;
 xstart += (noise(xStartNoise * 0.5) - 0.25); //varies by +/- 0.25 every frame
 xstart += (noise(yStartNoise * 0.5) - 0.25);
  xnoise = xstart;
  ynoise = ystart;
  for (int y = 0; y <= height; y+=5) {
    ynoise += 0.1;
    xnoise = xstart;//reset xnoise at the start of each row
    for (int x = 0; x <= width; x +=5) {
      xnoise += 0.1;
      drawPoint(x,y,noise(xnoise,ynoise));
    }
  }
}
  

void drawPoint(float x, float y, float noiseFactor) {
 pushMatrix();
 translate(x,y);
 rotate(noiseFactor * radians(360));
 float edgeSize = noiseFactor * 35;
 stroke(255,150);
 line(0,0,20,0);
 popMatrix();
}
