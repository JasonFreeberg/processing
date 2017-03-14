void keyPressed(){
  
  // Plot axes
  if(key == '1'){ showAxis = !showAxis; }
  
  // Show GUI
  if(key == '2'){ showGUI = !showGUI; }
}

void draw_axis(boolean showAxis_){
  if(showAxis_){
    pushMatrix();
      translate(0,0,0); // reset to origin
      stroke(0, 0, 0);
      strokeWeight(0.5);
      line(-maxDist, 0, 0, maxDist, 0, 0);
      line(0, -maxDist, 0, 0, maxDist, 0);
      line(0, 0, -maxDist, 0, 0, maxDist);
    popMatrix();
  }
  
}

String textValue;
String selectedValue;

void GUI(boolean showGUI){
  if (cp5.getWindow().isMouseOver()) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
  
  if(showGUI){
    if(searchNow){
      println("Collecting text");
      searchNow = !searchNow;
      selectedTitles.clear();
      textValue = cp5.get(Textfield.class, "input").getText();
      
      for(String title : titleMap.keySet()){
        if(match(title.toLowerCase(), textValue.toLowerCase()) != null && !cp5.get(Textfield.class, "input").getText().equals("")){
          selectedTitles.add(title);
        }
      }
      cp5.get(ScrollableList.class, "dropdown").setItems(selectedTitles);
      cp5.get(ScrollableList.class, "dropdown").show();
      println(selectedTitles.size(), " items selected.");
    }else if(cp5.get(Textfield.class, "input").getText().equals("")){
      selectedTitles.clear();
      cp5.get(ScrollableList.class, "dropdown").hide();
    }
    
    hint(DISABLE_DEPTH_TEST);
    noLights();
    cam.beginHUD();
      cp5.draw();
    cam.endHUD();
    hint(ENABLE_DEPTH_TEST);
  }
}

public void submit(int theValue){
  println("Search button pressed.");
  searchNow = true;
}

public void PCA(){
  println("PCA button pressed.");
  usePCA = !usePCA;
}

void checkArticles(){
  
  for(Article anArticle : titleMap.values()){
    if(checkboxLevel.getArrayValue()[anArticle.level] == 1){
      if(selectedTitles.size() > 0){ // user selected some titles
        if(selectedTitles.contains(anArticle.title)){
          anArticle.display(255);
        }
        else{
          anArticle.display(42.0);
        }
      }else{
        anArticle.display(255);
      }
    }
  }
}

public ArrayList<String> getLineage(String searchString){
  ArrayList<String> titleTree = new ArrayList<String>();
  while(searchString.toLowerCase() != "philosphy"){
    titleTree.add(searchString);
    searchString = parentMap.get(searchString).title;
  }
  titleTree.add("Philosophy");
  return(titleTree);
}

public void drawTree(ArrayList<String> theTitles){
  ArrayList<Float> coordinates = new ArrayList<Float>(); 
  Float X,Y,Z;
  
  for(String title: theTitles){
    for(int j = 0; j < 3; j++){
      coordinates.add(titleMap.get(title).prComps[j]);
    }
  }
  PShape s = createShape();
  s.setStrokeWeight(1.5);
  s.setStroke(color(0));
  for(int j = 0; j < coordinates.size()-3; j+=3){
    X = coordinates.get(j);
    Y = coordinates.get(j+1);
    Z = coordinates.get(j+2);
    s.vertex(X,Y,Z);
  }
  s.endShape();
  shape(s);
}

public static <T> boolean contains(final T[] array, final T v) {
    if (v == null) {
        for (final T e : array)
            if (e == null)
                return true;
    } else {
        for (final T e : array)
            if (e == v || v.equals(e))
                return true;
    }

    return false;
}