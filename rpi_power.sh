#!/bin/bash

OFF_BUTTON=20
LATCH_OUT=21

sudo echo "#!/bin/sh" > /etc/gpio-scripts/$OFF_BUTTON
sudo echo "echo \"Off button pressed\"" >> /etc/gpio-scripts/$OFF_BUTTON
sudo echo "date \"+%F %H:%M:%S - Off button triggered\" >> /var/log/rpi_power.log" >> /etc/gpio-scripts/$OFF_BUTTON
sudo echo "/usr/sbin/init 0" >> /etc/gpio-scripts/$OFF_BUTTON
sudo chmod 777 /etc/gpio-scripts/$OFF_BUTTON

sudo echo "$LATCH_OUT" > /sys/class/gpio/export	#output
sudo echo "out" > /sys/class/gpio/gpio$LATCH_OUT/direction
sudo echo "1" > /sys/class/gpio/gpio$LATCH_OUT/value
sudo date "+%F %H:%M:%S - On latch enabled" >> /var/log/rpi_power.log
sudo /opt/gpio-watch/gpio-watch $OFF_BUTTON:switch &
