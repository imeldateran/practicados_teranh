import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
Box2DProcessing box2d;
Craneo box;

PImage textura;
PImage grafico;
PImage grafico1;
PImage grafico2;
PImage grafico3;
PImage texto;
PImage texto2;
ArrayList<Circulo> circulos;
Particle particula;
Spring spring;
float xoff = 0;
float yoff = 1000;
int contador ;
int suma;
int contadorp ;
int sumap;
PFont f;
PImage bg;

void setup() {
  size(500,400);
  bg = loadImage("fondo.jpg");

  smooth();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
   box2d.listenForCollisions();
   
  circulos = new ArrayList<Circulo>();
  contador = 0;
  suma=0;
  contadorp = 0;
  sumap=1;
 
  textura = loadImage("muerte.png");
  grafico = loadImage("cuesta1.png");
  grafico1 = loadImage("werner.png");
  grafico2 = loadImage("alejandra.png");
  texto = loadImage("texto1.png");
  texto2 = loadImage("texto2.png");

  
  // Make the box
  box = new Craneo(width/2,height/2);
  spring = new Spring();
  spring.bind(width/2,height/2,box
  );
  
  particula = new Particle (100,100,8);
 
}

void draw() {

  background(bg);
     fill(255,0,0);
 textSize(10);
 f = createFont("Algerian", 10);
textFont(f);
 text("Maneja el craneo con mouse",35,380);
  text("Intenta derribar al personaje",35,390);
   box2d.setGravity(0, 0.1);
  
  if (random(1) < 0.1) {
    Circulo p = new Circulo(random(width),10);
    circulos.add(p);
  }
  
  if (mousePressed) {
    for (Circulo b: circulos) {
     Vec2 wind = new Vec2(10,0);
     b.applyForce(wind);
    }
  }
  for (Circulo b: circulos) {
    b.display();
  }
for (int i = circulos.size()-1; i >= 0; i--) {
    Circulo b = circulos.get(i);
    if (b.done()) {
      circulos.remove(i);
    }
  }

 contador = contador+suma; 
 if (contador<=70 && contador!=0){
   if (contador ==70) {
     suma=0;
   contador=0; 
   }
   imageMode(CENTER);
   image(texto, 260, 300);
     
 }
  particula.display();
  
  box2d.step();

  
  float x = noise(xoff)*width;
  float y = noise(yoff)*height;
  xoff += 0.01;
  yoff += 0.01;

  
  if (mousePressed) {
    spring.update(mouseX,mouseY);
    spring.display();
  } else {
    spring.update(x,y);
  }
  box.body.setAngularVelocity(0.0);
  box.display();

  
}



void beginContact(Contact cp) {
 
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
 
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

 
  if (o1.getClass() == Craneo.class) {
    Particle p = (Particle) o2;
    p.change();
    suma=1;
    image(texto, 0, 0);
  } 

  else if (o2.getClass() == Craneo.class) {
    Particle p = (Particle) o1;
    p.change();
    suma=2;
    image(texto2, 0, 0);
  }
}

void endContact() {
 contadorp= contadorp+sumap;
 
 if (contadorp>1){
   sumap=2;
     image(grafico1, 160, 100);
      image(texto2, 0, 0); 
}
}
