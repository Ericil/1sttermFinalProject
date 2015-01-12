import java.io.*;
import java.util.*;
BufferedReader reader;
String line;
HelmetClass[] helms;
ArmorClass[] armors;
BootsClass[] bootss;
WeaponClass[] weapons;
ItemClass[] items;
String[] inbetween;
int[] data;// data[0] = helmet, data[1] = armor, data[2] = boots, data[3] = weapon
float itemx;
float itemy;
float itemsize = 20;
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
float settingx = 50;
float settingy = 350;
ItemClass[] stuff;
void setup() {
  stuff = new ItemClass[10];
  data = new int[4];
  print(data[0]);
  size(600, 600);
  rectMode(RADIUS);
  stuff[0] = new ItemClass();
  data[0] = 1;
  reader = createReader("thehelmet.txt"); 
  loaditems(0);
  initalizeitems();
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
  printitems();
  lockon();
  // Test if the cursor is over the box
  if (mouseX > itemx-itemsize && mouseX < itemx+itemsize && mouseY > itemy-itemsize && mouseY < itemy+itemsize) {
    over = true;  
    if (!locked) { 
      stroke(255); 
      fill(153);
    }
  } else {
    stroke(153);
    fill(153);
    over = false;
  }
  rect(itemx, itemy, 20, 20);
  // Draw the box
}

void mousePressed() {
  if (over) { 
    locked = true; 
    fill(255, 255, 255);
  } else {
    locked = false;
  }
  bdifx = mouseX-itemx; 
  bdify = mouseY-itemy;
}

void mouseDragged() {
  if (locked) {
    itemx = mouseX-bdifx; 
    itemy = mouseY-bdify;
  }
}

void mouseReleased() {
  locked = false;
}
void loaditems(int b) {
  try {
    line = reader.readLine();
  } 
  catch (Exception e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    print("nope");
    noLoop();
  } else {
    inbetween = split(line, ",");
    print(inbetween[0]);
    if (b == 0) {
      helms = new HelmetClass[inbetween.length];
    }
    if (b == 1) {
      armors = new ArmorClass[inbetween.length];
    }
    if (b == 2) {
      bootss = new BootsClass[inbetween.length];
    }
    if (b == 3) {
      weapons = new WeaponClass[inbetween.length];
    }
    for (int a = 0; a < inbetween.length; a++) {
      if (b == 0) {
        helms[a] = new HelmetClass(inbetween[a]);
      }
      if (b == 1) {
        armors[a] = new ArmorClass(inbetween[a]);
      }
      if (b == 2) {
        bootss[a] = new BootsClass(inbetween[a]);
      }
      if (b == 3) {
        weapons[a] = new WeaponClass(inbetween[a]);
      }
    }
  }
}
void initalizeitems() {
  if (helms != null && helms.length != 0) {
    for (int b = 0; b < helms.length; b++) {
      helms[b].setx(settingx);
      helms[b].sety(settingy);
      if (settingx < 550) {
        settingx += 50;
      } else {
        settingx = 50;
        settingy += 50;
      }
    }
  }
  if (armors != null && armors.length != 0) {
    for (int b = 0; b < armors.length; b++) {
      armors[b].setx(settingx);
      armors[b].sety(settingy);
      if (settingx < 550) {
        settingx += 50;
      } else {
        settingx = 50;
        settingy += 50;
      }
    }
  }
  if (bootss != null && bootss.length != 0) {
    for (int b = 0; b < bootss.length; b++) {
      bootss[b].setx(settingx);
      bootss[b].sety(settingy);
      if (settingx < 550) {
        settingx += 50;
      } else {
        settingx = 50;
        settingy += 50;
      }
    }
  }
  if (weapons != null && weapons.length != 0) {
    for (int b = 0; b < weapons.length; b++) {
      weapons[b].setx(settingx);
      weapons[b].sety(settingy);
      if (settingx < 550) {
        settingx += 50;
      } else {
        settingx = 50;
        settingy += 50;
      }
    }
  }
} 
void printitems() {
  textSize(10);
  if (helms != null && helms.length != 0) {
    for (int a = 0; a < helms.length; a++) {
      float b = helms[a].getx();
      float c = helms[a].gety();
      rect(b, c, itemsize, itemsize);
      fill(0, 102, 153);
      text(helms[a].getname(), b - 10, c);
      fill(204, 202, 0);
      if (mouseX > b-itemsize && mouseX < b+itemsize && mouseY > c-itemsize && mouseY < c+itemsize) {
        itemx = b;
        itemy = c;
      }
    }
  }
  if (armors != null && armors.length != 0) {
    for (int a = 0; a < armors.length; a++) {
      float b = armors[a].getx();
      float c = armors[a].gety();
      rect(b, c, itemsize, itemsize);
      text(armors[a].getname(), b - 10, c);
      fill(204, 202, 0);
      if (mouseX > b-itemsize && mouseX < b+itemsize && mouseY > c-itemsize && mouseY < c+itemsize) {
        itemx = b;
        itemy = c;
      }
    }
  }
  if (bootss != null && bootss.length != 0) {
    for (int a = 0; a < bootss.length; a++) {
      float b = bootss[a].getx();
      float c = bootss[a].gety();
      rect(b, c, itemsize, itemsize);
      fill(0, 102, 153);
      text(bootss[a].getname(), b - 10, c);
      fill(204, 202, 0);
      if (mouseX > b-itemsize && mouseX < b+itemsize && mouseY > c-itemsize && mouseY < c+itemsize) {
        itemx = b;
        itemy = c;
      }
    }
  }
  if (weapons != null && weapons.length != 0) {
    for (int a = 0; a < weapons.length; a++) {
      float b = weapons[a].getx();
      float c = weapons[a].gety();
      rect(b, c, itemsize, itemsize);
      fill(0, 102, 153);
      text(weapons[a].getname(), b - 10, c);
      fill(204, 202, 0);
      if (mouseX > b-itemsize && mouseX < b+itemsize && mouseY > c-itemsize && mouseY < c+itemsize) {
        itemx = b;
        itemy = c;
      }
    }
  }
}

void lockon() {
  if (itemx - helmetx < 20 && itemx - helmetx > -20 && itemy - helmety < 20 && itemy - helmety > -20) {
    itemx = helmetx;
    itemy = helmety;
  }
  if (itemx - chestx < 20 && itemx - chestx > -20 && itemy - chesty < 20 && itemy - chesty > -20) {
    itemx = chestx;
    itemy = chesty;
  }
  if (itemx - bootsx < 20 && itemx - bootsx > -20 && itemy - bootsy < 20 && itemy - bootsy > -20) {
    itemx = bootsx;
    itemy = bootsy;
  }
  if (itemx - weaponx < 20 && itemx - weaponx > -20 && itemy - weapony < 20 && itemy - weapony > -20) {
    itemx = weaponx;
    itemy = weapony;
  }
}

