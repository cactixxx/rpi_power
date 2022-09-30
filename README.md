Installation Instructions:
~~~~~~~~~~~~~~~~~~~~~~~~~~
1)  Boot the Pi using the normal power supply. Do not connect the RPi Power Manager 2 before completing the follwing steps!
2)  Execute the follwing:
        wget -O - https://raw.githubusercontent.com/cactixxx/rpi_power/main/install.sh | /usr/bin/bash
3)  Shutdown the pi, by executing: init 0 or shutdown -h now
4)  Disconnect the normal power supply
5)  Connect as follows:
        RPi Manager 2   Raspberry Pi
        Pin             Pin
        5V  --------->  5V (Pin 2)
        GND --------->  Ground (Pin 6)
        LAT --------->  GPIO20 (Pin 38)
        OFF --------->  GPIO21 (Pin 40)
6)  Connect power (USB-C) to the RPi Manager 2
7)  The Orange PWR LED should light up
8)  Press the ON button.  The Green RELAY LED should light up
9)  After a few second the Blue LATCH LED should light up
10) To shutdown the Pi either execute a shutdown command from the console or GUI or press the OFF button. The Blue LATCH LED will switch off after a few seconds and the Green RELAY LED will shutdown according to the time delay selected via the soldered PADS.





