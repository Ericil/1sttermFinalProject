class Mob {
  int X;
  int Y;
  int hp;
  int atk;
  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }

  Mob(int x, int y, int HP, int ATK) {
    X = x;
    Y = y;
    hp = HP;
    atk = ATK;
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
  int getATK(){
    return atk;
  }
}

