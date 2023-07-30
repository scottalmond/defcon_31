#include "STM8s.h"
#include "api.h"
#include "application.h"
#include "developer.h"
#include "sleep.h"

int main()
{
	setup_main();
	while(1)
	{
		if(is_application_valid()) run_application();
		if(is_developer_valid()) run_developer();
		if(get_button_event(0,1)) run_sleep();//if long press on left button, enter sleep mode
	}
	return 0;
}
