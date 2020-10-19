//TASK:  weitere Level einbauen, 





int cellSize = 20;
int hud = 50;
int score = 0;
int cellX = 10, cellY = 10+hud;
int level = 1;
int frightendModeCounter = 0;
int highscore;

String highscoreSaver;
String[] list;

PVector[][] checkCell = new PVector[20][20];  //Koordinaten für jede Zelle (Zellmittelpunkt)
boolean[][] isOccupied = new boolean[20][20]; //Koordinaten der Zellen die mit Barriere belegt sind
boolean gameOver = false;
boolean levelUp = false;
boolean frightendModeOn = false;
boolean eatSuperpoint = false;


//Initialisieren der Objekte
Pacman pacman = new Pacman();
Point[] point = new Point[185];
Superpoint[] superpoint = new Superpoint[5]; 
Level1 level1 = new Level1();
Ghost ghost = new Ghost();
Ghost2 ghost2 = new Ghost2();

void setup() {
  size(400, 450);
  frameRate(30);
  level1.createMaze();
  initCheckCell();
  initIsOccupied();
  initPoints();  
  initSuperpoints();
  loadHighscore();
}

void draw() {
  if (gameOver) {
    //Anzeige wenn verloren
    background(0);    
    textSize(40);
    stroke(255);
    text("GAME OVER!", width/4, height/2);
  } else {
    background(0);
    drawHud();
    levelHandler();
    levelUp();
    scoreCount();
    lifeHandler();
    eatGhost();
    counterFrightendMode();
    level1.draw();
    pacman.draw();
    pacman.showLives();

    //points werden gezeichnet
    for (int i = 0; i < point.length; i++) {
      point[i].draw();
    }

    //superpoints werden gezeichnet
    for ( int i = 0; i < superpoint.length; i++) {
      superpoint[i].draw();
    }

    //ghost wird gezeichnet und der speed wird berechnet
    ghost.calcSpeed();
    ghost2.calcSpeed();
    ghost.drawGhost();
    ghost2.drawGhost();
    counterFrightendMode();

    //ghost Movement
    if (ghost.vel == 28 || ghost.vel == 27 || ghost.vel == 30) {
      if (!frightendModeOn) {
        ghost.move();
      } else {
        ghost.frightendMode();
      }
    } 

    //ghost2 Movement
    if (ghost2.vel == 28 || ghost2.vel == 27 || ghost2.vel == 30) {
      if (!frightendModeOn) {
        ghost2.move();
      } else {
        ghost2.frightendMode();
      }
    }   
    win();
  }
}

void scoreCount() {
  for (int i = 0; i < point.length; i++) {
    if (pacman.x == point[i].x && pacman.y == point[i].y && point[i].alive == true) {
      score+=10;
      point[i].alive = false;
    }
  }
  for (int i = 0; i < superpoint.length; i++) {
    if (pacman.x == superpoint[i].x && pacman.y == superpoint[i].y && superpoint[i].alive == true) {
      score+=100;
      frightendModeOn = true;
      eatSuperpoint = true;   //Variable um frightendModeCounter zu resetten, im Fall dass 
      superpoint[i].alive = false;
    }
  }
}

void drawHud() {
  stroke(255);
  fill(255);
  textSize(20);
  text("Score: " + score, 10, 40);
  text("Level: " + level, 10, 20);
  text("Highscore: " + highscore, 150, 20);
  line(0, hud, width, hud);
}

void initCheckCell() {
  for (int i = 0; i < 20; i++) {
    checkCell[0][i] = new PVector(cellX, cellY);
    cellX += 20;
  }
  cellX = 10;
  for (int i = 1; i < 20; i++) {
    cellY += 20;
    cellX = 10;
    for (int k = 0; k < 20; k++) {
      checkCell[i][k] = new PVector(cellX, cellY);
      cellX += 20;
    }
  }
}

void initIsOccupied() {
  int tmp = 0;
  for (int i = 0; i < 20; i++) {
    for (int k = 0; k < 20; k++) {
      if (checkCell[i][k].equals(level1.rects[tmp])) {
        isOccupied[i][k] = true;
        tmp++;
      }
    }
  }
}

void initPoints() {
  int a = 0;
  for (int i = 0; i < 20; i++) {
    for (int k = 0; k < 20; k++) {
      if (!isOccupied[i][k]) {
        point[a] = new Point(checkCell[i][k].x, checkCell[i][k].y);
        a++;
      }
    }
  }
}

