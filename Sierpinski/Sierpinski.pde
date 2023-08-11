//Kevin Eloi '24
//2024046@awhs.org
//A code modeling the Sierpinski Triangle!

//A dot will be drawn between the dot the user places and
//one of the three corner dots, chosen at random. Then, that dot
//will draw another dot between it and a corner dot, again chosen
//at random. Despite the heavily random nature of the code, it will
//always produce the same design.

//BUTTON CONTROLS
//ENTER — Freezes the application until it is closed.
//LEFT ARROW, A — Reduces the frame rate.
//RIGHT ARROW, D — Increases the frame rate.
//UP ARROW, W — Sets frame rate to 60.
//DOWN ARROW, S — Sets frame rate to 1.

PFont font1;
PFont font2;
PFont font3;
float r;
float b;
float g;
float selection;
int phase;
int x;
int y;
int time;
int multiply1;
int multiply2;
int currentTime;
int hasTimePassed;
int playlist;
int score;
int rate;

import processing.sound.*;
SoundFile song_1;
SoundFile song_2;

void setup(){
 frameRate(60);
 size(720,720);
 background(0);
 rectMode(CENTER);
 font1 = createFont("blocky.ttf", 100);
 font2 = createFont("blocky.ttf", 50);
 font3 = createFont("blocky.ttf", 25);
 song_1 = new SoundFile(this, "song_intro.mp3");
 song_2 = new SoundFile(this, "song_loop.mp3");
 playlist = 0;
 currentTime = second();
 hasTimePassed = currentTime;
 time = -1; //-1 999999998
 score = 0; //0 999999998
 multiply1 = 0;
 multiply2 = 0;
 r = 0;
 b = 0;
 g = 0;
 selection = 0;
 phase = 0;
 rate = 1;
 
 fill(5);
 triangle(360,90,90,630,630,630);
 
 stroke(255);
 strokeWeight(8);
 point(360,90); //top 0
 point(90,630); //left 1
 point(630,630); //right 2
}

