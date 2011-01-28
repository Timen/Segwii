int turn;

void getMotion() {
  if(!Serial1.available())      return;        
  delay(100);
  byte controlByte = Serial1.read();              // get control byte
  if(!Serial1.available())      return;
  int dataByte_1 = Serial1.read();               // get data byte 1
  if(!Serial1.available())      return;
  int dataByte_2 = Serial1.read();               // get data byte 2 
  
  Serial.print(controlByte);  
  Serial.print(dataByte_1);
  Serial.print(dataByte_2);
  Serial.print(millis());
  Serial.print("\r\n");
  
  if(controlByte == 'd')   {                    // Nunchuk joystick data
    setPoint = -(dataByte_1 - 20)/2;          // get forward/backward motion byte
    if(abs(setPoint) > 2)  {
      count = 0;
      last_count = 0;
    }
    turn = (dataByte_2 - 20);                   // get right/left motion byte
  }
} 


