float xNoise;
float yNoise;
float cNoise;
float sWeight;
float sNoise;
float colorStep = 0.001;
int lastX, lastX2, lastY,lastY2;
int c,lowColor,highColor;
boolean flip = true;
public void setup(){ 
  frameRate(24);
  size(800,800); 
  background(0);
  xNoise = random(width);
  yNoise = random(height);
  strokeWeight(2);
  stroke(255);
  lastX = -1;
  lastY = -1;
  cNoise = 0;
  sNoise = 0;
  lowColor = 50;
  highColor = 255;
} 
 
public void draw(){
	xNoise += 0.1;
	yNoise += 0.1;
	sNoise += 0.1;
	sWeight = noise(sNoise) * 10;
  int x = int(noise(xNoise) * (width*1.25));
  int y = int(noise(yNoise) * (height*1.25));
	c = lerpColor(lowColor,highColor,colorStep);
	if (flip) {
		
		colorStep += 0.001;
		if (colorStep >= 1.0)
			flip = false;
	} else {
		colorStep -= 0.001;
		if (colorStep <= 0.0)
			flip = true;
	}
  	
  	
  int x2 = width - x;
  int y2 = height - y; 
  strokeWeight(sWeight);
  stroke(c);
  
  
  /*
  color c = get(x,y);
  color display;
  if(c == -16777216)
  	display = color(255);
  else 
  	display = color(0);
  set(x,y,display);
  set(x2,y, display);
  set(x2,y2,display);
  set(x,y2, display);
  */
   	
  point(x,y);
  point(x2,y);
  point(x2,y2);
  point(x,y2);
  
  lastX = x;
  lastY = y;
  lastX2 = x2;
  lastY2 = y2;
  
} 
  
void keyPressed() {
 if (keyCode == ENTER) {
   saveFrame("noiseyMirrors-####.png");
 } 
 
 if (key == 'c') {
   background(0);
   colorStep = 0.001;
 }
}
