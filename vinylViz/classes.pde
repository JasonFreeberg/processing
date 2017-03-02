

class LibraryItem
{
  // Constructor variables
  private float minDate, maxDate;
  private float checkOut, checkIn;
  private float popularity, maxPop;
  public boolean dot;
  public int month, year;

  // Other 
  public PShape segment;
  private float step = 0.20;
  private float Nrad = 80 * 2 * PI;
  color[] colorCodes = {color(#1395BA), 
                        color(#117899), 
                        color(#0F5B78), 
                        color(#0D3C55), 
                        color(#C02E1D), 
                        color(#D94E1F), 
                        color(#F16C20), 
                        color(#EF8B2C), 
                        color(#ECAA38), 
                        color(#EBC844), 
                        color(#A2B86C), 
                        color(#5CA793)};
  // Constructor
  public LibraryItem(float minDate, float maxDate, float checkOut, 
                     float checkIn, int month, int year, float popularity, float maxPop)
  {
    this.minDate = minDate;
    this.maxDate = maxDate;
    this.checkOut = checkOut;
    this.checkIn = checkIn;
    this.month = month - 1;
    this.year = year;
    this.popularity = popularity;
    this.maxPop = maxPop;
    
    this.drawSegment();
  }

  // Draws shape, called 
  private void drawSegment() {

    float scaleParam = 6000;
    float spacing = 180;
    float Z = map(log(this.popularity), 1, log(this.maxPop), 0, maxDepth);
    float b = exp(abs((float)(Z/scaleParam)));
    
    
    segment = createShape();
    float theta0 = map(this.checkOut, minDate, maxDate, 0, this.Nrad);
    float theta1 = map(this.checkIn, minDate, maxDate, 0, this.Nrad);
    float r0 = theta0 + spacing;
    if(this.checkIn != 0){
      this.dot = false;
      segment.beginShape();
      segment.noFill();
      segment.stroke(this.colorCodes[this.month]);
      segment.strokeWeight(1);
      while (theta0 < theta1)
      {
        segment.vertex(r0 * cos(theta0) * b, 
                       r0 * sin(theta0) * b, 
                       maxDepth - Z);
        theta0 += this.step;
        r0 = theta0 + spacing;
      }
  
      segment.endShape();
    } else {
      this.dot = true;
      segment = createShape();
      segment.beginShape(POINTS);
      segment.noFill();
      segment.strokeWeight(3);
      segment.stroke(this.colorCodes[this.month]);
      segment.vertex(r0 * cos(theta0) * b, 
                     r0 * sin(theta0) * b,
                     maxDepth - Z);
      segment.endShape();
    }
  }
}