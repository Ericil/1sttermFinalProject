import java.io.*;
import java.util.*;

int[] data;// data[0] = helmet, data[1] = armor, data[2] = boots, data[3] = weapon
float itemx;
float itemy;
float itemsize;
boolean over = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
float helmetx = 500;
float helmety = 100;
float chestx = 500;
float chesty = 170;
float bootsx = 500;
float bootsy = 240;
float weaponx = 430;
float weapony = 170;
ItemClass[] stuff;
void setup() {
  stuff = new ItemClass[10];
  data = new int[4];
  print(data[0]);
  size(600, 600);
  rectMode(RADIUS);
  stuff[0] = new ItemClass();
  data[0] = 1;
  loadallitems();
}

void draw() {
  stroke(0);
  fill(200, 200, 100);
  background(0);
  rect(0, height/4 * 3, width, height/4);
  fill(204, 202, 0);
  rect(helmetx, helmety, 25, 25);
  rect(chestx, chesty, 25, 25);
  rect(bootsx, bootsy, 25, 25);
  rect(weaponx, weapony, 25, 25);
  if (itemx - helmetx < 20 && itemx - helmetx > -20 && itemy - helmety < 20 && itemy - helmety > -20){
    itemx = helmetx;
    itemy = helmety;
  }
  if (itemx - chestx < 20 && itemx - chestx > -20 && itemy - chesty < 20 && itemy - chesty > -20){
    itemx = chestx;
    itemy = chesty;
  }
  if (itemx - bootsx < 20 && itemx - bootsx > -20 && itemy - bootsy < 20 && itemy - bootsy > -20){
    itemx = bootsx;
    itemy = bootsy;
  }
  if (itemx - weaponx < 20 && itemx - weaponx > -20 && itemy - weapony < 20 && itemy - weapony > -20){
    itemx = weaponx;
    itemy = weapony;
  }
  // Test if the cursor is over the box 
  if (mouseX > itemx-itemsize && mouseX < itemx+itemsize && mouseY > itemy-itemsize && mouseY < itemy+itemsize) {
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
  rect(itemx, itemy, itemsize, itemsize);
  stuff[0].generate();
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
void loadallitems(){
  if (data[0] != 0){
    print("\nthere are items");
    try{
      File thefile = new File("thehelmet.txt");
      Scanner run = new Scanner(thefile);
      while(run.hasNextLine()){
        print(run.next());
      }
    }catch(FileNotFoundException ugh){
      print("\nfile not found");
    }
  }
    
}
  
