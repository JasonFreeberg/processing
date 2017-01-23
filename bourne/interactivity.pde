void keyPressed(){
  
  float step = 0.5;
  
  // Adjust transparancy
  if(key == CODED){
    if(keyCode == UP && alpha < 255) alpha += step;
    if(keyCode == DOWN && alpha > 1) alpha += -step;
  }
  
  if(key == 'n' || key == 'N') normalize = !normalize;
  
  println("alpha= " + alpha);
  println("norm= " + normalize);
  
  //if(normalize == true) normalizeDeviance();
  //else if(normalize == false) resetData();
}