#!/bin/bash

WIFINAME=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep " SSID" | awk -F ': ' '{print $2}')
if [[ $(echo $WIFINAME | grep "AirMac") = "" ]]; then
	exit 0
fi

stat=$(ioreg -l | grep -i ExternalConnected | awk '{print $5}')

if [[ $stat = 'Yes' ]]; then
	if [[ -d /Volumes/OrangePekoe ]]; then
		exit 0
	else
		osascript -e "try" -e "mount volume \"smb://teapot/OrangePekoe\"" -e "end try"
		echo "Mount teapot samba disk"
	fi

	if [[ -d /Volumes/BrokenPekoe ]]; then
		exit 0
	else
		osascript -e "try" -e "mount volume \"smb://teapot/BrokenPekoe\"" -e "end try"
		echo "Mount teapot samba disk"
	fi
else
	if [[ -d /Volumes/OrangePekoe ]]; then
		diskutil unmount /Volumes/OrangePekoe
		if [[ $? = '1' ]]; then
			killall iTunes
			diskutil unmount /Volumes/OrangePekoe
			echo "Unmount teapot samba disk | color=red"
		fi
	elif [[ -d /Volumes/BrokenPekoe ]]; then
		diskutil unmount /Volumes/BrokenPekoe
		if [[ $? = '1' ]]; then
			killall vlc
			diskutil unmount /Volumes/BrokenPekoe
			echo "Unmount teapot samba disk | color=red"
		fi
	else
		exit 0
	fi
fi
