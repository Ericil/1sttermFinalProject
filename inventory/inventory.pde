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
float bdifx = 0.0; 
float bdify = 0.0; 
float helmetx = 500;
float helmety = 100;
float armorx = 500;
float armory = 170;
float bootsx = 500;
float bootsy = 240;
float weaponx = 430;
float weapony = 170;
float settingx = 50;
float settingy = 350;
boolean isdown = false;
boolean isclicked = false;
String thechosen = "";
String thehelmet = "";
String thearmor = "";
String theboots = "";
String theweapon = "";
ItemClass[] stuff;
void setup() {
  stuff = new ItemClass[10];
  data = new int[4];
  size(600, 600);
  rectMode(RADIUS);
  stuff[0] = new ItemClass();
  data[0] = 1;
  reader = createReader("thehelmet.txt"); 
  loaditems(0);
  initalizeitems();
}

void draw() {
  printitems();  
  stroke(0);
  fill(200, 200, 100);
  background(0);
  rect(0, height/4 * 3, width, height/4);
  fill(204, 202, 0);
  rect(helmetx, helmety, 25, 25);
  rect(armorx, armory, 25, 25);
  rect(bootsx, bootsy, 25, 25);
  rect(weaponx, weapony, 25, 25);
  lockon();
  printitems();  
}

void mousePressed() {
  isdown = true;
}

void mouseDragged() {
}

void mouseReleased() {
  isdown = false;
  itemx = 0;
  itemy = 0;
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
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = helms[a].getname();
        }
        if (thechosen == helms[a].getname()){
          b = mouseX;
          c = mouseY;
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(helms[a].getname(), b - 10, c);
      fill(204, 202, 0);
      }
      if (isdown == false){
        if ((mouseX - helmetx < 30 && mouseX - helmetx > -30 && mouseY - helmety < 30 && mouseY - helmety > -30 && thechosen == helms[a].getname()) || thehelmet == helms[a].getname()){
          b = helmetx;
          c = helmety;
          thehelmet = helms[a].getname();
        }else if (b != helmetx && c != helmety){
          b = helms[a].getx();
          c = helms[a].gety();
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(helms[a].getname(), b - 10, c);
      fill(204, 202, 0);
      isclicked = false;
      }
    }
  }
  if (armors != null && armors.length != 0) {
    for (int a = 0; a < armors.length; a++) {
      float b = armors[a].getx();
      float c = armors[a].gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = armors[a].getname();
        }
        if (thechosen == armors[a].getname()){
          b = mouseX;
          c = mouseY;
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(armors[a].getname(), b - 10, c);
      fill(204, 202, 0);
      }
      if (isdown == false){
        if ((mouseX - armorx < 30 && mouseX - armorx > -30 && mouseY - armory < 30 && mouseY - armory > -30 && thechosen == armors[a].getname()) || thearmor == armors[a].getname()){
          b = armorx;
          c = armory;
          thearmor = armors[a].getname();
        }else if (b != armorx && c != armory){
          b = armors[a].getx();
          c = armors[a].gety();
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(armors[a].getname(), b - 10, c);
      fill(204, 202, 0);
      isclicked = false;
      }
    }
  }
  if (bootss != null && bootss.length != 0) {
    for (int a = 0; a < bootss.length; a++) {
      float b = bootss[a].getx();
      float c = bootss[a].gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = bootss[a].getname();
        }
        if (thechosen == bootss[a].getname()){
          b = mouseX;
          c = mouseY;
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(bootss[a].getname(), b - 10, c);
      fill(204, 202, 0);
      }
      if (isdown == false){
        if ((mouseX - bootsx < 30 && mouseX - bootsx > -30 && mouseY - bootsy < 30 && mouseY - bootsy > -30 && thechosen == bootss[a].getname()) || theboots == bootss[a].getname()){
          b = bootsx;
          c = bootsy;
          theboots = bootss[a].getname();
        }else if (b != bootsx && c != bootsy){
          b = bootss[a].getx();
          c = bootss[a].gety();
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(bootss[a].getname(), b - 10, c);
      fill(204, 202, 0);
      isclicked = false;
      }
    }
  }
  if (weapons != null && weapons.length != 0) {
    for (int a = 0; a < weapons.length; a++) {
      float b = weapons[a].getx();
      float c = weapons[a].gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = weapons[a].getname();
        }
        if (thechosen == weapons[a].getname()){
          b = mouseX;
          c = mouseY;
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(weapons[a].getname(), b - 10, c);
      fill(204, 202, 0);
      }
      if (isdown == false){
        if ((mouseX - weaponx < 30 && mouseX - weaponx > -30 && mouseY - weapony < 30 && mouseY - weapony > -30 && thechosen == weapons[a].getname()) || theweapon == weapons[a].getname()){
          b = weaponx;
          c = weapony;
          theweapon = weapons[a].getname();
        }else if (b != weaponx && c != weapony){
          b = weapons[a].getx();
          c = weapons[a].gety();
        }
      fill(204, 202, 0);
      rect(b, c, 20, 20);
      fill(0, 102, 153);
      text(weapons[a].getname(), b - 10, c);
      fill(204, 202, 0);
      isclicked = false;
      }
    }
  }
}

void lockon() {
  if (itemx - helmetx < 20 && itemx - helmetx > -20 && itemy - helmety < 20 && itemy - helmety > -20) {
    itemx = helmetx;
    itemy = helmety;
  }
  if (itemx - armorx < 20 && itemx - armorx > -20 && itemy - armory < 20 && itemy - armory > -20) {
    itemx = armorx;
    itemy = armory;
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

