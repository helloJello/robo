// This Arduino code controls three servo motors based on serial input commands received from an 
// external source, such as a computer running a Processing sketch. The servos are designated as tilt, 
// pan, and wheel, each controlled by specific channel IDs ('0', '1', and '2' respectively). 

#include <Servo.h>

char tiltChannel = '0', panChannel = '1', wheelChannel = '2'; // Add a new channel ID for the wheel
Servo servoTilt, servoPan, servoWheel; // Add a new Servo object for the wheel
char serialChar = 0;

void setup() {
  servoTilt.attach(2);  // The Tilt servo is attached to pin 2.
  servoPan.attach(3);   // The Pan servo is attached to pin 3.
  servoWheel.attach(4); // The new Wheel servo is attached to pin 4.
  servoTilt.write(90);  // Initially put the servos both at 90 degrees.
  servoPan.write(90);   // Initially put the servos both at 90 degrees.
  servoWheel.write(90); // Initially put the new servo at 90 degrees.
  Serial.begin(57600);  // Set up a serial connection for 57600 bps.
}

void loop() {
  while (Serial.available() > 0) {
    serialChar = Serial.read(); // Read the first character
    Serial.print("Received ID: ");
    Serial.println(serialChar); // Print received ID

    if (serialChar == tiltChannel) {
      while (Serial.available() <= 0); // Wait for the second command byte
      int tiltPosition = Serial.read();  // Read the tilt position
      Serial.print("Tilt Position: ");
      Serial.println(tiltPosition); // Print tilt position
      servoTilt.write(tiltPosition);
    } else if (serialChar == panChannel) {
      while (Serial.available() <= 0); // Wait for the second command byte
      int panPosition = Serial.read();   // Read the pan position
      Serial.print("Pan Position: ");
      Serial.println(panPosition); // Print pan position
      servoPan.write(panPosition);
    } else if (serialChar == wheelChannel) { // Check for the new wheel channel ID
      while (Serial.available() <= 0); // Wait for the second command byte
      int wheelPosition = Serial.read();   // Read the wheel position
      Serial.print("Wheel Position: ");
      Serial.println(wheelPosition); // Print wheel position
      servoWheel.write(wheelPosition);
    }
  }
}
