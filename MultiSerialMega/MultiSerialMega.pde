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
 #include <LiquidCrystal.h>
 
byte  oldx, oldy;
byte  error=10;
byte  a = 0;
byte b = 0;
LiquidCrystal lcd(35, 33, 31, 29, 27, 25, 23);

void setup() {
  // initialize both serial ports:
  Serial.begin(115200);
  Serial1.begin(115200);
   setupLCD();
   LCD();
}

void loop() {
  if (b == 0){
   if (Serial1.available()){
    b = 1;
       lcd.clear();                  // start with a blank screen
  lcd.setCursor(0,1);           // set cursor to column 0, row 1
  lcd.print("Operating..");
   } 
  }
  
  if (b == 1){
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
  
  if (a == 0){
          oldx=dataByte_2;
          oldy=dataByte_1;
  }
  
  if (controlByte == 'd'){
      if (checksum == ((dataByte_2+ dataByte_1)&& 0b01111111)){
      dataByte_2 = constrain(dataByte_2, 0, 40);                                
      dataByte_1 = constrain(dataByte_1, 0, 40);
        if (abs(dataByte_2 - oldx)>= error || abs(dataByte_1 - oldy)>= error) {a=0; return;}
        else{ 
              Serial.print(dataByte_2, DEC);
              Serial.println(dataByte_1, DEC);
              oldx=dataByte_2;
              oldy=dataByte_1;
              a = 1;
          }
      }
   }
delay(1);
}
}
