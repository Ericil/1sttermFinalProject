class Mob {
  float X;
  float Y;
  float hp;
  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }
  
  Mob(float x, float y){
    X = x;
    Y = y;
  }
  void draw(){
    rect(X,Y,50,50);
    fill(#FF0000);
  }
  float getHP(){
    return hp;
  }
  void setHP(float x){
    hp = x;
  }  
    
}

