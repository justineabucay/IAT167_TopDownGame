class Enemies extends Character {
  PVector startPos, endPos;
  PImage img; 
  Enemies(PVector pos, PVector startPos, PVector endPos, PImage img) {
    super(pos, new PVector(0, 2), new PVector(50, 50));
    
    this.startPos = startPos;
    this.endPos = endPos;
    this.img = img;
    
    
  }

  void update(){
    
    // moves back and forth along a linear path
    if(pos.y <= endPos.y || pos.y >= startPos.y) super.update();
    
    if(pos.y == endPos.y || pos.y == startPos.y) vel.y *= -1;
  }


  void drawMe() {
    pushMatrix();
    imageMode(CENTER);
    translate( -player.pos.x + width/2  + pos.x,
      -player.pos.y + height/2 + player.dim.y/2 + pos.y);

    //scale(1.04, 1.04);
    //image(img, -img.width, -img.height);
    rect(-dim.x, -dim.y, dim.x, dim.y);
    
    popMatrix();
  }
}
