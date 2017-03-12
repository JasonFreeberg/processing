// For connecting articles to their parents/children

class Edge{
  
  // a1, a2 -> article1, article2
  Article a1;
  Article a2;
  float[] a1Coord = new float[3];
  float[] a2Coord = new float[3];
  
  public void Edge(Article article1, Article article2){
    this.a1 = article1;
    this.a2 = article2;
  }
  
  private void makeLine(){
    this.a1Coord = this.a1.getCoordinates();
    this.a2Coord = this.a2.getCoordinates();
    
  }
  
}