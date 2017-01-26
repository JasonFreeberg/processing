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
  fill(0,0,0,255);
  
  textAlign(CENTER); // Title
  textSize(36);
  text("Bourne to Watch", width/2, vMargin/2);
  
  textSize(12); // Some labels
  text("Checkouts of Jason Bourne movies, 2005 - 2017", width/2, vMargin/2 + 30);
  text("Use up and down arrows to adjust transparency.", width/3, height - vMargin/2);
  text("Press R to show release dates.", 2*width/3, height - vMargin/2);
  text("Press J.", width/2, height-vMargin/4);
}

boolean checkNewYear(int day, int month){
  if((day == 1) && (month == 1)) return true;
  else return false;
}