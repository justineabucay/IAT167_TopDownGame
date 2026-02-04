class Tile {
  PVector pos, dim, diff, absDiff;
  PImage img;
  boolean block;



  Tile(String path, PVector pos, PVector dim, boolean block) {
    img = loadImage(path);

    img.resize(TILE_SIZE, TILE_SIZE);

    this.pos = pos;
    this.block = block;
    this.dim = dim;
  }



  void collision(Character c) {
    diff = PVector.sub(c.pos, pos);

    absDiff = new PVector(abs(diff.x), abs(diff.y));
    if (block &&
      absDiff.x < c.dim.x / 2 + img.width / 2 &&
      absDiff.y < c.dim.y / 2 + img.height / 2) {
      c.pos.x += diff.x*0.02;
      c.pos.y += diff.y*0.02;
      c.vel.mult(0.0);
    }
  }

  boolean check(Character c) {
    if (abs(c.pos.x - (pos.x)) < c.dim.x / 2 + dim.x / 2 &&
      abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) {
      //println("off");
      return true;
    }
    return false;
  }


  boolean inWindow() {
    if (absDiff.x < width && absDiff.y < height) {
  
      return true;
    }
    return false;
  }



  void drawMe(Character player) {

    pushMatrix();
    translate( -player.pos.x + width/2  + pos.x,
      -player.pos.y + height/2 + player.dim.y/2 + pos.y);

    scale(1.04, 1.04);
    image(img, -img.width/2, -img.height/2);

    popMatrix();
  }

  void checkCrystal(Character c) {
  }
}

// ArrayList that stores all FLOOR_TILES. Used to find a random location for crystals and candles
class Location{
  PVector pos;
  
  Location(PVector pos){
    this.pos = pos;
  }
  
}
