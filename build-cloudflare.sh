#!/bin/sh
set -eu

rm -rf dist
mkdir -p dist

# Copy the legacy static site while excluding repository metadata,
# backups, the separate Doug Ross portfolio path, and macOS metadata.
tar \
  --exclude='./dist' \
  --exclude='./.git' \
  --exclude='./.wrangler' \
  --exclude='./.vscode' \
  --exclude='./.DS_Store' \
  --exclude='*/.DS_Store' \
  --exclude='./.gitattributes' \
  --exclude='./wrangler.jsonc' \
  --exclude='./build-cloudflare.sh' \
  --exclude='./.assetsignore' \
  --exclude='./mabelstreetbrewingBackup' \
  --exclude='./dougross' \
  -cf - . | tar -xf - -C dist

# Cloudflare directory indexes use index.html. Keep the original
# index.htm too so old links/bookmarks continue to work.
cp dist/index.htm dist/index.html

echo "Prepared legacy Mabel Street Brewing site under dist/"
