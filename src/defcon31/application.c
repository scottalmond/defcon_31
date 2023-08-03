#include "STM8s.h"
#include "application.h"
#include "api.h"

#define SUBMENU_COUNT 4 //screen savers, games, puzzles
#define SUBMENU_TIME_OUT_MS 512 //how long the top menu will display for before entering the submenu
#define SCREEN_SAVER_COUNT_PONY 4//all SAOs have these screen savers
#define SCREEN_SAVER_COUNT_SPACE 1//only space ones have these

//configure peripherals before using them
void setup_application()
{
	setup_serial(0,0);
	clear_button_events();
}

//launch point for the top level menu
void run_application()
{
	u8 submenu_index=0;
	u8 iter;
	u32 show_top_menu_since_ms=0;
	setup_application();
	while(is_application_valid())
	{
		if(clear_button_event(0,0))
		{
			submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
			show_top_menu_since_ms=millis();
		}
		if(is_button_down(0)) show_top_menu_since_ms=millis();
		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
		{//if the countdown timeout expiration is in the future (because button is currently down or within 2 seconds of timeout), show top menu
			for(iter=0;iter<RGB_LED_COUNT;iter++)
				set_hue_max(iter,submenu_index<<14);//set all LEDs to the same color
			flush_leds((RGB_LED_COUNT<<1)+1);//10 RGB LEDs (2-elements each), only every-other enabled, and the status LED to give feedback about the button push to the user
		}else{//showing submenu
			show_top_menu_since_ms=0;
			switch(submenu_index)
			{
				case 0:{ show_screen_savers(); }break;
				case 1:{ show_game(0); }break;//cyclone
				case 2:{ show_game(4); }break;//gate
				case 3:{ show_counter(); }break;
			}
		}
	}
}

//if left button has been pushed, return 0
bool is_submenu_valid()
{
	return is_application_valid()&&!get_button_event(0,0);
}

//within the first menu
void show_screen_savers()
{
	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
	u8 screen_saver_index=0;
	while(is_submenu_valid())
	{
		if(clear_button_event(1,0))
		{
			is_auto_cycle=0;
			screen_saver_index++;
		}
		if(is_auto_cycle) screen_saver_index=millis()>>15;//proceed automatically to the next screen saver every 32 seconds
		if(clear_button_event(1,1)) is_auto_cycle=!is_auto_cycle;
		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(IS_SPACE_SAO?SCREEN_SAVER_COUNT_SPACE:0);
		switch(screen_saver_index)
		{
			case 0:{ set_frame_rainbow(); }break;
			case 1:{ set_frame_audio(); }break;
			case 2:{ set_frame_morse(); }break;
			case 3:{ set_frame_blink(); }break;
			case 4:{ set_frame_space_bits(); }break;//exclusive to space bits badges
		}
	}
}

void show_counter()
{//it counts the number of times you have clicked the right button.  Long-press to toggle clock mode.
	u16 state=1;
	bool is_clock_mode=0;
	u8 iter;
	while(is_submenu_valid())
	{
		if(is_clock_mode) state=millis()>>8;
		else if(clear_button_event(1,0)) state++;
		if(clear_button_event(1,1)) is_clock_mode=!is_clock_mode;
		for(iter=0;iter<RGB_LED_COUNT;iter++)
		{
			if((state>>iter)&0x01)
				set_hue_max(iter,millis()<<3);
		}
		flush_leds(21);
	}
}

void set_frame_rainbow()
{
	u8 iter;
	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue_max(iter,(millis()<<5)+(iter<<13));
	iter=(millis()>>8)&0x0F;
	if(IS_SPACE_SAO&&iter<WHITE_LED_COUNT) set_white_max(iter);
	flush_leds((RGB_LED_COUNT<<1)+1+1);//max 2 colors ON at a time and one led for button pushes
}

void set_frame_audio()
{
	u8 audio_level,iter;
	//update_audio();
	audio_level=get_audio_level();
	for(iter=0;iter<RGB_LED_COUNT;iter++)
	{
		if(audio_level>=iter)
		{
			if(iter>7)
			{//red for loud
				set_rgb_max(iter,0);
			}
			else if(iter>4)
			{//yellow for medium
				set_rgb_max(iter,0);
				set_rgb_max(iter,1);
			}else{
				//green quiet
				set_rgb_max(iter,1);
			}
		}
	}
	flush_leds(RGB_LED_COUNT+3+1);//3 yellow LEDs is double-count, 1 for status led for button pushes
}

