class Mob {
  float X;
  float Y;
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
    fill(600);
    rect(X,Y,50,50);
    fill(600);
  }   
}

