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

public class chapter_5_1 extends PApplet {

FloatTable salaryTable;
XML ffXML;
float plotX1, plotX2;
float plotY1, plotY2;
float paddingLeftX = 100;
float paddingRightX = 20;
float paddingTopY = 50;
float paddingBottomY = 50;
int maxPlayers = 10;
int salaryMin, salaryMax;
int rankMin, rankMax;
int minSalaryRequirement = 1000000;
int rankInterval = 10;
int salaryInterval = 1000000;
int salaryIntervalMinor = salaryInterval / 2;
int barWidth = 10;
float barOffset = 0;

PFont plotFont;


ArrayList qbList = new ArrayList();

public void setup() {
  background(224);
  size(1200,920);
  
  plotX1 = paddingLeftX;
  plotX2 = width - paddingRightX;
  plotY1 = height - paddingBottomY;
  plotY2 = paddingTopY;
  ffXML = loadXML("FF_QB.xml");  
  salaryTable = new FloatTable("nfl-salaries.tsv");
  //println(salaryTable.getColumnNames());
  
  XML[] qbs = ffXML.getChildren("Results/Player");
  String qbName,salaryName;
  
  int qbCount = 0;
  for(int i = 0; i < qbs.length; i++) {
    qbName = qbs[i].getString("Name");
   for(int j = 0; j < salaryTable.getRowCount(); j++) {
       salaryName = salaryTable.getRowName(j);
     if(qbName.equals(salaryName) ) {
       Player player = new Player(qbs[i],salaryTable.getRow(j));
       if (player.salary >= minSalaryRequirement)
         qbList.add(player);
       break;
     } 
     /*else if (j == salaryTable.getRowCount()-1) {
       String[] fakeSalaryNode = {"","-1","","",""};
       Player player = new Player(qbs[i],fakeSalaryNode);
       qbList.add(player);
     }*/
       
     
   }
  }
  
  salaryMin = MAX_INT;
  salaryMax = MIN_INT;
  rankMin = MAX_INT;
  rankMax = MIN_INT;
  for(int i = 0; i < qbList.size(); i++) {
    Player player = (Player) qbList.get(i);
    
    if (player.salary < salaryMin && player.salary > 0){
      salaryMin = player.salary;
    }
    if (player.salary > salaryMax) {
      salaryMax = player.salary;
    }
    
    if (player.ffPositionRank < rankMin) 
      rankMin = player.ffPositionRank;
    if (player.ffPositionRank > rankMax)
      rankMax = player.ffPositionRank;
  }
  salaryMax += salaryMax/10;
  plotFont = createFont("SansSerif",20);
  textFont(plotFont);
  
  
  smooth();
}


public void draw() {
  background(224);
  drawBackground();
  drawTitle();
  drawAxisLabels();
  drawDataBars();
  drawRankLabels();
  drawSalaryLabels();
  drawDataHighlight();
}

public void drawBackground() {
  rectMode(CORNERS);
  noStroke();
  fill(255);
  rect(plotX1, plotY1, plotX2, plotY2);
}

public void drawTitle() {
  fill(0);
  textSize(20);
  textAlign(LEFT,TOP);
  String title = "QB";
  text(title,plotX1, plotY2 - 25);
}

public void drawAxisLabels() {
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER,CENTER);
  //use \n to break the text into separate lines
  text("Salary\n(in $MM)", paddingLeftX/3, (plotY1+plotY2)/3);
  textAlign(CENTER);
  text("Fantasy Football Ranking", (plotX1+plotX2)/2, height-10);
}


public void drawRankLabels() {
  fill(0);
  textSize(10);
  textAlign(CENTER,TOP);
  //use thin grey lines to draw the grid
  stroke(224);
  strokeWeight(1);
  for (int i = 0; i < qbList.size(); i++) {
    Player player = (Player) qbList.get(i);
    if (player.ffPositionRank % rankInterval == 0) {
      float x = map(player.ffPositionRank, rankMin, rankMax, plotX1, plotX2);
      text(player.ffPositionRank, x, plotY1 + 10);
      line(x,plotY1, x, plotY2);
    }
  }
}

public void drawSalaryLabels() {
  fill(0);
  textSize(10);
  stroke(128);
  strokeWeight(1);
  textAlign(RIGHT,CENTER);
  float salaryFirst = salaryMin + salaryInterval;
  for (float v = salaryMin; v <= salaryMax; v += salaryIntervalMinor) {
    float y = map(v, salaryMin, salaryMax, plotY1, plotY2);
    if (v % salaryInterval == 0) { //major tick mark
      println("MAJOR TICK: " + v);
      if (v == salaryMin) {
        textAlign(RIGHT); //align by the bottom
      } else if ( v == salaryMax) {
        textAlign(RIGHT,TOP); // align by the top
      } else {
        textAlign(RIGHT,CENTER); // center vertically;
      }
    text(floor(v/salaryInterval), plotX1 - 10, y);
    line(plotX1 - 6, y, plotX1,y); // draw major tick
  } else {
    println("MINOR TICK: " + v);
    line(plotX1 - 3, y, plotX1, y); // draw minor tick
  }
  }
}


