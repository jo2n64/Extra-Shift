boolean pointInRect(float x, float y, float recX, float recY, float wid, float hei) {
  return x >= recX && x <= recX + wid && y >= recY && y <= recY + hei;
}

void showDescription(float x, float y, float wid, float hei, String description) {
  if (pointInRect(mouseX, mouseY, x, y, wid, hei)) {
    textSize(24);
    textAlign(CORNER);
    fill(0);
    text(description, 200, height - 120);
    textAlign(CENTER);
  }
}

void showAction(String description){
  float timer = millis();
  float end = 3000;
  while(timer <= end + timer){
    text(description, 10, height-50);
  }
}

void showText(String text){
  textAlign(CORNER);
  text(text, 200, height-120);
  textAlign(CENTER);
}
