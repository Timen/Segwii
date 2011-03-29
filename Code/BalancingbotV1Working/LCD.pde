void setupLCD(){
lcd.begin(20, 4);
  lcd.setCursor(0,1);
  pinMode(6, OUTPUT);
  analogWrite(6, 90); 
}

void LCD(){
  if (com != oldcom)
  {
    lcd.clear();
  switch (com){
    case 0:
    lcd.setCursor(4,0);
    lcd.print("Hello User");
    lcd.setCursor(0,1);
    lcd.print("Please press 1 And 2");
    lcd.setCursor(1,2);
    lcd.print("on the Wiimote.");
    lcd.setCursor(0,3);
    lcd.print("Made by: Tijmen L.V.");
    break;
    case 1:
    lcd.setCursor(4,0);
    lcd.print("Booting");
    lcd.setCursor(4,1);
    lcd.print("just a sec..");
    lcd.setCursor(1,2);
    lcd.print(".................");
    lcd.setCursor(0,3);
    lcd.print("Made by: Tijmen L.V.");
    break;
    case 2:
    lcd.setCursor(5,0);
    lcd.print("Connected");
    lcd.setCursor(5,1);
    lcd.print("Have fun!");
    lcd.setCursor(1,2);
    lcd.print("tijmenlv@me.com");
    lcd.setCursor(0,3);
    lcd.print("Made by: Tijmen L.V.");
    break;
    case 3:
    lcd.setCursor(5,0);
    lcd.print("Warning ");
    lcd.setCursor(3,1);
    lcd.print("Battery Low");
    lcd.setCursor(1,2);
    lcd.print("Please Recharge!");
    lcd.setCursor(0,3);
    lcd.print("Made by: Tijmen L.V.");
    break;
  }
  oldcom = com;
  }  
}
