class Mob {
  float X;
  float Y;
  int hp;
  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }

  Mob(float x, float y) {
    X = x;
    Y = y;
    hp = 10;
  }
  void draw() {
    rect(X, Y, 50, 50);
    fill(#FF0000);
  }
  int getHP() {
    return hp;
  }
  void setHP(int x) {
    hp = x;
  }
}

