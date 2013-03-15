class Cell{
 float x,y;
boolean state;
boolean nextState;
Cell[] neighbors;

Cell(float ex, float why) {
  x = ex * _cellSize;
  y = why * _cellSize;
  if (random(2) > 1) 
    nextState = true;
  else
    nextState = false;
  
  state = nextState;
  neighbors = new Cell[0];
  
}

void addNeighbour(Cell cell){
  neighbors = (Cell[])append(neighbors,cell);
}
  
  
void calcNextState() {
  int liveCount = 0;
  for (int i =0; i < neighbors.length; i++) {
    if (neighbors[i].state == true) {
      liveCount++;
    }
  }
  
  if (state == true){
    if (liveCount == 2 || liveCount == 3) {
      nextState = true;
    } else {
      nextState = false;
    }
  } else {
    if (liveCount == 3) {
      nextState = true;
    }  else {
      nextState = false;
    }
  }
}

  
void drawMe() {
 state = nextState;
stroke(0);
if (state == true) {
  fill(0);
} else {
  fill(255);
}
  ellipse(x,y,_cellSize,_cellSize);
}
}
