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



  colorMode(HSB, 360, 100, 100);
  fill(166, 91, 75);
  rect(0, 0, width, 250);  
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


  fill(mouseX, mouseY, 225);
  ellipse(mouseY, mouseX, 20, 20);
  ellipse(mouseY+50, mouseX+50, 20, 20);
  ellipse(mouseY-50, mouseX-50, 20, 20);
  ellipse(mouseX, mouseY, 20, 20);
  ellipse(mouseX-50, mouseY+50, 20, 20);
  ellipse(mouseX+50, mouseY-50, 20, 20);
}




void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
  }
}
