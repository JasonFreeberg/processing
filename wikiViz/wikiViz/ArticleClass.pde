// Holds each article's title, parent's title, depth, and principle components

class Article{
  String title;
  String parent;
  int level;
  float[] prcomps = new float[8];
  private boolean usingPCA;
  //public PShape shape;
  private color[] colorCodes = {color(#38e1ff), color(#35ff64), color(#ff4747)};
  private final float maxDist = 200; // absolute max distance in x,y,z directions
  private final float[] minComps = {-0.4094028, -0.4262940, -0.3464782, -0.3702722, -0.3905856, -0.3051968, -0.3117960, -0.3182977};
  private final float[] maxComps = {0.6702876, 0.7053004, 0.6421811, 0.5380188, 0.7148252, 0.5752281, 0.5103850, 0.5354660};
  private color pcaColor;
  private float[] defaultCoord = new float [3];
  
  public Article(String title, String parent, int level, float[] prcomps_){
    this.title = title;
    this.parent = parent;
    this.level = level;
    this.prcomps = prcomps_;
    
    // Calculate some values in constructor
    for(int i = 0; i < 3; i++){
      print(this.prcomps[i] + "   ");
      this.prcomps[i] = random(-maxDist, maxDist); //map(this.prcomps[i], minComps[i], maxComps[i], -maxDist, maxDist);
    }
    for(int i = 3; i < 6; i++){
      this.prcomps[i] = map(this.prcomps[i], minComps[i], maxComps[i], 0, 255);
    }
    
    this.pcaColor = color(prcomps[3], prcomps[4], prcomps[5]);
    this.defaultCoord[1] = map(level, 0, 2, 0, -maxDist);
    print(this.pcaColor);
    print('\n');
  }
  
  private void makeShape(){
    //this.shape = createShape(SPHERE, 100);
  }
  
  public float[] getCoordinates(){
    float[] returnVect = new float[3];
    if(this.usingPCA){
      for(int i = 0; i < 2; i++){ returnVect[i] = this.prcomps[i]; }
    }else{
      for(int i = 0; i < 2; i++){ returnVect[i] = this.defaultCoord[i]; }
    }
    return(returnVect);
  }
  
  public void drawShape(boolean usePCA){
    /*
      Sets color and location of the spheres dependent upon
      the user's choice to use PCA or not. "ucaPCA" is set 
      from user input thru controlP5.
    */
    if(usePCA == false){ // don't use PCA
      this.usingPCA = false;
      //this.shape.translate(__, this.defaultY, __);
      //this.shape.setFill(this.colorCodes[this.level]);
      //this.shape.setStroke(this.colorCodes[this.level]);
    }else{ // use PCA
      //print("Plotting!");
      this.usingPCA = true;
      
      pushMatrix();
        fill(this.pcaColor);
        stroke(this.pcaColor);
        translate(this.prcomps[0], this.prcomps[1], this.prcomps[2]);
        //print(this.prcomps[0], this.prcomps[1], this.prcomps[2], this.title, '\n');
        sphere(0.5);
      popMatrix();
      //this.shape.translate(this.prcomps[0], this.prcomps[1], this.prcomps[2]);
      //this.shape.setFill(color(0,0,0));
      //this.shape.setStroke(color(0,0,0));
      //shape(this.shape);
      
      //this.shape.setFill(this.pcaColor);
      //this.shape.setStroke(this.pcaColor);
    }
    
  }
  
  
}