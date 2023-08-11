//Kevin Eloi (2022)

/* The following Processing libraries are required:
 * Processing.net
 */

//Imports needed libraries and creates a new Client.
import processing.net.*;
Client myClient;

/* Body
 * This class reads a String of data from
 * another program about faces and hands
 * on the screen.
 */
public class Body {
  private int xFace; //X value of face.
  private int yFace; //Y value of face.
  private int wFace; //Width of face.
  private int hFace; //Height of face.
  private int distFace; //Distance of face.
  private int iterationFace; //Number of faces on screen.
  private int countFace; //Current face on screen being analyzed.

  private int xHand; //X value of hand.
  private int yHand; //Y value of hand.
  private int wHand; //Width of hand.
  private int hHand; //Height of hand.
  private int distHand; //Distance of hand.
  private int iterationHand; //Number of hands on screen.
  private int countHand; //Current hand on screen being analyzed.

  private String host; //Address of the Server.
  private int port; //Port to read/write from on the Server.
  private boolean connection; //Determines if the Client has connected to the Server at least once.

  Body(PApplet d) {
    //Initializes variables to zero.
    xFace = 0;
    yFace = 0;
    wFace = 0;
    hFace = 0;
    distFace = 0;
    iterationFace = 0;
    countFace = 0;

    xHand = 0;
    yHand = 0;
    wHand = 0;
    hHand = 0;
    distHand = 0;
    iterationHand = 0;
    countHand = 0;

    //Establishes a connection with the Server.
    host = "127.0.0.1"; //127.0.0.1
    port = 5204; //5204
    connection = false;
    myClient = new Client(d, host, port);
  }

  Body(PApplet d, String Host, int Port) {
    //Initializes variables to zero.
    xFace = 0;
    yFace = 0;
    wFace = 0;
    hFace = 0;
    distFace = 0;
    iterationFace = 0;
    countFace = 0;

    xHand = 0;
    yHand = 0;
    wHand = 0;
    hHand = 0;
    distHand = 0;
    iterationHand = 0;
    countHand = 0;

    //Establishes a connection with the Server.
    host = Host;
    port = Port;
    connection = false;
    myClient = new Client(d, host, port);
  }

  /* run()
   * Splits the String given by the Server into
   * different int variables.
   */
  public void run() {
    /* The String sent from the Server means the following, and has this many slots:
     * xFace.yFace.wFace.hFace.areaFace.iterationFace.countFace.xHand.yHand.wHand.hHand.areaHand.iterationHand.countHand
     * 0.1.2.3.4.5.6.7.8.9.10.11.12.13
     */

    if (myClient.available() > 0) {
      //Connection stays true forever if the Client has connected to the Server at least once.
      connection = true;

      //The String from the server is read and split into a String array.
      String s = myClient.readString();
      String[] list = split(s, '.');

      //The String array is converted into an integer, and placed into different int variables.
      xFace = int(list[0]);
      yFace = int(list[1]);
      wFace = int(list[2]);
      hFace = int(list[3]);
      distFace = int(list[4]);
      iterationFace = int(list[5]);
      countFace = int(list[6]);

      xHand = int(list[7]);
      yHand = int(list[8]);
      wHand = int(list[9]);
      hHand = int(list[10]);
      distHand = int(list[11]);
      iterationHand = int(list[12]);
      countHand = int(list[13]);
    }
  }

  /* getXFace()
   * Postcondition: The x value of the face.
   */
  public int getXFace() {
    return xFace;
  }

  /* getYFace()
   * Postcondition: The y value of the face.
   */
  public int getYFace() {
    return yFace;
  }

  /* getWFace()
   * Postcondition: The width of the face.
   */
  public int getWFace() {
    return wFace;
  }

  /* getHFace()
   * Postcondition: The height of the face.
   */
  public int getHFace() {
    return hFace;
  }

  /* getAreaFace()
   * Postcondition: The area of the face.
   */
  public int getDistFace() {
    return distFace;
  }

  /* getIterationFace()
   * Postcondition: The current face being analyzed.
   */
  public int getIterationFace() {
    return iterationFace;
  }

  /* getCountFace()
   * Postcondition: The number of faces on screen.
   */
  public int getCountFace() {
    return countFace;
  }

  /* getXHand()
   * Postcondition: The x value of the hand.
   */
  public int getXHand() {
    return xHand;
  }

  /* getYHand()
   * Postcondition: The y value of the hand.
   */
  public int getYHand() {
    return yHand;
  }

  /* getWHand()
   * Postcondition: The width of the hand.
   */
  public int getWHand() {
    return wHand;
  }

  /* getHHand()
   * Postcondition: The height of the hand.
   */
  public int getHHand() {
    return hHand;
  }

  /* getAreaHand()
   * Postcondition: The area of the hand.
   */
  public int getDistHand() {
    return distHand;
  }

  /* getIterationHand()
   * Postcondition: The current hand being analyzed.
   */
  public int getIterationHand() {
    return iterationHand;
  }

  /* getCountHand()
   * Postcondition: The number of hands on screen.
   */
  public int getCountHand() {
    return countHand;
  }

  /* running()
   * Postcondition: A boolean variable declaring if
   * the Client had at least made a connection to the
   * Server once.
   */
  public boolean running() {
    return connection;
  }
}
