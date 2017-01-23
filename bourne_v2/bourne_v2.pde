


Table table;
int nRows, nCols;
float minTime, maxTime, minDaysOut, maxDaysOut, maxDev, minDev;
float[][] data;
String[] titles = {"Bourne Identity", "Bourne Supremacy", "Bourne Ultimatum", "Bourne Legacy", "Jason Bourne"};
int countColumns[] = {3,4,11};

float vMargin = 100;
float hMargin = 160;

float row[];
float hPos, vPos, rectWidth;
float lane;
float alpha = 5;

PImage background;

void setup(){
  println(hour() + ":" + minute() + ":" + second());
  println("Invoked setup function.");

  size(1280, 720);
  background = loadImage("background.jpg");
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
  
  minTime = min(columnMin(data, 1), columnMin(data, 2));
  maxTime = max(columnMax(data, 1), columnMax(data, 2));
  
  println(maxTime);
  println(minTime);
  
  for(int i = 0; i < nRows; i ++){
    row = data[i];
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = map(row[2], minTime, maxTime, hMargin, width-hMargin);
    println("Start: "+hPos+" Stop: "+rectWidth);
    
    if(map(row[2], minTime, maxTime, hMargin, width-hMargin) > width-hMargin){
      print(i);
      break;
    }
  }
  
  println(maxTime);
  println(minTime);
  
}

void draw() {
  //background(0,0,0,5);
  tint(255, 126);
  imageMode(CENTER);
  image(background, width/2, height/2);
  surface.setResizable(true);
  
  for(int i = 0; i < titles.length; i++){
    vPos = vMargin + i*(height - 2*vMargin)/titles.length + 15;
    
    fill(0);
    textAlign(RIGHT, CENTER);
    text(titles[i], hMargin - 10, vPos);
  }
  
  for(int index = 0; index < nRows; index++){
    row = data[index];
    
    // Start at checkout time (hPos) end at checkin time (rectWidth)
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = map(row[2], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = rectWidth - hPos;
    lane = row[0]*(height - 2*vMargin)/5;
    vPos = vMargin + lane + row[6]*5;
    
    noStroke();
    fill(200,30,46, alpha);
    rect(hPos, vPos, rectWidth, 30);
  }
}