void initSuperpoints() {
  int tmp = 0;
  for (int i = 0; i < superpoint.length; i++) {
    tmp = (int)random(0, 185);
    superpoint[i] = new Superpoint(point[tmp].x, point[tmp].y);
    point[tmp].alive = false;
  }
}

void lifeHandler() {
  if (!frightendModeOn && ghost.pos.x == pacman.x && ghost.pos.y == pacman.y) {
    pacman.lives--;
    pacman.resetPacman();
    ghost.resetGhost();
  }
  if (!frightendModeOn && ghost2.pos.x == pacman.x && ghost2.pos.y == pacman.y) {
    pacman.lives--;
    pacman.resetPacman();
    ghost2.resetGhost();
  }
  if (pacman.lives == 0) {
    gameOver = true;
  }
}

void levelHandler() {
  int tmp = 0;
  for (int i = 0; i < point.length; i++) {
    if (!point[i].alive) {
      tmp++;
    }
  }
  if (tmp == point.length) {
    levelUp = true;
    level++;
    ghost.speed++; 
    ghost2.speed++;
  }
}

void levelUp() {
  if (levelUp) {
    //reset points
    for (int i = 0; i < point.length; i++) {
      point[i].alive = true;
    }
    //reset superpoints
    for (int i = 0; i < superpoint.length; i++) {
      superpoint[i].alive = true;
    }    
    ghost.vel = 0;
    ghost2.vel = 0;
    levelUp = false;
    frightendModeOn = false;
    pacman.resetPacman();
    ghost.resetGhost();
    ghost2.resetGhost();
  }
}

void resetLives() {
  pacman.lives = 3;
}

void counterFrightendMode() {
  if (frightendModeOn) {
    if (eatSuperpoint) {
      frightendModeCounter = 0;
      eatSuperpoint = false;
    }

    if (frameCount == 15) {
      frightendModeCounter++;
    }

    if (frightendModeCounter == 14) {
      frightendModeOn = false;
      frightendModeCounter = 0;
    }
  }
}

void eatGhost() {
  if (frightendModeOn && ghost.pos.x == pacman.x && ghost.pos.y == pacman.y) {
    score+=1000;
    ghost.resetGhost();
  }
  if (frightendModeOn && ghost2.pos.x == pacman.x && ghost2.pos.y == pacman.y) {
    score+=1000;
    ghost2.resetGhost();
  }
}

void win() {
  if (level == 5) {
    background(0);
    fill(255);
    text("YOU WIN!", width/2-50, height/2);
    text("YOUR SCORE: " + score, width/2-100, height/2+40);
    if (score > highscore) {
      highscoreSaver = str(score);
      list = split(highscoreSaver, ' ');
      try {
        saveStrings("highscore.txt", list);
      }
      catch (Exception e) {
        println("Speichern fehlgeschlagen!");
      }
    }
  }
}

void loadHighscore() {
  try {
    String[] lines = loadStrings("highscore.txt");
    highscore = Integer.parseInt(lines[0]);
  }
  catch(Exception ea) {
    println("Highscore konnte nicht geladen werden!");
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    pacman.animRight = true;
    pacman.animLeft = false;
    pacman.animUp = false;
    pacman.animDown = false;
    pacman.isRightBlocked(pacman.x, pacman.y);
    pacman.moveRight();
    pacman.goRight = true;
  }
  if (keyCode == LEFT) {
    pacman.animLeft = true;
    pacman.animRight = false;
    pacman.animUp = false;
    pacman.animDown = false;
    pacman.isLeftBlocked(pacman.x, pacman.y);
    pacman.moveLeft();
    pacman.goLeft = true;
  }
  if (keyCode == UP) {
    pacman.animUp = true;
    pacman.animRight = false;
    pacman.animLeft = false;
    pacman.animDown = false;
    pacman.isUpBlocked(pacman.x, pacman.y);
    pacman.moveUp();
    pacman.goUp = true;
  }
  if (keyCode == DOWN) {
    pacman.animDown = true;
    pacman.animRight = false;
    pacman.animLeft = false;
    pacman.animUp = false;
    pacman.isDownBlocked(pacman.x, pacman.y);
    pacman.moveDown();
    pacman.goDown = true;
  }
}
