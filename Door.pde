class Door extends Tile {
  PImage doorOpen;
  
  Door(String path, PVector pos, PVector dim, boolean block) {
    super(path, pos, dim, block);
  }


  void checkCrystal(Character c) {
    // checks if all crystals have been collected
    if (totalCrystalsCollected == crystal.size()) {
      // if so, door has opened and player may enter which proceeds
      // into the next level
      if (abs(pos.x - c.pos.x) < (TILE_SIZE/2 + c.dim.x/2)
        && abs(pos.y - c.pos.y) < (TILE_SIZE/2 + c.dim.y/2)) {
        //println("check");
        changeLevels();
        
      }
    }
  }
}
