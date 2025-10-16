class Weapon {
  float dmg = 50;
  float x;
  float y;
  float angle;
  float bulletSpeed = 15;
  float bulletX;
  float bulletY;
  float bulletAngle;
  int ammo = 6;
  int maxAmmo = 6;
  int bulletDelay = 32; //frames between being able to shoot
  int reloadTime = 120;
  boolean reload = false;
  boolean shooting = false;
  boolean reloadFinished = false;
  boolean bulletActive = false;
  PImage img;
  Weapon(float startX, float startY) {
    x = startX;
    y = startY;
    img = loadImage("revolver.png");
  }

  void update() {
    x = p0.x + 10;
    y = p0.y;

    bulletDelay = constrain(bulletDelay, 0, 32);
    reloadTime = constrain(reloadTime, 0, 120);


    float dx = mouseX - p0.x;
    float dy = mouseY - p0.y;
    angle = atan2(dy, dx);
    constrain(x, p0.x - 20, p0.x + 20);
    constrain(y, p0.y - 20, p0.y + 20);

    if (shooting && ammo > 0 && !reload && bulletDelay == 0) {
      bulletX = x;
      bulletY = y;
      bulletAngle = angle;
      ammo--;
      bulletDelay = 32;
      bulletActive = true;
      shooting = false;
    }
    bulletDelay--;

    if (bulletActive) { //on screen bullet movement
      bulletX += cos(bulletAngle) * bulletSpeed;
      bulletY += sin(bulletAngle) * bulletSpeed;

      for (int i = 0; i < npcs.size(); i++) {
        Npc n = npcs.get(i);

        float bulletDx = bulletX - n.x;
        float bulletDy = bulletY - n.y;
        float distance = sqrt(bulletDx * bulletDx + bulletDy * bulletDy);

        if (distance < 20) {  // hit
          n.hp -= dmg;
          println("Hit! NPC HP: " + n.hp);
          bulletActive = false;  // stop bullet after hit

          if (hard) {
            n.damageTaken += dmg * 0.75;
          } else {
            n.damageTaken += dmg;
          }
          break;  // stop checking others (bullet already hit one)
        }
      }

      if (bulletX <= 0 || bulletY <= 0) {
        bulletActive = false;
      }
    }
    //...
    if (reload && !shooting ) {
      reloadTime--;
    }
    if (reloadTime <= 0) {
      reloadFinished = true;
      reload = false;
    }
    if (reloadFinished) {
      ammo = maxAmmo;
      reloadFinished = false;
      reloadTime = 120;
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    imageMode(CENTER);
    image(img, 30, 10, 40, 40);
    popMatrix();
  }

  void startReload() {
    if (!reload && ammo < maxAmmo) {
      reload = true;
      reloadTime = 120;
      println("Started reload");
    }
  }
}
