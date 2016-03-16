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
  int rotation = 0;
  int jumpHeight=340;
  boolean jumping=false;
  float jumpPos=-10;
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
    int ty=this.y;
    if(jumping) {
      jumpPos+=1;
     
      ty = (height-this.heig)-((int) map(pow((jumpPos*0.4), 2), 25, 0, 0, jumpHeight));
      if(jumpPos == 10) jumping=false;
    }
      
    
    pushMatrix();
    translate(x+(wid/2), ty+(heig/2));
    //if(yvol > 0) rotate(radians(-map(this.distance(), 0, this.jumpHeight, 0, 180)));
    //if(yvol < 0) rotate(radians(-map(this.distance(), 0, this.jumpHeight, 180, 0)));
        fill(r, g, b);
    rect(-(wid/2), -(heig/2), wid, heig);
    popMatrix();

    rotation++;
    if(rotation== 360) rotation=0;
  }
  
 
  
  void jump() {
    if(!jumping) {
      jumping = true;
      jumpPos = -10;
    }
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
  
  int distance() {
    return height-(this.y+this.heig);
  }
}