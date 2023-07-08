#define ledPin 5
#define lowPin 6

typedef uint16_t u16;
typedef uint8_t u8;


u8 random() {
  srand(time(NULL));
  return rand() % 255;
}

// led_index[0-9], rgb_index[0-2], brightness[0-255]
void setRGB(u8 led_index, u8 rgb_index, u8 brightness) {

}

void flashMorseCode(const char* code, u16 dotDuration) {
  for (int i = 0; code[i] != '\0'; i++) {
    char c = code[i];

    if (c == '.') {
      digitalWrite(ledPin, HIGH);
      digitalWrite(lowPin, LOW);
      delay(dotDuration);
      digitalWrite(ledPin, LOW);
      digitalWrite(lowPin, LOW);
    } else if (c == '-') {
      digitalWrite(ledPin, HIGH);
      delay(dotDuration * 3);
      digitalWrite(ledPin, LOW);  
      digitalWrite(lowPin, LOW);
    } else if (c == ' ') {
      delay(dotDuration * 3);
    } else if (c == '/') {
      delay(dotDuration * 7);
    }

    delay(dotDuration);
  }
}


void setup() {
  pinMode(ledPin, OUTPUT);  // Set the LED pin as output
  pinMode(lowPin, OUTPUT);
}

void loop() {
  // S P A C E B I T S R U S
  // ... .--. .- -.-. . -... .. - ... .-. ..- ... 
  flashMorseCode("... .--. .- -.-. . -... .. - ... .-. ..- ...", 250);
  delay(2000);  // Wait for 2 seconds before repeating
}
