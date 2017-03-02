//
//

void keyPressed() {
  if (key == ' ') {
    println("Camera reset.");
    cam.reset();
  }

  if (key == 's' || key == 'S') {
    spin = !spin;
    if (!spin) println("Halt rotation.");
  }
  
  if (key == 'p' || key == 'P') {
    play = !play;
  }
  
  if (key == 'r' || key == 'R') {
    player.rewind();
  }
  
  
  if (key == 'm' || key == 'M') {
    checkAllMonths = !checkAllMonths;
    if(checkAllMonths){ checkbox.activateAll(); }
    else {checkbox.deactivateAll();}
  }
  
  if (key == 'y' || key == 'Y') {
    checkAllYears = !checkAllYears;
    if(checkAllYears){ checkbox2.activateAll(); }
    else {checkbox2.deactivateAll();}
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      speed += speedStep;
      println("Speed = " + speed);
    }
    if ((keyCode == DOWN) && (speed > speedStep)) { // Roundoff error
      speed -= speedStep; 
      println("Speed = " + speed);
    }
  }
}

void playerControls(){
  if(play == true){
    player.play();
  } else{ 
    player.pause();
  }
}

void drawLabels() {
  // To rotate towards camera
  camRotations = cam.getRotations();
  //println("Rotations = " + camRotations[0] + " , " + camRotations[2]+ " , " + camRotations[2]);

  drawRecordLabel();
  drawZLabels();
  drawTitle();
}

void drawTitle() {
  pushMatrix();

  // Gets cropped at current distance, make this closer or heighten cutoff plane
  translate(-maxRadius + -1625, 
    -maxRadius + -375, 
    maxDepth/2);
  rotateX(camRotations[0]);
  rotateY(camRotations[1]);
  rotateZ(camRotations[2]);

  fill(255);
  textSize(270);
  textAlign(CENTER);
  text("The Vinyl", 0, 0, 0);
  text("Frontier", 0, 253, 0);

  textSize(72);
  text("Jason Freeberg", 0, 454, 0);
  text("MAT 259 -- Winter 2017", 0, 362, 0);

  popMatrix();
}

void drawRecordLabel() {
  noStroke();
  fill(180, 30, 30);
  ellipse(0, 0, 300, 300);

  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("Side A", 0, -64, 1);

  textSize(14);
  text("Stereophonic", 0, 110, 1);

  textSize(18);
  textAlign(CENTER);
  float trackLocation = -19;
  float trackStep = 25;
  text("1. We R The Champions", 0, trackLocation, 1);
  text("2. Sweet Child O'MySQL", 0, trackLocation + trackStep, 1);
  text("3. Do you C color?", 0, trackLocation + trackStep*2, 1);
  text("4. Python Haze", 0, trackLocation + trackStep*3, 1);
}

void drawZLabels() {
  stroke(255);
  line(0, 0, 0, 0, 0, maxDepth);

  pushMatrix();
    fill(255);
    translate(0, 0, maxDepth/2);
    rotateY(PI/2);
  
    textSize(150);
    textAlign(CENTER);
    text("Weekly", 0, -5, 0);
    text("Popularity", 0, 125, 0);
  
    textSize(75);
    textAlign(LEFT);
    text("More Popular", +maxDepth/2 + 5, 0, 0);
  
    textSize(75);
    textAlign(RIGHT);
    text("Less Popular", -maxDepth/2, 0, 0);
  popMatrix();
}

public boolean contains(final int[] array, final int key) {     
    return contains(array, key);
}