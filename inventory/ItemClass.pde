class ItemClass{
  float x = 100;
  float y = 100;
  float size = 20;
  ItemClass(){
  }
  
  void generate(){
    rect(x, y, size, size);
  }
}
