#!/bin/bash

# GPIO numbers
LATCH_OUT=20
OFF_BUTTON=21
LOG_FILE="/var/log/rpi_power.log"

# Ensure gpiod tools are installed
if ! command -v gpioset >/dev/null 2>&1; then
  echo "Installing gpiod tools..."
  apt update && apt install -y gpiod
fi

# Create log file directory if needed
mkdir -p "$(dirname "$LOG_FILE")"

# Latch on
gpioset --mode=exit gpiochip0 $LATCH_OUT=1
echo "$(date '+%F %H:%M:%S') - Latch GPIO $LATCH_OUT set HIGH" >> "$LOG_FILE"

# Kill any previous gpiomon for this GPIO
pkill -f "gpiomon --rising-edge gpiochip0 $OFF_BUTTON"

# Start new gpiomon listener with proper buffering
(
  stdbuf -oL gpiomon --rising-edge gpiochip0 $OFF_BUTTON \
  | grep --line-buffered "RISING" \
  | while read -r line; do
      echo "$(date '+%F %H:%M:%S') - Button press detected on GPIO $OFF_BUTTON, shutting down..." >> "$LOG_FILE"
      /sbin/shutdown -h now
    done
) &

echo "$(date '+%F %H:%M:%S') - gpiomon monitor started on GPIO $OFF_BUTTON" >> "$LOG_FILE"
