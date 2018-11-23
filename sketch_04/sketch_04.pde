PFont font;
PFont fuente;
PFont tipo;




void setup() {
  size(400, 600);
  background(255);
  font = loadFont("AkzidenzGrotesk-Bold-60.vlw"); //para BOLD
  fuente = loadFont("AkzidenzGrotesk-Light-60.vlw"); //light
  tipo = loadFont("AkzidenzGrotesk-Roman-60.vlw"); //regular
  colorMode(HSB);
}



void draw() {

noStroke();

  

    colorMode(HSB, 360, 100, 100);
    fill(0, 0, 100);
    rect(0, 0, width, 220);  
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


  fill(255, 10);
  rect(0, 220, width+1, height+1);
  translate(width/2, 400);
  for (int x = -100; x <= 100; x+=10) {
    for (int y = -100; y <= 100; y+=10) {
      float d = dist(x, y, 0, 0);
      float d2 = sin(radians(d))*d;
      stroke(0, 150, 255, 255-d2*3);

      pushMatrix();
      translate(x*2, y*2);
      rotate(radians(frameCount));
      line(x, y, 0, 0);
      popMatrix();
      
      pushMatrix();
      translate(x*2, y*2);
      rotate(radians(-frameCount));
      line(x, y, 0, 0);
      popMatrix();
    }
  }

  }



void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
  }
}
