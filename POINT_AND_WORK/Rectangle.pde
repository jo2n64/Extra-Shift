class Rectangle{
  float x, y, w, h;
  Rectangle(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display(){
    fill(127);
    rect(x, y, w, h);
  }
  
  
  boolean pointInRec(float px, float py){
    return pointInRect(px, py, x, y, w, h);
  }
  
}
