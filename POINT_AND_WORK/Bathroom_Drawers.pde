PImage bathroom_drawer, eyedrops;
String dropsText = "Eye drops. These could be exchanged with something to make him see clearer.";
boolean upDrawerOpen, downDrawerOpen, pickedAlcohol = false, alcInInv = false, pickedVitamins = false, vitaminsInInv = false, pickedLax = false, laxInInv = false, pickedBleach = false, bleachInInv = false, changedDrops = false;
Rectangle upDrawerRec, downDrawerRec, alcRec, vitaminsRec, bleachRec, laxativesRec, dropsRec;

ImageButton upDrawer, downDrawer, backDrawerButton;
ItemButton alcohol, vitamins, bleach, laxatives;

void bathDrawersSetup() {
  upDrawer = new ImageButton(340, -85, "/IMAGES/closeup_open2.png");
  downDrawer = new ImageButton(350, 190, "/IMAGES/closeup_open.png");
  backDrawerButton = new ImageButton(width/2, height - 100, "/IMAGES/downArrow.png");
  if (downDrawerOpen) {
    alcohol = new ItemButton("Flamable Liquid", width/2 - 100, height - 230, "/IMAGES/rubbingalcohol2.png", 5, 5, alcRec, "Very flammable…..very nice.");
    alcRec = new Rectangle(width/2 - 110, height - 220, 80, 130);
    vitaminsRec = new Rectangle(width/2 + 40, height/2 , 80, 130);
    vitamins = new ItemButton("Vitamins", width/2, height/2, "/IMAGES/vitamins.png", 5, 5, vitaminsRec, "Flintstones! Meet the flintstones! Meet your end!");
    bleachRec = new Rectangle(width/2 + 40, height - 230, 80, 120);
    bleach = new ItemButton("Bleach", width/2 + 10, height - 240, "/IMAGES/bleach.png", 4, 4, bleachRec, "Hmm… I can use this bleach, but let’s not kill him.");
  }
  if (upDrawerOpen) {
    laxativesRec = new Rectangle(width/2, 70, 80, 80);
    laxatives = new ItemButton("Laxatives", width/2, 50, "/IMAGES/laxatives.png", 5, 5, laxativesRec, "Laxatives! Guess someone's not gonna hold it in...");
    dropsRec = new Rectangle(width/2 - 90, 70, 80, 80);
    eyedrops = loadImage("/IMAGES/eyedrops.png");
    if(changedDrops & !bleachInInv) eyedrops = loadImage("/IMAGES/eyedrops_when with bleach.png");
    eyedrops.resize(eyedrops.width / 4, eyedrops.height/4);
  }
  bathroom_drawer = loadImage("/IMAGES/bathroom_closeup_closed.png");
  upDrawerRec = new Rectangle(470, -50, 300, 200);
  downDrawerRec = new Rectangle(465, 320, 310, 310);
}

void bathDrawers() {
  bathDrawersSetup();
  image(bathroom_drawer, 0, -50);
  inv.showInventory();
  if (upDrawerOpen) {
    upDrawer.display();
    image(eyedrops, dropsRec.x - 25, dropsRec.y - 50);
    if(changedDrops) dropsText = "Now this will clear his sight!";
    showDescription(dropsRec.x, dropsRec.y, dropsRec.w, dropsRec.h, dropsText);
    if (!pickedLax)
      laxatives.display();
  }
  if (downDrawerOpen && pickedKey) {
    downDrawer.display();
    if (!pickedAlcohol) {
      alcohol.display();
      showDescription(alcRec.x, alcRec.y, alcRec.w, alcRec.h, alcohol.description);
    }
    if (!pickedVitamins) {
      vitamins.display();
      showDescription(vitaminsRec.x, vitaminsRec.y, vitaminsRec.w, vitaminsRec.h, vitamins.description);
    }
    if(!pickedBleach){
      bleach.display();
      showDescription(bleachRec.x, bleachRec.y, bleachRec.w, bleachRec.h, bleach.description);
    }
  }
  backDrawerButton.display();
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 130, height - 100, 130, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX - 50, mouseY - 50);
    }
  }
}

void bathDrawersClicks() {
  if (upDrawerRec.pointInRec(mouseX, mouseY)) {
    upDrawerOpen = !upDrawerOpen;
    if (upDrawerOpen == true) openDrawer.play();
    if (laxativesRec != null && laxativesRec.pointInRec(mouseX, mouseY) && !pickedLax) {
      pickedLax = true;
      pickItem.play();
      inv.addItem(laxatives);
    }
    if(dropsRec != null && dropsRec.pointInRec(mouseX, mouseY)){
    for(int i = 0; i < inv.heldItems; i++){
      ItemButton item = inv.items.get(i);
      if(item.name == "Bleach" && item.held){
        item.held = false;
        bleachInInv = false;
        inv.removeItem(item);
        changedDrops = true;
      }
    }
  }
  }
  if (downDrawerRec.pointInRec(mouseX, mouseY)) { 
    for (int i = 0; i < inv.heldItems; i++) {
      ItemButton item = inv.items.get(i);
      if (item.name == "Key" && item.held) {
        keyInInventory = false;
        item.held = false;
        inv.removeItem(item);
        downDrawerOpen = true;
      }
      else downDrawerOpen = !downDrawerOpen;
    }
    if (vitaminsRec != null && vitaminsRec.pointInRec(mouseX, mouseY) && !pickedVitamins) {
      pickedVitamins = true;
      vitaminsInInv = true;
      pickItem.play();
      inv.addItem(vitamins);
    }
    if (alcRec != null && alcRec.pointInRec(mouseX, mouseY) && !pickedAlcohol) {
      pickedAlcohol = true;
      alcInInv = true;
      pickItem.play();
      inv.addItem(alcohol);
    }
    if(bleachRec != null && bleachRec.pointInRec(mouseX, mouseY) && !pickedBleach){
      pickedBleach = true;
      bleachInInv = true;
      pickItem.play();
      inv.addItem(bleach);
    }
  }
  if (backDrawerButton.pointInRec(mouseX, mouseY)) { 
    scene = 4; 
    openDrawer.play();
  }
  

  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
