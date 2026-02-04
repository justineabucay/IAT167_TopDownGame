// ArrayList that stores the number of lives the player has left
// and is displayed as the green dots in the top right corner of the window 
class LivesLeft{
  PVector pos, dim;
  
  LivesLeft(PVector pos, PVector dim){
    this.pos = pos;
    this.dim = dim;
    
  }
 
  void drawMe(){
    fill(0, 255, 0);
    pushMatrix();
      translate(pos.x, pos.y);
      ellipse(0, 0, dim.x, dim.y);
    popMatrix();
  }
  
}
