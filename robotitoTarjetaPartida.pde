import geomerative.*;

Robotito robotito;
PGraphics back;
color cardColor, yellow, blue, green, red, white, markerColor;
int cardSize;
boolean puttingCards, puttingConditionalCard, stopRobot;
int offsetSensing;
int strokeThickness;

Card selectedCard;
int ignoredId;
ArrayList<Card> allCards;

void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  smooth();
  robotito = new Robotito(width/2, height/2);
  back = createGraphics(width, height);
  back.beginDraw();
  back.noStroke();
  back.background(255);
  back.rectMode(CENTER);
  back.imageMode(CENTER);
  back.endDraw();
  ellipseMode(CENTER);
  yellow = #FAF021;
  blue = #2175FA;
  red = #FA0F2B;
  green = #02E01A;
  white = #FFFFFF;
  markerColor = #000000;

  cardColor = green;
  cardSize = 100;
  puttingCards = true;
  puttingConditionalCard = false;
  stopRobot = false;
  offsetSensing = cardSize/2;
  ignoredId = 0;
  strokeThickness = 4;
  allCards = new ArrayList<Card>();
  initWithCards();

  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
}

void draw() {
  displayCards();
  if (!stopRobot) {
    robotito.update();
  }
}

void mousePressed() {
  // TODO restrict card selection to just one!
  for (Card currentCard : allCards) {
    if (currentCard.isPointInside(mouseX, mouseY)) {
      selectedCard =  currentCard;
      currentCard.setIsSelected(true, mouseX, mouseY);
    } else {
      currentCard.setIsSelected(false, mouseX, mouseY);
    }
  }
}
void mouseDragged() {
  for (Card currentCard : allCards) {
    if (currentCard.isPointInside(mouseX, mouseY) && currentCard.isSelected) {
      currentCard.updatePosition(mouseX, mouseY);
    }
  }
//if (robotito.isPointInside(mouseX, mouseY))
  if(dist(robotito.xpos, robotito.ypos, mouseX, mouseY) < robotito.size/2)
   {
    robotito.updatePosition(mouseX, mouseY);
  }
}
void keyPressed() {
  if (key == 'p' || key == 'P') {
    puttingCards = !puttingCards;
  } else if (key == 's' || key == 'S') {
    stopRobot = !stopRobot;
  } else if (key == 'd' || key == 'D') {
    deleteSelectedCard();
  } else if (key == CODED) {
    if (keyCode == DOWN) {
      if (puttingCards) {
        addCard(mouseX, mouseY);
      }
    } else if (keyCode == UP) {
      if (selectedCard != null && selectedCard.isConditional) {
        selectedCard.rotateCenter90Degrees();
      }
    } else if (keyCode == RIGHT) {
      if (selectedCard != null && selectedCard.isConditional) {
        ConditionalCard cc = (ConditionalCard)selectedCard;
        cc.getSelectedTriangle().setNextColor();
      }
    }
  } else {
    if (key == 'c' || key == 'C') {
      puttingConditionalCard = true;
    } else {
      puttingConditionalCard = false;
      if (key == 'b' || key == 'B') {
        cardColor = blue; // azul
      } else if (key == 'r' || key == 'R') {
        cardColor = red; // rojo
      } else if (key == 'g' || key == 'G') {
        cardColor = green; // verde
      } else if (key == 'y' || key == 'Y') {
        cardColor = yellow; // amarillo
      }
    }
  }
}

void addCard(int x, int y) {
  if (puttingConditionalCard) {
    allCards.add(new ConditionalCard(x, y, cardSize));
  } else {
    allCards.add(new ColorCard(x, y, cardSize, cardColor));
  }
}

void displayCards() {
  back.beginDraw();
  back.background(255);
  back.endDraw();
  for (Card currentCard : allCards) {
    currentCard.addToBackground();
  }
  image(back, 0, 0);
}

color getNextColor(color cc) {
  color newColor = green;
  if (cc == green) {
    newColor =  yellow;
  } else if (cc == yellow) {
    newColor = red;
  } else if (cc == red) {
    newColor = blue;
  }
  return newColor;
}

String colorToName(int colorNow) {
  String toReturn = "";
  switch(colorNow) {
  case -16588774:
    toReturn = "green";
    break;
  case -1:
    toReturn = "white";
    break;
  case -331743:
    toReturn = "yellow";
    break;
  case -389333:
    toReturn = "green";
    break;
  case -14584326:
    toReturn = "blue";
    break;
  case -16777216:
    toReturn = "marker";
    break;
  }
  return toReturn;
}

void deleteSelectedCard() {
  allCards.remove(selectedCard);
}
void initWithCards() {
  int x = 0 + cardSize/2 + 10;
  int y = height - cardSize/2 -10;
  allCards.add(new ColorCard(x, y, cardSize, green, 1));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, red, 2));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, yellow, 3));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, blue, 4));
  x = x + cardSize + 10;
  allCards.add(new ConditionalCard(x, y, cardSize, 5));
}
