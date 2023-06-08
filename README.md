# Overview

This repo contains the project files for multiple variations of Silly Add-On (SAO) Printed Circuit Boards (PCBs) for DEFCON 31.

## Space Bits R Us

This is the team badge for those competing in the Hack-a-Sat competition.

## Pony Circuit Board

Created in collaboration with Sugar Morning (artist), these badges present "My Little Pony Friendship is Magic" characters illuminated with LEDs

# Design Notes

- ~400 mA battery can fit in cavity
- 0.5C charge while sleeping = + 200 mA/day
    - day 1: 300 mA (10 hours)
    - day 2: 300 mA (10 hours)
    - day 3: 200 mA (5 hours)
- 30 mA

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

<img alt="alt_text" width="100px" src="doc\ideas_space_bits\img\DC31BADGE-CARD-OUTLINE_idea.png" />

# Eratta

How to fix git login: https://www.youtube.com/watch?v=EaN7TnD8RvM