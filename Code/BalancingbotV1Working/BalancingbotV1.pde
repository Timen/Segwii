// BalancingbotV1  -  Main module       basic version, angles in Quids, 10 bit ADC
//
#include <LiquidCrystal.h>
#include <math.h>
#define encodPinA1              3                              // encoder A right motor pin (Yellow)
#define encodPinB1              4      
#define   GYR_Y                 0                              // Gyro Y (IMU pin #4)
#define   ACC_Z                 1                              // Acc  Z (IMU pin #7)
#define   ACC_X                 2                              // Acc  X (IMU pin #9)
#define   PWM_R                 9                            // PWM right motor pin
#define   PWM_L                 10                               // PWM left motor pin
#define   Dir_R                 12                              // INB right motor pin
#define   Dir_L                 13                              // INA left motor pin


           
long count = 0, last_count = 0;

int sensorValue[3]  = { 0, 0, 0};
int sensorZero[3]  = { 0, 0, 0 }; 

int STD_LOOP_TIME  = 9, lastLoopTime = STD_LOOP_TIME, lastLoopUsefulTime = STD_LOOP_TIME, 
ACC_angle, GYRO_rate,
turn, torque_R, torque_L, 
error = 0;

unsigned long loopStartTime = 0;

float setPoint = 0, drive = 0, 
control = 0, controltmp = 0, 
actAngle; // angles in QUIDS (360° = 2PI = 1204 QUIDS   <<<

byte b = 0, com, K_map = 20, oldcom = 6;

LiquidCrystal lcd(35, 33, 31, 29, 27, 25, 23);

void setup() {
  setupLCD();
    com = 1;
  LCD();
  delay (500);
  Serial1.begin(115200);
  pinMode(21, OUTPUT);     
  analogReference(EXTERNAL);                                              // Aref 3.3V
  for(int pin=PWM_R; pin<=Dir_L; pin++)    pinMode(pin, OUTPUT);         // set output mode
  delay(100);            
  calibrateSensors();
    setupEncoder();
    com = 0;
}

void loop() {
// ********************* Sensor aquisition & filtering *******************
  LCD();
  getMotion();
  updateSensors();
  ACC_angle = getAccAngle();                                                 // in Quids
  GYRO_rate = getGyroRate();                                                 // in Quids/seconds
  actAngle = kalmanCalculate(ACC_angle, GYRO_rate, lastLoopTime);            // calculate Absolute Angle


// *********************** PID and motor drive *****************
  drive = updatePid(setPoint, actAngle);                                     // PID algorithm
  if(abs(actAngle-setPoint) < 100)                   Drive_Motor(drive); 
  else                                               Drive_Motor(0);         // stop motors if situation is hopeless
//************************update Serial***********************
              if (b == 1) {b = 0;}else {b = 1;}
              digitalWrite(21, b);
// *********************** loop timing control **************************
  lastLoopUsefulTime = millis()-loopStartTime;
  if(lastLoopUsefulTime<STD_LOOP_TIME)         delay(STD_LOOP_TIME-lastLoopUsefulTime);
  lastLoopTime = millis() - loopStartTime;
  loopStartTime = millis();
}
