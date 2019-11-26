PImage hall;
boolean openedCloset = false, pickedFW = false, fwInInventory = false, pickedCatnip, catnipInInv;

//items
ItemButton fireworks, catnip;

Rectangle closet, fw, frontDoor, leftDoor, catnipRec;

void hallSetup() {
  hall = loadImage("/IMAGES/hallway_closed.png");
  if (openedCloset) {
    hall = loadImage("/IMAGES/hallway.png");
    fireworks = new ItemButton("Fireworks", width - 290, height/2 + 90, "/IMAGES/fireworks2.png", 5, 5, fw, "Cheap bootleg fireworks, maximum damage.");
    fw = new Rectangle(fireworks.x, fireworks.y, 120, 100);
    catnip = new ItemButton("Catnip", width - 370, height/2 + 50, "/IMAGES/catnip.png", 5, 5, catnipRec, "Drugs for the cats, wonder how much it will take for him to get aggressive.");
    catnipRec = new Rectangle(catnip.x, catnip.y, 80, 80);
  }
  closet = new Rectangle(850, 100, 300, 500);
  frontDoor = new Rectangle(width/2 - 165, 130, 190, 350);
  leftDoor = new Rectangle(100, 90, 160, 475);
}

void hall() {
  hallSetup();
  
  image(hall, 0, -75);
  inv.showInventory();
  if (!openedCloset) {
    showDescription(closet.x, closet.y, closet.w, closet.h, "A closet. I think it’s unlocked.");
  }
  if (openedCloset) {
    if (!pickedFW) {
      fireworks.display();
      showDescription(fw.x, fw.y, fw.w, fw.h, fireworks.description);
    }
    if (!pickedCatnip) {
      catnip.display();
      showDescription(catnipRec.x, catnipRec.y, catnipRec.w, catnipRec.h, catnip.description);
    }
  }
  inv.displayItems();
  for (int i = 0; i < inv.heldItems; i++) {
    ItemButton item = inv.items.get(i);
    showDescription(180 * i + 150, height - 100, 130, 80, item.description);
    if (item.held) {
      item.displayOnInv(mouseX - 50, mouseY - 50);
    }
  }
  //println(fireworks.button);
}

void hallClicks() {
  if (frontDoor.pointInRec(mouseX, mouseY)) {
    scene = 3; 
    doorOpen.play();
  } //going to livingroom
  if (leftDoor.pointInRec(mouseX, mouseY)) {
    scene = 4; 
    doorOpen.play();
  } // going to bathroom  
  if (openedCloset && fw.pointInRec(mouseX, mouseY) && !pickedFW) {
    pickedFW = true;
    fwInInventory = true;
    pickItem.play();
    inv.addItem(fireworks);
  }
  if (openedCloset && catnipRec.pointInRec(mouseX, mouseY) && !pickedCatnip) {
    pickedCatnip = true;
    catnipInInv = true;
    pickItem.play();
    inv.addItem(catnip);
  }
  if (closet.pointInRec(mouseX, mouseY)) openedCloset = true;
  
  for (int i = 0; i < inv.heldItems; i++) {
    if (pointInRect(mouseX, mouseY, 180 * i + 150, height - 100, 130, 80)) inv.items.get(i).held = true;
    else inv.items.get(i).held = false;
  }
}
