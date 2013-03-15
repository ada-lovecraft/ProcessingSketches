FloatTable data;
float dataMin, dataMax;
float plotX1, plotY1, plotX2,plotY2;
int currentColumn = 0;
int columnCount;
int rowCount;
int yearMin, yearMax;
int[] years;
int yearInterval = 10;
int volumeInterval = 10;
int volumeIntervalMinor = 5;
float labelX, labelY;
float barWidth = 4;




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
  rowCount = data.getRowCount();

  plotFont = createFont("SansSerif",20);
  textFont(plotFont);
  
  
  smooth();
  
}

void draw() {

  background(255);
  

  drawTitle();
  drawAxisLabels();
  
  drawVolumeLabels();
  
  noStroke();
  fill(#5679C1);
  drawDataBars(currentColumn);
  
  drawYearLabels();
  //drawDataHighlight(currentColumn);
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
for (int row = 0; row < rowCount; row++) {
   if (data.isValid(row,col)) {
       float value = data.getFloat(row,col);
       float x = map(years[row],yearMin,yearMax,plotX1, plotX2);
       float y = map(value, dataMin,dataMax, plotY2, plotY1);
       point(x,y);
     }
  } 
}

void drawDataLine(int col) {
 beginShape();
 int rowCount = data.getRowCount();
 for (int row = 0; row < rowCount; row++) {
   if (data.isValid(row,col)) {
     float value = data.getFloat(row,col);
     float x = map(years[row],yearMin,yearMax,plotX1, plotX2); 
     float y = map(value,dataMin,dataMax,plotY2,plotY1);
     vertex(x,y);
   }
 } 
 endShape();
}

void drawDataArea(int col) {
 beginShape();
 int rowCount = data.getRowCount();
 for (int row = 0; row < rowCount; row++) {
   if (data.isValid(row,col)) {
     float value = data.getFloat(row,col);
     float x = map(years[row],yearMin,yearMax,plotX1, plotX2); 
     float y = map(value,dataMin,dataMax,plotY2,plotY1);
     curveVertex(x,y);
   }
 } 
 vertex(plotX2, plotY2);
 vertex(plotX1, plotY2);
 endShape(CLOSE);
}

void drawDataBars(int col) {
  noStroke();
  rectMode(CORNERS);
  for (int row = 0; row < rowCount; row++) {
   if (data.isValid(row,col)) {
     float value = data.getFloat(row,col);
     float x = map(years[row],yearMin,yearMax,plotX1, plotX2); 
     float y = map(value,dataMin,dataMax,plotY2,plotY1);
     rect(x-barWidth/2,y,x+barWidth/2,plotY2);
   }
 } 
}

void drawDataCurve(int col) {
 beginShape();
 int rowCount = data.getRowCount();
  for (int row = 0; row < rowCount; row++) {
    if (data.isValid(row,col)) {
      float value = data.getFloat(row,col);
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      curveVertex(x,y);
      //double the curve points for the starta dn stop
      if ((row == 0) || (row == rowCount - 1)) {
        curveVertex(x,y);
      }
    }
  }
  endShape();
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
  stroke(255);
  strokeWeight(1);
   int rowCount = data.getRowCount();

  for (int row = 0; row < rowCount; row++) {
    if (years[row] % yearInterval == 0) {
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      text(years[row], x, plotY2 + 10);
      //line(x,plotY1, x, plotY2);
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

void drawDataHighlight(int col) {
 for (int row = 0; row < rowCount; row++) {
  if (data.isValid(row,col)) {
    float value = data.getFloat(row,col);
    float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
    float y = map(value, dataMin, dataMax, plotY2, plotY1);
    if (dist(mouseX,mouseY,x,y) < 3) {
      strokeWeight(10);
      point(x,y);
      fill(0);
      textSize(10);
      textAlign(CENTER);
      text(nf(value,0,2) + " (" + years[row] + ")", x, y-8);
    }
  }
 } 
}

