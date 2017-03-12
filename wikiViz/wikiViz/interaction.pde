// User interactivity

void keyPressed(){
  
  if(key == 'p' || key == 'P'){
    usePCA = !usePCA;
    if(usePCA){
      println("Using PCA.");
    } else {
      println("Not using PCA.");
    }
  }
  
  
}