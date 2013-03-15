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
    float newRadius = width;
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
class Flare {
  float centerX;
  float centerY;
  float x1,y1,x2,y2;
  float noiseValue = random(10); //randomizes noise start point
  float radVariance,thisRadius,rad,oppRad;
  float angle = 0;
  float angleStep = 1;
  float strokeAlpha = 10; 
  color flareTint; 
  float radius;
  float weight;
  
  Flare(float _x, float _y, float _radius, float _weight, color _tint) { //constructor
    centerX = _x;
    centerY = _y;
    radius = _radius;
    flareTint = _tint;
    weight = _weight;
  }
  
  void update() {
    if (angle <= 180) {
      noiseValue += 0.1;
      radVariance = 30 * noise(noiseValue);
      
      thisRadius = radius + radVariance;
      rad = radians(angle);
      oppRad = rad + PI;
      x1 = centerX + (thisRadius * cos(rad));
      y1 = centerY + (thisRadius * sin(rad));
      x2 = centerX + (thisRadius * cos(oppRad));
      y2 = centerY + (thisRadius *sin(oppRad));
     
      strokeWeight(weight/2);
      stroke(flareTint,strokeAlpha);
      line(x1,y1,x2,y2);   
      strokeWeight(1);
      stroke(#ffffff,strokeAlpha);
      line(x1,y1,x2,y2);   
      angle += angleStep; 
    }
   else {
      angleStep = random(4)+1;
      angle = 0;
      strokeAlpha = random(3)+1;
      stroke(#ffffff,strokeAlpha);
    } 
  }
}

