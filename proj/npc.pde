class Npc{
    float x;
    float y;
    float hp;
    int startingHp = 100;
    float damageTaken;
    int speed = 2;
    int npcCount;
    boolean dead = false;
    
    
    Npc(float startX, float startY) {
      x = startX;
      y = startY;

      hp = startingHp;
      
    }
    
    void update(Player target) {
      if(hard){
        speed = 2;
        startingHp = 150;
       
      }
        if(normal){
        speed = 1;
        startingHp = 100;
      }

        
         hp = constrain(hp, 0, startingHp);
      moveTowards(target);
        x = constrain(x, 0, 715);
        y = constrain(y, 0, 715);
    }

    // Moves NPC toward player
    void moveTowards(Player target) {
        float dx = target.x - x;
        float dy = target.y - y;
        float distance = sqrt(dx*dx + dy*dy);

        // Only move if distance > 0 to avoid divide by 0
        if(distance > 0){
            x += dx * (speed / distance);
            y += dy * (speed / distance);
        }
        if(distance <= 75){
            p0.HP -= 1;
        }
  }
}