

Table table;
int nRows, nCols;
float minDay, maxDay, minTimeOut, maxTimeOut, maxDev, minDev;
float[][] data;
String[] titles = {"Jason Bourne", "Bourne Ultimatum", "Bourne Supremacy", "Bourne Legacy", "Bourne Identity"};

float vMargin = 100;
float hMargin = 160;

PImage colors;


void setup(){
  println(hour() + ":" + minute() + ":" + second());
  println("Invoked setup function.");

  size(1280, 720);
  background(250);
  surface.setResizable(true);
  println("Canvas set.");

  // Read Data
  table = loadTable("bourne.csv");
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
  
  // Mins and maxs of columns, for map()
  maxDay = max(max(data[1]), max(data[2]));
  minDay = min(min(data[1]), min(data[2]));
  maxTimeOut = max(data[3]);
  minTimeOut = min(data[3]);
  maxDev = max(data[5]);
  minDev = min(data[5]);
  
  // Same colors from the demo project in class
  colors = loadImage("colorMap.jpg"); 
}

float row[];
float vPos, hPos;

void draw(){
  background(250);
  fill(0);
  
  for (int index = 1; index < nCols; index++) {
    // 0, movie number
    // 1, unix time out
    // 2, unix time in
    // 3, time out
    // 4, mean time for movie
    // 5, deviance from mean time out
    row = data[index];
    
    vPos = map(row[0], 0, 4, vMargin, height-vMargin);
    hPos = map(row[1], minDay, maxDay, hMargin, width-hMargin);
    
    
    
  }
  
  
  
}