#!/bin/bash

headphones="alsa_output.usb-FiiO_DigiHug_USB_Audio-01.analog-stereo"
speakers="alsa_output.pci-0000_0d_00.4.analog-stereo"

current=`pactl get-default-sink` 2> /dev/null

if [ $current == $speakers ]; then 
	pactl set-default-sink $headphones
else
	pactl set-default-sink $speakers
fi
