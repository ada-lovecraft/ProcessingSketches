float radius;
int centerX;
int centerY;
float x1,y1,x2,y2;
float noiseValue = random(10); //randomizes noise start point
float radVariance,thisRadius,rad,oppRad;
float angle = 0;
float angleStep = 1;
  
void setup() {
  size(1024,1024); 
  background(0);
  strokeWeight(5);
  smooth();
 
  noFill();
  frameRate(30);
  //ellipse(centerX, centerY, radius*2, radius*2);
  
  stroke(#ffffff,10);
  strokeWeight(1);
  radius = width/2;
  centerX = width/2;
  centerY = height/2;
}
  
void draw() {
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
    line(x1,y1,x2,y2);   
    angle += angleStep; 
  }
  else {
    angleStep = random(5);
    angle = 0;
    stroke(#ffffff,random(10));
  }
}



