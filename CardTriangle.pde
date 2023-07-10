class CardTriangle {
  RPolygon triangle;
  color colorTriangle;
  int centerX, centerY;
  boolean isSelectedTriangle;
  RPoint[] points = new RPoint[3];
  CardTriangle(int x, int y, int cardSize, color colorIn ) {
    centerX = x;
    centerY = y;
    colorTriangle = colorIn;
    points[0] = new RPoint(x-cardSize/2, y-cardSize/2);
    points[1] = new RPoint(x+cardSize/2, y-cardSize/2);
    points[2] = new RPoint(x, y);
    triangle = new RPolygon(points);
    isSelectedTriangle = false;
  }

  void drawTriangle() {
    back.beginDraw();
    back.noStroke();
    back.fill(colorTriangle);
    back.beginShape();
    back.vertex(triangle.getPoints()[0].x, triangle.getPoints()[0].y);
    back.vertex(triangle.getPoints()[1].x, triangle.getPoints()[1].y);
    back.vertex(triangle.getPoints()[2].x, triangle.getPoints()[2].y);
    back.endShape(CLOSE);
    back.endDraw();
  }

  void drawSelection() {
    back.beginDraw();
    back.stroke(markerColor);
    back.strokeWeight(strokeThickness/2);
    back.noFill();
    back.beginShape();
    back.vertex(triangle.getPoints()[0].x, triangle.getPoints()[0].y);
    back.vertex(triangle.getPoints()[1].x, triangle.getPoints()[1].y);
    back.vertex(triangle.getPoints()[2].x, triangle.getPoints()[2].y);
    back.endShape(CLOSE);
    back.endDraw();
  }

  void setIsSelected(boolean is) {
    isSelectedTriangle = is;
  }

  void setNextColor() {
    colorTriangle = getNextColor(colorTriangle);
  }

  void updatePosition(int x, int y) {
    triangle.getPoints()[0].x = triangle.getPoints()[0].x - centerX + x;
    triangle.getPoints()[1].x = triangle.getPoints()[1].x - centerX + x;
    triangle.getPoints()[2].x = triangle.getPoints()[2].x - centerX + x;
    
    triangle.getPoints()[0].y = triangle.getPoints()[0].y - centerY + y;
    triangle.getPoints()[1].y = triangle.getPoints()[1].y - centerY + y;
    triangle.getPoints()[2].y = triangle.getPoints()[2].y - centerY + y;
    
    centerX = x;
    centerY = y;
  }

  float area(int x1, int y1, int x2, int y2, int x3, int y3) {
    return Math.abs((x1*(y2-y3) + x2*(y3-y1)+
      x3*(y1-y2))/2.0);
  }

  /* A function to check whether point P(x, y) lies inside the triangle formed by A(x1, y1), B(x2, y2) and C(x3, y3) */
  boolean contains(int x, int y) {
    /* Calculate area of triangle ABC */
    double A = area ((int)triangle.getPoints()[0].x, (int)triangle.getPoints()[0].y, (int)triangle.getPoints()[1].x, (int)triangle.getPoints()[1].y, (int)triangle.getPoints()[2].x, (int)triangle.getPoints()[2].y);

    /* Calculate area of triangle PBC */
    double A1 = area (x, y, (int)triangle.getPoints()[1].x, (int)triangle.getPoints()[1].y, (int)triangle.getPoints()[2].x, (int)triangle.getPoints()[2].y);

    /* Calculate area of triangle PAC */
    double A2 = area ((int)triangle.getPoints()[0].x, (int)triangle.getPoints()[0].y, x, y, (int)triangle.getPoints()[2].x, (int)triangle.getPoints()[2].y);

    /* Calculate area of triangle PAB */
    double A3 = area ((int)triangle.getPoints()[0].x, (int)triangle.getPoints()[0].y, (int)triangle.getPoints()[1].x, (int)triangle.getPoints()[1].y, x, y);

    /* Check if sum of A1, A2 and A3 is same as A */
    return (A == A1 + A2 + A3);
  }
}
