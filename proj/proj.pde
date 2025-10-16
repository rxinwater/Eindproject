Player p0; //Hey thats you!
Weapon w0;
boolean startscreen = true;
boolean normal = false;
boolean allDead = true;
boolean hard = false;
int wave = 0;
float totalPoints;
ArrayList<Npc> npcs = new ArrayList<Npc>();
void setup() {
  size(750, 750);
  p0 = new Player(100, 50);
  w0 = new Weapon(110, 50);
}

void draw() {
  if (startscreen) {
    background(0);
    fill(255);
    textSize(25);
    text("Choose your difficulty", 250, 200);
    fill(200, 200, 0);
    rect(250, 300, 220, 50);
    textSize(20);
    fill(0);
    text("Normal", 260, 330);
    fill(255, 0, 0);
    rect(250, 400, 220, 50);
    textSize(20);
    fill(0);
    text("Hard", 260, 430);
  } else {

    background(255);
    p0.display();
    p0.update();
    w0.display();
    w0.update();

    if (npcs.size() == 0) {
      allDead = true;
    }
    if (allDead) {
      startWave();
    }
    for (int i = 0; i < npcs.size(); i++) {
      Npc n = npcs.get(i);
      n.update(p0);
      n.moveTowards(p0);
      fill(200, 0, 0);
      ellipse(n.x, n.y, 35, 35);
      fill(0);
      textSize(12);
      text(n.hp, n.x - 10, n.y - 20);

      totalPoints += n.damageTaken;
      if (n.hp <= 0) {
        npcs.remove(i);
        i--;
      }
    }
    fill(0);
    textSize(20);
    text("Time survived: " +  frameCount/60 + " Seconds", 300, 60);



    fill(210, 210, 0);
    textSize(20);
    text(totalPoints, 680, 700);
    fill(0);
    textSize(20);
    text("Wave: " + (wave - 1), 650, 60);

    fill(0);
    textSize(20);
    text("Ammo: " + w0.ammo, CENTER, 650);
    if (w0.reload) {
      fill(255, 0, 0);
      text("Reloading...", CENTER, 670);
    }
    fill(0, 255, 0);
    rect(CENTER, 700, p0.HP*3, 20, 30);

    if (w0.bulletActive) {
      fill(255, 255, 0);
      pushMatrix();
      translate(w0.bulletX, w0.bulletY);
      rotate(w0.bulletAngle);
      rect(0, 0, 15, 2);
      popMatrix();
    }
  }
  if (p0.dead) {
    background(0);
    fill(255);
    textSize(50);
    text("lol loser", 300, 375);
    textSize(20);
    text("to retry press F", 310, 400);
    text("Time survived: " +  frameCount/60 + " Seconds", 300, 430);
    text("Waves survived: " + wave, 310, 450);
  }
}


void keyPressed() {
  char k = Character.toLowerCase(key);
  if (k == 'w') p0.wPressed = true;
  if (k == 'a') p0.aPressed = true;
  if (k == 's') p0.sPressed = true;
  if (k == 'd') p0.dPressed = true;
  if (k == 'r') {
    p0.rPressed = true;
    w0.startReload();
  }


  if (k == 'f' && p0.dead) {
    p0.HP = 100;
    p0.x = 100;
    p0.y = 50;
    p0.dead = false;
    npcs.clear();
    w0.ammo = w0.maxAmmo;
    wave = 1;
  }
}


void keyReleased() {
  char k = Character.toLowerCase(key);
  if (k == 'w') p0.wPressed = false;
  if (k == 'a') p0.aPressed = false;
  if (k == 's') p0.sPressed = false;
  if (k == 'd') p0.dPressed = false;
  if (k == 'r') p0.rPressed = false;
  if (mouseButton == LEFT) p0.m1Pressed = false;
}

void mousePressed() {
  if (startscreen && mouseX > 250 && mouseX < 470 && mouseY > 300 && mouseY < 350) {
    startscreen = false;
    normal = true;
    print("Normal chosen");
  }
  if (startscreen && mouseX > 250 && mouseX < 470 && mouseY > 400 && mouseY < 450) {
    startscreen = false;
    hard = true;
    print("Hard chosen");
  }
  if (mouseButton == LEFT && !startscreen) {
    p0.m1Pressed = true;
  }
  if (p0.m1Pressed == true && !w0.reload && w0.ammo > 0 && !p0.dead && !startscreen) {
    w0.shooting = true;
  } else {
    w0.shooting = false;
  }
}



void startWave() {
  allDead = false;
  int tehee = round(wave * 1.5);
  for (int i = 0; i < tehee; i++) {
    float spawnX = random(50, 700);
    float spawnY = random(50, 700);
    Npc newNpc = new Npc(spawnX, spawnY);
    npcs.add(newNpc);
  }
  wave++;
}
