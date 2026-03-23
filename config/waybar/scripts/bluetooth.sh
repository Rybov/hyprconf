#!/bin/bash
set -euo pipefail

icon=""

powered=$(
  bluetoothctl show 2>/dev/null | awk -F': ' '/Powered/ {p=$2} END {print p}'
)

if [ "${powered:-no}" != "yes" ]; then
  echo "$icon Off"
  exit 0
fi

device=$(
  bluetoothctl devices Connected 2>/dev/null | awk '{d=$2} END {print d}'
)

if [ -z "${device:-}" ]; then
  echo "$icon Disconnected"
  exit 0
fi

info="$(bluetoothctl info "$device" 2>/dev/null || true)"

connected="$(printf '%s\n' "$info" | awk -F': ' '/Connected/ {print $2; exit}')"
if [ "${connected:-no}" != "yes" ]; then
  echo "$icon Disconnected"
  exit 0
fi

name="$(printf '%s\n' "$info" | awk -F': ' '/Name/ {n=$2} END {print n}')"
if [ -z "${name:-}" ]; then
  name="$device"
fi

name_short="$(
  printf '%s' "$name" | awk '{ if (length($0) > 12) { print substr($0,1,12) "..." } else { print $0 } }'
)"

battery="$(
  printf '%s\n' "$info" | awk '
    /Battery Percentage/ {
      if (match($0, /\(([0-9]+)\)/, a)) { print a[1]; exit }
      if (match($0, /\(([0-9]+)%\)/, b)) { print b[1]; exit }
      if (match($0, /([0-9]+)/, c)) { print c[1]; exit }
    }
  '
)"

if [ -n "${battery:-}" ]; then
  echo "$icon $name_short $battery%"
else
  echo "$icon $name_short"
fi
