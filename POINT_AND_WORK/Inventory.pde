class Inventory {
  ArrayList<ItemButton> items;
  int limit, heldItems;
  PImage inv;
  float x, y;
  Inventory(int limit) {
    this.limit = limit;
    items = new ArrayList<ItemButton>(limit);
    x = 0;
    y = height - 150;
    inv = loadImage("/IMAGES/hud_proto.png");
    heldItems = 0;
  }

  void showInventory() {
    inv.resize(1280, 150);
    image(inv, x, y);
  }

  void addItem(ItemButton item) {
    if (items.size() < limit) {
      items.add(item);
      heldItems++;
      println(item.name + " added.");
      println(heldItems);
    }
  }

  void removeItem(ItemButton item) {
    if(heldItems > 0)
    items.remove(item);
    heldItems--;
    println(item.name + " removed.");
    println(heldItems);
  }


  void displayItems() {
    for (int i = 0; i < heldItems; i++) {
      if(heldItems >=1){
      ItemButton item = items.get(i);
      item.displayOnInv(190+i*150, y + 25);
      }
    }
  }
}
