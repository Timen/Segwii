// //Segwii V1.3  -  PID module

#define   GUARD_GAIN   10.0                // 20.0

float K = 1.9 ;      // wheels 100mm
float Kp = 14.01;    //16.37                       
float Ki = 1.0;                        
float Kd = -13.30; //-7.23      
float Kp_Wheel = 0.84;   
float Kd_Wheel = 27;
float vrSpeed = 0.0;
float last_vrSpeed=0.0;
float last_error = 0;
float integrated_error = 0;
float pTerm=0, iTerm=0, dTerm=0, pTerm_Wheel=0, dTerm_Wheel=0;

int updatePid(float targetPosition, float currentPosition)   {
  float error = targetPosition - currentPosition; 
  pTerm = Kp * error;
  integrated_error += error;                                       
  iTerm = Ki * constrain(integrated_error, -GUARD_GAIN, GUARD_GAIN);
  dTerm = Kd * (error - last_error);                            
  last_error = error;
  
    vrSpeed = count + control;
    vrSpeed = (vrSpeed / 100);  
    vrSpeed = vrSpeed * 15.5;         

    pTerm_Wheel = vrSpeed * Kp_Wheel;                       
    dTerm_Wheel = (vrSpeed - last_vrSpeed) * Kd_Wheel;    
    
    last_vrSpeed = vrSpeed;                        
    
    vrSpeed = 0.0;                              

  return -constrain(K*(pTerm + iTerm + dTerm+ pTerm_Wheel + dTerm_Wheel), -255, 255);
}
