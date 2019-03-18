 //<>// //<>// //<>//
// all cells available in the maze
Cell[][] cells;

// cells per width
int NUM = 2;

// dimension of a cell
int w, h;
ArrayList<Cell> frontiers;


void setup() {
  size (600, 600);
  frameRate(0.2);
//  noLoop();
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

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

void init() {
  //scelgo a caso un cella iniziale
  int a = floor(random(0, NUM));
  println(a);
  int b = floor(random(0, NUM));
  println(b);
  cells[a][b].visited = true;
  // aggiungo celle di frontiera
  cells[a][b].addFrontier();
}


void draw() {
  int q;

  background(255);
  for (int j = 0; j < NUM; j++) {
    for (int i = 0; i< NUM; i++) {
      cells[i][j].draw();
    }
  }

  // scelgo una cella di frontiera a caso dalla lista
  if (frontiers.size()>0) {
    int a = floor(random(0, frontiers.size()));
    println("a: "+a);
    println("frontiers.size(): "+frontiers.size());
    Cell c = frontiers.get(a);

    // la cella diventa visitata
    c.visited= true;
    // elimino la cella dalla lista delle frontiere
    frontiers.remove(a);
    c.frontier = false;
    // aggiungo celle di frontiera
    c.addFrontier();
    // scelgo un vicino visitato

    ArrayList<Cell> arr;
    arr = c.findVisited();
    int s = floor(random(arr.size()));

    // se esiste un vicino distruggo il muro tra cella e vicino
    if (s>0) {
      //Cell p = arr.get(s);
    }
  }
}
