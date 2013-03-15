ArrayList flares;

void setup() {
  size(500,500); 
  background(126);
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
 return new Flare(newX, newY, newRadius, newWeight);
}
