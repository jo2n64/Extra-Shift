PImage oven, gas[], match, fwImage, fwLit;
Rectangle knobsRec, drawerRec, screwdriverRec, ovenRec, coffeeRec;
boolean drawerOpen, knobsOn = false, pickedScrew = false, fwPlaced = false, matchesPlaced = false, usedLaxatives = false;
String ovenText, coffeeText, laxativesMissing = "- put the laxatives in the coffee machine";

//oven buttons
ImageButton knobs, drawer, backOvenButton;
ItemButton screwdriver;

void ovenSetup() {
  if (knobsOn)
    knobs = new ImageButton(222, height/2 + 32, "/IMAGES/knobson.png");
  if (drawerOpen)
    drawer = new ImageButton(650, height/2 + 70, "/IMAGES/draw_open.png");
  backOvenButton = new ImageButton(width/2, height - 200, "/IMAGES/downArrow.png");
  screwdriver = new ItemButton("Screwdriver", 700, height/2 + 100, "/IMAGES/screwdriver2.png", 8, 7, screwdriverRec, "Premium tool, I can do a lot with this.");
  oven = loadImage("/IMAGES/zavalio.png");
  if (fwPlaced) oven = loadImage("/IMAGES/fireworks_onstove.png");
  if (matchesPlaced && fwPlaced)oven = loadImage("/IMAGES/fireoworks_onstove_lit.png");

  match = loadImage("/IMAGES/matches.png");
  gas = new PImage[3];
  gas[0] = loadImage("/IMAGES/smoke_stove.png");
  gas[1] = loadImage("/IMAGES/smoke_stove2.png");
  gas[2] = loadImage("/IMAGES/smoke_stove3.png");
  knobsRec = new Rectangle(205, height/2, 425, 50);
  ovenRec = new Rectangle(250, 190, 360, 400);
  drawerRec = new Rectangle(650, height/2 + 70, 350, 100);
  screwdriverRec = new Rectangle(700, height/2 + 100, 220, 30);
  coffeeRec = new Rectangle(width/2 + 130, 60, 170, 250);
  ovenText = "A stove with the gas turned on. I don't think this is enough explosive power. I need more!";
  coffeeText = "A coffee machine. F***ing Nespresso.";
}

void oven() {
  ovenSetup();
  image(oven, 0, -50);
  inv.showInventory();
  showDescription(coffeeRec.x, coffeeRec.y, coffeeRec.w, coffeeRec.h, coffeeText);
  if (!knobsOn) {
    showDescription(knobsRec.x, knobsRec.y, knobsRec.w, knobsRec.h, "A knob to regulate the gas flow");
    if (fwPlaced) ovenText = "A stove with fireworks on it. I don't think this is enough explosive power. I need more!";
  }
  backOvenButton.display();
  if (knobsOn) {
    knobs.display();
    for (int i = 0; i < gas.length; i++) {
      image(gas[i], -100, -100);
    }
    if (fwPlaced) ovenText = "A stove with fireworks and the gas has been turned on. Now I just need something to light it with.";
    if (fwPlaced && matchesPlaced) ovenText = "A stove with lit fireworks and gas coming out. Oh shit, better get out of here.";
    showDescription(ovenRec.x, ovenRec.y, ovenRec.w, ovenRec.h, ovenText);
  }
  if (drawerOpen) {
    drawer.display();
    if (!pickedScrew) {
      screwdriver.display();
      showDescription(screwdriverRec.x, screwdriverRec.y, screwdriverRec.w, screwdriverRec.h, screwdriver.description);
    }
  }

  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 150, height - 100, 130, 90, item.description);
    if (item.held) {
      item.displayOnInv(mouseX - 50, mouseY - 50);
    }
  }
}

void ovenClicks() {
  if (backOvenButton.pointInRec(mouseX, mouseY)) scene = 3;
  if (drawerRec.pointInRec(mouseX, mouseY)) {
    drawerOpen = true; 
    openDrawer.play();
  }
  if (knobsRec.pointInRec(mouseX, mouseY)) { 
    knobsOn = !knobsOn; 
    if (knobsOn == true) gasStove.play();
  }
  if (screwdriverRec.pointInRec(mouseX, mouseY) && drawerOpen && !pickedScrew) {
    pickedScrew = true;
    inv.addItem(screwdriver);
    pickItem.play();
  }
  if (ovenRec.pointInRec(mouseX, mouseY)) {
    for (int i = 0; i < inv.heldItems; i++) {
      ItemButton item = inv.items.get(i);
      if (item.name == "Fireworks" && item.held) {
        inv.removeItem(item);
        fwInInventory = false;
        item.held = false;
        fwPlaced = true;
      }
      if (item.name == "Matches" && item.held) {
        item.held = false;
        matchesPlaced = true;
        matchesInInventory = false;
        lightMatch.play();
      }
    }
  }
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 150, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
