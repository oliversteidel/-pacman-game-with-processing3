class Ghost2 {

  PVector pos = new PVector(190, 490+hud);
  boolean goRight, goLeft, goUp, goDown;
  boolean eyesRight, eyesLeft, eyesUp, eyesDown;
  float speed = 1;
  float vel = 0;
  int green = 255;
  int blue = 0;


  void drawGhost() {
    noStroke();
    if (frightendModeOn) {
      green = 0;
      blue = 255;
    } else {
      green = 255;
      blue = 0;
    }
    fill(0, green, blue);
    arc(pos.x, pos.y, 20, 20, radians(180), radians(360));
    rectMode(CENTER);
    rect(pos.x, pos.y+5, 20, 10);
    fill(200);
    ellipse(pos.x-4, pos.y, 6, 6);
    ellipse(pos.x+4, pos.y, 6, 6);
    if (eyesRight) {
      fill(0, 0, 200);
      ellipse(pos.x-2, pos.y, 4, 4);
      ellipse(pos.x+6, pos.y, 4, 4);
    } else if (eyesLeft) {
      fill(0, 0, 200);
      ellipse(pos.x-6, pos.y, 4, 4);
      ellipse(pos.x+2, pos.y, 4, 4);
    } else if (eyesUp) {
      fill(0, 0, 200);
      ellipse(pos.x-4, pos.y-2, 4, 4);
      ellipse(pos.x+4, pos.y-2, 4, 4);
    } else if (eyesDown) {
      fill(0, 0, 200);
      ellipse(pos.x-4, pos.y+2, 4, 4);
      ellipse(pos.x+4, pos.y+2, 4, 4);
    } else {
      fill(0, 0, 200);
      ellipse(pos.x-4, pos.y, 4, 4);
      ellipse(pos.x+4, pos.y, 4, 4);
    }
    rectMode(CORNER);
  }
  void move() {
    if (pacman.x + 100 > pos.x) {
      isRightBlocked((int)pos.x, (int)pos.y);
      moveRight();
      goRight = true;
    }
    if (pacman.x - 100 < pos.x) {
      isLeftBlocked((int)pos.x, (int)pos.y);
      moveLeft();
      goLeft = true;
    }
    if (pacman.y +100 > pos.y) {
      isDownBlocked((int)pos.x, (int)pos.y);
      moveDown();
      goDown = true;
    }
    if (pacman.y - 100 < pos.y) {
      isUpBlocked((int)pos.x, (int)pos.y);
      moveUp();
      goUp = true;
    }
  }

  void moveRight() {
    if (pos.x < width-cellSize/2 && goRight) {
      eyesRight = true;
      eyesLeft = false;
      eyesUp = false;
      eyesDown = false;
      pos.x += cellSize;
    }
  }
  void moveLeft() {
    if (pos.x > 0+cellSize/2 && goLeft) {
      eyesRight = false;
      eyesLeft = true;
      eyesUp = false;
      eyesDown = false;
      pos.x -= cellSize;
    }
  }
  void moveUp() {
    if (pos.y > hud+cellSize/2 && goUp) {
      eyesRight = false;
      eyesLeft = false;
      eyesUp = true;
      eyesDown = false;
      pos.y -= cellSize;
    }
  }
  void moveDown() {
    if (pos.y < height-cellSize/2 && goDown) {
      eyesRight = false;
      eyesLeft = false;
      eyesUp = false;
      eyesDown = true;
      pos.y += cellSize;
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
  void resetGhost() {
    pos.x = 190;
    pos.y = 490+hud;
  }
  void calcSpeed() {
    vel += speed;
    if (vel == 30 || vel == 32) {
      vel = 0;
    }
  }
  void frightendMode() {
    if (190 > pos.x) {
      isRightBlocked((int)pos.x, (int)pos.y);
      moveRight();
      goRight = true;
    }
    if (190 < pos.x) {
      isLeftBlocked((int)pos.x, (int)pos.y);
      moveLeft();
      goLeft = true;
    }
    if (210+hud > pos.y) {
      isDownBlocked((int)pos.x, (int)pos.y);
      moveDown();
      goDown = true;
    }
    if (210+hud < pos.y) {
      isUpBlocked((int)pos.x, (int)pos.y);
      moveUp();
      goUp = true;
    }
  }
}
