class Cell {
  int i = -1;
  int j = -1;
  boolean visited = false;
  boolean frontier = false;

  //wall {N,E,S,W}
  int[] walls = {1, 1, 1, 1}; 

  Cell (int i_, int j_) {
    i = i_;
    j = j_;
  }

  void draw() {
    push();
    if (frontier==true) {
      fill(159, 0, 0, 100);
    } else {
      fill(0, 0, 240, 100);
    }
    stroke(0);
    strokeWeight(1);

    translate(i*w, j*h);
    noStroke();
    rect(0, 0, w, h);
    stroke(0);

    if (walls[0] ==1)
      line(0, 0, w, 0); //n
    if (walls[1] ==1)
      line(w, 0, w, h); //e
    if (walls[2] ==1)
      line(0, h, w, h); //s
    if (walls[3] ==1)
      line(0, 0, 0, h); //w

    pop();
  }


  // search for all Neighbors
  ArrayList<Cell> findNeighbors() {

    ArrayList<Cell> arr = new ArrayList<Cell>();
    //N
    if (j>0) {    
      arr.add(cells[i][j-1]);
    }

    //E
    if (i<NUM-1) {
      arr.add(cells[i+1][j]);
    }

    //S
    if (j<NUM-1) {
      arr.add(cells[i][j+1]);
    }
    //W
    if (i>0) {
      arr.add(cells[i-1][j]);
    }
    return arr; //arrayList di vicini
  }

  // search for visited neighbors cells (no frontier)
  ArrayList<Cell>  findVisited() {
    ArrayList<Cell> arr;
    arr = findNeighbors();

    ArrayList<Cell> ret = new ArrayList<Cell>();

    for (Cell c : arr) {
      if (c.visited == true && c.frontier == false) {
        ret.add(c);
      }
    }
    return ret;
  }

  // search for frontiers (no visited and frontier)
  ArrayList<Cell> findFrontier () {

    ArrayList<Cell> arr;
    arr = findNeighbors();

    for (Cell c : arr) {
      if (c.visited == false && c.frontier == true) {
        arr.add(c);
      }
    }
    return arr;
  }

  

  // add frontier of this cell to the list
  void addFrontier() {
    ArrayList<Cell> arr;
    arr = findNeighbors();
    for (Cell c : arr) {
      if (c.visited == false && c.frontier == false) {
        frontiers.add(c);
        println("frontiers.add(c);"+c.i +" "+ c.j);
      }
    }
  }
  
  
  // delete wall index i
  void deleteWall(int q) {
    //wall {N,E,S,W}
    // i = wall index
    walls[q] = 0;

    //delete south wall of cell (i,j-1)
    if ((q==0)&&(j>0)) {
      cells[i][j-1].walls[2] = 0;
    }
    //delete west wall of cell (i+1,j)
    if ((q==1)&&(i<w)) {
      cells[i+1][j].walls[3] = 0;
    }
    //delete north wall of cell (i,j+1)
    if ((q==2)&&(j<h)) {
      cells[i][j+1].walls[0] = 0;
    }
    //delete east wall of cell (i-1,j)
    if ((q==3)&&(i>0)) {
      cells[i-1][j].walls[1] = 0;
    }
  }
}
