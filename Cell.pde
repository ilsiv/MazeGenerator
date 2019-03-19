class Cell { //<>//
  int i = -1;
  int j = -1;
  boolean visited = false;
  boolean frontier = false;
  boolean render=true;
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
      //if (DEBUG) println("cell.draw frontier==true");
    } else if ((frontier==false) && (visited == false)) {
      fill(240, 240, 240, 100);
      //if (DEBUG) println("cell.draw frontier==false");
    } else if ((frontier==false) && (visited == true)) {
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
    return arr; //arrayList of neighbors
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
      boolean ins = true;
      if (c.visited == false && c.frontier == false) {
        // if frontier is not already listed
        ins = !frontiers.contains(this);
        if (ins) {
          if (DEBUG) println("frontiers.add(c) = "+c.i +" "+ c.j + " - " + c);
          frontiers.add(c);
        }
        c.frontier= true;
      }
    }
  }

  void deleteWallCell(Cell p) {

    if (DEBUG) println("deleteWallCell before p:" + p.i + " " + p.j + " - " + p + " / " + walls[0]+walls[1]+walls[2]+walls[3]);
    // N - S
    if (i==p.i) {
      // N
      if (j>p.j) {
        if (DEBUG) println("wall N");
        p.walls[2]=0;
        walls[0]=0;
      }
      // S
      else if (j<p.j) {
        if (DEBUG) println("wall S");
        p.walls[0]=0;
        walls[2]=0;
      }
    } else if (j==p.j) {
      // E
      if (i<p.i) {
        if (DEBUG) println("wall E");
        p.walls[3]=0;
        walls[1]=0;
      }
      // W
      else if (i>p.i) {
        if (DEBUG) println("wall W");
        p.walls[1]=0;
        walls[3]=0;
      }
    }
    if (DEBUG) println("deleteWallCell after  p:" + p.i + " " + p.j + " - " + p + " / " + i + " " + j + " " + walls[0]+walls[1]+walls[2]+walls[3]);
  }
}
