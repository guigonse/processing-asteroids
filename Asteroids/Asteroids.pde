import java.util.Iterator;

ArrayList<body> horde=new ArrayList<body>();
PVector screenCENTER;
PVector mousePV;
bodyROCKET ship;

void setup() {
  fullScreen();
  screenCENTER=new PVector(width/2, height/2);
  ship=new bodyROCKET(255);
  horde.add(ship);  // first shot is the emiter (a body defined to be eternal and extended to be rotable and drawn triangular
}

void draw() {
  background(0);
  mousePV=new PVector(mouseX, mouseY);
  mousePV.sub(ship.pos);
  Iterator<body> it=horde.iterator();
  while (it.hasNext()) {
    body b=it.next();
    if (b.exists()) {
      b.move();
      b.draw();
    } else {
      it.remove();
    }
  }
  if (random(0, 1)>0.99) {
    horde.add(new bodyTURNING(PVector.random2D(), PVector.random2D().setMag(random(0.5, 2)), int(random(1, 3.5))));
  }
}

void mouseClicked() {
  PVector vel=mousePV.copy();
  vel.setMag(2.75);
  horde.add(new body(screenCENTER, vel, 500, 0.5));
}