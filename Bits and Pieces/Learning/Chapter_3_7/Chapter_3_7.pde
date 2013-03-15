PImage mapImage;
Table locationTable, dataTable;
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

void setup() {
  size(640,400);
  noLoop();
  mapImage = loadImage("map.png");
  //make a data table from a file that contains
  //the coordinates of each state
  
  locationTable = new Table("locations.tsv");
  dataTable = new Table("random.tsv");
  rowCount = locationTable.getRowCount();

  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row,1);
    if (value > dataMax) 
        dataMax = value;
     if (value < dataMin) 
       dataMin = value;
  }
  println("min / max " + dataMin + "/" + dataMax);  
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
  float a = 0;
  if ( value >= 0 ) {
    a = map(value,0,dataMax,0,255);
    fill(#333366,a);
  } else {
   a  = map(value,0,dataMin,0,255);
    fill(#EC5166,a);
  }
  ellipse(x,y,15,15);
}
