/**
 Definition of all the classes that wil incarnate the visual
 elements of the game.
 */

// constant variable to store perimeters (how could it remain in class "bodyTURNING"?)
int[][] perimeter={{1, 2}, {0, 3}, {-2, 2}, {-3, 0}, {-3, -1}, {-1, -2}, {0, -3}, {2, -3}, {3, -1}, {2, 2}};

/**
 Class "body" will be the basis for the rest: it moves, keeps
 track of existence degree and vanishes as per an arbitrarian
 value; it defines itself of size 1 and draws as a so radius
 circle.
 */
class body {   // basis body to inherit the rest
  PVector pos;  // position in the screen
  PVector dir;  // direction of movement, included velocity
  float existence;
  float existINIT;
  float vanish;
  int size;

  body(PVector p, PVector d, float exVAL, float vanVAL) {
    pos=p.copy();
    dir=d.copy();
    existence=existINIT=exVAL;
    vanish=vanVAL;
    size=1;
  }
  void move() {  // moves till the border and rounds 
    pos.add(dir);
    pos.x= (pos.x<0)? width+pos.x : pos.x % width;
    pos.y= (pos.y<0)? height+pos.y : pos.y % height;
    existence-=vanish;
  }
  void draw() {
    // ellipse order is the easiest one...
    stroke(int(map(existence, 0, existINIT, 128, 255)));
    strokeWeight(2);
    noFill();
    ellipse(pos.x, pos.y, size, size);
  }
  boolean exists() {
    return existence>0;
  }
}
/**
 Class "bodyTURNING" extends "body" including an aleatory angular
 speed to keep it rotating; "size" becames 10 times the degree of existence
 and it draws itself from irregular perimeter matrix definitions scaled
 */
class bodyTURNING extends body {
  float ang;
  float angINC;
  bodyTURNING(PVector p, PVector d, float exVAL) {
    super(p, d, exVAL, 0);
    ang=random(0, TWO_PI);
    angINC=random(0.01, 0.1);
    size=int(10*exVAL);
  }
  void move() {
    super.move();
    ang+=angINC;
  }
  void draw() {
    int scale=size/3;
    stroke(255);
    strokeWeight(1);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(ang);
    beginShape();
    for (int[] v : perimeter) {
      vertex(v[0]*scale, v[1]*scale);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
/**
 Class "bodyROCKET" extends "bodyROT" with acceleration in the direction it
 points, friction and drawing itself as a triangle with higed bottom (we'll
 put there the flame :-) pointing to the mouse position.
 It defines itself of size 10, which is used in drawing.
 */
class bodyROCKET extends bodyTURNING {
  float dirACC;
  boolean accelerating=false;
  bodyROCKET(float exVAL) {
    super(screenCENTER.copy(), new PVector(0, 0), exVAL);
    ang=0.0;
    angINC=0.0;
    size=10;
    dirACC=0.0;
  }
  void accel(float acc) {
    if (dirACC==0) {
      dirACC=1.0;
    }
    dirACC *= acc;
    accelerating=true;
  }
  void move() {
    ang=mousePV.heading();
    if (accelerating) {
      if (dir.mag()==0) {
        dir.x=1.0;
        dir.rotate(ang);
      }
    }
    if (mouseButton!=RIGHT) {  // if we have released RIGHT mouse, stop accelerating
      accelerating=false;
    }
    dirACC *= 0.99;  // always reduces acceleration (so velocity increment) or it remains null (both)
    dir.mult(dirACC);
    super.move();
  }
  void draw() {
    stroke(255);
    strokeWeight(1);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(ang);
    beginShape();
    vertex(0, 0);
    vertex(-size/2, +size/1.5);
    vertex(size, 0);
    vertex(-size/2, -size/1.5);
    endShape(CLOSE);
    popMatrix();
    // ASSERTing variable value
    textSize(12);
    textAlign(LEFT, BASELINE);
    text(" "+dirACC+"*("+dir.x+","+dir.y+")", pos.x, pos.y);
  }
}