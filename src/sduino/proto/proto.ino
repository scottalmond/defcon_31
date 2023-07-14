#define ledPin 5
#define lowPin 6

typedef uint16_t u16;
typedef uint8_t u8;

//sets all rgb+white LEDs to 0 brightness
void reset_leds() {
  
}

// pushes the temporary values live to the peripherial
void flush_leds() {
  
}

// led_index[0-9], rgb_index[0-2], brightness[0-255]
void setRGB(u8 led_index, u8 rgb_index, u8 brightness) {


}

void setup() {
  // put your setup code here, to run once:
  Serial_begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial_available() > 0){
    Serial_write(Serial_read());
  } 
}
