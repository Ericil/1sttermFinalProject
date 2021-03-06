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
boolean intro = false;
String thechosen = "";
String thehelmet = "";
String thearmor = "";
String theboots = "";
String theweapon = "";
String mobhp = "";
String damagedealt = "";
String damagetaken = "";
int value = 0;
int xvaluerect = 75; //75
int yvaluerect = 25; //25
int toMoveX = 0;
int toMoveY = 0;
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
int maxHP;
int playerHP;
int chance;
int damage;
float armor;
int level;
String mapname;
int footstep = 1;
int X;
int Y;
PImage start;
PImage dead;
PImage win;
PImage introscreen;
void setup () {
  settingx = 1000;
  settingy = 350;
  helms = new ArrayList<HelmetClass>(1);
  armors = new ArrayList<ArmorClass>(1);
  bootss = new ArrayList<BootsClass>(1);
  weapons = new ArrayList<WeaponClass>(1);
  size(1300, 850);
  background(-1);
  xvaluerect = 75;
  yvaluerect = 25;
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
  start = loadImage("startscreen1.jpg");
  dead = loadImage("deadscreen1.jpg");
  win = loadImage("win1.jpg");
  introscreen = loadImage("intro.png");
  playerHP = 100;
  maxHP = 100;
  chance = 40;
  armor = 1;
  damage = 2;
  level = 0;
  mapname = "newmap1.jpg";
  rectMode(RADIUS); 
  themobs = new Mob[10];
  for (int a = 0; a < 10; a++) {
    themobs[a] = new Mob();
    randomCords(themobs[a]);
  }
  loadpossibleitems();
  helms.add(new HelmetClass(possiblehelms[0].getname()));
  armors.add(new ArmorClass(possiblearmors[0].getname()));
  bootss.add(new BootsClass(possiblebootss[0].getname()));
  weapons.add(new WeaponClass(possibleweapons[0].getname()));
  thehelmet = helms.get(0).getname();
  theboots = bootss.get(0).getname();
  thearmor = armors.get(0).getname();
  theweapon = weapons.get(0).getname();
}

void draw() {
  if (level == 11) {
    background(1);         
    image(win, 0, 0);      
    if (mousePressed) {
      setup();
    }
  } else if (level == 0 && intro == true) {
    image(introscreen, 0, 0);
    if (mousePressed) {
      setup();
      level = 1;
      damagedealt = "";
      damagetaken = "";
      mobhp = "";
      intro = false;
    }
  } else if (level == 0 && intro == false) {
    image(start, 0, 0);
    if (keyPressed) {
      intro = true;
    }
  } else {
    runGame();
  }

  if (playerHP < 1) {
    background(-1);
    image(dead, 0, 0);
    if (mousePressed) {
      setup();
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
      damagedealt = "";
      damagetaken = "";
      mobhp = "";
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
      if (level == 10){
        if (themobs[10].getX() == xvaluerect && themobs[10].getY() == yvaluerect - 50) {
          combat(themobs[10]);
        }
      }
    }
    player = up;
    keyClear();
  }
  if (keys[1]) {
    blockUpdate();
    if (a == -1 ) {
      damagedealt = "";
      damagetaken = "";
      mobhp = "";
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
      if (level == 10){
        if (themobs[10].getX() == xvaluerect - 50 && themobs[10].getY() == yvaluerect) {
          combat(themobs[10]);
        }
      }
    }
    player = left;
    keyClear();
  }
  if (keys[2]) {
    blockUpdate();
    if (s == -1) {  
      damagedealt = "";
      damagetaken = "";
      mobhp = "";  
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
      if (level == 10){
        if (themobs[10].getX() == xvaluerect && themobs[10].getY() == yvaluerect + 50) {
          combat(themobs[10]);
        }
      }
    }
    player = down;
    keyClear();
  }
  if (keys[3]) {
    blockUpdate();
    if (d == -1) {
      damagedealt = "";
      damagetaken = "";
      mobhp = "";
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
      println("trigger");
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getX() == xvaluerect + 50 && themobs[a].getY() == yvaluerect) {
          combat(themobs[a]);
        }
      }
      if (level == 10){
        if (themobs[10].getX() == xvaluerect + 50 && themobs[10].getY() == yvaluerect) {
          combat(themobs[10]);
        }
      }
    }
    keyClear();
    player = right;
  }
}

