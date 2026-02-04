/* 
Character:
the super class for Player and Enemies which consists of similar tasks, such as moving, 
and collision detection. 
*/

class Character{
  PVector pos, vel, dim;
  PImage img;
  
  
  int currFrame = 0;
  PImage[] activeFrames; 
  int animationRate = 2;

  Character(PVector pos, PVector vel, PVector dim){
    this.pos = pos; 
    this.vel = vel;
    this.dim = dim;
    
  }
  
  void move(PVector acc) {
    vel.add(acc);
  }
  
  void move(){
    pos.add(vel);
  }
  
  void update(){
    move();
  }
  
  boolean collision(Character other){
     return abs(pos.x-other.pos.x)<dim.x/2+other.dim.x/2&&abs(other.pos.y-pos.y)<dim.y/2+other.dim.y/2;
  }
  
  
  

  void drawMe(){
    ellipse(width/2+dim.x/2, height/2+dim.y/2, dim.x, dim.y);
  }
  
}