public void drawDataArea() {
  fill(0xff768EFF);
  noStroke();
  float x,y;
  beginShape();
  for(int i = 0; i < qbList.size(); i++) {
    Player player = (Player) qbList.get(i);
    x = map(i, 0, qbList.size(), plotX1, plotX2);
    y = map(player.salary, minSalaryRequirement, salaryMax, plotY1, plotY2);
    vertex(x,y);
    //println(player.displayName + " :: " + player.salary + " -> " + x + ", " + y);
  }
 vertex(plotX2, plotY1);
 vertex(plotX1, plotY1);
 endShape(CLOSE);
 fill(0xff293364);
 for(int i = 0; i < qbList.size(); i++) {
    Player player = (Player) qbList.get(i);
    x = map(i, 0, qbList.size(), plotX1, plotX2);
    y = map(player.salary, minSalaryRequirement, salaryMax, plotY1, plotY2);
    ellipse(x,y,5,5);
    //println(player.displayName + " :: " + player.salary + " -> " + x + ", " + y);
  }
}

public void drawDataBars() {
  
  noStroke();
  rectMode(CORNERS);
  float x,y;
  barWidth = 14;
  for(int i = 0; i < qbList.size(); i++) {
   fill(0xff333333); 
   Player player = (Player) qbList.get(i);
   x = map(player.ffPositionRank, rankMin,rankMax, plotX1, plotX2);
    if ((x-barWidth/2) < plotX1) {
      barOffset = plotX1 - (x-barWidth/2);
      println("barOffset: " + barOffset);
    }
    if (player.salary > 0 && (x+barWidth/2) < plotX2) {
      y = map(player.salary, minSalaryRequirement, salaryMax, plotY1, plotY2);  
    } else {
      fill(240);
      y = map(salaryMax, minSalaryRequirement, salaryMax, plotY1, plotY2);  
    }
     rect((x-barWidth/2) + barOffset ,y,(x+barWidth/2)+barOffset,plotY1);
 } 
}

public void drawDataHighlight() {
  noStroke();
  float x,y;
  for (int i = 0; i < qbList.size(); i++) {
    fill(0);
    Player player = (Player) qbList.get(i);
     x = map(player.ffPositionRank, rankMin,rankMax, plotX1, plotX2);
    if (player.salary > 0) {
      fill(0xff8A9EFC);
      y = map(player.salary, minSalaryRequirement, salaryMax, plotY1, plotY2);  
    } else {
      fill(196);
      y = map(salaryMax, minSalaryRequirement, salaryMax, plotY1, plotY2);  
    }
    if ( mouseX > x-barWidth/2 && mouseX < x + barWidth/2) {
      rect((x-barWidth/2) + barOffset,y,(x+barWidth/2) + barOffset,plotY1);
      drawToolTip(player);
    }
  }
} 


public void drawToolTip(Player player) {
  float textY = 5;
  float textX = 10;
  float toolTipX1,toolTipX2 = 0;
  
  rectMode(CORNERS);
  
  toolTipX2  = mouseX +450;
  //dropshadow
  fill(0,90);
  noStroke();
  rect(mouseX+20, mouseY+10,toolTipX2+20, mouseY-280);
  
  fill(0xffffffff,255);
  stroke(0xff333333);
  strokeWeight(1);
  rect(mouseX+10, mouseY-5, toolTipX2+10, mouseY-300);
  
  pushMatrix();
  translate( mouseX + 5, mouseY - 300);
  textSize(10);
  textAlign(LEFT);
  fill(0xff333333);
  textY += textAscent();
  text(player.firstName,textX,textY+textAscent());
  textSize(20);
  textY += textAscent() + 10;
  text(player.lastName,textX,textY);
  textSize(10);
  textY += textAscent() + 10;
  text("Position Draft Rank: " + player.ffPositionRank,textX,textY);
  textY += textAscent() + 10;
  text(player.teamName + " (" + player.teamCallSign +")",textX,textY);
  textY += textAscent() + 10;
  if (player.salary < 0) {
    text("Salary: N/A",textX,textY);
  } else {
     text("Salary: $" + nfc(player.salary),textX,textY);
  }
  
  popMatrix();
}
// first line of the file should be the column headers
// first column should be the row titles
// all other values are expected to be floats
// getFloat(0, 0) returns the first data value in the upper lefthand corner
// files should be saved as "text, tab-delimited"
// empty rows are ignored
// extra whitespace is ignored


