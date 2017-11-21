import java.util.Iterator;

PVector screenCENTER;
PVector mousePV;

bodyROCKET ship;
bodySystem shoots; // we will include our ship "manually" in the SHOOTS
bodyClashSystem rocks;

int flash=0;


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
  // verify if ship is alive
  if (ship.exists()) {
    // make systems run
    shoots.run();  // move all shoots
    rocks.run(shoots);  // move all rocks AGAINST shoots (including SHIP ;-)
    // generates (or maybe not) new rocks randomly
    rocks.newBody();
  } else {
    textSize(48);
    textAlign(CENTER, CENTER);
    flash=(flash>16) ? 0 : (flash+1);
    fill(abs(map(flash, 0, 16, -255, 255)));
    text("GAME OVER", screenCENTER.x, screenCENTER.y); 
    //noLoop();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    PVector vel=mousePV.copy();
    vel.setMag(2.75);
    shoots.newBody(ship.pos, vel, 500, 1.0);
  } else if (mouseButton == RIGHT) {
    ship.accel(1.1);
  }
}