class Cell{
 float x,y;
float state;
float nextState;
float lastState = 0;
Cell[] neighbors;

Cell(float ex, float why) {
  x = ex * _cellSize;
  y = why * _cellSize;
  nextState = ((x/width) + (y/width) * 14);
  state = nextState;
  neighbors = new Cell[0];
  
}

void addNeighbour(Cell cell){
  neighbors = (Cell[])append(neighbors,cell);
}
  
  
void calcNextState() {
  float total = 0;
    for (int i = 0; i < neighbors.length; i++) {
      total += neighbors[i].state;
    }
    float average = int(total/8);
    
    if(average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
       nextState = state + average;
      if (lastState > 0) 
         nextState -= lastState;
      if (nextState > 255) 
        nextState = 255;
      if (nextState < 0)
        nextState = 0;
    }
    
    lastState = state;
}

  
  void drawMe() {
   state = nextState;
    stroke(0);
    fill(state);
    ellipse(x,y,_cellSize,_cellSize);
  }
}
