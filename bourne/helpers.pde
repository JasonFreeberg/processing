
float max2D(float[][] dataMatrix){
  float max = 0;
  for(int row = 3; row < dataMatrix.length; row++){
    for(int col = 1; col < dataMatrix[row].length - 1; col++){
      if(dataMatrix[row][col] > max) max = dataMatrix[row][col]; 
    }
  }  
  return max;
}

float min2D(float[][] dataMatrix){
  float min = max2D(dataMatrix);
  for(int row = 3; row < dataMatrix.length; row++){
    for(int col = 0; col < dataMatrix[row].length - 1; col++){
      if(dataMatrix[row][col] < min) min = dataMatrix[row][col]; 
    }
  }  
  return min;
}