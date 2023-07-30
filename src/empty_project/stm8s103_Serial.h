 /*Header file for Arduino like Serial commands on STM8S
 * Website: https://circuitdigest.com/search/node/STM8S
 * Code by: Aswinth Raj
 * Github: https://github.com/CircuitDigest/STM8S103F3_SPL
 */
 
 /*Control on-board LED through USART
 * PD5 - UART1-Tx
 * PD6 - UART1-Rx
 */
 

//Funtion Declarations 
 void Serial_begin(uint32_t); //pass baug rate and start serial communiaction 
 void Serial_print_int (int); //pass integer value to print it on screen
 void Serial_print_char (char); //pass char value to print it on screen 
 void Serial_print_string (char[]); //pass string value to print it 
 void Serial_newline(void); //move to next line
 bool Serial_available(void); //check if input serial data available return 1 is yes 
 char Serial_read_char(void); //read the incoming char byte and return it 
 void Serial_print_u32(u32);
void Serial_print_string (char string[]);
bool Serial_available(void);