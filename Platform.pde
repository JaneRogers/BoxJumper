class Platform {
 int x;
 int y = height-50;
 color shade = color(125, 125, 125);
 int size =50;
  Platform(int _x) {
    this.x = _x;
  }
    void draw() {
    pushMatrix();
    translate(x, y);
    fill(shade);
    rect(0, 0, size, size);
    popMatrix();
    }   
  }
}