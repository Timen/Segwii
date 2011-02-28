// KasBot V2  -  Motors module


int Drive_Motor(int torque)  {
  if (torque + turn >= 0)  {                                          // drive motors forward
    cr = 0;
    torque_R = torque + turn;
    if (torque - turn >= 0)  {                                        // drive motors forward
      cl = 4;
      torque_L = torque - turn;
    }  else  {
      cl = 5;
      torque_L = abs(torque - turn);
    }
  }  else {                                                           // drive motors backward
    cr = 1;
    torque_R = abs(torque + turn);
     if (torque - turn >= 0)  {                                       // drive motors forward
      cl = 4;
      torque_L = torque - turn;
    }  else  {
      cl = 5;
      torque_L = abs(torque - turn);
    }
 }
  torque_R = map(torque_R,0,255,10,127);
  torque_L = map(torque_L,0,255,10,127);
  torque_RD =(byte) constrain(torque_R, 10, 127);
  torque_LD =(byte) constrain(torque_L * motor_Offset, 10, 127);
  Driver();
}
 



void setupEncoder()  {
  pinMode(encodPinA1, INPUT); 
  pinMode(encodPinB1, INPUT); 
  digitalWrite(encodPinA1, HIGH);                      // turn on pullup resistor
  digitalWrite(encodPinB1, HIGH);
  attachInterrupt(3, rencoder, FALLING);
}

void rencoder()  {                                       // pulse and direction, direct port reading to save cycles
  if (PIND & 0b00000001)    count++;                     // if(digitalRead(encodPinB1)==HIGH)   count++   (on DI #21)
  else                      count--;        
}

void setupDriver(){
 Serial2.begin(19200);
 Serial2.write(170);
 delay(50);
 Serial2.write(128);
 Serial2.write(2);
 Serial2.write(21);
 Serial2.write((128 + 1 + 21) & 0x7f);
  
}

void Driver() {
   Serial2.write(adress);
 Serial2.write(cl);
 Serial2.write(torque_LD);
 Serial2.write((adress + cl + torque_LD) && 0x7f);
   Serial2.write(adress);
 Serial2.write(cr);
 Serial2.write(torque_RD);
 Serial2.write((adress + cr + torque_RD) && 0x7f);
}

