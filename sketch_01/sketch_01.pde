
import java.util.Iterator;

final float MAX_PARTICLES = 500; // ADD
final float MAX_TRIANGLES = 1000; //500 // ADD
final float MAX_PARTICLE_SPEED = 1.5;// 1.0;
final float SIZE = 1;//2;
final float LIFESPAN_DECREMENT = 1.0;//.5; //2.0
final float MAX_TRI_DISTANCE = 50;//50; //35 //25; 
final float MIN_TRI_DISTANCE = 10;//15; //10
final int MAX_PARTICLE_NEIGHBOURS = 10; //5;//10;//5;
final int MAX_WANDERER_SPEED = 4;//4;
final int SPAWN_DELAY = 20; //10
final int PARTICLE_LIFESPAN = 255;

ParticleSystem system = new ParticleSystem();
TriangleSystem triangles = new TriangleSystem();
Wanderer spawner = new Wanderer();

/* Global colour object */
ColourGenerator colour = new ColourGenerator();

PFont font;
PFont fuente;
PFont tipo;


void setup() {
  size(400, 600);
  background(255);
  font = loadFont("DINPro-Bold-60.vlw"); //para BOLD
  fuente = loadFont("DINPro-Light-60.vlw"); //light
  tipo = loadFont("DINPro-60.vlw"); //regular
  colorMode(HSB);
frameRate(60);
  noStroke();
  smooth();
}
float rt = 0;
void draw() {
  colorMode(HSB, 360, 100, 100);
  fill(0, 0, 100);
  rect(0, 0, width, 300);  
  fill(0, 100, 0);  
  textFont(tipo, 48);  
  textSize(18);
  textLeading(12);
  text("a Pelican Book", 100, 50);
  textFont(font, 48);  
  textSize(46);
  textLeading(42);
  text("The Last\nResource", 100, 100);
  textSize(17);
  textLeading(20);
  text("Man's Exploitation of the Oceans", 100, 170);
  textSize(24);
  textLeading(24);
  textSize(20);
  text("Tony Loftas", 100, 210);
 triangles.clear();
  spawner.update();
  system.addParticle(new PVector(spawner.loc.x, spawner.loc.y));

system.update();
  triangles.display();
}

float amplify(float n) {
  return constrain(2 * n, 0, 255);
}



class ColourGenerator
{
  final static float MIN_SPEED = 0.2;
  final static float MAX_SPEED = 0.7;
  float R, G, B;
  float Rspeed, Gspeed, Bspeed;

  ColourGenerator()
  {
    init();
  }

  public void init()
  {
    
    R = random(255);
    G = random(255);
    B = random(255);

    // Starting transition speed
    Rspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Gspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Bspeed = (random(1) > 0.5 ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
  }

  public void update()
  {
    // Use transition to alter original colour (Keep within RGB bounds)
    Rspeed = ((R += Rspeed) > 255 || (R < 0)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 0)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 0)) ? -Bspeed : Bspeed;
  }
}

class Particle
{
  PVector velocity = new PVector(random(-MAX_PARTICLE_SPEED, MAX_PARTICLE_SPEED), random(-MAX_PARTICLE_SPEED, MAX_PARTICLE_SPEED));
  PVector pos;
  int lifespan = PARTICLE_LIFESPAN;
  //ColourGenerator colour = new ColourGenerator();

  // Stores nearby particles, for drawing triangles
  ArrayList<Particle> neighbours;

  Particle(PVector origin)
  {
    pos = origin;
  }

  void move()
  {
    // Apply velocity to particle
    pos.add(velocity);

    // Wrap around screen
    if (pos.x > width)
      pos.x -= width;
    if (pos.x < 0)
      pos.x += width;
    if (pos.y > height)
      pos.y -= height;
    if (pos.y < 0)
      pos.y += height;

    // Decrease particle lifespan
    lifespan -= LIFESPAN_DECREMENT;
  }

  void display()
  {
    //colour.update();
    noFill();
    fill(colour.R, colour.G, colour.B, lifespan);
    ellipse(pos.x, pos.y, SIZE, SIZE);
  }

