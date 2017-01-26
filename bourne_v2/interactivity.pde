void keyPressed(){
  
  // Change alpha
  if(key == CODED){
    if(keyCode == UP && alpha < 255) alpha++;
    if(keyCode == DOWN && alpha > 1) alpha--;
  }

  //if(key == 'n' || key == 'N') normalize = !normalize;
  
  if(key == 'j' || key == 'J') jesusChristItsJasonBourne(); 
  
  if(key == 'r' || key == 'R') showReleases();
  
  println("norm  = " + normalize);
  println("alpha = " + alpha);
}

void jesusChristItsJasonBourne(){
    player.rewind();
    player.play();
    println("JESUSCHRISTITSJASONBOURNE");
}

void showReleases(){
  
}