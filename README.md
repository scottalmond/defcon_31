95# Overview

This repo contains the project files for multiple variations of Silly Add-On (SAO) Printed Circuit Boards (PCBs) for DEFCON 31.

## Space Bits R Us

This is the team badge for those competing in the Hack-a-Sat competition.

## Pony Circuit Board

These badges present "My Little Pony Friendship is Magic" characters illuminated with LEDs

# Design Notes

- ~400 mA battery can fit in cavity
- 0.5C charge while sleeping (2 hour charge) = + 400 mA/day
    - day 1: 400 mA (10 hours)
    - day 2: 400 mA (10 hours)
    - day 3: 400 mA (5 hours)
- 40 mA continuous

- daisy-chain ~10 badges to charge and residual cal the clocks
    - 200 mA/badge * 10 bages --> 5V/2A wall wart, USB
- 9600 buad for long wire runs, EMI
- 10 ppm is 0.4 seconds error over 12 hours
    - objective is 30 FPS --> 0.03 seconds of error

- SAO 2*3 header
- USB, micro/C
- 

- team logo
- space theme
    - orbital dynamics
    - LEDs light up in sequence along orbital track
- gold ENIG for shiny orbit
- JSWT in gold ENIG
- and/or cubesat in PCB artwork (ref competition host is in orbit)
- noodle strand LED (yellow), straight lines work well, 80 mm

- Space badge, orbital silkscreen art at bottom left tip, logo (as a sticker to get blue color?), gold ENIG and JSWT honey comb.  red, green blue leds throughout (stars, respond to audio level in the room):

<img alt="alt_text" width="500px" src="doc\ideas_space_bits\img\DC31BADGE-CARD-OUTLINE_idea.png" />

- Pony badge, cannot fit CR2032 on front, will need to be on back:

<img alt="alt_text" width="500px" src="doc\ideas_space_bits\img\delete_me4.png" />

- KISS, pony badge with dime cell and same (?) LED driver as space badge; test out i2c communication early to buy down risk

- TODO: test brightness of 3 mA

- menus/games:
	- circle track from arcade
	- simon?
	- clock?
	- brightness adjust

# Eratta

How to fix git login: https://www.youtube.com/watch?v=EaN7TnD8RvM
STM8 preogramming ref: https://hackaday.io/project/161239-stm8s-development-board

# TODO
how to charge
how to use interface pads
how menu works

STM8 programmer setup https://circuitdigest.com/microcontroller-projects/getting-started-with-stm8s-using-stvd-and-cosmic-c-compiler
including Cosmic C licesne request (allow 2 business days to get a key)
ref. https://github.com/NevynUK/The-Way-of-the-Register

NOte: set ON/OFF switch to "ON" in order to program device
pulled examples for uart from https://github.com/CircuitDigest/STM8S103F3_SPL/blob/master/stm8s103%20Libraries/stm8s103_Serial.h

diagram showing whcih LED is whicih on schematic

reflow soldering the coin cell holder out myself is prone to unit damage, would strongly prefer fab house do this

observing LED 3 and 19 breifly light dimly red when white LEDs lit in order.  APpears to be a mat0-1 and mat0-5 association.  UNused eletrons get dissipated through red LED.  Maybe floor all matrix pins before flowting them...?  Did not fix issue, live with it?

interrupts: https://forum.arduino.cc/t/stm8-simple-timer-4-interrupt/693820

write-up notes: check purchase quantity, ref lipos x25 of 50

***v1r1 todo:
DONE flipped R10 silkscreen
DONE hide BT1 silk screen? ref in order for 250x pop and 50x DNI - keep as-is
DONE swap pin20 and pin 1 to get access to analog read audio (need to route)
DONE change discrete jelly bean led (need to route)
DONE add 20 pF to GND on OSC+ and OSC- (18pF, need to route)
DONE tie crystal pads 2 and 4 to ground (skip for this crystal model)
DONE change crystal
DONE red LED for 5V input (blue for charging)
add 2*2 SAO header pads
VDD cap for processor?
add resistor to drop battery voltage provided to processor?
add test pads (for which end points?)
order BTN1 filled to 250, DNI 50 qty