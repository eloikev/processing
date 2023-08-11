//Kevin Eloi (2022)

/* The following Processing libraries are required:
 * DeepVision
 */

//Import necessary libraries.
import ch.bildspur.vision.*;
import ch.bildspur.vision.result.*;

//Creates new DeepVision network.
DeepVision Vision;
SSDMobileNetwork Network;
ResultList<ObjectDetectionResult> Detections;

/* Hand
 * This class recognizes any hands in view of the camera
 * and draws a box around them.
 */
public class Hand {
  private ArrayList<Integer> x = new ArrayList<Integer>(10); //X value of hand.
  private ArrayList<Integer> y = new ArrayList<Integer>(10); //Y value of hand.
  private ArrayList<Integer> w = new ArrayList<Integer>(10); //Width of hand.
  private ArrayList<Integer> h = new ArrayList<Integer>(10); //Height of hand.
  private ArrayList<Integer> distance = new ArrayList<Integer>(10); //Distance between camera and hand.
  
  private final float avgSize; //The average size of a human hand, in millimeters.
  private int[] returning = new int[5]; //Return variable for methods.
  private int count; //Number of hands on screen.
  private int iteration; //Current hand on screen being analyzed.

  Hand(PApplet c) {
    //Initializes variables.
    avgSize = 182.88;
    count = 0;
    iteration = 0;
    
    x.add(0);
    y.add(0);
    w.add(0);
    h.add(0);
    distance.add(0);

    //Establishes DeepVision network.
    Vision = new DeepVision(c);
    Network = Vision.createHandDetector();
    Network.setup();
    Network.setConfidenceThreshold(0.5);
  }

  /* detect()
   * Detects hands on camera and draws a box around them.
   */
  public void detect() {
    //Detects any faces on screen.
    Detections = Network.run(camera.cam);

    //Establishes the look of the box.
    noFill();
    strokeWeight((width*height)/118400);
    stroke(0, 0, 255);
    
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

      //Creates a box around hands.
      for (ObjectDetectionResult Detection : Detections) {
        x.add((width - Detection.getX()) + (Detection.getWidth() / 2));
        y.add((Detection.getY()) + (Detection.getHeight() / 2));
        w.add(Detection.getWidth());
        h.add(Detection.getHeight());
        
        float dist = (avgSize * camera.getFocal() * camera.getResH()) / (camera.getSensorH() * Detection.getHeight());
        if (floor(dist) == 2147483647) {
          dist = 0.0;
        }
        distance.add(round(dist));
        
        count = Detections.size();
  
        rect(Detection.getX(), Detection.getY(), Detection.getWidth(), Detection.getHeight());
      }
    }

    //Determines which face is being analyzed.
    if (iteration < Detections.size()) {
      iteration++;
    } else {
      iteration = 1;
    }

    if (Detections.size() == 0) {
      count = 0;
      iteration = 0;
    }
  }

  /* getX()
   * Postcondition: The x value of the hand.
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
   * Postcondition: The y value of the hand.
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
   * Postcondition: The width of the hand.
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
   * Postcondition: The height of the hand.
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
   * Postcondition: The distance between the hand and camera,
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
   * Postcondition: The current hand being analyzed.
   */
  public int getIteration() {
    return iteration;
  }

  /* getCount()
   * Postcondition: The number of hands on screen.
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
