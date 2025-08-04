# 🧰 RPi Power Manager 2 – Installation Instructions

> **⚠️ Important:** Do **NOT** connect the RPi Power Manager 2 before completing the following steps.

---

## 🔌 1. Boot Normally

Power on the Raspberry Pi using the **standard power supply**.

---

## 📥 2. Install the Power Manager Script

Open a terminal and run:

```bash
wget -O - https://raw.githubusercontent.com/cactixxx/rpi_power/main/install.sh | /usr/bin/bash
```

## ⏹️ 3. Shutdown the Raspberry Pi

Use either of the following commands:

```bash
init 0
```

or

```bash
shutdown -h now
```

---

## 🔌 4. Disconnect Power

Unplug the Pi’s regular power supply.

---

## ⚙️ 5. Connect RPi Power Manager 2 to GPIO

Wire the following pins:

| **RPi Manager 2 Pin** | **Raspberry Pi Pin** |
| --------------------- | -------------------- |
| `5V`                  | 5V (Pin 2)           |
| `GND`                 | Ground (Pin 6)       |
| `LAT`                 | GPIO20 (Pin 38)      |
| `OFF`                 | GPIO21 (Pin 40)      |

---

## 🔌 6. Connect USB-C Power to the RPi Power Manager 2

---

## 💡 7. LED Status Indicators

* 🔶 **Orange PWR LED** should light up
* 🟢 Press the **ON button** → **Green RELAY LED** should light up
* 🔵 After a few seconds, **Blue LATCH LED** should light up

---

## 📴 8. Shutting Down

To safely power off the Raspberry Pi:

* Run a shutdown command from the console or GUI:

  ```bash
  shutdown -h now
  ```

  *OR*
* Press the **OFF button**

Once shutdown:

* 🔵 **Blue LATCH LED** will turn off
* 🟢 **Green RELAY LED** will power down after a delay (set via soldered PADs)

---

✅ You're now up and running with RPi Power Manager 2!

```

Let me know if you'd like this as a downloadable `README.md` or if you'd like to embed images/wiring diagrams!
```
