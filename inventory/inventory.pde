float itemx = 40;
float itemy = 40;
int bs = 25;
boolean over = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
float armorx = 500;
float armory = 500;
void setup() {
  size(600, 600);
  rectMode(RADIUS); 
}

void draw() {
  stroke(0);
  fill(100, 200, 100);
  background(0);
  rect(0, height/4 * 3, width, height/4);
  fill(204, 102, 0);
  rect(armorx, armory, 25, 25);
  if (itemx - armorx < 10 && itemx - armorx > -10){
    itemx = armorx;
    itemy = armory;
  }
  // Test if the cursor is over the box 
  if (mouseX > itemx-bs && mouseX < itemx+bs && mouseY > itemy-bs && mouseY < itemy+bs) {
    over = true;  
    if(!locked) { 
      stroke(255); 
      fill(153);
    } 
  } else {
    stroke(153);
    fill(153);
    over = false;
  }
  // Draw the box
  rect(itemx, itemy, bs, bs);
}

void mousePressed() {
  if(over) { 
    locked = true; 
    fill(255, 255, 255);
  } else {
    locked = false;
  }
  bdifx = mouseX-itemx; 
  bdify = mouseY-itemy; 
}

void mouseDragged() {
  if(locked) {
    itemx = mouseX-bdifx; 
    itemy = mouseY-bdify; 
  }
}

void mouseReleased() {
  locked = false;
}

