import processing.video.*;

PImage camera;
PImage img = createImage(960, 720, ARGB);
PImage pict;

PImage s1;
PImage s2;
PImage s3;
PImage s4;

int cX;
int cY;

int FPS = 30;

String filterss[] = new String[4];

Capture cam;

void setup() {
  size(1000, 820);
  fill(72, 72, 72);
  rect(0, 0, 1000, 820);
  fill(0, 0, 0);
  rect(700, 760, 50, 50);
  cX = round(random(100, 860));
  cY = round(random(100, 680));
  
  println(cX, cY);
  
  s1 = createImage(cX, cY, ARGB);
  s2 = createImage((960-cX), cY, ARGB);
  s3 = createImage(cX, (720-cY), ARGB);
  s4 = createImage((960-cX), (720-cY), ARGB);
  
  pict = loadImage("mountain.jpeg");
  
  ///camera
  String[] cameras = Capture.list();
  cam = new Capture(this, 960, 720, cameras[0], FPS);
  cam.start();
  
  camera = loadImage("camera.png");
  image(camera, 460, 760, 80, 50);

}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 20, 20, 960, 720);
  
  /// Take a pic button
  if ((mousePressed == true) && (mouseX > 460 && mouseX < 540 && mouseY > 760 && mouseY < 810)) {
    img.loadPixels();
    for (int y = 0; y < 720; y++) {
      for (int x = 0; x < 960; x++) {
        img.pixels[(y)*960 + (x)] = get(x+20, y+20);
      }
    }
    img.updatePixels();
    takePic();
  }
  
  /// Reset to mountain image
  if ((mousePressed == true) && (mouseX > 700 && mouseX < 750 && mouseY > 760 && mouseY < 810)) {
    img = pict;
    takePic();
  }
}

void takePic() {
  noLoop();
  
  //s1
  s1.loadPixels();
  for (int y = 0; y < cY; y++) {
    for (int x = 0; x < cX; x++) {
      s1.pixels[(y)*cX + (x)] = img.get(x, y);
    }
  }
  s1.updatePixels();
  s1.filter(THRESHOLD);
  image(s1, 20, 20);
  
  //s2
  s2.loadPixels();
  for (int y = 0; y < cY; y++) {
    for (int x = cX; x < 960; x++) {
      s2.pixels[(y)*(960-cX) + (x-cX)] = img.get(x, y);
    }
  }
  s2.updatePixels();
  s2.filter(GRAY);
  image(s2, cX+20, 20);
  
  //s3
  s3.loadPixels();
  for (int y = cY; y < 720; y++) {
    for (int x = 0; x < cX; x++) {
      s3.pixels[(y-cY)*cX + (x)] = img.get(x, y);
    }
  }
  s3.updatePixels();
  s3.filter(INVERT);
  image(s3, 20, cY+20);
  
  //s4
  s4.loadPixels();
  for (int y = cY; y < 720; y++) {
    for (int x = cX; x < 960; x++) {
      s4.pixels[(y-cY)*(960-cX) + (x-cX)] = img.get(x, y);
    }
  }
  s4.updatePixels();
  s4.filter(BLUR, 7);
  image(s4, cX+20, cY+20);
  
  save("capture.jpg");
}

void keyPressed() {
  
  loop();
  cX = round(random(100, 860));
  cY = round(random(100, 680));
  
  s1 = createImage(cX, cY, ARGB);
  s2 = createImage((960-cX), cY, ARGB);
  s3 = createImage(cX, (720-cY), ARGB);
  s4 = createImage((960-cX), (720-cY), ARGB);
}
