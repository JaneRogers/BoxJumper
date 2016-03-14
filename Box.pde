class Box {
  int x = 5;
  int y = 50;
  float yvol = 3;
  float xvol = 5;
  int r=0;
  int g=0;
  int b=0;
  int wid=30;
  int heig=30;

  Box(int _x, int _y, int _wid, int _heig, int _xvol, int _yvol) { // Constructor
    this.x = _x;
    this.y = _y;
    this.xvol = _xvol;
    this.yvol = _yvol;
    this.wid = _wid;
    this.heig = _heig;
  randomColor();
  }

  void draw() {


    
    if (x+wid+xvol >= width) {
      xvol*=-1;
      
    }
    if (x+xvol <= 0) {
      xvol*=-1;
      
    }

    if (y+heig+yvol >= height) {
      yvol*=-1;
      yvol*=friction;
      y = height-heig;
    if(abs(yvol)<gravity) yvol=0;
    }
    if (y+yvol <= 0){
      yvol*=-1;
      
    }
    if(y+heig+yvol < height-1) yvol+=gravity;
    
        fill(r, g, b);
    rect(x, y, wid, heig);
    
    x+=xvol;
    y+=yvol;
  }
  
 
  
  
  
  void randomColor() {
        this.r = (int) random(0, 255);
    this.g = (int) random(0, 255);
    this.b = (int) random(0, 255);
  }
  
  boolean collidedWith(DeathTriangle triangle) {
    if(scroll+this.x+this.wid >= triangle.x) {
      if(this.y+this.heig >= triangle.y) {
        if(scroll+this.x <= triangle.x+triangle.size) {
        return true;
        } else {
           if(!triangle.cleared) {
             score++;
             triangle.cleared = true;
           }
        }
      }
    }
    return false;
  }
}