void set_frame_blink()
{
	const u8 MAX_SIMULTANEOUS_LEDS_ON=5;
	u16 x=millis()>>7;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz, >>9 is ~2 Hz
	u8 led_index;
	u8 iter;
	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
	{
		led_index=get_random(x^(x>>1))%RGB_LED_COUNT;
		set_hue_max(led_index,get_random(x^(x>>1)));
		if(iter==0&&(((u8)millis()&0x7F)<0x47))
		{
			set_rgb_max(led_index,0);
			set_rgb_max(led_index,1);
			set_rgb_max(led_index,2);
		}
		x--;
	}
	flush_leds(MAX_SIMULTANEOUS_LEDS_ON<<1+1);
}

//2 words per second
void set_frame_space_bits()
{
	switch((millis()>>9)&0x03)
	{
		case 0:{ 
			set_white_max(0);
			set_white_max(1);
			set_white_max(4);
			set_white_max(5);
		}break;
		case 1:{ 
			set_white_max(5);
			set_white_max(6);
			set_white_max(9);
			set_white_max(10);
		}break;
		case 2:{ 
			set_white_max(1);
			set_white_max(2);
			set_white_max(3);
		}break;
		case 3:{ 
			if((millis()>>6)&0x01)
			{
				set_white_max(6);
				set_white_max(11);
			}else{
				set_white_max(7);
				set_white_max(10);
			}
		}break;
	}
	flush_leds(5);
}

//multiple games, selected by initial game state (allows re-use of ending game animation and loop logic with less code space)
void show_game(u8 state)
{
	u32 start_state_ms=millis();
	bool is_increasing=0;
	u8 TARGET_POSITION=5;//constant postiion of the winning position
	u8 player_position=0;
	u8 level=0;
	u8 iter,target_color=0,player_color=0;
	u32 residual;
	u8 PERIOD_MS=state==0?100:200;//how many ms pass before the 
	while(is_submenu_valid())
	{
		residual=millis()-start_state_ms;
		switch(state)
		{
			case 0:{  //cyclone normal play
				set_rgb_max(TARGET_POSITION,level);//single target objective to hit
				if(residual>PERIOD_MS)
				{
					player_position+=is_increasing?1:-1;
					player_position+=RGB_LED_COUNT;
					player_position%=RGB_LED_COUNT;
					start_state_ms+=PERIOD_MS;
				}
				set_rgb_max(player_position,0);
				set_rgb_max(player_position,1);
				set_rgb_max(player_position,2);
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{
					if(player_position==TARGET_POSITION)
					{//the part where the comuter cheats (nudging slightly forward/backward).  Refer to Cyclone user manual https://www.youtube.com/watch?v=vXBfwgwT1nQ
					  if(get_random(millis())&0x0F<(0x02+level<<2)) player_position+=is_increasing?1:-1;
					}
					if(player_position==TARGET_POSITION)
					{
						if(level==2) state=3;
						else state=1;
					}
					else state=2;
				}
			}break;
			case 1:{ //cyclone win
				if((millis()>>7)&0x01)
				{//blinking target, faster than goal posts
					set_rgb_max(TARGET_POSITION,0);
					set_rgb_max(TARGET_POSITION,1);
					set_rgb_max(TARGET_POSITION,2);
				}
				if((millis()>>9)&0x01)
				{//syncronized blinking goal posts
					set_rgb_max(TARGET_POSITION-1,level);
					set_rgb_max(TARGET_POSITION+1,level);
				}
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{//wait for user to accept win before returning to game
					state=0;
					level++;
					PERIOD_MS-=24;
					is_increasing=!is_increasing;//reverse direciton
					start_state_ms=millis();
				}
			}break;
			case 2:{ //cyclone lose
				if((millis()>>7)&0x01)
				{//blinking target, faster than goal posts
					set_rgb_max(player_position,0);
					set_rgb_max(player_position,1);
					set_rgb_max(player_position,2);
				}
				set_rgb_max(TARGET_POSITION,level);
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{//wait for user to accept win before returning to game
					state=0;
					is_increasing=!is_increasing;//reverse direciton
					start_state_ms=millis();
				}
			}break;
			case 3:{//win end game animation
				//meteour (only way to exit is left button push, ignore user trying to keep playing)
				PERIOD_MS=100;
				if(residual>PERIOD_MS)
				{
					player_position++;
					player_position%=RGB_LED_COUNT;
					start_state_ms+=PERIOD_MS;
				}
				for(iter=0;iter<4;iter++)
				{
					player_color=(player_position+iter)%RGB_LED_COUNT;//re-use variable for win animation index
					set_hue_max(player_color,(millis()<<3)-(iter<<11));
					if(iter==3)
					{
						set_rgb_max(player_color,0);
						set_rgb_max(player_color,1);
						set_rgb_max(player_color,2);
					}
				}
			}break;
			case 4:{//gatekeeper game
				if(residual>PERIOD_MS)
				{
					if(player_position==TARGET_POSITION)//"player" is the autonomous moving piece.  user controls color of target gate through button presses
					{
						player_color=(get_random((u8)millis()^~player_color))%3;
						PERIOD_MS-=3;
					}
					player_position++;
					player_position%=RGB_LED_COUNT;
					start_state_ms+=PERIOD_MS;
					if(PERIOD_MS<120) state=3;//win game
					if(player_position==TARGET_POSITION && player_color!=target_color) state=5;
				}
				set_rgb_max(TARGET_POSITION,target_color);//stationary gate
				set_rgb_max(player_position,player_color);//moving key
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{
					target_color++;
					target_color%=3;
				}
			}break;
			case 5:{//gate game lose
				if(millis()&0x40)
					set_rgb_max(TARGET_POSITION,player_color);
				else
					set_rgb_max(TARGET_POSITION,target_color);
				if((clear_button_event(1,0)&&(residual>0x0100))||clear_button_event(1,1))
				{
					start_state_ms=millis();
					PERIOD_MS=200;
					state=4;//restart game
				}
			}break;
		}
		flush_leds(12);//white (3 colors) * 3 tail + 2x goals + 1x status button
	}
}

