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
    float newRadius = random(width/10);
  //float newWeight = random(2);
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
 return new Flare(newX, newY, newRadius, .5,flareColor);
}
class Flare {
  float centerX;
  float centerY;
  float x1,y1,x2,y2;
  float noiseValue = random(10); //randomizes noise start point
  float radVariance,thisRadius,rad,oppRad;
  float angle = 0;
  float angleStep = 2;
  float strokeAlpha = 100; 
  int flareTint; 
  float radius;
  float weight;
  int segments = 50;
  float anamorphMultiplier;
  
  Flare(float _x, float _y, float _radius, float _weight, int _tint) { //constructor
    centerX = _x;
    centerY = _y;
    radius = _radius;
    flareTint = _tint;
    weight = _weight;
    anamorphMultiplier = random(4)+3;
    
  }
  
  void update() {
    if (angle <= 360) {
      noiseValue += 0.1;
      radVariance = 30 * noise(noiseValue);
      thisRadius = radius + radVariance;
      rad = radians(angle);
      oppRad = rad + PI;
      x1 = centerX + (thisRadius * cos(rad));
      y1 = centerY + (thisRadius * sin(rad));
     
     
      strokeWeight(weight/2);
      
      float alphaStep = strokeAlpha/segments;
      float newAlpha;
      float newX, newY, fraction;
      float lastX = centerX;
      float lastY = centerY;
      /*
      strokeWeight(weight/2);
      stroke(flareTint,strokeAlpha);
      line(x1,y1,x2,y2);
      strokeWeight(weight);
      stroke(#ffffff,strokeAlpha);
      line(x1,y1,x2,y2);
      */
      
      int newTint;
      float colorFraction;
      for (int i = 0; i < segments; i++) {
        colorFraction = float(i) / segments;
        fraction = float(i) / segments;
        newTint = lerpColor(#ffffff,flareTint,colorFraction);
        newAlpha = strokeAlpha - (alphaStep*i);
        newX = lerp(centerX,x1,fraction);
        newY = lerp(centerY,y1,fraction);
        strokeWeight(weight);
        stroke(newTint,newAlpha);
        line(lastX,lastY,newX,newY);
        lastX = newX;
        lastY = newY;      
      }   
     
      angle += angleStep; 
    }
   else {
      noiseValue += 0.1;
      angleStep = random(1)+1;
      angle = 0;
      float n = noise(noiseValue);
      radius += (1/n);
      drawAnamorph();
      //strokeAlpha = random(3)+1;
    } 
  }
  
  
  void drawAnamorph() {    
    int newTint;    
    float alphaStep = strokeAlpha/segments;
    float alphaMultiplier = segments / (2*PI*radius);
    float lastLeftX = centerX, lastRightX = centerX, colorFraction, fraction, newAlpha = 0, newLeftX,newRightX;
    strokeWeight(weight);
    float leftFinalX = centerX - (radius*anamorphMultiplier);
    float rightFinalX = centerX + (radius*anamorphMultiplier );
    float weightMultiplier = ((rightFinalX - leftFinalX) / radius) / 4;
    for (int i = 0; i <= segments; i++) {

        fraction = float(i+1) / segments;
        newTint = lerpColor(#ffffff,flareTint,fraction);
        newAlpha = (255 - ((255/segments)*i)) * alphaMultiplier;
        newLeftX = lerp(centerX,leftFinalX,fraction);
        newRightX = lerp(centerX,rightFinalX,fraction);
        strokeWeight(weight * anamorphMultiplier);
        stroke(newTint,newAlpha);
        line(lastLeftX,centerY,newLeftX,centerY);
        line(lastRightX,centerY,newRightX,centerY);
        lastLeftX = newLeftX;
        lastRightX = newRightX;
      }   
  }
}

