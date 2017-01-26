
import java.util.*;
import ddf.minim.*;

Table table;
int nRows, nCols;
float minTime, maxTime, minDaysOut, maxDaysOut, maxDev, minDev, minYear, maxYear;
float[][] data;
String[] titles = {"Identity", "Supremacy", "Ultimatum", "Legacy"};
long[] years = {1136073600,1167609600,1199145600,1230768000,1262304000,1293840000,1325376000,1356998400,1388534400,1420070400,1451606400,1483228800};
long[] releases = {1188432000, 1197331200, 1344297600, 1355184000, 1469750400, 1479168000};
String[] releaseNames = {"Ultimatum, Theaters", "Ultimatum, DVD", "Legacy, Theaters", "Legacy, DVD", "Jason Bourne, Theaters", "Jason Bourne, DVD"}; 

int countColumns[] = {3,4,11};

float vMargin = 100;
float hMargin = 160;

boolean normalize = false;

Minim minim;
AudioPlayer player;
PImage background;
PImage colors;
long year;

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
  
  // Load Files
  background = loadImage("background.jpg");
  colors = loadImage("colorMap.jpg");
  minim = new Minim(this);
  player = minim.loadFile("jcijb.aiff");
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
  
  // Title
  writeLabels();
  
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
      year = years[i];
      hPos = map(year, minTime, maxTime, hMargin, width-hMargin);
      year = new Date((long)year*1000).getYear() + 1900;
      
      stroke(0, 0, 0, 126);
      line(hPos, height - vMargin, hPos, vMargin);
      textAlign(CENTER);
      fill(0);
      text((int)year, hPos, height - vMargin + 15);
  }
  
  
  /*
  for(int i = 0; i < years.length; i++){
    hPos = hMargin + i * (width - 2*hMargin)/years.length;//
    
    stroke(0, 0, 0, 126);
    line(hPos, height - vMargin, hPos, vMargin);
    
    textAlign(LEFT);
    fill(0);
    text(years[i], hPos, height - vMargin + 15);
  }
  */
  
  for(int index = 0; index < nRows; index++){
    row = data[index];
    
    // Start at checkout time (hPos) end at checkin time (rectWidth)
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = map(row[2], minTime, maxTime, hMargin, width-hMargin) - hPos;
    lane = row[0]*(height - 2*vMargin)/titles.length;
    colorLocation = map(row[0], 0, 5, 2, colors.width-2);
    rectColor = colors.get((int)colorLocation, colors.height/2);
    vPos = vMargin + lane;
    
    noStroke();
    fill(red(rectColor), blue(rectColor), green(rectColor), alpha);
    rect(hPos, vPos, rectWidth, (height - 2*vMargin)/titles.length);
  }
  
  /*
  List<Integer> newYears = new ArrayList<Integer>();
  
  for(int index = 0; index < nRows; index++){
    row = data[index];
    
    day = new Date((long)row[1]*1000).getDay();
    month = new Date((long)row[1]*1000).getMonth() + 1;
    year = new Date((long)row[1]*1000).getYear() + 1900;
    
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    
    if(checkNewYear(day,month) && !newYears.contains(year)){
      stroke(0, 0, 0, 126);
      line(hPos, height - vMargin, hPos, vMargin);
      textAlign(CENTER);
      fill(0);
      text(year, hPos, height - vMargin + 15);
      newYears.add(year);
    }
  }
  */
}