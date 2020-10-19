class Pacman {

  int x, y, d;
  int counter = 0;
  int lives;
  boolean animRight = true, animLeft, animUp, animDown;
  boolean goRight = true, goLeft, goUp, goDown;

  Pacman() {
    x = 190;
    y = 90+hud;
    d = 20;
    lives = 3;
  }
  //Animation der Mundbewegung jede halbe Sekunde 
  void animCounter() {
    if (frameCount == 15) {
      frameCount = 0;
      if (counter == 0) {
        counter = 1;
      } else if (counter == 1) {
        counter = 0;
      }
    }
  }

  void draw() {
    animCounter();
    noStroke();
    fill(255, 255, 0);
    if (counter == 1 && animRight) {
      ellipse(x, y, d, d);
    } else if (counter == 0 && animRight) {
      arc(x, y, d, d, radians(30), radians(330));
    }
    if (counter == 1 && animLeft) {
      ellipse(x, y, d, d);
    } else if (counter == 0 && animLeft) {
      arc(x, y, d, d, radians(-150), radians(150));
    }
    if (counter == 1 && animDown) {
      ellipse(x, y, d, d);
    } else if (counter == 0 && animDown) {
      arc(x, y, d, d, radians(120), radians(420));
    }
    if (counter == 1 && animUp) {
      ellipse(x, y, d, d);
    } else if (counter == 0 && animUp) {
      arc(x, y, d, d, radians(-60), radians(250));
    }
  }
  void moveRight() {
    if (x < width-d/2 && goRight) {
      x += d;
    }
  }
  void moveLeft() {
    if (x > 0+d/2 && goLeft) {
      x -= d;
    }
  }
  void moveUp() {
    if (y > hud+d/2 && goUp) {
      y -= d;
    }
  }
  void moveDown() {
    if (y < height-d/2 && goDown) {
      y += d;
    }
  }
  void isRightBlocked(int posX, int posY) {
    for (int i = 0; i < level1.rects.length; i++) {
      if (posX+20 == level1.rects[i].x && posY == level1.rects[i].y) {
        goRight = false;
      }
    }
  }
  void isLeftBlocked(int posX, int posY) {
    for (int i = 0; i < level1.rects.length; i++) {
      if (posX-20 == level1.rects[i].x && posY == level1.rects[i].y) {
        goLeft = false;
      }
    }
  }
  void isUpBlocked(int posX, int posY) {
    for (int i = 0; i < level1.rects.length; i++) {
      if (posX == level1.rects[i].x && posY-20 == level1.rects[i].y) {
        goUp = false;
      }
    }
  }
  void isDownBlocked(int posX, int posY) {
    for (int i = 0; i < level1.rects.length; i++) {
      if (posX == level1.rects[i].x && posY+20 == level1.rects[i].y) {
        goDown = false;
      }
    }
  }
  void showLives() {
    switch(lives) {
    case 3:
      arc(320, 30, d, d, radians(30), radians(330));
      arc(350, 30, d, d, radians(30), radians(330));
      arc(380, 30, d, d, radians(30), radians(330));
      break;
    case 2:
      arc(320, 30, d, d, radians(30), radians(330));
      arc(350, 30, d, d, radians(30), radians(330));
    case 1:
      arc(320, 30, d, d, radians(30), radians(330));
      break;
    }
  }
  void resetPacman() {
    x = 190;
    y = 90+hud;
    
  }
}
