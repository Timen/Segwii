//BalancingbotV1 LCDV1
void setupLCD(){
   pinMode(6, OUTPUT);
  analogWrite(6, 90);
  lcd.begin(20,4); 
}

void LCD() {
   lcd.clear();                  // start with a blank screen
  lcd.setCursor(0,0);           // set cursor to column 0, row 0 (the first row)
  lcd.print("Hello, Operator");    // change this text to whatever you like. keep it clean.
  lcd.setCursor(0,1);           // set cursor to column 0, row 1
  lcd.print("Please press 1 AND 2");
    lcd.setCursor(0,2);           // set cursor to column 0, row 1
  lcd.print("on the Wiimote.");
}

void Oper() {
   lcd.clear();                  // start with a blank screen
     lcd.setCursor(0,0);           // set cursor to column 0, row 0 (the first row)
  lcd.print("Connected");  
  lcd.setCursor(0,1);           // set cursor to column 0, row 1
  lcd.print("Operating..");
    lcd.setCursor(0,2);           // set cursor to column 0, row 1
  lcd.print("Good luck!");
  con = 1;
}
