

class Edge{
  
  float[] coord1 = new float[3];
  float[] coord2 = new float[3];

  public Edge(Article art1, Article art2){
    this.coord1 = Arrays.copyOfRange(art1.prComps, 0, 2);
    this.coord2 = Arrays.copyOfRange(art2.prComps, 0, 2);
    
  }
  
  
  
}