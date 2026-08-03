#!/usr/bin/env bash
#
# install.sh - Install sshb to /usr/local/bin
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="/usr/local/bin"
INSTALL_NAME="sshb"

echo "Installing sshb..."

# Check if running as root or with sudo
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (use sudo)" >&2
  exit 1
fi

# Check source file exists
if [[ ! -f "$SCRIPT_DIR/sshb" ]]; then
  echo "Error: sshb script not found in $SCRIPT_DIR" >&2
  exit 1
fi

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Copy and set permissions
cp "$SCRIPT_DIR/sshb" "$INSTALL_DIR/$INSTALL_NAME"
chmod 755 "$INSTALL_DIR/$INSTALL_NAME"

echo "Installed: $INSTALL_DIR/$INSTALL_NAME"
echo ""
echo "Run 'sshb' to start (dependencies auto-install on first run)"
