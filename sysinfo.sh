#!/bin/bash

OUTPUT="sysinfo_$(hostname)_$(date +%Y-%m-%d).txt"

cat <<REPORT | tee "$OUTPUT"
=== SYSTEM INFO ===
Device:    $(cat /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null) $(cat /sys/devices/virtual/dmi/id/product_family 2>/dev/null)
Hostname:  $(hostname)
OS:        $(. /etc/os-release 2>/dev/null && echo "$PRETTY_NAME")
Kernel:    $(uname -r)

=== CPU ===
Model:     $(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | xargs)
Cores:     $(nproc --all) threads ($(grep -c "^processor" /proc/cpuinfo) logical)

=== RAM ===
Total:     $(free -h | awk '/Mem:/{print $2}')
Used:      $(free -h | awk '/Mem:/{print $3}')

=== STORAGE ===
$(lsblk -o NAME,SIZE,TYPE,MODEL | grep -E "disk|part")

=== GPU ===
$(lspci | grep -iE "vga|3d" | cut -d: -f3 | xargs)

=== BATTERY ===
Health:    $(echo "scale=1; $(cat /sys/class/power_supply/BAT*/energy_full 2>/dev/null)*100/$(cat /sys/class/power_supply/BAT*/energy_full_design 2>/dev/null)" | bc 2>/dev/null || echo "N/A")%
Cycles:    $(cat /sys/class/power_supply/BAT*/cycle_count 2>/dev/null || echo "N/A")
Charge:    $(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo "N/A")%
Status:    $(cat /sys/class/power_supply/BAT*/status 2>/dev/null || echo "N/A")
REPORT

echo ""
echo ">>> Saved to $OUTPUT"
