
import java.util.*; 

Table table;
int nRows, nCols;
float minTime, maxTime, minDaysOut, maxDaysOut, maxDev, minDev, minYear, maxYear;
float[][] data;
String[] titles = {"Identity", "Supremacy", "Ultimatum", "Legacy", "Jason Bourne"};
String[] years = {"2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017"};
int countColumns[] = {3,4,11};

float vMargin = 100;
float hMargin = 160;

boolean normalize = false;

PImage background;
PImage colors;
Date date1, date2;

void setup(){
  size(1280, 720);
  surface.setResizable(true);

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
  maxDev = columnMax(data, 11);
  minDev = columnMin(data, 11);
  println("Max dev: " + maxDev);
  println("Min dev: " + minDev);
  
  date1 = new Date((long)minTime*1000);
  date2 = new Date((long)maxTime*1000);
  
  // Images
  background = loadImage("background.jpg");
  colors = loadImage("colorMap.jpg");
}

float row[];
float hPos, vPos, rectWidth, colorLocation;
int rectColor;
float lane;
float alpha = 5;

void draw() {
  
  // Set up canvas
  background(255);
  tint(255, 126);
  imageMode(CENTER);
  image(background, width/2, height/2);
  surface.setResizable(true);
  
  // Y-axis labels
  for(int i = 0; i < titles.length; i++){
    vPos = vMargin + i*(height - 2*vMargin)/titles.length + 45;
    
    pushMatrix(); // Translate the axis
    translate(hMargin - 10, vPos);
    rotate(-HALF_PI);
    
    textAlign(CENTER); // Write text
    fill(0);
    text(titles[i], 0, 0);
    
    popMatrix(); // Reset axis
  }
  
  // X-axis labels and ticks
  for(int i = 0; i < years.length; i++){
    hPos = hMargin + i * (width - 2*hMargin)/years.length;//
    line(hPos, height - vMargin, hPos, vMargin);
    textAlign(LEFT);
    fill(0);
    text(years[i], hPos, height - vMargin);
    //fill(0,0,0, 10);
  }
  
  for(int index = 0; index < nRows; index++){
    row = data[index];
    
    // Start at checkout time (hPos) end at checkin time (rectWidth)
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = map(row[2], minTime, maxTime, hMargin, width-hMargin) - hPos;
    lane = row[0]*(height - 2*vMargin)/5;
    
    colorLocation = map(row[11], minDev, maxDev, 2, colors.width-2);
    rectColor = colors.get((int)colorLocation, colors.height/2);
    vPos = vMargin + lane + row[6]*5;
    
    noStroke();
    fill(red(rectColor), blue(rectColor), green(rectColor), alpha);
    rect(hPos, vPos, rectWidth, 15);
  }
}