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