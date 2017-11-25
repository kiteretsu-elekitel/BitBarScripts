#!/bin/bash

# <bitbar.title>Active WIFI Name</bitbar.title>
# <bitbar.author>Jiri</bitbar.author>
# <bitbar.author.github>CzechJiri</bitbar.author.github>
# <bitbar.desc>Displays currently connected WIFI Name</bitbar.desc>

#WIFINAME=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')
WIFINAME=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep " SSID" | awk -F ': ' '{print $2}')

if [ "$WIFINAME" = "" ]
then
	WIFINAME="No Connection"
fi


#googleDNSに繋がるか確認
Answer=$(ping -c 1 -t 1 8.8.8.8 | grep "1 packets received")

if [ "$Answer" = "" ]; then
	result="$WIFINAME(Can't connect DNS)"
else
	result="$WIFINAME"
fi

#結果を表示
echo "WIFI: $result"
