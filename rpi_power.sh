#!/bin/bash

# GPIO numbers
LATCH_OUT=20
OFF_BUTTON=21

# Ensure gpiod tools are installed
if ! command -v gpioset >/dev/null 2>&1; then
  echo "Installing gpiod tools..."
  apt update && apt install -y gpiod
fi

# Set LATCH_OUT as output and drive it high (latched on)
gpioset --mode=exit gpiochip0 $LATCH_OUT=1
date "+%F %H:%M:%S - On latch enabled" >> /var/log/rpi_power.log

# Create gpio-scripts directory if not exist
mkdir -p /etc/gpio-scripts

# Create OFF button handler script
cat <<EOF > /etc/gpio-scripts/$OFF_BUTTON
#!/bin/sh
echo "Off button pressed"
date "+%F %H:%M:%S - Off button triggered" >> /var/log/rpi_power.log
/usr/sbin/init 0
EOF

chmod +x /etc/gpio-scripts/$OFF_BUTTON

# Start monitoring OFF button for falling edge using gpiomon
# This blocks until the button is pressed
(
  gpiomon --rising-edge gpiochip0 $OFF_BUTTON && /etc/gpio-scripts/$OFF_BUTTON
) &
