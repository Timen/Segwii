/*
  Mega multple serial test
 
 Receives from the main serial port, sends to the others. 
 Receives from serial port 1, sends to the main serial (Serial 0).
 
 This example works only on the Arduino Mega
 
 The circuit: 
 * Any serial device attached to Serial port 1
 * Serial monitor open on Serial port 0:
 
 created 30 Dec. 2008
 by Tom Igoe
 
 This example code is in the public domain.
 
 */


void setup() {
  // initialize both serial ports:
  Serial.begin(115200);
  Serial1.begin(115200);
}

void loop() {
  // read from port 1, send to port 0:
  byte x, y, a, c;
  if (Serial1.available()) {
      a = Serial1.read();
      if (a == 'd'){
        x = Serial1.read();
        y = Serial1.read();
        c = Serial1.read();
         Serial1.flush();
        if (c == (x+y)){
           x = constrain(x, 0, 40);                                
           y = constrain(y, 0, 40);
          Serial.print(x, DEC);

          Serial.println(y, DEC);
        }
    }
    else Serial1.flush();
  }
  delay(1);
}
