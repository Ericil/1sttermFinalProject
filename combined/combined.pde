import java.io.*;
import java.util.*;
BufferedReader reader;
String[] line;
ArrayList<HelmetClass> helms = new ArrayList<HelmetClass>(1);
ArrayList<ArmorClass> armors = new ArrayList<ArmorClass>(1);
ArrayList<BootsClass> bootss = new ArrayList<BootsClass>(1);
ArrayList<WeaponClass> weapons = new ArrayList<WeaponClass>(1);
HelmetClass[] possiblehelms;
ArmorClass[] possiblearmors;
BootsClass[] possiblebootss;
WeaponClass[] possibleweapons;
Mob[] themobs;
String[] inbetween;
int[] data;// data[0] = helmet, data[1] = armor, data[2] = boots, data[3] = weapon
float itemx;
float itemy;
float itemsize = 20;
float bdifx = 0.0; 
float bdify = 0.0; 
float helmetx = 1150;
float helmety = 100;
float armorx = 1150;
float armory = 170;
float bootsx = 1150;
float bootsy = 240;
float weaponx = 1080;
float weapony = 170;
float settingx = 1000;
float settingy = 350;
boolean isdown = false;
boolean isclicked = false;
String thechosen = "";
String thehelmet = "";
String thearmor = "";
String theboots = "";
String theweapon = "";
int value = 0;
int xvaluerect = 75;
int yvaluerect = 25;
int toMoveX = 0;
int toMoveY = 0;
int damage = 1;
color w = 0;
color a = 0;
color s = 0;
color d = 0;
PImage player;
boolean locked;
boolean[] keys;
PImage up;
PImage down;
PImage left;
PImage right;
PImage map;
int playerHP;
int chance;
int level;
String mapname;
int footstep = 1;
int X;
int Y;
void setup () {
  size(1250, 850);
  background(-1);
  player = loadImage("down0.jpg");
  PImage img;
  img = loadImage("newmap1.jpg");
  image(img, 0, 0);
  locked = false;
  keys=new boolean[4];
  keys[0]=false; //w
  keys[1]=false; //a
  keys[2]=false; //s
  keys[3]=false; //d
  up = loadImage("up0.jpg");
  down = loadImage("down0.jpg");
  left = loadImage("left0.jpg");
  right = loadImage("right0.jpg");
  playerHP = 30;
  level = 1;
  mapname = "newmap1.jpg";
  rectMode(RADIUS); 
  themobs = new Mob[10];
  for (int a = 0; a < 10; a++) {
    themobs[a] = new Mob();
    randomCords(themobs[a]);
  }
  loadpossibleitems();
}

void draw() {
  if ((xvaluerect == 925) && (yvaluerect == 725)) {
    level++;
    mapname = "newmap" + Integer.toString(level) + ".jpg";
    map = loadImage(mapname);
    image(map, 0, 0);
    xvaluerect = 75;
    yvaluerect = 25;
    themobs = new Mob[10];
    for (int a = 0; a < 10; a++) {
      themobs[a] = new Mob();
      randomCords(themobs[a]);
    }
  }
  initializeitems();
  mapname = "newmap" + Integer.toString(level) + ".jpg";
  toMove();
  blockUpdate();
  background(-1);
  map = loadImage(mapname);
  image(map, 0, 0);
  move(toMoveX, toMoveY);
  image(player, xvaluerect-25, yvaluerect-25);
  rectMode(CORNER);
  fill(90);
  rect(1000, 0, 250, 750);
  fill(0);
  rect(0, 750, 1250, 100);
  textSize(15);
  fill(-1);
  text("Weapon damage: ", 20, 770);
  text("Armor: ", 20, 790);
  text("Health: ", 20, 810);
  text("Hit chance: ", 20, 830);
  rectMode(CENTER);
  toMoveX = 0;
  toMoveY = 0;
  stroke(0);
  fill(204, 202, 0);
  rect(helmetx, helmety, 50, 50);
  rect(armorx, armory, 50, 50);
  rect(bootsx, bootsy, 50, 50);
  rect(weaponx, weapony, 50, 50);
  lockon();
  printitems();
  fill(#FF0000);
  for (int a = 0; a < themobs.length; a++) {
    if (themobs[a].getHP() > 0) {
      themobs[a].draw();
    }
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
/*
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
 */

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
      if (footstep == 1) {
        up = loadImage("up1.jpg");
        footstep = 0;
      } else {
        up = loadImage("up0.jpg");
        footstep = 1;
      }
    }
    if (w == -65536) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getX() == xvaluerect && themobs[a].getY() == yvaluerect - 50) {
          combat(themobs[a]);
        }
      }
    }
    player = up;
    keyClear();
  }
  if (keys[1]) {
    blockUpdate();
    if (a == -1 ) {
      toMoveX = -50;//left
      if (footstep == 1) {
        left = loadImage("left1.jpg");
        footstep = 0;
      } else {
        left = loadImage("left0.jpg");
        footstep = 1;
      }
    }
    if (a == -65536) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getX() == xvaluerect - 50 && themobs[a].getY() == yvaluerect) {
          combat(themobs[a]);
        }
      }
    }
    player = left;
    keyClear();
  }
  if (keys[2]) {
    blockUpdate();
    if (s == -1) {    
      toMoveY = 50;//down
      if (footstep == 1) {
        down = loadImage("down1.jpg");
        footstep = 0;
      } else {
        down = loadImage("down0.jpg");
        footstep = 1;
      }
    }
    if (s == -65536) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getX() == xvaluerect && themobs[a].getY() == yvaluerect + 50) {
          combat(themobs[a]);
        }
      }
    }
    player = down;
    keyClear();
  }
  if (keys[3]) {
    blockUpdate();
    if (d == -1) {
      toMoveX = 50;//right
      if (footstep == 1) {
        right = loadImage("right1.jpg");
        footstep = 0;
      } else {
        right = loadImage("right0.jpg");
        footstep = 1;
      }
    }
    if (d == -65536) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getX() == xvaluerect + 50 && themobs[a].getY() == yvaluerect) {
          combat(themobs[a]);
        }
      }
    }
    keyClear();
    player = right;
  }
}

