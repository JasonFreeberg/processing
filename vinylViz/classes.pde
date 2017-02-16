class LibraryItem
{
  
  // Constructor variables
  float minDate, maxDate;
  float checkOut, checkIn;
  float popularity;
  String genre;
  
  // Other 
  private float theta0, theta1, r0, r1;
  public PShape segment;
  private float step = 0.005;
  private float Nrad = 100 * 2 * PI;
  private color[] genreColors = {color(#565565), color(#019274), color(#571534), color(#098614), color(#918264), color(#726535)};
  
  // Constructor
  public LibraryItem(float minDate, float maxDate, float checkOut, 
                     float checkIn, float popularity, String genre)
  {
    this.minDate = minDate;
    this.maxDate = maxDate;
    this.checkOut = checkOut;
    this.checkIn = checkIn;
    this.popularity = popularity;
    this.genre = genre;
    
    this.makePShape();
  }
  
  private void makePShape()
  {
    this.getPolar();
    
    float scaleParam = 8000;
    float spacing = 20;
    float Z = map(this.popularity, 1, 20000, 0, maxDepth);
    float b = exp(abs((float)(Z/scaleParam)));
    
    segment = createShape();
    segment.beginShape();
    segment.noFill();
    segment.stroke(this.genreColor());
    segment.strokeWeight(1);
    while(this.theta0 < this.theta1)
    {
      segment.vertex(this.r0 * cos(this.theta0) * b,
                     this.r0 * sin(this.theta0) * b,
                     Z);
      this.theta0 += this.step;
      this.r0 = this.theta0 + 150;
    }
    segment.endShape();
  }
  
  // Get starting coordinates and ending theta
  private void getPolar()
  {
    this.theta0 = map(this.checkOut, minDate, maxDate, 0, this.Nrad);
    this.theta1 = map(this.checkIn, minDate, maxDate, 0, this.Nrad);
    this.r0 = this.theta0 + 150;
  }
  
  // Use genre to get the color
  private color genreColor()
  {
    int index = int(random(this.genreColors.length));
    return this.genreColors[index];
  }
  
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////























class DummySegments{
  
  float minDate, maxDate;
  float checkOut, checkIn;
  float popularity;
  float theta0, theta1, r0, r1;
  PShape segment;
  float step = 0.005;
  float Nrad = 100 * 2 * PI;
  float epsilon = 0.01;
  
  public DummySegments(float minDate, float maxDate){
    
    // Generate data
    this.checkOut = random(minDate, maxDate);
    this.checkIn = random(this.checkOut + 1, maxDate);
    this.popularity = random(1, 20000); 
    
    assert(minDate < this.checkIn && this.checkIn < maxDate);
    assert(minDate < this.checkOut && this.checkOut < maxDate);
    
    // Map angle from dates to --> (0 < date < N*2*pi)
    this.theta0 = map(this.checkOut, minDate, maxDate, 0, this.Nrad);
    this.theta1 = map(this.checkIn, minDate, maxDate, 0, this.Nrad);
    
    this.r0 = this.theta0 + 150;
    
    this.makePShape();
  }
  
  private void makePShape(){
    float scaleParam = 8000;
    float spacing = 20;
    float Z = map(this.popularity, 1, 20000, 0, maxDepth);
    float b = exp(abs((float)(Z/scaleParam)));
    
    segment = createShape();
    segment.beginShape();
    while(this.theta0 < this.theta1){
      segment.noFill();
      segment.stroke(0);
      segment.strokeWeight(0.5);
      segment.vertex(this.r0 * cos(this.theta0) * b,
                     this.r0 * sin(this.theta0) * b,
                     Z);
         
      this.theta0 += this.step;
      this.r0 = this.theta0 + 150;
    }
    segment.endShape();
  }
}