  boolean isDead()
  {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();


  ParticleSystem() {
  }

  /* Add a particle to the particle system */
  void addParticle(PVector loc)
  {
    if (particles.size() < MAX_PARTICLES) {
      Particle part = new Particle(loc);

      for (int i = 0; i < SPAWN_DELAY; i++) {
        part.move();
      }
      particles.add(part);
    }
  }

  /* Discover and draw triangles between particle neighbours */
  void discoverNeighbours()
  {
    Particle p1, p2;

    // Work out neighbours/triangles for each particle
    for (int x = 0; x < particles.size(); x++) {
      p1 = particles.get(x);

      // Clear neighbours
      p1.neighbours = new ArrayList<Particle>();

      // Add particle itself to list of its neighbours (so traingles form using this particle)
      p1.neighbours.add(p1);

      // For other particles
      for (int y = x + 1; y < particles.size(); y++) {
        p2 = particles.get(y);

        float distance = PVector.dist(p1.pos, p2.pos);

        // If particle is within max distance 
        if (distance > MIN_TRI_DISTANCE && distance < MAX_TRI_DISTANCE)
        {
          // Add to neighbours
          p1.neighbours.add(p2);
        }
      }
      if (p1.neighbours.size() > 1 && p1.neighbours.size() < MAX_PARTICLE_NEIGHBOURS) {
        triangles.addTriangles(p1.neighbours);
      }
    }
  }

  /* Update Particle System */
  void update()
  {

    Iterator<Particle> i = particles.iterator();

    // Loop through particles and remove inactive particles
    while (i.hasNext()) {
      // Get next particle
      Particle p = i.next();

      // update position and lifespan
      p.move();

      // Remove particle if dead
      if (p.isDead()) {
        i.remove();
      } else {
        p.display();
      }
    }

    // Update the colour of the particle system
    colour.update();

    // Discover neighbours and draw triangles
    discoverNeighbours();
  }
}

class Triangle
{
  PVector A, B, C;

  Triangle(PVector p1, PVector p2, PVector p3)
  {
    A = p1;
    B = p2;
    C = p3;
  }

  void display()
  {
    vertex(A.x, A.y);
    vertex(B.x, B.y);
    vertex(C.x, C.y);
  }
}

class TriangleSystem
{
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();

  void addTriangles(ArrayList<Particle> neighbours)
  {
    
    int size = neighbours.size();

  
    if (size > 2)
    {
      for (int i = 1; i < size - 1; i++)
      {
        for (int j = i + 1; j < size; j++)
        {
          if (triangles.size() < MAX_TRIANGLES) {
            
            triangles.add(new Triangle(neighbours.get(0).pos, neighbours.get(i).pos, neighbours.get(j).pos));
          }
        }
      }
    }
  }

  void display() 
  {
    noStroke();
    stroke(max(colour.R, 0), max(colour.G, 0), max(colour.B, 0), 13);
    fill(amplify(colour.R), amplify(colour.G), amplify(colour.B), 30);
    //noFill();

    beginShape(TRIANGLES);
    for (int i = 0; i < triangles.size(); i++)
    {
      Triangle t = triangles.get(i);
      t.display();
    }
    endShape();
  }

  void clear()
  {
    // Clear triangles
    triangles = new ArrayList<Triangle>();
  }
}

class Wanderer {
  PVector loc;
  PVector vel;
  PVector acc;

  float angle;

  Wanderer() 
  {
    loc = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update()
  {
   
    angle += random(0, TWO_PI);
    float magnitude = random(0, 1.5); //3

    
    acc.x += cos(angle) * magnitude;
    acc.y += sin(angle) * magnitude;

    
    acc.limit(3);

   
    vel.add(acc);
    vel.limit(MAX_WANDERER_SPEED);//6);

   
    loc.add(vel);

   
    if (loc.x > width)
      loc.x -= width;
    if (loc.x < 0)
      loc.x += width;
    if (loc.y > height)
      loc.y -= height;
    if (loc.y < 0)
      loc.y += height;
  }

  void display() {
    fill(0);
    ellipse(loc.x, loc.y, 10, 10);
  }
}



 
void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
  }
}
