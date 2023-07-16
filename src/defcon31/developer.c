#include "STM8s.h"

#include "api.h"
#include "stm8s103_serial.h"


void run_developer()
{
	u32 old_sec=999;
	serial_setup(1,1000000);
	Serial_print_string("START");
	Serial_newline();
	//setup(false);
	while(!is_application_valid())
	{
		if(old_sec!=(millis()/1000))
		{
			old_sec=millis()/1000;
			Serial_print_string("sec: ");
			Serial_print_int(millis()/1000);
			Serial_newline();
		}
	}
	Serial_print_string("DONE");
	Serial_newline();
}