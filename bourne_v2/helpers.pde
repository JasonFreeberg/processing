float columnMax(float data[][], int column){
  float max = MIN_FLOAT;
  
  for(int row = 0; row < data.length; row++){
    if(data[row][column] > max) max = data[row][column];
  }
  
  return max;
}

float columnMin(float data[][], int column){
  float min = MAX_FLOAT;
  
  for(int row = 0; row < data.length; row++){
    if(data[row][column] < min) min = data[row][column];
  }
  
  return min;
}

float minMaxNorm(float value, float min, float max){
  return (value - min)/(max - min);
}

void writeLabels(){
  fill(textColor, 255);
  
  textAlign(CENTER); // Title
  textSize(36);
  text("Bourne to Watch", width/2, vMargin/2);
  
  textSize(12); // Some labels
  text("Checkouts of Jason Bourne movies, 2005 - 2017", width/2, vMargin/2 + 20);
  
  // Legend/guide
  textAlign(LEFT, BOTTOM);
  text("Use up and down arrow keys to adjust transparency.", hMargin + 20, height - vMargin/4 + 10);
  text("Press R to show release dates.", hMargin + 20, height - (2*vMargin)/4 + 10);
  text("Hover over visualization to display date.", hMargin + 20, height - (3*vMargin)/4 + 10);
  
  // Hover Date
  textAlign(RIGHT, CENTER);
  text("Date hovered:", width - hMargin, height - (3*vMargin)/4 + 10);
  mousePosToDate(width-hMargin, height - vMargin/2);
  
  //X-axis label
  textAlign(CENTER);
  textSize(20);
  text("Date", width/2, height - (vMargin*2)/3);
  
  // Y-axis Label
  pushMatrix(); // Translate the axis
  
  translate(hMargin - 40, height/2);
  rotate(-HALF_PI);
  textAlign(CENTER); // Write text
  textSize(20);
  text("Movie", 0, 0);
    
  popMatrix(); // Reset axis
  textSize(12);
}

boolean checkNewYear(int day, int month){
  if((day == 1) && (month == 1)) return true;
  else return false;
}