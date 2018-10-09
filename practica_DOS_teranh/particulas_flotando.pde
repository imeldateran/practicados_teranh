class Circulo {


  Body body;
  float w;
  float h;

  Circulo(float x, float y) {
    w = random(8, 16);
    h = w;
  
    makeBody(new Vec2(x, y), w, h);
  }

  void killBody() {
    box2d.destroyBody(body);
  }


  boolean done() {
  
    Vec2 pos = box2d.getBodyPixelCoord(body);  
   
    if (pos.y > height+w*h) {
      killBody();
      return true;
    }
    return false;
  }

  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }


  void display() {
   
    Vec2 pos = box2d.getBodyPixelCoord(body);
 
    float a = body.getAngle();

    ellipseMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(random(23,189));
    stroke(0);
    ellipse(0, 0, w, h);
    popMatrix();
  }


  void makeBody(Vec2 center, float w_, float h_) {

  
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.2;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.angle = random(TWO_PI);

    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(0,-5));
    
  }
  void Fuerza(){

  Vec2 pos = box2d.getBodyPixelCoord(body);
  if(pos.y<=0){
    body.setLinearVelocity(new Vec2(0,-40));
    
  }
else {
if (pos.y>=360){
   body.setLinearVelocity(new Vec2(0,40));
}
}
  }
}
