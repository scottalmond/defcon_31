#define ledPin 5
#define lowPin 6

typedef uint16_t u16;
typedef uint8_t u8;

//sets all rgb+white LEDs to 0 brightness
void reset_leds() {
  
}

// pushes the temporary values live to the peripherial
void flush_leds() {
  
}

// led_index[0-9], rgb_index[0-2], brightness[0-255]
void setRGB(u8 led_index, u8 rgb_index, u8 brightness) {


}

void decompress(uint8_t compressed[], int size, int lineBreakInterval) {
    for (int i = 0; i < size; i++) {
        for (int j = 7; j >= 0; j--) {
            //printf("%c", (compressed[i] >> j) & 0x01 ? '#' : ' ');
        }
        if ((i % lineBreakInterval) == (lineBreakInterval-1)) {
            //printf("\n");
        }
    }
}

//  ####  #####    ##    ####  ###### #####  # #####  ####  #####  #    #  ####  
// #      #    #  #  #  #    # #      #    # #   #   #      #    # #    # #      
//  ####  #    # #    # #      #####  #####  #   #    ####  #    # #    #  ####  
//      # #####  ###### #      #      #    # #   #        # #####  #    #      # 
// #    # #      #    # #    # #      #    # #   #   #    # #   #  #    # #    # 
//  ####  #      #    #  ####  ###### #####  #   #    ####  #    #  ####   ####  
void printSpaceBitsRUs() {
    uint8_t compressed[] = {0b01111001,0b11110000,0b11000011,0b11001111,0b11011111,0b00101111,0b10011110,0b01111100,0b10000100,0b11110000,0b10000001,0b00001001,0b00100100,0b00101000,0b00010000,0b10100010,0b00100000,0b01000010,0b10000101,0b00000000,0b01111001,0b00001010,0b00010100,0b00001111,0b10011111,0b00100010,0b00011110,0b01000010,0b10000100,0b11110000,0b00000101,0b11110011,0b11110100,0b00001000,0b00010000,0b10100010,0b00000001,0b01111100,0b10000100,0b00001000,0b10000101,0b00000010,0b00010100,0b00101000,0b00010000,0b10100010,0b00100001,0b01000100,0b10000101,0b00001000,0b01111001,0b00000010,0b00010011,0b11001111,0b11011111,0b00100010,0b00011110,0b01000010,0b01111000,0b11110000};    
    int size = sizeof(compressed) / sizeof(compressed[0]);
    
    int lineBreakInterval = 10;  // derived from chunkbits.py

    decompress(compressed, size, lineBreakInterval);
}

void printDefcon31() {
    uint8_t compressed[] = {0b00000000,0b00000000,0b00000000,0b00000000,0b00000000,0b00011111,0b00001000,0b11111001,0b11111011,0b11110011,0b11000111,0b10010000,0b10100000,0b10011000,0b10000101,0b00000010,0b00000100,0b00101000,0b01011000,0b10000000,0b10101000,0b10000101,0b11110011,0b11100100,0b00001000,0b01010100,0b10011111,0b00001000,0b10000101,0b00000010,0b00000100,0b00001000,0b01010010,0b10000000,0b10001000,0b10000101,0b00000010,0b00000100,0b00101000,0b01010001,0b10100000,0b10001000,0b11111001,0b11111010,0b00000011,0b11000111,0b10010000,0b10011111,0b00111110};
    int size = sizeof(compressed) / sizeof(compressed[0]);
    
    int lineBreakInterval = 7;  // derived from chunkbits.py

    decompress(compressed, size, lineBreakInterval);
}

void setup() {
  // put your setup code here, to run once:
  Serial_begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial_available() > 0){
    Serial_write(Serial_read());
  } 
}
