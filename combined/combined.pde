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
float helmetx = 1150;
float helmety = 100;
float armorx = 1150;
float armory = 170;
float bootsx = 1150;
float bootsy = 240;
float weaponx = 1100;
float weapony = 170;
float settingx = 1120;
float settingy = 350;
boolean isdown = false;
boolean isclicked = false;
String thechosen = "";
String thehelmet = "";
String thearmor = "";
String theboots = "";
String theweapon = "";
ItemClass[] stuff;
int value = 0;
int xvaluerect = 125;
int yvaluerect = 75;
int toMoveX = 0;
int toMoveY = 0;
color w = 0;
color a = 0;
color s = 0;
color d = 0;
PImage player;
boolean locked;
boolean[] keys;
Mob m = new Mob(175, 125, 10, 10);
PImage up;
PImage down;
PImage left;
PImage right;
PImage map;
int playerHP;
int chance;
int level;
String mapname;
void setup () {
  size(1250, 750);
  background(-1);
  player = loadImage("player.jpg");
  frameRate(40);
  Walls();
  PImage img;
  img = loadImage("newmap1.jpg");
  image(img, 0, 0);
  Walls();
  locked = false;
  keys=new boolean[4];
  keys[0]=false; //w
  keys[1]=false; //a
  keys[2]=false; //s
  keys[3]=false; //d
  up = loadImage("up.jpg");
  down = loadImage("down.jpg");
  left = loadImage("left.jpg");
  right = loadImage("right.jpg");
  playerHP = 10;
  level = 1;
  mapname = "newmap1.jpg";
  stuff = new ItemClass[10];
  data = new int[4];
  rectMode(RADIUS);
  stuff[0] = new ItemClass();
  data[0] = 1;
  reader = createReader("thehelmet.txt"); 
  loaditems(0);
  initalizeitems();
}

void draw() {

  mapname = "newmap" + Integer.toString(level) + ".jpg";
  toMove();
  blockUpdate();
  background(-1);
  map = loadImage(mapname);
  image(map, 0, 0);
  move(toMoveX, toMoveY);
  image(player, xvaluerect-25, yvaluerect-25);
  rectMode(CENTER);

  toMoveX = 0;
  toMoveY = 0;
  if (m.getHP() > 0) {
    m.draw();
  }
  if ((xvaluerect == 925) && (yvaluerect == 725)) {
    level++;
    xvaluerect = 75;
    yvaluerect = 25;
  }
  printitems();  
  stroke(0);
  fill(200, 200, 100);
  fill(204, 202, 0);
  rect(helmetx, helmety, 25, 25);
  rect(armorx, armory, 25, 25);
  rect(bootsx, bootsy, 25, 25);
  rect(weaponx, weapony, 25, 25);
  lockon();
  printitems(); 
  print(helms[3].getx());
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
    }
    if (w == -65536) {
      combat(m);
    }
    player = up;
    keyClear();
  }
  if (keys[1]) {
    blockUpdate();
    if (a == -1 ) {
      toMoveX = -50;//left
    }
    if (a == -65536) {
      combat(m);
    }
    player = left;
    keyClear();
  }
  if (keys[2]) {
    blockUpdate();
    if (s == -1) {    
      toMoveY = 50;//down
    }
    if (s == -65536) {
      combat(m);
    }
    player = down;
    keyClear();
  }
  if (keys[3]) {
    blockUpdate();
    if (d == -1) {
      toMoveX = 50;//right
    }
    if (d == -65536) {
      combat(m);
    }
    keyClear();
    player = right;
  }
}

void combat(Mob a) {
  print("\n\n\n\n");
  int damage = 1;
  chance = int(random(100));
  if (chance > 30) {
    a.setHP(a.getHP() - damage);
  } else {
    print("You missed\n");
  }

  print("Player: " + playerHP + " HP\n");
  print("Enemy: " + a.getHP() + " HP");
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
      print(settingx);
      helms[b].setx(settingx);
      helms[b].sety(settingy);
      if (settingx < 1250) {
        settingx += 50;
        print("right");
      } else if (settingx > 1250){
        print("down");
        settingx -= 1120;
        settingy += 50;
        print(settingx);
      }
    }
  }
  if (armors != null && armors.length != 0) {
    for (int b = 0; b < armors.length; b++) {
      armors[b].setx(settingx);
      armors[b].sety(settingy);
      if (settingx < 1250) {
        settingx += 50;
      } else {
        settingx = 1120;
        settingy += 50;
      }
    }
  }
  if (bootss != null && bootss.length != 0) {
    for (int b = 0; b < bootss.length; b++) {
      bootss[b].setx(settingx);
      bootss[b].sety(settingy);
      if (settingx < 1250) {
        settingx += 50;
      } else {
        settingx = 1120;
        settingy += 50;
      }
    }
  }
  if (weapons != null && weapons.length != 0) {
    for (int b = 0; b < weapons.length; b++) {
      weapons[b].setx(settingx);
      weapons[b].sety(settingy);
      if (settingx < 1250) {
        settingx += 50;
      } else {
        settingx = 1120;
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

