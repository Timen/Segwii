#include <LiquidCrystal.h>
#include <Wire.h>
int com;
int x = 0;
int y = 1;
int i;
int tot;
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(2, 3, 4, 9, 10, 11, 12);

void setup() {
  lcd.begin(20, 4);
  lcd.print("hello, world!");
  pinMode(5, OUTPUT);
  analogWrite(5, 90);
  Wire.begin(4);                // join i2c bus with address #4
  Wire.onReceive(receiveEvent); // register event
}

void loop()
{
  delay(1);
}

// function that executes whenever data is received from master
// this function is registered as an event, see setup()
void receiveEvent(int howMany)
{
  com = Wire.receive();
  tot = Wire.available();
  int data[tot];
  for (i = 0; i < tot; i += 1) {
   data[i] = Wire.receive();
  }
  switch (com) {
    case 1: 
      lcd.setCursor(0,0);
      lcd.print("Booting");
    break;
    case 2:
      lcd.setCursor(0,0);
      lcd.print("Calibrating");
      lcd.setCursor(0,1);
      lcd.print("Wait 5 seconds");
      lcd.setCursor(0,2);
      lcd.print(millis()/1000);
    break;
    case 3:
      lcd.setCursor(0,0);
      lcd.print("Debug info");
      lcd.setCursor(0,1);
      lcd.print("x = ");
      lcd.setCursor(3,1);
      lcd.print(data[x]);
      lcd.setCursor(0,2);
      lcd.print("y = ");
      lcd.setCursor(3,2);
      lcd.print(data[y]);
      lcd.setCursor(0, 3);
      lcd.print("Time past:");
      lcd.print(millis()/1000);
    break;
    default: 
     lcd.setCursor(0,0);
     lcd.print("Connection Lost");
  }
}


