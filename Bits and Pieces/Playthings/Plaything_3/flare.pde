class Flare {
  float centerX;
  float centerY;
  float x1,y1,x2,y2;
  float noiseValue = random(10); //randomizes noise start point
  float radVariance,thisRadius,rad,oppRad;
  float angle = 0;
  float angleStep = 1;
  float strokeAlpha = 250; 
  int flareTint; 
  float radius;
  float weight;
  int segments = 50;
  
  Flare(float _x, float _y, float _radius, float _weight, int _tint) { //constructor
    centerX = _x;
    centerY = _y;
    radius = _radius;
    flareTint = _tint;
    weight = _weight;
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
      x2 = centerX + (thisRadius * cos(oppRad));
      y2 = centerY + (thisRadius *sin(oppRad));
     
      strokeWeight(weight/2);
      
      float alphaStep = strokeAlpha/segments;
      float newAlpha;
      float newX, newY, fraction;
      float lastX = x1;
      float lastY = y1;
      /*
      strokeWeight(weight/2);
      stroke(flareTint,strokeAlpha);
      line(x1,y1,x2,y2);
      strokeWeight(weight);
      stroke(#ffffff,strokeAlpha);
      line(x1,y1,x2,y2);
      */
      
      
      for (int i = 0; i < segments; i++) {
        fraction = i / segments;
        newAlpha = strokeAlpha - (alphaStep*i);
        newX = lerp(x1,x2, fraction);
        newY = lerp(y1,y2,fraction);
        strokeWeight(weight);
        stroke(flareTint,strokeAlpha);
        line(lastX,lastY,newX,newY);
        lastX = newX;
        lastY = newY;      
      }   
     
      angle += angleStep; 
    }
   else {
      angleStep = random(4)+1;
      angle = 0;
      //strokeAlpha = random(3)+1;
    } 
  }
}
