size(500,300);
background(255);
strokeWeight(0.5); //finer line
smooth();

int centerX = 250;
int centerY = 150;


float x,y;
for (int i = 0; i < 100; i++) { //100 circles
  float lastX = -999;
  float lastY = -999;
  float radiusNoise = random(10);
  float radius = 10;
  stroke(random(20), random(50), random(70), 80);
  
  //randomizes spiral aspects
  int startAngle = int(random(360));
  int endAngle = 1440 + int(random(1440));
  int angleStep = 5 + int(random(3));
  for(float ang = startAngle; ang <= endAngle; ang += angleStep) { //loop 4 times 
    radiusNoise += 0.05;
    radius += 0.5;
    float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
    float rad = radians(ang);
    x = centerX + (thisRadius * cos(rad) );
    y = centerY + (thisRadius * sin(rad) );
    if (lastX > -999) {
      line(x,y,lastX,lastY);
    }
    lastX = x;
    lastY = y;
  }
}
