size(500,300);
background(255);
strokeWeight(5);
smooth();

float radius = 10;
int centerX = 250;
int centerY = 150;

stroke(0,30);
noFill();
ellipse(centerX,centerY, radius*2, radius*2);
stroke(20,50,70);

float x,y;
float lastx = -999;
float lasty = -999;
for(float ang = 0; ang <= 1440; ang += 5) { //loop 4 times 
  radius += 0.5;
  float rad = radians(ang);
  x = centerX + (radius * cos(rad) );
  y = centerY + (radius * sin(rad) );
  if (lastx > -999) {
    line(x,y,lastx,lasty);
  }
  lastx += x;
  lasty = y;
}

