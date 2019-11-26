PImage bathroom_drawer;
boolean upDrawerOpen, downDrawerOpen, pickedAlcohol = false, pickedVitamins = false;
Rectangle upDrawerRec, downDrawerRec, alcRec, vitaminsRec;

ImageButton upDrawer, downDrawer, backDrawerButton;
ItemButton alcohol, vitamins;

void bathDrawersSetup() {
  upDrawer = new ImageButton(340, -85, "/IMAGES/closeup_open2.png");
  downDrawer = new ImageButton(350, 190, "/IMAGES/closeup_open.png");
  backDrawerButton = new ImageButton(width/2, height - 100, "/IMAGES/downArrow.png");
  alcohol = new ItemButton("Flamable Liquid", width/2 - 100, height - 230, "/IMAGES/rubbingalcohol2.png", 5, 5, alcRec, "Very flammable…..very nice.");
  bathroom_drawer = loadImage("/IMAGES/bathroom_closeup_closed.png");
  upDrawerRec = new Rectangle(470, -50, 300, 200);
  downDrawerRec = new Rectangle(465, 320, 310, 310);
  alcRec = new Rectangle(width/2 - 110, height - 220, 80, 130);
  vitaminsRec = new Rectangle(width/2 + 40, height - 240, 80, 130);
  vitamins = new ItemButton("Vitamins", width/2, height - 250, "/IMAGES/vitamins.png", 5, 5, vitaminsRec, "Flintstones! Meet the flintstones! Meet your end!");
}

void bathDrawers() {
  bathDrawersSetup();
  image(bathroom_drawer, 0, -50);

  inv.showInventory();
  if (upDrawerOpen) upDrawer.display();
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
  }
  //if(pickedAlcohol){
  //  inv.positionItem(alcohol, alcRec);
  //  inv.displayItem(alcohol, alcRec);
  //}
  backDrawerButton.display();
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 130, height - 100, 130, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX, mouseY);
    }
  }
}

void bathDrawersClicks() {
  if (upDrawerRec.pointInRec(mouseX, mouseY)) {
    upDrawerOpen = !upDrawerOpen;
    if (upDrawerOpen == true) openDrawer.play();
  }
  if (downDrawerRec.pointInRec(mouseX, mouseY) && keyInInventory) { 
    for (int i = 0; i < inv.heldItems; i++) {
      ItemButton item = inv.items.get(i);
      downDrawerOpen = true;
      if (item.name == "Key" && item.held) {
        keyInInventory = false;
        item.held = false;
        inv.removeItem(item);
      }
    }
  }
  if (backDrawerButton.pointInRec(mouseX, mouseY)) { 
    scene = 4; 
    openDrawer.play();
  }
  if (vitaminsRec.pointInRec(mouseX, mouseY) && downDrawerOpen) {
    pickedVitamins = true;
    pickItem.play();
    inv.addItem(vitamins);
  }
  if (alcRec.pointInRec(mouseX, mouseY) && downDrawerOpen) {
    pickedAlcohol = true;
    pickItem.play();
    inv.addItem(alcohol);
  }
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
