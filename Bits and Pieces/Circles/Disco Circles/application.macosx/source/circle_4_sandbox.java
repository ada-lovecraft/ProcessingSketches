import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

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

public class circle_4_sandbox extends PApplet {

boolean shouldDraw;
int centerX,centerY;
float x,y;
float bgR = 255,bgG = 204, bgB = 0;

public void setup() {
size(500,500);
background(bgR, bgG, bgB);
strokeWeight(0.5f); //finer line
stroke(random(20), random(50), random(70), 30);

smooth();
shouldDraw = true;
centerX = width/2;
centerY= height/2;
}

public void draw() {

  if (shouldDraw) {
    for (int i = 0; i < 100; i++) { //100 circles
      float lastX = -999;
      float lastY = -999;
      float radiusNoise = random(10);
      float radius = random(50);
      
      //randomizes spiral aspects
      int startAngle = PApplet.parseInt(random(360));
      int endAngle = 1440 + PApplet.parseInt(random(1440));
      int angleStep = 5 + PApplet.parseInt(random(3));
      for(float ang = startAngle; ang <= endAngle; ang += angleStep) { //loop 4 times 
        strokeWeight(random(5));
        radiusNoise += 0.05f;
        radius += 0.5f;
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

public void keyPressed() {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_4_sandbox" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
