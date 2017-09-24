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
    if !(delay>0) {
      bodies.add(new body(p, d, exVAL, vanVAL);
      delay=delayINIT;
    }
  }
  void run(){
    Iterator<body> it=bodies.iterator();
    while (it.hasNext()){
      body b=it.next();
      b.move();
      if (b.exists()){
        b.draw();
      } else {
        it.remove();
      }
    }
  }