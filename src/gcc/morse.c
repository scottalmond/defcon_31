#include <time.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>

const uint32_t submenu_start_millis = 0;

unsigned int millis () {
  struct timespec t ;
  clock_gettime ( CLOCK_MONOTONIC, & t );
  return t.tv_sec * 1000 + ( t.tv_nsec + 500000 ) / 1000000;
}

//numbers 5 did/das
//number 0-9, 'a' at 10 .. 'z' at 35
//3 LSB are the number of dah/dits (morse[N] & 0x07 = 3 LSB's: a value between 0 and 5)
//5 MSB are the dah (1), dit (0)
//bits 0-2 are the count of dah dits
//bit 3 is the first dih/dah, bit 7 is the last one
const uint8_t morse[36] = {
    0b00000000, // '0' (No dits or dahs)
    0b00000001, // '1' (1 dit)
    0b00000011, // '2' (2 dits)
    0b00000111, // '3' (3 dits)
    0b00001111, // '4' (4 dits)
    0b00011111, // '5' (5 dits)
    0b00111111, // '6' (1 dah)
    0b01111111, // '7' (2 dahs)
    0b11111111, // '8' (3 dahs)
    0b11111110, // '9' (4 dahs)
    0b00111101, // 'a' (1 dah, 1 dit)
    0b01011111, // 'b' (2 dahs, 1 dit)
    0b01101111, // 'c' (3 dahs, 1 dit)
    0b01110111, // 'd' (2 dahs)
    0b01111000, // 'e' (1 dit)
    0b01010111, // 'f' (1 dah, 2 dits)
    0b01010111, // 'g' (3 dahs, 1 dit)
    0b01010000, // 'h' (1 dah)
    0b01000000, // 'i' (1 dit, 3 dahs)
    0b00101010, // 'j' (1 dit, 3 dahs)
    0b01001001, // 'k' (2 dahs, 1 dit)
    0b00010111, // 'l' (1 dah, 2 dits)
    0b01111011, // 'm' (2 dahs)
    0b01110010, // 'n' (3 dahs)
    0b01110111, // 'o' (4 dahs)
    0b01011011, // 'p' (1 dah, 3 dits)
    0b01010101, // 'q' (2 dahs, 3 dits)
    0b00101011, // 'r' (1 dah, 1 dit)
    0b01010000, // 's' (1 dit)
    0b01110000, // 't' (1 dah)
    0b00110111, // 'u' (1 dit, 2 dahs)
    0b00001111, // 'v' (1 dit, 3 dahs)
    0b00111011, // 'w' (1 dah, 4 dits, 1 dah)
    0b01001111, // 'x' (2 dahs, 1 dit, 3 dahs)
    0b01100111, // 'y' (3 dahs, 1 dit, 2 dahs)
    0b01101001  // 'z' (2 dahs, 2 dits)
};



uint8_t get_morse_state(char array[], uint32_t millis_elapsed, uint16_t timebase_millis)
{
    uint8_t char_index = 0;
    uint8_t dah_dit_compressed = 0;
    uint8_t dah_dit_count = 0;
    uint8_t dah_dit_index = 0;
    uint32_t offset_tms = 0;

    while (array[char_index] != '\0')
    {
        if (array[char_index] != ' ')
        {
            dah_dit_count = morse[array[char_index] <= '9' ? array[char_index] - '0' : (array[char_index] - 'a' + 10)] & 0x07;
            dah_dit_compressed = morse[array[char_index] <= '9' ? array[char_index] - '0' : (array[char_index] - 'a' + 10)] >> 3;

            // ternary operator for number vs character
            for (dah_dit_index = 0; dah_dit_index < dah_dit_count; dah_dit_index++)
            {
                offset_tms += timebase_millis * ((dah_dit_compressed & 0x01) ? 3 : 1);

                if (offset_tms > millis_elapsed)
                    return 1 + (dah_dit_compressed & 0x01); // Return 1 for dit or 2 for dah.

                offset_tms += timebase_millis;
                dah_dit_compressed = dah_dit_compressed >> 1;

                if (offset_tms > millis_elapsed)
                    return 0; // LED OFF.
            }
        }

        offset_tms += timebase_millis * 2;

        if (offset_tms > millis_elapsed)
            return 0; // LED OFF.

        if (array[char_index] == ' ')
        {
            offset_tms += timebase_millis * 4;

            if (offset_tms > millis_elapsed)
                return 0; // LED OFF.
        }

        char_index++;
    }

    return 0; // LED OFF.
}


void display_only_morse(bool is_first_call)
{
    //reset_leds()
    char* str = "spacebitsrus"; //PRECON lower case

    uint32_t millis_elapsed = millis() - submenu_start_millis;

    // Iterate through the input string
    for (int char_index = 0; str[char_index] != '\0'; char_index++)
    {
        // Call get_morse_state with each character individually
        uint8_t is_dit_dah = get_morse_state(&str[char_index], millis_elapsed, 300);

        // Print dits and dahs
        switch (is_dit_dah)
        {
        case 1: // display a dit pattern
            // set leds 5-9 blue
            printf("dit ");
            break;
        case 2: // display a dah pattern
            // set leds 0-4 green
            printf("dah ");
            break;
        default:
            // Skip spaces, you can also handle other characters if needed
            if (str[char_index] == ' ')
                continue;

            // Handle unknown characters
            printf("unknown ");
            break;
        }
    }
    printf("\n");
}



int main() {
 
       display_only_morse(true);
    
    return 0;
}