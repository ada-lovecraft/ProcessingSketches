void setup() {
  size(500,300); 
  background(255);
  strokeWeight(5);
  smooth();
  
  float radius = 100;
  int centerX = 250;
  int centerY = 150;
  
  stroke(0,30);
  noFill();
  ellipse(centerX, centerY, radius*2, radius*2);
  
  stroke(20,50,70);
  strokeWeight(1);
  
  float x,y;
  float noiseValue = random(10); //randomizes noise start point
  float radVariance,thisRadius,rad;
  
  beginShape();
  fill(20,50,70,50);
  for(float ang = 0; ang <= 360; ang += 1) {
    
    noiseValue += 0.1;
    radVariance = 30 * customNoise(noiseValue);
    
    thisRadius = radius + radVariance;
    rad = radians(ang);
    x = centerX + (thisRadius * cos(rad));
    y = centerY + (thisRadius * sin(rad));
    
    curveVertex(x,y);
  }
  
  endShape();
}

float customNoise(float value) { //returns -1 to 1
 float retValue = pow(sin(value),3);
  return retValue; 
}

