#include <WiiRemote.h>
#include <SPI.h>
#include <Max3421e.h>
#include <Usb.h>


WiiRemote wiiremote;


void setup()
{
  Serial.begin(115200);
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
    static int Byte1_ant, Byte2_ant;
 float u = wiiremote.Report.Accel.Y;
 float k = wiiremote.Report.Accel.X;
   u = (u+1)*20;
   k = (k+1)*20;
     u = constrain(u, 0, 40);                                
     k = constrain(k, 0, 40);
 byte x = (byte) u;
 byte y = (byte) k;
  if((x!=Byte1_ant)||(y!=Byte2_ant))  {  
    Serial.print('d');   
      Serial.write(x);    
      Serial.write(y);
      Serial.write(x+y);
      Byte1_ant = x;
      Byte2_ant = y;
  }
}


// vim: sts=2 sw=2 ts=2 et cin
