byte lspeed,rspeed;

void setup() {
  delay(2000);
 Serial1.begin(19200);
 Serial.write(170);
 delay(500);
 }
 

void loop() {
Serial1.write(128);
Serial1.write(1);
Serial1.write(lspeed);
Serial1.write((128 + 1 + lspeed) & 0x7f);
Serial1.write(128);
Serial1.write(5);
Serial1.write(rspeed);
Serial1.write((128 + 5 + rspeed) & 0x7f);
}
