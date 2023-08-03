#include "STM8s.h"
#include "developer.h"
#include "api.h"
#include "stm8s103_serial.h"

void setup_developer()
{
	setup_serial(1,1);//enabled at high speed
	clear_button_events();
	flush_leds(0);//clear outstanding led buffer
	#if HW_REVISION==1
		set_rgb(0,0,255);
	#else
		set_debug(255);//show only one debug led ON
	#endif
	flush_leds(1);
	Serial_newline();
	print_ascii_art(1);
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
		#if HW_REVISION==1
			set_rgb(0,0,255);
		#else
			set_debug(255);//show only one debug led ON
		#endif
		execute_terminal_command(&command,&parameters,&parameter_count);
	}
	Serial_print_string("Bye\n");
	flush_leds(0);//turn off debug led
	flush_leds(1);//turn off debug led
}

//ascii art welcome message
void print_ascii_art(bool is_welcome)
{
	u8 welcome[] = {
		#if IS_SPACE_SAO
											0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,
											0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,
											0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,
											0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,
											0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,
											0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,
											0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,
											0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,
											0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,
											0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000
		#else
											0b01111110,0b01111111,0b01111111,0b00111110,0b01111111,0b01000001,
											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000001,
											0b01000001,0b01100001,0b01000001,0b0011000,0b01000001,0b01000000,
											0b01000000,0b01000000,0b01000001,0b01010001,0b00000001,0b0101000,
											0b01000001,0b01111100,0b01111100,0b01000000,0b01000001,0b01001001,//last bit messed up?
											0b00111110,0b0001000,0b01000001,0b01000000,0b01000000,0b01000000,//mis-typed bit?
											0b01000001,0b01000101,0b00000001,0b0001000,0b01000001,0b01000000,
											0b01000000,0b01000001,0b01000001,0b01000011,0b01000001,0b0001000,
											0b01111110,0b01111111,0b01000000,0b00111110,0b01111111,0b01000001,
											0b00111110,0b0111110
		#endif
		};
	u8 winner[] = {     0b10000010,0b11101000,0b00101000,0b00101111,0b11101111,0b11000000,
											0b10010010,0b01001100,0b00101100,0b00101000,0b00001000,0b00100000,
											0b10010010,0b01001010,0b00101010,0b00101000,0b00001000,0b00100000,
											0b10010010,0b01001001,0b00101001,0b00101111,0b10001111,0b11000000,
											0b10010010,0b01001000,0b10101000,0b10101000,0b00001000,0b10000000,
											0b10010010,0b01001000,0b01101000,0b01101000,0b00001000,0b01000000,
											0b01101100,0b11101000,0b00101000,0b00101111,0b11101000,0b00100000 };
	u8 length = is_welcome?sizeof(welcome):sizeof(winner);
	u8 lineBreakInterval = is_welcome?
		#if IS_SPACE_SAO
			10
		#else
			8
		#endif
			:6;
	u8 i,j;
	for (i = 0; i < length; i++) {
		for (j = 7; j !=0xFF; j--) {
			// Extract the jth bit from the current byte and print '#' if it's 1, or ' ' if it's 0
			Serial_print_char((( (is_welcome?welcome[i]:winner[i]) >> j)  & 0x01) ? '#' : ' ');
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
	u8 new_input_index=0;
	char str[1+MAX_TERMINAL_PARAMETERS*11+3];//numbers can be up to 10 digits, plus space between them =11. plus initial char, plus new line char, plus '\0' termination
	u8 str_index=0,iter;
	while(is_developer_valid()&&str_index<sizeof(str))
	{//for fast/lossless execution, first step is to jest store the user input
		if(Serial_available())
		{
			input_char=Serial_read_char(0);
			if(str_index==0)
			{
				str[0]=input_char;
				str_index++;
				if(input_char=='\n') break;
			}else{
				if(input_char>='0' && input_char<='9')
				{
					if(str_index==1)
					{//"p9" --> "p 9"
						str[1]=' ';
						str_index++;
					}
					str[str_index]=input_char;
					str_index++;
				}else{
					if(input_char=='\n')
					{
						str[str_index]='\0';
						break;
					}
					if(str[str_index-1]!=' ')
					{
						str[str_index]=' ';
						str_index++;
					}
				}
			}
		}
	}
	//echo the received characters
	/*Serial_print_string("Input (");
	Serial_print_u32(str_index);
	Serial_print_string("): ");
	Serial_print_string(str);
	Serial_newline();*/
	*command=str[0];
	str[0]=0;
	*parameter_count=0;
	for(iter=1;iter<str_index;iter++)
	{
		new_input_index=(*parameter_count-1)%MAX_TERMINAL_PARAMETERS;
		if(str[iter]==' ')
		{
			(*parameters)[*parameter_count]=0;
			(*parameter_count)++;
		}
		else
		{
			(*parameters)[new_input_index]=(((*parameters)[new_input_index])<<3)+(((*parameters)[new_input_index])<<1)+str[iter]-'0';
		}
		str[iter]=0;
	}
	*parameter_count=(*parameter_count)>MAX_TERMINAL_PARAMETERS?MAX_TERMINAL_PARAMETERS:*parameter_count;
}

void execute_terminal_command(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	u8 iter;
	bool is_valid=0,is_command_exist=1;
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
		case 't':{ //if parameters>=1, then set time, else print time
			if(*parameter_count) set_millis((*parameters)[0]);
			Serial_print_u32(millis());
			is_valid=1;
		}break;
		case '?':
		case '\n':
		case 'h':{ //help dialog
			//Serial_print_string("GitHub.com/ScottAlmond/DefCon_31");//user wouldn't know which pins are UART, and the baud rate, unless they've already seen this page, so it's a moot point
			Serial_print_string("h\np 9 0 255\np0-3#\nt0-1#\nl2-3#\nw1-2#\na\ng");//more cryptic version
			is_valid=1;
		}break;
		case '1'://in case user mis-reads L as 1
		case 'l':{ //l as in lower case 'L' from 'LED'
			is_valid=1;
			if((*parameter_count)<2) is_valid=0;
			if(*parameter_count==2) (*parameters)[3]=255;
			if((*parameters)[0]>=RGB_LED_COUNT) is_valid=0;
			if((*parameters)[1]>=3) is_valid=0;
			if((*parameters)[2]>255) is_valid=0;
			if(is_valid)
			{
				set_rgb((*parameters)[0],(*parameters)[1],(*parameters)[2]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
		case 'w':{ //set white led (only populated on space SAOs
			is_valid=1;
			if(*parameter_count<1) is_valid=0;
			if(*parameter_count==1) (*parameters)[2]=255;
			if((*parameters)[0]>=WHITE_LED_COUNT) is_valid=0;
			if((*parameters)[1]>255) is_valid=0;
			if(is_valid)
			{
				set_white((*parameters)[0],(*parameters)[1]);
				flush_leds(2);//1 RGB led element and 1 for status led
			}
		}break;
		case 'a':{ //get audio level reading
			//for(iter=0;iter<255;iter++) update_audio();
			Serial_print_u32(get_audio_level());
			is_valid=1;
		}break;
		case 'g':{ //game
			play_terminal_game(command,parameters,parameter_count);
			is_valid=1;
		}break;
		default:{ is_command_exist=0; } break;
	}
	if(!is_command_exist)
	{
		Serial_print_string("Invalid cmd: ");
		Serial_print_char(*command);
	}
	else if(!is_valid) Serial_print_string("Invalid params");
	Serial_newline();
}

//minesweeper.
void play_terminal_game(char (*command),u32 (*parameters)[MAX_TERMINAL_PARAMETERS],u8 *parameter_count)
{
	u8 row,col;
	u8 mine_count=0,hidden_count=0;
	bool valid_input,is_lose=0;
	u8 mine_locations[MINESWEEPER_ROWS];
	u8 revealed_cells[MINESWEEPER_ROWS];
	for(row=0;row<MINESWEEPER_ROWS;row++)
	{//need to pre-clear array to have deterministic contents
		mine_locations[row]=0;
		revealed_cells[row]=0;
	}
	while(mine_count<10)
	{
		row=(get_random(millis())>>3)%MINESWEEPER_ROWS;
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
		get_terminal_command(command,parameters,parameter_count);
		if(*command=='q') return;
		if(*command<'0' || *command>'9') valid_input=0;
		else if(*parameter_count!=1) valid_input=0;
		else if((*parameters)[0]>=8) valid_input=0;
		if(valid_input)
		{
			row=*command-'0';
			col=(*parameters)[0];
			is_lose=make_guess(row,col,&mine_locations,&revealed_cells);
		}else Serial_print_string("Invalid\n");
	}
	if(!is_developer_valid()) return;//prevent displaying winner message because user left the menu manually
	if(is_lose){ Serial_print_string("Game Over\n"); is_lose=0; }
	else print_ascii_art(0);
}

//return number of cells still hiden from user (game is won when hidden_count==mine_count)
u8 print_minesweeper(u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_mines)[MINESWEEPER_ROWS],/*u8 (*marked_cells)[MINESWEEPER_ROWS],*/bool is_lose)
{
	u8 row,col,hidden_count=0;
	bool is_mine;
	Serial_print_string("\n    0 1 2 3 4 5 6 7\n");
	Serial_print_string(  "  +-----------------\n");
	for(row=0;row<MINESWEEPER_ROWS;row++)
	{
		Serial_print_char('0'+row);
		Serial_print_char(' ');
		Serial_print_char('|');
		for(col=0;col<8;col++)
		{
			Serial_print_char(' ');
			if(is_lose && is_mine_at(row,col,mine_locations)) Serial_print_char('X');
			else
			{
				if(is_mine_at(row,col,revealed_mines))
					Serial_print_char('0'+get_nearby_count(row,col,mine_locations));
				else
				{
					Serial_print_char('.');
					hidden_count++;
				}
			}
		}
		Serial_newline();
	}
	return hidden_count;
}

//return 0 if guess is valid; return 1 if landed on a mine
bool make_guess(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS],u8 (*revealed_cells)[MINESWEEPER_ROWS])
{
	u8 row_diff,col_diff;
	if(row>=MINESWEEPER_ROWS || col>=8) return 0;//if out of bounds, skip it
	if(((*revealed_cells)[row]>>col) & 0x01) return 0;//if already revealed, skip it
	(*revealed_cells)[row]|=0x01<<col;//reveal guess
	if(get_nearby_count(row,col,mine_locations)==0)
	{//clear out nearby squares if current guess is 0
		for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
			for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
				make_guess(row+row_diff,col+col_diff,mine_locations,revealed_cells);
	}
	return is_mine_at(row,col,mine_locations);
}

u8 get_nearby_count(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
{
	u8 row_diff,col_diff;
	u8 sum=0;
	for(row_diff=0xFF;row_diff<=1 || row_diff==0xFF;row_diff++)
	{
		for(col_diff=0xFF;col_diff<=1 || col_diff==0xFF;col_diff++)
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

bool is_mine_at(u8 row,u8 col,u8 (*mine_locations)[MINESWEEPER_ROWS])
{
	if(row>=MINESWEEPER_ROWS || col>=8) return 0;
	return ((*mine_locations)[row]>>col)&0x01;
}