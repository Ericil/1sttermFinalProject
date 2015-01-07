float bx = 40;
float by = 40;
int bs = 20;
boolean over = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 

void setup() {
  size(600, 600);
  rectMode(RADIUS);  
}

void draw() { 
  background(0);
  // Test if the cursor is over the box 
  if (mouseX > bx-bs && mouseX < bx+bs && mouseY > by-bs && mouseY < by+bs) {
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
  rect(bx, by, bs, bs);
}

void mousePressed() {
  if(over) { 
    locked = true; 
    fill(255, 255, 255);
  } else {
    locked = false;
  }
  bdifx = mouseX-bx; 
  bdify = mouseY-by; 
}

void mouseDragged() {
  if(locked) {
    bx = mouseX-bdifx; 
    by = mouseY-bdify; 
  }
}

void mouseReleased() {
  locked = false;
}

