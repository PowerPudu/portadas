graphics_1[] myGraphis;

int i_count;
Boolean b_click=false;
color[] c_c = {#0077FF, #00FFFF, #00FF5D, #3C0E69};

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
 i_count=50;
  myGraphis = new graphics_1[i_count];
}

float rt = 0;
void draw() {
  colorMode(HSB, 360, 100, 100);
  fill(182,76,44);
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

  noStroke();

  if (b_click) {

    for (int i=0; i<myGraphis.length; i++) {
      myGraphis[i].run();
    }
    bg=0;
    
  } else {
    
    fill(#E3E3E3, bg=lerp(bg, 100, 0.001f) );
    rect(0, 0, width, height);
    
  }

}

float bg=0;

void mousePressed() {

  for (int i=0; i<myGraphis.length; i++) {
    int p=(int)random(0, 4);
    myGraphis[i] = new graphics_1(new PVector(mouseX, mouseY), c_c[p]);
  }

  b_click=true;
}





class graphics_1 {

  PVector p_orgPos;
  float f_pointSize=0;
  float f_angle;
  float f_threshold=0.2f;
  float f_decrease;
  float test;
  float f_growSpeed;
  color c_color;
  float lifespan;

  graphics_1(PVector pos, color col) {

    p_orgPos = new PVector(0, 0);
    p_orgPos = pos;   
    f_pointSize = random(30, 80);
    //f_pointSize=80;
    f_angle = random(TWO_PI);
    f_decrease = random(3, 10);
    test=0;

    c_color = col;
    lifespan = 255.0;
    f_growSpeed=Math.round(random(1, 3));
    //println("loc " + p_orgPos.x + " " + p_orgPos.y +" "+ f_angle +" "+ f_decrease);
  }

  void run() {
    show();
    update();
  }

  void update() {

    if (f_pointSize>0 && frameCount%f_growSpeed==0) {

      f_angle+=random(-f_threshold, f_threshold);
      f_pointSize-=f_decrease;
      test+=20*noise(frameCount, 2, 3);
    }
    lifespan -= 1.0;
  }

  void show() {

    PVector tmpPos = new PVector( p_orgPos.x + (test)*cos(f_angle), 
      p_orgPos.y + (test)*sin(f_angle));

    //fill(map(f_pointSize, 0, 80, 220, 60), 90);
    //strokeWeight(0.1f);
    //stroke(#E3E3E3);
    
    fill(c_color, 90-f_pointSize);
    ellipse(tmpPos.x, tmpPos.y, f_pointSize, f_pointSize);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }}

void keyPressed() {
  if (key == 'p') {
    saveFrame("sketch-##.png");
      b_click=false;
  }
}
