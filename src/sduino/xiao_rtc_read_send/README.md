# SAMD21 Xiao Button Interface and DS3231 RTC Task

This Arduino code is designed to work with a SAMD21 Xiao microcontroller board, a Joystick Shield button interface, and a DS3231 Real-Time Clock (RTC) module. The code is intended to perform a specific task when the user presses a button on the Joystick Shield.

## Task Description

When the user presses the button on the Joystick Shield:

1. Turn on the on-board LED of the SAMD21 Xiao to indicate the start of the task.
2. Drive a digital output pin low to signal another board to go into developer mode.
3. Read the current time from the DS3231 RTC module and convert it to milliseconds since 8/5/2023 at midnight.
4. Create a time string in the format "t <milliseconds>\n" (e.g., "t 5649548\n").
5. Transmit the time string over UART (Serial) to the other board at a baud rate of 57600.
6. Optionally, introduce a small delay (100 milliseconds) to indicate the completion of the task.
7. Disable the relay by setting the digital output pin to an input mode (float the developer mode pin).
8. Turn off the on-board LED to signify the end of the task.

## Usage

1. Connect the Joystick Shield button interface and DS3231 RTC module to the appropriate pins on the SAMD21 Xiao board as described in the "Connections" section of this README.
2. Install the required `RTCLib` library in the Arduino IDE to work with the RTC module.
3. Upload the provided Arduino code (`main.ino`) to the SAMD21 Xiao using the Arduino IDE.
4. The code will run in an infinite loop, waiting for the button press. When the button is pressed, the specified tasks will be executed sequentially.

## Connections

### Joystick Shield Button Interface:

- Connect the GND (ground) pin of the Joystick Shield to any GND pin on the SAMD21 Xiao.
- Connect the VCC pin of the Joystick Shield to any 3.3V pin on the SAMD21 Xiao.
- Connect the signal (SIG) pin of the Joystick Shield to a digital input pin on the SAMD21 Xiao, for example, pin 2.

### DS3231 RTC Module:

- Connect the GND (ground) pin of the RTC module to any GND pin on the SAMD21 Xiao.
- Connect the VCC pin of the RTC module to any 3.3V pin on the SAMD21 Xiao.
- Connect the SDA pin of the RTC module to the I2C data pin (SDA) on the SAMD21 Xiao, usually pin A4.
- Connect the SCL pin of the RTC module to the I2C clock pin (SCL) on the SAMD21 Xiao, usually pin A5.

## Notes

- Replace `<outputPin>` in the code with the actual pin number you want to use for the developer mode signal.
- Ensure that the RTC module and Joystick Shield are connected properly to avoid any issues.
- The on-board LED will briefly illuminate during task execution, indicating that the task is in progress.

---
*Note: This README assumes that you are familiar with programming and using Arduino boards. If you need additional help or clarification, refer to the official Arduino documentation and community resources.*
