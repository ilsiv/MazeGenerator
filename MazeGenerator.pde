import processing.pdf.*; //<>//

// Prim's maze generator
// http://weblog.jamisbuck.org/2011/1/10/maze-generation-prim-s-algorithm

// all cells available in the maze
Cell[][] cells;

PImage img;

// cells per width
int NUM = 98;

// dimension of a cell
int w, h;
ArrayList<Cell> frontiers;

boolean DEBUG = false; // printing debug messages 

boolean IM = true; // use image as "backgroud" 
float contr = 1.3; // contrast 

boolean RUNNING = false; // display the cells updating

boolean SAVE = false; // save rendering


void setup() {
  size (698, 960);
  //size(1400, 2000,P3D);
  //fullScreen();
  //frameRate(1);
  //noLoop();
  //cell size (w x h)
  w = floor(width /NUM);
  h = floor(height/NUM);


  if (IM) {
    img = loadImage("silvio_3.jpg");
    //img.blend(0, 0, img.width, img.height, 0, 0, img.width, img.height, OVERLAY);
    img.resize(width, height);
    image(img, 0, 0);
    loadPixels();
    for (int i = 0; i < img.width; i++) {
      for (int j=0; j< img.height; j++) {
        int index = j*img.width + i;
        color c = color(pixels[index]);
        int r, g, b;
        r= (int)red(c);
        g = (int) green(c);
        b= (int)blue(c);


        r *= contr;
        g *= contr;
        b *= contr;

        r = r < 0 ? 0 : r > 255 ? 255 : r;
        g = g < 0 ? 0 : g > 255 ? 255 : g;
        b = b < 0 ? 0 : b > 255 ? 255 : b;

        pixels[index] = color(r, g, b);
      }
    }
    updatePixels();
  }
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
  contr = map(mouseX, 0, img.width, 0, 5);
  //image(img, 0, 0);
  saveFrame("canvas_####.jpg");

  /*  
   PGraphics svg = createGraphics(300, 300, SVG, "canvas.svg");
   svg.beginDraw();
   svg.background(128, 0, 0);
   svg.line(50, 50, 250, 250);
   svg.dispose();
   svg.endDraw();
   */
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
  //while (frontiers.size() > 0) {
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

  if (frameCount%10 == 0 ) {
    if (SAVE) {
      beginRecord(PDF, "canvas.pdf"); //SVG
    }
    background(255);
    for (int j = 0; j < NUM; j++) {
      for (int i = 0; i< NUM; i++) {
        if ((cells[i][j].frontier || cells[i][j].visited) ) {
          cells[i][j].draw();
        }
        if (DEBUG) println("cell :" + i + " " +j + " - " + cells[i][j] + " " + cells[i][j].frontier);
      }
    }
  }
  if (SAVE) {
    endRecord(); //SVG
  }
  //}
}
