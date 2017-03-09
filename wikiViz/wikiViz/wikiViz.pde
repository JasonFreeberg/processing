/*
  
  
  
  
*/

import peasy.*;
import controlP5.*;
import java.util.Map;

PShape aShape;
PeasyCam cam;

// Viz constants
final float zCenter = 0;
final float startDistance = 80;

// Arrays
Map<String, Integer> title2indx = new HashMap<String, Integer>();
ArrayList<Article> articles = new ArrayList<Article>();
ArrayList<Edge> edges = new ArrayList<Edge>();

// Variables for loading data
Table table;
int nRows;
String title, parent;
int level;

void setup(){
  size(1280, 720, P3D);
  
  cam = new PeasyCam(this, 0, 0, zCenter, startDistance);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(startDistance + 950);
  cam.setWheelScale(0.5);
  /*
  table = loadTable("hope copy.csv", "header");
  nRows = table.getRowCount();
  
  for(int i = 0; i < nRows; i++){
    title = table.getString(i, 9);
    parent = table.getString(i, 2);
    level = table.getInt(i, 8);
    
  }
  */
  aShape = createShape(SPHERE, 6);
}
float move = 0.1;
void draw(){
  lights();
  background(0,0,0);
  
  shape(aShape);
  aShape.translate(0 + move, 0.01, 0);
  aShape.setFill(color(#0a9a6a));
  aShape.setStroke(color(#0a9a6a));
  
  println(aShape.getParams());
}