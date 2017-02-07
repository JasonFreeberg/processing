// Dummy test


import peasy.*;

PeasyCam cam;

// Setup Constants
float vMargin = 80;
float hMargin = 160;

void setup() {
  size(1280, 720, P3D);
  surface.setResizable(true);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}

// Constants for viz
float spacing = 3.0;
float step = 0.5;
float i;
float X1, Y1;
float X2, Y2;

void draw() {
  background(30, 5, 5);

  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  i = 0;
  X1 = 0;
  Y1 = 0;
  X2 = 0;
  Y2 = 0;

  while ((abs(X2) < (width - hMargin)) && (abs(Y2) < (height - vMargin))) {
    X1 = width/2 + (i)*sin(i/spacing);
    Y1 = height/2 + (i)*cos(i/spacing);

    X2 = width/2 + (i+1)*sin((i+step)/spacing);
    Y2 = height/2 + (i+1)*cos((i+step)/spacing);

    line(X1, Y1, X2, Y2); // Now two Z params can be added
    i += step;
  }
  
  i = 0;
  X1 = 0;
  Y1 = 0;
  X2 = 0;
  Y2 = 0;
  while ((abs(X2) < (width - hMargin)) && (abs(Y2) < (height - vMargin))) {
    X1 = width/2 + (i)*sin(i/spacing);
    Y1 = height/2 + (i)*cos(i/spacing);

    X2 = width/2 + (i+1)*sin((i+step)/spacing);
    Y2 = height/2 + (i+1)*cos((i+step)/spacing);

    line(X1, Y1, X2, Y2, 0,0); // Now two Z params can be added
    i += step;
  }

  println(X1, ',', Y1);
  println('*', width, ',', height);
}