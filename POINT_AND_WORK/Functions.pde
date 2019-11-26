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


void showText(String text){
  float timer = millis();
  float last = 2000;
  if(millis() <= timer + last){
  textAlign(CORNER);
  text(text, 200, height-120);
  textAlign(CENTER);
  }
}
