// KasBot V2  -  PID module

#define   GUARD_GAIN   10.0                // 20.0

float K = 1.9 * 1.12;  // wheels 80mm
//float K = 1.9 ;      // wheels 100mm
float Kp = 7;                           
float Ki = 1;                        
float Kd = -6;       
float Kp_Wheel = -0.025;   
float Kd_Wheel = -8;

int last_error = 0;
int integrated_error = 0;
float pTerm=0, iTerm=0, dTerm=0, pTerm_Wheel=0, dTerm_Wheel=0;

int updatePid(int targetPosition, int currentPosition)   {
  int error = targetPosition - currentPosition; 
  pTerm = Kp * error;
  integrated_error += error;                                       
  iTerm = Ki * constrain(integrated_error, -GUARD_GAIN, GUARD_GAIN);
  dTerm = Kd * (error - last_error);                            
  last_error = error;
  pTerm_Wheel = Kp_Wheel * count;           //  -(Kxp/100) * count;
  dTerm_Wheel = Kd_Wheel * (count - last_count);                            
  last_count = count;
  return -constrain(K*(pTerm + iTerm + dTerm + pTerm_Wheel + dTerm_Wheel), -255, 255);
}

void setZeroIntegal() {
 integrated_error = 0; 
}
