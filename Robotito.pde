class Robotito {
  int ypos, xpos, speed, size, directionX, directionY, ledSize, activeDirection;
  color colorRobotito, lastColor;
  float ledDistance;
  boolean isSelected;
  Robotito (int x, int y) {
    xpos = x;
    ypos = y;
    speed = 1;
    size = 100;
    ledSize= 5;
    ledDistance = size*0.52/2-ledSize/2;
    directionX = directionY = activeDirection = 0;
    colorRobotito = #FCB603;
    lastColor = white;
    isSelected = false;
  }
  void update() {
    xpos += speed*directionX;
    ypos += speed*directionY;
    if ((ypos > height) || (ypos < 0)) {
      directionY = 0;
    }
    if ((xpos > width) || (xpos < 0)) {
      directionX = 0;
    }
    int offsetX = directionX*offsetSensing*-1;
    int offsetY = directionY*offsetSensing*-1;
    boolean awayFromCards = true; // will be used to undo ignoredId and allow to repeat violet
      for (Card currentCard : allCards) {
        if (currentCard.isPointInside(xpos+offsetX, ypos+offsetY)) {
          awayFromCards = false;
          if (currentCard.id != ignoredId) {
            processColorAndId(back.get(xpos+offsetX, ypos+offsetY), currentCard.id);
          }
        }
      }
      if (awayFromCards){
        ignoredId = -1;
      }
  }


  void drawRobotitoAndLights() {
    drawRobotito();
    //int offsetX = directionX*offsetSensing*-1;
    //int offsetY = directionY*offsetSensing*-1;
    //circle(xpos+offsetX, ypos+offsetY, 10); // debugging sensing position
    translate(xpos, ypos);
    draw4lights();
    drawDirectionLights();
  }

  void updatePosition(int x, int y) {
    xpos = x;
    ypos = y;
  }
  void drawRobotito() {
    fill(colorRobotito);
    stroke(strokeColor);
    circle(xpos, ypos, size);
    fill(255);
    noStroke();
    circle(xpos, ypos, size*0.62);
    fill(200);
    circle(xpos, ypos, size*0.52);
    fill(255);
    circle(xpos, ypos, size*0.42);
  }
  void draw4lights() {
    // 4 lights
    // green light
    pushMatrix();
    translate(0, -ledDistance);
    fill(green);
    stroke(strokeColor);
    circle(0, 0, ledSize);
    popMatrix();
    // red light
    pushMatrix();
    rotate(radians(180));
    translate(0, -ledDistance);
    fill(red);
    circle(0, 0, ledSize);
    popMatrix();
    //yellow
    pushMatrix();
    rotate(radians(90));
    translate(0, -ledDistance);
    fill(yellow);
    circle(0, 0, ledSize);
    popMatrix();
    //blue
    pushMatrix();
    rotate(radians(270));
    translate(0, -ledDistance);
    fill(blue);
    circle(0, 0, ledSize);
    popMatrix();
  }
  void drawDirectionLights() {
    switch(activeDirection) {
    case 1: // green
      drawArc(0, green);
      break;
    case 2: // yellow
      drawArc(90, yellow);
      break;
    case 3: // red
      drawArc(180, red);
      break;
    case 4: // blue
      drawArc(270, blue);
      break;
    }
  }

  void drawArc(int rotation, color ledArcColor) {
    pushMatrix();
    rotate(radians(rotation) + radians(360/24));
    translate(0, -ledDistance);
    fill(ledArcColor);
    stroke(strokeColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation)+radians(360/24)*2);
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
    // left
    pushMatrix();
    rotate(radians(rotation)-radians(360/24));
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation)-radians(360/24)*2);
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
  }


  void processColorAndId(color currentColor, int id) {
    if (currentColor == green || currentColor == yellow || currentColor == red || currentColor == blue) {
      if (currentColor == green) {
        directionY = -1;
        directionX = 0;
        activeDirection = 1;
      } else if (currentColor == yellow) {
        directionY = 0;
        directionX = 1;
        activeDirection = 2;
      } else if (currentColor == red) {
        directionY = 1;
        directionX = 0;
        activeDirection = 3;
      } else if (currentColor == blue) {
        directionY = 0;
        directionX = -1;
        activeDirection = 4;
      }
      ignoredId = id;
    }
  }

  void setIsSelected(boolean is) {
    isSelected = is;
  }
}
