import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.video.*;
Kinect kinect;
Body body;

float[] range = new float[3];
float rotY = 0;
int colormode = 0;

void setup() {
  fullScreen(P3D); //640, 480
  noCursor();
  kinect = new Kinect(this);
  kinect.initVideo();
  kinect.initDepth();
  body = new Body(this);

  strokeWeight(4);
  stroke(255);

  range[2] = 100;
  range[0] = 500 - range[2];
  range[1] = 500 + range[2];
}

void keyPressed() {
  if (keyCode == UP || key == 'W' || key == 'w') {
    colormode++;
    if (colormode > 2) {
      colormode = 0;
    }
  } else if (keyCode == DOWN || key == 'S' || key == 's') {
    colormode--;
    if (colormode < 0) {
      colormode = 2;
    }
  }
}

void coloring(int mode, int depth, int x, int y) {
  if (mode == 1) { //RGB
    color c = kinect.getVideoImage().get(x, y);
    stroke(c);
  } else if (mode == 2) { //RGB in black
    color c = kinect.getVideoImage().get(x, y);
    float r = red(c);
    float b = blue(c);
    float g = green(c);
    float w = (r + g + b) / 3;
    stroke(w);
  } else { //Whitescale
    float colour = map(depth, range[0], range[1], 255, 0);
    stroke(colour);
  }
}

void draw() {
  background(0);

  body.run();
  if (body.getDistFace() != 0) {
    range[0] = body.getDistFace() - range[2];
    range[1] = body.getDistFace() + range[2];
  }

  rotY += 0.025;
  translate(width/2, height/2, -200);
  //rotateY(rotY);
  translate(-width/2, -height/2, 200);

  int[] depth = kinect.getRawDepth();
  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y*kinect.width;
      int rawDepth = depth[offset];

      float newX = map(x, 1, kinect.width, 1, width);
      float newY = map(y, 1, kinect.height, 1, height);

      coloring(colormode, rawDepth, x, y);

      if (rawDepth >= range[0] && rawDepth <= range[1]) {
        point(newX, newY, -rawDepth*1.25);
      }
    }
  }
}
