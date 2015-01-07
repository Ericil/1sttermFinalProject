void setup (){
  size(600, 600);
    background(50);
    rect(100, 100, 50, 50);
}
int value = 0;
int xvaluerect = 100;
int yvaluerect = 0;
int xvaluecircle = 300;
int yvaluecircle = 300;
void draw(){
  //stop disappearing
  background(value);
  fill(255);
  wrapping();
  PImage img;
  img = loadImage("testmap.jpg");
  image(img, 0, 0);
  rect(xvaluerect, yvaluerect, 50, 50);
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
  if (key == 119 || key == 87) {
    yvaluerect -= 50;
  } else if (key == 97 || key == 65) {
    xvaluerect -= 50;
  } else if (key == 115 || key == 83) {
    yvaluerect += 50;
  } else if (key == 100 || key == 68) {
    xvaluerect += 50;
  }
}
