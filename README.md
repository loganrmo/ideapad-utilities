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
