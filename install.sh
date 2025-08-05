#!/bin/bash

set -e  # Stop on first error
set -u  # Error on undefined variables

echo "🔧 Installing RPi Power Manager 2 dependencies..."

# Make sure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (e.g., sudo $0)"
  exit 1
fi

# Variables
INSTALL_DIR="/opt/rpi_power"
SCRIPT_URL="https://raw.githubusercontent.com/cactixxx/rpi_power/main/rpi_power.sh"
CRON_LINE="@reboot /opt/rpi_power/rpi_power.sh"

# Update and install required packages
apt update
apt -y install gpiod

# Create directory for script
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Download the power script
wget -O rpi_power.sh "$SCRIPT_URL"
chmod 744 rpi_power.sh
chown root:root rpi_power.sh

# Create /etc/gpio-scripts directory
mkdir -p /etc/gpio-scripts

# Install cron job (if not already present)
CRON_TMP=$(mktemp)
crontab -l > "$CRON_TMP" 2>/dev/null || true
grep -qxF "$CRON_LINE" "$CRON_TMP" || echo "$CRON_LINE" >> "$CRON_TMP"
crontab "$CRON_TMP"
rm "$CRON_TMP"

# Done
echo
echo "✅ Installation Complete"
echo "You can now shutdown the RPi and connect it to the RPi Power Manager 2"
echo
