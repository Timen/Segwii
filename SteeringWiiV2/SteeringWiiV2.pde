#include <WiiRemote.h>
#include <SPI.h>
#include <Max3421e.h>
#include <Usb.h>

 int a = 0;
 byte level = 0;

WiiRemote wiiremote;


void setup()
{
  delay (5000);
  Serial.begin(115200);

  pinMode(2, INPUT);
  pinMode(A1, OUTPUT);     
  digitalWrite(A1, LOW);
  pinMode(A0, INPUT);  
   attachInterrupt(0, toggle, CHANGE);
  wiiremote.init();
  unsigned char wiiremote_bdaddr[6] = {0x00, 0x27, 0x09, 0x6E, 0xFB, 0xAA};
  wiiremote.setBDAddress(wiiremote_bdaddr, 6);
  wiiremote.setBDAddressMode(BD_ADDR_FIXED);
}

void loop()
{
  wiiremote.task(&myapp);
}


void myapp(void) {

byte adr = 'd';
  static int Byte1_ant, Byte2_ant;
 float u = wiiremote.Report.Accel.Y;
 float k = wiiremote.Report.Accel.X;
   u = (u+1)*10;
   k = (k+1)*10;
     u = constrain(u, 0, 20);                                
     k = constrain(k, 0, 20);
 byte x = (byte) u;
 byte y = (byte) k;
 
  if (analogRead(A0) <= 720){ //lithium cutoff connect balancer pin 1 to AI#2
  level = 1;
 }
 
 if (level == 0){
 if (a == 1) {
      Serial.write(adr);   
      Serial.write(x);    
      Serial.write(y);
      Serial.write((x+y)&& 0b01111111);

      Byte1_ant = x;
      Byte2_ant = y;
      a = 0;
  }
 }
 
 else{ 
   if (a == 1) {
      Serial.write('b');   
      Serial.write(10);    
      Serial.write(10);
      Serial.write((20)&& 0b01111111);

   }
 }
}

void toggle(){
a = 1;
}


