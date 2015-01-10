void setup () {
  size(600, 600);
  background(50);
  rect(100, 100, 50, 50);
  player = loadImage("player.jpg");
  frameRate(60);
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
Mob m = new Mob(200.0, 125.0);
void draw() {
  PImage img;
  img = loadImage("testmap.jpg");
  image(img, 0, 0);

  move(toMoveX, toMoveY);
  image(player, xvaluerect-25, yvaluerect-25);
  rectMode(CENTER);
  w = get(xvaluerect, yvaluerect-50);
  a = get(xvaluerect-50, yvaluerect);
  s = get(xvaluerect, yvaluerect+50);
  d = get(xvaluerect+50, yvaluerect);
  toMoveX = 0;
  toMoveY = 0;
}
void keyPressed() {
  if (key == 119 || key == 87) {
    if (w == -1) {
      toMoveY = -50; //up
      w = get(xvaluerect, yvaluerect-50);
    }
    PImage up;
    up = loadImage("up.jpg");
    player = up;
    return;
  } else if (key == 97 || key == 65) {  
    if (a == -1 ) {
      toMoveX = -50;//left
      a = get(xvaluerect-50, yvaluerect);
    }
    PImage left;
    left = loadImage("left.jpg");
    player = left;
        return;
  } else if (key == 115 || key == 83) {    
    if (s == -1) {    
      toMoveY = 50;//down
      s = get(xvaluerect, yvaluerect+50);
    }
    PImage down;
    down = loadImage("down.jpg");
    player = down;
        return;
  } else if (key == 100 || key == 68) {
    if (d == -1) {
      toMoveX = 50;//right
      d = get(xvaluerect+50, yvaluerect);
    }
    PImage right;
    right = loadImage("right.jpg");
    player = right;
        return;
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

