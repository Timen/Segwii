// KasBot V1  -  Motors module

int Drive_Motor(int torque)  {
  if (torque >= 0)  {                                        // drive motors forward
    digitalWrite(InA_R, LOW);                        
    digitalWrite(InB_R, HIGH);
    digitalWrite(InA_L, LOW);                     
    digitalWrite(InB_L, HIGH);
  }  else {                                                  // drive motors backward
    digitalWrite(InA_R, HIGH);                       
    digitalWrite(InB_R, LOW);
    digitalWrite(InA_L, HIGH);                      
    digitalWrite(InB_L, LOW);
    torque = abs(torque);
  }
  if(torque>5) map(torque,0,255,30,255);
    analogWrite(PWM_R,torque * motorOffsetR);
    //Original value  
    //analogWrite(PWM_L,torque * .9);                            // motor are not built equal...
    analogWrite(PWM_L,torque * motorOffsetL); 
}

