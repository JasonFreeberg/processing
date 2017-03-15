//
//
//

class Edge{
  
  PShape s;
  float[] coordA = new float[8];
  float[] coordB = new float[8];
  String parent;
  String child;
  
  public Edge(float[] childComps, float[] parentComps, String child_, String parent_){
    
    this.parent = parent_;
    this.child = child_;
    this.coordA = childComps;
    this.coordB = parentComps;
    
    // Make shape
    //this.makeShape();
  }
  /*
  private void makeShape(){
    s = createShape();
    s.beginShape(LINE);
      s.noFill();
      s.stroke(color(360, 0, 0, 360));
      s.strokeWeight(5);
      s.vertex(coordA[0], coordA[1], coordA[2]);
      s.vertex(coordB[0], coordB[1], coordB[2]);
    s.endShape();
  }
  
  public void drawShape(){ 
    shape(s); 
  }
  */
  public void drawLine(){
    stroke(color(250, 0, 0, 300));
    strokeWeight(1);
    line(coordA[0], coordA[1], coordA[2], coordB[0], coordB[1], coordB[2]);
    textSize(50);
    fill(color(250, 0, 0, 300));
    pushMatrix();
      translate(coordA[0], coordA[1]-5, coordA[2]);
      rotateX(cam.getRotations()[0]);
      rotateY(cam.getRotations()[1]);
      rotateZ(cam.getRotations()[2]);
      text(child, 0, 0,0);
    popMatrix();
    pushMatrix();
      translate(coordB[0], coordB[1]-5, coordB[2]);
      rotateX(cam.getRotations()[0]);
      rotateY(cam.getRotations()[1]);
      rotateZ(cam.getRotations()[2]);
      text(parent, 0, 0, 0);
    popMatrix();
    
  }
}