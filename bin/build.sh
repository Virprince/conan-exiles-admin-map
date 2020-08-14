#!/usr/bin/env bash

PACKAGE_VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",\t ]//g')

rm -rf lib build
webpack
cp -rf src/views lib/views
pkg lib/conan-exiles-admin-map.js -t latest-win-x64 --out-path build -c package.json
rm -rf lib
cd build
# mv conan-exiles-admin-map-win.exe conan-exiles-admin-map.exe
cp ../src/conan-exiles-admin-map.ini .
cp ../src/bindings/win_x64/node_sqlite3.node .
zip -r conan-exiles-admin-map-v$PACKAGE_VERSION.zip .
cd ..
