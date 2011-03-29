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
int control,controltmp,setPoint,turn; 
byte b = 0;


void setup() {
  // initialize both serial ports:
  Serial.begin(115200);
  Serial1.begin(115200);
   pinMode(21, OUTPUT);     
  delay (2000);
}

void loop() {
  if(!Serial1.available())   return;        
  delay(1);
  byte controlByte = Serial1.read();              // get control byte
  if(!Serial1.available())      return;
  int dataByte_2 = Serial1.read();               // get data byte 2
  if(!Serial1.available())   return;
  int dataByte_1 = Serial1.read();               // get data byte 1
  if(!Serial1.available())    return;
  byte checksum = Serial1.read(); 
  Serial1.flush();  
  
     
  if (controlByte == 'd'){
      if (checksum == ((dataByte_2+ dataByte_1)&& 0b01111111)){
      dataByte_2 = constrain(dataByte_2, 0, 20);                                
      dataByte_1 = constrain(dataByte_1, 0, 20);
          setPoint = (dataByte_1 - 10)/4;     
          turn = (dataByte_2 - 10);
         controltmp =  (dataByte_1 - 10);
      }
   }
          control += controltmp;
              if (b == 1) {b = 0;}else {b = 1;}
              digitalWrite(21, b);
              delay (10);
}
