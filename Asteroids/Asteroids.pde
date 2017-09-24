import java.util.Iterator;

PVector screenCENTER;
PVector mousePV;

bodyROCKET ship;
bodySystem shoots; // we will include our ship "manually" in the SHOOTS
bodyClashSystem rocks;


void setup() {
  fullScreen();
  screenCENTER=new PVector(width/2, height/2);
  // create the emiter of all shoots
  ship=new bodyROCKET(1);
  // create the container of shoots, and add the ship to it (for easy in moving and drawing)
  shoots=new bodySystem(2);
  shoots.bodies.add(ship);  // first shot is the emiter (a body defined to be eternal and extended to be rotable and drawn triangular)
  // create the container of all the asteroids
  rocks=new bodyClashSystem();
}

void draw() {
  background(0);
  // calculate orientaton from ship to mouse
  mousePV=new PVector(mouseX, mouseY);
  mousePV.sub(ship.pos);
  if (ship.exists()) {
    // make systems run
    shoots.run();  // move all shoots
    rocks.run(shoots);  // move all rocks AGAINST shoots
    // generates (or maybe not) new rocks randomly
    rocks.newBody();
  } else {
    textSize(48);
    textAlign(CENTER,CENTER);
    text("GAME OVER", screenCENTER.x, screenCENTER.y); 
    fill(0, 102, 153);
    noLoop();
  }
}

void mouseClicked() {
  PVector vel=mousePV.copy();
  vel.setMag(2.75);
  shoots.newBody(screenCENTER, vel, 500, 0.5);
}