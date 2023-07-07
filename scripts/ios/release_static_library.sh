#!/bin/bash

PLUGIN="rating"
BIN_PATH="ios/bin"

# Compile Plugin
./scripts/ios/generate_static_library.sh $PLUGIN release $1
./scripts/ios/generate_static_library.sh $PLUGIN release_debug $1
mv ./${BIN_PATH}/${PLUGIN}.release_debug.a ./${BIN_PATH}/${PLUGIN}.debug.a

# Move to release folder
rm -rf ./${BIN_PATH}/release
mkdir ./${BIN_PATH}/release
rm -rf ./${BIN_PATH}/release/${PLUGIN}
mkdir -p ./${BIN_PATH}/release/${PLUGIN}

# Move Plugin
mv ./${BIN_PATH}/${PLUGIN}.{release,debug}.a ./${BIN_PATH}/release/${PLUGIN}
cp ./plugin/${PLUGIN}/config/${PLUGIN}.gdip ./${BIN_PATH}/release/${PLUGIN}
