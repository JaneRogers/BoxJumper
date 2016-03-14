int minDistance = 350;
int maxDistance = 600;
int jumpVelocity = 40;
double gravity = 2.5;

String[] deathNotes = { "You were killed by that spike!!!", "A spike went up your bum!!!", "You were brutally dissected!!!", "Next time bring a jetpack!!!" };
String deathNote = null;
String finalScore = "Score: ";
int size=100;

boolean active = true;

boolean killed = false;

boolean messagePlayed = false;

double friction = .0;
int scroll = 0;
int score = 0;
int deathOpacity = 0;

Box player;
DeathTriangle[] triangle;
void setup() {
  size(displayWidth, displayHeight, P2D);
  player = new Box(100, height-size, size, size, 0, 0);
  smooth();
  triangle = new DeathTriangle[10];
  int lastX = width;
  for (int i=0; i<triangle.length; i++) {
    int xpos = lastX+(int) random(minDistance, maxDistance);
    triangle[i] = new DeathTriangle(xpos, height-100);
    lastX = xpos;
  }
}

void draw() {
  background(72, 224, 38);
  player.draw();
  fill(255);
  textSize(60);
  text(score, 60, 60);
  if (active) scroll+=10;
  if (!killed) {
    if (processTriangles()) {
      background(255, 0, 0);
      deathNote = deathNotes[ (int) random(0, deathNotes.length)]; 
      return;
    }
  }
  
  if (killed) {
    background(255, 0, 0);
    fill(255, 255, 255, deathOpacity);
    textSize(60);
    float twidth = textWidth(deathNote)/2;
    text(deathNote, width/2-twidth, height/4);
    noStroke();
    ellipse(width/2-50, height/2-50, 50, 50); // Left eye
    ellipse(width/2+50, height/2-50, 50, 50); // Right eye
    strokeWeight(5);
    bezier(width/2-50, height/2, width/2-50, height/2+50, width/2+50, height/2+50, width/2+50, height/2);

    String temp = finalScore+score;
    float scoreWidth = textWidth(temp)/2;
    text(finalScore+score, width/2-scoreWidth, height/2+200);
    
    
    if(deathOpacity<255) deathOpacity+=5;
    else {
      if(!messagePlayed) {
        try { 
          Runtime.getRuntime().exec("say -v zarvox '"+deathNote+"'");
        } catch(java.io.IOException e) {
        }
        messagePlayed = true;
      }
    }
    
  }
}

void keyPressed() {
  if (key == ' ') {
    if (player.yvol == 0) player.yvol-=jumpVelocity;
  }
  if (key == 'b') background(72, 224, 38);
  if (key == 'p') active = !active;
  if(key == 'r') {
    reset();
  }
}

void reset() {
  resetTriangles();
  active = true;
    killed = false;
    deathOpacity=0;
  score=0;
  messagePlayed = false;
  deathNote = null;
}

void resetTriangles() {
    scroll = 0;
  triangle = new DeathTriangle[5];
  int lastX = width;
  for (int i=0; i<triangle.length; i++) {
    int xpos = lastX+(int) random(minDistance, maxDistance);
    triangle[i] = new DeathTriangle(xpos, height-100);
    lastX = xpos;
  }
}

boolean processTriangles() {
  boolean onScreen = false;

  for (int i=0; i<triangle.length; i++) {
    if (!triangle[i].passedScreen()) onScreen = true;
    if (player.collidedWith(triangle[i])) {
      active = false;
      killed = true;
      return true;
    }
    triangle[i].draw();
  }
  if (!onScreen) resetTriangles();
  return false;
}