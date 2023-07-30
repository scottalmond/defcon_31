#include "STM8s.h"
#include "application.h"
#include "api.h"

const u8 SUBMENU_COUNT=3; //screen savers, games, puzzles
const u8 SUBMENU_TIME_OUT_MS=2048; //how long the top menu will display for before entering the submenu
const u8 SCREEN_SAVER_COUNT_PONY=3;
const u8 SCREEN_SAVER_COUNT_SPACE=2;
const u16 SCREEN_SAVER_DURATION_MS=32768;

void setup_application()
{
	setup_serial(0,0);
	clear_button_events();
}

void run_application()
{
	u8 submenu_index;
	u8 iter;
	u32 show_top_menu_since_ms=0;
	setup_application();
	while(is_application_valid())
	{
		if(clear_button_event(0,0)) submenu_index=(submenu_index+1)%SUBMENU_COUNT;//incement menu selection after every left button release
		if(is_button_down(0)) show_top_menu_since_ms=millis();
		if((show_top_menu_since_ms+SUBMENU_TIME_OUT_MS)>millis())
		{//if the coutndown timeout expiration is in the future (because button is currently down or within 2 seconds of timeout), show top menu
			for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,submenu_index<<13,255);//set all LEDs to the same color
			flush_leds(RGB_LED_COUNT+1);//10 RGB LEDs and the status LED to give feedback about the button push to the user
		}else{
			show_top_menu_since_ms=0;
			switch(submenu_index)
			{
				case 0:{ show_screen_savers(); }break;
				case 1:{ show_cyclone(); }break;
				case 2:{ show_puzzle(); }break;
			}
		}
	}
}

bool is_submenu_valid()
{
	return is_application_valid()&&!is_button_down(0);
}

void show_screen_savers()
{
	bool is_auto_cycle=1;//automatically cycle through screen savers as a function of millis() (sync millis across multiple SAOs through terminal to get multiple badges sync'd)
	u8 screen_saver_index=0;
	while(is_submenu_valid())
	{
		if(is_auto_cycle)
		{
			screen_saver_index=millis()/SCREEN_SAVER_DURATION_MS;
			if(clear_button_event(1,1)) is_auto_cycle=0;
		}else{
			if(clear_button_event(1,0)) screen_saver_index++;//short right button push to go to next screen saver
			if(clear_button_event(1,1)) is_auto_cycle=1;//long right button push to resume auto-cycling
		}
		screen_saver_index%=SCREEN_SAVER_COUNT_PONY+(is_space_sao()?SCREEN_SAVER_COUNT_SPACE:0);
		switch(screen_saver_index)
		{
			case 0:{ set_frame_rainbow(); }break;
			case 1:{ set_frame_blink(); }break;
			case 2:{ set_frame_audio(); }break;
			case 3:{  }break;
			case 4:{  }break;
		}
	}
}

void set_frame_rainbow()
{
	u8 iter;
	for(iter=0;iter<RGB_LED_COUNT;iter++) set_hue(iter,(u16)(millis()*32+(0xFFFF/10)*iter),255);
	flush_leds(2*RGB_LED_COUNT+1);//max 2 colors ON at a time and one led for button pushes
}

void set_frame_audio()
{
	u8 audio_level,iter;
	audio_level=get_audio_level()/2;
	for(iter=0;iter<RGB_LED_COUNT;iter++)
	{
		if(audio_level>iter)
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
	u8 LED_WHITE_COUNT=12;
	u8 RGB_ELEMENT_COUNT=RGB_LED_COUNT*3;//10*3=30
	u8 MAX_SIMULTANEOUS_LEDS_ON=4;//red and green and blue are each coutned independently
	u16 m=RGB_ELEMENT_COUNT+LED_WHITE_COUNT;
	u16 x=millis()/128;//divide by the period (in ms) with which to change which LEDs are shown --> 256 is ~4 Hz, 128 is ~8 Hz
	u8 led_index;
	u8 iter;
	for(iter=0;iter<MAX_SIMULTANEOUS_LEDS_ON;iter++)
	{
		x=get_random(x);
		led_index=x%m;
		if(led_index>=RGB_ELEMENT_COUNT)
		{
			if(is_space_sao()) set_white(led_index-RGB_ELEMENT_COUNT,255);
		}else{
			set_rgb(led_index/3,led_index%3,255);
		}
	}
	flush_leds(MAX_SIMULTANEOUS_LEDS_ON+1);
}

//timing game
void show_cyclone()
{
	while(is_submenu_valid())
	{
		
	}
}

void show_puzzle()
{
	while(is_submenu_valid())
	{
		
	}
}