
void serial_setup(bool is_enabled,u32 baud_rate);
bool is_application_valid(void);
void setup(void);
u32 millis(void);
void set_matrix_high_z(void);
void set_rgb(u8 index,u8 color,u8 brightness);
void set_white(u8 index,u8 brightness);
void set_debug(u8 brightness);
u8 get_audio_sample(void);
void set_led(u8 index);
void flush_leds(u8 led_count);
u16 get_val(u8 index);