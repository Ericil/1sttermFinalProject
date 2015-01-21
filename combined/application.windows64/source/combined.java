import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class combined extends PApplet {



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
float bdifx = 0.0f; 
float bdify = 0.0f; 
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
int w = 0;
int a = 0;
int s = 0;
int d = 0;
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
public void setup () {
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

public void draw() {
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
    if(keyPressed){
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

public void delay(int delay)
{
  int time = millis();
  while (millis () - time <= delay);
}

public void keyPressed() {
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

public void keyReleased() {
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

public void move(int X, int Y) {
  xvaluerect += X;
  yvaluerect += Y;
}

public void wrapping() {
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

public void keyClear() {
  keys[0]=false; //w
  keys[1]=false; //a
  keys[2]=false; //s
  keys[3]=false; //d
}

public void blockUpdate() {
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
public void toMove() {
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

public void combat(Mob a) {
  print("\n\n\n\n");
  damagedealt = "";
  damagetaken = "";
  mobhp = "";
  mobhp +=a.getHP();
  int randomly = PApplet.parseInt(random(100));
  if (chance > randomly) {
    a.setHP(a.getHP() - damage);
    damagedealt = "you have dealt " + damage + " points of damage!";
  } else {
    damagedealt = "you have missed!";
    print("You missed\n");
  }
  randomly = PApplet.parseInt(random(100));
  if (randomly > 50 && a.getHP() > 0) {
    playerHP = playerHP - PApplet.parseInt(a.getATK() - (a.getATK()*armor));
    damagetaken = "you have taken " + (a.getATK() - armor) + " points of damage!";
  } else {
    damagetaken = "you have taken no damage!";
    print("Player: " + playerHP + " HP\n");
    print("Enemy: " + a.getHP() + " HP");
  }
  randomly = PApplet.parseInt(random(100));
  if (a.getHP() <= 0) {
    if (randomly > 50) {
      int random1 = PApplet.parseInt(random(4));
      if (random1 == 0) {
        int random2 = PApplet.parseInt(random(possiblehelms.length));
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
        int random2 = PApplet.parseInt(random(possiblearmors.length));
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
        int random2 = PApplet.parseInt(random(possiblebootss.length));
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
        int random2 = PApplet.parseInt (random(possibleweapons.length));
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
public void mousePressed() {
  isdown = true;
}

public void mouseDragged() {
}

public void mouseReleased() {
  isdown = false;
  itemx = 0;
  itemy = 0;
}
public void loadpossibleitems() {
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
public void initializeitems() {
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
public void printitems() {
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
        text("MaxHP: " + (100 + PApplet.parseInt(helms.get(a).getname())*10), b - 28, c - 28);
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
        text("MaxHP: " + (100 + PApplet.parseInt(helms.get(a).getname())*10), b - 28, c - 28);
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
        text("Armor(%): " + PApplet.parseInt(1 + PApplet.parseInt(armors.get(a).getname()))*10, b - 30, c - 28);
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
        text("Armor(%): " + PApplet.parseInt(1 + PApplet.parseInt(armors.get(a).getname()))*10, b - 30, c - 28);
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
        text("Hit %: " + (45 + PApplet.parseInt(bootss.get(a).getname())*5), b - 20, c - 28);
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
        text("Hit %: " + (45 + PApplet.parseInt(bootss.get(a).getname())*5), b - 20, c - 28);
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
        text("ATK: " + (2 + PApplet.parseInt(weapons.get(a).getname())), b - 17, c - 28);
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
        text("ATK: " + (2 + PApplet.parseInt(weapons.get(a).getname())), b - 17, c - 28);
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

public void lockon() {
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

public void randomCords(Mob a) {
  boolean test = true;
  while (test) {
    X = ((PApplet.parseInt(random(18)) + 1) * 50) +25;
    Y = ((PApplet.parseInt(random(13)) + 1) * 50) +25;
    if (get(X, Y) == -1) {
      test = false;
      a.setX(X);
      a.setY(Y);
    }
  }
}
public void modifystats() {
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
    armor = .2f;
  }
  if (thearmor.equals("2")) {
    armor = .3f;
  }
  if (thearmor.equals("3")) {
    armor = .4f;
  }
  if (thearmor.equals("4")) {
    armor = .5f;
  }
  if (thearmor.equals("5")) {
    armor = .6f;
  }
  if (thearmor.equals("6")) {
    armor = .7f;
  }
  if (thearmor.equals("7")) {
    armor = .8f;
  }
  if (thearmor.equals("8")) {
    armor = .9f;
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

public void runGame() {
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
      themobs = new Mob[10];
      for (int a = 0; a < 10; a++) {
        themobs[a] = new Mob();
        randomCords(themobs[a]);
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
    text("Armor(%): " + PApplet.parseInt(armor * 100), 20, 790);
    text("Health: " + playerHP, 20, 810);
    text("Hit chance: " + chance, 20, 830);
    fill(0xffFF0000);
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
    fill(0xffFF0000);
    for (int a = 0; a < themobs.length; a++) {
      if (themobs[a].getHP() > 0) {
        themobs[a].draw();
      }
    }
    modifystats();
  }
}

class ArmorClass extends ItemClass{
  ArmorClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
  }
  ArmorClass(){
    this("a peice of armor");
  }
  
  float Durability;
  public float getDurability(){
    return x;
  }
  public void setDurability(float a){
    Durability = a;
  }
}
class BootsClass extends ItemClass{
  BootsClass(){
    this("a pair of boots");
  }
  BootsClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
  }
  
}

class HelmetClass extends ItemClass {
  HelmetClass(){
    this("a helmet");
  }
  HelmetClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
    beenset = false;
  }
    
}

class ItemClass{
  float x;
  float y;
  float size;
  boolean beenset;
  String name;
  ItemClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
    beenset = false;
  }
  ItemClass(){
    this("an item");
  }
    
  public void generate(){
    rect(x, y, size, size);
  }
  public float getx(){
    return x;
  }
  public float gety(){
    return y;
  }
  public float getsize(){
    return size;
  }
  public boolean getbeenset(){
    return beenset;
  }
  public String getname(){
    return name;
  }
  public void setx(float a){
    x = a;
  }
  public void sety(float a){
    y = a;
  }
  public void setsize(float a){
    size = a;
  }
  public void setbeenset(boolean a){
    beenset = a;
  }
  public void setname(String a){
    name = a;
  }
}

class Mob {
  int X;
  int Y;
  int hp;
  float atk;
  boolean spawn = false;
  PImage pic;
  String mobname;
  public float getX() {
    return X;
  }
  public float getY() {
    return Y;
  }
  
  Mob(int x, int y, int HP, float ATK) {
    hp = HP;
    atk = ATK;
    X = x;
    Y = x;
    mobname = "mob" + Integer.toString(PApplet.parseInt(random(4) + 1)) + ".png";
  }
  Mob(){
    this(0, 0, 15, 3);
    mobname = "mob" + Integer.toString(PApplet.parseInt(random(4) + 1)) + ".png";
  }
  public void draw() {
    
    rect(X, Y, 50, 50);
    fill(0xffFF0000);
    pic = loadImage(mobname);
    image(pic,X-25,Y-25);
  }
  public int getHP() {
    return hp;
  }
  public float getATK(){
    return atk;
  }
  public void setHP(int x) {
    hp = x;
  }
  public void setX(int a){
    X = a;
  }
  public void setY(int a){
    Y = a;
  }
  public void setatk(float a){
    atk = a;
  }
}
class WeaponClass extends ItemClass{
  WeaponClass(){
    this("a helmet");
  }
  WeaponClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
  }
  
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "combined" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
