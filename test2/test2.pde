void setup () {
  size(1000, 750);
  background(-1);
  player = loadImage("player.jpg");
  frameRate(10);
  Walls();
  PImage img;
  img = loadImage("newmap1.jpg");
  image(img, 0, 0);
  Walls();
  locked = false;
  keys=new boolean[4];
  keys[0]=false; //w
  keys[1]=false; //a
  keys[2]=false; //s
  keys[3]=false; //d
  up = loadImage("up.jpg");
  down = loadImage("down.jpg");
  left = loadImage("left.jpg");
  right = loadImage("right.jpg");
  playerHP = 10;
  level = 1;
  mapname = "newmap1.jpg";
}
int value = 0;
int xvaluerect = 125;
int yvaluerect = 75;
int toMoveX = 0;
int toMoveY = 0;
color w = 0;
color a = 0;
color s = 0;
color d = 0;
PImage player;
boolean locked;
boolean[] keys;
Mob m = new Mob(175, 125, 10, 10);
PImage up;
PImage down;
PImage left;
PImage right;
PImage map;
int playerHP;
int chance;
int level;
String mapname;
void draw() {

  mapname = "newmap" + Integer.toString(level) + ".jpg";
  toMove();
  blockUpdate();
  background(-1);
  map = loadImage(mapname);
  image(map, 0, 0);
  move(toMoveX, toMoveY);
  image(player, xvaluerect-25, yvaluerect-25);
  rectMode(CENTER);

  toMoveX = 0;
  toMoveY = 0;
  if (m.getHP() > 0) {
    m.draw();
  }
  if ((xvaluerect == 925) && (yvaluerect == 725)) {
    level++;
    xvaluerect = 75;
    yvaluerect = 25;
  }
}

void delay(int delay)
{
  int time = millis();
  while (millis () - time <= delay);
}

void keyPressed() {
  if (key == 119 || key == 87) { //w
    keys[0] = true;
  }
  if (key == 97 || key == 65) { //a
    keys[1] = true;
  }
  if (key == 115 || key == 83) { //s
    keys[2] = true;
  }
  if (key == 100 || key == 68) { //d
    keys[3] = true;
  }
}

void keyReleased() {
  if (key == 119 || key == 87) { //w
    keys[0] = false;
  }
  if (key == 97 || key == 65) { //a
    keys[1] = false;
  }
  if (key == 115 || key == 83) { //s
    keys[2] = false;
  }
  if (key == 100 || key == 68) { //d
    keys[3] = false;
  }
} 

void move(int X, int Y) {
  xvaluerect += X;
  yvaluerect += Y;
}

void wrapping() {
  if (xvaluerect > 600) {
    xvaluerect = 0;
  } else if (xvaluerect < 0) {
    xvaluerect = 600;
  }
  if (yvaluerect > 600) {
    yvaluerect = 0;
  } else if (yvaluerect < 0) {
    yvaluerect = 600;
  }
}

void Walls() {
  for (int i = 0; i < 20; i++) {
    insertWall(i, 0);
    insertWall(0, i);
    insertWall(19, i);
    insertWall(i, 14);
  }
}
void insertWall(int x, int y) {
  PImage wall = loadImage("wall.jpg");
  image(wall, x * 50, y * 50);
}
void insertSpace(int x, int y) {
  PImage space = loadImage("space.jpg");
  image(space, x * 50, y * 50);
}

void keyClear() {
  keys[0]=false; //w
  keys[1]=false; //a
  keys[2]=false; //s
  keys[3]=false; //d
}

void blockUpdate() {
  w = get(xvaluerect, yvaluerect-50);
  a = get(xvaluerect-50, yvaluerect);
  s = get(xvaluerect, yvaluerect+50);
  d = get(xvaluerect+50, yvaluerect);
}

/*
void mouseClicked() {
 if (get(mouseX, mouseY) == -1) {
 insertWall(mouseX/50, mouseY/50);
 } else {
 insertSpace(mouseX/50, mouseY/50);
 }
 }
 */

void toMove() {
  if (keys[0]) {
    blockUpdate();
    if (w == -1) {   
      toMoveY = -50; //up
    }
    if (w == -65536) {
      combat(m);
    }
    player = up;
    keyClear();
  }
  if (keys[1]) {
    blockUpdate();
    if (a == -1 ) {
      toMoveX = -50;//left
    }
    if (a == -65536) {
      combat(m);
    }
    player = left;
    keyClear();
  }
  if (keys[2]) {
    blockUpdate();
    if (s == -1) {    
      toMoveY = 50;//down
    }
    if (s == -65536) {
      combat(m);
    }
    player = down;
    keyClear();
  }
  if (keys[3]) {
    blockUpdate();
    if (d == -1) {
      toMoveX = 50;//right
    }
    if (d == -65536) {
      combat(m);
    }
    keyClear();
    player = right;
  }
}

void combat(Mob a) {
  print("\n\n\n\n");
  int damage = 1;
  chance = int(random(100));
  if (chance > 30) {
    a.setHP(a.getHP() - damage);
  } else {
    print("You missed\n");
  }

  print("Player: " + playerHP + " HP\n");
  print("Enemy: " + a.getHP() + " HP");
}

