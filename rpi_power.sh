#!/bin/bash

LATCH_OUT=20
OFF_BUTTON=21

echo "#!/bin/sh" > /etc/gpio-scripts/$OFF_BUTTON
echo "echo \"Off button pressed\"" >> /etc/gpio-scripts/$OFF_BUTTON
echo "date \"+%F %H:%M:%S - Off button triggered\" >> /var/log/rpi_power.log" >> /etc/gpio-scripts/$OFF_BUTTON
echo "/usr/sbin/init 0" >> /etc/gpio-scripts/$OFF_BUTTON
chmod 777 /etc/gpio-scripts/$OFF_BUTTON

echo "$LATCH_OUT" > /sys/class/gpio/export	#output
echo "out" > /sys/class/gpio/gpio$LATCH_OUT/direction
echo "1" > /sys/class/gpio/gpio$LATCH_OUT/value
date "+%F %H:%M:%S - On latch enabled" >> /var/log/rpi_power.log
/opt/gpio-watch/gpio-watch $OFF_BUTTON:switch &
