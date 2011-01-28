int skipOut=0;

void serialOut_GUI() {  
  
  if(skipOut++>=updateRate) {                                                        
    skipOut = 0;
    //Filtered and unfiltered angle
    Serial.print(ACC_angle, DEC);  Serial.print(",");
    Serial.print(actAngle, DEC);   Serial.print(",");
    
    //Raw sensor data
    Serial.print(sensorValue[ACC_X], DEC);   Serial.print(",");
    Serial.print(sensorValue[ACC_Z], DEC);   Serial.print(",");
    Serial.print(sensorValue[GYR_Y], DEC);   Serial.print(",");
   
    Serial.print(pTerm, DEC);      Serial.print(",");
    Serial.print(iTerm, DEC);      Serial.print(",");
    Serial.print(dTerm, DEC);      Serial.print(",");
    Serial.print(drive, DEC);      Serial.print(",");
    Serial.print(error, DEC);      Serial.print(",");
    Serial.print(setPoint, DEC);   Serial.print(",");
    
    //PID Parameters
    Serial.print(K, DEC);    Serial.print(",");
    Serial.print(Kp, DEC);   Serial.print(",");
    Serial.print(Ki, DEC);   Serial.print(",");
    Serial.print(Kd, DEC);   Serial.print(",");
    
    //loop
    Serial.print(STD_LOOP_TIME, DEC);        Serial.print(",");
    Serial.print(lastLoopUsefulTime, DEC);   Serial.print(",");
    Serial.print(lastLoopTime, DEC);         Serial.print(",");
    Serial.print(updateRate, DEC);           Serial.print(",");
    
    Serial.print(motorOffsetL, DEC);         Serial.print(",");
    Serial.print(motorOffsetR, DEC);         Serial.print("\n");
  }
}

union u_tag {
  byte b[4];
  float fval;
} u;

int skipIn=0;

void serialIn_GUI(){
  
  if(skipIn++>=updateRate) {                                                        
    skipIn = 0;
    byte id;
    
    if(Serial.available() > 0)
    {               
      char param = Serial.read(); 
      //Serial.println("Have bytes");
      delay(10);
      byte inByte[Serial.available()];
      if(Serial.read() == SPLIT){
        if(Serial.available() >= 4){
          u.b[3] = Serial.read(); 
          u.b[2] = Serial.read(); 
          u.b[1] = Serial.read(); 
          u.b[0] = Serial.read(); 
          Serial.flush();
          
          switch (param) {
            case 'p':
              Kp = int(u.fval);
              break;
            case 'i':
              Ki = int(u.fval);
              break;
            case 'd':
              Kd = int(u.fval);
              break;
            case 'k':
              K = u.fval;
              break;
            case 's':
              setPoint = int(u.fval);
              break;
            case 'u':
              updateRate = int(u.fval);
              break;
            case 'l':
              motorOffsetL = u.fval;
              break;
            case 'r':
              motorOffsetR = u.fval;
              break;
          }
        }
      }
      
    }
  }
}

void serialOut_raw() {
  static int skip=0;
  if(skip++==40) {                                                        
    skip = 0;
    Serial.print("ACC_X:");	Serial.print(sensorValue[ACC_X]);  
    Serial.print("  ACC_Z:");	Serial.print(sensorValue[ACC_Z]);
    Serial.print("  GYR_Y:");	Serial.println(sensorValue[GYR_Y]);
    
  }
}

void serialOut_timing() {

  static int skip=0;

  if(skip++==5) { // display every 500 ms (at 100 Hz)
    skip = 0;
    Serial.print(lastLoopUsefulTime); Serial.print(",");
    Serial.print(lastLoopTime); Serial.print("\n");
  }
}

/*
int getTuning() {
  if(!Serial.available())    return 0;
  delay(10);                  
  char param = Serial.read();                            // get parameter byte
  if(!Serial.available())    return 0;
  char cmd = Serial.read();                              // get command byte
  Serial.flush();
  switch (param) {
    case 'p':
      if(cmd=='+')    Kp++;
      if(cmd=='-')    Kp--;
      break;
    case 'i':
      if(cmd=='+')    Ki++;
      if(cmd=='-')    Ki--;
      break;
    case 'd':
      if(cmd=='+')    Kd++;
      if(cmd=='-')    Kd--;
      break;
    case 'k':
      if(cmd=='+')    K +=0.2;
      if(cmd=='-')    K -=0.2;
      break;
    default:
      Serial.print("?");           Serial.print(param);
      Serial.print(" ?");          Serial.println(cmd);
    }
  Serial.println();
  Serial.print("K:");           Serial.print(K);
  Serial.print("   Kp:");       Serial.print(Kp);
  Serial.print("   Ki:");       Serial.print(Ki);
  Serial.print("   Kd:");       Serial.println(Kd);
} */
