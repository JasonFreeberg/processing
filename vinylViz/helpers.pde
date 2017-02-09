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
  println("Rotations = " + camRotations[0] + ',' + camRotations[2]+ ',' + camRotations[2]);
  
  drawRecordLabel();
  drawZLabels();
}

void drawRecordLabel(){
  
  textSize(30);
  textAlign(CENTER);
  String labelText = "Side 1";
  if(!spin){ // not spinning
    pushMatrix();
      translate(0,0,0);
      rotateX(camRotations[0]);
      rotateY(camRotations[1]);
      rotateZ(camRotations[2]);
      
      noStroke();
      fill(180, 30, 30);
      ellipse(0, 0, 300, 300);
      
      fill(255);
      text(labelText, 0, 0, 0);
    popMatrix();
  }
  else{
    noStroke();
    fill(180, 30, 30);
    ellipse(0, 0, 300, 300);
    text(labelText, 0, 0, 0);
  }
}

void drawZLabels(){
  int offset = 300;
  stroke(255);
  line(0, 0, 0, 0, 0, maxDepth);
  
  pushMatrix();
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