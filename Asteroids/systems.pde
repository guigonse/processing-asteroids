/**
 Definition of systems that will manage defined bodies
 */

/** 
 System of bodies (class body); only generates a body after a delay; 
 till then, adding bodies requests are discarded.
 DELAY defined when creating the system.
 */
class bodySystem {
  ArrayList<body> bodies;
  int delay;
  int delayINIT;

  bodySystem(int delayDEF) {
    bodies=new ArrayList<body>();
    delay=0;
    delayINIT=delayDEF;
  }
  void newBody(PVector p, PVector d, float exVAL, float vanVAL) {
    // once created the body (if DELAY has expired) restart DELAY
    if (!(delay>0)) {
      bodies.add(new body(p, d, exVAL, vanVAL));
      delay=delayINIT;
    }
  }
  void run() {
    delay= (delay > 0) ? (delay-1) : 0;  //decrease DELAY till next shoot
    Iterator<body> it=bodies.iterator();
    while (it.hasNext()) {
      body b=it.next();
      b.move();
      if (b.exists()) {
        b.draw();
      } else {
        it.remove();
      }
    }
  }
}
/**
 Extends bodySystem class generating bodyTURNINGs randomly and checking
 its clash with argument's bodySystem
 */
class bodyClashSystem extends bodySystem {
  bodyClashSystem() {
    super(0);  // no delay in creatin new bodies; it's a RANDOM condition...
  }
  void newBody() {
    // only generates new flying rock if RANDOM matches, anywhere else, nothing happens 
    if (random(0, 1)>0.99) {
      PVector newPOS=PVector.random2D().setMag(random(100, 300));
      newPOS.add(ship.pos);  // we generate at an aleatory distance of 100 to 300 from SHIP 
      bodies.add(new bodyTURNING(newPOS, PVector.random2D().setMag(random(0.5, 2)), int(random(1, 3.5))));
    }
  }
  // run all bodies AGAINST another group of bodies
  void run(bodySystem against) {
    // restart iterator, and begin clash control
    Iterator<body> it=bodies.iterator();
    while (it.hasNext()) {
      body rock=it.next();
      for (body shoot : against.bodies) {
        PVector distPV=PVector.sub(rock.pos, shoot.pos);
        float dist=distPV.mag();
        if (dist<rock.size+shoot.size){
          rock.existence=shoot.existence=0;
        }
      }
    }
    super.run();  // and now, take profit of mother class definition
  }
}