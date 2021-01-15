# Ideapad Utilities

## Lenovo Vantage Utilities for Linux
This is my first venture into Bash scripting. As someone who uses Linux, I found that one of my biggest issues was the fact that my Ryzen 4000 Ideapad laptop had poor battery life and I was unable to access features included in Lenovo Vantage, which is for Windows only. This script uses the `acpi_call` kernel module to change performance modes and rapid charge modes. It should be noted that this script ONLY works for Ryzen 4000 series Ideapads and has not been tested on all models.

## Features
Adjusting performance modes - options include:
1. Intelligent Cooling
2. Extreme Performance
3. Battery Saving

Adjusting rapid charge modes - 1: on, 2: off

## Dependencies
Depending on your system, either `acpi_call`, `acpi_call-lts`, `acpi_call-dkms`. 

## Running the Script
The script requires superuser elevations. To run the script, run `sudo ./utils.sh` in the script's directory. If this does not work, ensure it is an exectuable by running `chmod +w utils.sh`. Without any flags, the program should display an error message if the kernel module is not installed and loaded. Note that the module can be loaded after install with `sudo modprobe acpi_call`.  Otherwise, it will present the current mode and a help message.

## Script Usage and Parameters
Flags: `-p` `-r` `-h`

To change performance mode, provide the `-p` flag followed by 1, 2, or 3 to change the respective performance mode. For rapid charge, provide the `-r` flag with 1 or 2, respectively. `-h` shows the help message.
