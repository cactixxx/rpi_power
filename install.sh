#!/bin/bash

cd /opt
git clone https://github.com/larsks/gpio-watch.git
cd gpio-watch
make
sudo make install

sudo mkdir /opt/rpi_power
cd /opt/rpi_power
/usr/bin/wget -O - https://raw.githubusercontent.com/cactixx/rpi_power/rpi_power.sh
chmod 755 /opt/rpi_power/rpi_power.sh
crontab -l > root
grep -qxF '@reboot /opt/rpi_power/rpi_power.sh' root || echo "@reboot /opt/rpi_power/rpi_power.sh" >> root
crontab root
rm root
/opt/rpi_power/rpi_power.sh
