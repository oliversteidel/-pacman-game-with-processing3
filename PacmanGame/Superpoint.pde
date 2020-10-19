class Superpoint {
  float x,y;
  boolean alive;



  Superpoint(float px, float py) {
    x = px;
    y = py;
    alive = true;
  }
  
  void draw() {
    if (alive) {
      noStroke();
      fill(255);
      ellipse(x, y, 10, 10);
    }
  }
}
