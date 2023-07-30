#include "api.h"

#define MAX_TERMINAL_PARAMETERS 3
#define MINESWEEPER_ROWS 9

void setup_developer(void);
void run_developer(void);
void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count);
void execute_terminal_command(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count);
void print_welcome(void);
void play_terminal_game(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count);
u8 print_minesweeper(u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_mines)[MINESWEEPER_ROWS],bool is_lose);
bool make_guess(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_cells)[MINESWEEPER_ROWS]);
u8 get_nearby_count(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS]);
bool is_mine_at(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS]);