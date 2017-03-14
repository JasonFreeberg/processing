/*
  Jason Freeberg
  MAT 259 -- Winter 2017
  Visualizing the structure of Wikipedia. Used a Python webscaper to gather data.
  Visualization begins with the data structured according to the Philosophy rule: https://en.wikipedia.org/wiki/Wikipedia:Getting_to_Philosophy
  Performed PCA on the text to allow the data to take its own shape as well.
*/

import peasy.*;
import controlP5.*;
import java.util.Map;

PShape aShape;
PeasyCam cam;
final float[] minComps = {-0.4094028, -0.4262940, -0.3464782, -0.3702722, -0.3905856, -0.3051968, -0.3117960, -0.3182977};
final float[] maxComps = {0.6702876, 0.7053004, 0.6421811, 0.5380188, 0.7148252, 0.5752281, 0.5103850, 0.5354660};
// Viz constants and parameters
final float zCenter = 0;
final float startDistance = 150;
final float maxDist = 50;
boolean usePCA = true;

// Arrays
Map<String, Integer> title2indx = new HashMap<String, Integer>();
ArrayList<Article> articles = new ArrayList<Article>();
ArrayList<Edge> edges = new ArrayList<Edge>();

// Variables for loading data and passing to objects
Table table;
int nRows, level;
String title, parent;
float[] prComps = new float[8];

void setup(){
  size(1280, 720, P3D);
  
  cam = new PeasyCam(this, 0, 0, zCenter, startDistance);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(startDistance + 950);
  cam.setWheelScale(0.5);
  
  table = loadTable("wikiPCA.csv", "header");
  nRows = table.getRowCount();
  
  //   0      1    2      3,  4,  5,  6,  7,  8,  9, 10  
  // title,level,parent, x0, x1, x2, x3, x4, x5, x6, x7
  print("Reading data...");
  for(int i = 0; i < nRows-6; i+=5){
    title = table.getString(i, 0);
    level = table.getInt(i, 1);
    parent = table.getString(i, 2);
    
    // Get principle components
    for(int j = 0; j < 8; j++){ 
      prComps[j] = map(table.getFloat(i, j+3), minComps[j], maxComps[j], -maxDist, maxDist);
      print(prComps[j] + "   ");
    }
    print('\n');
    articles.add(new Article(title, parent, level, prComps));
  }
  println(" done!");
}


void draw(){
  lights();
  background(250, 250, 250);
  int fuck = 9;
  for(int i = -100; i < 100; i+=10){
    pushMatrix();
      translate(i,0,0);
      sphere(1);
    popMatrix();
  }
  articles.get(fuck).drawShape(usePCA);
  for(int i = 0; i < articles.size(); i++){
    if(i % 10 == 0){
      println(articles.get(i).shape);
    }
  }
  
}