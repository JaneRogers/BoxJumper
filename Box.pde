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
  int jumpRangeStart=-18;
  int jumpRangeEnd=18;
  int jumpY;
  float jumpScale = 0.5;
  boolean jumping=false;
  float jumpPos=0;
  Box(int _x, int _y, int _wid, int _heig, int _xvol, int _yvol) { // Constructor
    this.x = _x;
    this.y = _y;
    this.xvol = _xvol;
    this.yvol = _yvol;
    this.wid = _wid;
    this.heig = _heig;
   jumpY = (int) pow(jumpRangeStart*jumpScale, 2);
  randomColor();
  }

  void draw() {    
    int ty=this.y;
    if(jumping) {
      jumpPos+=min(map(score, 0, 20, 1, 3), 3);
     
      ty = (height-this.heig)-((int) map(pow((jumpPos*jumpScale), 2), jumpY, 0, 0, jumpHeight));
      if(jumpPos >= jumpRangeEnd) {
        jumping=false;
        jumpPos = 0;
      }
    }
      
    
    pushMatrix();
    translate(x+(wid/2), ty+(heig/2));
    if(jumpPos > 0) rotate(radians(-map(this.distance(), 0, this.jumpHeight, 0, 180)));
    if(jumpPos < 0) rotate(radians(-map(this.distance(), 0, this.jumpHeight, 180, 0)));
        fill(r, g, b);
    rect(-(wid/2), -(heig/2), wid, heig);
    popMatrix();

    rotation++;
    if(rotation== 360) rotation=0;
  }
  
 
  
  void jump() {
    if(!jumping) {
      jumping = true;
      jumpPos = jumpRangeStart;
    }
  }
  
  void randomColor() {
        this.r = (int) random(0, 255);
    this.g = (int) random(0, 255);
    this.b = (int) random(0, 255);
  }
  
  boolean collidedWith(DeathTriangle triangle) {
    if(scroll+this.x+this.wid >= triangle.x) {
      int ty = this.y;
      if(jumping) ty = (height-this.heig)-((int) map(pow((jumpPos*jumpScale), 2), jumpY, 0, 0, jumpHeight));
      int relativeX = (scroll+this.x+this.wid)-triangle.x;
      if(scroll+this.x >= triangle.x+(triangle.size/2)) relativeX = (triangle.size-((scroll+this.x)-(triangle.x+(triangle.size/2))));
      println(ty + "+" + this.heig+ ">=" + height + "-" +relativeX);
      println((    ty+   this.heig) + ">="+ (height-relativeX));
      
      

        if(scroll+this.x <= triangle.x+triangle.size) {
          if(ty+this.heig >= (height-relativeX)) {
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
    int ty = this.y;
      if(jumping) ty = (height-this.heig)-((int) map(pow((jumpPos*jumpScale), 2), jumpY, 0, 0, jumpHeight));
    //println(height-(ty+this.heig));
    return (height-(ty+this.heig));
  }
}