//Kevin Eloi (2022)

/* The following Processing libraries are required:
 * DeepVision
 */

//Import necessary libraries.
import ch.bildspur.vision.*;
import ch.bildspur.vision.result.*;

//Creates new DeepVision network.
DeepVision vision;
ULFGFaceDetectionNetwork network;
ResultList<ObjectDetectionResult> detections;

/* Face
 * This class recognizes any faces in view of the camera
 * and draws a box around them.
 */
public class Face {
  private ArrayList<Integer> x = new ArrayList<Integer>(10); //X value of face.
  private ArrayList<Integer> y = new ArrayList<Integer>(10); //Y value of face.
  private ArrayList<Integer> w = new ArrayList<Integer>(10); //Width of face.
  private ArrayList<Integer> h = new ArrayList<Integer>(10); //Height of face.
  private ArrayList<Integer> distance = new ArrayList<Integer>(10); //Distance between camera and face.
  
  private final float avgSize; //The average size of a human face, in millimeters.
  private int[] returning = new int[5]; //Return variable for methods.
  private int count; //Number of faces on screen.
  private int iteration; //Current face on screen being analyzed.

  Face(PApplet b) {
    //Initializes variables.
    avgSize = 113.35;
    count = 0;
    iteration = 0;
    
    x.add(0);
    y.add(0);
    w.add(0);
    h.add(0);
    distance.add(0);

    //Establishes DeepVision network.
    vision = new DeepVision(b);
    network = vision.createULFGFaceDetectorRFB320();
    network.setup();
  }

  /* detect()
   * Detects faces on camera and draws a box around them.
   */
  public void detect() {
    //Detects any faces on screen.
    detections = network.run(camera.cam);

    //Establishes the look of the box.
    noFill();
    strokeWeight((width*height)/118400);
    stroke(255, 0, 0);

    //Gets data for the ArrayLists.
    if (iteration < 2) {
      //Clears the ArrayLists, then gives them a value at index zero.
      x.clear();
      x.add(0);
      y.clear();
      y.add(0);
      w.clear();
      w.add(0);
      h.clear();
      h.add(0);
      distance.clear();
      distance.add(0);
    
      //Creates a box around faces.
      for (ObjectDetectionResult detection : detections) {
        x.add((width - detection.getX()) + (detection.getWidth() / 2));
        y.add((detection.getY()) + (detection.getHeight() / 2));
        w.add(detection.getWidth());
        h.add(detection.getHeight());
        
        float dist = (avgSize * camera.getFocal() * camera.getResH()) / (camera.getSensorH() * detection.getHeight());
        if (floor(dist) == 2147483647) {
          dist = 0.0;
        }
        distance.add(round(dist));
        
        count = detections.size();
  
        rect(detection.getX(), detection.getY(), detection.getWidth(), detection.getHeight());
      }
    }

    //Determines which face is being analyzed.
    if (iteration < detections.size()) {
      iteration++;
    } else {
      iteration = 1;
    }

    if (detections.size() == 0) {
      count = 0;
      iteration = 0;
    }
  }

  /* getX()
   * Postcondition: The x value of the face.
   */
  public int getX() {
    try {
      returning[0] = x.get(iteration);
    } catch (IndexOutOfBoundsException x) {
      println("IndexOutOfBoundsException thrown for getX().");
    }
    
    return returning[0];
  }

  /* getY()
   * Postcondition: The y value of the face.
   */
  public int getY() {
    try {
      returning[1] = y.get(iteration);
    } catch (IndexOutOfBoundsException y) {
      println("IndexOutOfBoundsException thrown for getY().");
    }
    
    return returning[1];
  }

  /* getW()
   * Postcondition: The width of the face.
   */
  public int getW() {
    try {
      returning[2] = w.get(iteration);
    } catch (IndexOutOfBoundsException w) {
      println("IndexOutOfBoundsException thrown for getW().");
    }
    
    return returning[2];
  }

  /* getH()
   * Postcondition: The height of the face.
   */
  public int getH() {
    try {
      returning[3] = h.get(iteration);
    } catch (IndexOutOfBoundsException h) {
      println("IndexOutOfBoundsException thrown for getH().");
    }
    
    return returning[3];
  }

  /* getDistance()
   * Postcondition: The distance between the face and camera,
   * in millimeters.
   */
  public int getDistance() {
    try {
      returning[4] = distance.get(iteration);
    } catch (IndexOutOfBoundsException d) {
      println("IndexOutOfBoundsException thrown for getDistance().");
    }
    
    return returning[4];
  }

  /* getIteration()
   * Postcondition: The current face being analyzed.
   */
  public int getIteration() {
    return iteration;
  }

  /* getCount()
   * Postcondition: The number of faces on screen.
   */
  public int getCount() {
    return count;
  }

  /* getAll()
   * Converts all values into Strings and joins them together,
   * with each value separated by a period.
   * Postcondition: A String of all values.
   */
  public String getAll() {
    String s = "";
    String p = ".";
    
    s = str(getX()) + p + str(getY()) + p + str(getW()) + p + str(getH()) + p + str(getDistance()) + p + str(iteration) + p + str(count);
    return s;
  }
}
