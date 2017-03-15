
import peasy.*;
import controlP5.*;
import java.util.Map;
import java.util.Arrays;
import java.lang.System;

// Peasy and P5
PeasyCam cam;
ControlP5 cp5;
CheckBox checkboxLevel;

// Viz constants and parameters
final float maxDist = 3000;
final float startDistance = maxDist + 750;
boolean showAxis = true;
boolean showGUI = true;
boolean searchNow = false;

// Arrays and maps
ArrayList<Article> articles1 = new ArrayList<Article>();
ArrayList<Article> articles2 = new ArrayList<Article>();
ArrayList<String> selectedTitles = new ArrayList();
HashMap<String, Article> titleMap = new HashMap<String, Article>(); // Maps the title to the article
HashMap<String, Edge> edgeMap = new HashMap<String, Edge>(); // Holds edges and the name of the connected child

void setup(){
  size(1280, 720, P3D);
  
  // Controls
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  checkboxLevel = cp5.addCheckBox("checkboxLevel")
                     .setPosition(width - 490, 20)
                     .setColorActive(color(10, 80, 0))
                     .setColorLabel(color(0))
                     .setSize(40, 40)
                     .setItemsPerRow(3)
                     .setSpacingColumn(30)
                     .setSpacingRow(20)
                     .addItem("0", 0)
                     .addItem("1", 1)
                     .addItem("2", 2)
                    ;
                    
  cp5.addTextfield("input")
     .setPosition(width - 230, 20)
     .setSize(200,40)
     .setFont(createFont("SansSerif", 15))
     .setFocus(true)
     .setColor(color(255,255,255))
     .setAutoClear(false)
     ;
     
  cp5.addScrollableList("dropdown")
     .setPosition(width - 230, 62)
     .setSize(200, height/2)
     .setBarHeight(20)
     .setItemHeight(20)
     .setType(ControlP5.LIST)
     .setFont(createFont("SansSerif", 10))
     .getCaptionLabel().setVisible(false).hide();
  
  cp5.addButton("submit")
     .setValue(0)
     .setSize(40,40)
     .setPosition(width - 280, 20)
     .setOff()
     ;
  
  checkboxLevel.activateAll();
  
  // PeasyCam setup
  cam = new PeasyCam(this, 0, 0, 0, startDistance);
  //cam.setYawRotationMode();
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(maxDist + 1550);
  cam.setRotations(0.5, 0.5, -0.25);
  cam.setWheelScale(0.08);
  
  // Loading Data
  Table table;
  int nRows, level_;
  String title_, parent_;
  float[] prCompHolder;
  
  table = loadTable("wikiPCA.csv", "header");
  nRows = table.getRowCount();
  int step = 1;
  
  prCompHolder = new float[7];
  for(int i = 0; i < nRows-step; i+=step){
    title_ = table.getString(i, 0);
    parent_ = table.getString(i, 2);
    level_ = table.getInt(i, 1);
    
    prCompHolder[0] = table.getFloat(i, 3);
    prCompHolder[1] = table.getFloat(i, 4);
    prCompHolder[2] = table.getFloat(i, 5);
    prCompHolder[3] = table.getFloat(i, 6);
    prCompHolder[4] = table.getFloat(i, 7);
    prCompHolder[5] = table.getFloat(i, 8);
    prCompHolder[6] = table.getFloat(i, 9);
    
    Article tempArticle = new Article(title_, parent_, level_, prCompHolder);

    titleMap.put(title_, tempArticle);
  }
  for(Article child: titleMap.values()){
    Article parent = titleMap.get(child.parent);
    Edge edge = new Edge(child.prComps, parent.prComps, child.title, parent.title);
      
    edgeMap.put(child.title, edge);
  }

}

void draw(){
  //colorMode(RGB, 255, 255, 255);
  background(360, 360, 360);
  lights();
  
  checkArticles();
  
  draw_axis(showAxis);
  GUI(showGUI);
  
}