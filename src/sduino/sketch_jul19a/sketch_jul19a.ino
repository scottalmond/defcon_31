// Constants
const int NUM_LEDS = 10;         // Total number of LEDs
const int INITIAL_SPEED = 1000;   // Initial speed of light movement (in milliseconds)
const int SPEED_INCREMENT = 100; // Speed increment when button pressed (in milliseconds)
const int TARGET_LED = 3;

// Variables
uint32_t start_ms = 0;                 // Start time of the current level
uint8_t current_led = 0;              // Currently cycling LED
uint32_t speed = 1000;        // Speed of light movement (in milliseconds)
uint16_t initial_speed = 1000; // Initial speed of light movement
uint32_t delay_ms = 0;

void flush_leds(uint8_t led_count) {
  // pushes the temporary values live to the periphreal
}

void set_rgb(uint8_t index, uint8_t color, uint8_t brightness) {
  // led_index[0-9], color[0-255], brightness[0-255]
  Serial_print_s("index = ");
  Serial_print_u(index);
  Serial_print_s(" color = ");
  Serial_print_u(color);
  Serial_print_s(" brightness = ");
  Serial_print_u(brightness);
  Serial_println();
}

void reset_leds() {
  //sets all rgb+white LEDs to 0 brightness
  Serial_print_s("reset_leds()");
  Serial_println();
}

bool is_button_pressed(bool is_left, bool is_short) {
  // isButtonPressed(true,true); returns true if the left button is pressed
  // for 0.05-2 seconds.  (true,false) returns true if left button has been pressed for >2 seconds.
  // so bool is_right=isButtonPressed(false,true) || isButtonPressed((false,false); is expected here
}

void handleButtonPress() {
  // using right button for cyclone; left is menu 
  if (!is_button_pressed(false, true)) {
    // Check if target LED is active
    if (current_led == TARGET_LED) {
      // Increase difficulty by decreasing speed
      speed -= SPEED_INCREMENT;
      if (speed < 0) {
        speed = 0;
      }
    } else {
      // Restart the game by resetting speed and start time
      speed = initial_speed;
      start_ms = millis();
    }
  }
}

void runCyclone()
{ 
  // Calculate delta time from level start
  uint32_t current_ms = millis();
  int32_t delta_time = current_ms - start_ms;

  if (current_ms - delay_ms >= speed) {
     delay_ms = current_ms;
       
  
  //if (current_ms - start_ms >= speed) {
     Serial_print_s("delta_time = ");
     Serial_print_u(delta_time);
     Serial_print_s(" current_ms = ");
     Serial_print_u(current_ms);
     Serial_print_s(" start_ms = ");
     Serial_print_u(start_ms);
     Serial_print_s(" speed = ");
     Serial_print_u(speed);
     Serial_println();
  
     // Compute position of the moving light
     uint8_t position = (delta_time / speed) % NUM_LEDS;

     Serial_print_s("curr pos = ");
     Serial_print_u(position);
  
     // Update current LED
     uint8_t current_led = position;
     uint8_t prev = position-1;
  
     // overflow
     if(prev > 9) prev = 0;

     Serial_print_s(" prev pos = ");
     Serial_print_u(prev);
     Serial_println();

     if (prev != TARGET_LED) {
        // turn off previous
        set_rgb(prev, 0, 0);
        set_rgb(prev, 0, 0);
        set_rgb(prev, 0, 0);
     }

     // turn on current
     set_rgb(current_led, 13, 255);
     set_rgb(current_led, 191, 255);
     set_rgb(current_led, 28, 255);
  
     // Red is 255,0,0
     set_rgb(TARGET_LED, 255, 255);
     set_rgb(TARGET_LED, 0, 255);
     set_rgb(TARGET_LED, 0, 255);
     flush_leds(NUM_LEDS);
  }
  //}
}

void setup() {
  // Initialize LED pins
  reset_leds();
  flush_leds(10);
    
  //set_rgb(u8 led_index, u8 rgb_index, u8 brightness);
  
  // Set initial start time
  start_ms = millis();
  delay_ms = millis();
  
  // Store the initial speed in a separate variable
  initial_speed = 1000;
  // put your setup code here, to run once:
  Serial_begin(9600);
}

void loop() {
   runCyclone();
}
