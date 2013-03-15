class Flare {
  float centerX;
  float centerY;
  float x1,y1,x2,y2;
  float noiseValue = random(10); //randomizes noise start point
  float radVarianceSeed = random(100);
  float radVariance,thisRadius,rad,oppRad;
  float angle = 0;
  float angleStep = random(10);
  float strokeAlpha = 250; 
  float startingAngle = random(360);
  int flareTint; 
  float radius;
  float weight;
  int segments = 50;
  color blueFrom = #00ffea;
  color blueTo = #0006ff;
  color redFrom = #ff0000;
  color redTo = #ffc000;
  color blueBase, redBase, flareBase;
  
  Flare(float _x, float _y, float _radius, float _weight) { //constructor
    centerX = _x;
    centerY = _y;
    radius = _radius;

    weight = _weight;
    blueBase = generateColor(blueFrom,blueTo);
    redBase = generateColor(redFrom, blueFrom);
    flareBase = generateColor(blueBase,redBase);
    flareTint = flareBase;
  }
  
  void update() {
    if (angle <= 360) {
      noiseValue += random(1);
      radVariance = (random(radVarianceSeed)+radVarianceSeed) * noise(noiseValue);
      if (angle + startingAngle > 360)
      {
        startingAngle -= 360;
      }
      thisRadius = radius + radVariance;
      rad = radians(angle+startingAngle);
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
      
      /*
      for (int i = 0; i < segments; i++) {
        fraction = i / segments;
        newAlpha = strokeAlpha - (alphaStep*i);
        newX = lerp(x1,x2, fraction);
        newY = lerp(y1,y2,fraction);
        strokeWeight(weight);
        stroke(flareTint,strokeAlpha);
        point(newX,newY);
        lastX = newX;
        lastY = newY;      
      }   */
     
      strokeWeight(weight);
      stroke(flareTint,strokeAlpha);
      point(x2,y2);
      angle += angleStep; 
    }
   else {
      angleStep = random(4)+1;
      angle = 0;
      //strokeAlpha = random(3)+1;
      flareTint = generateColor(redBase,blueBase);
    } 
  }
  
  color generateColor(color from, color to) {
    float amount = random(1);
    return lerpColor(from,to,amount);
  }
}
