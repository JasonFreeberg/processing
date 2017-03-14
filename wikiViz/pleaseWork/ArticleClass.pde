
class Article{
  
  String title;
  String parent;
  int level;
  float[] prComps = new float[8];

  public Article(String title_, String parent_, int level_, float[] prComps_){
    this.title = title_;
    this.parent = parent_;
    this.level = level_;
    
    // Map principle components
    this.prComps[0] = map(prComps_[0], -0.4094028, 0.6702876, -maxDist, maxDist); // X
    this.prComps[1] = map(prComps_[1], -0.4262940, 0.7053004, -maxDist, maxDist); // Y
    this.prComps[2] = map(prComps_[2], -0.3464782, 0.6421811, -maxDist, maxDist); // Z
    this.prComps[3] = map(prComps_[3], -0.3702722, 0.5380188, 10, 360); // R
    this.prComps[4] = map(prComps_[4], -0.3905856, 0.7148252, 10, 360); // G
    this.prComps[5] = map(prComps_[5], -0.3051968, 0.5752281, 10, 360); // B
    this.prComps[6] = map(prComps_[6], -0.3117960, 0.5103850, 1, 10);   // size
  }
  
  public void display(float transparency){
    colorMode(RGB, 360, 360, 360, 360);
    stroke(color(this.prComps[3], this.prComps[4], this.prComps[5], transparency));
    strokeWeight(this.prComps[6]);
    point(this.prComps[0], this.prComps[1], this.prComps[2]);
  } 
}