void combat(Mob a) {
  print("\n\n\n\n");
  damagedealt = "";
  damagetaken = "";
  mobhp = "";
  mobhp += a.getHP();
  int randomly = int(random(100));
  if (chance > randomly) {
    a.setHP(a.getHP() - damage);
    damagedealt = "you have dealt " + damage + " points of damage!";
  } else {
    damagedealt = "you have missed!";
    print("You missed\n");
  }
  randomly = int(random(100));
  if (randomly > 50 && a.getHP() > 0) {
    playerHP = playerHP - int(a.getATK() - (a.getATK()*armor));
    damagetaken = "you have taken " + (a.getATK() - armor) + " points of damage!";
  } else {
    damagetaken = "you have taken no damage!";
    print("Player: " + playerHP + " HP\n");
    print("Enemy: " + a.getHP() + " HP");
  }
  randomly = int(random(100));
  if (a.getHP() <= 0) {
    if (randomly > 50) {
      int random1 = int(random(4));
      if (random1 == 0) {
        int random2 = int(random(possiblehelms.length));
        boolean already = false;
        for (int b = 0; b < helms.size () && already == false; b++) {
          if (helms.get(b).getname() == possiblehelms[random2].getname()) {
            already = true;
          }
        }
        if (already == false) {
          helms.add(new HelmetClass(possiblehelms[random2].getname()));
        }
      }
      if (random1 == 1) {
        int random2 = int(random(possiblearmors.length));
        boolean already = false;
        for (int b = 0; b < armors.size () && already == false; b++) {
          if (armors.get(b).getname() == possiblearmors[random2].getname()) {
            already = true;
          }
        }
        if (already == false) {
          armors.add(new ArmorClass(possiblearmors[random2].getname()));
        }
      }
      if (random1 == 2) {
        int random2 = int(random(possiblebootss.length));
        boolean already = false;
        for (int b = 0; b < bootss.size () && already == false; b++) {
          if (bootss.get(b).getname() == possiblebootss[random2].getname()) {
            already = true;
          }
        }
        if (already == false) {
          bootss.add(new BootsClass(possiblebootss[random2].getname()));
        }
      }
      if (random1 == 3) {
        int random2 = int (random(possibleweapons.length));
        boolean already = false;
        for (int b = 0; b < weapons.size () && already == false; b++) {
          if (weapons.get(b).getname() == possibleweapons[random2].getname()) {
            already = true;
          }
        }
        if (already == false) {
          weapons.add(new WeaponClass(possibleweapons[random2].getname()));
        }
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
          settingx += 60;
        } else {
          settingx = 1060;
          settingy += 70;
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
          settingx += 60;
        } else {
          settingx = 1060;
          settingy += 70;
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
          settingx += 60;
        } else {
          settingx = 1060;
          settingy += 70;
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
          settingx += 60;
        } else {
          settingx = 1060;
          settingy += 70;
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
        if (thechosen == helms.get(a).getname() && thehelmet != helms.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        if (helms.get(a).getname() == thehelmet) {
          b = helmetx;
          c = helmety;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0);
        text("MaxHP: " + (100 + int(helms.get(a).getname())*10), b - 28, c - 28);
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
        fill(0);
        text("MaxHP: " + (100 + int(helms.get(a).getname())*10), b - 28, c - 28);
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
        if (thechosen == armors.get(a).getname() && thearmor != armors.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        if (armors.get(a).getname() == thearmor) {
          b = armorx;
          c = armory;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0);
        text("Armor(%): " + int(1 + int(armors.get(a).getname()))*10, b - 30, c - 28);
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
        fill(0);
        text("Armor(%): " + int(1 + int(armors.get(a).getname()))*10, b - 30, c - 28);
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
        if (thechosen == bootss.get(a).getname() && bootss.get(a).getname() != theboots) {
          b = mouseX;
          c = mouseY;
        }
        if (bootss.get(a).getname() == theboots) {
          b = bootsx;
          c = bootsy;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0);
        text("Hit %: " + (45 + int(bootss.get(a).getname())*5), b - 20, c - 28);
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
        fill(0);
        text("Hit %: " + (45 + int(bootss.get(a).getname())*5), b - 20, c - 28);
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
        if (thechosen == weapons.get(a).getname()&& theweapon != weapons.get(a).getname()) {
          b = mouseX;
          c = mouseY;
        }
        if (weapons.get(a).getname() == theweapon) {
          b = weaponx;
          c = weapony;
        }
        fill(204, 202, 0);
        rect(b, c, 20, 20);
        fill(0);
        text("ATK: " + (2 + int(weapons.get(a).getname())), b - 17, c - 28);
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
        fill(0);
        text("ATK: " + (2 + int(weapons.get(a).getname())), b - 17, c - 28);
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
void modifystats() {
  if (theboots.equals("1")) {
    chance = 50;
  }
  if (theboots.equals("2")) {
    chance = 55;
  }
  if (theboots.equals("3")) {
    chance = 60;
  }
  if (theboots.equals("4")) {
    chance = 65;
  }
  if (thearmor.equals("1")) {
    armor = .2;
  }
  if (thearmor.equals("2")) {
    armor = .3;
  }
  if (thearmor.equals("3")) {
    armor = .4;
  }
  if (thearmor.equals("4")) {
    armor = .5;
  }
  if (thearmor.equals("5")) {
    armor = .6;
  }
  if (thearmor.equals("6")) {
    armor = .7;
  }
  if (thearmor.equals("7")) {
    armor = .8;
  }
  if (thearmor.equals("8")) {
    armor = .9;
  }
  if (theweapon.equals("1")) {
    damage = 3;
  }
  if (theweapon.equals("2")) {
    damage = 4;
  }
  if (theweapon.equals("3")) {
    damage = 5;
  }
  if (theweapon.equals("4")) {
    damage = 6;
  }
  if (theweapon.equals("5")) {
    damage = 7;
  }
  if (theweapon.equals("6")) {
    damage = 8;
  }
  if (theweapon.equals("7")) {
    damage = 9;
  }
  if (theweapon.equals("8")) {
    damage = 10;
  }
  if (theweapon.equals("9")) {
    damage = 11;
  }
  if (theweapon.equals("10")) {
    damage = 12;
  }
  if (theweapon.equals("11")) {
    damage = 13;
  }
  if (theweapon.equals("12")) {
    damage = 14;
  }
  if (theweapon.equals("13")) {
    damage = 15;
  }
  if (theweapon.equals("14")) {
    damage = 16;
  }
  if (theweapon.equals("15")) {
    damage = 18;
  }
  if (thehelmet .equals("1")) {
    maxHP = 110;
  }
  if (thehelmet .equals("2")) {
    maxHP = 120;
  }
  if (thehelmet .equals("3")) {
    maxHP = 130;
  }
  if (thehelmet .equals("4")) {
    maxHP = 140;
  }
  if (thehelmet .equals("5")) {
    maxHP = 150;
  }
  if (thehelmet .equals("6")) {
    maxHP = 160;
  }
}

void runGame() {
  if ((xvaluerect == 925) && (yvaluerect == 725)) {
    level++;
    mapname = "newmap" + Integer.toString(level) + ".jpg";
    if (level == 11) {
      background(1);    
      image(win, 0, 0);
      if (mousePressed) {
        setup();
      }
    } else {
      if (playerHP + 10 <= maxHP) {
        playerHP = playerHP + 10;
      } else {
        playerHP = maxHP;
      }
      map = loadImage(mapname);
      image(map, 0, 0);
      xvaluerect = 75;
      yvaluerect = 25;
      themobs = new Mob[11];
      for (int a = 0; a < 10; a++) {
        themobs[a] = new Mob();
        randomCords(themobs[a]);
      }
      if (level == 10) {
        themobs[10] = new Mob(925, 675, 200, 15);
        themobs[10].setmobname("mob5.png");
      }
    }
  } else {
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
    rect(1000, 0, 300, 750);
    fill(0);
    rect(0, 750, 1300, 100);
    textSize(15);
    fill(0);
    text("Inventory", 1010, 300);
    fill(-1);
    text("Weapon damage: " + damage, 20, 770);
    text("Armor(%): " + int(armor * 100), 20, 790);
    text("Health: " + playerHP, 20, 810);
    text("Hit chance: " + chance, 20, 830);
    fill(#FF0000);
    text("Combat", 500, 770);
    fill(-1);
    text("Enemy HP: " + mobhp, 500, 790);
    text(damagedealt, 500, 810);
    text(damagetaken, 500, 830);
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
    if (level != 10) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getHP() > 0) {
          themobs[a].draw();
        }
      }
    }
    if (level == 10) {
      for (int a = 0; a < 10; a++) {
        if (themobs[a].getHP() > 0) {
          themobs[a].draw();
        }
      }
      if (themobs[10].getHP() > 0) {
        themobs[10].getHP();
        themobs[10].draw();
      }
    }
    modifystats();
  }
}

