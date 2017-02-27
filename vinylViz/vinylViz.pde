// Jason Freeberg
// MAT 259 -- Winter 2017
// 3D Visualization with SPL Database

import peasy.*;
import controlP5.*;
import ddf.minim.*;

PeasyCam cam;
ControlP5 cp5;
Minim minim;
AudioPlayer player;

// Setup Constants
float startDistance = 6400;
float maxRadius = 1000;
float maxDepth = -6000;
float Nrotations = 330;

// Setup variables
Table table, counts;
int nRows, nRows2;
float[][] popCounts;
int section = 1;
float maxDate, minDate;
int minYear, maxPop;
float songLength;
ArrayList<LibraryItem> libItems = new ArrayList<LibraryItem>();
ArrayList<LibraryItem> plotThese = new ArrayList<LibraryItem>();

// Interactivity
boolean spin = false;
boolean checkAllMonths = true;
boolean checkAllYears = true;
boolean play = false;
float speed = 0.1;
float speedStep = 0.01;
float[] camRotations;
CheckBox checkbox, checkbox2;
CheckBox checkbox3;

void setup() {
  //textMode(SHAPE);
  size(1280, 720, P3D);
  surface.setResizable(true);
  
  
  minim = new Minim(this);
  player = minim.loadFile("thriller.aiff");
  songLength = player.length();
  player.setGain(1.0);
  
  cam = new PeasyCam(this, 0, 0, maxDepth/2, startDistance);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(startDistance + 950);
  cam.setWheelScale(0.5);
  
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  checkbox = cp5.addCheckBox("months")
        .setPosition(45, 675)
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
  checkbox2 = cp5.addCheckBox("years")
              .setPosition(275, 675)
              .setColorForeground(color(120))
              .setColorActive(color(255))
              .setColorLabel(color(255))
              .setSize(10, 10)
              .setItemsPerRow(2)
              .setSpacingColumn(25)
              .setSpacingRow(5)
              .addItem("2008", 1)
              .addItem("2009", 2)
              .addItem("2010", 3)
              .addItem("2011", 4)
              ;
  checkbox3 = cp5.addCheckBox("dots")
              .setPosition(375, 675)
              .setColorForeground(color(120))
              .setColorActive(color(255))
              .setColorLabel(color(255))
              .setSize(10, 10)
              .setItemsPerRow(2)
              .setSpacingColumn(25)
              .setSpacingRow(5)
              .addItem("Only stolen albums", 1)
              ;
              
  checkbox3.deactivateAll();
  checkbox2.activateAll();
  checkbox.activateAll();
  // Load data to objects
  table = loadTable("thrillerJoined.csv", "header");
  counts = loadTable("groupedCounts.csv", "header");
  nRows = table.getRowCount();
  nRows2 = counts.getRowCount();
  println("Rows: " + nRows);
  
  minDate = MAX_FLOAT;
  maxDate = MIN_FLOAT;
  minYear = MAX_INT;
  maxPop = MIN_INT;
  for(int i = 0; i < nRows; i++){
    float checkOut = table.getFloat(i, 0);
    float checkIn = table.getFloat(i, 1);
    int year = table.getInt(i, 3);
    int pop = table.getInt(i, 6);
    // Get max and min checkouts
    if(checkOut > maxDate){maxDate = checkOut;}
    if(checkIn < minDate && checkIn != 0){minDate = checkIn;}
    if(year < minYear){minYear = year;}
    if(pop > maxPop){maxPop = pop;}
  }
  
  // Make object for each transaction
  for(int i = 0; i < nRows; i++)
  {
    float checkOut = table.getFloat(i, 0);
    float checkIn = table.getFloat(i, 1);
    int year = table.getInt(i, 3);
    int month = table.getInt(i, 4);
    float popularity = table.getInt(i, 6);
    libItems.add(new LibraryItem(minDate, maxDate, checkOut, checkIn, month, year, popularity, maxPop));
  }
  
  popCounts = new float[nRows2][2];
  for(int i = 0; i < nRows2; i++){
    popCounts[i][0] = map(i + 1, 1, nRows2, 0, songLength);
    popCounts[i][1] = map(counts.getFloat(i, 3), 4, 287, -6, 6);
  }
  
  println("Setup complete.");
  println(width, height);  
}

// Constants for viz
float spacing = 1.5;
float currGain;
float step = 0.05;
float i;
float X1, Y1;
float X2, Y2;

void draw() {
  perspective(PI/5.0, (float) width/height, 1, 100000);
  //println("Cam distance = " + cam.getDistance()); println(width + ',' + height);
  background(200, 180, 190);
  
  playerControls();
  drawLabels();
  
  stroke(50, 50, 200);
  fill(30, 5, 5);
  strokeWeight(2);
  strokeJoin(ROUND);
  
  for(int i = 0; i < libItems.size(); i++){
    if( (checkbox3.getArrayValue()[0] == 1.0 && libItems.get(i).dot) ||
        (checkbox3.getArrayValue()[0] == 0.0 && !libItems.get(i).dot)){
      if(checkbox2.getArrayValue()[libItems.get(i).year - (int)minYear] == 1.0){
        if(checkbox.getArrayValue()[libItems.get(i).month] == 1.0){
          shape(libItems.get(i).segment);
        }
      } 
    }
  }
  
  if(player.position() < popCounts[section][0]){
    currGain = player.getGain();
    player.setGain((currGain + popCounts[section-1][1])/2);
    player.setGain(popCounts[section-1][1]);
  }else{
    section += 1;
  }
  
  println(player.position() + "   " + (section-1) + "   " + player.getGain());
  
  cam.beginHUD();
    perspective(PI/3.0, (float)width/height, 1, 100000);
    cp5.draw();
  cam.endHUD();
    
}