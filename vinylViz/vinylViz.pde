// Jason Freeberg
// MAT 259 -- Winter 2017
// 3D Visualization with SPL Database
import peasy.*;
PeasyCam cam;

// Setup Constants
float startDistance = 2000;
float maxRadius = 1000;
float maxDepth = -6000;
double scaleParam = startDistance + 300;
float Nrotations = 330;

// Setup variables
Table table;
int nRows;
float maxDate, minDate;
ArrayList<LibraryItem> libItems = new ArrayList<LibraryItem>();
ArrayList<DummySegments> dummies = new ArrayList<DummySegments>();

// Interactivity
boolean spin = false;
float speed = 0.1;
float speedStep = 0.01;
float[] camRotations;

void setup() {
  
  size(1280, 720, P3D);
  surface.setResizable(true);
  
  cam = new PeasyCam(this, startDistance);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(startDistance + 950);
  
  // Load data to objects
  table = loadTable("transactions.csv", "header");
  nRows = table.getRowCount();
  println("Rows: " + nRows);
  
  minDate = MAX_FLOAT;
  maxDate = MIN_FLOAT;
  for(int i = 0; i < nRows; i++){
    float checkIn = table.getFloat(i, 1);
    float checkOut = table.getFloat(i, 0);
    
    if(Float.isNaN(checkIn)){checkIn = 0;}
    
    if(checkOut > maxDate){maxDate = checkOut;}
    if(checkIn < minDate && checkIn != 0){minDate = checkIn;}
  }
  
  println("maxDate = " + maxDate);
  println("minDate = " + minDate);
  
  for(int i = 20; i < 10000; i++)
  {
    float checkOut = table.getFloat(i, 0);
    float checkIn = table.getFloat(i, 1);
    if(Float.isNaN(checkIn)){ println("Skip" + i); continue; }
    float popularity = random(1, 20000);
    String genre = "";
    libItems.add(new LibraryItem(minDate, maxDate, checkOut, checkIn, popularity, genre));
  }
  
  //for(int i = 0; i < 10; i++){
  //  dummies.add(new DummySegments(minDate, maxDate));
  //}
 
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
  perspective(PI/3.0, (float) width/height, 1, 100000);
  println("Cam distance = " + cam.getDistance());
  background(200, 180, 190);
  drawLabels();
  presentationRotation();
  
  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  
  for(int i = 0; i < libItems.size(); i++){
    
    shape(libItems.get(i).segment);
    
  }
}