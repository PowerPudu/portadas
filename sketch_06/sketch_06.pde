PFont font;
PFont fuente;
PFont tipo;


Rings[] rings = new Rings[10];
int centreX = 300;
int centreY = 300;
int ticker = 0;

void setup() {
  size(400, 600);
  background(0);
  font = loadFont("AkzidenzGrotesk-Bold-60.vlw"); //para BOLD
  fuente = loadFont("AkzidenzGrotesk-Light-60.vlw"); //light
  tipo = loadFont("AkzidenzGrotesk-Roman-60.vlw"); //regular
  colorMode(HSB);
   for (int i = 0; i < rings.length; i++) {
    rings[i] = new Rings();
  }
}



void draw() {
  
  ++ticker;
  centreX = mouseX;
  centreY = mouseY;

  fill(0, 10);
  rect(-5, -5, 610, 610);
  stroke(255);
  strokeWeight(2);
  
    for (int i = 0; i < rings.length; i++) {
    rings[i].update();
    rings[i].show(); 
  }
}

class Rings {
  float x, y, z;
  float r, g, b;
  float rad;
  float radStep;

  Rings () {
    rad = 50;
    radStep = random(2, 8);
    x = random(centreX-5, centreX+5);
    y = random(centreY-5, centreY+5);
    r = random(1,180);
    g = random(1,1);
    b = random(1,256);
  }



  void update() {
    rad += radStep;
    if (rad > 1200 || rad < 50) {
      radStep *= -1;
      x = random(centreX-5, centreX+5);
      y = random(centreY-5, centreY+5);
      }
    }

  void show() {
    noFill();
    stroke(366, 65, 100);
    ellipse(x, y, rad, rad);
    
    colorMode(HSB, 360, 100, 100);
  fill(144, 0, 0);
  noStroke();
  rect(0, 0, width, 240);  
  fill(146, 27, 91);  
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
  }
}


void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
  }

}
