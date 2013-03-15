FloatTable data;
float dataMin, dataMax;
float plotX1, plotY1, plotX2,plotY2;
int currentColumn = 0;
int columnCount;
int yearMin, yearMax;
int[] years;
int yearInterval = 10;
int volumeInterval = 10;
int volumeIntervalMinor = 5;
float labelX, labelY;




PFont plotFont;

void setup() {
  size(720,405);
  data = new FloatTable("milk-tea-coffee.tsv");
  columnCount = data.getColumnCount();
  years = int(data.getRowNames());
  yearMin = years[0];
  yearMax = years[years.length-1];
 
  dataMin = 0;
  dataMax = ceil(data.getTableMax() / volumeInterval) * volumeInterval;
 
   //Corners of the plotted time series
  plotX1 = 120;
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  plotFont = createFont("SansSerif",20);
  textFont(plotFont);
  
  
  smooth();
  
}

void draw() {
  
  background(224);
  
  //show the plot areas a white box
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);
  drawTitle();
  drawAxisLabels();
  drawYearLabels();
  drawVolumeLabels();
  
  
  //draw the title fo the current plot
  
  strokeWeight(5);
  //draw the data for the first column
  stroke(#5679C1);
  drawDataPoints(currentColumn); 
}

void keyPressed() {
  if (key == '[') {
    currentColumn--;
    if (currentColumn < 0) {
      currentColumn = columnCount - 1;
    }
  } else if (key == ']') {
    currentColumn++;
    if (currentColumn == columnCount) {
      currentColumn = 0;
    }
  }
}

void drawDataPoints(int col) {
 int rowCount = data.getRowCount();
for (int row = 0; row < rowCount; row++) {
   if (data.isValid(row,col)) {
       float value = data.getFloat(row,col);
       float x = map(years[row],yearMin,yearMax,plotX1, plotX2);
       float y = map(value, dataMin,dataMax, plotY2, plotY1);
       point(x,y);
     }
  } 
}

void drawTitle() {
  fill(0);
  textSize(20);
  textAlign(LEFT,TOP);
  String title = data.getColumnName(currentColumn);
  text(title,plotX1, plotY1 - 25);
}

void drawYearLabels() {
  fill(0);
  textSize(10);
  textAlign(CENTER,TOP);
  //use thin grey lines to draw the grid
  stroke(224);
  strokeWeight(1);
   int rowCount = data.getRowCount();

  for (int row = 0; row < rowCount; row++) {
    if (years[row] % yearInterval == 0) {
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      text(years[row], x, plotY2 + 10);
      line(x,plotY1, x, plotY2);
    }
  }
}

void drawVolumeLabels() {
  fill(0);
  textSize(10);
  stroke(128);
  strokeWeight(1);
  textAlign(RIGHT,CENTER);
  float dataFirst = dataMin + volumeInterval;
  for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
    float y = map(v, dataMin, dataMax, plotY2, plotY1);
    if (v % volumeInterval == 0) { //major tick mark
      if (v == dataMin) {
        textAlign(RIGHT); //align by the bottom
      } else if ( v == dataMax) {
        textAlign(RIGHT,TOP); // align by the top
      } else {
        textAlign(RIGHT,CENTER); // center vertically;
      }
    text(floor(v), plotX1- 10, y);
    line(plotX1 - 6, y, plotX1,y); // draw major tick
  } else {
    line(plotX1 - 3, y, plotX1, y); // draw minor tick
  }
  }
}

void drawAxisLabels() {
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER,CENTER);
  //use \n to break the text into separate lines
  text("Gallons\nconsumed\nper capita", labelX, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Year", (plotX1+plotX2)/2, labelY);
}

