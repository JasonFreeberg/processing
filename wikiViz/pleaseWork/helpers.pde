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
      
    }else if(cp5.get(Textfield.class, "input").getText().equals("")){
      selectedTitles.clear();
      cp5.get(ScrollableList.class, "dropdown").hide();
    }
    
    if(selectedTitles.size() > 0){
      drawlines();
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

void drawlines(){
  selectedValue = titleMap.get(selectedTitles.get((int)cp5.get(ScrollableList.class, "dropdown").getValue())).title;

  Edge edge = edgeMap.get(selectedValue);
  println(edge.child);
  //println(edge.parent);
  edge.drawLine();
  int s = 0;
  while(match(edge.parent.toLowerCase(), "philosophy") == null && s < 50){
    edge = edgeMap.get(edge.parent);
    edge.drawLine();
    println(edge.parent);
    //println("Edge from " + edge.child + " to " + edge.parent + ".");
    //edgeMap.get(edge.parent).drawLine();
    s++;
  }
  println(s);
}

void checkArticles(){
  for(Article anArticle : titleMap.values()){
    if(checkboxLevel.getArrayValue()[anArticle.level] == 1){
      if(selectedTitles.size() > 0){ // user selected some titles
        if(selectedTitles.contains(anArticle.title)){
          anArticle.display(255);
        }
        else{
          anArticle.display(10.0);
        }
      }else{
        anArticle.display(255);
      }
    }
  }
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