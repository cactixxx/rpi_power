#!/bin/bash

cd /opt
sudo apt update
sudo apt -y install git
sudo git clone https://github.com/larsks/gpio-watch.git
sudo chown $(whoami) /opt/gpio-watch 
cd gpio-watch
make
sudo make install
sudo mkdir /etc/gpio-scripts

sudo mkdir /opt/rpi_power
sudo chown $(whoami) /opt/rpi_power
/usr/bin/wget https://raw.githubusercontent.com/cactixxx/rpi_power/main/rpi_power.sh
sudo chmod 744 /opt/rpi_power/rpi_power.sh
sudo chown root /opt/rpi_power/rpi_power.sh
sudo crontab -l > root
grep -qxF '@reboot /opt/rpi_power/rpi_power.sh' root || echo "@reboot /opt/rpi_power/rpi_power.sh" >> root
sudo crontab root
rm root
echo " "
echo " "
echo "Installation Complete"
echo "You can now shutdown the RPi and connect it to the RPi Power Manager 2"
echo " "
