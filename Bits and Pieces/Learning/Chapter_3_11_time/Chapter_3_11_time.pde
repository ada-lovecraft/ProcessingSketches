PImage mapImage;
Table locationTable, nameTable;
int rowCount;

Table dataTable;
float dataMin = -10;
float dataMax = 10;
float closestDist;
String closestText;
float closestTextX;
float closestTextY;

Integrator[] interpolators;

void setup() {
  size(640,400);
  mapImage = loadImage("map.png");
  
  locationTable = new Table("locations.tsv");
  nameTable = new Table("names.tsv");
  dataTable = new Table("random.tsv");
  rowCount = locationTable.getRowCount();
  
  interpolators = new Integrator[rowCount];
  for (int row = 0; row < rowCount; row++) {
   float intialValue = dataTable.getFloat(row,1);
  interpolators[row] = new Integrator(intialValue); 
  }
  
  PFont font = loadFont("Futura-Medium-12.vlw");
  textFont(font);
  
  smooth();
  noStroke();
  frameRate(30);
}



void draw() {
  background(255);
  image(mapImage,0,0);
  
  //Draw: update the Integratorwith the current values
//which are either those from the setup() function
//or those those loaded byt the target() function
//issued in updateTable();
  
  for (int row= 0; row < rowCount; row++) {
    interpolators[row].update();
  }
  closestDist = MAX_FLOAT;
  for (int row = 0; row < rowCount; row++ ) {
    String abbrev = dataTable.getRowName(row);
    float x = locationTable.getFloat(row,1); // column 1;
    float y = locationTable.getFloat(row,2); //column 2;
    drawData(x,y,abbrev);
  }
  
  //use global variables set in drawData()
  //to draw text related to closest Circl
  if (closestDist != MAX_FLOAT) {
    fill(0);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

//map the size of the ellispe to the data value
void drawData(float x, float y, String abbrev) {
  //figure out row this is
  int row = dataTable.getRowIndex(abbrev);
  //get the current value
  float value = interpolators[row].value;

  float radius = 0;
  if ( value >= 0 ) {
    radius = map(value,0,dataMax,1.5,15);
    fill(#4422cc);
  } else {
   radius  = map(value,0,dataMin,1.5,15);
    fill(#FF4422);
  }
  ellipseMode(RADIUS);
  ellipse(x,y,radius,radius);
  
  float d = dist(x,y,mouseX,mouseY);
  //because the following check is done each time a new circle is drawn,
  //we end up with the values of the circle nearest the mouse
  if ((d < radius +2) && (d < closestDist))  {
    closestDist = d;
    String name = nameTable.getString(abbrev,1);
    closestText = name + " " + nfp(value,0,2);
    closestTextX = x;
    closestTextY = y - radius - 4;
    
  }
}

void keyPressed() {
  if (key == ' ') 
    updateTable();
}

void updateTable() {
 for (int row = 0; row < rowCount; row++) {
     float newValue = random(-10,10);
     interpolators[row].target(newValue);
 } 
}
