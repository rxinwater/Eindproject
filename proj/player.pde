
class Player {
  boolean wPressed = false;
  boolean aPressed = false;
  boolean sPressed = false;
  boolean dPressed = false;
  boolean rPressed = false;
  boolean m1Pressed = false;
  float y;
  float x;
  float angle;
  int speed = 4;
  int HP = 100;
  int level = 1;
  boolean dead = false;
  PImage pModel;


  Player(float startX, float startY) {
    x = startX;
    y = startY;
    pModel = loadImage("pmodel.png");
  }




  void update() {
    if (wPressed) y -= speed;
    if (aPressed) x -= speed;
    if (sPressed) y += speed;
    if (dPressed) x += speed;
    x = constrain(x, 0, 730);
    y = constrain(y, 0, 730);
    float dx = mouseX - x;
    float dy = mouseY - y;
    angle = atan2(dy, dx);
    if (HP <= 0) {
      dead = true;
    } else {
      dead = false;
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle + 180);
    imageMode(CENTER);
    image(pModel, 0, 0, 80, 80);
    popMatrix();
  }
}
