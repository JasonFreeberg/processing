// Jason Freeberg
// MAT 259 -- Winter 2017
// 3D Visualization with SPL Database

import peasy.*;
PeasyCam cam;

// Setup Constants
float startDistance = 2000;
float maxRadius = 1000;
float maxDepth = -6000;

// Interactivity
boolean spin = false;
float speed = 0.1;
float speedStep = 0.01;
float[] camRotations;

void setup() {
  size(1280, 720, P3D);
  surface.setResizable(true);
  
  cam = new PeasyCam(this, startDistance);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(startDistance + 750);
  
  println("Setup complete.");
  println(width, height);
}

// Constants for viz
float spacing = 1.5;
float step = 0.05;
float i;
float X1, Y1;
float X2, Y2;

void draw() {
  println("Cam distance =" + cam.getDistance());
  background(200, 180, 190);
  drawLabels();
  presentationRotation();
  
  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  i = 150;
  X1 = 0;
  Y1 = 0;
  X2 = 0;
  Y2 = 0;
  int iter = 0;
  int Z = 0;
  
  while ((abs(X2) < maxRadius) && (abs(Y2) < maxRadius)) {
    if((900 < iter) && (iter < 1500)){
      Z = -500;
      stroke(30, 200, 20);
      double scaleParam = startDistance + 300;
      float b = exp(abs((float)(Z/scaleParam)));
      X1 = (i)*sin(i/spacing)*b;
      Y1 = (i)*cos(i/spacing)*b;
      
      X2 = (i)*sin((i+step)/spacing)*b;
      Y2 = (i)*cos((i+step)/spacing)*b;
    }
    else{
      stroke(0, 0, 0); 
      Z = 0;
      X1 = (i)*sin(i/spacing);
      Y1 = (i)*cos(i/spacing);
      
      X2 = (i)*sin((i+step)/spacing);
      Y2 = (i)*cos((i+step)/spacing);
    }

    line(X1, Y1, Z, X2, Y2, Z);
    i += step;
    iter++;
  }
}