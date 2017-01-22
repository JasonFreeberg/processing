/**********************************************************

Jason Freeberg
MAT 259A - Winter Quarter 2017
First Project: 
   Uses processing to investigate how often
   users of the Seattle Public Library check
   out materials for hobbies or other personal
   disciplines. A few examples include cooking, painting,
   programming and gardening.

************************************************************/

// Declarations
Table table;
int nRows, nCols;
float[][] data;
float dataMax;
float dataMin;

float verticalMargin = 100;
float horizontalMargin = 160;

// Save the column headers here. 
// Now I can iterate over the data's columns and headers simultaneously.
String[] header = {"day", "month", "year", "Cooking", "Office Skills", 
  "woodWorking", "Music", "Outdoor Activities", "Indoor Activies", 
  "Programming", "Housekeeping", "Accounting", "Gardening", "Drawing", "Painting", 
  "Travel", "Daily Total"};
PImage colors;

// Interactivity
HScrollbar scrollBar;
float barPos;
float startPos = 0;

void setup() {
  println(hour() + ":" + minute() + ":" + second());
  println("Invoked setup function.");

  size(1280, 720);
  background(250);
  surface.setResizable(true);
  println("Canvas set.");

  // Read Data
  table = loadTable("hobbies.csv");
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
  dataMax = max2D(data);
  dataMin = min2D(data);

  println("Max = ", dataMax);
  println("Min = ", dataMin);
  
  scrollBar = new HScrollbar(startPos, height-verticalMargin, width, 16, 1);
  
  // Same colors from the demo project in class
  colors = loadImage("colorMap.jpg");
}

int index;
float row[];
int day;
String month;
int year;
String date;

// Default values for updating
int oldDay = 1;
String oldMonth = "January";
int oldYear = 2006;

float count;
String title;
float mappedHeight;
float mappedColor;
float horizontalSpace;
float horizontalPos;

void draw() {
  background(250);
  fill(0);
  
  println("  barPos: ", barPos);
  println("startPos: ", startPos);
  println("----------------------click");
  // Scrollbar setup
  //Scrollbar               x_pos,  y_pos,               width,height,loose/heavy
  //scrollBar = new HScrollbar(startPos, height-verticalMargin, width, 16, 1);
  barPos = scrollBar.getPos();
  //startPos = barPos;
  scrollBar.update();
  scrollBar.display();
  println("  barPos: ", barPos);
  println("startPos: ", startPos);
  fill(0);

  // Use scrollbar to index the data
  index = (int)map(barPos, 0, width, 1, nRows-1);
  row = data[index];

  // Display date selected from scrollbar
  printDate();
  //println("Month selected: " + month);
  //println("Index: " + index);
  //println("Row contents:");
  //println(row);

  // Plot the circles
  horizontalSpace = (width - 2*horizontalMargin)/(row.length - 4); //-4 bc of day, month, year and totalCount
  for (int elem = 3; elem < nCols - 1; elem++) {
    count = row[elem];
    title = header[elem];
    horizontalPos = horizontalMargin + (elem - 3)*horizontalSpace;

    mappedHeight = map(count, dataMin, dataMax, verticalMargin, height-verticalMargin);
    mappedColor = map(count, dataMin, dataMax, 2, colors.width-2);
    float mappedSize = map(count, dataMin, dataMax, 30, horizontalMargin/2);
    
    fill(colors.get((int)mappedColor, colors.height/2));
    ellipse(horizontalPos, // x
      height - mappedHeight - verticalMargin, // y
      mappedSize, // width
      mappedSize); // height
      
    // Vertical Text
    fill(0);
    textAlign(CENTER);
    pushMatrix();
    translate(horizontalPos, height/2);
    rotate(-HALF_PI);
    text(title + ": " + (int)count, 0, 0);
    popMatrix();
  }
}