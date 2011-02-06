
void getMotion() {
  if(!Serial1.available())   Serial1.flush();     return;        
  delay(1);
  byte controlByte = Serial1.read();              // get control byte
  if(!Serial1.available())  Serial1.flush();      return;
  int dataByte_2 = Serial1.read();               // get data byte 2
  if(!Serial1.available())  Serial1.flush();      return;
  int dataByte_1 = Serial1.read();               // get data byte 1
  if(!Serial1.available())  Serial1.flush();      return;
  int checksum = Serial1.read(); 
  Serial1.flush();  
  

  
  if(controlByte == 'd')   { 
    if(checksum == (dataByte_1+dataByte_2)){
      setPoint = -(dataByte_1 - 20)/2;          // get forward/backward motion byte
      if(abs(setPoint) > 2)  {
          count = 0;
          last_count = 0;
        }
      turn = (dataByte_2 - 20);                   // get right/left motion byte
    }
  }
} 


