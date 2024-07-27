// This Processing code interacts with an Arduino to control three servos: one for tilt, one for pan, 
// and a new one for a wheel, based on user input.

import processing.serial.*;

int xpos = 90; // set x servo's value to mid point (0-180)
int ypos = 90; // and the same here
int wheelPos = 90; // initial position for the new wheel servo
Serial port; // The serial port we will be using

void setup() {
  size(360, 360);
  frameRate(100);
  
  // List and print all available serial ports
  String[] portNames = Serial.list();
  println("Available serial ports:");
  for (int i = 0; i < portNames.length; i++) {
    println(i + ": " + portNames[i]);
  }
  
  // Select the correct device from the list
  int selectedPortIndex = 1; // Change this to match the correct port index
  port = new Serial(this, portNames[selectedPortIndex], 57600);
}

void draw() {
  fill(175);
  rect(0, 0, 360, 360);
  fill(255, 0, 0); // rgb value so RED
  rect(180, 175, mouseX - 180, 10); // xpos, ypos, width, height
  fill(0, 255, 0); // and GREEN
  rect(175, 180, 10, mouseY - 180);
  update(mouseX, mouseY);
}

void update(int x, int y) {
  // Calculate servo position from mouseX and mouseY
  xpos = constrain((360 - x) / 2, 0, 180); // Reverse xpos direction and ensure it is between 0 and 180
  ypos = constrain(y / 2, 0, 180); // Ensure ypos is between 0 and 180

  // Print data to the console for debugging
  println("Sending tilt ID: 0, Position: " + xpos);
  println("Sending pan ID: 1, Position: " + ypos);
  println("Sending wheel ID: 2, Position: " + wheelPos);

  // Send the tilt servo data (ID '0' followed by position)
  port.write('0'); // tiltChannel ID
  port.write(xpos);
  delay(50); // Small delay to ensure separation between messages

  // Send the pan servo data (ID '1' followed by position)
  port.write('1'); // panChannel ID
  port.write(ypos);
  delay(50); // Small delay to ensure separation between messages

  // Send the wheel servo data (ID '2' followed by position)
  port.write('2'); // wheelChannel ID
  port.write(wheelPos);
  delay(50); // Small delay to ensure separation between messages
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  wheelPos = constrain(wheelPos + (int)e * 5, 0, 180); // Adjust the wheel position based on mouse wheel input
}
