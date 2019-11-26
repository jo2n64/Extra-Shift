PImage livingRoom, matchestopick, rdyCatnip;
boolean pickedMatches, matchesInInventory = false, shreddedPants = false, putCatnip = false, blownUp = false, explosionPlayed = false;
String blenderText = "Blender, Zoom zoom!";
String catnipMissing = "- put catnip on the cat's bed";
String catText = "“Noschki”, who would name their cat like that?";
String bedroomText = "A door to his bedroom. It's locked.";
Rectangle cat, fridge, matchRect, livingOven, blenderRec, backLivingRoom, bedroomRec, screwRec2;

//living room buttons

ItemButton matches;

void livingRoomSetup() {
  if (!pickedMatches) {
    matches = new ItemButton("Matches", 900, height/2 + 100, "/IMAGES/matches.png", 4, 4, matchRect, "What devilish plans can I do with this!");
    matchestopick = loadImage("/IMAGES/matchestopick.png");
  }
  livingRoom = loadImage("/IMAGES/Livingroom.png");
  if (blownUp) {
    livingRoom = loadImage("/IMAGES/kitchen.explode_screwinTV.png");
    screwRec2 = new Rectangle(width-320, height/2 - 150, 100, 100);
    if (pickedScrew) {
      livingRoom = loadImage("/IMAGES/kitchen.explode_screwoutTV.png");
    }
  }
  if (putCatnip) rdyCatnip = loadImage("/IMAGES/placedCatnip.png");

  cat = new Rectangle (1175, 500, 100, 75);
  fridge = new Rectangle(400, 50, 175, 375);
  matchRect = new Rectangle(width/2 + 330, height/2 + 40, 40, 40);
  blenderRec = new Rectangle(600, height/2 - 175, 80, 90);
  if (!blownUp) {
    livingOven = new Rectangle(130, height/2 - 70, 240, 270);
    bedroomRec = new Rectangle(0, 0, 120, 570);
  } else bedroomRec = new Rectangle(100, 100, 200, 400);
  backLivingRoom = new Rectangle(width/2 - 40, height - 260, 100, 100);
}

void livingRoom() {
  livingRoomSetup();
  image(livingRoom, 0, -125);
  if (putCatnip) image(rdyCatnip, cat.x - 20, cat.y + 5);

  inv.showInventory();
  showDescription(fridge.x, fridge.y, fridge.w, fridge.h, "A fridge. I could mess with his food.");
  if (putCatnip) catText = "A cat bowl laced with catnip. Take that “Noschki”!";
  showDescription(cat.x, cat.y, cat.w, cat.h, catText);
  if (!blownUp) showDescription(livingOven.x, livingOven.y, livingOven.w, livingOven.h, "A gas powered stove.");
  showDescription(blenderRec.x, blenderRec.y, blenderRec.w, blenderRec.h, blenderText);
  if (blownUp) bedroomText = "A hole going to the bedroom.";
  showDescription(bedroomRec.x, bedroomRec.y, bedroomRec.w, bedroomRec.h, bedroomText);
  if (!pickedMatches) {
    image(matchestopick, width - 300, height/2 + 50);
    showDescription(matchRect.x, matchRect.y, matchRect.w, matchRect.h, matches.description);
  }
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 150, height - 100, 130, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX - 50, mouseY - 50);
    }
  }
}

void livingRoomClicks() {
  if (backLivingRoom.pointInRec(mouseX, mouseY)) {
    scene = 2; 
    doorOpen.play();
    if (matchesPlaced && fwPlaced && knobsOn && !explosionPlayed) {
      blownUp = true;
      explosion.play();
      explosionPlayed = true;
    }
  } // hall
  if (screwRec2 != null && screwRec2.pointInRec(mouseX, mouseY)) {
    pickedScrew = true;
    screwdriver = new ItemButton("Screwdriver", width/2 + 75, height/2 + 25, "/IMAGES/screwdriver2.png", 8, 7, screwdriverRec, "Premium tool, I can do a lot with this.");
    inv.addItem(screwdriver);
    pickItem.play();
  }
  if (livingOven != null && livingOven.pointInRec(mouseX, mouseY) && !blownUp) scene = 5; //oven
  if (bedroomRec.pointInRec(mouseX, mouseY) && matchesPlaced && fwPlaced && knobsOn) {
    scene = 7; 
    doorOpen.play();
  } //bedroom
  if (matchRect.pointInRec(mouseX, mouseY) && !pickedMatches) {
    pickedMatches = true;
    matchesInInventory = true;
    pickItem.play();
    inv.addItem(matches);
  }
  if (cat.pointInRec(mouseX, mouseY)) {
    for (int i = 0; i < inv.heldItems; i++) {
      ItemButton item = inv.items.get(i);
      if (item.name == "Catnip" && item.held) {
        inv.removeItem(item);
        catnipInInv = false;
        item.held = false;
        putCatnip = true;
      }
    }
  }
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 150, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
