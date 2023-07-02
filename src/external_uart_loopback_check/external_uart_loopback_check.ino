/*
  Blink

  Turns an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino
  model, check the Technical Specs of your board at:
  https://www.arduino.cc/en/Main/Products

  modified 8 May 2014
  by Scott Fitzgerald
  modified 2 Sep 2016
  by Arturo Guadalupi
  modified 8 Sep 2016
  by Colby Newman

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/Blink
*/

//#include <SoftwareSerial.h>
//const byte rxPin = 2;
//const byte txPin = 3;


// Set up a new SoftwareSerial object
SoftwareSerial mySerial (rxPin, txPin);

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  //pinMode(1,INPUT);//0 is TX
  Serial.begin(9600);
  //while(!Serial){}
  //pinMode(rxPin, INPUT);
  //pinMode(txPin, OUTPUT);
  //mySerial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  //Serial1.println(millis(),DEC);
  int period=400;
  digitalWrite(LED_BUILTIN, millis()%period>(period/2));
  while(Serial.available()){ Serial.print("DEC: "); Serial.println(Serial.read(),DEC); }
  //digitalWrite(LED_BUILTIN,digitalRead(1));
  delay(400);
  //Serial.println(millis());
}
