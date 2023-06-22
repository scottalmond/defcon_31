# Overview

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