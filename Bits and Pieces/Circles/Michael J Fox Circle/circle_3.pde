size(500,300);
background(255);
strokeWeight(5);
smooth();

int centerX = 250;
int centerY = 150;
float radius = 100;

stroke(0,30);
noFill();
ellipse(centerX,centerY, radius*2, radius*2);
stroke(20,50,70);

radius = 10;
float x,y;
float lastx = -999;
float lasty = -999;
float radiusNoise = random(10);

for(float ang = 0; ang <= 1440; ang += 5) { //loop 4 times 
  radiusNoise += 0.05;
  radius += 0.5;
  float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
  float rad = radians(ang);
  x = centerX + (thisRadius * cos(rad) );
  y = centerY + (thisRadius * sin(rad) );
  if (lastx > -999) {
    line(x,y,lastx,lasty);
  }
  lastx = x;
  lasty = y;
}
