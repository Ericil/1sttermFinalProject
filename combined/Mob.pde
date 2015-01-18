class Mob {
  int X;
  int Y;
  int hp;
  int atk;
  boolean spawn = false;
  PImage pic;
  String mobname;
  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }
  
  Mob(int x, int y, int HP, int ATK) {
    hp = HP;
    atk = ATK;
    X = x;
    Y = x;
    mobname = "mob" + Integer.toString(int(random(4) + 1)) + ".png";
  }
  Mob(){
    this(0, 0, 10, 10);
    mobname = "mob" + Integer.toString(int(random(4) + 1)) + ".png";
  }
  void draw() {
    
    rect(X, Y, 50, 50);
    fill(#FF0000);
    pic = loadImage(mobname);
    image(pic,X-25,Y-25);
  }
  int getHP() {
    return hp;
  }
  int getATK(){
    return atk;
  }
  void setHP(int x) {
    hp = x;
  }
  void setX(int a){
    X = a;
  }
  void setY(int a){
    Y = a;
  }
  void setatk(int a){
    atk = a;
  }
}