void draw(){ 
  noCursor();
  
  if(keyPressed && keyCode == LEFT || keyPressed && key == 'a' ||  keyPressed && key == 'A'){
    if(rate > 1){
      rate = rate - 1;
    }
  }
  if(keyPressed && keyCode == RIGHT || keyPressed && key == 'd' || keyPressed && key == 'D'){
    if(rate < 60){
      rate = rate + 1;
    }
  }
  if(keyPressed && keyCode == UP || keyPressed && key == 'w' || keyPressed && key == 'W'){
    rate = 60;
  }
  if(keyPressed && keyCode == DOWN || keyPressed && key == 's' || keyPressed && key == 'S'){
    rate = 1;
  }
  
  if(phase == 0){
    noCursor();
    textAlign(CENTER);
    frameRate(60);
    
    background(0);
    fill(5);
    stroke(0);
    triangle(360,90,90,630,630,630);
    stroke(255);
    strokeWeight(8);
    point(360,90); //top 0
    point(90,630); //left 1
    point(630,630); //right 2
    
    fill(255);
    textFont(font2);
    textAlign(CENTER);
    text("PRESS THE MOUSE",360,700);
    textFont(font3);
    textAlign(RIGHT);
    text("FPS = " + rate,700,40);
    text("WASD + ARROW KEYS",700,70);
    textAlign(LEFT);
    text("PRESS ENTER/RETURN",20,40);
    text("TO FREEZE APPLICATION",20,70);
    textAlign(CENTER);
    
    textFont(font3);
    strokeWeight(1);
    if(mouseX != 360 || mouseY != 360){
      stroke(255,0,0);
    }
    if(mouseX == 360 && mouseY == 360){
      stroke(0,255,0);
    }
    
    if(mouseX == 360 && mouseY == 360){
      fill(5);
    }
    if(mouseX != 360 || mouseY != 360){
      fill(255);
    }
    
    if(mouseX > 359 && mouseY < 360){ //Q1
      text(mouseX + ", " + mouseY,mouseX - 60,mouseY + 25);
      line(mouseX,0,mouseX,720);
      line(0,mouseY,720,mouseY);
    }
    if(mouseX < 360 && mouseY < 360){ //Q2
      text(mouseX + ", " + mouseY,mouseX + 60,mouseY + 25);
      line(mouseX,0,mouseX,720);
      line(0,mouseY,720,mouseY);
    }
    if(mouseX < 360 && mouseY > 359){ //Q3
      text(mouseX + ", " + mouseY,mouseX + 60,mouseY - 10);
      line(mouseX,0,mouseX,720);
      line(0,mouseY,720,mouseY);
    }
    if(mouseX > 359 && mouseY > 359){ //Q4
      text(mouseX + ", " + mouseY,mouseX - 60,mouseY - 10);
      line(mouseX,0,mouseX,720);
      line(0,mouseY,720,mouseY);
    }
    
    if(mouseX == 360 && mouseY != 360){
      stroke(255,255,0);
      line(mouseX,0,mouseX,720);
      stroke(255,0,0);
      line(0,mouseY,720,mouseY);
    }
    if(mouseY == 360 && mouseX != 360){
      stroke(255,255,0);
      line(0,mouseY,720,mouseY);
      stroke(255,0,0);
      line(mouseX,0,mouseX,720);
    }
    
    strokeWeight(4);
    stroke(255);
    point(mouseX,mouseY);
    
    if(mousePressed){
      background(0);
      fill(5);
      stroke(0);
      triangle(360,90,90,630,630,630);
      stroke(255);
      strokeWeight(8);
      point(360,90); //top 0
      point(90,630); //left 1
      point(630,630); //right 2
      
      stroke(255);
      strokeWeight(4);
      x = mouseX;
      y = mouseY;
      point(x,y);
      print("Origin dot at X" + x + " Y" + y + "!");
      phase = 1;
      playlist = 1;
    }
  }
  
  if(phase == 1){
    frameRate(rate);
    fill(0);
    stroke(0);
    square(100,100,330);
    square(620,100,330);
    fill(255);
    
    noCursor();
    selection = random(3);
    r = random(255);
    b = random(1,254);
    g = random(255);
    stroke(r,b,g);
    strokeWeight(1);
    
    if(selection > 0 && selection < 1){
      y = (y + 90)/2;
      x = (x + 360)/2;
      point(x,y);
      score = score + 1;
    }
    
    if(selection > 1 && selection < 2){
      y = (y + 630)/2;
      x = (x + 90)/2;
      point(x,y);
      score = score + 1;
    }
    
    if(selection > 2 && selection < 3){
      y = (y + 630)/2;
      x = (x + 630)/2;
      point(x,y);
      score = score + 1;
    }
    
    if(selection == 0 || selection == 1 || selection == 2 || selection == 3){
      y = (y + 360)/2;
      x = (x + 360)/2;
      stroke(127);
      strokeWeight(4);
      point(x,y);
      print("Special dot at X" + x + " Y" + y + "!");
      score = score + 1;
    }
    stroke(0);
    
    currentTime = second();
    if(currentTime != hasTimePassed){
      time = time + 1;
      hasTimePassed = currentTime;
    }
    
    textAlign(RIGHT);
    textFont(font2);
    text("TIME",680,40);
    
    textAlign(RIGHT);
    if(time > -1 && time < 999){
      textFont(font1);
      text(time,680,100);
    }
    if(time > 998 && time < 9999999){
      textFont(font2);
      text(time,680,75);
    }
    if(time > 9999998){
      textFont(font3);
      text(time,680,100);
    }
    
    if(time > 999999998){
      time = 0;
      multiply1 = multiply1 + 1;
    }
    textFont(font3);
    if(multiply1 > 0){
      text("999999999 x "+ multiply1 + " +",680,125);
    }
    
    textFont(font2);
    textAlign(LEFT);
    text("SCORE",40,40);
    if(score > -1 && score < 999){
      textFont(font1);
      text(score,40,100);
    }
    if(score > 998 && score < 9999999){
      textFont(font2);
      text(score,40,75);
    }
    if(score > 9999998){
      textFont(font3);
      text(score,40,100);
    }
    
    if(score > 999999998){
      score = 0;
      multiply2 = multiply2 + 1;
    }
    textFont(font3);
    if(multiply2 > 0){
      text("+ 999999999 x "+multiply2,40,125);
    }
    
    if(playlist == 1){
      song_1.play();
      playlist = 2;
    }
    if(time == 25){
      playlist = 3;
    }
    if(playlist == 3){
      //song_1.stop();
      song_2.loop();
      playlist = 4;
    }
    
    fill(0);
    rect(360,700,720,70);
    fill(255);
    textFont(font3);
    textAlign(CENTER);
    text("FPS = " + rate,360,700);
    
    if(keyCode == ENTER){
      frameRate(1);
      fill(0);
      rect(360,700,720,50);
      textFont(font2);
      textAlign(CENTER);
      fill(255);
      text("RESET",360,700);
      frameRate(0);
    }
  }
}
