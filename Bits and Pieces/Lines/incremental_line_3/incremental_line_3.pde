//setup
size(500,100);
background(255);
strokeWeight(5);
smooth();
stroke(0,30);
line(20,50,480,50);

//initialization
int step = 10;
float xstep = 10;
float ystep = 10;
float lastx = 20;
float lasty = 50;
float y = 50;
stroke(20,50,70);

for (int x = 20; x <= 480; x += xstep) {
  ystep = random(20) - 10; //range -10 to 10
  y += ystep;
  line(x,y, lastx, lasty);
  lastx = x;
  lasty = y;
}

