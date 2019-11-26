PImage frontPorch;
Rectangle porch, axeRec;
boolean axePicked, axeInInventory;
int doorHitCount = 0;

//porch buttons
ImageButton door[], axePlace;
ItemButton axe;

void frontPorchSetup() {
  axe = new ItemButton("Fire Axe", width - 200, height/2 - 200, "/IMAGES/axe.png", 5, 5, axeRec, "This is a fire axe, wonder what I can break with that. ");
  frontPorch = loadImage("/IMAGES/222.png");
  porch = new Rectangle(475, -50, 300, 700);
  axeRec = new Rectangle(width/2 + 370, height/2 - 200, 400, 200);
  axePlace = new ImageButton(width - 270, height/2 - 200, "/IMAGES/axeHanged.png");
  door = new ImageButton[3];
  door[0] = new ImageButton(0, -50, "/IMAGES/door_fine.png");
  door[1] = new ImageButton(0, -50, "/IMAGES/door_harmed2.png");
  door[2] = new ImageButton(0, -50, "/IMAGES/door_harmed3.png");
}

void scene1() {
  frontPorchSetup();
  image(frontPorch, 0, -75);

  if (doorHitCount == 0)
    door[0].display();
  inv.showInventory();
  if (!axePicked) {
    axePlace.display();
    showDescription(axePlace.x, axePlace.y, axePlace.button.width, axePlace.button.height, axe.description);
  }
  if (doorHitCount == 1) door[1].display();
  if (doorHitCount == 2) door[2].display();
  //  if(axePicked) {
  //    inv.positionItem(axe, axeRec);
  //    inv.displayItem(axe, axeRec, "This is a fire axe, wonder what I can break with that.");
  //}
  showDescription(porch.x, porch.y, porch.w, porch.h, "This is the place. Now how do I get in?");
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 130, height - 100, 150, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX, mouseY);
    }
  }
}

void frontPorchClicks() {

  if (axeRec.pointInRec(mouseX, mouseY)) {
    inv.addItem(axe);
    axePicked = true;
    axeInInventory = true;
    pickItem.play();
  }
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) item.held = true;
    if (porch.pointInRec(mouseX, mouseY) && axePicked && item.held) {
      doorHitCount++;
      axeHit.play();
      item.held = false;
      if (doorHitCount >= 3) {
        scene = 2;
        if (item.name == "Fire Axe") {
          inv.removeItem(item);
          axeInInventory = false;
          item.held = false;
        }
      }
    } 
  }
}
