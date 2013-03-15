boolean shouldDraw;
int centerX,centerY;
float x,y;
float bgR = 255,bgG = 204, bgB = 0;

void setup() {
size(500,500);
background(bgR, bgG, bgB);
strokeWeight(0.5); //finer line
stroke(random(20), random(50), random(70), 30);

smooth();
shouldDraw = true;
centerX = width/2;
centerY= height/2;
}

void draw() {

  if (shouldDraw) {
    for (int i = 0; i < 100; i++) { //100 circles
      float lastX = -999;
      float lastY = -999;
      float radiusNoise = random(10);
      float radius = random(50);
      
      //randomizes spiral aspects
      int startAngle = int(random(360));
      int endAngle = 1440 + int(random(1440));
      int angleStep = 5 + int(random(3));
      for(float ang = startAngle; ang <= endAngle; ang += angleStep) { //loop 4 times 
        strokeWeight(random(5));
        radiusNoise += 0.05;
        radius += 0.5;
        float thisRadius = radius + (noise(radiusNoise) * 200) - 150;
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
  }
  shouldDraw = false;
}

void keyPressed() {
 if (keyCode == ENTER || keyCode == RETURN) { //save frame
   saveFrame("circle-####.jpg");
   println("saved frame");
 }
  if (keyCode == UP) { //change background and draw
    bgR = random(255);
    bgG = random(255);
    bgB = random(255);
    background(bgR, bgG, bgB);
    shouldDraw = true;
  }
  if (keyCode == DOWN) { //change the stroke color and draw
    stroke(random(255), random(255), random(255), 30);
    shouldDraw = true;
  }
  if (keyCode == 39) { //right key; draw another iteration
    shouldDraw = true;
  }
  if (key == 'c') { //clear current canvas and draw
    background(bgR, bgG, bgB);
    shouldDraw = true;
  }
}

