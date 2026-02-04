// player must activate the crystal to proceed into the next level.
// they must stand on the crystal for a few seconds before it triggers
// a switch to open a door. this door leads to the next level of the game.
// if not all crystals are collects, the player cannot go through the door.

class Crystal extends Loots {
  int currHealth;
 
  Crystal(PVector pos, PVector dim) {
    super(pos, new PVector(TILE_SIZE, TILE_SIZE), "crystal.png");

    img.resize(TILE_SIZE, TILE_SIZE);

    currHealth = 0;
  }

  // the health of the crystal only increases when the player stands on top of it. 
  void activateCrystal() {
    if (currHealth < MAX_CRYSTAL_HEALTH) {
      currHealth++;
      // the crystal has reached its maximum health when the circle completes forming its shape. 
      if(currHealth == MAX_CRYSTAL_HEALTH){
        // updates the number of crystals collected within a level 
        if (totalCrystalsCollected < crystal.size()) totalCrystalsCollected++;
      }
    }
  }
  
  void resetCrystal(){
   currHealth = 0;
 }
  
  // checks whether the player is standing on the crystal 
  boolean check(Character c) {
    if (abs(c.pos.x - (pos.x)) < c.dim.x / 2 + dim.x / 2 &&
      abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) {

      return true;
    }
    return false;
  }

  void drawMe() {
    pushMatrix();
    translate( -player.pos.x + width/2  + pos.x,
      -player.pos.y + height/2 + player.dim.y/2 + pos.y);

    float healthRatio=(float)currHealth/(float)MAX_CRYSTAL_HEALTH;
    float ARC=TWO_PI*healthRatio;
    noStroke();

    fill(0, 80);

    arc(-img.width/2-5, -img.height/2-80, 40, 40, 0, ARC);
    //ellipse(-img.width/2, -img.height/2+80, 30, 30);

    //scale(1.04, 1.04);
    image(img, -img.width/2, -img.height/2);
    //rect(-dim.x/2, -dim.y/2, dim.x, dim.y);
    popMatrix();
  }

  void update() {
    drawMe();
  }
}
