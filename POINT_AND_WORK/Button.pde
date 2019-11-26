class ImageButton {
  float x, y;
  PImage button;
  String path;
  ImageButton(float x, float y, String path) {
    this.x = x;
    this.y = y;
    this.path = path;
  }

  void display() {
    if (button == null) {
      button = loadImage(path);
      if (path == "/IMAGES/leftArrow.png" || path == "/IMAGES/rightArrow.png" || path == "/IMAGES/upArrow.png" || path == "/IMAGES/downArrow.png") button.resize(100, 100);
    }
      image(button, x, y);
  }

  boolean pointInRec(float px, float py) {
    return pointInRect(px, py, x, y, button.width, button.height);
  }
}

class ItemButton extends ImageButton {
  int xRatio, yRatio;
  String name, description;
  Rectangle rect;
  boolean held;
  ItemButton(String name, float x, float y, String path, int xRatio, int yRatio, Rectangle rect, String description) {
    super(x, y, path);
    this.xRatio = xRatio;
    this.yRatio = yRatio;
    this.name = name;
    this.rect = rect;
    this.description = description;
    held = false;
  }

  void display() {
    if (button == null) {
      button = loadImage(path);
      button.resize(button.width / xRatio, button.height / yRatio);
    }
    image(button, x, y);
  }

  void displayOnInv(float x, float y) {
    if (button == null) {
      button = loadImage(path);
      button.resize(button.width / xRatio, button.height/ yRatio);
    }
    image(button, x, y);
  }

  boolean pointInRec(float px, float py) {
    return pointInRect(px, py, x, y, button.width, button.height);
  }
}
