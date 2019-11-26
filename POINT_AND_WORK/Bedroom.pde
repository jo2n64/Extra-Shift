PImage bedroom;
Rectangle bookcase, pictures[], keyRec, screwsRec, backBedroom;
boolean pickedKey, keyInInventory, pickedCode, liquidPlaced, safeOpened, codeInInv;
int roomState = 0;

//bedroom buttons
//items
ItemButton key, code;

void bedroomSetup() {
  //frontBedroomButton = new ImageButton(width/2 - 200, height/2 - 100, "/IMAGES/upArrow.png");
  if (roomState == 0) bedroom = loadImage("/IMAGES/bedroom.png");
  if (roomState == 1) bedroom = loadImage("/IMAGES/room_withoutbookshelf.png"); // no shelf
  if (roomState == 2) bedroom = loadImage("/IMAGES/room_safefound.png"); // no screws
  if (roomState == 3) bedroom = loadImage("/IMAGES/room_safeopen.png"); // no code
  bookcase = new Rectangle(340, 100, 300, 380);
  screwsRec = new Rectangle(370, 170, 200, 100);
  pictures = new Rectangle[3];
  pictures[0] = new Rectangle(10, 100, 150, 150);
  pictures[1] = new Rectangle(175, 125, 125, 125);
  pictures[2] = new Rectangle(width - 350, 125, 150, 175);
  keyRec = new Rectangle(width - 380, 410, 50, 50);
  backBedroom = new Rectangle(width - 100, 200, 100, 100);
  key = new ItemButton("Key", width/2 + 200, 375, "/IMAGES/key.png", 4, 4, keyRec, "A key. What could it unlock?");
  if (!pickedCode && !codeInInv)
    code = new ItemButton("Key Code", pictures[0].x, pictures[0].y, "/IMAGES/code.png", 5, 5, pictures[0], "A key code...");
}

void bedroom() {
  bedroomSetup();
  image(bedroom, 0, -50);
  inv.showInventory();
  for (int i = 0; i < pictures.length; i++) {
    showDescription(pictures[i].x, pictures[i].y, pictures[i].w, pictures[i].h, "A picture...");
  }
  if (roomState == 0) showDescription(bookcase.x, bookcase.y, bookcase.w, bookcase.h, "A bookcase. Lots of books with lots of dust, he doesn’t really read….");
  if (roomState == 1) showDescription(screwsRec.x, screwsRec.y, screwsRec.w, screwsRec.h, "Screws. I need a tool!");
  if (roomState == 2) showDescription(screwsRec.x, screwsRec.y, screwsRec.w, screwsRec.h, "The safe is closed. Now to find the key code");
  if (roomState == 3) showDescription(screwsRec.x, screwsRec.y, screwsRec.w, screwsRec.h, "OoOoOoOoHhHhHh me pot of gold");
  if (!pickedKey) {
    key.display();
    showDescription(keyRec.x, keyRec.y, keyRec.w, keyRec.h, key.description);
  }
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 130, height - 100, 130, 80, item.description);
    if(item.held){
      item.displayOnInv(mouseX, mouseY);
    }
  }
}

void bedroomClicks() {
  if (backBedroom.pointInRec(mouseX, mouseY)) {
    scene = 3; // living room
    doorOpen.play();
  }
  if (bookcase.pointInRec(mouseX, mouseY) && roomState == 0) { 
    fallBookcase.play(); 
    roomState = 1;
  }
  if (screwsRec.pointInRec(mouseX, mouseY)) {
    for (int i = 0; i < inv.heldItems; i++) {
      ItemButton item = inv.items.get(i);
      if (item.name == "Screwdriver" && item.held) {
        item.held = false;
        roomState = 2;
        inv.removeItem(item);
        fallingScrew.play();
      }
      if (item.name == "Key Code" && item.held && roomState == 2) {
        item.held = false;
        codeInInv = false;
        inv.removeItem(code);
        roomState = 3;
      }
      if (item.name == "Flamable Liquid" && item.held && roomState == 3) {
        item.held = false;
        inv.removeItem(item);
        liquidPlaced = true;
      }
      if (item.name == "Matches" && item.held && roomState == 3 && liquidPlaced) {
        item.held = false;
        matchesInInventory = false;
        inv.removeItem(item);
        scene = 8;
      }
    }
  }

  if (pictures[0].pointInRec(mouseX, mouseY)) { 
    pickedCode = true;
    codeInInv = true;
    inv.addItem(code);
    pickItem.play();
  }
  if (keyRec.pointInRec(mouseX, mouseY) && !keyInInventory) {
    pickedKey = true; 
    keyInInventory = true;
    inv.addItem(key);
    pickItem.play();
  }
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
