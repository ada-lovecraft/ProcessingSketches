class Place {
  int code;
  String name;
  float x;
  float y;
  boolean display;
  public Place(int code, String name, float x, float y, boolean disp) {

    this.code = code;
    this.name = name;
    this.display = disp;
    this.x = x;
    this.y = y;
    if (display) 
      println(code + " :: "  + name + " :: " + x + " :: " + y);
  }

  void draw() {
    int xx = (int)TX(x);
    int yy = (int)TY(y);
    if (display) {
      println(xx + " :: " + yy);
      set(xx, yy, #ff0000);
    } else {
      set(xx, yy, #000000);
    }
    display = false;
    
  }
}

