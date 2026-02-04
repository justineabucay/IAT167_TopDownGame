// once the player picks up the candle, the candle removes itself.
// 

class Candle extends Loots {
  

  Candle(PVector pos, PVector dim) {
    super(pos, dim, "img/candles/candle0.png");
    
    img.resize(TILE_SIZE/2, TILE_SIZE/2);

  }

  void update() {
    // checks if player is on the candle.
    // player can only pick up the candle if their health is less thanthe MAX HEALTH
    // if so, candle removes itself and candlesCollected increases by one.
    
    // the variable candlesCollected holds the number of candles collected,
    // which also means how many times the player can press "x" to heal. 
    if (check(player)) {
      
      if (player.currHealth < MAX_HEALTH) {
        candlesCollected++;
        
        item.remove(this);
      }
    }
  }

  void drawMe() {
    pushMatrix();
    imageMode(CENTER);
    translate( -player.pos.x + width/2  + pos.x,
      -player.pos.y + height/2 + player.dim.y/2 + pos.y);

    //scale(1.04, 1.04);
    image(img, -img.width, -img.height);
    //rect(-dim.x, -dim.y, dim.x, dim.y);
    popMatrix();
  }

}
