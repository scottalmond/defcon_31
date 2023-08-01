#include "STM8s.h"
#include "application.h"
#include "api.h"

const u8 SUBMENU_COUNT=3; //screen savers, games, puzzles
const u8 SUBMENU_TIME_OUT_MS=2048; //how long the top menu will display for before entering the submenu
const u8 SCREEN_SAVER_COUNT_PONY=3;//all SAOs have these screen savers
const u8 SCREEN_SAVER_COUNT_SPACE=0;//only space ones have these
//const u16 SCREEN_SAVER_DURATION_MS=32768;

void setup_application()
{
	setup_serial(0,0);
	clear_button_events();
}

/*void run_application()
{
	setup_application();
	while(is_application_valid())
	{
		show_cyclone();
	}
}*/

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
		if((show_top_menu_since_ms+(u32)SUBMENU_TIME_OUT_MS)>millis())
		{//if the countdown timeout expiration is in the future (because button is currently down or within 2 seconds of timeout), show top menu
			for(iter=0;iter<RGB_LED_COUNT;iter++) 
				if(iter&0x01)
					set_hue(iter,submenu_index<<14,255);//set all LEDs to the same color
			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs (2-elements each), only every-other enabled, and the status LED to give feedback about the button push to the user
		}else{//showing submenu
			show_top_menu_since_ms=0;
			switch(submenu_index)
			{
				case 0:{ show_screen_savers(); }break;
				case 1:{ show_cyclone(); }break;
				case 2:{ show_counter(); }break;
				//case 3:{ show_puzzle(); }break;
			}
		}
	}
}

bool is_submenu_valid()
{
	return is_application_valid()&&!get_button_event(0,0);
}

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
		if(is_auto_cycle)
		{
			screen_saver_index=millis()>>15;
		}//else{
		//	if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
		//}
		if(clear_button_event(1,1)) is_auto_cycle=!is_auto_cycle;
		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(is_space_sao()?SCREEN_SAVER_COUNT_SPACE:0);
		switch(screen_saver_index)
		{
			case 0:{ set_frame_rainbow(); }break;
			case 1:{ set_frame_blink(); }break;
			case 2:{ set_frame_audio(); }break;
		}
	}
}

void show_counter()
{//it counts the number of times you have clicked the right button.  Long-press to toggle clock mode.
	u32 state=1;
	bool is_clock_mode=0;
	u8 iter;
	while(is_submenu_valid())
	{
		if(is_clock_mode) state=millis()>>8;
		else if(clear_button_event(1,0)) state++;
		if(clear_button_event(1,1)) is_clock_mode=!is_clock_mode;
		state&=0x03FF;
		for(iter=0;iter<RGB_LED_COUNT;iter++)
		{
			if((state>>iter)&0x01)
				set_hue(iter,millis()<<3,255);
		}
		flush_leds(21);
	}
}

void set_frame_rainbow()
{
	u8 iter;
	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,(millis()*32+0x1999*iter),255);
	/*set_rgb(2,0,get_button_event(0,0)?255:0);
	set_rgb(2,2,get_button_event(0,1)?255:0);
	set_rgb(4,0,get_button_event(1,0)?255:0);
	set_rgb(4,2,get_button_event(1,1)?255:0);*/
	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
}

void set_frame_audio()
{
	u8 audio_level,iter;
	audio_level=get_audio_level()/2;
	for(iter=0;iter<RGB_LED_COUNT;iter++)
	{
		if(audio_level>=iter)
		{
			if(iter>7)
			{//red for loud
				set_rgb(iter,0,255);
			}
			else if(iter>4)
			{//yellow for medium
				set_rgb(iter,0,128);
				set_rgb(iter,1,128);
			}else{
				//green quiet
				set_rgb(iter,1,255);
			}
		}
	}
	flush_leds(RGB_LED_COUNT+3+1);//3 yellow LEDs is double-count, 1 for status led for button pushes
}

