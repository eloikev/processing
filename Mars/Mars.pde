float trans,transX,transY;

int pressing;

int cols, rows;
int scl = height/5; //20
int w = height*45; //4750
int h = height*19; //2000

float flying = 0;
float[][] terrain;

float rotX, rotY;
int rotUD, rotLR;
float R,G,B, r,g,b;
float sunY;
int prog;
float opacStar;

int[] x = new int[1000];
int[] y = new int[1000];
int C = -1;

void setup(){
  fullScreen(P3D);
  //size(1920,1080,P3D);
  //size(1440,900,P3D);
  //size(720,720,P3D);
  //size(100,100,P3D);
  
  noCursor();
  
  imageMode(CENTER);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  
  pressing = 0;
  
  rotX = 100;
  rotY = 10;
  rotUD = 0;
  rotLR = 0;
  
  trans = 0;
  transX = 0;
  transY = 0;
  
  sunY = width/5;
  opacStar = 0;
  
  R = 179;
  G = 141;
  B = 105;
  
  r = 176;
  g = 103;
  b = 63;
  
  for(int i = 0; i< x.length; i ++){
    x[i] = floor(random(-width*5,width*5)); y[i] = floor(random(-height*5,height*5));
  }
  
  prog = 0;
}

void draw(){
  background(R,G,B);  noStroke(); lights();
  
  trans = trans + 0.01;
  transX = floor(random(0,1)) + noise(trans); transY = floor(random(0,2)) + noise(trans); 
  transX = map(transX,0,1,-10,10); transY = map(transX,0,1,-10,10);
  
  
  if(transX < -10){
    transX = -10;
  }
  if(transX > 10){
    transX = 10;
  }
  if(transY < -10){
    transY = -10;
  }
  if(transY > 10){
    transY = 10;
  }
  
  translate(transX,transY,0);
  
  if(C == x.length){
    C = -1;
  }
  if(C >= 0){
    x[C] = floor(random(-width*5,width*5)); y[C] = floor(random(-height*5,height*5));
    
    C = C + 1;
  }
  
  push();
  translate(0,0,-height);
  translate(width/2,height/1.5,0);
  rotate(radians(rotY));
  translate(-width/2,-height/1.5,0);
  //image(sun, width/2, height/1.5 + rotUD*0.3);
  pop();
  
  for(int i = 0; i< x.length; i ++){
    strokeWeight(height/175); stroke(255,255,255,opacStar);
    point(x[i] + rotLR, y[i] + rotUD, -height); //-height/45
    noStroke();
  }

  flying = flying - 0.05;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff = xoff + 0.06;
    }
    yoff = yoff + 0.06;
  }

  translate(width/2, height/2+300);
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    fill(r,g,b,y*7);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  
  if(keyPressed && keyCode == LEFT || keyPressed && key == 'A' || keyPressed && key == 'a'){
    if(rotY >= -30){
      rotY = rotY - 0.5;
      rotLR = rotLR - 25;
    }
  }
  if(keyPressed && keyCode == RIGHT || keyPressed && key == 'D' || keyPressed && key == 'd'){
    if(rotY <= 30){
      rotY = rotY + 0.5;
      rotLR = rotLR + 25;
    }
  }
  if(keyPressed && keyCode == UP || keyPressed && key == 'W' || keyPressed && key == 'w'){
    if(rotX <= 100){
      rotX = rotX + 0.5;
      rotUD = rotUD + 25;
    }
  }
  if(keyPressed && keyCode == DOWN || keyPressed && key == 'S' || keyPressed && key == 's'){
    if(rotX >= 10){
      rotX = rotX - 0.5;
      rotUD = rotUD - 25;
    }
  }
  
  if(prog == 0){
    if(keyPressed && keyCode == ENTER){
      if(R > 59){
        R = R - 0.5;
      }
      if(G > 41){
        G = G - 0.5;
      }
      if(B > 27){
        B = B - 0.5;
      }
      
      if(r > 46){
        r = r - 0.5;
      }
      if(g > 29){
        g = g - 0.5;
      }
      if(b > 22){
        b = b - 0.5;
      }
      if(opacStar < 128){
        opacStar = opacStar + 0.5;
      }
      
      sunY = sunY + 5;
      
      if(R == 59 && G == 41 && B == 27
      && r == 46 && g == 29 && b == 22 && opacStar == 128){
        prog = 1;
      }
    }
  }
  
  if(prog == 1){
    if(keyPressed && keyCode == ENTER){
      if(R < 179){
        R = R + 0.5;
      }
      if(G < 141){
        G = G + 0.5;
      }
      if(B < 105){
        B = B + 0.5;
      }
      
      if(r < 176){
        r = r + 0.5;
      }
      if(g < 103){
        g = g + 0.5;
      }
      if(b < 63){
        b = b + 0.5;
      }
      if(opacStar > -0.5){
        opacStar = opacStar - 0.5;
      }
      
      sunY = sunY - 5;
      
      if(R == 179 && G == 141 && B == 105
      && r == 176 && g == 103 && b == 63 && opacStar <= 0){
        for(int i = 0; i< x.length; i ++){
          x[i] = floor(random(-width*5,width*5)); y[i] = floor(random(-height*5,height*5));
        }
        prog = 0;
      }
    }
  }
  
  println("W" + width + " H" + height + "; FPS = " + frameRate);
}
