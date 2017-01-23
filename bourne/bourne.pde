

Table table;
int nRows, nCols;
float minCheckoutTime, maxCheckoutTime, minTimeOut, maxTimeOut, maxDeviance, minDeviance;
float[][] data;
String[] titles = {"Bourne Identity", "Bourne Supremacy", "Bourne Ultimatum", "Bourne Legacy", "Jason Bourne"};
int countColumns[] = {3,4,11};

float vMargin = 100;
float hMargin = 160;

PImage colors;

// Interactivity variables
float alpha = 64;
boolean normalize = false;

void setup(){
  println(hour() + ":" + minute() + ":" + second());
  println("Invoked setup function.");

  size(1280, 720);
  background(250);
  surface.setResizable(true);
  println("Canvas set.");

  // Read Data
  table = loadTable("bourne.csv", "header");
  nRows = table.getRowCount();
  nCols = table.getColumnCount();

  // Data is set up: matrix[rows][columns] because I come from
  // an R and Python background
  data = new float[nRows][nCols];
  for (int col = 0; col < nCols; col++) {
    for (int row = 0; row < nRows; row++) {
      data[row][col] = table.getFloat(row, col);
    }
  }
  
  // Sanity checks
  for(int index = 0; index < nRows; index++){
    row = data[index];
    if(index % 5 == 0) println(" Movie: " + row[0] + " TimeOut: " + row[1] + " TimeIn: " + row[2] + " DaysOut: " + row[3] + " Deviance: " + row[11]);
  } 
  println("--------------------------");
  println("MaxDay: " + maxCheckoutTime);
  println("MinDay: " + minCheckoutTime);
  println("MaxDaysOut: " + maxTimeOut);
  println("MinDaysOut: " + minTimeOut);
  println("Max Dev: " + maxDeviance);
  println("Min Dev: " + minDeviance);
  
  maxCheckoutTime = columnMax(data, 1);
  minCheckoutTime = columnMin(data, 1); //1119299400;
  maxTimeOut = columnMax(data, 3);
  minTimeOut = columnMin(data, 3);
  
  // Same colors from the demo project in class
  colors = loadImage("colorMap.jpg"); 
}

float row[]; //<>//
float hPos, vPos;
float rectWidth;
float imagePixel;
int fill;

void draw() {
  background(250);
  
  for(int i = 0; i < titles.length; i++){
    vPos = vMargin + i*(height - 2*vMargin)/titles.length + 15;
    
    fill(0);
    textAlign(RIGHT, CENTER);
    text(titles[i], hMargin - 10, vPos);
  }
  
  for(int index = 0; index < nRows; index++){
    row = data[index];
    
    //imagePixel = map(row[11], minDeviance, maxDeviance, 2, colors.width-2);
    //fill = (int)colors.get((int)imagePixel, colors.height/2);
    rectWidth = map(row[3], minTimeOut, maxTimeOut, 20, 200);
    hPos = map(row[1], minCheckoutTime, maxCheckoutTime, hMargin, width - hMargin);
    vPos = vMargin + (row[0]*(height - 2*vMargin)/5);
  
    noStroke();
    //fill(red(fill), green(fill), blue(fill), alpha);
    fill(200,30,46, alpha);
    rect(hPos, vPos, rectWidth, 50);
    
    //println("x=" + hPos + ", y=" + vPos);
  }
  println("--------------------------");
  println("MaxDay: " + maxCheckoutTime);
  println("MinDay: " + minCheckoutTime);
  println("MaxDaysOut: " + maxTimeOut);
  println("MinDaysOut: " + minTimeOut);
  println("Max Dev: " + maxDeviance);
  println("Min Dev: " + minDeviance);
}