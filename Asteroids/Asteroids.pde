import java.util.Iterator;

ArrayList<body> horde=new ArrayList<body>();
PVector screenCENTER;
PVector mousePV;
bodyROT emiter;

void setup() {
  size (1024, 600);
  screenCENTER=new PVector(width/2, height/2);
  emiter=new bodyROT(screenCENTER, new PVector(0,0),255);
  horde.add(emiter);  // first shot is the emiter (a body defined to be eternal and extended to be rotable and drawn triangular 
}

void draw() {
  background(0);
  mousePV=new PVector(mouseX, mouseY);
  mousePV.sub(screenCENTER);
  emiter.orient(mousePV.heading());
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
  if (random(0,1)>0.99){
    horde.add(new bodyTURNING(PVector.random2D(),PVector.random2D().setMag(random(0.5,2)),int(random(1,3.5))));
  }
}

void mouseClicked(){
  PVector vel=mousePV.copy();
  float life=vel.mag();
  vel.div(100);
  //print(screenCENTER,vel,life,"\n");
  horde.add(new body(screenCENTER,vel,life,life/1000));
}
  