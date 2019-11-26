PImage bathroom;
Rectangle bath, frontArrow, backArrow;

//bathroom buttons
void bathroomSetup() {
  bathroom = loadImage("/IMAGES/bathroom.png");
  bath = new Rectangle(20, 275, 500, 300);
  frontArrow = new Rectangle(width/2 - 25, height/2 - 105, 130, 150);
  backArrow = new Rectangle(width/2 - 40, height - 215, 100, 70);
}

void bathroom() {
  bathroomSetup();
  //bath.display();
  image(bathroom, 0, -80);
  inv.showInventory();
  showDescription(bath.x, bath.y, bath.w, bath.h, "A bathtub. Not a beach.");
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 130, height - 100, 130, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX, mouseY);
    }
  }
}

void bathroomClicks() {
  if (frontArrow.pointInRec(mouseX, mouseY)) scene = 6; //println("closeup"); // closer to the cabinet
  if (backArrow.pointInRec(mouseX, mouseY)) {
    scene = 2; // hall
    doorOpen.play();
  }
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 130, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
