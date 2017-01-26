
import java.util.*;
import ddf.minim.*;

Table table;
int nRows, nCols;
float minTime, maxTime;
float[][] data;

float vMargin = 100;
float hMargin = 160;
int textColor = #EFEFEF;

boolean showReleases = false;

Minim minim;
AudioPlayer player;
PImage background;
long year;

// Some hard-coded arrays
String[] titles = {"Identity", "Supremacy", "Ultimatum", "Legacy"};
long[] years = {1136073600, 1167609600, 1199145600, 1230768000, 1262304000, 1293840000, 1325376000, 1356998400, 1388534400, 1420070400, 1451606400, 1483228800};
long[] releases = {1188432000, 1197331200, 1344297600, 1355184000, 1469750400, 1479168000};
String[] releaseNames = {"Ultimatum in Theaters", "Ultimatum on DVD", "Legacy in Theaters", "Legacy on DVD", "Jason Bourne in Theaters", "Jason Bourne on DVD"}; 
String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
//int[][] colors = {{219, 3, 83, 341}, {85, 140, 26, 112}, {120, 228, 3, 161}, {2, 151, 151, 210}};
int[] colors = {#DB0353, #029797, #FCF003, #78E403};

void setup() {
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

  // Load Files
  background = loadImage("background.jpg");
  //colors = loadImage("colorMap.jpg");
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
  background(#22210B);
  tint(255, 126);
  //imageMode(CENTER);
  //image(background, width/2, height/2);
  surface.setResizable(true);
  
  // Title and legends
  writeLabels();

  // Y-axis labels
  for (int i = 0; i < titles.length; i++) {
    lane = (i + 1)*(height - 2*vMargin)/titles.length;
    vPos = vMargin + lane - (height - 2*vMargin)/(titles.length * 2);

    pushMatrix(); // Translate the axis
    translate(hMargin - 10, vPos);
    rotate(-HALF_PI);

    textAlign(CENTER); // Write text
    fill(textColor);
    text(titles[i], 0, 0);

    popMatrix(); // Reset axis
  }

  // X-axis labels and ticks
  for (int i = 0; i < years.length; i++) {
    year = years[i];
    hPos = map(year, minTime, maxTime, hMargin, width-hMargin);
    year = new Date((long)year*1000).getYear() + 1900;
    
    // Tick marks
    strokeWeight(1);
    stroke(textColor, 200);
    line(hPos, height - vMargin, hPos, vMargin);
    
    // Labels
    textAlign(CENTER);
    fill(textColor);
    text((int)year, hPos, height - vMargin + 15);
  }

  // Main visualization
  for (int index = 0; index < nRows; index++) {
    row = data[index];

    // Start at checkout time (hPos) end at checkin time (rectWidth)
    hPos = map(row[1], minTime, maxTime, hMargin, width-hMargin);
    rectWidth = map(row[2], minTime, maxTime, hMargin, width-hMargin) - hPos;
    lane = row[0]*(height - 2*vMargin)/titles.length;
    vPos = vMargin + lane;

    noStroke();
    fill(colors[(int)row[0]], alpha);
    rect(hPos, vPos, rectWidth, (height - 2*vMargin)/titles.length);
  }

  // Release Dates
  if (showReleases) plotReleases();
}