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
  fill(96, 0, 100);
  rect(0, 250, width, height);

  float curveWidth = 10.0;
  float curveThickness = 10.0;
  float angleOffset = 0.9;

  float angleIncrement = map(mouseY, 0, height, 0.0, 0.2);
  float angleA = 0.0;
  float angleB = angleA + angleOffset;

  float k = map(mouseX, 0, width, 2.0, 4.0);

  for (int i = 0; i < height; i += curveWidth*k) {
    float waveColor = map(i, 0, mouseY+10, 0, 255);
    noStroke();

    pushMatrix();
    translate(0, 400);
    fill(waveColor);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      //float y1 = i + (sin(angleA)* curveWidth);
      //float y2 = i + (sin(angleB)* curveWidth);
      float y1 = i + (sin(angleB) * curveWidth);
      float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();

    pushMatrix();
    scale(1.0, -1.0);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      //float y1 = i + (sin(angleA)* curveWidth);
      //float y2 = i + (sin(angleB)* curveWidth);
      float y1 = i + (sin(angleB) * curveWidth);
      float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();
    popMatrix();
    popMatrix();



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
  }
}


void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
  }
}