void set_frame_morse()
{
	u8 morse_units[]= {
		#if IS_SPACE_SAO
			 0b10101001,0b01110111,0b01001011,0b10011101,0b01110100,0b10011101,0b01010010,0b10011100,0b10101001,0b01110100,0b10101110,0b01010100 
		#else
			 0b11101010,0b01001010,0b11101001,0b11010111,0b01001110,0b11101110,0b01110100,0b10101011,0b10111001,0b01110111,0b01110111,0b00000000
		#endif
		};
	u16 morse_period_units=0x0008;//will become the period of the morse code cycling in lengths of *units* (there are dead bands at the end of each cycle while the patterns waits to repeat - needs to be an even multiple of 2 to make the clock math easy
	u8 morse_shift=sizeof(morse_units);//number of *bytes* in morse_list
	u8 morse_bit;
	u8 morse_index,iter;
	while(morse_shift)//for every multiple of 2 bytes in morse_units, divide morse_units by 2 and multiple morse_period_units by 2 to get morse_period_units to become the next even mulitple of 2 greater than morse_units
	{
		morse_period_units<<=1;
		morse_shift>>=1;
	}
	morse_bit=(millis()>>7)&(morse_period_units-1);//use time to index into the array
	morse_index=morse_bit>>3;//get the byte-wise index within the array
	if(morse_index<sizeof(morse_units))//needs to be within the array to light any LEDs
	{
		morse_shift=morse_bit&0x07;//3 LSBs are which bit within the byte to fetch
		if(morse_units[morse_index]>>(7-morse_shift)&0x01)//use "7-" to make it easier to generate and read the list constructor left-to-right
		{
			#if IS_SPACE_SAO
				for(iter=0;iter<WHITE_LED_COUNT;iter++) set_white_max(iter);
			#else
				for(iter=0;iter<RGB_LED_COUNT;iter++) set_rgb_max(iter,2);
			#endif
		}
	}//else all LEDs OFF
	#if IS_SPACE_SAO
		flush_leds(WHITE_LED_COUNT+1);
	#else
		flush_leds(WHITE_LED_COUNT+1);
	#endif
}