void set_frame_blink()
{
	//Linear Congruential Generator for pseudo-random numbers
	//u8 LED_WHITE_COUNT=12;
	//u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
	u8 MAX_SIMULTANEOUS_LEDS_ON=5;//red and green and blue are each coutned independently
	//u16 m=RGB_LED_COUNT+LED_WHITE_COUNT;
	u16 x=millis()>>7;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz, >>9 is ~2 Hz
	u8 led_index;
	u8 iter;
	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
	{
		/*if(get_random(~x)&0x01 && is_space_sao())
		{
			led_index=get_random(x)%WHITE_LED_COUNT;
			set_white(led_index,255);
		}else{*/
			led_index=get_random(x^(x>>1))%RGB_LED_COUNT;
			set_hue(led_index,get_random(x^(x>>1)),255);
			//if(iter==0&&!(millis()&0x70))
			if(iter==0&&(((u8)millis()&0x7F)<0x47))
			{
				set_rgb(led_index,0,255);
				set_rgb(led_index,1,255);
				set_rgb(led_index,2,255);
			}
		//}
		x--;
		/*x=get_random(x);
		led_index=x%m;
		if(led_index>=RGB_LED_COUNT)
		{
			if(is_space_sao()) set_white(led_index-RGB_LED_COUNT,255);
		}else{
			//set_rgb(led_index/3,led_index%3,255);
			set_hue(led_index,get_random(x),255);
		}*/
	}
	flush_leds(MAX_SIMULTANEOUS_LEDS_ON<<1+1);
}

//timing game
void show_cyclone()
{
	u32 start_state_ms=millis();
	u8 state=0;
	bool is_increasing=0;
	u8 TARGET_POSITION=5;//constant postiion of the winning position
	u8 player_position=0;
	u8 level=0;
	u8 iter,color;
	u32 residual;
	u8 PERIOD_MS=100;//how many ms pass before the 
	while(is_submenu_valid())
	{
		residual=millis()-start_state_ms;
		switch(state)
		{
			case 0:{  //normal pay
				if((millis()>>9)&0x01)//alternating goal posts
					set_rgb(TARGET_POSITION-1,level,255);
				else
					set_rgb(TARGET_POSITION+1,level,255);
				for(iter=0;iter<3;iter++) //tail length
					for(color=0;color<3;color++) //rgb
						set_rgb((player_position+(is_increasing?1:-1)+RGB_LED_COUNT)%RGB_LED_COUNT,color,255);
				if(residual>PERIOD_MS)
				{
					player_position+=is_increasing?1:-1;
					player_position+=RGB_LED_COUNT;
					player_position%=RGB_LED_COUNT;
					start_state_ms+=PERIOD_MS;
				}
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
			case 1:{ //win
				if((millis()>>7)&0x01)
				{//blinking target, faster than goal posts
					set_rgb(TARGET_POSITION,0,255);
					set_rgb(TARGET_POSITION,1,255);
					set_rgb(TARGET_POSITION,2,255);
				}
				if((millis()>>9)&0x01)
				{//syncronized blinking goal posts
					set_rgb(TARGET_POSITION-1,level,255);
					set_rgb(TARGET_POSITION+1,level,255);
				}
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{//wait for user to accept win before returning to game
					state=0;
					level++;
					PERIOD_MS-=20;
					is_increasing=!is_increasing;//reverse direciton
					start_state_ms=millis();
				}
			}break;
			case 2:{ 
				if((millis()>>7)&0x01)
				{//blinking target, faster than goal posts
					set_rgb(player_position,0,255);
					set_rgb(player_position,1,255);
					set_rgb(player_position,2,255);
				}
				if((millis()>>9)&0x01)//alternating goal posts
					set_rgb(TARGET_POSITION-1,level,255);
				else
					set_rgb(TARGET_POSITION+1,level,255);
				if(clear_button_event(1,0)||clear_button_event(1,1))
				{//wait for user to accept win before returning to game
					state=0;
					is_increasing=!is_increasing;//reverse direciton
					start_state_ms=millis();
				}
			}break;
			case 3:{//end game animation
				//meteour (only way to exit is left button push, ignore user trying to keep playing)
				PERIOD_MS=100;
				if(residual>PERIOD_MS)
				{
					player_position--;
					player_position+=RGB_LED_COUNT;
					player_position%=RGB_LED_COUNT;
					start_state_ms+=PERIOD_MS;
				}
				set_rgb(player_position,0,255);
				set_rgb(player_position,1,255);
				set_rgb(player_position,2,255);
				for(iter=1;iter<4;iter++)
				{
					set_hue((player_position+iter)%RGB_LED_COUNT,(millis()<<3)-(iter<<11),128);
				}
			}break;
		}
		flush_leds(12);//white (3 colors) * 3 tail + 2x goals + 1x status button
	}
}

/*void show_puzzle()
{
	while(is_submenu_valid())
	{
		if(millis()&0b10000000)
			set_rgb(9,2,255);
		else
			set_rgb(8,2,255);
		flush_leds(2);
	}
}*/