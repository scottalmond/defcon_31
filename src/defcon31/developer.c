#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"


void run_developer()
{
	//setup(false);
	u8 iter=0;
	u32 old_sec=999;
	serial_setup(1,1000000);
	//Serial_print_string("START");
	//Serial_newline();
	//set_hue(iter,(u16)((millis())/8),255);
	while(!is_application_valid())
	{
		for(iter=0;iter<10;iter++)
		//iter=0;
		{
			//set_rgb(iter,0,millis()/512);
			set_hue(iter,(u16)(millis()*16+(0xFFFF/10)*iter),255);
			//set_hue(iter,(u16)((millis())/1),255);
			//set_hue(iter,(u16)(old_sec),255);
		}
		if(old_sec!=(millis()/100))
		{
			old_sec=millis()/100;
			//old_sec++;
			Serial_print_string("sec: ");
			Serial_print_int(millis()/1000);
			//Serial_print_int(old_sec);
			Serial_print_string(", [0]: ");
			Serial_print_int(get_val(0));
			Serial_print_string(", [1]: ");
			Serial_print_int(get_val(1));
			Serial_print_string(", [2]: ");
			Serial_print_int(get_val(2));
			Serial_print_string(", [3]: ");
			Serial_print_int(get_val(3));
			Serial_print_string(", [4]: ");
			Serial_print_int(get_val(4));
			Serial_print_string(", [5]: ");
			Serial_print_int(get_val(5));
			Serial_print_string(", [6]: ");
			Serial_print_int(get_val(6));
			Serial_print_string(", [7]: ");
			Serial_print_int(get_val(7));
			Serial_print_string(", [8]: ");
			Serial_print_int(get_val(8));
			Serial_print_string(", [9]: ");
			Serial_print_int(get_val(9));
			Serial_print_string(", [10]: ");
			Serial_print_int(get_val(10));
			Serial_newline();
			//set_rgb(old_sec%10,(old_sec/10)%3,255);
			//flush_leds(1);
		}
		//set_rgb(0,1,128);
		//set_rgb(1,0,128);
		/*set_rgb(2,1,255);
		set_rgb(3,2,255);
		set_rgb(4,1,255);
		set_rgb(5,0,255);
		set_rgb(6,1,255);
		set_rgb(7,2,255);
		set_rgb(8,1,255);
		set_rgb(9,0,255);*/
		//flush_leds(20);
		//set_rgb((millis()/100)%10,0,255);
		//set_rgb((millis()/300)%10,1,255);
		//set_rgb((millis()/500)%10,2,255);
		//flush_leds(3);
		flush_leds(20);
	}
	Serial_print_string("DONE");
	Serial_newline();
}