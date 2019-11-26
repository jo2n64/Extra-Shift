PImage bedroom;
Rectangle bookcase, pictures[], keyRec, screwsRec, backBedroom, codeRec;
boolean pickedKey, keyInInventory, pickedCode, liquidPlaced, safeOpened, codeInInv;
boolean pic1 = true, pic2 = true, pic3 = true;
int roomState = 0;

//bedroom buttons
//items
ItemButton key, code;
ImageButton[] pics;

void bedroomSetup() {
  //frontBedroomButton = new ImageButton(width/2 - 200, height/2 - 100, "/IMAGES/upArrow.png");
  if (roomState == 0) bedroom = loadImage("/IMAGES/room_bookshelf.png");
  if (roomState == 1) bedroom = loadImage("/IMAGES/room_usescrewdriver.png"); // no shelf
  if (roomState == 2) bedroom = loadImage("/IMAGES/room_safe.png"); // no screws
  if (roomState == 3) bedroom = loadImage("/IMAGES/room1_money.png"); // no code
  bookcase = new Rectangle(340, 100, 300, 380);
  screwsRec = new Rectangle(370, 170, 200, 100);
  pictures = new Rectangle[3];
  pics = new ImageButton[3];
  pictures[0] = new Rectangle(10, 70, 150, 150);
  pics[0] = new ImageButton(pictures[0].x, pictures[0].y, "/IMAGES/picture_mostleft.png");
  pictures[1] = new Rectangle(190, 125, 125, 125);
  pics[1] = new ImageButton(pictures[1].x, pictures[1].y, "/IMAGES/picture1_withcode.png");
  pictures[2] = new Rectangle(width - 250, 125, 150, 175);
  pics[2] = new ImageButton(pictures[2].x, pictures[2].y, "/IMAGES/picture_above bed.png");
  keyRec = new Rectangle(width - 380, 410, 50, 50);
  backBedroom = new Rectangle(width - 100, 200, 100, 100);
  key = new ItemButton("Key", width/2 + 200, 375, "/IMAGES/key.png", 4, 4, keyRec, "A key. What could it unlock?");

  if (!pic1) {
    codeRec = new Rectangle(pictures[0].x + 40, pictures[0].y + 30, 70, 90);
    code = new ItemButton("Key Code", pictures[0].x + 30, pictures[0].y + 30, "/IMAGES/code.png", 6, 6, codeRec, "A key code...");
  }
}

void bedroom() {
  bedroomSetup();
  image(bedroom, 0, -50);
  inv.showInventory();
  if (pic1) {
    pics[0].display(); 
    showDescription(pictures[0].x, pictures[0].y, pictures[0].w, pictures[0].h, "A picture...");
  }
  if (!pic1) { 
    if(!pickedCode){
    code.display(); 
    showDescription(codeRec.x, codeRec.y, codeRec.w, codeRec.h, code.description);
    }
  }
  if (pic2) {
    pics[1].display(); 
    showDescription(pictures[1].x, pictures[1].y, pictures[1].w, pictures[1].h, "A picture...");
  }
  if (pic3) {
    pics[2].display(); 
    showDescription(pictures[2].x, pictures[2].y, pictures[2].w, pictures[2].h, "A picture...");
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
    if (item.held) {
      item.displayOnInv(mouseX - 50, mouseY - 50);
    }
  }
}


void bedroomClicks() {
  if (codeRec != null && codeRec.pointInRec(mouseX, mouseY) && !pickedCode) {
    pickedCode = true;
    codeInInv = true;
    inv.addItem(code);
    pickItem.play();
  }
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
        inv.removeItem(item);
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
    pic1 = false;
  }
  if (pictures[1].pointInRec(mouseX, mouseY)) {
    pic2 = false;
  }
  if (pictures[2].pointInRec(mouseX, mouseY)) {
    pic3 = false;
  }

  if (keyRec.pointInRec(mouseX, mouseY) && !keyInInventory) {
    pickedKey = true; 
    keyInInventory = true;
    inv.addItem(key);
    pickItem.play();
    showText("You picked up " + key);
  }

  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
