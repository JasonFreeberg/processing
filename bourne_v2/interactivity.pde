void keyPressed(){
  
  // Change alpha
  if(key == CODED){
    if(keyCode == UP && alpha < 255) alpha++;
    if(keyCode == DOWN && alpha > 1) alpha--;
  }
  
  if(key == 'j' || key == 'J') jesusChristItsJasonBourne(); 
  
  if(key == 'r' || key == 'R') showReleases = !showReleases;
  
  println("releases = " + showReleases);
  println("   alpha = " + alpha);
}

void jesusChristItsJasonBourne(){
   player.rewind();
   player.play();
   println("JESUSCHRISTITSJASONBOURNE");
}

void plotReleases(){
  assert(releases.length == releaseNames.length);
  
  float releaseDate;
  float offset = 0;
  for(int i = 0; i < releases.length; i++){
    releaseDate = releases[i];
    
    // Draw bright orange line
    hPos = map(releaseDate, minTime, maxTime, hMargin, width-hMargin);
    stroke(#FF8E00, 200);
    strokeWeight(3);
    line(hPos, height - vMargin, hPos, vMargin);
    
    // Offset the titles on top
    if(i % 2 == 0) offset = 14;
    else offset = 2;
    
    textAlign(CENTER);
    fill(textColor);
    text(releaseNames[i], hPos, vMargin - offset);
  }
}

void mousePosToDate(float hPos, float vPos){
  if((mouseX > hMargin) && (mouseX < (width - hMargin)) &&
     (mouseY > vMargin) && (mouseY < (height - vMargin))){
    
    float mouseTime = map(mouseX, hMargin, width - hMargin, minTime, maxTime);
    int mouseYear = new Date((long)mouseTime*1000).getYear() + 1899;
    int mouseMonth = new Date((long)mouseTime*1000).getMonth();
    
    text(monthNames[mouseMonth] + ' ' + mouseYear, hPos, vPos);
  }
  else text("Hover over visualization", hPos, vPos);
}