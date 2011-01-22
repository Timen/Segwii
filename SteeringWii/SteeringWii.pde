#include <WiiRemote.h>
#include <SPI.h>
#include <Max3421e.h>
#include <Usb.h>

WiiRemote wiiremote;

void setup()
{
  Serial.begin(9600);
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

 float y = wiiremote.Report.Accel.Y;
 Serial.print(y);
 Serial.print("\r\n");
}


// vim: sts=2 sw=2 ts=2 et cin
