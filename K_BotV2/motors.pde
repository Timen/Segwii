// KasBot V2  -  Motors module
byte torque_R;
byte torque_L;
byte K_map = 20;
byte motor_Offset = 0;

int Drive_Motor(int torque)  {
  if (torque + turn >= 0)  {                                          // drive motors forward
    digitalWrite(InA_R, LOW);                        
    digitalWrite(InB_R, HIGH);
    torque_R = torque + turn;
    if (torque - turn >= 0)  {                                        // drive motors forward
      digitalWrite(InA_L, LOW);                    
      digitalWrite(InB_L, HIGH);
      torque_L = torque - turn;
    }  else  {
      digitalWrite(InA_L, HIGH);                      
      digitalWrite(InB_L, LOW);
      torque_L = abs(torque - turn);
    }
  }  else {                                                           // drive motors backward
    digitalWrite(InA_R, HIGH);                      
    digitalWrite(InB_R, LOW);
    torque_R = abs(torque + turn);
     if (torque - turn >= 0)  {                                       // drive motors forward
      digitalWrite(InA_L, LOW);                    
      digitalWrite(InB_L, HIGH);
      torque_L = torque - turn;
    }  else  {
      digitalWrite(InA_L, HIGH);                      
      digitalWrite(InB_L, LOW);
      torque_L = abs(torque - turn);
    }
 }
  torque_R = map(torque_R,0,255,K_map,255);
  torque_L = map(torque_L,0,255,K_map,255);
  torque_R = constrain(torque_R, 0, 255);
  torque_L = constrain(torque_L * motor_Offset, 0, 255);
  analogWrite(PWM_R,torque_R);
  analogWrite(PWM_L,torque_L * motor_Offset);                      // motors are not built equal...
}
 



void setupEncoder()  {
  pinMode(encodPinA1, INPUT); 
  pinMode(encodPinB1, INPUT); 
  digitalWrite(encodPinA1, HIGH);                      // turn on pullup resistor
  digitalWrite(encodPinB1, HIGH);
  attachInterrupt(1, rencoder, FALLING);
}

void rencoder()  {                                       // pulse and direction, direct port reading to save cycles
  if (PIND & 0b00000100)    count++;                     // if(digitalRead(encodPinB1)==HIGH)   count++   (on DI #2)
  else                      count--;        
}

