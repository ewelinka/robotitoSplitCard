class Card {

  int xpos;
  int ypos;
  int cardSize;
  int id;
  boolean isConditional; // color or conditional?
  boolean isSelected;

  Card(int x, int y, int cSize) {
    xpos = x;
    ypos = y;
    cardSize = cSize;
    isSelected = false;
    id = millis();
  }
  
  Card(int x, int y, int cSize, int fixedId) {
    this(x,y,cSize);
    id = fixedId;
  }
  
  void updatePosition(int x, int y) {
    xpos = x;
    ypos = y;
  }

  void addToBackground() {
  }

  void rotateCenter90Degrees() {
  }

  boolean isPointInside(int x, int y) {
    return x >= xpos-cardSize/2 && x <= xpos+cardSize/2 && y >= ypos-cardSize/2 && y <= ypos+cardSize/2;
  }
  void setIsSelected(boolean is, int x, int y) {
    isSelected = is;
    processMouseXY(x, y);
  }
  void processMouseXY(int x, int y) {
  }
  boolean isConditionalCard() {
    return isConditional;
  }
}
