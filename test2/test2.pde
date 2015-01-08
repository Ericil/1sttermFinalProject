void setup (){
  size(600, 600);
    background(50);
    rect(100, 100, 50, 50);
}
int value = 0;
int xvaluerect = 125;
int yvaluerect = 75;
int xvaluecircle = 300;
int yvaluecircle = 300;
color w = 0;
color a = 0;
color s = 0;
color d = 0;
PImage player;
void draw(){
  //stop disappearing
        PImage img;
  img = loadImage("testmap.jpg");
  image(img, 0, 0); 
  player = loadImage("player.jpg");
  image(player, xvaluerect-25, yvaluerect-25);
  rectMode(CENTER);
  w = get(xvaluerect,yvaluerect-50);
  a = get(xvaluerect-50,yvaluerect);
  s = get(xvaluerect,yvaluerect+50);
  d = get(xvaluerect+50,yvaluerect);  
  ellipse(xvaluecircle, yvaluecircle, 50, 50);
  if ((xvaluerect - xvaluecircle < 50 && xvaluerect - xvaluecircle > -100) && (yvaluerect - yvaluecircle < 50 && yvaluerect - yvaluecircle > -100)){
    fill(600, 0, 0);
    ellipse(xvaluecircle, yvaluecircle, 50, 50);
  }
}
void wrapping(){
    if (xvaluerect > 600){
    xvaluerect = 0;
  } else if (xvaluerect < 0){
    xvaluerect = 600;
  }
  if (yvaluerect > 600){
    yvaluerect = 0;
  }else if (yvaluerect < 0){
    yvaluerect = 600;
  }
}
void keyPressed() {
    if (w == -1 && key == 119 || key == 87) {
       yvaluerect -= 50; //up
       PImage up;
    up = loadImage("up.jpg");
    player = up;
  } else if (a == -1 && key == 97 || key == 65) {
    xvaluerect -= 50;//left
    PImage left;
    left = loadImage("left.jpg");
    player = left;
  } else if (s == -1 && key == 115 || key == 83) {
    yvaluerect += 50;//down
    PImage down;
    down = loadImage("down.jpg");
    player = down;
  } else if (d == -1 && key == 100 || key == 68) {
    xvaluerect += 50;//right
    PImage right;
    right = loadImage("right.jpg");
    player = right;
  }
}
