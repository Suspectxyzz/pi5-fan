#!/bin/bash

# Initial settings
FAN="/sys/class/hwmon/hwmon*/pwm1"
TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"
MAX_TEMP=57000  # 57 degrees Celsius
MIN_TEMP=40000  # 40 degrees Celsius
CONSTANT_SPEED=100
HIGH_SPEED=250

while true; do
    CPU_TEMP=$(cat $TEMP_FILE)
    
    if [ "$CPU_TEMP" -ge "$MAX_TEMP" ]; then
        echo $HIGH_SPEED | sudo tee $FAN > /dev/null  # Fan at high speed
    else
        echo $CONSTANT_SPEED | sudo tee $FAN > /dev/null  # Keep the speed constant
    fi
    
    sleep 0  # Temperature check interval 5, it is good but recommended 0
done
