#!/bin/bash

# GPIO numbers
LATCH_OUT=20
OFF_BUTTON=21
SCRIPT_PATH="/etc/gpio-scripts/$OFF_BUTTON"
LOG_FILE="/var/log/rpi_power.log"

# Ensure gpiod tools are installed
if ! command -v gpioset >/dev/null 2>&1; then
  echo "Installing gpiod tools..."
  apt update && apt install -y gpiod
fi

# Create gpio-scripts directory if not exist
mkdir -p /etc/gpio-scripts

# Create OFF button handler script if not already present
if [ ! -f "$SCRIPT_PATH" ]; then
  cat <<EOF > "$SCRIPT_PATH"
#!/bin/sh
echo "Off button pressed"
date "+%F %H:%M:%S - Off button triggered" >> $LOG_FILE
/usr/sbin/init 0
EOF

  chmod +x "$SCRIPT_PATH"
  echo "$(date '+%F %H:%M:%S') - OFF button handler script created" >> "$LOG_FILE"
else
  echo "$(date '+%F %H:%M:%S') - OFF button script already exists, skipping creation" >> "$LOG_FILE"
fi

# Latch on if not already latched (gpioset --mode=exit sets and exits, so it's safe to always run)
gpioset --mode=exit gpiochip0 $LATCH_OUT=1
echo "$(date '+%F %H:%M:%S') - Latch GPIO $LATCH_OUT set HIGH" >> "$LOG_FILE"

# Start gpiomon if not already running for the same GPIO
if ! pgrep -f "gpiomon --rising-edge gpiochip0 $OFF_BUTTON" > /dev/null; then
  (
    gpiomon --rising-edge gpiochip0 $OFF_BUTTON && "$SCRIPT_PATH"
  ) &
  echo "$(date '+%F %H:%M:%S') - Started gpiomon monitor on GPIO $OFF_BUTTON" >> "$LOG_FILE"
else
  echo "$(date '+%F %H:%M:%S') - gpiomon already running for GPIO $OFF_BUTTON, skipping launch" >> "$LOG_FILE"
fi
