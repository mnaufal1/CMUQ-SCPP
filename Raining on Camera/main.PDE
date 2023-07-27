import processing.video.*;
Capture cam;
Capture camF;
int[] x = new int[100];
int[] y = new int[100];
color black;
int FPS = 30;

void setup() {
  size(640, 480);
  black = color(0, 0, 0);

  for (int i = 1; i < 100; i++) {
    x[i] = i * 10;
    y[i] = 0;
  }
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    cam = new Capture(this, 640, 480, cameras[0], FPS);
    camF = cam;
    cam.start();
    camF.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  fill(0, 0, 255);
  for (int i = 0; i < 100; i++) {
    if (((camF.get(x[i], y[i]+3) != black) || (cam.get(x[i], y[i]-10) == black))) {
      y[i] = y[i] + round(random(5));
    }
  }


  for (int i = 0; i < 100; i++) {
    ellipse(x[i], y[i], 10, 10);

    if (y[i] > 790) {
      y[i] = 0;
    }
  }
  camF.filter(THRESHOLD, 0.01);
}
