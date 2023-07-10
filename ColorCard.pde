class ColorCard extends Card{
  color cardColor;

  ColorCard(int x, int y, int cSize, color cColor) {
    super(x,y,cSize);
    cardColor = cColor;
    isConditional = false;
  }
  
  void addToBackground(){
    back.beginDraw();
    back.fill(cardColor);
    if(isSelected){
      back.stroke(markerColor);
      back.strokeWeight(6);
    }else{
      back.noStroke();
    }
    back.rect(xpos, ypos, cardSize, cardSize);
    back.text(id,xpos, ypos);
    back.endDraw();
  }

 
}
