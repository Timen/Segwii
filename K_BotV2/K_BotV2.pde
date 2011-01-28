// KasBot V2  -  Main module       basic version, angles in Quids, 10 bit ADC

// History
// V2: encoders implementation
// V1: basic bot
#include <math.h>

#define   GYR_Y                 0                              // Gyro Y (IMU pin #4)
#define   ACC_Z                 1                              // Acc  Z (IMU pin #7)
#define   ACC_X                 2                              // Acc  X (IMU pin #9)

#define   InA_R                 4                              // INA right motor pin 
#define   InB_R                 5                              // INB right motor pin
#define   PWM_R                 10                             // PWM right motor pin
#define   InA_L                 8                              // INA left motor pin
#define   InB_L                 9                              // INB left motor pin
#define   PWM_L                 11                             // PWM left motor pin
#define encodPinA1              3                              // encoder A right motor pin (Yellow)
#define encodPinB1              2                              // encoder B right motor pin (White)

int   STD_LOOP_TIME  =          9;             

int sensorValue[3]  = { 0, 0, 0};
int sensorZero[3]  = { 0, 0, 0 }; 
int lastLoopTime = STD_LOOP_TIME;
int lastLoopUsefulTime = STD_LOOP_TIME;
unsigned long loopStartTime = 0;
int actAngle;                                                  // angles in QUIDS (360° = 2PI = 1204 QUIDS   <<<
int ACC_angle;
int GYRO_rate;
int setPoint = 0;
int drive = 0;
long count = 0;
long last_count = 0;

void setup() {
  analogReference(EXTERNAL);                                             // Aref 3.3V
  Serial.begin(115200);
  Serial1.begin(115200);
  for(int pin=InA_R; pin<=PWM_L; pin++)    pinMode(pin, OUTPUT);         // set output mode
  setupEncoder();
  delay(2000);                                                
  calibrateSensors();
}

void loop() {
// ********************* Get Xbee data *******************************
  getMotion();

// ********************* Sensor aquisition & filtering *******************
  updateSensors();
  ACC_angle = getAccAngle();                                                 // in Quids
  GYRO_rate = getGyroRate();                                                 // in Quids/seconds
  actAngle = kalmanCalculate(ACC_angle, GYRO_rate, lastLoopTime);            // calculate Absolute Angle

// *********************** Angle Control and motor drive *************
  drive = updatePid(setPoint, actAngle);            		        // PID algorithm

  if(abs(actAngle) < 100)    {
    Drive_Motor(drive);
  }  else {  
    Drive_Motor(0);                                                    // stop motors if situation is hopeless
   setZeroIntegal();                                               // reset PID Integral accumulaor
  }

// *********************** loop timing control **************************
  lastLoopUsefulTime = millis()-loopStartTime;
  if(lastLoopUsefulTime<STD_LOOP_TIME)         delay(STD_LOOP_TIME-lastLoopUsefulTime);
  lastLoopTime = millis() - loopStartTime;
  loopStartTime = millis();
}
