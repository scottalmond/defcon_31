#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"


void run_developer()
{
	//setup(false);
	u32 old_sec=999;
	serial_setup(1,1000000);
	Serial_print_string("START");
	Serial_newline();
	while(!is_application_valid())
	{
		if(old_sec!=(millis()/1000))
		{
			old_sec=millis()/1000;
			Serial_print_string("sec: ");
			Serial_print_int(millis()/1000);
			Serial_print_string(", [0]: ");
			Serial_print_int(get_val(0));
			Serial_print_string(", [1]: ");
			Serial_print_int(get_val(1));
			Serial_print_string(", [2]: ");
			Serial_print_int(get_val(2));
			Serial_print_string(", [3]: ");
			Serial_print_int(get_val(3));
			Serial_newline();
			//set_rgb(old_sec%10,(old_sec/10)%3,255);
			//flush_leds(1);
			/*if(old_sec%10==0)
			{
				set_rgb(0,1,255);
				set_rgb(1,0,255);
				set_rgb(2,1,255);
				set_rgb(3,2,255);
				set_rgb(4,1,255);
				set_rgb(5,0,255);
				set_rgb(6,1,255);
				set_rgb(7,2,255);
				set_rgb(8,1,255);
				set_rgb(9,0,255);
				flush_leds(10);
			}*/
		}
		set_rgb((millis()/100)%10,0,255);
		set_rgb((millis()/300)%10,1,255);
		set_rgb((millis()/500)%10,2,255);
		flush_leds(3);
	}
	Serial_print_string("DONE");
	Serial_newline();
}