class FloatTable {
  int rowCount;
  int columnCount;
  String[][] data;
  String[] rowNames;
  String[] columnNames;
  
  
  FloatTable(String filename) {
    String[] rows = loadStrings(filename);
    
    String[] columns = split(rows[0], TAB);
    columnNames = subset(columns, 1); // upper-left corner ignored
    //columnNames = columns;
    scrubQuotes(columnNames);
    columnCount = columnNames.length;

    rowNames = new String[rows.length-1];
    data = new String[rows.length-1][];

    // start reading at row 1, because the first row was only the column headers
    for (int i = 1; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }

      // split the row on the tabs
      String[] pieces = split(rows[i], TAB);
      scrubQuotes(pieces);
      
      // copy row title
      rowNames[rowCount] = pieces[0];
      // copy data into the table starting at pieces[1]
      data[rowCount] = subset(pieces, 1);

      // increment the number of valid rows found so far
      rowCount++;      
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }
  
  
  public void scrubQuotes(String[] array) {
    for (int i = 0; i < array.length; i++) {
      if (array[i].length() > 2) {
        // remove quotes at start and end, if present
        if (array[i].startsWith("\"") && array[i].endsWith("\"")) {
          array[i] = array[i].substring(1, array[i].length() - 1);
        }
      }
      // make double quotes into single quotes
      array[i] = array[i].replaceAll("\"\"", "\"");
    }
  }
  
  
  public int getRowCount() {
    return rowCount;
  }
  
  
  public String getRowName(int rowIndex) {
    //println("getting rowname: " + rowIndex);
    return rowNames[rowIndex];
  }
  
  
  public String[] getRowNames() {
    return rowNames;
  }

  
  // Find a row by its name, returns -1 if no row found. 
  // This will return the index of the first row with this name.
  // A more efficient version of this function would put row names
  // into a Hashtable (or HashMap) that would map to an integer for the row.
  public int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {
      if (rowNames[i].equals(name)) {
        return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }
  
  
  // technically, this only returns the number of columns 
  // in the very first row (which will be most accurate)
  public int getColumnCount() {
    return columnCount;
  }
  
  
  public String getColumnName(int colIndex) {
    return columnNames[colIndex];
  }
  
  
  public String[] getColumnNames() {
    return columnNames;
  }


  public String getString(int rowIndex, int col) {
    // Remove the 'training wheels' section for greater efficiency
    // It's included here to provide more useful error messages
    
    // begin training wheels
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }
    // end training wheels
    
    return data[rowIndex][col];
  }
  
  public String[] getRow(int rowIndex) {
    return data[rowIndex];
  }
  
  /*
  boolean isValid(int row, int col) {
    if (row < 0) return false;
    if (row >= rowCount) return false;
    //if (col >= columnCount) return false;
    if (col >= data[row].length) return false;
    if (col < 0) return false;
    return !Float.isNaN(data[row][col]);
  }*/
  
  
  public float getColumnMin(int col) {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (!Float.isNaN(PApplet.parseFloat(data[i][col]))) {
        if (PApplet.parseFloat(data[i][col]) < m) {
          m = PApplet.parseFloat(data[i][col]);
        }
      }
    }
    return m;
  }

  
  public float getColumnMax(int col) {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (!Float.isNaN(PApplet.parseFloat(data[i][col]))) {
        if (PApplet.parseFloat(data[i][col]) > m) {
          m = PApplet.parseFloat(data[i][col]);
        }
      }
    }
    return m;
  }

  
  public float getRowMin(int row) {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < columnCount; i++) {
      if (!Float.isNaN(PApplet.parseFloat(data[row][i]))) {
        if (PApplet.parseFloat(data[row][i]) < m) {
          m = PApplet.parseFloat(data[row][i]);
        }
      }
    }
    return m;
  } 

  
  public float getRowMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int i = 1; i < columnCount; i++) {
      if (!Float.isNaN(PApplet.parseFloat(data[row][i]))) {
        if (PApplet.parseFloat(data[row][i]) > m) {
          m = PApplet.parseFloat(data[row][i]);
        }
      }
    }
    return m;
  }
  
  
  public float getTableMin() {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (!Float.isNaN(PApplet.parseFloat(data[i][j]))) {
          if (PApplet.parseFloat(data[i][j]) < m) {
            m = PApplet.parseFloat(data[i][j]);
          }
        }
      }
    }
    return m;
  }

  
  public float getTableMax() {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
       if (!Float.isNaN(PApplet.parseFloat(data[i][j]))) {
          if (PApplet.parseFloat(data[i][j]) < m) {
            m = PApplet.parseFloat(data[i][j]);
          }
        }
      }
    }
    return m;
  }
}
class Player{
  String firstName;
  String lastName;
  String displayName;
  String position;
  String teamName;
  String teamCallSign;
  int ffOverallRank;
  int ffPositionRank;
  int salaryRank;
  int salary;
  
  Player(XML ffNode,String[] salaryNode) {
    String[] nameSplit = ffNode.getString("Name").split(" ");
    
    firstName = nameSplit[0];
    lastName = nameSplit[1];
    displayName = ffNode.getString("Name");
    position = ffNode.getString("Position");
    teamName = salaryNode[4];
    teamCallSign = ffNode.getString("Team");
    ffOverallRank = ffNode.getInt("OverallRank");
    ffPositionRank = ffNode.getInt("PositionRank");
    salary = PApplet.parseInt(salaryNode[1]);
    println("OR: " + ffPositionRank);
  }
  
  public void print() {
    println(displayName + " (" + position + ")");
    println(teamName + " (" + teamCallSign + ")");
    println("Overall Draft Rank: " + ffOverallRank);
    println("Position Draft Rank: " + ffPositionRank);
    println("Salary: " + salary);
  } 
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "chapter_5_1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
