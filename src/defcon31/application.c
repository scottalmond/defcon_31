#include "STM8s.h"
#include "application.h"
#include "api.h"


void run_application()
{
	serial_setup(0,0);
	//setup(true);
	while(is_application_valid())
	{
		
	}
}

//setup GPIO right/left button