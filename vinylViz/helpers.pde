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
  
  if(key == CODED){
    if(keyCode == UP){
      speed += speedStep;
      println("Speed = " + speed);
    }
    if((keyCode == DOWN) && (speed > speedStep)){ // Roundoff error
      speed -= speedStep; 
      println("Speed = " + speed);
    }
  }
}


void presentationRotation(){
  // Rotates the camera to fake a spinning vinyl record
  if(spin){
    println("Spinning.");
    cam.rotateZ(-speed); // Actually rotates in negative direction
  }
  else {println("Not spinning.");}
}

void drawLabels(){
  // To rotate towards camera
  camRotations = cam.getRotations();
  println("Rotations = " + camRotations[0] + " , " + camRotations[2]+ " , " + camRotations[2]);
  
  drawRecordLabel();
  drawZLabels();
  drawTitle();
}

void drawTitle(){
  pushMatrix();
  
    // Gets cropped at current distance, make this closer or heighten cutoff plane
    translate(-maxRadius*exp((float)(-maxDepth/2/scaleParam)), 
              -maxRadius*exp((float)(-maxDepth/3/scaleParam)), 
              maxDepth/2);
    rotateX(camRotations[0]);
    rotateY(camRotations[1]);
    rotateZ(camRotations[2]);
    
    fill(255);
    textSize(400);
    textAlign(CENTER);
    text("The Vinyl", 0, 0, 0);
    text("Frontier", 0, 400, 0);
    
    textSize(120);
    text("Jason Freeberg", 0, 576, 0);
    text("MAT 259 -- Winter 2017", 0, 600+120, 0);
    
  popMatrix();
}

void drawRecordLabel(){
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
    text("1. Pythonic Journies", 0, trackLocation, 1);
    text("2. Do you C color?", 0, trackLocation + trackStep, 1);
    text("3. Another cup of Java", 0, trackLocation + trackStep*2, 1);
    text("4. You R Expected", 0, trackLocation + trackStep*3, 1);
}

void drawZLabels(){
  stroke(255);
  line(0, 0, 0, 0, 0, maxDepth);
  
  pushMatrix();
    fill(255);
    translate(0, 0, maxDepth/2);
    rotateY(PI/2);
    
    textSize(150);
    textAlign(CENTER);
    text("Item Popularity", 0, 0, 0);
    
    textSize(75);
    textAlign(LEFT);
    text("More Popular", +maxDepth/2 + 5, 0, 0);
    
    textSize(75);
    textAlign(RIGHT);
    text("Less Popular", -maxDepth/2, 0, 0);
  popMatrix();
}