#!/bin/bash

# Lenovo IdeaPad Utilities - Works on most Ryzen 4000 Renoir Laptops
# Simulates features provided by Lenovo Vantage, which is only available on Windows
# github.com/loganrmo

# FUNCTIONS 

MODULE="acpi_call"
MODULE_LTS="acpi_call-lts"
MODULE_DKMS="acpi_call-dkms"

function checkModule() {
  if lsmod | grep "$MODULE" &> /dev/null ; then
    echo "$MODULE is loaded"
  elif lsmod | grep "$MODULE_LTS" &> /dev/null ; then
    echo "$MODULE_LTS is loaded"
  elif lsmod | grep "$MODULE_DKMS" &> /dev/null ; then
      echo "$MODULE_DKMS is loaded"
  else 
    echo "WARNING:"
    echo "Neither $MODULE, $MODULE_LTS, or $MODULE_DKMS are loaded."
    echo "Please ensure the appropriate kernel module is installed and loaded."
    exit 1;
  fi
}

function printHelp() {
  echo "LENOVO IDEAPAD UTILITIES"
  echo "Access Lenovo Vantage features from Linux with this CLI tool."
  echo "Please ensure the acpi_call kernel module is installed and loaded."
  echo ""
  echo "Options:"
  echo "To change performance mode, use the -p flag followed by one of these options:"
  echo "Intelligent Cooling: 1"
  echo "Extreme Performance: 2"
  echo "Battery Saving: 3" 
  echo ""
  echo "To change rapid charge mode, use the -r flag followed by one of these options:"
  echo "Rapid Charge On: 1"
  echo "Rapid Charge Off: 2"
  exit 1;
}

function getCPU() {
  echo $(lscpu | awk -F ": *" '/Model name/{print $NF}')
}

function performanceMode() {
  if [ $1 == "1" ]
  then
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | tee /proc/acpi/call
  elif [ $1 == "2" ]
  then
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' | tee /proc/acpi/call
  elif [ $1 == "3" ]
  then
    echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | tee /proc/acpi/call
  else
    echo "Error: Performance mode parameter incorrect"
  fi
  checkPerfMode
}

function checkPerfMode() {
  echo '\_SB.PCI0.LPC0.EC0.FCMO' | tee /proc/acpi/call
  cat /proc/acpi/call | cut -d '' -f1
}

function rapidChargeMode() {
  if [ $1 == "1" ]
  then
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' | tee /proc/acpi/call
  elif [ $1 == "2" ]
  then
    echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' | tee /proc/acpi/call
  else
    echo "Error: Rapid Charge mode parameter incorrect"
  fi
  checkRapidChargeMode
}

function checkRapidChargeMode() {
  echo '\_SB.PCI0.LPC0.EC0.QCHO' | tee /proc/acpi/call
  cat /proc/acpi/call | cut -d '' -f1
}

# MAIN

while getopts p:r FLAG
do
  case "$FLAG" in
    p) PERFOPTION=${OPTARG};;
    r) RAPOPTION=${OPTARG};;
    \?) help; exit 1;;
  esac
done

checkModule

echo "$PERFOPTION" > performanceMode
echo "$RAPOPTION" > rapidChargeMode
