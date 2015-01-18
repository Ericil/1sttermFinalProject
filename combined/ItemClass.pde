class ItemClass{
  float x;
  float y;
  float size;
  boolean beenset;
  String name;
  ItemClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
    beenset = false;
  }
  ItemClass(){
    this("an item");
  }
    
  void generate(){
    rect(x, y, size, size);
  }
  float getx(){
    return x;
  }
  float gety(){
    return y;
  }
  float getsize(){
    return size;
  }
  boolean getbeenset(){
    return beenset;
  }
  String getname(){
    return name;
  }
  void setx(float a){
    x = a;
  }
  void sety(float a){
    y = a;
  }
  void setsize(float a){
    size = a;
  }
  void setbeenset(boolean a){
    beenset = a;
  }
  void setname(String a){
    name = a;
  }
}

