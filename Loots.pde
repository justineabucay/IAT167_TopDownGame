// Loots is a superclass for Candle and Crystal 
class Loots {
  PVector pos, dim, diff, absDiff;
  String path;
  PImage img;

  Loots(PVector pos, PVector dim, String path) {
    this.pos = pos;
    this.dim = dim;
    this.path = path;
   
    img = loadImage(path); 
  }

  void update() {}

  /*boolean collision(Player other){
   return abs(pos.x-other.pos.x)<dim.x/2+other.dim.x/2&&abs(other.pos.y-pos.y)<dim.y/2+other.dim.y/2;
   }*/

  boolean check(Character c) {
    //print("player's position: " + c.pos + " - player's dim: " + c.dim);
    //println("** + candle's position: " + pos + " - candle's dim: " + dim);
    if (abs(c.pos.x - (pos.x)) < c.dim.x / 2 + dim.x / 2 &&
      abs(c.pos.y - pos.y) < c.dim.y / 2 + dim.y / 2) {
      return true;
    } else return false;
  }


  void drawMe() {
    rect(pos.x, pos.y, 10, 10);
  }

  void activateCrystal() {}
  
  void resetCrystal(){}
}
