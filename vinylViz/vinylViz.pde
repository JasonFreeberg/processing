// Jason Freeberg
// MAT 259
// Winter 2017

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
  cam.setMaximumDistance(1500);
}

// Constants for viz
float spacing = 3.0;
float step = 0.05;
float i;
float X1, Y1;
float X2, Y2;

void draw() {
  background(30, 5, 5);

  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  int iter = 0;
  int Z = 0;
  i = 0;
  X1 = 0;
  Y1 = 0;
  X2 = 0;
  Y2 = 0;
  
  while ((abs(X2) < (width - hMargin)) && (abs(Y2) < (height - vMargin))) {
    if((10 < iter) && (iter < 500)){
      Z = 400;
      stroke(30, 200, 20);
    }
    else stroke(50, 50, 200); Z = 0;
    X1 = (i)*sin(i/spacing);
    Y1 = (i)*cos(i/spacing);

    X2 = (i)*sin((i+step)/spacing);
    Y2 = (i)*cos((i+step)/spacing);
    
    line(X1, Y1, Z, X2, Y2, Z); // Now two Z params can be added
    i += step;
    iter++;
  }

  println(X1, ',', Y1);
  println('*', width, ',', height);
}