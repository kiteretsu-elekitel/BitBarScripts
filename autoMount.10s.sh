#!/bin/bash

stat=$(ioreg -l | grep -i ExternalConnected | awk '{print $5}')

if [[ $stat = 'Yes' ]]; then
	if [[ -d /Volumes/OrangePekoe ]]; then
		exit 0
	else
		osascript -e "try" -e "mount volume \"smb://teapot\"" -e "end try"
	fi
else
	if [[ -d /Volumes/OrangePekoe ]]; then
		umount /Volumes/OrangePekoe
		if [[ $? = '1' ]]; then
			killall iTunes
			umount /Volumes/OrangePekoe
		fi
	else
		exit 0
	fi
fi
