PImage mapImage;
Table locationTable, dataTable;
int rowCount;



void setup() {
  size(640,400);
  mapImage = loadImage("map.png");
  //make a data table from a file that contains
  //the coordinates of each state
  
  locationTable = new Table("locations.tsv");
  rowCount = locationTable.getRowCount();
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
    float x = locationTable.getFloat(row,1); // column 1;
    float y = locationTable.getFloat(row,2); //column 2;
    ellipse(x,y,9,9);
  }
}
