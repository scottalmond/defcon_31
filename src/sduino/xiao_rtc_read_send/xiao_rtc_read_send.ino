#include <Wire.h>
#include <RTClib.h>

const int buttonPin = 2;
const int ledPin = LED_BUILTIN; // On-board LED pin

RTC_DS3231 rtc;

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW); // Turn off the LED initially

  Wire.begin();
  rtc.begin();

  Serial.begin(57600);
}

void loop() {
  if (digitalRead(buttonPin) == LOW) {
    // Button is pressed, perform the task

    // Turn on the on-board LED
    digitalWrite(ledPin, HIGH);

    // Drive a digital output pin low (developer mode signal)
    // Replace 'outputPin' with the desired output pin number
    int outputPin = 3; // Example pin, choose an appropriate pin
    pinMode(outputPin, OUTPUT);
    digitalWrite(outputPin, LOW);

    // Read the time from the RTC
    DateTime now = rtc.now();
    long timeInMillis = now.unixtime() * 1000L;

    // Create the time string in the required format
    String timeString = "t " + String(timeInMillis) + "\n";

    // Transmit the time string over UART
    Serial.print(timeString);

    // Delay for a moment to indicate completion (optional)
    delay(100);

    // Disable the relay (float the developer mode pin)
    pinMode(outputPin, INPUT);

    // Turn off the on-board LED
    digitalWrite(ledPin, LOW);
  }
}
