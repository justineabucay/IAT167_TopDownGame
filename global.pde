void switchCurrentLevel() {

  switch(currentLevel) {
  case LEVEL_ONE:
    println("level one");
    playerStartTile();
    generateGameWorld(map0);
    createHearts();
    spawnCandle();
    spawnCrystal();


    break;
  case LEVEL_TWO:
    MAX_HEALTH = 800;
    totalCandles = 3;
    totalCrystals = 2;

    playerStartTile();
    enemyStartTIle();
    generateGameWorld(map1);
    spawnCandle();
    spawnCrystal();

    break;

  case LEVEL_THREE:
    player = new Player(new PVector(width-TILE_SIZE*2, height), playerFramesIdle[0]);
    generateGameWorld(map2);

    break;
  }
  state = PLAY_GAME;
}

void changeLevels() {
  currentLevel++;

  tiles.clear();
  item.clear();
  crystal.clear();
  location.clear();

  dataReset();

  player.currHealth = MAX_HEALTH;
  println(currentLevel);
  if (currentLevel == MAX_LEVELS) {
    winGame();
  } else {
    switchCurrentLevel();
  }
}

void loadAssets() {
  textAlign(CENTER);
  loadPlayerFrames();
  loadObjects();

  state = MENU;
}

void loadFrames(PImage[] ar, String fname) {
  for (int i = 0; i < ar.length; i++) {
    PImage frame = loadImage(fname + i + ".png");
    frame.resize(64, 64);
    ar[i] = frame;
  }
}

void loadPlayerFrames() {
  loadFrames(playerFramesIdle, "idle");
  loadFrames(playerFramesMoving, "running");
}

void loadObjects() {
  loadFrames(candleFrames, "img/candles/candle");
}

void playLevel() {


  if (left) player.move(leftForce);
  if (right) player.move(rightForce);
  if (up) player.move(upForce);
  if (down) player.move(downForce);

  for (int i = 0; i < tiles.size(); i++) {
    Tile t = tiles.get(i);

    t.collision(player);

    if (t.inWindow()) {
      t.drawMe(player);
    }

    if (t instanceof Door) t.checkCrystal(player);
  }

  for ( int i = 0; i < enemies.size(); i++) {
    Enemies e = enemies.get(i);

    e.update();
    if (e.collision(player)) {
      player.damage(ENEMY_DAMAGE);
      //enemies.remove(e);
    }
    e.drawMe();
  }

  for (int i = 0; i < item.size(); i++) {
    Loots l = item.get(i);


    l.update();
    l.drawMe();
  }

  for (int i = 0; i < crystal.size(); i++) {
    crystal.get(i).update();
    player.update(crystal.get(i));
  }



  player.drawMe();
  player.displayHearts();
  player.displayHealthBar();

  displayCandlesCollected();
  displayTotalCrystals();
}

void createHearts() {
  for (int i = 0; i < MAX_ATTEMPTS; i++) {
    hearts.add(new LivesLeft(new PVector((width - 50) - ((i + 1) * 20), 20), new PVector(10, 10)));
  }
}

void playerStartTile() {
  switch(currentLevel) {
  case LEVEL_ONE:
    player = new Player(new PVector(width-TILE_SIZE*2, height), playerFramesIdle[0]);
    break;
  case LEVEL_TWO:
    player = new Player(new PVector(TILE_SIZE*14, TILE_SIZE*14), playerFramesIdle[0]);
    break;

  case LEVEL_THREE:

    break;
  }
}

void enemyStartTIle() {
  switch(currentLevel) {
  case LEVEL_ONE:
    break;
  case LEVEL_TWO:
    // start tile, end tile LOLOL
    enemies.add(new Enemies(new PVector(17 * TILE_SIZE, 6 * TILE_SIZE), new PVector(17 * TILE_SIZE, 6 * TILE_SIZE), new PVector(17 * TILE_SIZE, 15 * TILE_SIZE), playerFramesIdle[0]));
    break;
  case LEVEL_THREE:

    break;
  }
}

void spawnCandle() {
  switch(currentLevel) {
  case LEVEL_ONE:
    item.add(new Candle(new PVector(13 * TILE_SIZE, 14 * TILE_SIZE), new PVector(25, 25)));
    break;
  case LEVEL_TWO:
    for (int i = 0; i < totalCandles; i++) {
      Location temp = location.get((int)random(location.size()));
      item.add(new Candle(temp.pos, new PVector(25, 25)));
    }
    break;

  case LEVEL_THREE:

    break;
  }
}


void spawnCrystal() {
  switch(currentLevel) {
  case LEVEL_ONE:
    crystal.add(new Crystal(new PVector(17 * TILE_SIZE, 6 * TILE_SIZE), new PVector()));
    break;
  case LEVEL_TWO:
    for (int i = 0; i < 2; i++) {
      Location temp = location.get((int)random(location.size()));
      crystal.add(new Crystal(temp.pos, new PVector()));
    }
    break;

  case LEVEL_THREE:

    break;
  }
}

void loseHeart() {
  int last;
  last = hearts.size() - 1;
  hearts.remove(last);
}

void resetPlayer() {
  item.clear();
  crystal.clear();

  spawnCandle();
  spawnCrystal();

  dataReset();
  println(hearts.size());
  if (hearts.size() > 0) {
    loseHeart();
    if (hearts.size() == 0) {
      print("stop");
      loseGame();
    } else {
      player.currHealth = MAX_HEALTH;
      playerStartTile();
    }
  }
}

void dataReset() {
  candlesCollected = 0;
  totalCrystalsCollected = 0;
}

void loseGame() {
  state = LOST;
}

void winGame() {
  state = WON;
}

void displayCandlesCollected() {
  fill(255);
  textAlign(CENTER);
  text("Candles collected: " + candlesCollected, 90, height - 60);
}

void displayTotalCrystals() {
  fill(255);
  textAlign(LEFT);
  text(totalCrystalsCollected + " / " + crystal.size(), 15, height - 80);
}

void displayHowTo() {
  fill(0);
  translate(width/2, height/2);

  
    //textTimer--;
    textAlign(CENTER);
    text("HOW TO PLAY", 0, -100);
    textAlign(LEFT);
    text("Use arrow keys to move player.", -150, -60);
    text("Collect the candles and press X to heal.", -150, -40);
    text("Collect all crystals by standing on it.", -150, -20);
    text("Once all crystals are collected, find the door ", -150, 0);
    text("and enter to proceed to the next level. ", -150, 20);
    text("Click screen to play", -150, 80);
  
}
