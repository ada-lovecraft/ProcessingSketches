ArrayList flares;

void setup() {
  size(800,800); 
  background(0);
  smooth();
 
  noFill();
  frameRate(30);
  //ellipse(centerX, centerY, radius*2, radius*2);
  flares = new ArrayList();
  flares.add(generateFlare(random(width), random(height)));
}
  
void draw() {
  for(int i=0; i < flares.size(); i++) {
    Flare flare = (Flare) flares.get(i);
    flare.update();
  }
}


void mousePressed() {
  flares.add(generateFlare(mouseX,mouseY));
}

Flare generateFlare(float newX, float newY) {
    float newRadius = random(width/2);
  float newWeight = random(2);
  color blueFrom = #00ffea;
  color blueTo = #0006ff;
  float blueAmount = random(1);
  color blueLerp = lerpColor(blueFrom, blueTo, blueAmount);
  color redFrom = #ff0000;
  color redTo = #fffc00;
  float redAmount = random(1);
  color redLerp = lerpColor(redFrom, redTo, redAmount);
  float flareAmount = random(1);
  color flareColor = lerpColor(redLerp,blueLerp,flareAmount);
 return new Flare(newX, newY, newRadius, newWeight,flareColor);
}
