import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class NoiseyMirrors extends PApplet {

float xNoise;
float yNoise;
float cNoise;
float sWeight;
float sNoise;
float colorStep = 0.001f;
int lastX, lastX2, lastY,lastY2;
int c,lowColor,highColor;
boolean flip = true;
public void setup(){ 
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
	xNoise += 0.1f;
	yNoise += 0.1f;
	sNoise += 0.1f;
	sWeight = noise(sNoise) * 10;
  int x = PApplet.parseInt(noise(xNoise) * (width*1.25f));
  int y = PApplet.parseInt(noise(yNoise) * (height*1.25f));
	c = lerpColor(lowColor,highColor,colorStep);
	if (flip) {
		
		colorStep += 0.001f;
		if (colorStep >= 1.0f)
			flip = false;
	} else {
		colorStep -= 0.001f;
		if (colorStep <= 0.0f)
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
  
public void keyPressed() {
 if (keyCode == ENTER) {
   saveFrame("noiseyMirrors-####.png");
 } 
 
 if (key == 'c') {
   background(0);
   colorStep = 0.001f;
 }
}

    static public void main(String args[]) {
        PApplet.main(new String[] { "--bgcolor=#ECE9D8", "NoiseyMirrors" });
    }
}
