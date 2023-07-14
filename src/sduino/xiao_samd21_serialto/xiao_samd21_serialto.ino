// Code from https://wiki.seeedstudio.com/Seeeduino-XIAO-by-Nanase/
// This code will loopback the UART so that you can connect to another
// UART device
// Used this to talk to a STM8 Breakout Board on D5 and D6
void setup() {
  Serial.begin(9600);
  Serial1.begin(9600);
}

void loop() {
  if (Serial.available()) {
    char c = (char)Serial.read();
    Serial1.write(c);
  }

  if (Serial1.available()) {
    char c = (char)Serial1.read();
    Serial.write(c);
  }
}
