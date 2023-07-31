class ConditionalCard extends Card { //<>// //<>// //<>//
  CardTriangle triangle1, triangle2, triangle3, triangle4 ;
  ArrayList<CardTriangle> allTriangles;
  CardTriangle selectedTriangle;

  ConditionalCard(int x, int y, int cSize) {
    super(x, y, cSize);
    isConditional = true;
    initTriangles(x,y,cSize);
  }
    ConditionalCard(int x, int y, int cSize, int fixedId) {
    super(x, y, cSize, fixedId);
    isConditional = true;
    initTriangles(x,y,cSize);
  }
  
  void initTriangles(int x, int y, int cSize){
    allTriangles = new ArrayList<CardTriangle>();
    triangle1 = new CardTriangle(x, y, cSize, green);
    allTriangles.add(triangle1);
    triangle2 = new CardTriangle(x, y, cSize, yellow);
    triangle2.triangle.rotate(radians(90), x, y);
    allTriangles.add(triangle2);
    triangle3 = new CardTriangle(x, y, cSize, red);
    triangle3.triangle.rotate(radians(180), x, y);
    allTriangles.add(triangle3);
    triangle4 = new CardTriangle(x, y, cSize, blue);
    triangle4.triangle.rotate(radians(270), x, y);
    allTriangles.add(triangle4);
  }

  void processMouseXY(int x, int y) {
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


  void updatePosition(int x, int y) {
    xpos = x;
    ypos = y;
    updateAllTrianglesPositions(x, y);
  }

  CardTriangle getSelectedTriangle() {
    return selectedTriangle;
  }

  void addToBackground () {
    drawAllTriangles();
    if (isSelected) {
      drawSelection();
    }
  }

  void drawAllTriangles() {
    for (CardTriangle currentTriangle : allTriangles) {
      currentTriangle.drawTriangle();
    }
  }

  void drawSelection() {
    // rectangle
    back.beginDraw();
    back.stroke(markerColor);
    back.strokeWeight(strokeThickness);
    back.noFill();
    back.rect(xpos, ypos, cardSize, cardSize);
    back.endDraw();
    //triangle
    selectedTriangle.drawSelection();
  }

  void rotateAllXDegrees(float deg) {
    for (CardTriangle currentTriangle : allTriangles) {
      currentTriangle.triangle.rotate(radians(deg), xpos, ypos);
    }
  }

  void rotateCenter90Degrees() {
    rotateAllXDegrees(90);
  }

  void updateAllTrianglesPositions(int x, int y) {
    for (CardTriangle currentTriangle : allTriangles) {
      currentTriangle.updatePosition(x,y);
    }
  }
}
