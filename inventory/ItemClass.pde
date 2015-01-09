class ItemClass{
  float x;
  float y;
  float size;
  ItemClass(){
    x = 50;
    y = 350;
    size = 20;
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
  void setx(float a){
    x = a;
  }
  void sety(float a){
    y = a;
  }
  void setsize(float a){
    size = a;
  }
}

