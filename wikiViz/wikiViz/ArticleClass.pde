

class Article{
  String title;
  String parent;
  int level;
  float[] prcomps;
  private boolean usingPCA;
  private PShape shape;
  private float maxDist = 500; // absolute max distance in x,y,z directions
  private color[] colorCodes = {color(#38e1ff), color(#35ff64), color(#ff4747)};
  private color pcaColor;
  private float[] defaultCoord = new float [3];
  
  public Article(String title, String parent, int level, float[] prcomps){
    this.title = title;
    this.parent = parent;
    this.level = level;
    this.prcomps = prcomps;
    
    // Calculate some values in constructor
    this.pcaColor = color(prcomps[4], prcomps[5], prcomps[6]);
    this.defaultCoord[1] = map(level, 0, 2, 0, -maxDist);
  }
  
  
  private void makeShape(){
    this.shape = createShape(SPHERE);
    
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
      this.shape.setFill(this.colorCodes[this.level]);
      this.shape.setStroke(this.colorCodes[this.level]);
    }else{
      this.usingPCA = true;
      this.shape.translate(this.prcomps[0], this.prcomps[0], this.prcomps[0]);
      this.shape.setFill(this.pcaColor);
      this.shape.setStroke(this.pcaColor);
    }
    
  }
  
  
}