PImage mapImage;
Table locationTable, dataTable,nameTable;
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

void setup() {
  PFont font = loadFont("Futura-Medium-12.vlw");
  textFont(font);
  size(640,400);
  mapImage = loadImage("map.png");
  //make a data table from a file that contains
  //the coordinates of each state
  
  locationTable = new Table("locations.tsv");
  dataTable = new Table("random.tsv");
  nameTable = new Table("names.tsv");
  rowCount = locationTable.getRowCount();

  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row,1);
    if (value > dataMax) 
        dataMax = value;
     if (value < dataMin) 
       dataMin = value;
  }
}

void draw() {
  background(255);
  image(mapImage,0,0);
  
  //drawing attributes for teh ellipses
  smooth();
  fill(192,0,0);
  noStroke();
  
  //loop through the rows of the lcoations file and draw the points
  
  for (int row= 0; row < rowCount; row++) {
    String abbrev = dataTable.getRowName(row);
    float x = locationTable.getFloat(row,1); // column 1;
    float y = locationTable.getFloat(row,2); //column 2;
    drawData(x,y,abbrev);
  }
}

//map the size of the ellispe to the data value
void drawData(float x, float y, String abbrev) {
  //get data value for state
  float value = dataTable.getFloat(abbrev,1);
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
  
  if (dist(x,y, mouseX,mouseY) < radius+2) {
    fill(0);
    textAlign(CENTER);
    //show the data value and the state abbreviateion in parentheses
    String name = nameTable.getString(abbrev,1);
    text(name + " " + value,x,y-radius-4);
  }
}
