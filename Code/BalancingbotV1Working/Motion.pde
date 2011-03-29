void getMotion() {
  if(!Serial1.available())   return;        
  byte controlByte = Serial1.read();              // get control byte
  if (controlByte == 'b'){
  com = 3;
  controltmp = 0;
  setPoint = 0;
  turn = 0;
  return;
  }
  
  if(!Serial1.available())      return;
  int dataByte_2 = Serial1.read();               // get data byte 2
  if(!Serial1.available())   return;
  int dataByte_1 = Serial1.read();               // get data byte 1
  if(!Serial1.available())    return;
  byte checksum = Serial1.read(); 
  Serial1.flush();  

     
  if (controlByte == 'd'){
      if (checksum == ((dataByte_2+ dataByte_1)&& 0b01111111)){
        com = 2;
      dataByte_2 = constrain(dataByte_2, 0, 20);                                
      dataByte_1 = constrain(dataByte_1, 0, 20);
          //setPoint = -(dataByte_1 - 10)/4;     
          turn = -(dataByte_2 - 10);
         controltmp =  -(dataByte_1 - 10);
      }
   }
          control += controltmp;
}

