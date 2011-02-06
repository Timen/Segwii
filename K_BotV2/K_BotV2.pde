// Segwii V1.3      basic, angles in Quids, 10 bit ADC

// History
// V1.3: Controls and sabertooth comms
// V1.2: Advanced balancing with encoders integrated
// V1: basic Blancing
#include <math.h>

#define   GYR_Y                 0                              // Gyro Y (IMU pin #4)
#define   ACC_Z                 1                              // Acc  Z (IMU pin #7)
#define   ACC_X                 2                              // Acc  X (IMU pin #9)
#define encodPinA1              30                              // encoder A right motor pin (Yellow)
#define encodPinB1              31                              // encoder B right motor pin (White)
//moter control variables
byte cr, cl;
byte adress = 128;
int torque_R;
int torque_L;
byte torque_RD;
byte torque_LD;
byte K_map = 20;
byte motor_Offset = 0;
//control variables
byte  oldx, oldy;
byte  error=10;
byte  a = 0;
int setPoint = 0;
int turn;
//Sensor data and processing variables
int   STD_LOOP_TIME  =          9;             
int sensorValue[3]  = { 0, 0, 0};
int sensorZero[3]  = { 0, 0, 0 }; 
int actAngle;                                                  // angles in QUIDS (360° = 2PI = 1204 QUIDS   <<<
int ACC_angle;
int GYRO_rate;
int drive = 0;
//loop time variables
long count = 0;
long last_count = 0;
int lastLoopTime = STD_LOOP_TIME;
int lastLoopUsefulTime = STD_LOOP_TIME;
unsigned long loopStartTime = 0;

void setup() {
  analogReference(EXTERNAL);                                             // Aref 3.3V
  // Serial.begin(115200);
  Serial1.begin(115200);
  setupEncoder();
  setupDriver();
  delay(2000);                                                
  calibrateSensors();
}

void loop() {
// ********************* Wiimote Data *******************************
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
