
void getMotion() {
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
         int setPoint = -(dataByte_1 - 20)/2;          // get forward/backward motion byte
            if(abs(setPoint) > 2)  {
                count = 0;
                last_count = 0;
              }
            int turn = (dataByte_2 - 20);         
              oldx=dataByte_2;
              oldy=dataByte_1;
              a = 1;
          }
      }
   }
delay(1);
}


