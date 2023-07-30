#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"

//setup Tx/Rx
//char terminal_command;
//u32 terminal_parameters[3];

void setup_developer()
{
	setup_serial(1,0);//enabled, 0: 9600 baud, 1: at high speed (1MBaud)
	clear_button_events();
	flush_leds(0);//clear outstanding led buffer
	set_debug(255);//show only one debug led ON
	flush_leds(1);
	print_welcome();
}

void run_developer()
{
	char command;
	u8 parameter_count;//number of parameters recevied
	u32 parameters[MAX_TERMINAL_PARAMETERS];
	setup_developer();
	while(is_developer_valid())
	{
		Serial_print_string("> ");
		get_terminal_command(&command,&parameters,&parameter_count);
		set_debug(255);//show only one debug led ON
		execute_terminal_command(&command,&parameters,&parameter_count);
		command=0;
		parameter_count=0;
	}
	
	//Serial_print_string("DONE");
	//Serial_newline();
}

//ascii art welcome message
void print_welcome()
{
	u8 space_bits[] = { 0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,
											0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,
											0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,
											0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,
											0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,
											0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,
											0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,
											0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,
											0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,
											0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000}; 
	u8 defcon31[] = {   0b01111110,0b01111111,0b01111111,0b00111110,0b01111111,0b01000001,
											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000001,
											0b01000001,0b01100001,0b01000001,0b0011000,0b01000001,0b01000000,
											0b01000000,0b01000000,0b01000001,0b01010001,0b00000001,0b0101000,
											0b01000001,0b01111100,0b01111100,0b01000000,0b01000001,0b01001001,//last bit messed up?
											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000000,//mis-typed bit?
											0b01000001,0b01000101,0b00000001,0b0001000,0b01000001,0b01000000,
											0b01000000,0b01000001,0b01000001,0b01000011,0b01000001,0b0001000,
											0b01111110,0b01111111,0b01000000,0b00111110,0b01111111,0b01000001,
											0b00111110,0b0111110 };
	u8 length = sizeof(is_space_sao()?space_bits:defcon31);
	u8 lineBreakInterval = is_space_sao()?10:8;
	u8 i,j;
	for (i = 0; i < length; i++) {
			for (j = 7; j >= 0; j--) {
				 // Extract the jth bit from the current byte and print '#' if it's 1, or ' ' if it's 0
				 Serial_print_char((((is_space_sao()?space_bits[i]:defcon31[i]) >> j) & 0x01) ? '#' : ' ');
				 //sprintf(buffer, "%c", (compressed[i] >> j) & 0x01 ? '#' : ' ');
				 //Serial_print_s(buffer);
			}
			if ((i % lineBreakInterval) == (lineBreakInterval-1)) {
				 // Insert a line break after every lineBreakInterval elements
				 Serial_newline();
			}
	}
}

void get_terminal_command(char *command,u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	bool is_new_line=0;
	bool is_any_input=0;//set to true after new input received, including a value of '0'
	char input_char;
	while(is_developer_valid() && !is_new_line)
	{
		if(Serial_available())
		{
			input_char=Serial_read_char();
			if((*command)==0) (*command)=input_char;
			else{
				if('0'<=input_char && input_char<='9')
				{
					if(!is_any_input) (*parameters)[(*parameter_count)]=0;
					(*parameters)[(*parameter_count)]=((*parameters)[(*parameter_count)]<<3+(*parameters)[(*parameter_count)]<<1)+(input_char-'0');//new_value = old_value*8 + old_value*2 + char;
					is_any_input=1;
				}else{//spaces commas or any other inter-parameter spacing, ignore it, including multi-character spaces
					if(is_any_input)
					{
						(*parameter_count)++;
						is_any_input=0;
						(*parameter_count)%=MAX_TERMINAL_PARAMETERS;//protect against array indexing overflow
					}
					if(input_char=='\n') is_new_line=1;
				}
			}
		}
	}
}

