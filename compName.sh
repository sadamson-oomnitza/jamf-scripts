#!/bin/bash

#userName="$(stat -f%Su /dev/console)"
#realName="$(dscl . -read /Users/$userName RealName | cut -d: -f2 | sed -e 's/^[ \t]*//' | grep -v "^$")"
#userName=$(/bin/ls -la /dev/console | /usr/bin/cut -d " " -f 4)
macModel=$(/usr/sbin/sysctl -n hw.model)
macChip=$(system_profiler SPHardwareDataType | grep "Chip:")

# Get the Serial Number of the Machine
sn=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')

#  Need to define the non MacBooks options
if [[ "$macModel" =~ BookAir ]]; then
    setModel='MBA'
  elif [[ "$macModel" =~ Mac14 ]]; then
  	setModel='MBA'
  elif [[ "$macModel" =~ BookPro ]]; then
    setModel='MBP'
else
    setModel='iMac'
fi

# Set chip type
if [[ "$macChip" =~ M1 ]]; then
  setChip='M1'
elif [[ "$macChip" =~ M2 ]]; then
  setChip='M2'
else
  setChip='Int'
fi

computerName="$sn-$setModel.$setChip"

# echo $computerName

# Set the ComputerName, HostName and LocalHostName
/usr/sbin/scutil --set ComputerName "$computerName"
/usr/sbin/scutil --set HostName "$computerName"
/usr/sbin/scutil --set LocalHostName "$computerName"

exit 0