void combat(Mob a) {
  print("\n\n\n\n");
  chance = int(random(100));
  if (chance > 30) {
    a.setHP(a.getHP() - damage);
  } else {
    print("You missed\n");
  }
  if (chance > 50 && a.getHP() > 0) {
    playerHP -= a.getATK();
  }
  print("Player: " + playerHP + " HP\n");
  print("Enemy: " + a.getHP() + " HP");
  if (a.getHP() <= 0) {
    if (chance > 0) {
      int random1 = int(random(4));
      if (random1 == 0) {
        int random2 = int(random(possiblehelms.length));
        helms.add(new HelmetClass(possiblehelms[random2].getname()));
      }
      if (random1 == 1) {
        int random2 = int(random(possiblearmors.length));
        armors.add(new ArmorClass(possiblearmors[random2].getname()));
      }
      if (random1 == 2) {
        int random2 = int(random(possiblebootss.length));
        bootss.add(new BootsClass(possiblebootss[random2].getname()));
      }
      if (random1 == 3) {
        int random2 = int (random(possibleweapons.length));
        weapons.add(new WeaponClass(possibleweapons[random2].getname()));
      }
    }
  }
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
void loadpossibleitems() {
  for (int b = 0; b < 4; b++) {
    if (b == 0) {
      line = loadStrings("thehelmets.txt");
      inbetween = split(line[0], ",");
      possiblehelms = new HelmetClass[inbetween.length];
      for (int a = 0; a < inbetween.length; a++) {
        possiblehelms[a] = new HelmetClass(inbetween[a]);
      }
    }
    if (b == 1) {
      line = loadStrings("thearmors.txt");
      inbetween = split(line[0], ",");
      possiblearmors = new ArmorClass[inbetween.length];
      for (int a = 0; a < inbetween.length; a++) {
        possiblearmors[a] = new ArmorClass(inbetween[a]);
      }
    }
    if (b == 2) {
      line = loadStrings("theboots.txt");
      inbetween = split(line[0], ",");
      possiblebootss = new BootsClass[inbetween.length];
      for (int a = 0; a < inbetween.length; a++) {
        possiblebootss[a] = new BootsClass(inbetween[a]);
      }
    }
    if (b == 3) {
      line = loadStrings("theweapons.txt");
      inbetween = split(line[0], ",");
      possibleweapons = new WeaponClass[inbetween.length];
      for (int a = 0; a < inbetween.length; a++) {
        possibleweapons[a] = new WeaponClass(inbetween[a]);
      }
    }
  }
}
void initializeitems() {
  if (helms.size() != 0) {
    for (int b = 0; b < helms.size (); b++) {
      if (helms.get(b).getbeenset() == false) {
        if (settingx < 1200) {
          settingx += 50;
        } else {
          settingx = 1050;
          settingy += 50;
        }
        helms.get(b).setx(settingx);
        helms.get(b).sety(settingy);
        helms.get(b).setbeenset(true);
      }
    }
  }
  if (armors.size() != 0) {
    for (int b = 0; b < armors.size (); b++) {
      if (armors.get(b).getbeenset() == false) {
        if (settingx < 1200) {
          settingx += 50;
        } else {
          settingx = 1050;
          settingy += 50;
        }
        armors.get(b).setx(settingx);
        armors.get(b).sety(settingy);
        armors.get(b).setbeenset(true);
      }
    }
  }
  if (bootss.size() != 0) {
    for (int b = 0; b < bootss.size (); b++) {
      if (bootss.get(b).getbeenset() == false) {
        if (settingx < 1200) {
          settingx += 50;
        } else {
          settingx = 1050;
          settingy += 50;
        }
        bootss.get(b).setx(settingx);
        bootss.get(b).sety(settingy);
        bootss.get(b).setbeenset(true);
      }
    }
  }
  if (weapons.size() != 0) {
    for (int b = 0; b < weapons.size (); b++) {
      if (weapons.get(b).getbeenset() == false) {
        if (settingx < 1200) {
          settingx += 50;
        } else {
          settingx = 1050;
          settingy += 50;
        }
        weapons.get(b).setx(settingx);
        weapons.get(b).sety(settingy);
        weapons.get(b).setbeenset(true);
      }
    }
  }
} 
void printitems() {
  textSize(10);
  if (helms.size() != 0) {
    for (int a = 0; a < helms.size (); a++) {
      float b = helms.get(a).getx();
      float c = helms.get(a).gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = helms.get(a).getname();
        }
        if (thechosen == helms.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(helms.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        imageMode(CENTER);
        PImage theimage = loadImage("helm" + helms.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
      if (isdown == false) {
        if ((mouseX - helmetx < 30 && mouseX - helmetx > -30 && mouseY - helmety < 30 && mouseY - helmety > -30 && thechosen == helms.get(a).getname()) || thehelmet == helms.get(a).getname()) {
          b = helmetx;
          c = helmety;
          thehelmet = helms.get(a).getname();
        } else if (b != helmetx && c != helmety) {
          b = helms.get(a).getx();
          c = helms.get(a).gety();
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(helms.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        isclicked = false;
        imageMode(CENTER);
        PImage theimage = loadImage("helm" + helms.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
    }
  }
  if (armors != null && armors.size() != 0) {
    for (int a = 0; a < armors.size (); a++) {
      float b = armors.get(a).getx();
      float c = armors.get(a).gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = armors.get(a).getname();
        }
        if (thechosen == armors.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(armors.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        imageMode(CENTER);
        PImage theimage = loadImage("armor" + armors.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
      if (isdown == false) {
        if ((mouseX - armorx < 30 && mouseX - armorx > -30 && mouseY - armory < 30 && mouseY - armory > -30 && thechosen == armors.get(a).getname()) || thearmor == armors.get(a).getname()) {
          b = armorx;
          c = armory;
          thearmor = armors.get(a).getname();
        } else if (b != armorx && c != armory) {
          b = armors.get(a).getx();
          c = armors.get(a).gety();
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(armors.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        isclicked = false;
        imageMode(CENTER);
        PImage theimage = loadImage("armor" + armors.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
    }
  }
  if (bootss != null && bootss.size() != 0) {
    for (int a = 0; a < bootss.size (); a++) {
      float b = bootss.get(a).getx();
      float c = bootss.get(a).gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = bootss.get(a).getname();
        }
        if (thechosen == bootss.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(bootss.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        imageMode(CENTER);
        PImage theimage = loadImage("boots" + bootss.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
      if (isdown == false) {
        if ((mouseX - bootsx < 30 && mouseX - bootsx > -30 && mouseY - bootsy < 30 && mouseY - bootsy > -30 && thechosen == bootss.get(a).getname()) || theboots == bootss.get(a).getname()) {
          b = bootsx;
          c = bootsy;
          theboots = bootss.get(a).getname();
        } else if (b != bootsx && c != bootsy) {
          b = bootss.get(a).getx();
          c = bootss.get(a).gety();
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(bootss.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        isclicked = false;
        imageMode(CENTER);
        PImage theimage = loadImage("boots" + bootss.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
    }
  }
  if (weapons != null && weapons.size() != 0) {
    for (int a = 0; a < weapons.size (); a++) {
      float b = weapons.get(a).getx();
      float c = weapons.get(a).gety();
      if (isdown == true) {
        if (b - mouseX < 30 && b - mouseX > -30 && c - mouseY < 30 && c - mouseY > -30 && isclicked == false) {
          isclicked = true;
          thechosen = weapons.get(a).getname();
        }
        if (thechosen == weapons.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0, 102, 153);
        text(weapons.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        imageMode(CENTER);
        PImage theimage = loadImage("sword" + weapons.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
      }
      if (isdown == false) {
        if ((mouseX - weaponx < 30 && mouseX - weaponx > -30 && mouseY - weapony < 30 && mouseY - weapony > -30 && thechosen == weapons.get(a).getname()) || theweapon == weapons.get(a).getname()) {
          b = weaponx;
          c = weapony;
          theweapon = weapons.get(a).getname();
        } else if (b != weaponx && c != weapony) {
          b = weapons.get(a).getx();
          c = weapons.get(a).gety();
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);  
        fill(0, 102, 153);
        text(weapons.get(a).getname(), b - 10, c);
        fill(204, 202, 0);
        isclicked = false;
        imageMode(CENTER);
        PImage theimage = loadImage("sword" + weapons.get(a).getname() + ".png");
        image(theimage, b, c);
        imageMode(CORNER);
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

void randomCords(Mob a) {
  boolean test = true;
  while (test) {
    X = ((int(random(18)) + 1) * 50) +25;
    Y = ((int(random(13)) + 1) * 50) +25;
    if (get(X, Y) == -1) {
      test = false;
      a.setX(X);
      a.setY(Y);
    }
  }
}

