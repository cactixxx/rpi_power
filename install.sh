#!/bin/bash

cd /opt
sudo git clone https://github.com/larsks/gpio-watch.git
sudo chown $(whoami) /opt/gpio-watch 
cd gpio-watch
make
sudo make install
sudo mkdir /etc/gpio-scripts

sudo mkdir /opt/rpi_power
sudo chown $(whoami) /opt/rpi_power
/usr/bin/wget -O - https://raw.githubusercontent.com/cactixxx/rpi_power/main/rpi_power.sh > /opt/rpi_power/rpi_power.sh
sudo chmod 744 /opt/rpi_power/rpi_power.sh
sudo chown root /opt/rpi_power/rpi_power.sh
crontab -l > root
grep -qxF '@reboot /opt/rpi_power/rpi_power.sh' root || echo "@reboot /opt/rpi_power/rpi_power.sh" >> root
sudo crontab root
rm root
