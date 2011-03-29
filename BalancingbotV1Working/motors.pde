// BalancingbotV1  -  Motors module V2

int Drive_Motor(int torque)  {
  if (torque + turn >= 0)  {                                          // drive motors forward
    digitalWrite(Dir_R, LOW);                        
    torque_R = torque + turn;
    if (torque - turn >= 0)  {                                        // drive motors forward
      digitalWrite(Dir_L, LOW);                    
      torque_L = torque - turn;
    }  else  {
      digitalWrite(Dir_L, HIGH);                      
      torque_L = abs(torque - turn);
    }
  }  else {                                                           // drive motors backward
    digitalWrite(Dir_R, HIGH);                      
    torque_R = abs(torque + turn);
     if (torque - turn >= 0)  {                                       // drive motors forward
      digitalWrite(Dir_L, LOW);                    
      torque_L = torque - turn;
    }  else  {
      digitalWrite(Dir_L, HIGH);                      
      torque_L = abs(torque - turn);
    }
 }
  torque_R = map(torque_R,0,255,K_map,255);
  torque_L = map(torque_L,0,255,K_map,255);
  torque_R = constrain(torque_R, 0, 255);
  torque_L = constrain(torque_L * 0.92, 0, 255);
  analogWrite(PWM_R,torque_R);
  analogWrite(PWM_L,torque_L * 0.92);                      // motors are not built equal...
}
 



void setupEncoder()  {
    pinMode(encodPinA1, INPUT); 
  pinMode(encodPinB1, INPUT); 
  digitalWrite(encodPinA1, HIGH);                      // turn on pullup resistor
  digitalWrite(encodPinB1, HIGH);
  attachInterrupt(1, rencoder, FALLING);
}

void rencoder()  {                                       // pulse and direction, direct port reading to save cycles
  if (PINE & 0b00010000)    count++;                     // if(digitalRead(encodPinB1)==HIGH)   count++   (on DI #3)
  else                      count--;        
}
