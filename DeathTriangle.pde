class DeathTriangle {
  int x;
  int y;
  int size=100;
  boolean cleared=false;
    DeathTriangle(int _x, int _y){
    this.x = _x;
    this.y = _y;
    
  }
  void draw() {
    noStroke();
    int tx = x-scroll;
    noFill();
    rect(tx, y, size, size);
    
    fill(224, 66, 66);
    
     triangle(tx, y+size, tx+(size/2), y, tx+size, y+size); 
  }
  
  boolean passedScreen() {
    int tx = x-scroll;
    if(tx+size < 0) return true;
    else return false;
  }
  
}