

class LibraryItem
{
  // Constructor variables
  float minDate, maxDate;
  float checkOut, checkIn;
  float popularity;
  String genre;

  // Other 
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

    if (this.checkIn != 0) {
      this.drawSegment();
    } else {
      this.drawDot();
    }
  }

  // Draws shape, called 
  private void drawSegment() {

    ArrayList<Long> months = this.getMonths();

    float scaleParam = 8000;
    float spacing = 20;
    float Z = map(this.popularity, 1, 20000, 0, maxDepth);
    float b = exp(abs((float)(Z/scaleParam)));

    segment = createShape();
    segment.beginShape();
    segment.noFill();
    segment.strokeWeight(1);

    for (int i = 1; i < months.size(); i++) {
      long start = months.get(i-1);
      long end = months.get(i);

      segment.stroke(this.monthColor(start));

      float theta0 = map(start, minDate, maxDate, 0, this.Nrad);
      float theta1 = map(end, minDate, maxDate, 0, this.Nrad);
      float r0 = theta0 + 150;

      while (theta0 < theta1)
      {
        segment.vertex(r0 * cos(theta0) * b, 
          r0 * sin(theta0) * b, 
          Z);
        theta0 += this.step;
        r0 = theta0 + 150;
      }
    }

    segment.endShape();
  }

  private void drawDot() {
    
    float scaleParam = 8000;
    float Z = map(this.popularity, 1, 20000, 0, maxDepth);
    float b = exp(abs((float)(Z/scaleParam)));
    float theta = map(this.checkOut, minDate, maxDate, 0, this.Nrad);
    float r = theta + 150;
    
    segment = createShape();
    segment.beginShape(POINTS);
    segment.noFill();
    segment.strokeWeight(3);
    segment.stroke(this.monthColor((long)this.checkOut*100));
    segment.vertex(r * cos(theta) * b, 
                   r * sin(theta) * b,
                   Z);
   segment.endShape();
    
  }

  private color monthColor(long month) {
    DateTime datetime = new DateTime(month*1000);
    int intMonth = datetime.getMonthOfYear();
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
    println(intMonth + "-->" + colorCodes[intMonth-1]);
    return colorCodes[intMonth-1];
  }

  public ArrayList<Long> getMonths() {

    DateTime checkOut = new DateTime((long)this.checkOut*1000);
    DateTime checkIn = new DateTime((long)this.checkIn*1000);

    ArrayList<Long> months = new ArrayList<Long>();

    int addTheseDays = checkOut.dayOfMonth().getMaximumValue() - checkOut.getDayOfMonth() + 1;
    checkOut = checkOut.plusDays(addTheseDays);

    int monthsLeft = new Period(checkOut, checkIn).getMonths();

    for (int i = 0; i < monthsLeft; i++) {
      addTheseDays = checkOut.dayOfMonth().getMaximumValue() - checkOut.getDayOfMonth() + 1;   
      checkOut = checkOut.plusDays(addTheseDays);   
      months.add(checkOut.getMillis()/1000);
    }

    months.add(checkIn.getMillis()/1000);

    return(months);
  }
}