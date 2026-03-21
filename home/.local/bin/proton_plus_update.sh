#!/bin/bash
# Check for native install first
if command -v protonplus >/dev/null 2>&1; then
    protonplus update all
# Fallback to Flatpak detection
elif flatpak list --app | grep -iq "ProtonPlus"; then
    FP_ID=$(flatpak list --app --columns=application | grep -i "ProtonPlus")
    /usr/bin/flatpak run "$FP_ID" update all
else
    echo "Error: ProtonPlus not found."
    exit 1
fi