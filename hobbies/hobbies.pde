/**********************************************************
 * Jason Freeberg
 * MAT 259A - Winter Quarter 2017
 * First Project: 
 *   Uses processing to investigate how often
 *   users of the Seattle Public Library check
 *   out materials for hobbies or other personal
 *   disciplines. A few examples include cooking, painting,
 *   programming and gardening.
 ***********************************************************
 */



// Declarations
Table table;
int nRows, nCols;
float[][] data;
float verticalMargin = 100;
float horizontalMargin = 160;

// Save the column headers here. 
// Now I can iterate over the data's columns and headers simultaneously.
String[] header = {"day", "month", "year", "Cooking", "Office Skills", 
  "woodWorking", "Music", "Outdoor Activities", "Indoor Activies", 
  "Programming", "Housekeeping", "Accounting", "Gardening", "Drawing", "Painting", 
  "Travel", "Daily Total"};

// Interactivity
HScrollbar scrollBar;
float barPos;

void setup() {
  println(hour() + ":" + minute() + ":" + second());
  println("Invoked setup function.");

  size(1280, 720);
  background(250);
  surface.setResizable(true);
  println("Canvas set.");

  // Read Data
  table = loadTable("hobbies_06_08.csv");
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
  
  //Scrollbar
  //                          x_pos,    y_pos,  width,  height, loose/heavy
  scrollBar = new HScrollbar(0, height-verticalMargin, width, 16, 1);
  
}

void draw() {
  fill(0);
  
  scrollBar.update();
  scrollBar.display();
  barPos = scrollBar.getPos();
  int index = (int)map(barPos, 0, width, 0, nRows);
  
  text(barPos, barPos/2, barPos/2);
  fill(0);
  
  /*
  for (int col = 0; col < nCols; col++) {
    int sum = 0;
    for (int row = 0; row < nRows; row++) {
      sum += data[row][col];
    }
    String printHobby = col + ". " + header[col];
    text(printHobby, horizontalMargin, verticalMargin + col*20);
    text(sum, horizontalMargin + 200, verticalMargin + col*20);
  }
  */
}