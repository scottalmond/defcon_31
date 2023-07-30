#include "STM8s.h"
#include "sleep.h"
#include "api.h"

void setup_sleep()
{
	setup_serial(0,0);//turn UART pins to inputs (to accept button inputs to leave sleep mode)
	clear_button_events();//flush any outstanding button events (like the long press used to enter sleep mode)
}

void run_sleep()
{
	setup_sleep();
	while(is_sleep_valid()) flush_leds(1);//have red status LED shine when pushing a button, but before release, as feedback to user
}