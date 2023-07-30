
#define RGB_LED_COUNT 10  //number of RGB LEDs around periphery
#define WHITE_LED_COUNT 12 //number of white ELDs on the Space SAO ONLY

void setup_serial(bool is_enabled,bool is_fast_baud_rate);
bool is_application_valid(void);
void setup_main(void);
u32 millis(void);
void set_matrix_high_z(void);
void set_rgb(u8 index,u8 color,u8 brightness);
void set_white(u8 index,u8 brightness);
void set_debug(u8 brightness);
u8 get_audio_sample(void);
void set_led(u8 index);
void flush_leds(u8 led_count);
//u16 get_val(u8 index);
void set_hue(u8 index,u16 color,u8 brightness);
bool is_application_valid(void);
bool is_developer_valid(void);
bool is_sleep_valid(void);
void update_buttons(void);
bool get_button_event(u8 button_index,bool is_long);
bool clear_button_event(u8 button_index,bool is_long);
void clear_button_events(void);
bool is_button_down(u8 index);
void update_audio(void);
bool is_space_sao(void);
u16 get_random(u16 x);
u8 get_audio_level(void);
void set_millis(u32 new_time);
u8 get_eeprom_byte(u16 address);