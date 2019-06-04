// Written by Thomas Griffin
// Code used to communicated serial output with Processing GUI
// QuickPark.io

#include <SparkFun_RFD77402_Arduino_Library.h>
RFD77402 myDistance;

void setup() {
  // begins serial communication
  Serial.begin(9600);
  analogReference(DEFAULT);
  while (!Serial);

  // initializes the sensor and make sure it didn't fail
  if (myDistance.begin() == false) 
  {
    Serial.println("Sensor failed to initialize. Check wiring.");
    while (1);
  }
  Serial.println("Sensor online!");
}

void loop() {
  // tell sensor to take measurement and populate distance variable with measurement value
  myDistance.takeMeasurement();

  // retrieve the distance value
  unsigned int distance = myDistance.getDistance(); 
  Serial.flush();
  Serial.println(distance);

  if(Serial.available()) {
    char val = Serial.read();
  }
}
