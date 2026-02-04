class Player extends Character {

  float damp = 0.8; //constant damping factor
  PImage mask;
  PImage img;

  int currFrame = 0;
  PImage[] activeFrames;
  int animationRate = 2;

  int currAttempts;
  int currHealth;

  float healthPercent = 1;


  //a constructor to initialize the fields above with initial values
  Player(PVector pos, PImage playerImg) {
    //this.pos = pos;
    super(pos, new PVector(), new PVector(64, 64));
    img = playerImg;
    mask = loadImage("mask.png");
    activeFrames = playerFramesIdle;

    currAttempts = MAX_ATTEMPTS;
    currHealth = MAX_HEALTH;
  }

  //update the physics for the character
  void update(Loots c) {
    super.update();
    vel.mult(damp);
     
    // if player health has reached 0, resets the crystals health and resets the player as well 
    if (currHealth == 0) {
      c.resetCrystal();
      resetPlayer();
    }

    // checks if the player is standing on the crystal
    if (c.check(player)) {
      // if so, the crystal heals the player
      if (currHealth < MAX_HEALTH) currHealth += currHealth * 0.01;
      c.activateCrystal();
    } else if (currHealth > 0 && hearts.size() > 0) {
      // player loses health instantly if not standing on crystal
      currHealth--;
    }

    updateFrame();
    healthPercent = (float) currHealth / MAX_HEALTH;
  }

  void updateFrame() {
    if (frameCount % animationRate == 0) { //Display each image for 6 frames before switching to the next
      if (currFrame < activeFrames.length-1) //if within array length
        currFrame++;    // 0, 1, 2, 3          //switch to the next image
      else
        currFrame = 0; //if reaching the end of the array restart from the begining

      img = activeFrames[currFrame];
    }
  }
  
  // player takes damage if it comes in contact with enemy
  void damage(int healthLost) {
    currHealth -= healthLost;
    if (currHealth <= 0) {
      resetPlayer();
    }
    healthPercent = (float) currHealth / MAX_HEALTH;
  }

  void heal() {
    if (currHealth < MAX_HEALTH) {
      currHealth++;
    }
    healthPercent = (float) currHealth / MAX_HEALTH;
  }

  // player gains health from the candle 
  void heal(int healthGained) {
    if (currHealth + healthGained > MAX_HEALTH) { // checks to make sure health does not go over max health after gaining health
      currHealth = currHealth + healthGained - ((currHealth + healthGained) - MAX_HEALTH); // only adds up health to max health
    } else currHealth += healthGained; // add up gained health to health

    healthPercent = (float) currHealth / MAX_HEALTH;
  }
  
  void displayHearts() {
    for (int i = 0; i < hearts.size(); i++) {
      LivesLeft l =  hearts.get(i);
      l.drawMe();
    }
  }

  void displayHealthBar() {
    int healthBarWidth = 200;
    pushMatrix();
    fill(0, 64);
    translate(20, 20);
    rect(0, 0, healthBarWidth, 20);
    fill(255, 0, 0, 255);
    rect(0, 0, healthBarWidth * healthPercent, 20);
    popMatrix();
  }

  void drawMe() {

    imageMode(CENTER);

    pushMatrix();
    translate(width/2-img.width, height/2-img.height/2);

    push();
    if (vel.x < 0) {
      scale(-1, 1);
    }
  
    image(mask, img.width/3, 0);
    image(img, 0, 0);
    pop();


    popMatrix();
  }

  void idle() {
    activeFrames = playerFramesIdle;
    //print("idle" + playerFramesIdle.length);
  }

  void moving() {
    activeFrames = playerFramesMoving;
    //print("moving" + playerFramesMoving.length);
  }
}
