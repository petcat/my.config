#!/bin/bash

# Set architecture and binary name
ARCH="x86_64-unknown-linux-gnu"
BIN_NAME="ssserver"
INSTALL_PATH="/usr/local/bin/$BIN_NAME"

# Get latest version from GitHub
echo "🔍 Checking for latest version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/^v//')

# Get current installed version
if command -v "$BIN_NAME" >/dev/null 2>&1; then
  CURRENT_VERSION=$("$BIN_NAME" -V | awk '{print $2}' | sed 's/^v//')
else
  CURRENT_VERSION="none"
fi

echo "🔎 Installed version: $CURRENT_VERSION"
echo "🆕 Latest version: $LATEST_VERSION"

# Compare versions
if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo "✅ Already up to date. No upgrade needed."
  exit 0
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Download and extract latest binary
echo "⬇️ Downloading shadowsocks-rust v$LATEST_VERSION..."
curl -LO "https://github.com/shadowsocks/shadowsocks-rust/releases/download/v$LATEST_VERSION/shadowsocks-v$LATEST_VERSION.$ARCH.tar.xz"
tar -xf "shadowsocks-v$LATEST_VERSION.$ARCH.tar.xz"

# Stop systemd service (if exists)
echo "🛑 Stopping ssserver service..."
systemctl stop ssserver 2>/dev/null

# Replace binary
echo "🔄 Updating ssserver binary..."
mv "$BIN_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

# Start service
echo "🚀 Starting ssserver service..."
systemctl start ssserver 2>/dev/null

# Show updated version
echo "✅ Upgrade complete. Current version:"
"$INSTALL_PATH" -V

# Clean up
rm -rf "$TMP_DIR"
