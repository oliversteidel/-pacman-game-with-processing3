class Point {

  float x, y;
  boolean alive = true;

  Point(float px, float py) {
    x = px;
    y = py;
  }

  void draw() {
    if (alive) {
      noStroke();
      fill(255);
      ellipse(x, y, 5, 5);
    }
  }
}
