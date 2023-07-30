#include "api.h"

#define MAX_TERMINAL_PARAMETERS 3

void setup_developer(void);
void run_developer(void);
void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count);
void execute_terminal_command(char command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 parameter_count);
void print_welcome(void);