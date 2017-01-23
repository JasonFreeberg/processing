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
  return (value - min) / (max - min);
}

float undoNorm(float value, float min, float max){
  return (max - min)*value + min;
}

void normalizeDeviance(){
    //for(int row = 0; row < data.length; row++){
    //  data[row][countColumns[col]] = minMaxNorm(data[row][countColumns[col]], columnMin(data, countColumns[col]), columnMax(data, countColumns[col]));
    //}
    for(int row = 0; row < data.length; row++){
      data[row][11] = minMaxNorm(data[row][11], minDeviance, maxDeviance);
    }
}

void resetData(){
  data = new float[nRows][nCols];
  for (int col = 0; col < nCols; col++) {
    for (int row = 0; row < nRows; row++) {
      data[row][col] = table.getFloat(row, col);
    }
  }
}