// This sketch draws a tree using two functions, i.e branch and threeLines
// branch function draws branches recursively by calling threeLines inside itself
// threeLines draws three lines based on the angle between them
// Base condition is checked using branch lengths
// pushMatrix & popMatrix are used (instead of rotation matrix) to preserve previous translation
// branch lengths are reduced at each recursive step
// branch lengths and angles between them are randomly varied using mouseY position

boolean click;
float theta;
float angle;
float Branchlen;
float subBranch1 = 80;
float subBranch2 = 20;
float strokeThick = 1;

void setup() {
  size(640, 480);
  background(255);
}

void draw() {
  background(255);

  if (mouseY >= 100 || mouseY <= 250) {
    Branchlen = mouseY;
    subBranch1 = 0.8*mouseY; // changing branch lengths
    subBranch2 = 0.8*mouseY;
    theta = (random(PI/4, PI/6)); // changing branch angles
    angle = (random(PI/4, PI/8));
  }

  translate(width/2, height); // moving origin to the middle bottom of the window
  branch(theta, angle, strokeThick, Branchlen, subBranch1, subBranch2);
}

void mousePressed() {
  click = true;
  saveFrame("task_6_recursion.tif");
}

void branch(float theta, float strokeThick, float angle, float BranchLen, float subBranch1, float subBranch2) {
  strokeWeight(strokeThick);
  threeLines(angle, BranchLen, subBranch1, subBranch2);

  BranchLen *= 0.66;
  subBranch1 *= 0.66;
  subBranch2 *= 0.66;
  strokeThick -= 0.1;

  if (BranchLen > 2 && subBranch2 >2 ) { // base condition
    pushMatrix();
    rotate(angle);
    branch(theta, angle, strokeThick, BranchLen, subBranch1, subBranch2); // right side recursive call
    popMatrix();

    pushMatrix();
    rotate(-angle);
    branch(theta, angle, strokeThick, BranchLen, subBranch1, subBranch2); // left side recursive call
    popMatrix();
  }
}

void threeLines(float theta, float BranchLen, float subBranch1, float subBranch2) {

  line(0, 0, 0, -BranchLen); // central branch
  translate(0, -BranchLen);
  pushMatrix();
  rotate(theta);
  line(0, 0, subBranch1, -subBranch2); // right branch
  popMatrix();

  pushMatrix();
  translate(0, 0);
  rotate(-theta);
  line(0, 0, -subBranch1, -subBranch2); // left branch
  popMatrix();
}
