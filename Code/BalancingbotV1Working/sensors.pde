// BalancingbotV1V1  -  Sensors Module

void calibrateSensors() {                                       // Set zero sensor values
  long v;
  for(int n=0; n<3; n++) {
    v = 0;
    for(int i=0; i<50; i++)       v += readSensor(n);
    sensorZero[n] = v/50;
  }                                                            //(618 - 413)/2 = 102.5    330/3.3 = x/1024
  sensorZero[ACC_Z] -= 102;                                    // Sensor position: horizontal, upward
}

void updateSensors() {                                         // data acquisition
  long v;
  for(int n=0; n<3; n++) {
    v = 0;
    for(int i=0; i<5; i++)       v += readSensor(n);
    sensorValue[n] = v/5 - sensorZero[n];
  }
}

int readSensor(int channel){
  return (analogRead(channel));
}

int getGyroRate() {                                             // ARef=3.3V, Gyro sensitivity=2mV/(deg/sec)
  return int(sensorValue[GYR_Y] * 4.583333333);                 // in quid/sec:(1024/360)/1024 * 3.3/0.002)
}

int getAccAngle() {                      
  return arctan2(-sensorValue[ACC_Z], -sensorValue[ACC_X]) + 256;  // in Quid: 1024/(2*PI))
}

int arctan2(int y, int x) {                                    // http://www.dspguru.com/comp.dsp/tricks/alg/fxdatan2.htm
   int coeff_1 = 128;                                          // angle in Quids (1024 Quids=360°) <<<<<<<<<<<<<<
   int coeff_2 = 3*coeff_1;
   float abs_y = abs(y)+1e-10;                                 // prevent 0/0 condition
   float r, angle;
   
   if (x >= 0) {
     r = (x - abs_y) / (x + abs_y);
     angle = coeff_1 - coeff_1 * r;
   }  else {
     r = (x + abs_y) / (abs_y - x);
     angle = coeff_2 - coeff_1 * r;
   }
   if (y < 0)      return int(-angle);                           // negate if in quad III or IV
   else            return int(angle);
}
 
