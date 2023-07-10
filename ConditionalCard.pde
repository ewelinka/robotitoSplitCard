class ConditionalCard extends Card { //<>// //<>//
  CardTriangle topTriangle, rightTriangle, bottomTriangle, leftTriangle ;
  ArrayList<CardTriangle> allTriangles;
  CardTriangle selectedTriangle;

  ConditionalCard(int x, int y, int cSize) {
    super(x, y, cSize);
    isConditional = true;
    allTriangles = new ArrayList<CardTriangle>();
    topTriangle = new CardTriangle(x, y, cSize, green);
    allTriangles.add(topTriangle);
    rightTriangle = new CardTriangle(x, y, cSize, yellow);
    rightTriangle.triangle.rotate(radians(90), x, y);
    allTriangles.add(rightTriangle);
    bottomTriangle = new CardTriangle(x, y, cSize, red);
    bottomTriangle.triangle.rotate(radians(180), x, y);
    allTriangles.add(bottomTriangle);
    leftTriangle = new CardTriangle(x, y, cSize, blue);
    leftTriangle.triangle.rotate(radians(270), x, y);
    allTriangles.add(leftTriangle);
  }

  void processMouseXY(int x, int y){
    // check which part of the card was selected and highlight
    for (CardTriangle currentTriangle : allTriangles) {
      if (isSelected) {
        if (currentTriangle.contains(x, y)) {
          selectedTriangle =  currentTriangle;
          currentTriangle.setIsSelected(true);
        } else {
          currentTriangle.setIsSelected(false);
        }
      } else {
        currentTriangle.setIsSelected(false);
      }
    }
  }
  

  
  CardTriangle getSelectedTriangle(){
    return selectedTriangle;
  }

  void addToBackground () {
    drawAllTriangles();
    if (isSelected) {
      drawSelection();
    }
  }

  void drawAllTriangles() {
    topTriangle.drawTriangle();
    rightTriangle.drawTriangle();
    bottomTriangle.drawTriangle();
    leftTriangle.drawTriangle();
  }

  void drawSelection() {
    // rectangle
    back.beginDraw();
    back.stroke(markerColor);
    back.strokeWeight(6);
    back.noFill();
    back.rect(xpos, ypos, cardSize, cardSize);
    back.endDraw();
    //triangle
    selectedTriangle.drawSelection();
  }

  void rotateAllXDegrees(float deg) {
    topTriangle.triangle.rotate(radians(deg), xpos, ypos);
    rightTriangle.triangle.rotate(radians(deg), xpos, ypos);
    bottomTriangle.triangle.rotate(radians(deg), xpos, ypos);
    leftTriangle.triangle.rotate(radians(deg), xpos, ypos);
  }

  void rotateCenter90Degrees() {
    rotateAllXDegrees(90);
  }
}
