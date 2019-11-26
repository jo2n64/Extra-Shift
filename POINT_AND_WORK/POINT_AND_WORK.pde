import processing.sound.*;

int scene;
Inventory inv;

float recX, recY;

void setup() {
  size(1280, 720, P2D);
  scene = 0;
  recX = width/2 - 150;
  recY = height/2 - 100;
  inv = new Inventory(7);
  doorOpen = new SoundFile(this, "/sounds/Door Sound.mp3");
  fallBookcase = new SoundFile(this, "/sounds/Bookcase Falls.wav");
  pickItem = new SoundFile(this, "/sounds/Inventory Pick up sound.mp3");
  gasStove = new SoundFile(this, "/sounds/Gas Stove1.mp3");
  lightMatch = new SoundFile(this, "/sounds/Match Sound.mp3");
  openDrawer = new SoundFile(this, "/sounds/Open Cabinet1.wav");
  fallingScrew = new SoundFile(this, "/sounds/Screw-Falling.wav");
  openSafe = new SoundFile(this, "/sounds/Safe opening.mp3");
  axeHit = new SoundFile(this, "/sounds/Axe Impact.wav");
  explosion = new SoundFile(this, "/sounds/Firework and Gas stove explosion.mp3");
}

void draw() {
  background(255);
  loadScenes();
}

void mousePressed() {
  switch(scene) {
  case 0:
    if (pointInRect(mouseX, mouseY, recX, recY, recX + 300, recY + 200) && mouseButton == LEFT) scene = 1;
    break;
  case 1: 
    if (mouseButton == LEFT) frontPorchClicks();
    break;
  case 2: 
    if (mouseButton == LEFT) hallClicks();
    break;
  case 3:
    if (mouseButton == LEFT) livingRoomClicks();
    break;
  case 4:
    if (mouseButton == LEFT) bathroomClicks();
    break;
  case 5:
    if (mouseButton == LEFT) ovenClicks();
    break;
  case 6:
    if (mouseButton == LEFT) bathDrawersClicks();
    break;
  case 7: 
    if (mouseButton == LEFT) bedroomClicks();
    break;
  case 8:
    if (pointInRect(mouseX, mouseY, recX, recY, recX + 300, recY + 200) && mouseButton == LEFT) {
      scene = 0;
      reset();
    }
    break;
  }
}

void loadScenes() {
  
  switch(scene) {
  case 0: 
    intro();
    break;
  case 1: //porch
    scene1();
    break;
  case 2: //hall
    hall();
    break;
  case 3: //living room
    livingRoom();      
    break;
  case 4: //bathroom
    bathroom();      
    break;
  case 5: //oven
    oven();
    break;
  case 6:
    bathDrawers(); // bathDrawers
    break;
  case 7: //bedroom
    bedroom();
    break;
  case 8: //end
    end();
    break;
  }
}

void intro() {
  String title = "EXTRA SHIFT";
  String start = "START GAME";
  background(0);
  fill(255, 0, 0);
  rect(recX, recY, 300, 150);
  fill(255);
  textAlign(CENTER);
  textSize(32);
  text(title, width/2, height/2 - 200);
  textSize(24);
  text(start, width/2, height/2);
}

void end() {
  PImage endScreen, puffEyes, scratched, shat, green;
  endScreen = loadImage("/IMAGES/zavalionew/room_endscene_without pictures.png");
  image(endScreen, 0, 0);
  if (usedLaxatives){ shat = loadImage("/IMAGES/zavalionew/bosslose_lax.png"); image(shat, 0, 0);}
  if (putCatnip) {scratched = loadImage("/IMAGES/zavalionew/bosslose_catnip.png"); image(scratched, 0, 0);}
  if (changedDrops) {puffEyes = loadImage("/IMAGES/zavalionew/bosslose_eyedrops.png"); image(puffEyes, 0, 0);}
}

void reset() {
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    inv.removeItem(item);
  }
  upDrawerOpen = false;
  downDrawerOpen = false;
  pickedAlcohol = false;
  pickedKey = false;
  keyInInventory = false;
  pickedCode = false;
  liquidPlaced = false;
  roomState = 0;
  axePicked = false;
  axeInInventory = false;
  doorHitCount = 0;
  openedCloset = false;
  pickedFW = false;
  fwInInventory = false;
  drawerOpen = false;
  knobsOn = false;
  pickedScrew = false;
  fwPlaced = false;
  matchesPlaced = false;
  pickedMatches = false;
  matchesInInventory = false;
  pickedCatnip = false;
  catnipInInv = false;
  putCatnip = false;
  blownUp = false;
  explosionPlayed = false;
}