void execute_terminal_command(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	u8 iter;
	bool is_valid=0;
	switch(*command)
	{
		case 'p':{ //simple ping/echo
			Serial_print_char(*command);
			for(iter=0;iter<*parameter_count;iter++)
			{
				Serial_print_char(' ');
				Serial_print_u32((*parameters)[iter]);
			}
			is_valid=1;
		}break;
		case 'b':{ //increase baud rate to 1 MBaud
			setup_serial(1,1);
		}break;
		case 't':{ //if parameters>=1, then set time, else print time
			if(*parameter_count) set_millis((*parameters)[0]);
			else Serial_print_u32(millis());
			is_valid=1;
		}break;
		case 'h':{ //help dialog
			print_welcome();
			Serial_print_string("GitHub.com/ScottAlmond/DefCon_31");
			is_valid=1;
		}break;
		case 'e':{ //eeprom interface
			if(*parameter_count==1)
			{//read, 0-127
				if((*parameters)[0]<128)
					//Serial_print_u32(FLASH_ReadByte(eeprom_address));
					Serial_print_u32(get_eeprom_byte((*parameters)[0]));
			}/*else if(parameter_count==2)
			{//write
				if((*parameters)[1]<256)
				{
					FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
					FLASH_Unlock(FLASH_MEMTYPE_DATA);
					while(FLASH_GetFlagStatus(FLASH_FLAG_DUL)==RESET);
					FLASH_ProgramByte(FLASH_ReadByte((*parameters)[0]+0x4000),(*parameters)[1]);
					FLASH_Lock(FLASH_MEMTYPE_DATA);
				}
			}*/
		}break;
		case 'l':{ //l as in lower case 'L' from 'LED'
			is_valid=1;
			if(*parameter_count<3) is_valid=0;
			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
			if((*parameters)[1]>=3) is_valid=0;
			if((*parameters)[2]>=255) is_valid=0;
			if(is_valid)
			{
				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
		case 'w':{ //set white led (only populated on space SAOs
			is_valid=1;
			if(*parameter_count<2) is_valid=0;
			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
			if((*parameters)[1]>=255) is_valid=0;
			if(is_valid)
			{
				set_white((*parameters)[0],(*parameters)[1]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
		case 'a':{ //get audio level reading
			Serial_print_u32(get_audio_level());
			is_valid=1;
		}break;
		case 'g':{ //game
			play_terminal_game(command,parameters,parameter_count);
			is_valid=1;
		}break;
	}
	if(!is_valid) Serial_print_string("Invalid");
	Serial_newline();
}

void play_terminal_game(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	u8 mine_locations[MINESWEEPER_ROWS];
	u8 revealed_cells[MINESWEEPER_ROWS];
	s8 row,col;
	u8 mine_count=0,hidden_count=0;
	bool valid_input,is_lose;
	while(mine_count<10)
	{
		row=(get_random(millis())>>3)%9;
		col=get_random(millis())%8;
		if(!((mine_locations[row]>>col)&0x01))
		{
			mine_locations[row]|=0x01<<col;
			mine_count++;
		}
	}
	while(is_developer_valid())
	{
		valid_input=1;
		hidden_count=print_minesweeper(&mine_locations,&revealed_cells,is_lose);
		if(hidden_count<=mine_count || is_lose) break;//won game
		Serial_print_string("Guess (row col), or quit: ");
		*command=0;//prepare for nested method calls to get_terminal_command() to get use input
		*parameter_count=0;
		get_terminal_command(command,parameters,parameter_count);
		if(*command=='q') return;
		if(*command<'0' || *command>='9') valid_input=0;
		else if(*parameter_count!=1) valid_input=0;
		else if((*parameters)[0]>=8) valid_input=0;
		if(valid_input)
		{
			is_lose=make_guess(*command-'0',(*parameters)[0],&mine_locations,&revealed_cells);
		}else Serial_print_string("Invalid\n");
	}
	if(is_lose) Serial_print_string("Game Over\n");
	else Serial_print_string("Winner\n");
}

//return number of cells still hiden from user (game is won when hidden_count==mine_count)
u8 print_minesweeper(u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_mines)[MINESWEEPER_ROWS],bool is_lose)
{
	u8 row,col,hidden_count=0;
	bool is_mine;
	Serial_print_string("    0  1  2  3  4  5  6  7\n");
	Serial_print_string("  +------------------------\n");
	for(row=0;row<MINESWEEPER_ROWS;row++)
	{
		Serial_print_char('0'+row);
		Serial_print_string(" | ");
		for(col=0;col<8;col++)
		{
			if(is_lose && is_mine_at(row,col,mine_locations)) Serial_print_char('X');
			else
			{
				if(is_mine_at(row,col,revealed_mines)) Serial_print_char('0'+get_nearby_count(row,col,mine_locations));
				else
				{
					Serial_print_char('.');
					hidden_count++;
				}
			}
			Serial_print_string("  ");
		}
		Serial_newline();
	}
	return hidden_count;
}

//return 0 if guess is valid; return 1 if landed on a mine
bool make_guess(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_cells)[MINESWEEPER_ROWS])
{
	s8 row_diff,col_diff;
	if(row<0 || col <0 || row>=MINESWEEPER_ROWS || col>=8) return 0;//if out of bounds, skip it
	if(((*revealed_cells)[row]>>col) & 0x01) return 0;//if already revealed, skip it
	(*revealed_cells)[row]|=0x01<<col;//reveal guess
	if(get_nearby_count(row,col,mine_locations)==0)
	{//clear out nearby squares if current guess is 0
		for(row_diff=-1;row_diff<=1;row_diff++)
			for(col_diff=-1;col_diff<=1;col_diff++)
				make_guess(row+row_diff,col+col_diff,mine_locations,revealed_cells);
	}
	return is_mine_at(row,col,mine_locations);
}

u8 get_nearby_count(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
{
	s8 row_diff,col_diff;
	u8 sum=0;
	for(row_diff=-1;row_diff<=1;row_diff++)
	{
		for(col_diff=-1;col_diff<=1;col_diff++)
		{
			if(row_diff==0 && col_diff==0)
			{
				if(is_mine_at(row,col,mine_locations)) return 1;
			}else{
				sum+=is_mine_at(row+row_diff,col+col_diff,mine_locations);
			}
		}
	}
	return sum;
}

bool is_mine_at(s8 row,s8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
{
	if(row<0 || col<0 || row>=MINESWEEPER_ROWS || col>=8) return 0;
	return ((*mine_locations)[row]>>col)&0x01;
}