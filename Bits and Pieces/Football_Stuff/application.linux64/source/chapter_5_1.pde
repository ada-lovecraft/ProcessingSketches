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

void setup() {
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


void draw() {
  background(224);
  drawBackground();
  drawTitle();
  drawAxisLabels();
  drawDataBars();
  drawRankLabels();
  drawSalaryLabels();
  drawDataHighlight();
}

void drawBackground() {
  rectMode(CORNERS);
  noStroke();
  fill(255);
  rect(plotX1, plotY1, plotX2, plotY2);
}

void drawTitle() {
  fill(0);
  textSize(20);
  textAlign(LEFT,TOP);
  String title = "QB";
  text(title,plotX1, plotY2 - 25);
}

void drawAxisLabels() {
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER,CENTER);
  //use \n to break the text into separate lines
  text("Salary\n(in $MM)", paddingLeftX/3, (plotY1+plotY2)/3);
  textAlign(CENTER);
  text("Fantasy Football Ranking", (plotX1+plotX2)/2, height-10);
}


void drawRankLabels() {
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

void drawSalaryLabels() {
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


void drawDataArea() {
  fill(#768EFF);
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
 fill(#293364);
 for(int i = 0; i < qbList.size(); i++) {
    Player player = (Player) qbList.get(i);
    x = map(i, 0, qbList.size(), plotX1, plotX2);
    y = map(player.salary, minSalaryRequirement, salaryMax, plotY1, plotY2);
    ellipse(x,y,5,5);
    //println(player.displayName + " :: " + player.salary + " -> " + x + ", " + y);
  }
}

void drawDataBars() {
  
  noStroke();
  rectMode(CORNERS);
  float x,y;
  barWidth = 14;
  for(int i = 0; i < qbList.size(); i++) {
   fill(#333333); 
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

void drawDataHighlight() {
  noStroke();
  float x,y;
  for (int i = 0; i < qbList.size(); i++) {
    fill(0);
    Player player = (Player) qbList.get(i);
     x = map(player.ffPositionRank, rankMin,rankMax, plotX1, plotX2);
    if (player.salary > 0) {
      fill(#8A9EFC);
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


void drawToolTip(Player player) {
  float textY = 5;
  float textX = 10;
  float toolTipX1,toolTipX2 = 0;
  
  rectMode(CORNERS);
  
  toolTipX2  = mouseX +450;
  //dropshadow
  fill(0,90);
  noStroke();
  rect(mouseX+20, mouseY+10,toolTipX2+20, mouseY-280);
  
  fill(#ffffff,255);
  stroke(#333333);
  strokeWeight(1);
  rect(mouseX+10, mouseY-5, toolTipX2+10, mouseY-300);
  
  pushMatrix();
  translate( mouseX + 5, mouseY - 300);
  textSize(10);
  textAlign(LEFT);
  fill(#333333);
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
