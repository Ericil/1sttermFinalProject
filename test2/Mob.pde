class Mob {
  float X = 50;
  float Y = 50;
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

