//Kevin Eloi (2022)

/* The following Processing libraries are required:
 * Video
 */

//Import necessary libraries.
import processing.video.Capture;

/* Camera
 * This class creates and displays a camera.
 */
public class Camera {
  //Gets new camera.
  Capture cam;
  
  //Measurements of the camera that are in millimeters.
  private final float focal; //Determines how strongly the camera converges or diverges light.
  private final float sensorW; //The physical width of the camera.
  private final float sensorH; //The physical height of the camera.
  
  //Measurements of the camera that are in pixels.
  private final int resW; //The number of horizontal pixels in the screen display.
  private final int resH; //The number of vertical pixels in the screen display.

  //Initializes and runs the camera.
  Camera (PApplet a) {
    focal = 50;
    sensorW = 25.4;
    sensorH = 25.4;
    resW = width;
    resH = height;
    
    cam = new Capture(a, resW, resH, "pipeline:autovideosrc");
    cam.start();
  }
  
  //Initializes and runs the camera.
  Camera (PApplet a, float f, float sw, float sh, int rw, int rh) {
    focal = f;
    sensorW = sw;
    sensorH = sh;
    resW = rw;
    resH = rh;
    
    cam = new Capture(a, resW, resH, "pipeline:autovideosrc");
    cam.start();
  }

  /* run()
   * Displays the camera on screen.
   * Precondition: An integer to determine if the
   * camera should be displayed on screen or not.
   */
  public void run(int x) {
    if (cam.available()) {
      cam.read();
    }

    if (x == 0) {
      image(cam, 0, 0);
    } else {
      background(0);
    }

    if (cam.width == 0) {
      return;
    }
  }

  /* plays()
   * Freezes and unfreezes the camera.
   * Precondition: An integer to determine whether to freeze
   * or unfreeze the camera.
   */
  public void play(int x) {
    if (x == 1) {
      println("\nCAMERA IS FROZEN. PRESS A KEY OR CLICK THE MOUSE TO UNFREEZE.");
      cam.stop();
    } else {
      println("\nCAMERA HAS BEEN UNFROZEN. PRESS A KEY OR CLICK THE MOUSE TO FREEZE.");
      cam.start();
    }
  }
  
  /* getFocal()
   * Precondition: Returns the focal value
   * of the camera in millimeters as a float.
   */
  public float getFocal() {
    return focal;
  }
  
  /* getSensorW()
   * Precondition: Returns the width of the
   * physical camera in millimeters as a float.
   */
  public float getSensorW() {
    return sensorW;
  }
  
  /* getSensorH()
   * Precondition: Returns the height of the
   * physical camera in millimeters as a float.
   */
  public float getSensorH() {
    return sensorH;
  }
  
  /* getResW()
   * Precondition: Returns the width of the
   * camera resolution in pixels as an integer.
   */
  public int getResW() {
    return resW;
  }
  
  /* getResH()
   * Precondition: Returns the height of the
   * camera resolution in pixels as an integer.
   */
  public int getResH() {
    return resH;
  }
}
