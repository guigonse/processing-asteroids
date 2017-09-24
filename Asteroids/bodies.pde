/**
 Definition of all the classes that wil incarnate the visual
 elements of the game.
 */

// constant variable to store perimeters (how could it remain in class "bodyTURNING"
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
  void move() {
    pos.add(dir);
    pos.x= (pos.x<0)? width+pos.x : pos.x % width;
    pos.y= (pos.y<0)? height+pos.y : pos.y % height;
    existence-=vanish;
  }
  void draw() {
    // ellipse order is the easiest one...
    stroke(int(map(existence, 0, existINIT, 0, 255)));
    strokeWeight(2);
    noFill();
    ellipse(pos.x, pos.y, size, size);
    /* nine point body version; 1 point looked minuscule
     int[] i={-1, 0, 1};
     for (int x : i) { 
     for (int y : i) {
     point(pos.x+x, pos.y+y);
     }
     }*/
  }
  boolean exists() {
    return existence>0;
  }
}
/**
 Class "bodyROT" extends "body" making it rotable and drawing
 itself as a triangle with higed bottom (we'll put there the flame :-)
 It defines itself of size 10, which is used in drawing.
 */
class bodyROT extends body {
  float ang;
  bodyROT(PVector p, PVector d, float exVAL) {
    super(p, d, exVAL, 0);
    ang=0;
    size=10;
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
  }
  void orient(float angVAL) {
    ang=angVAL;
  }
}
/**
 Class "bodyTURNING" extends "bodyROT" including an aleatory angular
 speed to keep it rotating; "size" becames 10 times the degree of existence
 and it draws itself from irregular perimeter matrix definitions scaled
 */
class bodyTURNING extends bodyROT {
  float angINC;
  bodyTURNING(PVector p, PVector d, float exVAL) {
    super(p, d, exVAL);
    ang=random(0, TWO_PI);
    angINC=random(0.01, 0.1)  ;
    size=int(10*exVAL);
    vanish=0.001;
  }
  void move(){
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
    // "scale()" deforms stroke weights; will do it manually...
    //scale(size/3);
    //strokeWeight(12/size);
    beginShape();
    for (int[] v : perimeter) {
      vertex(v[0]*scale, v[1]*scale);
    }
    endShape(CLOSE);
    popMatrix();
  }
}