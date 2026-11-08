#!/bin/bash
# Install the omarchy layout + theme + sync hook into the Herdr app home.
set -euo pipefail

HERDR_HOME="${HERDR_HOME:-$HOME/.config/herdr-app}"
HOOK_DIR="$HOME/.config/omarchy/hooks/theme-set.d"
HERE=$(cd "$(dirname "$0")" && pwd)

mkdir -p "$HERDR_HOME/layouts" "$HERDR_HOME/themes" "$HOOK_DIR"

cp -- "$HERE/layouts/omarchy.json" "$HERDR_HOME/layouts/omarchy.json"
cp -- "$HERE/themes/omarchy.json" "$HERDR_HOME/themes/omarchy.json"
cp -- "$HERE/preview.png" "$HERDR_HOME/layouts/omarchy.png"
cp -- "$HERE/hooks/herdr-omarchy-sync" "$HOOK_DIR/herdr-omarchy-sync"
chmod 755 "$HOOK_DIR/herdr-omarchy-sync"

# Regenerate the theme from the current Omarchy palette right away.
"$HOOK_DIR/herdr-omarchy-sync" "${1:-manual}"

echo "Installed. Switch with: herdr-app do layout.switch --name omarchy"
