// IAT 167 D102
// Justine Abucay
// 301540624


/*
I have a created a tile based game where the player must find all the crystals in order to proceed through the next level.
At the moment, there are only two levels. Each level has at least one candle that the player can pick and heal their health.
An enemy appears in the second level where it moves along a path. The player must avoid coming into contact with the enemy,
or they will take health damage. 

The player has three lives throughout the game. Their health automatically decreases as time passes by. 

Sources: 
- character sprite [run + idle animation] -- https://lucky-loops.itch.io/character-satyr
- candle -- https://nyknck.itch.io/candle
- floors + walls -- https://pixel-poem.itch.io/dungeon-assetpuck

*/

float speed = 2;
PVector upForce = new PVector(0, -speed);
PVector downForce = new PVector(0, speed);
PVector leftForce = new PVector(-speed, 0);
PVector rightForce = new PVector(speed, 0);
boolean up, down, left, right;

PImage[] playerFramesMoving = new PImage[8];
PImage[] playerFramesIdle = new PImage[6];

PImage[] candleFrames = new PImage[3];

static final int TILE_EMPTY = 0;  //empty space
static final int TILE_SOLID = 1;  //solid block
static final int TILE_FLOOR = 2;
static final int TILE_DOOR = 3;

int state;
final int PLAY_GAME = 0;
final int WON = 1;
final int LOST = 3;
final int MENU = 4;

final int LEVEL_ONE = 0;
final int LEVEL_TWO = 1;
final int LEVEL_THREE = 2;

int currentLevel = LEVEL_ONE;
int textTimer = 120;

int MAX_LOOTS = 3;
final int MAX_ATTEMPTS = 3;
final int MAX_CRYSTAL_HEALTH = 150;
final int ENEMY_DAMAGE = 50;
final int MAX_LEVELS = 2;

int candlesCollected;
int totalCandles;
int totalCrystalsCollected;
int totalCrystals;
int MAX_HEALTH = 500;

static final int TILE_SIZE = 96;
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<Enemies> enemies = new ArrayList<Enemies>();
ArrayList<Loots> item = new ArrayList<Loots>();
ArrayList<Loots> crystal = new ArrayList<Loots>();
ArrayList<LivesLeft> hearts = new ArrayList<LivesLeft>();

ArrayList<Location> location = new ArrayList<Location>();


Player player;

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) left = true;
    else if (keyCode == RIGHT) right = true;
    else if (keyCode == UP) up = true;
    else if (keyCode == DOWN) down = true;

    player.moving();
  }

  if (key == 'x') {
    
    if (candlesCollected > 0) {
      player.heal(MAX_HEALTH/2);
      candlesCollected--;
    }
  }
}

void mouseClicked() {
  switchCurrentLevel();
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) left = false;
    else if (keyCode == RIGHT) right = false;
    else if (keyCode == UP) up = false;
    else if (keyCode == DOWN) down = false;

    player.idle();
  }
}

void setup() {
  size(800, 600);

  stroke(200);
  strokeWeight(2);
  fill(63);

  PFont font = loadFont("DMSans-Light-48.vlw");
  textFont(font, 16);

  loadAssets();
}

void draw() {
  background(255);
  switch(state) {
  case PLAY_GAME:
    playLevel();
    break;
  case WON:
    textScreen("YOU WIN");
    break;
  case LOST:
    textScreen("YOU LOSE");
    break;
  case MENU:
    displayHowTo();
    break;
  default:
    rect (player.pos.x, player.pos.y, player.dim.x, player.dim.y);
  }
}

void textScreen(String str) {
  
  background(255);
  textAlign(CENTER); 
  fill(0);
  text(str, width/2, height/2);
}
