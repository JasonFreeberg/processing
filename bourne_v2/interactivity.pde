void keyPressed(){
  
  // Change alpha
  if(key == CODED){
    if(keyCode == UP && alpha < 255) alpha++;
    if(keyCode == DOWN && alpha > 1) alpha--;
  }
  
  
  if(key == 'n' || key == 'N'){
    if(normalize == true){
      
    }
  }
  
  println("alpha = " + alpha);
}

void normalizeDeviance(){
}