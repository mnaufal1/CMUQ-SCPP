boolean small = true;

void setup() {

  size(1000, 600);
  rect(50, 50, 850, 450);
  rect(20, 520, 910, 60);
  rect(30, 540, 890, 20);
  rect(50, 530, 40, 40);
  
}

void draw() {

  rect(930, 50, 40, 40);
  ellipse(950, 70, 10, 10);

  rect(930, 100, 40, 40);
  ellipse(950, 120, 40, 40);

  // draw
  if (small == true) {
    if (mousePressed == true) {
      if (mouseX > 55 && mouseX < 895 && mouseY > 55 && mouseY < 495) {
        ellipse(mouseX, mouseY, 10, 10);
      }
    }
  } else {
    if (mousePressed == true) {
      if (mouseX > 70 && mouseX < 880 && mouseY > 70 && mouseY < 480) {
        ellipse(mouseX, mouseY, 40, 40);
      }
    }
  }

  // clear
  if (mousePressed == true) {
    if (mouseX > 50 && mouseX < 890 && mouseY > 530 && mouseY < 570) {
      noStroke();
      rect(mouseX, 51, 10, 449);
      stroke(0, 0, 0);
      rect(20, 520, 910, 60);
      rect(30, 540, 890, 20);
      rect(mouseX-20, 530, 40, 40);
    }
  }

  // small circle
  if (mousePressed == true) {
    if (mouseX > 930 && mouseX < 970 && mouseY > 50 && mouseY < 90) {
      small = true;
    }
  }

  // large circle
  if (mousePressed == true) {
    if (mouseX > 930 && mouseX < 970 && mouseY > 100 && mouseY < 140) {
      small = false;
    }
  }
}
