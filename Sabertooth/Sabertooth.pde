byte lspeed,rspeed;

void setup() {
 delay(500);
 Serial2.begin(19200);
 Serial2.write(170);
 delay(50);
 Serial2.write(128);
 Serial2.write(2);
 Serial2.write(21);
 Serial2.write((128 + 1 + 21) && 0x7f);
 }
 

void loop() {
 Serial2.write(128);
 byte q = 0;
 Serial2.write(q);
 Serial2.write(127);
 Serial2.write((128 + 0 + 127) && 0x7f);
  Serial2.write(128);
 Serial2.write(4);
 Serial2.write(127);
 Serial2.write((128 + 4 + 127) && 0x7f);
}
