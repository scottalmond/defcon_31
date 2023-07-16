/* MAIN.C file
 * 
 * 
 */

#include "STM8s.h"
//#include "stm8s103_ADC.h"
#include "api.h"
#include "application.h"
#include "developer.h"

//void setup(bool is_application);

int main()
{
	setup();
	while(1)
	{
		if(is_application_valid())
		{
			run_application();
		}else{
			run_developer();
		}
	}
	return 0;
}



/*void setup(bool is_application)
{
	serial_setup(!is_application,115200);
	if(!is_application)
	{
		//print terminal welcome message here
	}
}*/