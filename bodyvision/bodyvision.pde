//Kevin Eloi (2022)

/* bodyvision
 * This program sends a String of data about
 * faces and hands on the screen.
 */

/* The following Processing libraries are required:
 * Processing.net
 */

//Summons the camera, alongside face and hands.
Camera camera;
Face face;
Hand hand;

//Makes Strings to hold together all data.
final public String[] Default = new String[4];
public String all = "";
public String facing = "";
public String handing = "";

//Makes Strings to capture and store individual data.
public int xFace = 0;
public int yFace = 0;
public int wFace = 0;
public int hFace = 0;
public int distFace = 0;
public int iterationFace = 0; //The current number face being displayed.
public int countFace = 0; //The total number of faces detected.

public int xHand = 0;
public int yHand = 0;
public int wHand = 0;
public int hHand = 0;
public int distHand = 0;
public int iterationHand = 0; //The current number hand being displayed.
public int countHand = 0; //The total number of hands detected.

//Determines if the camera is frozen or not, or if it is displayed.
public int blocker = 0;
public int player = 0;

//Imports needed libraries and creates a new Server.
import processing.net.*;
Server myServer;

/* setup()
 * Initializes all aspects of the program.
 */
public void setup() {
  //fullScreen();
  size(720, 450);
  surface.setTitle("Hand and Face Recognition");
  frameRate(30);
  noCursor();

  camera = new Camera(this);
  face = new Face(this);
  hand = new Hand(this);

  myServer = new Server(this, 5204);

  Default[0] = "xFace.yFace.wFace.hFace.distFace.iterationFace.countFace.xHand.yHand.wHand.hHand.distHand.iterationHand.countHand";
  Default[1] = "0.1.2.3.4.5.6.7.8.9.10.11.12.13";
  Default[2] = "x.y.w.h.dist.iteration.count";
  Default[3] = "0.1.2.3.4.5.6";
  print("\n" + Default[0] + "\n" + Default[1] + "\n\n");
}

/* detection()
 * Gets all data and puts them into Strings.
 */
public void detection() {
  face.detect();
  hand.detect();

  facing = face.getAll();
  handing = hand.getAll();
  all = facing + "." + handing;

  xFace = face.getX();
  yFace = face.getY();
  wFace = face.getW();
  hFace = face.getH();
  distFace = face.getDistance();
  countFace = face.getCount();
  iterationFace = face.getIteration();

  xHand = hand.getX();
  yHand = hand.getY();
  wHand = hand.getW();
  hHand = hand.getH();
  distHand = hand.getDistance();
  countHand = hand.getCount();
  iterationHand = hand.getIteration();
}

/* texting()
 * Displays all data Strings on screen.
 */
public void texting() {
  textSize(width/72);

  fill(0, 0, 255);
  text("All", 10, 20);

  fill(255, 0, 0);
  text(Default[0], 10, 40);
  text(Default[1], 10, 60);

  fill(0, 255, 0);
  text(all, 10, 80);

  fill(0, 0, 255);
  text("Face", 10, 120);

  fill(255, 0, 0);
  text(Default[2], 10, 140);
  text(Default[3], 10, 160);

  fill(0, 255, 0);
  text(facing, 10, 180);

  fill(0, 0, 255);
  text("Hand", 10, 220);

  fill(255, 0, 0);
  text(Default[2], 10, 240);
  text(Default[3], 10, 260);

  fill(0, 255, 0);
  text(handing, 10, 280);
}

/* mousePressed()
 * Takes a screenshot.
 * Precondition: Input from the mouse.
 */
public void mousePressed() {
  saveFrame("Images/####.png");
}

/* keyPressed()
 * Hides/unhides and/or freezes/unfreezes the camera,
 * or takes a screenshot.
 * Precondition: Input from the keyboard.
 */
public void keyPressed() {
  if (keyCode == ENTER) {
    if (player == 1) {
      player = 0;
    } else {
      player = 1;
    }
    camera.play(player);
  }

  if ((keyCode == DELETE) || (keyCode == BACKSPACE)) {
    if (blocker == 1) {
      blocker = 0;
      player = 0;
      camera.play(player);
    } else {
      blocker = 1;
      player = 1;
      camera.play(player);
    }
  }

  if ((keyCode != ENTER) && (keyCode != DELETE) && (keyCode != BACKSPACE)) {
    saveFrame("Images/####.png");
  }
}

/* draw()
 * Runs all methods and sends data to clients.
 */
public void draw() {
  background(0);
  camera.run(blocker);
  detection();
  texting();

  println(all);
  myServer.write(all);
}
