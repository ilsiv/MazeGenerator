 //<>//
// Prim's maze generator

// all cells available in the maze
Cell[][] cells;

// cells per width
int NUM = 40;

// dimension of a cell
int w, h;
ArrayList<Cell> frontiers;
boolean DEBUG=false;

void setup() {
  //size (1000, 1000);
  fullScreen();
  //frameRate(1);
  //noLoop();
  //cell size (w x h)
  w = floor(width /NUM);
  h = floor(height/NUM);


  cells = new Cell[NUM][NUM];
  frontiers = new ArrayList<Cell>();

  for (int j = 0; j < NUM; j++) {
    for (int i = 0; i< NUM; i++) {
      cells[i][j] = new Cell(i, j);
    }
  }

  //noFill();
  init();
}

void mousePressed() {
  redraw();
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void init() {
  cells = new Cell[NUM][NUM];
  frontiers = new ArrayList<Cell>();
  for (int j = 0; j < NUM; j++) {
    for (int i = 0; i< NUM; i++) {
      cells[i][j] = new Cell(i, j);
    }
  }
  if (DEBUG) println("init draw()");
  for (int j = 0; j < NUM; j++) {
    for (int i = 0; i< NUM; i++) {
      cells[i][j].draw();
      if (DEBUG) println("cell :" + i + " " +j + " - " + cells[i][j] + " " + cells[i][j].frontier);
    }
  }
  //initial cell
  int a = floor(random(0, NUM));
  int b = floor(random(0, NUM));

  if (DEBUG) println("scelgo a caso i= " + a + ", j= " +b);
  cells[a][b].visited = true;
  // adding frontier cells
  cells[a][b].addFrontier();
}


void draw() {
  //background(255);
  if (frameCount%100 == 0)
    println(frameRate);

  // scelgo una cella di frontiera a caso dalla lista
  if (frontiers.size() > 0) {
    int a = floor(random(0, frontiers.size()));
    if (DEBUG) println("a: "+a);
    if (DEBUG) println("frontiers.size(): "+frontiers.size());
    Cell c = frontiers.get(a);

    // la cella diventa visitata
    c.visited= true;
    // elimino la cella dalla lista delle frontiere
    if (DEBUG) println("frontiers.remove(a)= " + c.i + " " + c.j + " - " + c);
    frontiers.remove(a);
    c.frontier = false;
    // aggiungo celle di frontiera
    c.addFrontier();

    // scelgo un vicino visitato
    ArrayList<Cell> arr;
    arr = c.findVisited();
    int s = floor(random(arr.size()));

    // se esiste un vicino distruggo il muro tra cella e vicino
    if (arr.size() > 0) {
      Cell p = arr.get(s); //prendo 0 per comodità; poi dovrebbe essere (s)
      c.deleteWallCell(p);
    }
  }

  if (DEBUG) println("draw()");

  if (frameCount%100 == 0) {
    //background(255);
    //for (int j = 0; j < NUM; j++) {
    //  for (int i = 0; i< NUM; i++) {
    //    cells[i][j].draw();
    //    if (DEBUG) println("cell :" + i + " " +j + " - " + cells[i][j] + " " + cells[i][j].frontier);
    //  }
    //}
  }
  //if (frontiers.isEmpty()) {
  //init();
  background(255);
  for (int j = 0; j < NUM; j++) {
    for (int i = 0; i< NUM; i++) {
      if ((cells[i][j].frontier || cells[i][j].visited) ) {
        cells[i][j].draw();
      }
      if (DEBUG) println("cell :" + i + " " +j + " - " + cells[i][j] + " " + cells[i][j].frontier);
    }
  }
  //}
}
