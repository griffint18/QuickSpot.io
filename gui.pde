// Written by Thomas Griffin
// Code used for changing a graphics user interface to update parking spot locations
// QuickSpot.io

import controlP5.*;
import processing.serial.*;

// establish the serial port
Serial port;

// variables for later use
String val;
int dist;

// establish the cp5
ControlP5 cp5;

// establish the font
PFont font;

// establish colors and variable for switch statement
color [] colors = new color[6]; 
int n = 1;

// change slot based on input from sensor, for now set to a constant 0
int slot = 4;

void setup() {
  
  // create the window
  size(600, 400);
  smooth();
  
  // choose the correct serial port
  printArray(Serial.list());
  port = new Serial(this, "COM11", 9600);
  
  // creates a ControlP5
  cp5 = new ControlP5(this);
  font = createFont("MS Gothic", 12);
}

void draw() {
  
  // set text font
  textFont(font);
  
  // make the text label "Sample Lot"
  background(255, 255, 255);
  textSize(16);
  text("Sample Lot", 300, 30);
  fill(0, 0, 0);
  textAlign(CENTER);
  
  // write in the labels
  for(int j = 1; j < 7; j++) {
    textSize(12);
    text(j, 125+(j*50), 140);
  }
  
  // draw the rectangles used as parking spots
  for(int i = 0; i < 6; i++) {
    stroke(1);
    fill(colors[i]);
    rect(155+(i*50), 150, 40, 80);
  }
  
  // if data is available
  if (port.available() > 0) {
    
    // read it and store it in val
    val = port.readStringUntil('\n');

    // deal with conversion of string in the serial port to integer, deal with cathing errors in case there is a non-int
    String st = trim(val);
    try {
      dist = Integer.parseInt(st);
    } catch(NumberFormatException ex) {
      System.out.println("Not an integer");
    }
    
    // actually change the display of the parking spot to see if it's taken
    if(dist > 1500) {
      switch(n) {
        case 1:
          // green color
          colors[slot] = color(66,244,116);
          n = 2;
          break;     
      } 
    } 
    
    else if(dist <= 1500) {
      switch(n) {
        case 2:
          // red color
          colors[slot] = color(244, 66, 66);
          n = 1;
          break; 
      }
    }
  } 
  
  // print value out in console
  println(val);
}
