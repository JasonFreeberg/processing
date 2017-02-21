// Jason Freeberg
// MAT 259 -- Winter 2017
// 3D Visualization with SPL Database

import peasy.*;
import controlP5.*;
PeasyCam cam;
ControlP5 cp5;

// Setup Constants
float startDistance = 5450;
float maxRadius = 1000;
float maxDepth = -6000;
float Nrotations = 330;

// Setup variables
Table table;
int nRows;
float maxDate, minDate;
ArrayList<LibraryItem> libItems = new ArrayList<LibraryItem>();

// Interactivity
boolean spin = false;
float speed = 0.1;
float speedStep = 0.01;
float[] camRotations;
CheckBox checkbox;

void setup() {
  //textMode(SHAPE);
  size(1280, 720, P3D);
  surface.setResizable(true);
  
  cam = new PeasyCam(this, 0, 0, maxDepth/2, startDistance);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(startDistance + 950);

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  checkbox = cp5.addCheckBox("months")
        .setPosition(0, 0)
        .setColorForeground(color(120))
        .setColorActive(color(255))
        .setColorLabel(color(255))
        .setSize(10, 10)
        .setItemsPerRow(6)
        .setSpacingColumn(25)
        .setSpacingRow(5)
        .addItem("Jan", 1)
        .addItem("Feb", 2)
        .addItem("Mar", 3)
        .addItem("Apr", 4)
        .addItem("May", 5)
        .addItem("Jun", 6)
        .addItem("Jul", 7)
        .addItem("Aug", 8)
        .addItem("Sep", 9)
        .addItem("Oct", 10)
        .addItem("Nov", 11)
        .addItem("Dec", 12)
       ;
  
  // Load data to objects
  table = loadTable("transactions.csv", "header");
  nRows = table.getRowCount();
  println("Rows: " + nRows);
  
  minDate = MAX_FLOAT;
  maxDate = MIN_FLOAT;
  for(int i = 0; i < nRows; i++){
    float checkIn = table.getFloat(i, 1);
    float checkOut = table.getFloat(i, 0);
    
    // Change null values to zero, will change in next query
    if(Float.isNaN(checkIn)){checkIn = 0;}
    
    // Get max and min checkouts
    if(checkOut > maxDate){maxDate = checkOut;}
    if(checkIn < minDate && checkIn != 0){minDate = checkIn;}
  }
  
  // Make object for each transaction
  for(int i = 20; i < 1000; i++)
  {
    float checkOut = table.getFloat(i, 0);
    float checkIn = table.getFloat(i, 1);
    if(Float.isNaN(checkIn)){checkIn = 0;} // Change null values to zero, will change in next query
    float popularity = random(1, 20000);
    String genre = "";
    libItems.add(new LibraryItem(minDate, maxDate, checkOut, checkIn, popularity, genre));
  }
  
  for(int i = 0; i < libItems.size(); i++){
    libItems.get(i).getMonths();
  }
  
  DateTime time = new DateTime((long)minDate*1000);
  println("minDate = " + minDate + "==" + time);
  time = new DateTime((long)maxDate*1000);
  println("maxDate = " + maxDate + "==" + time);
  
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
  perspective(PI/6.0, (float) width/height, 1, 100000);
  //println("Cam distance = " + cam.getDistance());
  //println(width + ',' + height);
  background(200, 180, 190);
  drawLabels();
  presentationRotation();
  
  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  
  for(int i = 0; i < libItems.size(); i++){
    //shape(libItems.get(i).segment);
  }
  
  //cam.beginHUD();
  //hint(DISABLE_DEPTH_TEST);
  //pushMatrix();
    cam.beginHUD();
    //translate(360, 465);
    perspective(PI/3.0, (float)width/height, 1, 100000);
    cp5.draw();
    cam.endHUD();
  //popMatrix();
  //hint(ENABLE_DEPTH_TEST);
  
  
}