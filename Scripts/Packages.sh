#!/bin/bash
set -e

if [ "${WRT_HONK:-false}" != "true" ]; then
  echo "Honk injection skipped."
  exit 0
fi

HONK_DIR="$GITHUB_WORKSPACE/wrt/package/honk"
rm -rf "$HONK_DIR"
git clone --depth=1 https://github.com/QiuSimons/luci-app-honk.git "$HONK_DIR"

test -f "$HONK_DIR/honk/Makefile"
test -f "$HONK_DIR/luci-app-honk/Makefile"
test -d "$HONK_DIR/luci-app-honk/po/zh_Hans"

echo "WRT_HONK_HASH=$(git -C "$HONK_DIR" rev-parse --short HEAD)" >> "$GITHUB_ENV"
echo "Honk source: $(git -C "$HONK_DIR" log -1 --format='%h %s')"
