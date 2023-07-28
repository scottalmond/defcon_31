# Space Pony Overview

This repo contains the project files for two Silly Add-On (SAO) Printed Circuit Boards (PCBs) for DEFCON 31.

TODO: User Guide Video Here

## Space Bits R Us

This is the team badge for those competing in the Hack-a-Sat competition.  These are exclusive badges for the team and not for general sale.

## Pony Circuit Board

These badges present "My Little Pony Friendship is Magic" characters surrounded by LEDs.  These badges are for sale, MSRP $20 each.  There are over 10 unique designs.  Each "Space Bits R Us" team member (identifiable because they are wearing the "Space Bits" badge described above) will have several units for sale.  Visit the Hack-a-sat competition area immediately before, or immediately after competition each day to acquire one.  Specifically: before 10 AM Friday/Saturday, after 8 PM Friday/Saturday, before Noon Sunday, or after 1:30 PM Sunday.

[![Bumper reel and general information]
(https://img.youtube.com/vi/0cRPfB8QzD0/maxresdefault.jpg)]
(https://www.youtube.com/watch?v=0cRPfB8QzD0)

# Features

- STM8S003F3P6TR Processor
	- 8 kB Flash
	- 1 kB RAM
	- 128 B EEPROM
- Microphone
- 16 MHz clock, 10 ppm
- LiPo Battery
	- 40 mAh LIR2032 LiPo (Pony SAO)
		- ~2 hours battery life at max brightness
	- 500 mAh 502540 LiPo (Space Bits R Us SAO)
		- ~25 hours battery life at max brightness
- LiPo Charger
	- ~2 hours to charge from 3V to 4.2V
- Developer header
	- 5V charging input
	- ST SWIM Interface
	- 1 MBaud UART
	- I2C
- SAO 4-pin header
	- Under BT1 (Pony SAO)
	- Under Acrylic (Space Bits R Us SAO)
- 10x RGB LEDs
- 12x White LEDs (Space Bits R Us SAO Only)
- 1x Status LED
	- Green
		- 5V input is present
		- Battery is fully charged, if present
	- Green + Blue = Cyan
		- Battery Charging is Underway
	- Red
		- A user button is pressed

# Schematic

![DefCon31 v1r2](\pcb\fab\v1r2\schematic.png)

# User Guide

- Power Modes
	- Turn ON
	- 5V
	- Charging
	- Sleep
	- OFF
	- External Power
- Terminal Access
	- Recognized commands
- Developer header pinout
- STM8 setup

# Menus

TODO

# Hardware

## Design

Concept, Project Management, PCB Design, Software Architecture: [Scott Almond](https://github.com/scottalmond)
Morse Code, Cyclone Game, Terminal Artwork: [Brian Wilkins](SpaceHamBrian@gmail.com)
Pony & space artwork: [Sugar Morning](https://twitter.com/itssugarmorning)

## Fabrication & Tools

PCB design in [EasyEDA](https://easyeda.com/); PCB/PCBA fabrication through [JLCPCB](https://jlcpcb.com/)
Acrylic stock, 45% lighting white, 1/8" thick through [TAP Plastics](https://www.tapplastics.com/)
Acrylic cutting in-house using a LC40 Dremel laser cutter
Stickers fabricated by [Sticker Mule](https://www.stickermule.com/)
Through-hole LEDs, batteries, and support hardware (protoboards, pogo pins, etc) purchased through [Aliexpress](https://www.aliexpress.us) vendors

# Eratta

How to fix git login: https://www.youtube.com/watch?v=EaN7TnD8RvM
STM8 programming ref: https://hackaday.io/project/161239-stm8s-development-board
STM8 programmer setup: https://circuitdigest.com/microcontroller-projects/getting-started-with-stm8s-using-stvd-and-cosmic-c-compiler
including Cosmic C licesne request (allow 2 business days to get a key) ref. https://github.com/NevynUK/The-Way-of-the-Register